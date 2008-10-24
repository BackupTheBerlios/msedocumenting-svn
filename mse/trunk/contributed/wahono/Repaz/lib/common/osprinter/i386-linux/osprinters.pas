{*********************************************************}
{                                                         }
{                 OSPrinter Components                    }
{     Inherited classes from PSPrinter for Linux          }
{                                                         }
{*********************************************************}
{            Copyright (c) 2008 Sri Wahono                }
{*********************************************************}
{                                                         }
{ License Agreement:                                      }
{                                                         }
{ This library is distributed in the hope that it will be }
{ useful, but WITHOUT ANY WARRANTY; without even the      }
{ implied warranty of MERCHANTABILITY or FITNESS FOR      }
{ A PARTICULAR PURPOSE.  See the GNU Lesser General       }
{ Public License for more details.                        }
{                                                         }
{ The source code of the OSPrinter libraries and packages }
{ are distributed under the Library GNU General Public    }
{ License with the following  modification:               }
{ As a special exception, the copyright holders of this   }
{ library give you permission to link this library with   }
{ independent modules to produce an executable,           }
{ regardless of the license terms of these independent    }
{ modules, and to copy and distribute the resulting       }
{ executable under terms of your choice, provided that    }
{ you also meet, for each linked independent module,      }
{ the terms and conditions of the license of that module. }
{ An independent module is a module which is not derived  }
{ from or based on this library.                          }
{                                                         }
{ If you modify this library, and your modification is    }
{ added some usefull values for other Repaz user, please  }
{ send your modification to :                             }
{                                                         }
{               wahono@aztechsoft-int.com                 }
{                                                         }
{ I will evaluate it and if your modification is really   }
{ usefull and compatible with other library, I will       }
{ publish your modification.                              }
{                                                         }
{*********************************************************}

unit osprinters;

{$ifdef FPC}{$mode objfpc}{$goto on}{$h+}{$endif}

interface

uses
 mseclasses,classes,msetypes,psprinter,osprinter,cupsapi,osprinterstype,msewidgets,
 msestream,msesys,msestrings;

type

 tosprinter = class(tpsprinter)
  private
   //cups
   fcupsoptions: pcups_option_t;
   fcupsprinters: pcups_dest_t;    //printers available
   fcupsppd: pppd_file_t;
   fcupshttp: phttp_t;         //server connection
   fcupsnumopts: integer;
   libstatus: boolean;
   fdefprinter: string;
   frawstream: ttextstream;

   procedure docupsconnect;
   function getcupsrequest(aname: pcups_dest_t) : pipp_t;
   function getattributestring(aprinter: pcups_dest_t; aname: pchar; const defaultvalue : string): string;
  function printfile(afilename: string): longint;
   function getprinterpapers(aprintername: string): stdpagearty; override;
   function getprinters: printerarty; override;
   function getdefaultprinter: string; override;
  public
   constructor create(aowner: tcomponent); override;
   destructor destroy; override;
   procedure senddata(const text: msestring);
   procedure beginprint; override;
   procedure endprint; override;
 end;

implementation
uses
 sysutils;
{ tosprinter }

constructor tosprinter.create(aowner: tcomponent);
begin
 inherited;
 fpsfilename:= 'tmpmseguiprint.ps';
 fcupsprinters:=nil;
 fcupshttp    :=nil;
 fcupsppd     :=nil;
 fcupsoptions :=nil;
 fcupsnumopts :=0;
 libstatus:= cupslibinstalled;
end;

destructor tosprinter.destroy;
begin
 inherited;
 fcupsprinters:=nil;
 fcupshttp    :=nil;
 fcupsppd     :=nil;
 fcupsoptions :=nil;
 FinalizeCups;
end;

procedure tosprinter.beginprint;
begin
 inherited;
 if rawmode then begin
  frawstream:= nil;
  frawstream:= ttextstream.create('tmpmseguiprint.raw',fm_create);
 end;
end;

procedure tosprinter.senddata(const text: msestring);
begin
 frawstream.write(text);
end;

procedure tosprinter.endprint;
begin
 inherited;
 if rawmode then begin
  if raw_draweraction=cdaOpenBefore then begin
   senddata(esclist[esc_open_drawer]);
  end;
 end;
 if rawmode then begin
  printfile('tmpmseguiprint.raw');
 end else begin
  printfile(fpsfilename);
 end;
 if rawmode then begin
  if raw_draweraction=cdaOpenAfter then begin
   senddata(esclist[esc_open_drawer]);
  end;
  if raw_cutpaperonfinish then begin
   senddata(esclist[esc_cut_paper]);
  end;
 end;
 //temporary file not removed
end;

function tosprinter.printfile(afilename: string): longint;
var
 aprintername : string;
begin
 result:=-1;
 if not libstatus then exit;
 afilename:=expandfilename(afilename);
 if length(printers)>0 then begin
  aprintername:= printername;
  result:= cupsprintfile(pchar(aprintername),pchar(afilename),
   pchar(self.title),fcupsnumopts,fcupsoptions);
 end;
end;

