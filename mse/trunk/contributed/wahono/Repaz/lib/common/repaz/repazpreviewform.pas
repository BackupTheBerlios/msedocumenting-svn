{*********************************************************}
{                                                         }
{                 Repaz Preview Form                      }
{             Form for show Repaz metadata                }
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

unit repazpreviewform;
{$ifdef FPC}{$mode objfpc}{$h+}{$endif}
interface
uses
 mseglob,mseguiglob,mseapplication,msestat,msemenus,msegui,msegraphics,
 msegraphutils,mseevent,mseclasses,mseforms,msesimplewidgets,msewidgets,
 repazpreview,mseact,msetoolbar,msestatfile,msedataedits,mseedit,msestrings,
 msetypes,msereal,sysutils,mseimage,msebitmap;
type
 trepazpreviewfo = class(tmseform)
   tscrollbox1: tscrollbox;
   tpreview1: tpreview;
   tstatfile1: tstatfile;
   tmainmenu1: tmainmenu;
   timagelist1: timagelist;
   tgroupbox1: tgroupbox;
   btnfirst: tbutton;
   cpage: tintegeredit;
   btnprior: tbutton;
   btnnext: tbutton;
   btnlast: tbutton;
   cbzoom: tdropdownlistedit;
   btnsave: tbutton;
   btnprint: tbutton;
   btnpdf: tbutton;
   btnps: tbutton;
   btnfind: tbutton;
   procedure cpage_ondataentered(const sender: TObject);
   procedure tpreview1_onfileopened(const sender: TObject);
   procedure btnzoom_onexecute(const sender: TObject);
   procedure btnfirst_onexecute(const sender: TObject);
   procedure btnprior_onexecute(const sender: TObject);
   procedure btnnext_onexecute(const sender: TObject);
   procedure btnlast_onexecute(const sender: TObject);
   procedure mnuexitexec(const sender: TObject);
   procedure mnugotoexecute(const sender: TObject);
   procedure zoomexecute(const avalue: integer);
   procedure mnuzoomexec(const sender: TObject);
   procedure mnuhelpexec(const sender: TObject);
   procedure mnuaboutexec(const sender: TObject);
   procedure btnfind_onexecute(const sender: TObject);
   procedure tpreview1_onpagereposition(const sender: TObject);
 end;
var
 repazpreviewfo: trepazpreviewfo;
implementation
uses
 repazpreviewform_mfm,math,mseintegerenter;
procedure trepazpreviewfo.cpage_ondataentered(const sender: TObject);
begin
 if cpage.value>0 then begin
  tpreview1.activepage:=cpage.value-1;
  btnzoom_onexecute(cbzoom);
 end;
end;

procedure trepazpreviewfo.tpreview1_onfileopened(const sender: TObject);
begin
 cpage.max:= tpreview1.pagecount;
 if tpreview1.pagecount>=1 then cpage.value:=1;
end;

procedure trepazpreviewfo.btnzoom_onexecute(const sender: TObject);
begin
 zoomexecute(cbzoom.dropdown.itemindex);
end;

procedure trepazpreviewfo.zoomexecute(const avalue: integer);
begin
 if avalue=0 then begin
  tpreview1.zoom(0.5);
 end else if avalue=1 then begin
  tpreview1.zoom(0.75);
 end else if avalue=2 then begin
  tpreview1.zoom(1.0);
 end else if avalue=3 then begin
  tpreview1.zoom(1.25);
 end else if avalue=4 then begin
  tpreview1.zoom(1.5);
 end else if avalue=5 then begin
  tpreview1.zoom(1.75);
 end else if avalue=6 then begin
  tpreview1.zoom(2.0);
 end;
end;
procedure trepazpreviewfo.btnfirst_onexecute(const sender: TObject);
begin
 cpage.value:= cpage.min;
end;

procedure trepazpreviewfo.btnprior_onexecute(const sender: TObject);
begin
 if (cpage.value-1)>=cpage.min then begin
  cpage.value:= cpage.value-1;
 end;
end;

procedure trepazpreviewfo.btnnext_onexecute(const sender: TObject);
begin
 if (cpage.value+1)<cpage.max then begin
  cpage.value:= cpage.value+1;
 end;
end;

procedure trepazpreviewfo.btnlast_onexecute(const sender: TObject);
begin
 cpage.value:= cpage.max;
end;

procedure trepazpreviewfo.mnuexitexec(const sender: TObject);
begin
 window.close;
end;

procedure trepazpreviewfo.mnugotoexecute(const sender: TObject);
var
 avalue: integer;
begin
 avalue:=1;
 if integerenter(avalue,cpage.min,cpage.max,'Goto page : ','Goto Page')=mr_ok then begin
  if avalue>0 then begin
   cpage.value:= avalue;
  end;
 end;
end;

procedure trepazpreviewfo.mnuzoomexec(const sender: TObject);
begin
 zoomexecute((sender as tmenuitem).tag);
end;

procedure trepazpreviewfo.mnuhelpexec(const sender: TObject);
begin
 showmessage('Help not yet created!');
end;

procedure trepazpreviewfo.mnuaboutexec(const sender: TObject);
begin
 showmessage('Repaz!');
end;

procedure trepazpreviewfo.btnfind_onexecute(const sender: TObject);
begin
 tpreview1.findtext;
end;

procedure trepazpreviewfo.tpreview1_onpagereposition(const sender: TObject);
begin
 cpage.value:= tpreview1.activepage+1;
end;

end.
