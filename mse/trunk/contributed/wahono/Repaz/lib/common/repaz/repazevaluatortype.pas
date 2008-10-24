{*********************************************************}
{                                                         }
{           Type definition for TRepazEvaluator           }
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
unit repazevaluatortype;


interface

uses
 msestrings,sysutils,classes,db,variants,repazconsts,mseconsts;

const
     // parser datatypes for constants
     toeof         =      char(0);
     tosymbol      =      char(1);
     tkstring      =      char(2);
     tointeger     =      char(3);
     tofloat       =      char(4);
     tooperator    =      char(5);
     towstring     =      char(6);
     // max number of parameters in a function
     maxparams =  50;

type
 tevaltoken=(toteof,totsymbol,totstring,totinteger,totfloat,totoperator,
              totboolean,totdate,tottime,totdatetime);


 tevalnamedexception=class(exception)
  public
   errormessage:string;
   elementerror:string;
   constructor create(msg,element:string);
 end;
 tevalexception=class(tevalnamedexception)
  public
   errorline:integer;
   errorposition:integer;
   constructor create(msg,element:string;line,position:integer);
 end;

 tevalvalue = variant;


 rtypeidentificator = (rtypeidenfunction,rtypeidenvariable,rtypeidenconstant);

 tevalidentifier=class(tcomponent)
  protected
   fparamcount:integer;
   procedure setevalvalue(value:tevalvalue);virtual;abstract;
   function getevalvalue:tevalvalue;virtual;abstract;
  public
   evaluator:tcomponent;
   rtype:rtypeidentificator;
   idenname:string;
   help:string;
   model:string;
   aparams:string;
   params:array[0..maxparams-1] of tevalvalue;
   constructor create(aowner:tcomponent);override;
   property paramcount:integer read fparamcount;
   property value:tevalvalue read getevalvalue write setevalvalue;
  end;

 tidenfunction=class(tevalidentifier)
  protected
   procedure setevalvalue(avalue:tevalvalue);override;
  public
   constructor create(aowner:tcomponent);override;
  end;

 tidenvariable=class(tevalidentifier)
  protected
   fvalue:tevalvalue;
   procedure setevalvalue(avalue:tevalvalue);override;
   function getevalvalue:tevalvalue;override;
  public
   constructor create(aowner:tcomponent);override;
  end;

 tidenconstant=class(tevalidentifier)
  protected
   fvalue:tevalvalue;
   procedure setevalvalue(avalue:tevalvalue);override;
   function getevalvalue:tevalvalue;override;
  public
   constructor create(aowner:tcomponent);override;
  end;

 tidenfield=class(tevalidentifier)
 private
  ffield:tfield;
 protected
   function getevalvalue:tevalvalue;override;
   procedure setevalvalue(avalue:tevalvalue);override;
 public
   constructor create(aowner:tcomponent);override;
   constructor createfield(aowner:tcomponent;nom:string);
   property field:tfield read ffield write ffield;
 end;

 tidentrue=class(tidenconstant)
 public
  constructor create(aowner:tcomponent);override;
 end;

 tidenfalse=class(tidenconstant)
 public
  constructor create(aowner:tcomponent);override;
 end;

// math operations
function sumtevalvalue(value1,value2:tevalvalue):tevalvalue;
function diftevalvalue(value1,value2:tevalvalue):tevalvalue;
function multtevalvalue(value1,value2:tevalvalue):tevalvalue;
function divtevalvalue(value1,value2:tevalvalue):tevalvalue;
function signtevalvalue(value:tevalvalue):tevalvalue;
// comp operations
function equaltevalvalue(value1,value2:tevalvalue):tevalvalue;
function equalequaltevalvalue(value1,value2:tevalvalue):tevalvalue;
function morethanequaltevalvalue(value1,value2:tevalvalue):tevalvalue;
function lessthanequaltevalvalue(value1,value2:tevalvalue):tevalvalue;
function morethantevalvalue(value1,value2:tevalvalue):tevalvalue;
function lessthantevalvalue(value1,value2:tevalvalue):tevalvalue;
function diferenttevalvalue(value1,value2:tevalvalue):tevalvalue;
function isnulltevalvalue(value:tevalvalue):boolean;

