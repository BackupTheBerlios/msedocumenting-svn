{*********************************************************}
{                                                         }
{                 Repaz Preview Components                }
{             Classes for preview Repaz Metadata          }
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
{ The source code of the Repaz libraries and packages are }
{ distributed under the Library GNU General Public        }
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

unit repazpreview;
{$ifdef FPC}{$mode objfpc}{$h+}{$interfaces corba}{$endif}

interface
uses
 classes,msegui,mseevent,msegraphutils,msegraphics,mseclasses,msemenus,typinfo,
 msestrings,msewidgets,mseglob,mseact,msegrids,msesimplewidgets,
 msedataedits,mselistbrowser,msedatanodes,mselist,msetypes,repazglob,
 mseedit,mseforms,msedatalist,msedropdownlist,mseeditglob;

type
 
 tpreview = class(tpaintbox)
  private
   fonpagereposition: notifyeventty;
   fonfileopened: notifyeventty;
   fpagecount: integer;
   fmetapages: tmetapages;
   factivepage: integer;
   findhistory: msestringarty;
   tmpstring: tstringedit;
   fppmm: real;
   zoomscale: real;
   origwidth: integer;
   origheight: integer;
   procedure setmetapages(const avalue : tmetapages);
   procedure setactivepage(const avalue: integer);
  protected
   procedure dokeyup(var info: keyeventinfoty); override;
   procedure doonpaint(const acanvas: tcanvas); override;
   procedure doafterpaint(const canvas: tcanvas); override;
   procedure showpage(apage: integer);
   function dofindtext(const apage: integer;
    const ainfo: findtextinfoty; var neverfound: boolean): boolean;
  public
   constructor create(aowner: tcomponent); override;
   destructor destroy; override;
   procedure savetofile(afilename: filenamety);
   procedure loadfromfile(const afilename: filenamety);
   procedure findtext;
   procedure zoom(const ascale: real); 
   property metapages: tmetapages read fmetapages write setmetapages;
  published
   property onpagereposition: notifyeventty read fonpagereposition write fonpagereposition;
   property onfileopened: notifyeventty read fonfileopened write fonfileopened;
   property pagecount: integer read fpagecount;
   property activepage: integer read factivepage write setactivepage;
   property optionswidget default defaultgroupboxoptionswidget;
 end;
 
implementation
uses
 msekeyboard,mseguiglob,msebits,sysutils,
 msedatamodules,
 mseactions,msestream,msesys,
 mseformatstr,msearrayprops,msebitmap,
 msefiledialog,msereal,msehash,math,findtextdialogform;

{ tpreview }
  
constructor tpreview.create(aowner: tcomponent);
begin
 inherited;
 createframe;
 if not (csdesigning in componentstate) then begin
  tmpstring:= tstringedit.create(self);
  tmpstring.visible:=false;
  tmpstring.readonly:= true;
  tmpstring.optionswidget:= [ow_mousefocus,ow_tabfocus,ow_parenttabfocus,
  ow_arrowfocus,ow_arrowfocusin,ow_arrowfocusout];
  insertwidget(tmpstring,makepoint(0,0));
 end;
 findhistory:= nil;
 frame.colorclient:=cl_white;
 frame.framewidth:=0;
 frame.colorframe:=cl_black;
 fmetapages:= nil;
 zoomscale:= 1.0;
end;

destructor tpreview.destroy;
var
 int1: integer;
begin
 if not (csdesigning in componentstate) then begin
  tmpstring.free;
 end;
 fmetapages:= nil;
 inherited;
end;

procedure tpreview.savetofile(afilename: filenamety);
begin
 //
end;

procedure tpreview.loadfromfile(const afilename: filenamety);
begin
 //
end;

procedure tpreview.showpage(apage: integer);
begin
 factivepage:= apage;
 invalidate;
end;

function tpreview.dofindtext(const apage: integer;
 const ainfo: findtextinfoty; var neverfound: boolean): boolean;
var
 int1: integer;
 found: boolean;
 fstart: integer; 
 tmprect: rectty;
