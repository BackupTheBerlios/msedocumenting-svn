{*********************************************************}
{                                                         }
{                    TRepazEvaluator                      }
{                                                         }
{*********************************************************}
{            Copyright (c) 2008 Sri Wahono                }
{*********************************************************}
{            Originally concept is taken from             }
{           ReportMan source code, written by :           }
{                     Toni Martir                         }
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

unit repazevaluator;


interface

uses
  sysutils,classes,db,repazevaluatortype,msestrings,
  sysconst,repazevaluatorparser,variants,repazdatasources,repazconsts,
  mseconsts;

type
 trepazcustomevaluator=class(tcomponent)
 private
  evalfunctions:tstringlist;
  fevaldatasource:trepazdatasources;
  ferror:string;
  fposerror:longint;
  flineerror:word;
  repazevalparser:tmseevalparser;
  fexpression:msestring;
  fevalresult:tevalvalue;
  fidentifiers:tstringlist;
  fpartial:tevalvalue;
  fchecking:boolean;
  procedure setexpression(value:msestring);
  procedure variables(var value:tevalvalue);
  procedure separator(var value:tevalvalue);
  procedure logicalor(var value:tevalvalue);
  procedure logicaland(var value:tevalvalue);
  procedure comparations(var value:tevalvalue);
  procedure sum_dif(var value:tevalvalue);
  procedure mul_div(var value:tevalvalue);
  procedure dosign(var value:tevalvalue);
  procedure executeiif(var value:tevalvalue);
  procedure parentesis(var value:tevalvalue);
  procedure operand(var value:tevalvalue);
  function evaluateexpression:tevalvalue;
  function searchwithoutdot(name1:shortstring):tevalidentifier;
  function getevalresultstring:msestring;
  procedure addidentifiers;
  procedure freeevalfunctions;
  procedure initevalfunctions;
  procedure fillfunctions;
 protected
  procedure notification(acomponent:tcomponent;operation:toperation);override;
 public
  evaluating:boolean;
  constructor create(aowner:tcomponent);override;
  constructor createwithoutiden(aowner:tcomponent;addidens:boolean);
  destructor destroy;override;
  procedure addvariable(name1:string;objecte:tevalidentifier);
  procedure addiden(name1:string;objecte:tevalidentifier);
  function newvariable(name1:string;valueini:tevalvalue):tidenvariable;
  function searchidentifier(name1:shortstring):tevalidentifier;
  procedure evaluate;
  function evaluatetext(text:msestring):tevalvalue;
  procedure checksyntax;
  property expression:msestring read fexpression write setexpression;
  property evalresult:tevalvalue read fevalresult;
  property identifiers:tstringlist read fidentifiers
   write fidentifiers;
  property checking:boolean read fchecking;
  property error:string read ferror;
  property poserror:longint read fposerror;
  property lineerror:word read flineerror;
  property evalresultstring:msestring read getevalresultstring;
  property datasource:trepazdatasources read fevaldatasource write fevaldatasource;
 end;

 trepazevaluator = class(trepazcustomevaluator)
  private
  protected
  public
  published
   property datasource;
   property evalresult;
   property expression;
  end;


function evaluateexpression(aexpression:msestring):variant;

implementation

uses repazevaluatorfunc;

{ trepazcustomevaluator }

constructor trepazcustomevaluator.createwithoutiden(aowner:tcomponent;addidens:boolean);
begin
 inherited create(aowner);
 evaluating:=false;
 fexpression:='';
 repazevalparser:=tmseevalparser.create;
 fidentifiers:=tstringlist.create;
 if addidens then
  addidentifiers;
end;

constructor trepazcustomevaluator.create(aowner:tcomponent);
begin
 inherited create(aowner);
 initevalfunctions;
 evaluating:=false;
 fexpression:='';
 repazevalparser:=tmseevalparser.create;
 fidentifiers:=tstringlist.create;
 addidentifiers;
end;

