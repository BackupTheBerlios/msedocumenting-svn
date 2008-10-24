{*********************************************************}
{                                                         }
{                 OSPrinter Components                    }
{                 GDI API declaration                     }
{                                                         }
{            Originally file is msegdiprint part          }
{            written by Martin Schreiber                  }
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
unit gdiapi;
{$ifdef FPC}{$mode objfpc}{$h+}{$endif}
interface
uses windows,sysutils,msesysintf,msesys;

type
 winbool = longbool;
 docinfow = record
  cbsize: longint;
  lpszdocname: lpcwstr;
  lpszoutput: lpcwstr;
  lpszdatatype: lpcwstr;
  fwtype: dword;
 end;
 tdocinfow = docinfow;
 pdocinfow = ^docinfow;

 TDocInfo1 = record
   pDocName: PAnsiChar;
   pOutputFile: PAnsiChar;
   pDatatype: PAnsiChar;
 end;

 PPrinterDefaultsA = ^TPrinterDefaultsA;
 TPrinterDefaultsA = record
   pDatatype: PAnsiChar;
   pDevMode: PDeviceModeA;
   DesiredAccess: ACCESS_MASK;
 end;
  
 printer_info_2 = packed record
  pservername: pchar;
  pprintername: pchar;
  psharename: pchar;
  pportname: pchar;
  pdrivername: pchar;
  pcomment: pchar;
  plocation: pchar;
  pdevmode: pdevicemode;
  psepfile: pchar;
  pprintprocessor: pchar;
  pdatatype: pchar;
  pparameters: pchar;
  psecuritydescriptor: pointer;
  attributes: dword;
  priority: dword;
  defaultpriority: dword;
  starttime: dword;
  untiltime: dword;
  status: dword;
  cjobs: dword;
  averageppm: dword; 
 end;
 
 pprinter_info_2 = ^printer_info_2;
 
 printer_info_4 = packed record
  pprintername: pchar; 
  pservername: pchar;
  attributes: dword; 
 end;

 pprinter_info_4 = ^printer_info_4;

 printer_info_5 = packed record
  pprintername: pchar;
  pportname: pchar;
  attributes: dword;
  devicenotselectedtimeout: dword;
  transmissionretrytimeout: dword;
 end;

 pprinter_info_5 = ^printer_info_5;          

var     
 setworldtransform: function(_para1:hdc; var _para2:xform):winbool; stdcall;
 startdocw: function(_para1:hdc; _para2:pdocinfow):longint; stdcall;
 getdefaultprintera: function(pszbuffer: pchar;pcchbuffer: pdword): boolean; stdcall;
 enumprinters: function(flags: dword; name: pchar; level: dword;
  pprinterenum: pointer; cbbuf: dword; var pcbneeded, pcreturned: dword): boolean; stdcall;
 devicecapabilities: function (pdevice, pport: pchar; fwcapability: word;
  poutput: pchar; devmode: pdevicemodew): integer; stdcall;
 writeprinter: function (hPrinter: THandle; pBuf: Pointer; cbBuf: DWORD; var pcWritten: DWORD): boolean; stdcall;
 openprinter: function (pPrinterName: PAnsiChar; var phPrinter: THandle; pDefault: PPrinterDefaultsA): boolean; stdcall;
 closeprinter: function (hPrinter: THandle): boolean; stdcall;
 startdocprinter: function (hPrinter: THandle; Level: DWORD; pDocInfo: Pointer): DWORD; stdcall;

function initgdiprint: boolean;

implementation

function initgdiprint: boolean;
var
 haserror: boolean;
begin
 haserror:= false;
 if not iswin95 then begin
  try
   getprocaddresses(getmodulehandle('gdi32'),[
    'SetWorldTransform',                        //0
    'StartDocW'                                 //1
    ],
    [
    {$ifndef FPC}@{$endif}@SetWorldTransform,     //0
    {$ifndef FPC}@{$endif}@StartDocW              //1
    ]);
  except
   haserror:= true;
  end;
 end;
 if not haserror then begin
  try
   getprocaddresses(['WINSPOOL.DRV'],[
   'GetDefaultPrinterA',
   'EnumPrintersA',
   'DeviceCapabilitiesA',
   'WritePrinter',
   'OpenPrinterA',
   'ClosePrinter',
   'StartDocPrinterA'
   ],[
   {$ifndef FPC}@{$endif}@GetDefaultPrinterA,
   {$ifndef FPC}@{$endif}@EnumPrinters,
   {$ifndef FPC}@{$endif}@DeviceCapabilities,
   {$ifndef FPC}@{$endif}@writeprinter,
   {$ifndef FPC}@{$endif}@openprinter,
   {$ifndef FPC}@{$endif}@closeprinter,
   {$ifndef FPC}@{$endif}@startdocprinter
   ]);
  except
   haserror:= true;
  end;
 end else begin
  haserror:= true;
 end;
 result:= not haserror;
end;

end.