// logical operations
function logicalandtevalvalue(value1,value2:tevalvalue):tevalvalue;
function logicalortevalvalue(value1,value2:tevalvalue):tevalvalue;
function logicalnottevalvalue(value1:tevalvalue):tevalvalue;

// formatting operations
function tevalvaluetostring(value:tevalvalue):msestring;
function formattevalvalue(sformat:string;value:tevalvalue;userdef:boolean):string;

// date operation validation
procedure datetimevalidation(var value1,value2:tevalvalue);
function varisstring(avar:variant):boolean;
function varisnumber(avar:variant):boolean;
function varisinteger(avar:variant):boolean;
function varisboolean(avar:variant):boolean;
function roundfloat(num:double;redondeo:double):double;
function formatcurradv(mask:string;number:double):string;
function numbertotext(fnumber:currency):msestring;
function numbertotextenglish(amount:currency):msestring;

var
 defaultdecimals:integer;

implementation

// tevalnamedexception
constructor tevalnamedexception.create(msg,element:string);
begin
 errormessage:=msg;
 elementerror:=element;
 inherited create(errormessage);
end;

// tevalexception
constructor tevalexception.create(msg,element:string;line,position:integer);
begin
 inherited create(msg,element);

 errorline:=line;
 errorposition:=position;
 errormessage:=msg;
 elementerror:=element;
end;

// tevalidentifier
constructor tevalidentifier.create(aowner:tcomponent);
begin
 inherited create(aowner);

 help:=uc(ord(rcsnohelp));
 aparams:=uc(ord(rcsnoaparams));
 model:=uc(ord(rcsnomodel));
end;

// tidenfunction
constructor tidenfunction.create(aowner:tcomponent);
begin
 inherited create(aowner);
 rtype:=rtypeidenfunction;
end;

procedure tidenfunction.setevalvalue(avalue:tevalvalue);
begin
 raise tevalnamedexception.create(uc(ord(rcsassignfunc)),
       idenname);
end;

// tidentrue
constructor tidentrue.create(aowner:tcomponent);
begin
 inherited create(aowner);
 fvalue:=true;
 rtype:=rtypeidenconstant;
 help:=uc(ord(rcstruehelp));
 idenname:='true';
end;

// tidenfalse
constructor tidenfalse.create(aowner:tcomponent);
begin
 inherited create(aowner);
 fvalue:=false;
 help:=uc(ord(rcsfalsehelp));
 idenname:='false';
end;

// tidenvariable
constructor tidenvariable.create(aowner:tcomponent);
begin
 inherited create(aowner);
 rtype:=rtypeidenvariable;
end;

function tidenvariable.getevalvalue:tevalvalue;
begin
 result:=fvalue;
end;

procedure tidenvariable.setevalvalue(avalue:tevalvalue);
begin
 fvalue:=value;
end;

// tidenconstant
constructor tidenconstant.create(aowner:tcomponent);
begin
 inherited create(aowner);
 rtype:=rtypeidenconstant;
end;

function tidenconstant.getevalvalue:tevalvalue;
begin
 result:=fvalue;
end;

procedure tidenconstant.setevalvalue(avalue:tevalvalue);
begin
 raise tevalnamedexception.create(uc(ord(rcsassignconst)),
       idenname);
end;

// tidenfield
constructor tidenfield.create(aowner:tcomponent);
begin
 inherited create(aowner);
end;

constructor tidenfield.createfield(aowner:tcomponent;nom:string);
begin
 inherited create(aowner);
 idenname:=nom;
 help:=uc(ord(rcsfieldhelp));
end;

procedure tidenfield.setevalvalue(avalue:tevalvalue);
begin
  raise tevalnamedexception.create(uc(ord(rcsassignfield)),
       idenname);
end;

function tidenfield.getevalvalue:tevalvalue;
var
 atype:tvartype;