procedure trepazcustomevaluator.fillfunctions;
var iden:tevalidentifier;
begin
 if evalfunctions.count>0 then
  exit;
  iden:=tidentrue.create(nil);
  evalfunctions.addobject('true',iden);
  iden:=tidenfalse.create(nil);
  evalfunctions.addobject('false',iden);

 // datetime constants
 iden:=tidentoday.create(nil);
 evalfunctions.addobject('today',iden);
 iden:=tidentime.create(nil);
 evalfunctions.addobject('time',iden);
 iden:=tidennow.create(nil);
 evalfunctions.addobject('now',iden);

 // null constant
 iden:=tidennull.create(nil);
 evalfunctions.addobject('null',iden);

 // functions
 iden:=tidensinus.create(nil);
 evalfunctions.addobject('sin',iden);
 iden:=tidenmax.create(nil);
 evalfunctions.addobject('max',iden);
 iden:=tidenfloattodatetime.create(nil);
 evalfunctions.addobject('floattodatetime',iden);
 iden:=tidenstringtotime.create(nil);
 evalfunctions.addobject('stringtotime',iden);
 iden:=tidenstringtodatetime.create(nil);
 evalfunctions.addobject('stringtodatetime',iden);
 iden:=tidentimetostring.create(nil);
 evalfunctions.addobject('timetostring',iden);
 iden:=tidendatetimetostring.create(nil);
 evalfunctions.addobject('datetimetostring',iden);
 iden:=tidendayofweek.create(nil);
 evalfunctions.addobject('dayofweek',iden);
 iden:=tidenround.create(nil);
 evalfunctions.addobject('round',iden);
 iden:=tidenroundtointeger.create(nil);
 evalfunctions.addobject('roundtointeger',iden);
 iden:=tidenint.create(nil);
 evalfunctions.addobject('int',iden);
 iden:=tidenabs.create(nil);
 evalfunctions.addobject('abs',iden);
 iden:=tidencomparevalue.create(nil);
 evalfunctions.addobject('comparevalue',iden);
 iden:=tidensqrt.create(nil);
 evalfunctions.addobject('sqrt',iden);
 iden:=tidenfieldexists.create(nil);
 evalfunctions.addobject('identexists',iden);
 iden:=tidenisinteger.create(nil);
 evalfunctions.addobject('isinteger',iden);
 iden:=tidenisnumeric.create(nil);
 evalfunctions.addobject('isnumeric',iden);
 iden:=tidenisvaliddatetime.create(nil);
 evalfunctions.addobject('isvaliddatetime',iden);
 iden:=tidencheckexpression.create(nil);
 evalfunctions.addobject('checkexpression',iden);
 iden := tidenstringtobin.create(nil);
 evalfunctions.addobject('stringtobin', iden);

 iden:=tidenstr.create(nil);
 evalfunctions.addobject('str',iden);
 iden:=tidenval.create(nil);
 evalfunctions.addobject('val',iden);
 iden:=tidenleft.create(nil);
 evalfunctions.addobject('left',iden);
 iden:=tidenlength.create(nil);
 evalfunctions.addobject('length',iden);
 iden:=tidentrim.create(nil);
 evalfunctions.addobject('trim',iden);
 iden:=tidenpos.create(nil);
 evalfunctions.addobject('pos',iden);
 iden:=tidenmodul.create(nil);
 evalfunctions.addobject('mod',iden);
 iden:=tidenmonthname.create(nil);
 evalfunctions.addobject('monthname',iden);
 iden:=tidenmonth.create(nil);
 evalfunctions.addobject('month',iden);
 iden:=tidenyear.create(nil);
 evalfunctions.addobject('year',iden);
 iden:=tidenday.create(nil);
 evalfunctions.addobject('day',iden);
 iden:=tidenright.create(nil);
 evalfunctions.addobject('right',iden);
 iden:=tidensubstr.create(nil);
 evalfunctions.addobject('substr',iden);
 iden:=tidenformatstr.create(nil);
 evalfunctions.addobject('formatstr',iden);
 iden:=tidenformatnum.create(nil);
 evalfunctions.addobject('formatnum',iden);
 iden:=tidenhourminsec.create(nil);
 evalfunctions.addobject('hourminsec',iden);
 iden:=tidenuppercase.create(nil);
 evalfunctions.addobject('uppercase',iden);
 iden:=tidenfileexists.create(nil);
 evalfunctions.addobject('fileexists',iden);
 iden:=tidenlowercase.create(nil);
 evalfunctions.addobject('lowercase',iden);
 iden:=tidenevaltext.create(nil);
 evalfunctions.addobject('evaltext',iden);
 iden:=tidennumtotext.create(nil);
 evalfunctions.addobject('numtotext',iden);
 iden:=tidenreplacestr.create(nil);
 evalfunctions.addobject('replacestr',iden);

 iden:=tidengetvaluefromsql.create(nil);
 evalfunctions.addobject('getvaluefromsql',iden);
