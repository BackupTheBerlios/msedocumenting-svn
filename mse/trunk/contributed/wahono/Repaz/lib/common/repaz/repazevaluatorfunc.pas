{*********************************************************}
{                                                         }
{            Functions unit for TRepazEvaluator           }
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

unit repazevaluatorfunc;

interface

uses
 sysutils,classes,db,repazconsts,mseconsts,dateutils,msestrings,
 {$ifdef mswindows}windows,{$endif}variants,repazevaluatortype;

type

 { functions }
 tidenuppercase=class(tidenfunction)
  protected
   function getevalvalue:tevalvalue;override;
  public
   constructor create(aowner:tcomponent);override;
  end;

 tidenfileexists=class(tidenfunction)
  protected
   function getevalvalue:tevalvalue;override;
  public
   constructor create(aowner:tcomponent);override;
  end;

 tidenlowercase=class(tidenfunction)
  protected
   function getevalvalue:tevalvalue;override;
  public
   constructor create(aowner:tcomponent);override;
  end;

 tidenhourminsec=class(tidenfunction)
  protected
   function getevalvalue:tevalvalue;override;
  public
   constructor create(aowner:tcomponent);override;
  end;

 tidensinus=class(tidenfunction)
  protected
   function getevalvalue:tevalvalue;override;
  public
   constructor create(aowner:tcomponent);override;
  end;

 tidenmax=class(tidenfunction)
  protected
   function getevalvalue:tevalvalue;override;
  public
   constructor create(aowner:tcomponent);override;
  end;


 tidenfloattodatetime=class(tidenfunction)
  protected
   function getevalvalue:tevalvalue;override;
  public
   constructor create(aowner:tcomponent);override;
  end;

 tidenstringtotime=class(tidenfunction)
  protected
   function getevalvalue:tevalvalue;override;
  public
   constructor create(aowner:tcomponent);override;
  end;

 tidenstringtodatetime=class(tidenfunction)
  protected
   function getevalvalue:tevalvalue;override;
  public
   constructor create(aowner:tcomponent);override;
  end;

 tidentimetostring=class(tidenfunction)
  protected
   function getevalvalue:tevalvalue;override;
  public
   constructor create(aowner:tcomponent);override;
  end;

 tidendatetimetostring=class(tidenfunction)
  protected
   function getevalvalue:tevalvalue;override;
  public
   constructor create(aowner:tcomponent);override;
  end;

 tidendayofweek=class(tidenfunction)
  protected
   function getevalvalue:tevalvalue;override;
  public
   constructor create(aowner:tcomponent);override;
  end;

 tidenround=class(tidenfunction)
  protected
   function getevalvalue:tevalvalue;override;
  public
   constructor create(aowner:tcomponent);override;
  end;

 tidenroundtointeger=class(tidenfunction)
  protected
   function getevalvalue:tevalvalue;override;
  public
   constructor create(aowner:tcomponent);override;
  end;

 tidenabs=class(tidenfunction)
  protected
   function getevalvalue:tevalvalue;override;
  public
   constructor create(aowner:tcomponent);override;
  end;

 tidencomparevalue=class(tidenfunction)
  protected
   function getevalvalue:tevalvalue;override;
  public
   constructor create(aowner:tcomponent);override;
  end;

 tidenint=class(tidenfunction)
  protected
   function getevalvalue:tevalvalue;override;
  public
   constructor create(aowner:tcomponent);override;
  end;

 tidenval=class(tidenfunction)
  protected
   function getevalvalue:tevalvalue;override;
  public
   constructor create(aowner:tcomponent);override;
  end;

 tidenstr=class(tidenfunction)
  protected
   function getevalvalue:tevalvalue;override;
  public
   constructor create(aowner:tcomponent);override;
  end;

 tidentrim=class(tidenfunction)
  protected
   function getevalvalue:tevalvalue;override;
  public
   constructor create(aowner:tcomponent);override;
  end;

 tidenleft=class(tidenfunction)
  protected
   function getevalvalue:tevalvalue;override;
  public
   constructor create(aowner:tcomponent);override;
  end;

 tidenlength=class(tidenfunction)
  protected
   function getevalvalue:tevalvalue;override;
  public
   constructor create(aowner:tcomponent);override;
  end;

 tidenisinteger=class(tidenfunction)
  protected
   function getevalvalue:tevalvalue;override;
  public
   constructor create(aowner:tcomponent);override;
  end;

 tidenisnumeric=class(tidenfunction)
  protected
   function getevalvalue:tevalvalue;override;
  public
   constructor create(aowner:tcomponent);override;
  end;

 tidenisvaliddatetime=class(tidenfunction)
  protected
   function getevalvalue:tevalvalue;override;
  public
   constructor create(aowner:tcomponent);override;
  end;

 tidencheckexpression=class(tidenfunction)
  protected
   function getevalvalue:tevalvalue;override;
  public
   constructor create(aowner:tcomponent);override;
  end;

 tidenpos=class(tidenfunction)
  protected
   function getevalvalue:tevalvalue;override;
  public
   constructor create(aowner:tcomponent);override;
  end;

 tidengetvaluefromsql=class(tidenfunction)
  protected
   function getevalvalue:tevalvalue;override;
  public
   constructor create(aowner:tcomponent);override;
  end;

 tidenmodul=class(tidenfunction)
  protected
   function getevalvalue:tevalvalue;override;
  public
   constructor create(aowner:tcomponent);override;
  end;

 tidensqrt=class(tidenfunction)
 protected
   function getevalvalue:tevalvalue;override;
  public
   constructor create(aowner:tcomponent);override;
  end;

 tidenmonth=class(tidenfunction)
 protected
   function getevalvalue:tevalvalue;override;
  public
   constructor create(aowner:tcomponent);override;
  end;

 tidenevaltext=class(tidenfunction)
 protected
   function getevalvalue:tevalvalue;override;
 public
   constructor create(aowner:tcomponent);override;
 end;

 tidenmonthname=class(tidenfunction)
 protected
   function getevalvalue:tevalvalue;override;
  public
   constructor create(aowner:tcomponent);override;
  end;

 tidenyear=class(tidenfunction)
 protected
   function getevalvalue:tevalvalue;override;
  public
   constructor create(aowner:tcomponent);override;
  end;

 tidenday=class(tidenfunction)
 protected
   function getevalvalue:tevalvalue;override;
  public
   constructor create(aowner:tcomponent);override;
  end;

 tidenright=class(tidenfunction)
 protected
   function getevalvalue:tevalvalue;override;
  public
   constructor create(aowner:tcomponent);override;
  end;


 tidenstringtobin=class(tidenfunction)
 protected
   function getevalvalue:tevalvalue;override;
  public
   constructor create(aowner:tcomponent);override;
  end;

 tidensubstr=class(tidenfunction)
 protected
   function getevalvalue:tevalvalue;override;
  public
   constructor create(aowner:tcomponent);override;
  end;

 tidenformatstr=class(tidenfunction)
 protected
   function getevalvalue:tevalvalue;override;
  public
   constructor create(aowner:tcomponent);override;
  end;

 tidenformatnum=class(tidenfunction)
 protected
   function getevalvalue:tevalvalue;override;
  public
   constructor create(aowner:tcomponent);override;
  end;

 tidennumtotext=class(tidenfunction)
 protected
   function getevalvalue:tevalvalue;override;
  public
   constructor create(aowner:tcomponent);override;
  end;

 tidenreplacestr=class(tidenfunction)
 protected
   function getevalvalue:tevalvalue;override;
  public
   constructor create(aowner:tcomponent);override;
  end;

 tidenfieldexists=class(tidenfunction)
  protected
   function getevalvalue:tevalvalue;override;
  public
   constructor create(aowner:tcomponent);override;
 end;

 { constants }
 tidentoday=class(tidenconstant)
  protected
   function getevalvalue:tevalvalue;override;
  public
   constructor create(aowner:tcomponent);override;
  end;

 tidentime=class(tidenconstant)
  protected
   function getevalvalue:tevalvalue;override;
  public
   constructor create(aowner:tcomponent);override;
  end;

 tidennow=class(tidenconstant)
  protected
   function getevalvalue:tevalvalue;override;
  public
   constructor create(aowner:tcomponent);override;
  end;

 tidennull=class(tidenconstant)
  protected
   function getevalvalue:tevalvalue;override;
  public
   constructor create(aowner:tcomponent);override;
  end;


