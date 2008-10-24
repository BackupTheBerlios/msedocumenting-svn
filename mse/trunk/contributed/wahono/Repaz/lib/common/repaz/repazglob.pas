{*********************************************************}
{                                                         }
{            Repaz Variable Types and Utilities           }
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

unit repazglob;
{$ifdef FPC}{$mode objfpc}{$h+}{$endif}
interface
uses
 classes,msetypes,msegui,msedrawtext,msegraphutils,msegraphics,
 mserichstring,msestrings,msewidgets,sysutils;
type

 rawfontty = (rfNormal,rfCourier,rfRoman,rfCondensed,rfExpanded,rfDoubleHeight{,rfDoubleWidth}); 

 colprintercodety = record
  pos: integer;
  codetext: string;
 end;

 printercodety = record
  row: integer;
  col: array of colprintercodety;
 end;
 printercodearty= array of printercodety;
 
 replineinfoty = record
  widthmm: real;
  color: colorty;
  colorgap: colorty;
  capstyle: capstylety;
  dashes: string;
  startpoint: pointty;
  endpoint: pointty;
 end;

 reprectinfoty = record
  rectarea: rectty;
  color: colorty;
 end;

 reptextinfoty = record
  text: richstringty;
  dest,clip: rectty;
  flags: textflagsty;
  font: tfont;
  tabulators: tcustomtabulators;
  res: rectty;
  rawfont: rawfontty;
 end;

 tmetapage = record
  textobjects: array of reptextinfoty;
  lineobjects: array of replineinfoty;
  rectobjects: array of reprectinfoty;
 end;
 tmetapages = array of tmetapage;

 findtextinfoty = record
  text: msestring;
  options: searchoptionsty;
  allpage: boolean;
  history: msestringarty;
 end;

 pagesizety = (Letter,Folio,Ledger,Legal,Tabloid,A0,
 A1,A2,A3,A4,A5,A6,A7,A8,A9,B0,B1,B2,B3,B4,B5,B6,B7,B8,B9,B10,
 C5E,Comm10E,DLE,Executive,Custom);

 pagety = record
  name: string;
  width,height: real //mm
 end;
 
const
 pagesizes: array[pagesizety] of pagety = (
  (name: 'Letter';    width:   216; height:  279),
  (name: 'Folio';     width:   210; height:  330),
  (name: 'Ledger';    width:   432; height:  279),
  (name: 'Legal';     width:   216; height:  356),
  (name: 'Tabloid';   width:   279; height:  432),
  (name: 'A0';        width:   841; height: 1189),
  (name: 'A1';        width:   594; height:  841),
  (name: 'A2';        width:   420; height:  594),
  (name: 'A3';        width:   297; height:  420),
  (name: 'A4';        width:   210; height:  297),
  (name: 'A5';        width:   148; height:  210),
  (name: 'A6';        width:   105; height:  148),
  (name: 'A7';        width:    74; height:  105),
  (name: 'A8';        width:    52; height:   74),
  (name: 'A9';        width:    37; height:   52),
  (name: 'B0';        width:  1030; height: 1456),
  (name: 'B1';        width:   728; height: 1030),
  (name: 'B2';        width:   515; height:  728),
  (name: 'B3';        width:   364; height:  515),
  (name: 'B4';        width:   257; height:  364),
  (name: 'B5';        width:   182; height:  257),
  (name: 'B6';        width:   128; height:  182),
  (name: 'B7';        width:    91; height:  128),
  (name: 'B8';        width:    64; height:   91),
  (name: 'B9';        width:    45; height:   64),
  (name: 'B10';       width:    32; height:   45),
  (name: 'C5E';       width:   163; height:  229),
  (name: 'Comm10E';   width:   105; height:  241),
  (name: 'DLE';       width:   110; height:  220),
  (name: 'Executive'; width:   191; height:  254),
  (name: 'Custom';      width:     0; height:    0)
  );

 procedure printmetapages(const acanvas: tcanvas; const ametapages: tmetapages;
  const apage: integer; const ascale: real=1.0);

 function createrectinfo(const arect: rectty; acolor: colorty):reprectinfoty;
 function createlineinfo(const acanvas: tcanvas; const astart,aend:pointty; const acolor: colorty) : replineinfoty;
 function createtextinfo(const ainfo: drawtextinfoty; arawfont: rawfontty; const apos: pointty): reptextinfoty;
 
implementation

procedure printmetapages(const acanvas: tcanvas; const ametapages: tmetapages;
 const apage: integer; const ascale: real=1.0);
var
 tmpinfo: drawtextinfoty;
 int1: integer;
 tmprect: rectty;
 tmpstart,tmpend: pointty;
 tmpwidthmm: real;
 tmpfont: tfont;