procedure tosprinter.docupsconnect;
begin
 if not assigned(fcupshttp) then begin
  if not libstatus then exit;
  fcupshttp:=httpconnect(cupsserver(),ippport());
  if not assigned(fcupshttp) then
   showmessage('Unable to contact server!');
 end;
end;

function tosprinter.getcupsrequest(aname: pcups_dest_t) : pipp_t;
var
 request   : pipp_t;
 language  : pcups_lang_t;
 uri       : array[0..http_max_uri] of char;
begin
 result:=nil;
 if not libstatus then exit;
 if aname=nil then exit;
 if assigned(aname) then begin
  docupsconnect;
  request:=ippnew();
  request^.request.op.operation_id := ipp_get_printer_attributes;
  request^.request.op.request_id   := 1;
  language:=cupslangdefault;

  ippaddstring(request, ipp_tag_operation, ipp_tag_charset,
           'attributes-charset', '', cupslangencoding(language));

  ippaddstring(request, ipp_tag_operation, ipp_tag_language,
           'attributes-natural-language', '', language^.language);

  uri:=format('ipp://localhost/printers/%s',[aname^.name]);
  ippaddstring(request,ipp_tag_operation,ipp_tag_uri,'printer-uri','',uri);

  result:=cupsdorequest(fcupshttp, request, '/');
  if assigned(result) then begin
   if (result^.request.status.status_code>ipp_ok_conflict) then begin
    ippdelete(result);
    result:=nil;
   end;
  end;
 end else begin
  showmessage(format('"%s" is not a valid printer.',[aname]));
 end;
end;

function tosprinter.getattributestring(aprinter: pcups_dest_t; aname: pchar;
  const defaultvalue : string): string;
var
 reponse: pipp_t;
 attribute: pipp_attribute_t;
begin
 result:=defaultvalue;
 if not libstatus then exit;
 reponse:=getcupsrequest(aprinter);
 if assigned(reponse) then begin
  try
   attribute:=ippfindattribute(reponse,aname, ipp_tag_zero);
   if assigned(attribute) then begin
    result:=attribute^.values[0]._string.text;
   end else begin
    showmessage('Failed to get attribute aname="' + aname + '"');
   end;
  finally
   ippdelete(reponse);
  end;
 end;
end;

function tosprinter.getdefaultprinter: string;
begin
 if not libstatus then exit;
 result:= fdefprinter;
end;

function tosprinter.getprinters: printerarty;
var
 i,num: integer;
 p : pcups_dest_t;
begin
 result:= nil;
 if not libstatus then exit;

 num:=cupsgetdests(@fcupsprinters);
 setlength(result,num);
 for i:=0 to num-1 do begin
  p:=nil;
  p:=@fcupsprinters[i];
  if assigned(p) then begin
   result[i].printername:=p^.name;
   result[i].location:= GetAttributeString(p,'printer-location','');
   result[i].description:= GetAttributeString(p,'printer-info','');
   result[i].servername:= cupsServer()+':'+IntToStr(ippPort());  
   if p^.is_default<>0 then begin
    fdefprinter:= p^.name;
    result[i].isdefault:= true;
   end else begin
    result[i].isdefault:= false;
   end;
  end;
 end;
end;

function tosprinter.getprinterpapers(aprintername: string): stdpagearty;
var 
 int1      : integer;
 reponse   : pipp_t;
 attribute : pipp_attribute_t;
 i         : integer;
 p         : pcups_dest_t;
 ppr       : pppd_size_t;
 fn        : string;
 supportedpapers: integer;
begin
 result:=nil;
 int1:= printerindex;
 
 if assigned(fcupsppd) then begin
  ppdclose(fcupsppd);
 end;
 fcupsppd:=nil;
 fn:=cupsgetppd(pchar(aprintername));
 fcupsppd:=ppdopenfile(pchar(fn));

 p:=nil;
 p:=@fcupsprinters[int1];
 reponse:=getcupsrequest(p);
 if not assigned(reponse) then begin
  showmessage('Get enum attribute string no reponse');
 end else begin
  try
   attribute:=ippfindattribute(reponse, 'media-supported', ipp_tag_zero);
   if assigned(attribute) then begin
    setlength(result,attribute^.num_values+1);
    supportedpapers:= attribute^.num_values;
    for i:=0 to supportedpapers-1 do begin
     if attribute^.value_tag=ipp_tag_integer then
      result[i].name:= inttostr(pipp_value_t(@attribute^.values)[i].ainteger)
     else
      result[i].name:= pipp_value_t(@attribute^.values)[i]._string.text;
     ppr:= nil;
     ppr:= ppdpagesize(fcupsppd,pchar(result[i].name));
     if assigned(ppr) then begin
      result[i].width := (ppr^.width/72)*25.4;
      result[i].height := (ppr^.length/72)*25.4;
      result[i].paperindex := i;
     end else begin
      result[i].width := 210;
      result[i].height := 297;
      result[i].paperindex := i;
     end;    
    end;
    result[supportedpapers].name:='Custom Paper';
    result[supportedpapers].width:=0;
    result[supportedpapers].height:=0;
    result[supportedpapers].paperindex:=supportedpapers;
   end else begin
    showmessage('Attribute not found!');
   end;
  finally
   ippdelete(reponse);
  end;
 end;
end;

end.
