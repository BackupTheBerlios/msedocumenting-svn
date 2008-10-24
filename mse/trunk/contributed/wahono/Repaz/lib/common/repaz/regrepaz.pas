{*********************************************************}
{                                                         }
{                Register Repaz Component                 }
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
unit regrepaz;
{$ifdef FPC}{$mode objfpc}{$h+}{$endif}
interface
uses
 classes,msecomponenteditors,msedesignintf,sysutils,msestrings,repazcomponents,
 repazdatasources,mseglob,repazpreview,repazevaluator,frmevaldialog,repazconsts,
 repazlookupbuffers;

type
 trepazeditor = class(tcomponenteditor)
  public
   constructor create(const adesigner: idesigner; acomponent: tcomponent); override;
   procedure edit; override;
 end;
 
implementation
uses
 repazdesign,regrepaz_bmp;

constructor trepazeditor.create(const adesigner: idesigner; acomponent: tcomponent);
begin
 inherited;
 fstate:= fstate + [cs_canedit];
end;

procedure trepazeditor.edit;
begin
 editrepaz(trepaz(fcomponent));
 fdesigner.componentmodified(fcomponent);
end;

procedure Register;
begin
 registercomponents('Repaz',[trepaz,trepazdatasources,trepazlookupbuffers,tpreview,trepazevaluator,trepazevaldialog]); 
 registercomponenttabhints(['Repaz'],['Repaz Component','Collection of Repaz datasources','Collection of Repaz mselookupbuffer','Repaz Preview',
   'Expression evaluator','Dialog for expression evaluator']);
 registercomponenteditor(trepaz,trepazeditor)
end;

initialization
 register;
end.