implementation

uses repazevaluator,math;

function varisstring(avar:variant):boolean;
begin
 result:=false;
 if ((vartype(avar)=varstring) or (vartype(avar)=varolestr)) then
  result:=true;
end;

constructor tidenuppercase.create(aowner:tcomponent);
begin
 inherited create(aowner);
 fparamcount:=1;
 idenname:='uppercase';
 help:=uc(ord(rcsuppercase));
 model:='uppercase(s:string):string';
 aparams:=uc(ord(rcspuppercase));
end;

function tidenuppercase.getevalvalue:tevalvalue;
begin
 if params[0]=null then
 begin
  result:='';
  exit;
 end;
 if not varisstring(params[0]) then
   raise tevalnamedexception.create(uc(ord(rcsevaltype)),
         idenname);
 result:=mseuppercase(params[0]);
end;

constructor tidenfileexists.create(aowner:tcomponent);
begin
 inherited create(aowner);
 fparamcount:=1;
 idenname:='fileexists';
 help:=uc(ord(rcsfileexists));
 model:='fileexists(s:string):boolean';
 aparams:=uc(ord(rcspfileexists));
end;

function tidenlowercase.getevalvalue:tevalvalue;
begin
 if params[0]=null then
 begin
  result:='';
  exit;
 end;
 if not varisstring(params[0]) then
   raise tevalnamedexception.create(uc(ord(rcsevaltype)),
         idenname);
  result:=mselowercase(params[0]);
end;

constructor tidenlowercase.create(aowner:tcomponent);
begin
 inherited create(aowner);
 fparamcount:=1;
 idenname:='lowercase';
 help:=uc(ord(rcslowercase));
 model:='lowercase(s:string):string';
 aparams:=uc(ord(rcsplowercase));
