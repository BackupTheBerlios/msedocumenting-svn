{*********************************************************}
{                                                         }
{           Language constant string for TRepaz           }
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
unit repazconsts;
{$ifdef FPC}{$mode objfpc}{$h+}{$endif}
interface

uses
 msestrings,mseconsts;
type
 rcscaptionty = (
  rcsLineTooLong,
  rcsExpected,
  rcssetexpression,
  rcsDivisioZero,
  rcsEvalsyntax,
  rcsEvalType,
  rcsInvalidOperation,
  rcsEvalDescIden,
  rcsEvalDescIdenLeft,
  rcsEvalParent,
  rcsVariabledefined,
  rcsFieldNotFound,
  rcsErrorReadingFromFieldStream,
  rcsIdentifierexpected,
  rcsstringexpected,
  rcsNumberexpected,
  rcsOperatorExpected,
  rcsFileNameRequired,
  rcsNone,
  rcsGeneral,
  rcsSAgeGroup,
  rcsSAgeType,
  rcsSum,
  rcsMin,
  rcsMax,
  rcsAvg,
  rcsStdDev,
  rcsSIniValue,
  rcsSIdentifier,
  rcsErrorIdenExpression,
  rcsAssignFunc,
  rcsAssignConst,
  rcsAssignfield,
  rcsNohelp,
  rcsNoaparams,
  rcsNomodel,
  rcsTrueHelp,
  rcsFalseHelp,
  rcsFieldHelp,
  rcsUpperCase,
  rcsPUpperCase,
  rcsLowerCase,
  rcsPLowerCase,
  rcsHourMinSec,
  rcsPHourMinSec,
  rcsFloatToDateTime,
  rcsPFloatToDateTime,
  rcsSin,
  rcsPSin,
  rcsRound,
  rcsPRound,
  rcsInt,
  rcsPInt,
  rcsStr,
  rcsPStr,
  rcsVal,
  rcsPVal,
  rcsTrim,
  rcsPtrim,
  rcsLeft,
  rcsPLeft,
  rcsPos,
  rcsPPos,
  rcsFileExists,
  rcsPFileExists,
  rcsAbs,
  rcsPAbs,
  rcsCompareValue,
  rcsPCompareValue,
  rcsNotAField,
  rcsNotBinary,
  rcsSQrt,
  rcsPSQRt,
  rcsMod,
  rcsPMod,
  rcsToday,
  rcsNow,
  rcsTimeH,
  rcsNull,
  rcsMonthName,
  rcsPMonthName,
  rcsEvalText,
  rcsPEvalText,
  rcsMonth,
  rcsPMonth,
  rcsYear,
  rcsPyear,
  rcsDay,
  rcsPDay,
  rcsRight,
  rcsPRight,
  rcsSubStr,
  rcsPSubStr,
  rcsFormatStr,
  rcsPFormatStr,
  rcsNumToText,
  rcsPNumToText,
  rcsConvertError,
  rcsInvalidBinary,
  rcsFieldDuplicated,
  rcsOperatorSum,
  rcsOperatorDif,
  rcsOperatorMul,
  rcsOperatorDiv,
  rcsOperatorComp,
  rcsOperatorLog,
  rcsOperatorDec,
  rcsOperatorDecM,
  rcsOperatorDecP,
  rcsOperatorSep,
  rcsOperatorSepP,
  rcsErrorOpenImp,
  rcsLength,
  rcsPLength,
  rcsPMax,
  rcsChsToCht,
  rcsChtToChs,
  rcsParameterExists,
  rcsCached,
  rcsIsInteger,
  rcsIsNumeric,
  rcsIsValidDateTime,
  rcsCheckExpression,
  rcsCachedFixed,
  rcsCachedVariable,
  rcsGetValueFromSQL,
  rcsGetValueFromSQLP,
  rcsFormatNum,
  rcsPFormatNum,
  rcsDataUnionNotFound,
  rcsCannotCombine,
  rcsSParamList,
  rcsSParamListDesc,
  rcsReplaceStr,
  rcsPReplaceStr,
  rcsParseParamsH,
  rcsSClearExpChart,
  rcsSBoolClearExp,
  rcsStreamFormat,
  rcsErrorFilter,
  rcsDecode64,
  rcsStringToBin,
  rcsLoadfile,
  rcsOK,
  rcsCancel,
  rcsExpCreator,
  rcsCategory,
  rcsOperation,
  rcsAddSelection,
  rcsSyntaxCheck,
  rcsShowresult,
  rcsDbFields,
  rcsFunctions,
  rcsVariables,
  rcsConstants,
  rcsOperators,
  rcsClear,
  rcsstringtotime,
  rcspstringtotime,
  rcsstringtodatetime,
  rcspstringtodatetime,
  rcstimetostring,
  rcsptimetostring,
  rcsdatetimetostring,
  rcspdatetimetostring,
  rcsdayofweek,
  rcspdayofweek
  );