begin
 if field=nil then
 begin
  result:=null;
  exit;
 end;
 result:=field.asvariant;
 {atype:=vartype(result);
 if atype=14 then
  result:=field.asinteger;
 atype:=vartype(result);
 if atype=varfmtbcd then
 begin
  result:=bcdtodouble(vartobcd(result));
 end;}
end;

// math functions
function sumtevalvalue(value1,value2:tevalvalue):tevalvalue;
var
 atype1,atype2:tvartype;

begin
 if varisnull(value1) then
 begin
  result:=value2;
 end
 else
  if varisnull(value2) then
  begin
   result:=value1;
  end
  else
  begin
   // bugfix suming msestring+string
   // the result should be by default a msestring
   // but it's a string
   atype1:=vartype(value1);
   atype2:=vartype(value2);
   if atype1=atype2 then
    result:=value1+value2
   else
   begin
    if atype1=varolestr then
     result:=value1+msestring(value2)
    else
     if atype2=varolestr then
      result:=msestring(value1)+value2
     else
      result:=value1+value2
   end;
  end;
end;

function diftevalvalue(value1,value2:tevalvalue):tevalvalue;
begin
 if value1=null then
 begin
  result:=-value2;
 end
 else
  if value2=null then
  begin
   result:=value1;
  end
  else
   result:=value1-value2;
end;

function multtevalvalue(value1,value2:tevalvalue):tevalvalue;
begin
 result:=value1*value2;
end;

function divtevalvalue(value1,value2:tevalvalue):tevalvalue;
begin
 result:=value1/value2;
end;

function signtevalvalue(value:tevalvalue):tevalvalue;
begin
 result:=-value;
end;

// formating functions
function tevalvaluetostring(value:tevalvalue):msestring;
begin
 if value=null then
 begin
  result:='';
  exit;
 end;
 case vartype(value) of
   vardate:
    result:=formatdatetime(shortdateformat,tdatetime(value));
   else
    result:=value;
 end;

end;

function formattevalvalue(sformat:string;value:tevalvalue;userdef:boolean):string;
var
 index:integer;
 general:boolean;
begin
 if varisnull(value) then
 begin
  result:='';
  exit;
 end;
 case vartype(value) of
  varsmallint..varinteger:
   begin
    if not userdef then
    begin
     general:=false;
     index:=pos('n',sformat);
     if index<>0 then
      general:=true
     else
     begin
      index:=pos('f',sformat);
      if index<>0 then
       general:=true
      else
      begin
       index:=pos('m',sformat);
       if index<>0 then
        general:=true
      end;
     end;

     if general then
     begin
      if pos('.',sformat)=0 then
      begin
       insert('.'+inttostr(defaultdecimals),sformat,index);
      end;
     end;
    end;
    if userdef then
     result:=sysutils.formatfloat(sformat,double(value))
    else
    begin
     index:=pos('d',sformat);
     if index<>0 then
      result:=format(sformat,[integer(value)])
     else
      result:=format(sformat,[double(value)]);
    end;
   end;
  varsingle,vardouble,varcurrency:
   begin
    if not userdef then
    begin
     general:=false;
     index:=pos('n',sformat);
     if index<>0 then
      general:=true
     else
     begin
      index:=pos('f',sformat);
      if index<>0 then
       general:=true
      else
      begin
       index:=pos('m',sformat);
       if index<>0 then
       begin
        general:=true;
       end;
      end;
     end;
     if (general) then
     begin
      if pos('.',sformat)=0 then
      begin
       insert('.'+inttostr(defaultdecimals),sformat,index);
      end;
     end;
    end;
    try
     if userdef then
      result:=sysutils.formatfloat(sformat,double(value))
     else
      result:=format(sformat,[double(value)]);
    except
     if double(value)<>integer(value) then
      raise;
     if userdef then
      result:=sysutils.formatfloat(sformat,double(value))
     else
      result:=format(sformat,[integer(value)]);
    end;
   end;
  varstring:
   if value='' then result:='' else
    result:=format(sformat,[string(value)]);
  varboolean:
   begin
    if userdef then
     result:=sformat
    else
    if boolean(value) then
     result:='true'
    else
     result:='false';
   end;
  vardate:
   begin
    if userdef then
    begin
     result:=formatdatetime(sformat,tdatetime(value));
    end
    else
    begin
     if (sformat='%xl') then
     begin
      if tdatetime(value)=0 then
      begin
       result:='';
       exit;
      end;
      if tdatetime(value)<1 then
        result:=formatdatetime(longtimeformat,tdatetime(value))
      else
       if tdatetime(value)-trunc(double(value))=0 then
        result:=formatdatetime(longdateformat,tdatetime(value))
       else
        result:=formatdatetime(longdateformat+' '+longtimeformat,tdatetime(value))
     end
     else
     begin
      if tdatetime(value)=0 then
      begin
       result:='';
       exit;
      end;
      if tdatetime(value)<1 then
        result:=formatdatetime(shorttimeformat,tdatetime(value))
      else
       if tdatetime(value)-trunc(double(value))=0 then
        result:=formatdatetime(shortdateformat,tdatetime(value))
       else
        result:=formatdatetime(shortdateformat+' '+shorttimeformat,tdatetime(value))
     end;
    end;
   end;
  else
   result:='';
 end;