end;

function tidenfileexists.getevalvalue:tevalvalue;
begin
 if params[0]=null then
 begin
  result:=false;
  exit;
 end;
 if not varisstring(params[0]) then
   raise tevalnamedexception.create(uc(ord(rcsevaltype)),
         idenname);
 result:=fileexists(string(params[0]));
end;

constructor tidenhourminsec.create(aowner:tcomponent);
begin
 inherited create(aowner);
 fparamcount:=4;
 idenname:='hourminsec';
 help:=uc(ord(rcshourminsec));
 model:='hourminsec(h:double;idenh:string;idenm:string;idens:string):string';
 aparams:=uc(ord(rcsphourminsec));
end;

function tidenhourminsec.getevalvalue:tevalvalue;
var
 racional:double;
 hores:integer;
 minuts,segons:word;
 minutsstr,segonsstr:string;
begin
 if (not varisstring(params[1])) then
   raise tevalnamedexception.create(uc(ord(rcsevaltype)),
         idenname);
 if (not varisstring(params[2])) then
   raise tevalnamedexception.create(uc(ord(rcsevaltype)),
         idenname);
 if (not varisstring(params[3])) then
   raise tevalnamedexception.create(uc(ord(rcsevaltype)),
         idenname);
 if varisnumber(params[0]) then
 begin
  racional:=double(params[0]);
  //calculations in racional
  hores:=round(int(racional));
  minuts:=round(int(frac(racional)*60));
  segons:=round(frac(frac(racional)*60)*60);
  if segons<10 then
   segonsstr:='0'+inttostr(segons)
  else
   segonsstr:=inttostr(segons);
  if minuts<10 then
   minutsstr:='0'+inttostr(minuts)
  else
   minutsstr:=inttostr(minuts);
  result:=inttostr(hores)+params[1]+minutsstr+params[2]
   +segonsstr+params[3];
 end
 else
  raise tevalnamedexception.create(uc(ord(rcsevaltype)),
         idenname);
end;

constructor tidenfloattodatetime.create(aowner:tcomponent);
begin
 inherited create(aowner);
 fparamcount:=1;
 idenname:='floattodatetime';
 help:=uc(ord(rcsfloattodatetime));
 model:='floattodatetime(n:double):tdatetime';
 aparams:=uc(ord(rcspfloattodatetime));
end;

function tidenfloattodatetime.getevalvalue:tevalvalue;
begin
 if varisnumber(params[0]) then
  result:=tdatetime(params[0])
 else
  if vartype(params[0])=vardate then
    result:=tdatetime(params[0])
  else
  if varisnull(params[0]) then
  begin
   result:=null;
  end
  else
   raise tevalnamedexception.create(uc(ord(rcsevaltype)),
         idenname);
end;

constructor tidenstringtotime.create(aowner:tcomponent);
begin
 inherited create(aowner);
 fparamcount:=1;
 idenname:='stringtotime';
 help:=uc(ord(rcsstringtotime));
 model:='stringtotime(n:string):tdatetime';
 aparams:=uc(ord(rcspstringtotime));
end;

function tidenstringtotime.getevalvalue:tevalvalue;
begin
 if varisstring(params[0]) then
  result:=strtotime(params[0])
 else
  raise tevalnamedexception.create(uc(ord(rcsevaltype)),
   idenname);
end;

constructor tidenstringtodatetime.create(aowner:tcomponent);
begin
 inherited create(aowner);
 fparamcount:=1;
 idenname:='stringtodatetime';
 help:= uc(ord(rcsstringtodatetime));
 model:='stringtodatetime(n:string):tdatetime';
 aparams:=uc(ord(rcspstringtodatetime));
end;

function tidenstringtodatetime.getevalvalue:tevalvalue;
begin
 if varisstring(params[0]) then
  result:=strtodatetime(params[0])
 else
   raise tevalnamedexception.create(uc(ord(rcsevaltype)),
         idenname);
end;

constructor tidentimetostring.create(aowner:tcomponent);
begin
 inherited create(aowner);
 fparamcount:=2;
 idenname:='timetostring';
 help:=uc(ord(rcstimetostring));
 model:='timetostring(mask:string; n:tdatetime):string';
 aparams:=uc(ord(rcsptimetostring));
end;

function tidentimetostring.getevalvalue:tevalvalue;
begin
 if vartype(params[1])=vardate then begin
  if ( not (varisstring(params[0]))) then
   raise tevalnamedexception.create(uc(ord(rcsevaltype)),
    idenname);
  if not varisnull(params[1]) then begin
   if params[0]='' then params[0]:='hh:nn:ss';
    result:=formatdatetime(params[0],params[1]);
  end else begin
   result:='';
  end;
 end else begin
  raise tevalnamedexception.create(uc(ord(rcsevaltype)),
   idenname);
 end;
end;

constructor tidendatetimetostring.create(aowner:tcomponent);
begin
 inherited create(aowner);
 fparamcount:=2;
 idenname:='datetimetostring';
 help:= uc(ord(rcsdatetimetostring));
 model:='datetimetostring(mask:string; n:tdatetime):string';
 aparams:=uc(ord(rcspdatetimetostring));
