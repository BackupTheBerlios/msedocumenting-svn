{*********************************************************}
{                                                         }
{   Repaz Component to link Repaz with mselookupbuffer    }
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
unit repazlookupbuffers;
{$ifdef FPC}{$mode objfpc}{$h+}{$endif}
interface
uses
 mseclasses,classes,mselookupbuffer,msearrayprops;
type
 trepazlookupbuffers = class;
 
 tlookupbufferitem = class(tvirtualpersistent)
  protected
   fowner: trepazlookupbuffers;
   flookupbuffer: tcustomlookupbuffer;
  published
   property lookupbuffer: tcustomlookupbuffer read flookupbuffer write flookupbuffer;
 end;

 tlookupbufferitems = class(tpersistentarrayprop)
  private
   fowner: tlookupbufferitem;
   function getlookupbufferitems(index: integer): tlookupbufferitem;
   procedure setlookupbufferitems(index: integer; const Value: tlookupbufferitem);
  protected
   procedure createitem(const index: integer; var item: tpersistent); override;
  public
   constructor create(const aowner: tlookupbufferitem);
   //class function getitemclasstype: persistentclassty; override;
   procedure insert(const index: integer; const aitem: tlookupbufferitem); overload;
   property items[index: integer]: tlookupbufferitem read getlookupbufferitems write setlookupbufferitems; default;
 end;

 trepazlookupbuffers = class(tmsecomponent)
  private
   flookupbuffers: tlookupbufferitems;
   procedure setlookupbuffer(const Value: tlookupbufferitems);
  public
   constructor create(aowner: tcomponent); overload; override;
   destructor destroy; override;
   function count: integer;
  published
   property lookupbuffer: tlookupbufferitems read flookupbuffers write setlookupbuffer;
 end;

implementation

constructor tlookupbufferitems.create(const aowner: tlookupbufferitem);
begin
 fowner:= aowner;
 inherited create(tlookupbufferitem);
end;

procedure tlookupbufferitems.insert(const index: integer; const aitem: tlookupbufferitem);
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

function tlookupbufferitems.getlookupbufferitems(index: integer): tlookupbufferitem;
begin
 result:= tlookupbufferitem(getitems(index));
end;

procedure tlookupbufferitems.setlookupbufferitems(index: integer; const Value: tlookupbufferitem);
begin
 tlookupbufferitem(getitems(index)).assign(value);
end;

procedure tlookupbufferitems.createitem(const index: integer; var item: tpersistent);
begin
 item:= tlookupbufferitem.create;
end;

{ trepazlookupbuffers }
constructor trepazlookupbuffers.create(aowner: tcomponent);
begin
 inherited;
 flookupbuffers:= tlookupbufferitems.create(nil);
end;

destructor trepazlookupbuffers.destroy;
begin
 flookupbuffers.Free;
 inherited;
end;

procedure trepazlookupbuffers.setlookupbuffer(const Value: tlookupbufferitems);
begin
 flookupbuffers.assign(Value);
end;

function trepazlookupbuffers.count: integer;
begin
 result:= flookupbuffers.count;
end;

end.