const
 en_rcscaption: array[rcscaptionty] of msestring = (
  'Line too long',  //rcsLineTooLong
  'Expected %s',  //rcsExpected 
  'Can not set a value to a expression',  //rcssetexpression
  'Division by zero',  //rcsDivisioZero 
  'Syntax error',  //rcsEvalsyntax 
  'Type conversion error',  //rcsEvalType 
  'Invalid operation',  //rcsInvalidOperation 
  'Unknown identifier: ',  //rcsEvalDescIden 
  'Left side can not be assigned',  //rcsEvalDescIdenLeft
  'Parentesis error',  //rcsEvalParent 
  'Variable redefined',  //rcsVariabledefined 
  'Field not found: ',  //rcsFieldNotFound
  'Error reading from field stream',  //rcsErrorReadingFromFieldStream
  'Indentifier expected',  //rcsIdentifierexpected 
  'String expected',  //rcsstringexpected 
  'Number expected',  //rcsNumberexpected 
  'Operator expected',  //rcsOperatorExpected 
  'File name required',  //rcsFileNameRequired 
  'None',  //rcsNone
  'General',  //rcsGeneral
  'Ag.Group',  //rcsSAgeGroup
  'Ag.Type',  //rcsSAgeType
  'Sum',  //rcsSum
  'Min',  //rcsMin
  'Max',  //rcsMax
  'Average',  //rcsAvg
  'Std.Desv.',  //rcsStdDev
  'Ag.I.Value',  //rcsSIniValue
  'Identifier',  //rcsSIdentifier
  'Error expression item no assigned (idenexpression)',  //rcsErrorIdenExpression
  'Can not set a value to a function',  //rcsAssignFunc
  'Can not set a value to a constant',  //rcsAssignConst
  'Can not set a value to a field',  //rcsAssignfield
  'No help available',  //rcsNohelp
  'No parameters',  //rcsNoaparams
  'No model',  //rcsNomodel
  'A constant with True value',  //rcsTrueHelp
  'A constant with False value',  //rcsFalseHelp
  'Database field',  //rcsFieldHelp
  'Return the string in uppercase',  //rcsUpperCase
  's is the string to do uppercase',  //rcsPUpperCase
  'Returns the string in lowercase',  //rcsLowerCase
  's is the string to do lowercase',  //rcsPLowerCase
  'Converts a number to a time string hh:mm:ss',  //rcsHourMinSec
  'H represents hours, idenH is the conversion string '+#10+'for hours, idenM for minutes and '+#10+'idenS for seconds',  //rcsPHourMinSec
  'Converts a float to a datetime type',  //rcsFloatToDateTime
  'n is the number to convert',  //rcsPFloatToDateTime
  'Returns the sin of an angle',  //rcsSin
  'ang is expressed in radians',  //rcsPSin
  'Rounds to a multiple of a number.',  //rcsRound
  'num is the number to round and r i the multiplier',  //rcsPRound
  'Returns the integer part of a number',  //rcsInt
  'num is the number to obtain the int part.',  //rcsPInt
  'Converts a number to a string',  //rcsStr
  'num is the number to convert',  //rcsPStr
  'Converts a string to a number',  //rcsVal
  's is the string to convert',  //rcsPVal
  'Returns a string without spaces in right-left sides',  //rcsTrim
  's is the string to be trimmed',  //rcsPtrim
  'Returns the left side of a string',  //rcsLeft
  's is the source string,count is the number of chars to return',  //rcsPLeft
  'Returns the position index of a string inside another string (0 if not found)',  //rcsPos
  'SubStr is the substring to search for',  //rcsPPos
  'Returns true if the file exists',  //rcsFileExists
  's is filename to check',  //rcsPFileExists
  'Returns absolute value of a number.',  //rcsAbs
  'num is the number change sign',  //rcsPAbs
  'Returns -1 if first number is lower, 1 if first number is greater or zero if equal.',  //rcsCompareValue
  'num1 and num2 are numbers to compare, epsilon de diference tolerance',  //rcsPCompareValue
  'Not a field: ',  //rcsNotAField
  'Not a binary field: ',  //rcsNotBinary
  'The square of a number',  //rcsSQrt
  'num is the number to square',  //rcsPSQRt
  'Returns the module that is the rest of the integer division',  //rcsMod
  'd1 is the dividend d2 is the divisor',  //rcsPMod
  'Returns today date in datetime data type',  //rcsToday
  'Returns today and time in datetime data type',  //rcsNow
  'Returns the time in datetime datatype',  //rcsTimeH
  'Null',  //rcsNull
  'The name of the month in string',  //rcsMonthName
  'd es de date to be decoded',  //rcsPMonthName
  'Evals an expression, returns the evaluated result',  //rcsEvalText
  'expr is the expression to evaluate',  //rcsPEvalText
  'Returns the month number (1-12)',  //rcsMonth
  'd is the date to decode',  //rcsPMonth
  'Returns the year',  //rcsYear
  'd is the date to decode',  //rcsPyear
  'Returns the day',  //rcsDay
  'd is the date to decode',  //rcsPDay
  'Returns the right side of a string',  //rcsRight
  's is the source string and count is the number of characters to copy',  //rcsPRight
  'Returns a substring of a string',  //rcsSubStr
  'cadena is the sorce string, index is the index to copy from '+#10+' and count is the number of characters to copy',  //rcsPSubStr
  'Formats a string in diferent ways taking a picture of characters',  //rcsFormatStr
  'Format is the format string: ex.''dd/mm/yyyy'''+#10+' and v is the value to convert to a formated string',  //rcsPFormatStr
  'Text representation of a number',  //rcsNumToText
  'n is the number',  //rcsPNumToText
   'Type conversion error',  //rcsConvertError 
   'Invalid Binary',  //rcsInvalidBinary 
   'Duplicated field you must use the alias',  //rcsFieldDuplicated 
  'Sum operator',  //rcsOperatorSum
  'Substract operator',  //rcsOperatorDif
  'Multiply operator',  //rcsOperatorMul
  'Division operator',  //rcsOperatorDiv
  'Comparison operator',  //rcsOperatorComp
  'Logical operator',  //rcsOperatorLog
  'Decision operator',  //rcsOperatorDec
  'IIF(condition,action1,action2)',  //rcsOperatorDecM
  'Condition is a boolean expression, if it''s true the '+#10+' first parameter is executed, else the second is executed',  //rcsOperatorDecP
  'Separator operator',  //rcsOperatorSep
  'Is used to execute more than one expresión, the last is the result',  //rcsOperatorSepP
  'Error opening the printer ',  //rcsErrorOpenImp
  'Returns the length, in characters, of a string',  //rcsLength
  's is the source string',  //rcsPLength
  'Returns the maximum value',  //rcsPMax
  'Convert simplified to traditional Chinese',  //rcsChsToCht
  'Convert traditional to simplified Chinese',  //rcsChtToChs
  'Parameter already exists',  //rcsParameterExists
  'Shared Image',  //rcsCached
  'Returns true if the string is a valid integer',  //rcsIsInteger
  'Returns true if the string is a valid number',  //rcsIsNumeric
  'Returns true if the string is a valid date and time',  //rcsIsValidDateTime
  'Raises an exception with provided message if the expression is false',  //rcsCheckExpression
  'Fixed Image',  //rcsCachedFixed
  'Variable Image',  //rcsCachedVariable
  'Obtain a value from a sql sentence',  //rcsGetValueFromSQL
  'You use a connection name and a sql sentence that should return a value',  //rcsGetValueFromSQLP
  'Formats a number using a mask',  //rcsFormatNum
  'The mask can be like ##,##,##,##0.00',  //rcsPFormatNum
  'Data Union not found in Mybase',  //rcsDataUnionNotFound
  'Cannot combine-union a dataset to other dataset with fewer field number',  //rcsCannotCombine
  'Value list',  //rcsSParamList
  'Strings to show (left) and strings to assign (right)',  //rcsSParamListDesc
  'Replace a string within a string',  //rcsReplaceStr
  'x Replace a string within a string',  //rcsPReplaceStr
  ' -paramPARAMNAME=paramvalueAssign a value to a parameter',  //rcsParseParamsH
  'Clear expression',  //rcsSClearExpChart
  'Bool C.expression',  //rcsSBoolClearExp
  'Invalid Stream format',  //rcsStreamFormat
  'Error on filter',  //rcsErrorFilter
  'Decode base 64 string',  //rcsDecode64
  'Converts string to binary stream',  //rcsStringToBin
  'Loads a file inside a string',  //rcsLoadfile
  '&OK',   //rcsOK
  '&Cancel',   //rcsCancel
  'Expression Creator',   //rcsExpCreator
  'Category',   //rcsCategory
  'Operation',   //rcsOperation
  '&Add Selection',   //rcsAddSelection
  '&Syntax Check',   //rcsSyntaxCheck
  'Show &Result',   //rcsShowresult
  'Database Fields',   //rcsDbFields
  'Functions',   //rcsFunctions
  'Variables',   //rcsVariables
  'Constants',   //rcsConstants
  'Operators',   //rcsOperators
  '&Clear',   //rcsClear
  'Convert string to time',   //rcsstringtotime
  'string : time string',   //rcspstringtotime
  'Convert string to datetime',   //rcsstringtodatetime
  'string : datetime string',   //rcspstringtodatetime
  'Convert time to string',   //rcstimetostring
  'time : tdatetime',   //rcsptimetostring
  'Convert datetime to string',   //rcsdatetimetostring
  'datetime : tdatetime',   //rcspdatetimetostring
  'Convert datetime to day of the week',   //rcsdayofweek
  'datetime : tdatetime'   //rcspdayofweek
  );

 id_rcscaption: array[rcscaptionty] of msestring = (
  'Baris sangat panjang',  //rcsLineTooLong
  'Diharapkan %s',  //rcsExpected 
  'Nilai tidak bisa di set ke ekspresi',  //rcssetexpression
  'Pembagian dgn nol ',  //rcsDivisioZero 
  'Perintah salah',  //rcsEvalsyntax 
  'konversi type salah',  //rcsEvalType 
  'Operasi tdk benar',  //rcsInvalidOperation 
  'Persamaan tidak dikenal',  //rcsEvalDescIden 
  'Sisi kiri tidak dapat diterapkan',  //rcsEvalDescIdenLeft
  'tanda kurung salah',  //rcsEvalParent 
  'variabel didefinisika kembali',  //rcsVariabledefined 
  'field tdk ditemukan',  //rcsFieldNotFound
  'kesalahan membaca dari field stream',  //rcsErrorReadingFromFieldStream
  'Persamaan yang diharapkan',  //rcsIdentifierexpected 
  'string yang diharapkan',  //rcsstringexpected 
  'Angka yang diharapkan',  //rcsNumberexpected 
  'Operator yg diharapkan',  //rcsOperatorExpected 
  'Nama file yg dibutuhkan',  //rcsFileNameRequired 
  'Kosong / Tidak ada',  //rcsNone
  'Umum',  //rcsGeneral
  'Ag.Group',  //rcsSAgeGroup
  'Ag.Type',  //rcsSAgeType
  'JUmlah',  //rcsSum
  'Minimum',  //rcsMin
  'Maximum',  //rcsMax    
  'Rata-rata',  //rcsAvg
  'Std.Desv.',  //rcsStdDev
  'Ag.I.Value',  //rcsSIniValue
  'Identifier',  //rcsSIdentifier
  'kesalahan ekspresi, tidak diterapkan',  //rcsErrorIdenExpression
  'Tidak dapat menerapkan nilai utk fungsi',  //rcsAssignFunc
  'Tidak dapat menerapkan nilai untuk konstanta',  //rcsAssignConst
  'Tidak dapat menerapkan nilai untuk field',  //rcsAssignfield
  'Tidak ada bantuan yang tersedia',  //rcsNohelp
  'Tidak ada parameter',  //rcsNoaparams
  'Tidak ada model',  //rcsNomodel
  'Sebuah konstanta dengan nilai benar',  //rcsTrueHelp
  'Sebuah konstanta dengan nilai salah',  //rcsFalseHelp
  'Database field',  //rcsFieldHelp
  'mengembalikan string  menjadi huruf besar',  //rcsUpperCase
  ' adalah string didalam huruf besar',  //rcsPUpperCase
  'mengembalikan string didalam huruf kecil',  //rcsLowerCase
  ' adalah string untuk menjadi huruf kecil',  //rcsPLowerCase
  'Merubah angka ke string waktu hh:mm:ss',  //rcsHourMinSec
  'h untuk jam, h dikonversi menjadi '+#10+' untuk jam, m untuk menit dan '+ #10 + 's utk detik',  //rcsPHourMinSec
  'Merubah float menjadi datetime',  //rcsFloatToDateTime
  'n is the number to convert',  //rcsPFloatToDateTime
  'Returns the sin of an angle',  //rcsSin
  'ang is expressed in radians',  //rcsPSin
  'Rounds to a multiple of a number.',  //rcsRound
  'num is the number to round and r i the multiplier',  //rcsPRound
  'Returns the integer part of a number',  //rcsInt
  'num is the number to obtain the int part.',  //rcsPInt
  'Converts a number to a string',  //rcsStr
  'num is the number to convert',  //rcsPStr
  'Converts a string to a number',  //rcsVal
  's is the string to convert',  //rcsPVal
  'Returns a string without spaces in right-left sides',  //rcsTrim
  's is the string to be trimmed',  //rcsPtrim
  'Returns the left side of a string',  //rcsLeft
  's is the source string,count is the number of chars to return',  //rcsPLeft
  'Returns the position index of a string inside another string (0 if not found)',  //rcsPos
  'SubStr is the substring to search for',  //rcsPPos
  'Returns true if the file exists',  //rcsFileExists
  's is filename to check',  //rcsPFileExists
  'Returns absolute value of a number.',  //rcsAbs
  'num is the number change sign',  //rcsPAbs
  'Returns -1 if first number is lower, 1 if first number is greater or zero if equal.',  //rcsCompareValue
  'num1 and num2 are numbers to compare, epsilon de diference tolerance',  //rcsPCompareValue
  'Not a field: ',  //rcsNotAField
  'Not a binary field: ',  //rcsNotBinary
  'The square of a number',  //rcsSQrt
  'num is the number to square',  //rcsPSQRt
  'Returns the module that is the rest of the integer division',  //rcsMod
  'd1 is the dividend d2 is the divisor',  //rcsPMod
  'Returns today date in datetime data type',  //rcsToday
  'Returns today and time in datetime data type',  //rcsNow
  'Returns the time in datetime datatype',  //rcsTimeH
  'Null',  //rcsNull
  'The name of the month in string',  //rcsMonthName
  'd es de date to be decoded',  //rcsPMonthName
  'Evals an expression, returns the evaluated result',  //rcsEvalText
  'expr is the expression to evaluate',  //rcsPEvalText
  'Returns the month number (1-12)',  //rcsMonth
  'd is the date to decode',  //rcsPMonth
  'Returns the year',  //rcsYear
  'd is the date to decode',  //rcsPyear
  'Returns the day',  //rcsDay
  'd is the date to decode',  //rcsPDay
  'Returns the right side of a string',  //rcsRight
  's is the source string and count is the number of characters to copy',  //rcsPRight
  'Menghasilkan penggalan dari sebuah string',  //rcsSubStr
  'cadena is the sorce string, index is the index to copy from '+#10+' and count is the number of characters to copy',  //rcsPSubStr
  'Formats a string in diferent ways taking a picture of characters',  //rcsFormatStr
  'Format is the format string: ex.''dd/mm/yyyy'''+#10+' and v is the value to convert to a formated string',  //rcsPFormatStr
  'Menampilkan angka dalam bentuk kata (1=satu, 2=dua, dsb)',  //rcsNumToText
  'n is the number',  //rcsPNumToText
  'Type conversion error',  //rcsConvertError 
  'Invalid Binary',  //rcsInvalidBinary 
  'Duplicated field you must use the alias',  //rcsFieldDuplicated 
  'Sum operator',  //rcsOperatorSum
  'Substract operator',  //rcsOperatorDif
  'Multiply operator',  //rcsOperatorMul
  'Division operator',  //rcsOperatorDiv
  'Comparison operator',  //rcsOperatorComp
  'Logical operator',  //rcsOperatorLog
  'Decision operator',  //rcsOperatorDec
  'IIF(condition,action1,action2)',  //rcsOperatorDecM
  'Condition is a boolean expression, if it''s true the '+#10+' first parameter is executed, else the second is executed',  //rcsOperatorDecP
  'Separator operator',  //rcsOperatorSep
  'Is used to execute more than one expresión, the last is the result',  //rcsOperatorSepP
  'Error opening the printer ',  //rcsErrorOpenImp
  'Returns the length, in characters, of a string',  //rcsLength
  's is the source string',  //rcsPLength
  'Returns the maximum value',  //rcsPMax
  'Convert simplified to traditional Chinese',  //rcsChsToCht
  'Convert traditional to simplified Chinese',  //rcsChtToChs
  'Parameter already exists',  //rcsParameterExists
  'Shared Image',  //rcsCached
  'Returns true if the string is a valid integer',  //rcsIsInteger
  'Returns true if the string is a valid number',  //rcsIsNumeric
  'Returns true if the string is a valid date and time',  //rcsIsValidDateTime
  'Raises an exception with provided message if the expression is false',  //rcsCheckExpression
  'Fixed Image',  //rcsCachedFixed
  'Variable Image',  //rcsCachedVariable
  'Obtain a value from a sql sentence',  //rcsGetValueFromSQL
  'You use a connection name and a sql sentence that should return a value',  //rcsGetValueFromSQLP
  'Formats a number using a mask',  //rcsFormatNum
  'The mask can be like ##,##,##,##0.00',  //rcsPFormatNum
  'Data Union not found in Mybase',  //rcsDataUnionNotFound
  'Cannot combine-union a dataset to other dataset with fewer field number',  //rcsCannotCombine
  'Value list',  //rcsSParamList
  'Strings to show (left) and strings to assign (right)',  //rcsSParamListDesc
  'Replace a string within a string',  //rcsReplaceStr
  'x Replace a string within a string',  //rcsPReplaceStr
  ' -paramPARAMNAME=paramvalueAssign a value to a parameter',  //rcsParseParamsH
  'Clear expression',  //rcsSClearExpChart
  'Bool C.expression',  //rcsSBoolClearExp
  'Invalid Stream format',  //rcsStreamFormat
  'Error on filter',  //rcsErrorFilter
  'Decode base 64 string',  //rcsDecode64
  'Converts string to binary stream',  //rcsStringToBin
  'Loads a file inside a string',  //rcsLoadfile
  '&OK',   //rcsOK
  '&Cancel',   //rcsCancel
  'Expression Creator',   //rcsExpCreator
  '&Kategori',   //rcsCategory
  '&Operasi',   //rcsOperation
  '&Tambahkan',   //rcsAddSelection
  '&Cek Sintaks',   //rcsSyntaxCheck
  'Tampilkan &Hasil',   //rcsShowresult
  'Field Database',   //rcsDbFields
  'Fungsi-fungsi',   //rcsFunctions
  'Variable',   //rcsVariables
  'Konstanta',   //rcsConstants
  'Operator',   //rcsOperators
  '&Bersihkan',   //rcsClear
  'Konversi string ke time time',   //rcsstringtotime
  'string : time string',   //rcspstringtotime
  'Konversi string ke datetime',   //rcsstringtodatetime
  'string : datetime string',   //rcspstringtodatetime
  'Konversi time ke string',   //rcstimetostring
  'time : tdatetime',   //rcsptimetostring
  'Konversi datetime ke string',   //rcsdatetimetostring
  'datetime : tdatetime',   //rcspdatetimetostring
  'Konversi datetime ke hari dalam minggu',   //rcsdayofweek
  'datetime : tdatetime'   //rcspdayofweek
  );
implementation
initialization
 registeruserlangconsts('id',id_rcscaption);
 registeruserlangconsts('en',en_rcscaption);

end.