end;

function tidendatetimetostring.getevalvalue:tevalvalue;
begin
 if vartype(params[1])=vardate then begin
  if ( not (varisstring(params[0]))) then
   raise tevalnamedexception.create(uc(ord(rcsevaltype)),
    idenname);
  if not varisnull(params[1]) then begin
   if params[0]='' then params[0]:='dd/mm/yyyy';
   result:=formatdatetime(params[0],params[1]);
  end else begin
   result:='';
  end;
 end else begin
  raise tevalnamedexception.create(uc(ord(rcsevaltype)),
    idenname);
 end;
end;

constructor tidendayofweek.create(aowner:tcomponent);
begin
 inherited create(aowner);
 fparamcount:=1;
 idenname:='dayofweek';
 help:= uc(ord(rcsdayofweek));
 model:='dayofweek(n:tdatetime):integer';
 aparams:=uc(ord(rcspdayofweek));
end;

function tidendayofweek.getevalvalue:tevalvalue;
begin
 if vartype(params[0])=vardate then begin
  if not varisnull(params[0]) then begin
   result:=dayoftheweek(params[0]);
  end else begin
   result:=0;
  end;
 end else begin
  raise tevalnamedexception.create(uc(ord(rcsevaltype)),
    idenname);
 end;
end;

constructor tidensinus.create(aowner:tcomponent);
begin
 inherited create(aowner);
 fparamcount:=1;
 idenname:='sin';
 help:=uc(ord(rcssin));
 model:='sin(ang:double):double';
 aparams:=uc(ord(rcspsin));
end;

function tidensinus.getevalvalue:tevalvalue;
begin
 if varisnumber(params[0]) then
  result:=sin(double(params[0]))
 else
   raise tevalnamedexception.create(uc(ord(rcsevaltype)),
         idenname);
end;

constructor tidenmax.create(aowner:tcomponent);
begin
 inherited create(aowner);
 fparamcount:=2;
 idenname:='max';
 help:=uc(ord(rcsmax));
 model:='max(a,y:double):double';
end;

function tidenmax.getevalvalue:tevalvalue;
begin
 if varisnumber(params[0]) then begin
  if varisnumber(params[1]) then
   result:=max(double(params[0]),double(params[1]))
  else
   raise tevalnamedexception.create(uc(ord(rcsevaltype)),
         idenname);
 end else
   raise tevalnamedexception.create(uc(ord(rcsevaltype)),
         idenname);
end;

constructor tidenround.create(aowner:tcomponent);
begin
 inherited create(aowner);
 idenname:='round';
 help:=uc(ord(rcsround));
 model:='round(num:double,r:double):double';
 aparams:=uc(ord(rcspround));
end;

function tidenround.getevalvalue:tevalvalue;
begin
 if (not varisnumber(params[0])) then
   raise tevalnamedexception.create(uc(ord(rcsevaltype)),
         idenname);
 if (not varisnumber(params[1])) then
   raise tevalnamedexception.create(uc(ord(rcsevaltype)),
         idenname);
 result:=roundfloat(double(params[0]),double(params[1]));
end;

constructor tidenroundtointeger.create(aowner:tcomponent);
begin
 inherited create(aowner);
 fparamcount:=1;
 idenname:='roundtointeger';
 help:=uc(ord(rcsround));
 model:='roundtointeger(num:double):integer';
 aparams:='';
end;

function tidenroundtointeger.getevalvalue:tevalvalue;
begin
 if (not varisnumber(params[0])) then
   raise tevalnamedexception.create(uc(ord(rcsevaltype)),
         idenname);
 result:=round(double(params[0]));
end;

constructor tidenabs.create(aowner:tcomponent);
begin
 inherited create(aowner);
 fparamcount:=1;
 idenname:='abs';
 help:=uc(ord(rcsabs));
 model:='abs(num:double):double';
 aparams:=uc(ord(rcspabs));
end;

function tidenabs.getevalvalue:tevalvalue;
begin
 if (not varisnumber(params[0])) then
   raise tevalnamedexception.create(uc(ord(rcsevaltype)),
         idenname);
 result:=abs(double(params[0]));
end;

constructor tidencomparevalue.create(aowner:tcomponent);
begin
 inherited create(aowner);
 fparamcount:=3;
 idenname:='comparevalue';
 help:=uc(ord(rcscomparevalue));
 model:='compare(num1,num2,epsilon:double):integer';
 aparams:=uc(ord(rcspcomparevalue));
end;

function comparevalue(p1,p2,epsilon:double):integer;
var
 dif:double;
begin
 dif:=abs(p1-p2);
 epsilon:=abs(epsilon);
 if dif<epsilon then
 begin
  result:=0;
  exit;
 end;
 if p1<p2 then
  result:=-1
 else
  result:=1;
end;

