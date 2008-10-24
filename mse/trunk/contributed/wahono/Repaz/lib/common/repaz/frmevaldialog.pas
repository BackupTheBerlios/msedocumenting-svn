{*********************************************************}
{                                                         }
{     Dialog to create expression for TRepazEvaluator     }
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
unit frmevaldialog;
{$ifdef FPC}{$mode objfpc}{$h+}{$endif}
interface
uses
 mseglob,mseguiglob,mseapplication,msestat,msemenus,msegui,msegraphics,
 msegraphutils,mseevent,mseclasses,mseforms,msedataedits,mseedit,msestrings,
 msetypes,msesimplewidgets,msewidgets,msegrids,repazdatasources,repazevaluator,
 repazconsts,classes,mseconsts,repazevaluatortype,msedbedit,msedialog,db,msedb,
 mseinplaceedit,msesplitter;

const
 fmaxlisthelp=5;
type
 tevalrechelp=class(tobject)
 public
  rfunction:string;
  help:string;
  model:string;
  params:string;
 end;

 trepazevaldialog = class(tcomponent)
 private
  fexpression:msestring;
  fevaldatasource:trepazdatasources;
  fevaluator:trepazevaluator;
 protected
  procedure notification(acomponent:tcomponent;operation:toperation);override;
 public
  constructor create(aowner:tcomponent);override;
  destructor destroy;override;
  function execute:boolean;
 published
  property expression:msestring read fexpression write fexpression;
  property datasource:trepazdatasources read fevaldatasource write fevaldatasource;
  property evaluator:trepazevaluator read fevaluator write fevaluator;
 end;

type
 tfrmevaldialogfo = class(tmseform)
   MemoExpre: tmemoedit;
   LItems: tstringgrid;
   LCategory: tstringgrid;
   lparams: tlabel;
   lmodel: tlabel;
   lhelp: tlabel;
   tlayouter1: tlayouter;
   bclear: tbutton;
   bshowresult: tbutton;
   bchecksyn: tbutton;
   tbutton3: tbutton;
   badd: tbutton;
   tlayouter2: tlayouter;
   bcancel: tbutton;
   bok: tbutton;
   procedure frmevaldialogfo_oncreate(const sender: tobject);
   procedure frmevaldialogfo_ondestroy(const sender: tobject);
   procedure badd_onexecute(const sender: tobject);
   procedure bchecksyn_onexecute(const sender: tobject);
   procedure bshowresult_onexecute(const sender: tobject);
   procedure lcategory_oncellevent(const sender: tobject;
                   var info: celleventinfoty);
   procedure litems_oncellevent(const sender: tobject;
                   var info: celleventinfoty);
   procedure bok_onexecute(const sender: tobject);
   procedure bclear_onexecute(const sender: TObject);
  private
   validate:boolean;
   aresult:variant;
   fevaluator:trepazcustomevaluator;
   llistes:array[0..fmaxlisthelp-1] of tstringlist;
   procedure setevaluator(aval:trepazcustomevaluator);
  public
   property evaluator:trepazcustomevaluator read fevaluator write setevaluator;
 end;

var
 frmevaldialogfo: tfrmevaldialogfo;
 
function changeexpression(formul:string;aval:trepazcustomevaluator):string;
function changeexpressionw(formul:msestring;aval:trepazcustomevaluator):msestring;
function expressioncalculatew(formul:msestring;aval:trepazcustomevaluator):variant;

implementation
uses
 frmevaldialog_mfm;
 
function changeexpression(formul:string;aval:trepazcustomevaluator):string;
var
 dia:tfrmevaldialogfo;
begin
 dia:=tfrmevaldialogfo.create(application);
 try
  if not assigned(aval) then
   dia.evaluator:=trepazevaluator.create(dia)
  else
   dia.evaluator:=aval;
  dia.memoexpre.value:=formul;
  result:=formul;
  if dia.show=mr_ok then
   result:=dia.memoexpre.value;
 finally
  dia.free;
 end;
