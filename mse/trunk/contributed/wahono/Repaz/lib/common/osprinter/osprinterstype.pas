{*********************************************************}
{                                                         }
{                 OSPrinter Components                    }
{         Variable type declaration for OSPrinter         }
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
{ The source code of the OSPrinter libraries and packages }
{ are distributed under the Library GNU General Public    }
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

unit osprinterstype;
{$ifdef FPC}{$mode objfpc}{$h+}{$endif}
interface
type
 stdpagety = record
  paperindex: integer;
  name: string;
  width,height: real //mm
 end;
 stdpagearty = array of stdpagety;

 printerty = record
  printername: string;
  drivername: string;
  location: string;
  port: string;
  description: string;
  isdefault: boolean;
  servername: string;
  sharename: string;
 end;
 printerarty = array of printerty;

 pageskindty = (pk_all,pk_even,pk_odd);
 
 pagerangety = record
  first,last: integer;
 end;
 pagerangearty = array of pagerangety;

implementation
end.