function tidencomparevalue.getevalvalue:tevalvalue;
begin
 if (not varisnumber(params[0])) then
   raise tevalnamedexception.create(uc(ord(rcsevaltype)),
         idenname);
 if (not varisnumber(params[1])) then
   raise tevalnamedexception.create(uc(ord(rcsevaltype)),
         idenname);
 if (not varisnumber(params[2])) then
   raise tevalnamedexception.create(uc(ord(rcsevaltype)),
         idenname);
 result:=integer(comparevalue(double(params[0]),double(params[1]),double(params[2])));
end;

constructor tidenint.create(aowner:tcomponent);
begin
 inherited create(aowner);
 fparamcount:=1;
 idenname:='int';
 help:=uc(ord(rcsint));
 model:='int(num:double):integer';
 aparams:=uc(ord(rcspint));
end;

function tidenint.getevalvalue:tevalvalue;
begin
 if (not (vartype(params[0]) in [varsmallint..vardate,varvariant])) then
   raise tevalnamedexception.create(uc(ord(rcsevaltype)),
         idenname);
 case vartype(params[0]) of
  varsmallint..vardate:
   begin
    result:=integer(trunc(int(double(params[0]))));
   end;
  varvariant:
   begin
    result:=integer(trunc(int(double(params[0]))));
   end;
  else
   raise tevalnamedexception.create(uc(ord(rcsevaltype)),
         idenname);
  end;

end;

constructor tidenstr.create(aowner:tcomponent);
begin
 inherited create(aowner);
 fparamcount:=1;
 idenname:='str';
 help:=uc(ord(rcsstr));
 model:='str(num:variant):string';
 aparams:=uc(ord(rcspstr));
end;

function tidenstr.getevalvalue:tevalvalue;
begin
 if varisnull(params[0]) then
  result:=''
 else
  result:=string(params[0]);
end;

constructor tidenval.create(aowner:tcomponent);
begin
 fparamcount:=1;
 idenname:='val';
 help:=uc(ord(rcsval));
 model:='val(s:string):double';
 aparams:=uc(ord(rcspval));
end;

function tidenval.getevalvalue:tevalvalue;
begin
 try
  if varisstring(params[0]) then begin
   if params[0]=''+chr(0) then begin
    result:=0;
    exit;
   end;
   result:=strtofloat(params[0]);
  end else begin
   result:=double(params[0]);
  end;
 except
   raise tevalnamedexception.create(uc(ord(rcsconverterror)),
         idenname);
 end;
end;

constructor tidentrim.create(aowner:tcomponent);
begin
 inherited create(aowner);
 fparamcount:=1;
 idenname:='trim';
 help:=uc(ord(rcstrim));
 model:='trim(s:string):string';
 aparams:=uc(ord(rcsptrim));
end;

function tidentrim.getevalvalue:tevalvalue;
begin
 if params[0]=null then begin
  result:='';
  exit;
 end;
 if not varisstring(params[0]) then
   raise tevalnamedexception.create(uc(ord(rcsevaltype)),
         idenname);
 result:=trim(string(params[0]));
end;

constructor tidenleft.create(aowner:tcomponent);
begin
 inherited create(aowner);
 fparamcount:=2;
 help:=uc(ord(rcsleft));
 model:='left(s:string,count:integer):string';
 aparams:=uc(ord(rcspleft));
end;

function tidenleft.getevalvalue:tevalvalue;
begin
 if not varisstring(params[0]) then
   raise tevalnamedexception.create(uc(ord(rcsevaltype)),
         idenname);
 if  not (varisinteger(params[1])) then
   raise tevalnamedexception.create(uc(ord(rcsevaltype)),
         idenname);

end;

constructor tidenlength.create(aowner:tcomponent);
begin
 inherited create(aowner);
 fparamcount:=1;
 idenname:='length';
 help:=uc(ord(rcslength));
 model:='length(s:string):integer';
 aparams:=uc(ord(rcsplength));
end;

function tidenlength.getevalvalue:tevalvalue;
begin
 if varisnull(params[0]) then
 begin
  result:=0;
  exit;
 end;
 if not varisstring(params[0]) then
   raise tevalnamedexception.create(uc(ord(rcsevaltype)),
         idenname);
 result:=length(string(params[0]));
end;

constructor tidenisinteger.create(aowner:tcomponent);
begin
 inherited create(aowner);
 fparamcount:=1;
 idenname:='isinteger';
 help:=uc(ord(rcsisinteger));
 model:='isinteger(s:string):boolean';
end;

function tidenisinteger.getevalvalue:tevalvalue;
begin
 if varisnull(params[0]) then begin
  result:=false;
  exit;
 end;
 if not varisstring(params[0]) then
   raise tevalnamedexception.create(uc(ord(rcsevaltype)),
         idenname);
 result:=true;
 try
  strtoint(params[0]);
 except
  result:=false;
 end;
end;

constructor tidenisnumeric.create(aowner:tcomponent);
begin
 inherited create(aowner);
 fparamcount:=1;

 help:=uc(ord(rcsisnumeric));
 model:='isnumeric(s:string):boolean';
end;

function tidenisnumeric.getevalvalue:tevalvalue;
begin
 if varisnull(params[0]) then begin
  result:=false;
  exit;
 end;
 if not varisstring(params[0]) then
   raise tevalnamedexception.create(uc(ord(rcsevaltype)),
         idenname);
 result:=true;
 try
  strtofloat(params[0]);
 except
  result:=false;
 end;