end;

// logical functions

function isnulltevalvalue(value:tevalvalue):boolean;
begin
 case vartype(value) of
  varsmallint..vardouble:
   result:=(double(value)=0);
  varstring:
   result:=(string(value)='');
  varboolean:
   result:=not boolean(value);
  vardate:
   result:=(tdatetime(value)=0);
  else
   result:=varisnull(value);
 end;
end;

function logicalandtevalvalue(value1,value2:tevalvalue):tevalvalue;
begin
 result:=value1 and value2;
end;

function logicalortevalvalue(value1,value2:tevalvalue):tevalvalue;
begin
 result:=value1 or value2;
end;

function logicalnottevalvalue(value1:tevalvalue):tevalvalue;
begin
  result:=not value1;
end;

function equaltevalvalue(value1,value2:tevalvalue):tevalvalue;
begin
 datetimevalidation(value1,value2);
 result:=(value1=value2);
end;

function morethanequaltevalvalue(value1,value2:tevalvalue):tevalvalue;
begin
 datetimevalidation(value1,value2);
 result:=value1>=value2;
end;

function lessthanequaltevalvalue(value1,value2:tevalvalue):tevalvalue;
begin
 datetimevalidation(value1,value2);
 result:=(value1<=value2);
end;

function morethantevalvalue(value1,value2:tevalvalue):tevalvalue;
begin
 datetimevalidation(value1,value2);
 result:=(value1>value2);
end;

function lessthantevalvalue(value1,value2:tevalvalue):tevalvalue;
begin
 datetimevalidation(value1,value2);
 result:=(value1<value2);
end;

function diferenttevalvalue(value1,value2:tevalvalue):tevalvalue;
begin
 datetimevalidation(value1,value2);
 result:=(value1<>value2);
end;

function equalequaltevalvalue(value1,value2:tevalvalue):tevalvalue;
begin
 datetimevalidation(value1,value2);
 result:=(value1=value2);
end;

// date time validation
procedure datetimevalidation(var value1,value2:tevalvalue);
begin
 if vartype(value1)=vardate then
 begin
  if vartype(value2)<>vardate then
   if value2<>null then
   begin
    value2:=varastype(value2,vardate);
   end;
 end;
 if vartype(value2)=vardate then
 begin
  if vartype(value1)<>vardate then
   if value1<>null then
   begin
    value1:=varastype(value1,vardate);
   end;
 end;
end;

function varisstring(avar:variant):boolean;
begin
 result:=false;
 if ((vartype(avar)=varstring) or (vartype(avar)=varolestr)) then
  result:=true;
end;

function varisnumber(avar:variant):boolean;
begin
 result:=(vartype(avar) in [varsmallint,varinteger,varsingle,vardouble,varcurrency,
  varshortint,varbyte,varword,varlongword,varint64]);
end;

function varisinteger(avar:variant):boolean;
begin
 result:=(vartype(avar) in [varsmallint,varinteger,varshortint,varbyte,varword,varlongword,varint64]);
end;