end;

// adds the identifiers that are on cache
procedure trepazcustomevaluator.addidentifiers;
var
 i:integer;
begin
 fillfunctions;
 for i:=0 to evalfunctions.count-1 do
  fidentifiers.addobject(evalfunctions.strings[i],evalfunctions.objects[i]);
// identifiers.assign(evalfunctions);
end;

destructor trepazcustomevaluator.destroy;
begin
 if repazevalparser<>nil then
  repazevalparser.free;
 fidentifiers.free;
 freeevalfunctions;
 inherited destroy;
end;

procedure trepazcustomevaluator.setexpression(value:msestring);
begin
 if evaluating then
  raise exception.create(uc(ord(rcssetexpression)));
 fexpression:=value;
end;

// to evaluate a text we must create another evaluator
function trepazcustomevaluator.evaluatetext(text:msestring):tevalvalue;
var eval:trepazcustomevaluator;
    oldiden:tstringlist;
begin
 oldiden:=nil;
 if evaluating then
 begin
  eval:=trepazcustomevaluator.createwithoutiden(self,false);
  try
   oldiden:=eval.identifiers;
   eval.identifiers:=identifiers;
   eval.datasource:=fevaldatasource;
   eval.expression:=text;
   eval.evaluate;
   result:=eval.evalresult;
  finally
   eval.identifiers:=oldiden;
   eval.free;
  end;
 end
 else
 begin
  expression:=text;
  evaluate;
  result:=evalresult;
 end;
end;

// checking for syntax
procedure trepazcustomevaluator.checksyntax;
begin
 repazevalparser.expression:=fexpression;

 if repazevalparser.tokenstring='' then
 begin
  fevalresult:=true;
  exit;
 end;
 fchecking:=true;
 try
  evaluateexpression;
  fevalresult:=true;
 except
  fevalresult:=false;
  raise;
 end;
end;

procedure trepazcustomevaluator.evaluate;
begin
 repazevalparser.expression:=fexpression;
 fchecking:=false;
 if ((repazevalparser.tokenstring='') and (not (repazevalparser.token in [tkstring,towstring]))) then
 begin
  fevalresult:=true;
  exit;
 end;
 try
  fevalresult:=evaluateexpression;
 except
  raise
 end;
end;