end;

constructor tidenisvaliddatetime.create(aowner:tcomponent);
begin
 inherited create(aowner);
 fparamcount:=1;
 idenname:='isvaliddatetime';

 model:='isvaliddatetime(s:string):boolean';
end;

function tidenisvaliddatetime.getevalvalue:tevalvalue;
begin
 if varisnull(params[0]) then begin
  result:=false;
  exit;
 end;
 if not varisstring(params[0]) then
   raise tevalnamedexception.create(uc(ord(rcsevaltype)),
         idenname);
 result:=true;
 try
  strtodatetime(params[0]);
 except
  result:=false;
 end;
end;

constructor tidencheckexpression.create(aowner:tcomponent);
begin
 inherited create(aowner);
 fparamcount:=2;
 idenname:='checkexpression';
 model:='checkexpression(expression,message:string):boolean';
end;

function tidencheckexpression.getevalvalue:tevalvalue;
begin
 if not varisstring(params[0]) then
   raise tevalnamedexception.create(uc(ord(rcsevaltype)),
         idenname);
 if not varisstring(params[1]) then
   raise tevalnamedexception.create(uc(ord(rcsevaltype)),
         idenname);
 result:=trepazevaluator(evaluator).evaluatetext(params[0]);
 if varisboolean(params[0]) then
  result:=params[0];
 if (not result) then
  raise exception.create(params[1]);
end;

constructor tidenpos.create(aowner:tcomponent);
begin
 inherited create(aowner);
 fparamcount:=2;
 idenname:='pos';
 help:=uc(ord(rcspos));
 model:='pos(substr:string,str:string):integer';
 aparams:=uc(ord(rcsppos));
end;

function tidenpos.getevalvalue:tevalvalue;
begin
 if params[0]=null then begin
  result:=0;
  exit;
 end;
 if not varisstring(params[0]) then
   raise tevalnamedexception.create(uc(ord(rcsevaltype)),
         idenname);
 if not varisstring(params[1]) then
   raise tevalnamedexception.create(uc(ord(rcsevaltype)),
         idenname);
 result:=pos(string(params[0]),string(params[1]));
end;

constructor tidengetvaluefromsql.create(aowner:tcomponent);
begin
 inherited create(aowner);
 fparamcount:=2;
 idenname:='getvaluefromsql';
 help:=uc(ord(rcsgetvaluefromsql));
 model:='getvaluefromsql(connectionname:string;sql:string):variant';
 aparams:=uc(ord(rcsgetvaluefromsqlp));
end;

function tidengetvaluefromsql.getevalvalue:tevalvalue;
begin
 if not varisstring(params[0]) then
   raise tevalnamedexception.create(uc(ord(rcsevaltype)),
         idenname);
 if not varisstring(params[1]) then
   raise tevalnamedexception.create(uc(ord(rcsevaltype)),
         idenname);
 result:=null;
end;

constructor tidensqrt.create(aowner:tcomponent);
begin
 inherited create(aowner);
 fparamcount:=1;
 idenname:='sqrt';
 help:=uc(ord(rcssqrt));
 model:='sqrt(num:double):double';
 aparams:=uc(ord(rcspsqrt));
end;

function tidensqrt.getevalvalue:tevalvalue;
begin
 if varisnumber(params[0]) then
  result:=sqrt(double(params[0]))
 else
  raise tevalnamedexception.create(uc(ord(rcsevaltype)),
         idenname);
end;

constructor tidenmodul.create(aowner:tcomponent);
begin
 inherited create(aowner);
 fparamcount:=2;
 idenname:='mod';
 help:=uc(ord(rcsmod));
 model:='mod(d1:integer,d2:integer):integer';
 aparams:=uc(ord(rcspmod));
end;

function tidenmodul.getevalvalue:tevalvalue;
begin
 if not varisnumber(params[0]) then
  raise tevalnamedexception.create(uc(ord(rcsevaltype)),
       idenname);
 if not varisnumber(params[1]) then
  raise tevalnamedexception.create(uc(ord(rcsevaltype)),
       idenname);
 result:=integer(params[0]) mod integer(params[1]);
end;

constructor tidentoday.create(aowner:tcomponent);
begin
 inherited create(aowner);
 help:=uc(ord(rcstoday));
 model:='today'+':date';
end;

function tidentoday.getevalvalue:tevalvalue;
begin
 result:=date;
end;

constructor tidentime.create(aowner:tcomponent);
begin
 inherited create(aowner);
 idenname:='time';
 help:=uc(ord(rcstimeh));
 model:='time'+':time';
end;

function tidentime.getevalvalue:tevalvalue;
begin
 result:=timeof(now);
end;

constructor tidennull.create(aowner:tcomponent);
begin
 inherited create(aowner);
 idenname:='null';
 help:=uc(ord(rcsnull));
 model:='null'+':variant';
end;

function tidennull.getevalvalue:tevalvalue;
begin
 result:=null;
end;