function varisboolean(avar:variant):boolean;
begin
 result:=(vartype(avar) in [varboolean]);
end;

function roundfloat(num:double;redondeo:double):double;
var
 provanum,provaredon,quocient:currency;
 intnum,intredon:comp;
 reste:integer;
 signenum,escala:integer;
begin
 if ((redondeo=0) or (num=0)) then
 begin
  result:=num;
  exit;
 end;
 if redondeo<0.0001 then
 begin
  redondeo:=0.0001;
 end;

 // original number
 signenum:=1;
 if num<0 then
  signenum:=-1;
 // has decimal?
 provanum:=abs(num);
 provaredon:=abs(redondeo);
 escala:=1;
 while (frac(provanum)<>0) do
 begin
  provanum:=provanum*10;
  provaredon:=provaredon*10;
  escala:=escala*10;
 end;
 while (frac(provaredon)<>0) do
 begin
  provanum:=provanum*10;
  provaredon:=provaredon*10;
  escala:=escala*10;
 end;
 // integers
 intnum:=trunc(provanum);
 intredon:=trunc(provaredon);
// intnum:=int(provanum);
// intredon:=int(provaredon);
 // mod
 quocient:=intnum/intredon;
 reste:=round(intnum-intredon*int(quocient));
 if (reste<(intredon/2)) then
  intnum:=intnum-reste
 else
  intnum:=intnum-reste+intredon;
 result:=intnum/escala*signenum;
end;

function formatcurradv(mask:string;number:double):string;
var
 decseparator:boolean;
 hiddendecseparator:boolean;
 decimalplacesvariable:boolean;
 index:integer;
 leftfillchar:char;
 astring:string;
 intstring,decstring:string;
 decchar:char;
 thchar:char;
 leftmask:string;
 rightmask:string;
 i:integer;
 allzeros:boolean;
 isnegative:boolean;
begin
 isnegative:=number<0;
 if (isnegative) then
  number:=-number;

 decseparator:=true;
 hiddendecseparator:=false;
 leftfillchar:='0';
 rightmask:='';
 decimalplacesvariable:=true;
 decchar:=decimalseparator;
 if decchar=chr(0) then
  decchar:='.';
 thchar:=thousandseparator;
 // decimal separator options
 index:=pos('.',mask);
 if index<1 then
 begin
  index:=pos(':',mask);
  if index>=0 then
   hiddendecseparator:=true;
 end;
 if index>0 then
 begin
  if index<length(mask) then
  begin
   if mask[index+1]='0' then
    decimalplacesvariable:=false;
  end
  else
   decseparator:=false;
 end
 else
  decseparator:=false;
 if not decseparator then
  decimalplacesvariable:=false;
 // right mask
 if index>0 then
  rightmask:=copy(mask,index+1,length(mask));
 // left mask option
 if index=0 then
  index:=length(mask);
 leftmask:='';
 while index>0 do
 begin
  if mask[index] in ['#',',','0'] then
   leftmask:=leftmask+mask[index];
  dec(index);
 end;

 // fill char options
 index:=pos('l',mask);
 if index>0 then
 begin
  if index<length(mask) then
   leftfillchar:=mask[index+1];
 end;
 // thousand  char
 index:=pos('t',mask);
 if index>0 then
 begin
  if index<length(mask) then
   thchar:=mask[index+1];
 end;
 index:=pos('d',mask);
 if index>0 then
 begin
  if index<length(mask) then
   decchar:=mask[index+1];
 end;

 // now formats the number
 intstring:='';
 decstring:='';
 astring:='##.';
 if decimalplacesvariable then
  astring:=astring+'#'
 else
  astring:=astring+rightmask;
 astring:=formatfloat(astring,number);
 index:=pos(decimalseparator,astring);
 if index>=0 then
 begin
  decstring:=copy(astring,index+1,length(astring));
  intstring:=copy(astring,1,index-1);
 end;
 // convert the number integer number
 i:=1;
 index:=length(intstring);
 astring:='';
 allzeros:=true;
 while index>0 do
 begin
  // negative case
  if intstring[index]='-' then
  begin
   astring:=intstring[index]+astring;
   break;
  end;
  while i<=length(leftmask) do
  begin
   if leftmask[i]=',' then
   begin
    astring:=thchar+astring;
    inc(i)
   end
   else
   begin
    if leftmask[i]='#' then
     allzeros:=false;
    inc(i);
    break;
   end;
  end;
  astring:=intstring[index]+astring;
  dec(index);
 end;
 if not decseparator then
  inc(i);
 // now fills if all 0
 while (allzeros and (i<=length(leftmask))) do
 begin
  if leftmask[i]='#' then
   allzeros:=false
  else
   astring:=leftfillchar+astring;
  inc(i);
 end;

 if hiddendecseparator then
  result:=astring+decstring
 else
 begin
  if (decseparator and (length(decstring)>0)) then
   result:=astring+decchar+decstring
  else
   result:=astring;
 end;
 if (isnegative) then
  result:='-'+result;