begin
 if length(ametapages)>0 then begin
  if length(ametapages[apage].rectobjects)>0 then begin
   for int1:=0 to length(ametapages[apage].rectobjects)-1 do begin
    with ametapages[apage].rectobjects[int1] do begin
     tmprect:= rectarea;
     if ascale<>1.0 then begin
      with tmprect do begin
       x:= round(x*ascale);
       y:= round(y*ascale);
       cx:= round(cx*ascale);
       cy:= round(cy*ascale);
      end;  
     end;
     acanvas.fillrect(tmprect,color);
    end;
   end;
  end;
  if length(ametapages[apage].textobjects)>0 then begin
   for int1:=0 to length(ametapages[apage].textobjects)-1 do begin
    with ametapages[apage].textobjects[int1] do begin
     tmpinfo.text:= text;
     tmpinfo.dest:= dest;
     tmpinfo.clip:= clip;
     tmpinfo.flags:= flags;
     tmpfont:= tfont.create;
     with ametapages[apage].textobjects[int1].font do begin
      tmpfont.color:= color;
      tmpfont.colorbackground:= colorbackground;
      tmpfont.colorshadow:= colorshadow;
      tmpfont.height:= height;
      tmpfont.width:= width;
      tmpfont.extraspace:= extraspace;
      tmpfont.style:= style;
      tmpfont.name:= name;
      tmpfont.charset:= charset;
      tmpfont.options:= options;
      tmpfont.xscale:= xscale;
     end;     
     tmpinfo.font:= tmpfont;
     tmpinfo.tabulators:= tabulators;
     tmpinfo.res:= res;
     if ascale<>1.0 then begin
      with tmpinfo.dest do begin
       x:= round(x*ascale);
       y:= round(y*ascale);
       cx:= round(cx*ascale);
       cy:= round(cy*ascale);
      end;  
      with tmpinfo.clip do begin
       x:= round(x*ascale);
       y:= round(y*ascale);
       cx:= round(cx*ascale);
       cy:= round(cy*ascale);
      end;  
      with tmpinfo.res do begin
       x:= round(x*ascale);
       y:= round(y*ascale);
       cx:= round(cx*ascale);
       cy:= round(cy*ascale);
      end;  
      tmpinfo.font.height:= round(tmpinfo.font.height * ascale);
     end;
    end;
    drawtext(acanvas,tmpinfo);
    tmpfont.free;
   end;
  end;
  if length(ametapages[apage].lineobjects)>0 then begin
   for int1:=0 to length(ametapages[apage].lineobjects)-1 do begin
    with ametapages[apage].lineobjects[int1] do begin
     tmpwidthmm:= widthmm;
     tmpstart:= startpoint;
     tmpend:= endpoint;
     if ascale<>1.0 then begin
      tmpwidthmm:= tmpwidthmm*ascale;
      tmpstart.x:= round(tmpstart.x*ascale);
      tmpstart.y:= round(tmpstart.y*ascale);
      tmpend.x:= round(tmpend.x*ascale);
      tmpend.y:= round(tmpend.y*ascale);
     end;
     acanvas.linewidthmm:= tmpwidthmm;
     acanvas.colorbackground:= colorgap;
     acanvas.capstyle:= capstyle;
     acanvas.dashes:= dashes;
     acanvas.drawline(tmpstart,tmpend,color);
     end;
   end;
  end;
 end; 
end;

function createrectinfo(const arect: rectty; acolor: colorty):reprectinfoty;
begin
 result.rectarea:= arect;
 result.color:= acolor;
end;

function createlineinfo(const acanvas: tcanvas; const astart,aend:pointty; const acolor: colorty) : replineinfoty;
begin
 result.widthmm:= acanvas.linewidthmm;
 result.color:= acolor;
 result.colorgap:= acanvas.colorbackground;
 result.capstyle:= acanvas.capstyle;
 result.dashes:= acanvas.dashes;
 result.startpoint:= addpoint(acanvas.origin,astart);
 result.endpoint:= addpoint(acanvas.origin,aend);
end;

function createtextinfo(const ainfo: drawtextinfoty; arawfont: rawfontty; const apos: pointty): reptextinfoty;
begin
 result.text:= ainfo.text;
 result.dest:= makerect(apos.x,apos.y,ainfo.dest.cx,ainfo.dest.cy);
 result.clip:= ainfo.clip;
 result.flags:= ainfo.flags;
 result.font:= ainfo.font;
 result.tabulators:= ainfo.tabulators;
 result.res:= ainfo.res;
 result.rawfont:= arawfont;
end;

end.