constructor tidennow.create(aowner:tcomponent);
begin
 inherited create(aowner);
 idenname:='now';
 help:=uc(ord(rcsnow));
 model:='now'+':datetime';
end;

function tidennow.getevalvalue:tevalvalue;
begin
 result:=now;
end;

constructor tidenmonthname.create(aowner:tcomponent);
begin
 inherited create(aowner);
 fparamcount:=1;
 idenname:='monthname';
 help:=uc(ord(rcsmonthname));
 model:='monthname(d:datetime):string';
 aparams:=uc(ord(rcspmonthname));
end;

function tidenmonthname.getevalvalue:tevalvalue;
var any,mes,dia:word;
begin
 if varisnumber(params[0]) then begin
  mes:=integer(params[0]);
  if (not (mes in [1..12])) then
   result:=''
  else
   result:=longmonthnames[mes];
 end else
 if vartype(params[0])=vardate then begin
  decodedate(tdatetime(params[0]),any,mes,dia);
  result:=longmonthnames[mes];
 end else
  raise tevalnamedexception.create(uc(ord(rcsevaltype)),
         idenname);
end;

constructor tidenevaltext.create(aowner:tcomponent);
begin
 fparamcount:=1;
 idenname:='evaltext';
 help:=uc(ord(rcsevaltext));
 model:='evaltext(expr:string):variant';
 aparams:=uc(ord(rcspevaltext));
end;

function tidenevaltext.getevalvalue:tevalvalue;
var avaluador:trepazcustomevaluator;
begin
 if not varisstring(params[0]) then
   raise tevalnamedexception.create(uc(ord(rcsevaltype)),
         idenname);
 // evalue
 avaluador:=(evaluator as trepazcustomevaluator);
 result:=avaluador.evaluatetext(params[0]);
end;

constructor tidenmonth.create(aowner:tcomponent);
begin
 inherited create(aowner);
 fparamcount:=1;
 idenname:='month';
 help:=uc(ord(rcsmonth));
 model:='month(d:datetime):integer';
 aparams:=uc(ord(rcspmonth));
end;


function tidenmonth.getevalvalue:tevalvalue;
var any,mes,dia:word;
begin
 case vartype(params[0]) of
  vardate:
   begin
    decodedate(tdatetime(params[0]),any,mes,dia);
    result:=mes;
   end;
  else
   raise tevalnamedexception.create(uc(ord(rcsevaltype)),
         idenname);
 end;
end;

constructor tidenyear.create(aowner:tcomponent);
begin
 inherited create(aowner);
 fparamcount:=1;
 idenname:='year';
 help:=uc(ord(rcsyear));
 model:='year(d:datetime):integer';
 aparams:=uc(ord(rcspyear));
end;

function tidenyear.getevalvalue:tevalvalue;
var any,mes,dia:word;
begin
 case vartype(params[0]) of
  vardate:
   begin
    decodedate(tdatetime(params[0]),any,mes,dia);
    result:=any;
   end;
  else
   raise tevalnamedexception.create(uc(ord(rcsevaltype)),
         idenname);
 end;
end;

constructor tidenday.create(aowner:tcomponent);
begin
 inherited create(aowner);
 fparamcount:=1;
 idenname:='day';
 help:=uc(ord(rcsday));
 model:='day(d:datetime):integer';
 aparams:=uc(ord(rcspday));
end;

function tidenday.getevalvalue:tevalvalue;
var any,mes,dia:word;
begin
 if ((vartype(params[0])=vardate) or (varisnumber(params[0]))) then
 begin
  decodedate(tdatetime(params[0]),any,mes,dia);
  result:=integer(dia);
 end
 else
  raise tevalnamedexception.create(uc(ord(rcsevaltype)),
         idenname);
end;

{ tidenright }

constructor tidenright.create(aowner:tcomponent);
begin
 inherited create(aowner);
 fparamcount:=2;
 idenname:='right';
 help:=uc(ord(rcsright));
 model:='right(s:string,count:integer):string';
 aparams:=uc(ord(rcspright));
end;


function tidenright.getevalvalue:tevalvalue;
begin
 if not varisstring(params[0]) then
   raise tevalnamedexception.create(uc(ord(rcsevaltype)),
         idenname);
 if ( not (varisinteger(params[1]))) then
   raise tevalnamedexception.create(uc(ord(rcsevaltype)),
         idenname);
 if  (integer(params[1])<1) then
  result:=''
 else
  result:=copy(string(params[0]),
              length(string(params[0]))+1-integer(params[1]),
              integer(params[1]));
end;


constructor tidensubstr.create(aowner:tcomponent);
begin
 inherited create(aowner);
 fparamcount:=3;
 idenname:='substr';
 help:=uc(ord(rcssubstr));
 model:='substr(s:string,index:integer,count:integer):string';
 aparams:=uc(ord(rcspsubstr));
end;