end;

function numbertotext(fnumber:currency):msestring;
begin
 result:= numbertotextenglish(fnumber);
end;

function numbertotextenglish(amount:currency):msestring;
var
 num : longint;
 fracture : integer;

 function num2str(num: longint): string;
 const hundred = 100;
       thousand = 1000;
       million = 1000000;
       billion = 1000000000;
  begin
    if num >= billion then
      if (num mod billion) = 0 then
        num2str := num2str(num div billion) + ' billion'
      else
        num2str := num2str(num div billion) + ' billion ' +
                   num2str(num mod billion)
    else
      if num >= million then
        if (num mod million) = 0 then
          num2str := num2str(num div million) + ' million'
        else
          num2str := num2str(num div million) + ' million ' +
                     num2str(num mod million)
      else
        if num >= thousand then
          if (num mod thousand) = 0 then
            num2str := num2str(num div thousand) + ' thousand'
          else
            num2str := num2str(num div thousand) + ' thousand ' +
                       num2str(num mod thousand)
        else
          if num >= hundred then
            if (num mod hundred) = 0 then
              num2str := num2str(num div hundred) + ' hundred'
            else
              num2str := num2str(num div  hundred) + ' hundred ' +
                         num2str(num mod hundred)
          else
          case (num div 10) of
         6,7,9: if (num mod 10) = 0 then
                   num2str := num2str(num div 10) + 'ty'
                 else
                   num2str := num2str(num div 10) + 'ty-' +
                              num2str(num mod 10);
              8: if num = 80 then
                   num2str := 'eighty'
                 else
                   num2str := 'eighty-' + num2str(num mod 10);
              5: if num = 50 then
                   num2str := 'fifty'
                 else
                   num2str := 'fifty-' + num2str(num mod 10);
              4: if num = 40 then
                   num2str := 'forty'
                 else
                   num2str := 'forty-' + num2str(num mod 10);
              3: if num = 30 then
                   num2str := 'thirty'
                 else
                   num2str := 'thirty-' + num2str(num mod 10);
              2: if num = 20 then
                   num2str := 'twenty'
                 else
                   num2str := 'twenty-' + num2str(num mod 10);
            0,1: case num of
                    0: num2str := 'zero';
                    1: num2str := 'one';
                    2: num2str := 'two';
                    3: num2str := 'three';
                    4: num2str := 'four';
                    5: num2str := 'five';
                    6: num2str := 'six';
                    7: num2str := 'seven';
                    8: num2str := 'eight';
                    9: num2str := 'nine';
                   10: num2str := 'ten';
                   11: num2str := 'eleven';
                   12: num2str := 'twelve';
                   13: num2str := 'thirteen';
                   14: num2str := 'fourteen';
                   15: num2str := 'fifteen';
                   16: num2str := 'sixteen';
                   17: num2str := 'seventeen';
                   18: num2str := 'eightteen';
                   19: num2str := 'nineteen'
                 end
          end
 end {num2str};

begin
 num:= trunc(abs(amount));
 fracture:= round(1000*frac(abs(amount)));
 result := num2str(num);
 if fracture > 0 then
   result := result + ' and '+inttostr(fracture) + '/1000';
end;

initialization

defaultdecimals:=2;

end.