function trepazcustomevaluator.evaluateexpression:tevalvalue;
begin
 fpartial:=varnull;
 try
  evaluating:=true;
  try
   // call the recursive tree to evaluate the expression
   separator(fpartial);
  finally
   evaluating:=false;
  end;
 except
  // we can assign error information here
  on e:ezerodivide do
   begin
    ferror:=uc(ord(rcsdivisiozero));
    flineerror:=repazevalparser.sourceline;
    fposerror:=repazevalparser.sourcepos;
    raise tevalexception.create(ferror,
        repazevalparser.tokenstring,flineerror,fposerror);
   end;
  on e:tevalnamedexception do
   begin
   ferror:=e.errormessage;
   flineerror:=repazevalparser.sourceline;
   fposerror:=repazevalparser.sourcepos;
   raise tevalexception.create(ferror+' '''+e.elementerror+'''',
        repazevalparser.tokenstring,flineerror,fposerror)
   end;
  on eparsererror do
   begin
    ferror:=uc(ord(rcsevalsyntax));
    flineerror:=repazevalparser.sourceline;
    fposerror:=repazevalparser.sourcepos;
    raise tevalexception.create(ferror,
        repazevalparser.tokenstring,flineerror,fposerror);
   end;
  on e:tevalexception do
   begin
    ferror:=e.errormessage;
    flineerror:=e.errorline;
    fposerror:=e.errorposition;
    raise;
   end;
  on e:evarianterror do
   begin
    if e.message=sinvalidcast then
    begin
     ferror:=uc(ord(rcsevaltype));
     flineerror:=repazevalparser.sourceline;
     fposerror:=repazevalparser.sourcepos;
     raise tevalexception.create(ferror,
         repazevalparser.tokenstring,flineerror,fposerror);
    end
    else
     if e.message=sinvalidvarop then
     begin
      ferror:=uc(ord(rcsinvalidoperation));
      flineerror:=repazevalparser.sourceline;
      fposerror:=repazevalparser.sourcepos;
      raise tevalexception.create(ferror,
         repazevalparser.tokenstring,flineerror,fposerror);
     end;
   end;
  else
  begin
   ferror:=uc(ord(rcsevalsyntax));
   flineerror:=repazevalparser.sourceline;
   fposerror:=repazevalparser.sourcepos;
   raise;
  end;
 end;

 if repazevalparser.token<>toeof then
 begin
  ferror:=uc(ord(rcsevalsyntax));
  flineerror:=repazevalparser.sourceline;
  fposerror:=repazevalparser.sourcepos;
  raise tevalexception.create(uc(ord(rcsevalsyntax))+repazevalparser.tokenstring,
        repazevalparser.tokenstring,repazevalparser.sourceline,repazevalparser.sourcepos);
 end;
 result:=fpartial;
end;

procedure trepazcustomevaluator.variables(var value:tevalvalue);
var
 iden:tevalidentifier;
begin
 if repazevalparser.token=tosymbol then
 begin
  // exists this identifier?
  iden:=searchidentifier(repazevalparser.tokenstring);
  if iden=nil then
  begin
   raise tevalexception.create(uc(ord(rcsevaldesciden))+':'+
         repazevalparser.tokenstring,repazevalparser.tokenstring,
        repazevalparser.sourceline,repazevalparser.sourcepos);
  end
  else
  begin
   iden.evaluator:=self;
   // is a variable?
   if iden.rtype=rtypeidenvariable then
   begin
    // is a := , so we must assign
    if repazevalparser.nexttokenis(':=') then
    begin
     repazevalparser.nexttoken;
     // the :=
     repazevalparser.nexttoken;
     // look for the value
     variables(value);
     // if syntax checking not touch the variable
     if (not fchecking) then
      (iden as tidenvariable).value:=value;
     if ((repazevalparser.token=tooperator) and (repazevalparser.tokenstring[1]=';')) then
      separator(value);
    end
    else
     // not a := we must continue
     logicalor(value);
   end
   else
    // look for it
    logicalor(value);
  end
 end
 else
 begin
   // look for it
  logicalor(value);
 end;
end;

{**************************************************************************}

procedure trepazcustomevaluator.logicalor(var value:tevalvalue);
var operador:string[3];
    auxiliar,auxiliar2:tevalvalue;
begin
 // first precedes the and operator
 logicaland(value);

 if repazevalparser.token=tooperator then
 begin
  operador:=lowercase(repazevalparser.tokenstring);
  while (operador='or') do
  begin
   auxiliar2:=value;
   repazevalparser.nexttoken;
   logicaland(auxiliar);
   // compatible types?
   if (not fchecking) then
    value:=logicalortevalvalue(auxiliar2,auxiliar);
   if repazevalparser.token<>tooperator then
    exit
   else
    operador:=lowercase(repazevalparser.tokenstring);
  end;
 end;
end;

procedure trepazcustomevaluator.logicaland(var value:tevalvalue);
var operador:string[3];
    auxiliar,auxiliar2:tevalvalue;
begin
 comparations(value);       

 if repazevalparser.token=tooperator then
 begin
  operador:=lowercase(repazevalparser.tokenstring);
  while (operador='and') do
  begin
   repazevalparser.nexttoken;
   auxiliar2:=value;
   comparations(auxiliar);
   // compatible types?
   if (not fchecking) then
    value:=logicalandtevalvalue(auxiliar2,auxiliar);
   if repazevalparser.token<>tooperator then
    exit
   else
    operador:=lowercase(repazevalparser.tokenstring);
  end;
 end;
end;

procedure trepazcustomevaluator.separator(var value:tevalvalue);
begin
 if ((repazevalparser.token=tooperator) and (repazevalparser.tokenstring[1]=';')) then
 begin
  while ((repazevalparser.token=tooperator) and (repazevalparser.tokenstring[1]=';')) do
  begin
   repazevalparser.nexttoken;
   if (repazevalparser.token<>toeof) then
    variables(value);
  end
 end
 else
 begin
  variables(value);
  while ((repazevalparser.token=tooperator) and (repazevalparser.tokenstring[1]=';')) do
  begin
   repazevalparser.nexttoken;
   if (repazevalparser.token<>toeof) then
    variables(value);
  end
 end;
end;

procedure trepazcustomevaluator.comparations(var value:tevalvalue);
var
operation:string[3];
auxiliar,auxiliar2:tevalvalue;
begin
 sum_dif(value);
 while repazevalparser.token=tooperator do
 begin
  operation:=repazevalparser.tokenstring;
  if operation='=' then
    begin
     repazevalparser.nexttoken;
     auxiliar2:=value;
     sum_dif(auxiliar);
     if (not fchecking) then
      value:=equaltevalvalue(auxiliar2,auxiliar);
    end
   else
   if ((operation='<>') or (operation='><')) then
   begin
    repazevalparser.nexttoken;
    auxiliar2:=value;
    sum_dif(auxiliar);
    if (not fchecking) then
    value:=diferenttevalvalue(auxiliar2,auxiliar);
   end
   else
   if operation='>=' then
   begin
    repazevalparser.nexttoken;
    auxiliar2:=value;
    sum_dif(auxiliar);
    if (not fchecking) then
    value:=morethanequaltevalvalue(auxiliar2,auxiliar);
   end
   else
   if operation='<=' then
   begin
    repazevalparser.nexttoken;
    auxiliar2:=value;
    sum_dif(auxiliar);
    if (not fchecking) then
    value:=lessthanequaltevalvalue(auxiliar2,auxiliar);
   end
   else
   if operation='>' then
   begin
    repazevalparser.nexttoken;
    auxiliar2:=value;
    sum_dif(auxiliar);
    if (not fchecking) then
    value:=morethantevalvalue(auxiliar2,auxiliar);
   end
   else
   if operation='<' then
   begin
    repazevalparser.nexttoken;
    auxiliar2:=value;
    sum_dif(auxiliar);
    if (not fchecking) then
    value:=lessthantevalvalue(auxiliar2,auxiliar);
   end
   else
   if operation='==' then
   begin
    repazevalparser.nexttoken;
    auxiliar2:=value;
    sum_dif(auxiliar);
    if (not fchecking) then
    value:=equalequaltevalvalue(auxiliar2,auxiliar);
   end
   else
   if operation=':=' then
   begin
    raise tevalexception.create(uc(ord(rcsevaldescidenleft))+':'+
          repazevalparser.tokenstring,repazevalparser.tokenstring,
         repazevalparser.sourceline,repazevalparser.sourcepos);
   end
   else
    exit;
 end;
end;

procedure trepazcustomevaluator.sum_dif(var value:tevalvalue);
var operador:string[3];
    auxiliar,auxiliar2:tevalvalue;
begin
 mul_div(value);

 if repazevalparser.token=tooperator then
 begin
  operador:=lowercase(repazevalparser.tokenstring);
  while ((operador='+') or (operador='-')) do
  begin
   repazevalparser.nexttoken;
   auxiliar2:=value;
   mul_div(auxiliar);

   // compatible types?
   if (not fchecking) then
   case operador[1] of
    '+':value:=sumtevalvalue(auxiliar2,auxiliar);
    '-':value:=diftevalvalue(auxiliar2,auxiliar);
   end;
   if repazevalparser.token<>tooperator then
    exit
   else
    operador:=lowercase(repazevalparser.tokenstring);
  end;
 end;
end;

procedure trepazcustomevaluator.mul_div(var value:tevalvalue);
var operador:string[4];
    auxiliar,auxiliar2:tevalvalue;
begin
 dosign(value);

 if repazevalparser.token=tooperator then
 begin
  operador:=lowercase(repazevalparser.tokenstring);
  while ((operador='*') or (operador='/')) do
  begin
   repazevalparser.nexttoken;
   auxiliar2:=value;
   dosign(auxiliar);
   if (not fchecking) then
   case operador[1] of
    '*':value:=multtevalvalue(auxiliar2,auxiliar);
    '/':value:=divtevalvalue(auxiliar2,auxiliar);
   end;
   if repazevalparser.token<>tooperator then
      exit
   else
    operador:=lowercase(repazevalparser.tokenstring);
  end;
 end;
end;

// the sign is same precedence than functions
procedure trepazcustomevaluator.dosign(var value:tevalvalue);
var operador:string[4];
    iden:tevalidentifier;
    i:integer;
begin
 iden:=nil;
 operador:='';
 if repazevalparser.token=tooperator then
 begin
  operador:=lowercase(repazevalparser.tokenstring);
  if ((operador='+') or (operador='-')
       or (operador='not') or (operador='iif')) then
   repazevalparser.nexttoken;
 end
 else
 // is a function?
 if repazevalparser.token=tosymbol then
 begin
  iden:=searchidentifier(repazevalparser.tokenstring);
  if iden=nil then
   raise tevalexception.create(uc(ord(rcsevaldesciden))+
       repazevalparser.tokenstring,repazevalparser.tokenstring,
      repazevalparser.sourceline,repazevalparser.sourcepos);
  if iden.rtype=rtypeidenfunction then
  begin
   iden.evaluator:=self;
   // ok is a function assign params
   if iden.paramcount>0 then
   begin
    repazevalparser.nexttoken;
    if repazevalparser.token<>tooperator then
       raise tevalexception.create(uc(ord(rcsevalparent))+' ('+
       repazevalparser.tokenstring,' ( '+repazevalparser.tokenstring,repazevalparser.sourceline,
       repazevalparser.sourcepos);
    if repazevalparser.tokenstring<>'(' then
       raise tevalexception.create(uc(ord(rcsevalparent))+
       repazevalparser.tokenstring,'('+repazevalparser.tokenstring,repazevalparser.sourceline,
       repazevalparser.sourcepos);
   end;
   for i:=0 to iden.paramcount-1 do
   begin
    // next param
    repazevalparser.nexttoken;
    // look for the value
    separator(iden.params[i]);
    // param separator is ','
    if iden.paramcount>i+1 then
    begin
      if repazevalparser.token<>tooperator then
       raise tevalexception.create(uc(ord(rcsevalsyntax))+
       repazevalparser.tokenstring,repazevalparser.tokenstring,repazevalparser.sourceline,
       repazevalparser.sourcepos);
      if repazevalparser.tokenstring[1]<>',' then
       raise tevalexception.create(uc(ord(rcsevalsyntax))+
       repazevalparser.tokenstring,repazevalparser.tokenstring,repazevalparser.sourceline,
       repazevalparser.sourcepos);
     end;
   end;
   // now the close ) expected
   if iden.paramcount>0 then
   begin
    if repazevalparser.token<>tooperator then
       raise tevalexception.create(uc(ord(rcsevalparent))+' )'+
       repazevalparser.tokenstring,' ) '+repazevalparser.tokenstring,repazevalparser.sourceline,
       repazevalparser.sourcepos);
    if repazevalparser.tokenstring<>')' then
       raise tevalexception.create(uc(ord(rcsevalparent))+' )'+
       repazevalparser.tokenstring,' ) '+repazevalparser.tokenstring,repazevalparser.sourceline,
       repazevalparser.sourcepos);
    repazevalparser.nexttoken;
   end;
  end
  else
   // if not a function must be an operator
   iden:=nil;
 end;
 if iden=nil then
 begin
  if operador='iif' then
     executeiif(value)
  else
   parentesis(value)
 end
 else
  if iden.paramcount=0 then
   repazevalparser.nexttoken;

 // if it's a funcion execute it (if not syntax check)
 if iden<>nil then
 begin
  if not fchecking then
   value:=iden.value;
 end
 else
 begin
  if operador='-' then
     if (not fchecking) then
      value:=signtevalvalue(value)
     else
     begin
     end
  else
   if operador='not' then
     if (not fchecking) then
      value:=logicalnottevalvalue(value);
 end;
end;

procedure trepazcustomevaluator.operand(var value:tevalvalue);
var
    iden:tevalidentifier;
begin
 case repazevalparser.token of
  tosymbol:
   begin
    // obtaining the value of an identifier
    iden:=searchidentifier(repazevalparser.tokenstring);
    if iden=nil then
    begin
     raise tevalexception.create(uc(ord(rcsevaldesciden))+
         repazevalparser.tokenstring,repazevalparser.tokenstring,
        repazevalparser.sourceline,repazevalparser.sourcepos);
    end;
    iden.evaluator:=self;
    value:=iden.value;
    repazevalparser.nexttoken;
   end;
  tkstring:
   begin
    value:=repazevalparser.tokenstring;
    repazevalparser.nexttoken;
   end;
  towstring:
   begin
    value:=repazevalparser.tokenwidestring;
    repazevalparser.nexttoken;
   end;
  tointeger:
   begin
    value:=repazevalparser.tokenint;
    repazevalparser.nexttoken;
   end;
  tofloat:
   begin
    value:=repazevalparser.tokenfloat;
    repazevalparser.nexttoken;
   end;
  else
  begin
   raise tevalexception.create(uc(ord(rcsevalsyntax))+
         repazevalparser.tokenstring,repazevalparser.tokenstring,
        repazevalparser.sourceline,repazevalparser.sourcepos);
  end;
 end;
end;

procedure trepazcustomevaluator.parentesis(var value:tevalvalue);
var operation:char;
begin
 if repazevalparser.token=tooperator then
 begin
  operation:=repazevalparser.tokenstring[1];
  if operation='(' then
  begin
   repazevalparser.nexttoken;
   // look into the parentesis
   separator(value);

   if (repazevalparser.token<>tooperator) then
    raise tevalexception.create(uc(ord(rcsevalparent)),'',
        repazevalparser.sourceline,repazevalparser.sourcepos);
   operation:=repazevalparser.tokenstring[1];
   if (operation<>')') then
      raise tevalexception.create(uc(ord(rcsevalparent)),'',
        repazevalparser.sourceline,repazevalparser.sourcepos);
   repazevalparser.nexttoken;
  end
  else
   operand(value);
 end
 else
   operand(value);
end;

procedure trepazcustomevaluator.executeiif(var value:tevalvalue);
var
 auxiliar:tevalvalue;
 anticfchecking:boolean;
begin
 // must be a parentesis
 if repazevalparser.token<>tooperator then
   raise tevalexception.create(uc(ord(rcsevalparent)),'(',
      repazevalparser.sourceline,repazevalparser.sourcepos);
 if repazevalparser.tokenstring<>'(' then
   raise tevalexception.create(uc(ord(rcsevalparent)),'(',
      repazevalparser.sourceline,repazevalparser.sourcepos);
 // decision term
 repazevalparser.nexttoken;
 separator(value);
 // null means false
 if varisnull(value) then
  value:=false;
 // not boolean error
 if ((vartype(value)<>varboolean) and (not fchecking)) then
   raise tevalexception.create(uc(ord(rcsevaltype)),'iif',
      repazevalparser.sourceline,repazevalparser.sourcepos);
 // next tokens
 if repazevalparser.token<>tooperator then
   raise tevalexception.create(uc(ord(rcsevalsyntax)),'iif',
      repazevalparser.sourceline,repazevalparser.sourcepos);
 if repazevalparser.tokenstring<>',' then
   raise tevalexception.create(uc(ord(rcsevalsyntax)),'iif',
      repazevalparser.sourceline,repazevalparser.sourcepos);
 repazevalparser.nexttoken;
 // if yes and not checking syntax
 if not fchecking then
 begin
  if boolean(value) then
  begin
   separator(value);
   // skip the second term
   if repazevalparser.token<>tooperator then
     raise tevalexception.create(uc(ord(rcsevalsyntax)),'iif',
        repazevalparser.sourceline,repazevalparser.sourcepos);
   if repazevalparser.tokenstring<>',' then
     raise tevalexception.create(uc(ord(rcsevalsyntax)),'iif',
        repazevalparser.sourceline,repazevalparser.sourcepos);
   repazevalparser.nexttoken;

   anticfchecking:=fchecking;
   fchecking:=true;
   separator(auxiliar);
   fchecking:=anticfchecking;
  end
  else
  begin
   anticfchecking:=fchecking;
   fchecking:=true;
   separator(auxiliar);

   if repazevalparser.token<>tooperator then
     raise tevalexception.create(uc(ord(rcsevalsyntax)),'iif',
        repazevalparser.sourceline,repazevalparser.sourcepos);
   if repazevalparser.tokenstring<>',' then
     raise tevalexception.create(uc(ord(rcsevalsyntax)),'iif',
        repazevalparser.sourceline,repazevalparser.sourcepos);
   repazevalparser.nexttoken;

   fchecking:=anticfchecking;
   separator(value);
  end;
 end
 else
 // syntax checking
 begin
  // skip the params
  separator(value);
  if repazevalparser.token<>tooperator then
    raise tevalexception.create(uc(ord(rcsevalsyntax)),'iif',
       repazevalparser.sourceline,repazevalparser.sourcepos);
  if repazevalparser.tokenstring<>',' then
    raise tevalexception.create(uc(ord(rcsevalsyntax)),'iif',
       repazevalparser.sourceline,repazevalparser.sourcepos);
  repazevalparser.nexttoken;
  separator(auxiliar);
 end;
 // must be a ) now
 if repazevalparser.token<>tooperator then
   raise tevalexception.create(uc(ord(rcsevalparent)),')',
      repazevalparser.sourceline,repazevalparser.sourcepos);
 if repazevalparser.tokenstring<>')' then
   raise tevalexception.create(uc(ord(rcsevalparent)),')',
      repazevalparser.sourceline,repazevalparser.sourcepos);
 repazevalparser.nexttoken;
end;

procedure trepazcustomevaluator.addvariable(name1:string;objecte:tevalidentifier);
begin
 objecte.idenname:=name1;
 fidentifiers.addobject('m.'+ansilowercase(name1),objecte);
end;

procedure trepazcustomevaluator.addiden(name1:string;objecte:tevalidentifier);
begin
 identifiers.addobject(name1,objecte);
end;

function trepazcustomevaluator.searchwithoutdot(name1:shortstring):tevalidentifier;
var
 index:integer;
begin
  result:=nil;
  index:=fidentifiers.indexof(name1);
  if index>=0 then
   result:=fidentifiers.objects[index] as tevalidentifier;
  if assigned(result) then
   exit;
  // memory variable?
  index:=fidentifiers.indexof('m.'+name1);
  if index>=0 then
   result:=fidentifiers.objects[index] as tevalidentifier;
  if assigned(result) then
   exit;
  // may be a field ?
  if fevaldatasource<>nil then
   result:=fevaldatasource.searchfield(name1);
end;

function trepazcustomevaluator.searchidentifier(name1:shortstring):tevalidentifier;
var
pospunt:byte;
primer,sensepunt:string;
doble:boolean;
 index:integer;
begin
 name1:=ansilowercase(name1);
 result:=nil;
 // have a point ?
 pospunt:=pos('.',name1);
 if pospunt=0 then
 begin
  result:=searchwithoutdot(name1);
  exit;
 end;
 primer:=copy(name1,0,pospunt-1);
  // memory variable ?
 if primer='m' then
 begin
  index:=fidentifiers.indexof(name1);
  if index>=0 then
   result:=fidentifiers.objects[index] as tevalidentifier;
  exit;
 end;
 sensepunt:=copy(name1,pospunt+1,ord(name1[0])-pospunt);
 if fevaldatasource<>nil then
  result:=fevaldatasource.searchfieldwithdataset(primer,sensepunt);
end;

function trepazcustomevaluator.getevalresultstring:msestring;
begin
 result:=tevalvaluetostring(evalresult);
end;

procedure trepazcustomevaluator.notification(acomponent:tcomponent;operation:toperation);
begin
 inherited notification(acomponent,operation);
 if operation=opremove then
 begin
  if acomponent=fevaldatasource then
   datasource:=nil;
 end;
end;


function trepazcustomevaluator.newvariable(name1:string;valueini:tevalvalue):tidenvariable;
var iden:tidenvariable;
begin
 if searchidentifier(name1)=nil then
 begin
  iden:=tidenvariable.create(self);
  iden.value:= valueini;
  addvariable(name1,iden);
  iden.evaluator:=self;
  result:=iden;
 end
 else
  // error variable redeclared
  raise exception.create(uc(ord(rcsvariabledefined))+name1)
end;

procedure trepazcustomevaluator.freeevalfunctions;
var
 i:integer;
begin
 if assigned(evalfunctions) then
 begin
  for i:=0 to evalfunctions.count-1 do
  begin
   evalfunctions.objects[i].free;
  end;
 end;
 evalfunctions.free;
end;

procedure trepazcustomevaluator.initevalfunctions;
begin
 evalfunctions:=tstringlist.create;
 evalfunctions.sorted:=true;
 evalfunctions.duplicates:=duperror;
end;

function evaluateexpression(aexpression:msestring):variant;
var
 aeval:trepazevaluator;
begin
 aeval:=trepazevaluator.create(nil);
 try
  aeval.expression:=aexpression;
  aeval.evaluate;
  result:=aeval.evalresult;
 finally
  aeval.free;
 end;
end;

initialization

finalization

end.