function tidensubstr.getevalvalue:tevalvalue;
begin
 if not varisstring(params[0]) then
   raise tevalnamedexception.create(uc(ord(rcsevaltype)),
         idenname);
 if ( not (varisinteger(params[1]))) then
   raise tevalnamedexception.create(uc(ord(rcsevaltype)),
         idenname);
 if integer(params[1])<1 then
 begin
  result:='';
  exit;
 end;
 if ( not (varisinteger(params[2]))) then
   raise tevalnamedexception.create(uc(ord(rcsevaltype)),
         idenname);
 if integer(params[2])<1 then
 begin
  result:='';
  exit;
 end;
 result:=copy(string(params[0]),
              integer(params[1]),
              integer(params[2]));
end;

constructor tidenformatstr.create(aowner:tcomponent);
begin
 inherited create(aowner);
 fparamcount:=2;
 idenname:='formatstr';
 help:=uc(ord(rcsformatstr));
 model:='formatstr(format:string,v:variant):string';
 aparams:=uc(ord(rcspformatstr));
end;


function tidenformatstr.getevalvalue:tevalvalue;
var
 avalue:variant;
begin
 if not varisstring(params[0]) then
   raise tevalnamedexception.create(uc(ord(rcsevaltype)),
         idenname);

 avalue:=params[1];
 if avalue=null then
 begin
  result:='';
  exit;
 end;
 case vartype(avalue) of
  varsmallint,varinteger,varsingle,vardouble,varword,varbyte,varcurrency:
   begin
    result:=formatfloat(params[0],double(avalue));
   end;
  vardate,272:
   begin
    result:=formatdatetime(params[0],vartodatetime(value));
   end;
  varboolean:
   begin
    if boolean(value) then
     result:='true'
    else
     result:='false';
   end;
  else
  begin
   result:=vartostr(value);
  end;
 end;
end;

constructor tidenformatnum.create(aowner:tcomponent);
begin
 inherited create(aowner);
 fparamcount:=2;
 idenname:='formatnum';

 model:='formatnum(mask:string;number:double):string';
 aparams:=uc(ord(rcspformatnum));
end;

function tidenformatnum.getevalvalue:tevalvalue;
begin
 if varisnull(params[1]) then
  params[1]:=0.0;
 if not (varisnumber(params[1]))then
   raise tevalnamedexception.create(uc(ord(rcsevaltype)),
         idenname);
 if ( not (varisstring(params[0]))) then
   raise tevalnamedexception.create(uc(ord(rcsevaltype)),
         idenname);
 result:=formatcurradv(params[0],params[1]);
end;

constructor tidennumtotext.create(aowner:tcomponent);
begin
 inherited create(aowner);
 fparamcount:=1;
 idenname:='numtotext';
 help:=uc(ord(rcsnumtotext));
 model:='numtotext(n:double):string';
 aparams:=uc(ord(rcspnumtotext));
end;

function tidennumtotext.getevalvalue:tevalvalue;
begin
 if not (varisnumber(params[0])) then
   raise tevalnamedexception.create(uc(ord(rcsevaltype)),
         idenname);
 if params[0]=null then
  result:= ''
 else
  result:=numbertotext(params[0]);
end;

constructor tidenreplacestr.create(aowner:tcomponent);
begin
 inherited create(aowner);
 fparamcount:=3;
 idenname:='replacestr';
 help:=uc(ord(rcsreplacestr));
 model:='replacestr(const s, oldpattern, newpattern:string;): string;';
 aparams:=uc(ord(rcspreplacestr));
end;

function tidenreplacestr.getevalvalue:tevalvalue;
begin
 if (not varisstring(params[0]))
  or (not varisstring(params[1]))
  or (not varisstring(params[2])) then
   raise tevalnamedexception.create(uc(ord(rcsevaltype)),idenname);
 result:=stringreplace(string(params[0]),string(params[1]),string(params[2]),
  [rfreplaceall, rfignorecase]);
end;

constructor tidenfieldexists.create(aowner: tcomponent);
begin
 inherited create(aowner);
 fparamcount:=1;
 idenname:='identexists';
 help:='';
 aparams:='';
end;

function tidenfieldexists.getevalvalue: tevalvalue;
 var iden:tevalidentifier;
begin
  // check if the parameter is a string
  if (not varisstring( params[0])) then
   raise tevalnamedexception.create(uc(ord(rcsevaltype)),idenname);
  // search for the identifier
  iden:=(evaluator as trepazevaluator).searchidentifier(string(params[0]));
  // set result
  result := not (iden = nil)
end;

constructor tidenstringtobin.create(aowner:tcomponent);
begin
 inherited create(aowner);
 fparamcount:=1;
 idenname:='stringtobin';
 help:=uc(ord(rcsdecode64));
 model:='stringtobin(s:string):binary';
 aparams:='';
end;


function tidenstringtobin.getevalvalue:tevalvalue;
var
 astring:string;
 p:pointer;
begin
 if not varisstring(params[0]) then
   raise tevalnamedexception.create(uc(ord(rcsevaltype)),
         idenname);
 astring:=string(params[0]);
 if length(astring)>0 then begin
  result:=vararraycreate([0,length(astring)-1],varbyte);
  p:=vararraylock(result);
  try
   move(astring[1],p^,length(astring));
  finally
   vararrayunlock(result);
  end;
 end;
end;

end.
