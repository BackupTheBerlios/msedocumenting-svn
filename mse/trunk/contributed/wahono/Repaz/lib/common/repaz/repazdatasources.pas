{*********************************************************}
{                                                         }
{       Repaz Component to link Repaz with DataSource     }
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
unit repazdatasources;
{$ifdef FPC}{$mode objfpc}{$h+}{$endif}
interface
uses
 mseclasses,classes,db,msearrayprops,repazevaluatortype;
type
 trepazdatasources = class;
 
 tdatasourceitem = class(tvirtualpersistent)
  protected
   fowner: trepazdatasources;
   fdatasource: tdatasource;
  published
   property datasource: tdatasource read fdatasource write fdatasource;
 end;

 tdatasourceitems = class(tpersistentarrayprop)
  private
   fowner: tdatasourceitem;
   function getdatasourceitems(index: integer): tdatasourceitem;
   procedure setdatasourceitems(index: integer; const Value: tdatasourceitem);
  protected
   procedure createitem(const index: integer; var item: tpersistent); override;
  public
   constructor create(const aowner: tdatasourceitem);
   //class function getitemclasstype: persistentclassty; override;
   procedure insert(const index: integer; const aitem: tdatasourceitem); overload;
   property items[index: integer]: tdatasourceitem read getdatasourceitems write setdatasourceitems; default;
 end;

 trepazdatasources = class(tmsecomponent)
  private
   iden:tidenfield;
   fdatasources: tdatasourceitems;
   procedure setdatasource(const Value: tdatasourceitems);
  public
   constructor create(aowner: tcomponent); overload; override;
   destructor destroy; override;
   function count: integer;
   function searchfield(aname:shortstring):tevalidentifier;
   function searchfieldwithdataset(adataset:shortstring;aname:shortstring):tevalidentifier;
   procedure fillwithfields(lines:tstrings);
  published
   property datasource: tdatasourceitems read fdatasources write setdatasource;
 end;

implementation

constructor tdatasourceitems.create(const aowner: tdatasourceitem);
begin
 fowner:= aowner;
 inherited create(tdatasourceitem);
end;

procedure tdatasourceitems.insert(const index: integer; const aitem: tdatasourceitem);
var
 int1: integer;
begin
 int1:= index;
 if index > count then begin
  int1:= count;
 end;
 beginupdate;
 try
  insertempty(int1);
  fitems[int1]:= aitem;
 finally
  endupdate;
 end;
end;

function tdatasourceitems.getdatasourceitems(index: integer): tdatasourceitem;
begin
 result:= tdatasourceitem(getitems(index));
end;

procedure tdatasourceitems.setdatasourceitems(index: integer; const Value: tdatasourceitem);
begin
 tdatasourceitem(getitems(index)).assign(value);
end;

procedure tdatasourceitems.createitem(const index: integer; var item: tpersistent);
begin
 item:= tdatasourceitem.create;
end;

{ trepazdatasources }
constructor trepazdatasources.create(aowner: tcomponent);
begin
 inherited;
 fdatasources:= tdatasourceitems.create(nil);
 iden:=tidenfield.createfield(self,'');
end;

destructor trepazdatasources.destroy;
begin
 fdatasources.Free;
 inherited;
end;

procedure trepazdatasources.setdatasource(const Value: tdatasourceitems);
begin
 fdatasources.assign(Value);
end;

function trepazdatasources.count: integer;
begin
 result:= fdatasources.count;
end;

// searching a field in the list
function trepazdatasources.searchfield(aname:shortstring):tevalidentifier;
var 
 field:tfield;
 i,j: integer;
begin
 result:=nil;
 if fdatasources.count>0 then begin
  for i:=0 to fdatasources.count-1 do begin
   for j:=0 to fdatasources[i].datasource.dataset.fieldcount-1 do begin
    if lowercase(aname)=lowercase(fdatasources[i].datasource.dataset.fields[j].name) then begin
     field:=fdatasources[i].datasource.dataset.fieldbyname(aname);
     if field<>nil then begin
      iden.field:=field;
      result:=iden;
     end;
     exit;
    end;
   end;
  end;
 end;
end;

function trepazdatasources.searchfieldwithdataset(adataset:shortstring;aname:shortstring):tevalidentifier;
var 
 field:tfield;
 i:integer;
begin
 result:=nil;
 if fdatasources.count>0 then begin
  for i:=0 to fdatasources.count-1 do begin
   if lowercase(adataset)=lowercase(fdatasources[i].datasource.name) then begin
    field:=fdatasources[i].datasource.dataset.fieldbyname(aname);
    if field<>nil then begin
     iden.field:=field;
     result:=iden;
    end;
    exit;
   end;
  end;
 end;
end;

// fills a string list with the fieldnames in a
// aliaslist as alias.field
procedure trepazdatasources.fillwithfields(lines:tstrings);
var
 i,j:integer;
begin
 lines.clear;
 if fdatasources.count>0 then begin
  for i:=0 to fdatasources.count-1 do begin
   for j:=0 to fdatasources[i].datasource.dataset.fieldcount-1 do begin
    lines.add(fdatasources[i].datasource.name + '.' + fdatasources[i].datasource.dataset.fields[j].fieldname);
   end;
  end;
 end;
end;

end.