end;

function changeexpressionw(formul:msestring;aval:trepazcustomevaluator):msestring;
var
 dia:tfrmevaldialogfo;
begin
 dia:=tfrmevaldialogfo.create(application);
 try
  if not assigned(aval) then
   dia.evaluator:=trepazevaluator.create(dia)
  else
   dia.evaluator:=aval;
  dia.memoexpre.value:=formul;
  result:=formul;
  if dia.show(true)=mr_ok then
   result:=dia.memoexpre.value;
 finally
  dia.free;
 end;
end;

function expressioncalculatew(formul:msestring;aval:trepazcustomevaluator):variant;
var
 dia:tfrmevaldialogfo;
begin
 result:=null;
 dia:=tfrmevaldialogfo.create(application);
 try
  dia.validate:=true;
  //dia.memoexpre.wantreturns:=false;
  if not assigned(aval) then
   dia.evaluator:=trepazevaluator.create(dia)
  else
   dia.evaluator:=aval;
  dia.memoexpre.value:=formul;
  result:=dia.aresult;
  if dia.show(true)=mr_ok then
   result:=dia.aresult;
 finally
  dia.free;
 end;
end;

{ trepazevaldialog }

function trepazevaldialog.execute:boolean;
var
 dia:tfrmevaldialogfo;
begin
 if fevaldatasource<>nil then fevaluator.datasource:=fevaldatasource;
  dia:=tfrmevaldialogfo.create(application);
  try
   dia.evaluator:=fevaluator;
   dia.memoexpre.value:=expression;
   dia.activate;
   result:= dia.show(true)=mr_ok;
   if result then
    expression:=dia.memoexpre.value;
  finally
   dia.free;
  end;
end;

constructor trepazevaldialog.create(aowner:tcomponent);
begin
 inherited create(aowner);
 fevaluator:=trepazevaluator.create(self);
 fexpression:='';
end;

destructor trepazevaldialog.destroy;
begin
 inherited destroy;
 fevaluator:= nil;
end;

procedure trepazevaldialog.notification(acomponent:tcomponent;operation:toperation);
begin
 inherited notification(acomponent,operation);
 if operation=opremove then begin
  if acomponent=fevaldatasource then begin
   datasource:=nil;
  end else begin
   if acomponent=fevaluator then begin
    fevaluator:=nil;
   end;
  end;
 end;
end;

procedure tfrmevaldialogfo.frmevaldialogfo_oncreate(const sender: tobject);
var
 i:integer;
begin
 inherited;
 memoexpre.activate;
 for i:=0 to fmaxlisthelp-1 do
 begin
  llistes[i]:=tstringlist.create;
 end;

 bok.caption:=uc(ord(rcsok));
 bcancel.caption:=uc(ord(rcscancel));
 caption:=uc(ord(rcsexpcreator));
 lcategory.frame.caption:=uc(ord(rcscategory));
 litems.frame.caption:=uc(ord(rcsoperation));
 badd.caption:=uc(ord(rcsaddselection));
 bchecksyn.caption:=uc(ord(rcssyntaxcheck));
 bshowresult.caption:=uc(ord(rcsshowresult));
 bclear.caption:=uc(ord(rcsclear));
 lcategory.appendrow(uc(ord(rcsdbfields)));
 lcategory.appendrow(uc(ord(rcsfunctions)));
 lcategory.appendrow(uc(ord(rcsvariables)));
 lcategory.appendrow(uc(ord(rcsconstants)));
 lcategory.appendrow(uc(ord(rcsoperators)));
end;

procedure tfrmevaldialogfo.frmevaldialogfo_ondestroy(const sender: tobject);
var
 i,j:integer;
begin
  inherited;
 for i:=0 to fmaxlisthelp-1 do
 begin
  for j:=0 to llistes[i].count-1 do
  begin
   llistes[i].objects[j].free;
  end;
  llistes[i].free;
 end;