begin
 result:= true;
 if length(fmetapages[apage].textobjects)>0 then begin
  for int1:=0 to length(fmetapages[apage].textobjects)-1 do begin
   with fmetapages[apage].textobjects[int1] do begin
    fstart:=1;
    while fstart>0 do begin
     found:= false;
     fstart:= msestringsearch(ainfo.text,text.text,fstart,ainfo.options);
     if fstart>0 then begin
      found:= true;
      neverfound:= false;
      if factivepage<>apage then begin
       setactivepage(apage);              
      end;
      //draw rect
      tmpstring.color:= cl_white;
      if zoomscale=1.0 then begin
       tmpstring.widgetrect:=dest;
       tmpstring.font:= twidgetfont(font);
      end else begin
       tmprect.x:= round(dest.x * zoomscale);
       tmprect.y:= round(dest.y * zoomscale);
       tmprect.cx:= round(dest.cx * zoomscale);
       tmprect.cy:= round(dest.cy * zoomscale);
       tmpstring.widgetrect:= tmprect;
       tmpstring.font.color:= font.color;
       tmpstring.font.colorbackground:= font.colorbackground;
       tmpstring.font.colorshadow:= font.colorshadow;
       tmpstring.font.height:= round(font.height*zoomscale);
       tmpstring.font.width:= font.width;
       tmpstring.font.extraspace:= font.extraspace;
       tmpstring.font.style:= font.style;
       tmpstring.font.name:= font.name;
       tmpstring.font.charset:= font.charset;
       tmpstring.font.options:= font.options;
       tmpstring.font.xscale:= font.xscale;
      end;      
      tmpstring.visible:= true;
      tmpstring.value:= text.text;
      //drawselection
      tmpstring.setfocus;
      tmpstring.editor.selstart:= fstart-1;
      tmpstring.editor.sellength:= length(ainfo.text);
      tmpstring.editor.curindex:= fstart+length(ainfo.text)-1;
      tmpstring.activate;
      if not askyesno('Find again?') then begin
       result:= false;
       exit;  
      end else begin
       inc(fstart,length(ainfo.text));
       if fstart>=length(text.text) then begin
        fstart:=0;
       end;
      end;
     end;
    end;
   end;
  end;
  if (found=false) and (apage=fpagecount-1) then begin
   if neverfound=true then begin
    showmessage('Text not found!');
    tmpstring.visible:= false;
   end else begin
    showmessage('Text not found again!');
   end;
   result:= true;
  end;
 end else begin
  showmessage('Text not found!');
  tmpstring.visible:= false;
  result:= true;
 end;
end;

procedure tpreview.findtext;
var
 info: findtextinfoty;
 int1: integer;
 neverfound: boolean;
begin
 neverfound:= true;
 info.options:=[so_caseinsensitive];
 info.allpage:= true;
 info.history:= findhistory;
 if findtextdialogexecute(info) then begin
  findhistory:= info.history;
  with info do begin
   if text<>'' then begin
    if allpage then begin
     for int1:=0 to fpagecount-1 do begin
      if not dofindtext(int1,info,neverfound) then break;
     end;
    end else begin
     dofindtext(factivepage,info,neverfound);
    end;
   end;
  end;
 end;
end;

procedure tpreview.zoom(const ascale: real);
begin
 zoomscale:= ascale;
 width:= round(origwidth*zoomscale);
 height:= round(origheight*zoomscale);
 tmpstring.visible:= false;
 invalidate;
end;

procedure tpreview.doonpaint(const acanvas: tcanvas);
begin
 inherited;
 printmetapages(acanvas,fmetapages,factivepage,zoomscale);
end;

procedure tpreview.doafterpaint(const canvas: tcanvas);
begin
 inherited;
end;

procedure tpreview.dokeyup(var info: keyeventinfoty); 

begin
 inherited;
 {with info do begin
  if shiftstate * keyshiftstatesmask = [] then begin
   case key of
    key_down: begin
    //
    end;
    key_up: begin
    //
    end;
    end;
   end;
  end
 end;}
end;

procedure tpreview.setmetapages(const avalue : tmetapages);
begin
 fmetapages:= avalue;
 fpagecount:= length(avalue);
 origwidth:= width;
 origheight:= height;
 if canevent(tmethod(fonfileopened)) then begin
  fonfileopened(self);
 end;
 if fpagecount>0 then begin
  showpage(0);
 end;
end;

procedure tpreview.setactivepage(const avalue: integer);
begin
 if avalue<>factivepage then begin
  factivepage:= avalue;
  tmpstring.visible:= false;
  showpage(avalue);
  if canevent(tmethod(fonpagereposition)) then begin
   fonpagereposition(self);
  end;
 end;
end;

end.