end;

procedure tfrmevaldialogfo.badd_onexecute(const sender: tobject);
begin
 if litems.row>-0 then begin
  memoexpre.value:=memoexpre.value+litems[0][litems.row];
 end;
end;

procedure tfrmevaldialogfo.bchecksyn_onexecute(const sender: tobject);
begin
 evaluator.expression:=memoexpre.value;
 try
  evaluator.checksyntax;
 except
  memoexpre.setfocus;
  memoexpre.editor.selstart:=evaluator.poserror;
  memoexpre.editor.sellength:=0;
  raise;
 end;
end;

procedure tfrmevaldialogfo.bshowresult_onexecute(const sender: tobject);
begin
 evaluator.expression:=memoexpre.value;
 try
  evaluator.evaluate;
 except
  memoexpre.setfocus;
  memoexpre.editor.selstart:=evaluator.poserror;
  memoexpre.editor.sellength:=0;
  raise;
 end;
 showmessage(tevalvaluetostring(evaluator.evalresult));
end;

procedure tfrmevaldialogfo.lcategory_oncellevent(const sender: tobject;
               var info: celleventinfoty);
var
 int1: integer;
begin
 if (info.eventkind=cek_buttonrelease) or (info.eventkind=cek_keyup) then begin
  litems.clear;
  for int1:=0 to llistes[lcategory.row].count-1 do begin
   litems.appendrow(llistes[lcategory.row].strings[int1]);
  end;
  lhelp.caption:='';
  lparams.caption:='';
  lmodel.caption:='';
 end;
end;

procedure tfrmevaldialogfo.litems_oncellevent(const sender: tobject;
               var info: celleventinfoty);
begin
 if (info.eventkind=cek_buttonrelease) or (info.eventkind=cek_keyup) then
 begin
  lhelp.caption:=(llistes[lcategory.row].objects[litems.row] 
   as tevalrechelp).help;
  lparams.caption:=(llistes[lcategory.row].objects[litems.row]
   as tevalrechelp).params;
  lmodel.caption:=(llistes[lcategory.row].objects[litems.row]
   as tevalrechelp).model;
 end;
 
 if iscellclick(info,[ccr_dblclick]) then
 begin
  memoexpre.value:=memoexpre.value+litems[0][litems.row];
 end;
end;

procedure tfrmevaldialogfo.bok_onexecute(const sender: tobject);
begin
 if validate then
 begin
  evaluator.expression:=memoexpre.value;
  try
   evaluator.evaluate;
   aresult:=evaluator.evalresult;
  except
   memoexpre.setfocus;
   memoexpre.editor.selstart:=evaluator.poserror;
   memoexpre.editor.sellength:=0;
   raise;
  end;
 end;
 close;
end;

procedure tfrmevaldialogfo.setevaluator(aval:trepazcustomevaluator);
var
 lista1:tstringlist;
 i:integer;
 iden:tevalidentifier;
 rec:tevalrechelp;
begin
 fevaluator:=aval;
 for i:=0 to fmaxlisthelp-1 do
 begin
  llistes[i].clear;
 end;
 lista1:=llistes[0];
 if aval.datasource<>nil then
 begin
  aval.datasource.fillwithfields(lista1);
  for i:=0 to lista1.count -1 do
  begin
   rec:=tevalrechelp.create;
   rec.rfunction:=lista1.strings[i];
   lista1.objects[i]:=rec;
  end;
 end;
 for i:=0 to aval.identifiers.count-1 do
 begin
  iden:=tevalidentifier(aval.identifiers.objects[i]);

  if iden<>nil then begin
   case iden.rtype of
    rtypeidenfunction:
     begin
     lista1:=llistes[1];
     end;
    rtypeidenvariable:
     begin
      lista1:=llistes[2];
     end;
    rtypeidenconstant:
     begin
      lista1:=llistes[3];
     end;
   end;
  	rec:=tevalrechelp.create;
   rec.rfunction:=aval.identifiers.strings[i];
   rec.help:=iden.help;
   rec.model:=iden.model;
   rec.params:=iden.aparams;
   lista1.addobject(rec.rfunction,rec);
  end;
 end;
 lista1:=llistes[4];
 // +
 rec:=tevalrechelp.create;
 rec.rfunction:='+';
 rec.help:=uc(ord(rcsoperatorsum));
 lista1.addobject(rec.rfunction,rec);
 // -
 rec:=tevalrechelp.create;
 rec.rfunction:='-';
 rec.help:=uc(ord(rcsoperatordif));
 lista1.addobject(rec.rfunction,rec);
 // *
 rec:=tevalrechelp.create;
 rec.rfunction:='*';
 rec.help:=uc(ord(rcsoperatormul));
 lista1.addobject(rec.rfunction,rec);
 // /
 rec:=tevalrechelp.create;
 rec.rfunction:='/';
 rec.help:=uc(ord(rcsoperatordiv));
 lista1.addobject(rec.rfunction,rec);
 // =
 rec:=tevalrechelp.create;
 rec.rfunction:='=';
 rec.help:=uc(ord(rcsoperatorcomp));
 lista1.addobject(rec.rfunction,rec);
 // ==
 rec:=tevalrechelp.create;
 rec.rfunction:='==';
 rec.help:=uc(ord(rcsoperatorcomp));
 lista1.addobject(rec.rfunction,rec);
 // >=
 rec:=tevalrechelp.create;
 rec.rfunction:='>=';
 rec.help:=uc(ord(rcsoperatorcomp));
 lista1.addobject(rec.rfunction,rec);
 // <=
 rec:=tevalrechelp.create;
 rec.rfunction:='<=';
 rec.help:=uc(ord(rcsoperatorcomp));
 lista1.addobject(rec.rfunction,rec);
 // >
 rec:=tevalrechelp.create;
 rec.rfunction:='>';
 rec.help:=uc(ord(rcsoperatorcomp));
 lista1.addobject(rec.rfunction,rec);
 // <
 rec:=tevalrechelp.create;
 rec.rfunction:='<';
 rec.help:=uc(ord(rcsoperatorcomp));
 lista1.addobject(rec.rfunction,rec);
 // <>
 rec:=tevalrechelp.create;
 rec.rfunction:='<>';
 rec.help:=uc(ord(rcsoperatorcomp));
 lista1.addobject(rec.rfunction,rec);
 // and
 rec:=tevalrechelp.create;
 rec.rfunction:='and';
 rec.help:=uc(ord(rcsoperatorlog));
 lista1.addobject(rec.rfunction,rec);
 // or
 rec:=tevalrechelp.create;
 rec.rfunction:='or';
 rec.help:=uc(ord(rcsoperatorlog));
 lista1.addobject(rec.rfunction,rec);
 // not
 rec:=tevalrechelp.create;
 rec.rfunction:='not';
 rec.help:=uc(ord(rcsoperatorlog));
 lista1.addobject(rec.rfunction,rec);
 // ;
 rec:=tevalrechelp.create;
 rec.rfunction:=';';
 rec.help:=uc(ord(rcsoperatorsep));
 rec.params:=uc(ord(rcsoperatorsepp));
 lista1.addobject(rec.rfunction,rec);
 // iif
 rec:=tevalrechelp.create;
 rec.rfunction:='iif';
 rec.help:=uc(ord(rcsoperatordec));
 rec.model:=uc(ord(rcsoperatordecm));
 rec.params:=uc(ord(rcsoperatordecp));
 lista1.addobject(rec.rfunction,rec);
 lcategory.row:=0;
end;

procedure tfrmevaldialogfo.bclear_onexecute(const sender: TObject);
begin
 MemoExpre.value:='';
end;

end.
