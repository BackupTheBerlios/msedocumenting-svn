unit main_mfm;
{$ifdef FPC}{$mode objfpc}{$h+}{$INTERFACES CORBA}{$endif}

interface

implementation
uses
 mseclasses,main;

const
 objdata: record size: integer; data: array[0..2601] of byte end =
      (size: 2602; data: (
  84,80,70,48,7,116,109,97,105,110,102,111,6,109,97,105,110,102,111,13,
  111,112,116,105,111,110,115,119,105,100,103,101,116,11,13,111,119,95,97,114,
  114,111,119,102,111,99,117,115,11,111,119,95,115,117,98,102,111,99,117,115,
  17,111,119,95,100,101,115,116,114,111,121,119,105,100,103,101,116,115,9,111,
  119,95,104,105,110,116,111,110,12,111,119,95,97,117,116,111,115,99,97,108,
  101,0,8,98,111,117,110,100,115,95,120,3,35,1,8,98,111,117,110,100,
  115,95,121,3,247,0,9,98,111,117,110,100,115,95,99,120,3,52,1,9,
  98,111,117,110,100,115,95,99,121,3,24,1,8,116,97,98,111,114,100,101,
  114,2,1,23,99,111,110,116,97,105,110,101,114,46,111,112,116,105,111,110,
  115,119,105,100,103,101,116,11,13,111,119,95,109,111,117,115,101,102,111,99,
  117,115,11,111,119,95,116,97,98,102,111,99,117,115,13,111,119,95,97,114,
  114,111,119,102,111,99,117,115,11,111,119,95,115,117,98,102,111,99,117,115,
  19,111,119,95,109,111,117,115,101,116,114,97,110,115,112,97,114,101,110,116,
  17,111,119,95,100,101,115,116,114,111,121,119,105,100,103,101,116,115,12,111,
  119,95,97,117,116,111,115,99,97,108,101,0,18,99,111,110,116,97,105,110,
  101,114,46,98,111,117,110,100,115,95,120,2,0,18,99,111,110,116,97,105,
  110,101,114,46,98,111,117,110,100,115,95,121,2,0,19,99,111,110,116,97,
  105,110,101,114,46,98,111,117,110,100,115,95,99,120,3,52,1,19,99,111,
  110,116,97,105,110,101,114,46,98,111,117,110,100,115,95,99,121,3,24,1,
  21,99,111,110,116,97,105,110,101,114,46,102,114,97,109,101,46,100,117,109,
  109,121,2,0,13,111,112,116,105,111,110,115,119,105,110,100,111,119,11,14,
  119,111,95,103,114,111,117,112,108,101,97,100,101,114,0,7,111,112,116,105,
  111,110,115,11,7,102,111,95,109,97,105,110,19,102,111,95,116,101,114,109,
  105,110,97,116,101,111,110,99,108,111,115,101,15,102,111,95,97,117,116,111,
  114,101,97,100,115,116,97,116,16,102,111,95,97,117,116,111,119,114,105,116,
  101,115,116,97,116,10,102,111,95,115,97,118,101,112,111,115,12,102,111,95,
  115,97,118,101,115,116,97,116,101,0,15,109,111,100,117,108,101,99,108,97,
  115,115,110,97,109,101,6,8,116,109,115,101,102,111,114,109,0,12,116,100,
  98,110,97,118,105,103,97,116,111,114,13,116,100,98,110,97,118,105,103,97,
  116,111,114,49,13,111,112,116,105,111,110,115,119,105,100,103,101,116,11,17,
  111,119,95,100,101,115,116,114,111,121,119,105,100,103,101,116,115,12,111,119,
  95,97,117,116,111,115,99,97,108,101,11,111,119,95,97,117,116,111,115,105,
  122,101,0,8,98,111,117,110,100,115,95,120,2,8,8,98,111,117,110,100,
  115,95,121,2,0,9,98,111,117,110,100,115,95,99,120,3,32,1,11,102,
  114,97,109,101,46,100,117,109,109,121,2,0,10,100,97,116,97,115,111,117,
  114,99,101,7,15,116,109,115,101,100,97,116,97,115,111,117,114,99,101,49,
  14,118,105,115,105,98,108,101,98,117,116,116,111,110,115,11,10,100,98,110,
  98,95,102,105,114,115,116,10,100,98,110,98,95,112,114,105,111,114,9,100,
  98,110,98,95,110,101,120,116,9,100,98,110,98,95,108,97,115,116,11,100,
  98,110,98,95,105,110,115,101,114,116,11,100,98,110,98,95,100,101,108,101,
  116,101,9,100,98,110,98,95,101,100,105,116,9,100,98,110,98,95,112,111,
  115,116,11,100,98,110,98,95,99,97,110,99,101,108,11,100,98,110,98,95,
  102,105,108,116,101,114,16,100,98,110,98,95,102,105,108,116,101,114,111,110,
  111,102,102,9,100,98,110,98,95,102,105,110,100,0,0,0,13,116,100,98,
  119,105,100,103,101,116,103,114,105,100,14,116,100,98,119,105,100,103,101,116,
  103,114,105,100,49,13,111,112,116,105,111,110,115,119,105,100,103,101,116,11,
  13,111,119,95,109,111,117,115,101,102,111,99,117,115,11,111,119,95,116,97,
  98,102,111,99,117,115,13,111,119,95,97,114,114,111,119,102,111,99,117,115,
  17,111,119,95,102,111,99,117,115,98,97,99,107,111,110,101,115,99,13,111,
  119,95,109,111,117,115,101,119,104,101,101,108,17,111,119,95,100,101,115,116,
  114,111,121,119,105,100,103,101,116,115,18,111,119,95,102,111,110,116,103,108,
  121,112,104,104,101,105,103,104,116,12,111,119,95,97,117,116,111,115,99,97,
  108,101,0,8,98,111,117,110,100,115,95,120,2,8,8,98,111,117,110,100,
  115,95,121,2,32,9,98,111,117,110,100,115,95,99,120,3,34,1,9,98,
  111,117,110,100,115,95,99,121,3,242,0,11,102,114,97,109,101,46,100,117,
  109,109,121,2,0,8,116,97,98,111,114,100,101,114,2,1,10,100,97,116,
  97,115,111,117,114,99,101,7,15,116,109,115,101,100,97,116,97,115,111,117,
  114,99,101,49,11,111,112,116,105,111,110,115,103,114,105,100,11,15,111,103,
  95,114,111,119,105,110,115,101,114,116,105,110,103,14,111,103,95,114,111,119,
  100,101,108,101,116,105,110,103,19,111,103,95,102,111,99,117,115,99,101,108,
  108,111,110,101,110,116,101,114,15,111,103,95,97,117,116,111,102,105,114,115,
  116,114,111,119,13,111,103,95,97,117,116,111,97,112,112,101,110,100,20,111,
  103,95,99,111,108,99,104,97,110,103,101,111,110,116,97,98,107,101,121,12,
  111,103,95,97,117,116,111,112,111,112,117,112,17,111,103,95,109,111,117,115,
  101,115,99,114,111,108,108,99,111,108,0,13,102,105,120,99,111,108,115,46,
  99,111,117,110,116,2,1,13,102,105,120,99,111,108,115,46,105,116,101,109,
  115,14,1,5,119,105,100,116,104,2,15,0,0,13,102,105,120,114,111,119,
  115,46,99,111,117,110,116,2,1,13,102,105,120,114,111,119,115,46,105,116,
  101,109,115,14,1,6,104,101,105,103,104,116,2,16,0,0,14,100,97,116,
  97,99,111,108,115,46,99,111,117,110,116,2,1,16,100,97,116,97,99,111,
  108,115,46,111,112,116,105,111,110,115,11,7,99,111,95,102,105,108,108,12,
  99,111,95,115,97,118,101,118,97,108,117,101,12,99,111,95,115,97,118,101,
  115,116,97,116,101,10,99,111,95,114,111,119,102,111,110,116,11,99,111,95,
  114,111,119,99,111,108,111,114,13,99,111,95,122,101,98,114,97,99,111,108,
  111,114,17,99,111,95,109,111,117,115,101,115,99,114,111,108,108,114,111,119,
  0,14,100,97,116,97,99,111,108,115,46,105,116,101,109,115,14,1,5,119,
  105,100,116,104,3,254,0,7,111,112,116,105,111,110,115,11,7,99,111,95,
  102,105,108,108,12,99,111,95,115,97,118,101,118,97,108,117,101,12,99,111,
  95,115,97,118,101,115,116,97,116,101,10,99,111,95,114,111,119,102,111,110,
  116,11,99,111,95,114,111,119,99,111,108,111,114,13,99,111,95,122,101,98,
  114,97,99,111,108,111,114,17,99,111,95,109,111,117,115,101,115,99,114,111,
  108,108,114,111,119,0,10,119,105,100,103,101,116,110,97,109,101,6,14,116,
  100,98,115,116,114,105,110,103,101,100,105,116,49,0,0,13,100,97,116,97,
  114,111,119,104,101,105,103,104,116,2,16,13,114,101,102,102,111,110,116,104,
  101,105,103,104,116,2,14,0,13,116,100,98,115,116,114,105,110,103,101,100,
  105,116,14,116,100,98,115,116,114,105,110,103,101,100,105,116,49,13,111,112,
  116,105,111,110,115,119,105,100,103,101,116,11,13,111,119,95,109,111,117,115,
  101,102,111,99,117,115,11,111,119,95,116,97,98,102,111,99,117,115,13,111,
  119,95,97,114,114,111,119,102,111,99,117,115,17,111,119,95,100,101,115,116,
  114,111,121,119,105,100,103,101,116,115,18,111,119,95,102,111,110,116,103,108,
  121,112,104,104,101,105,103,104,116,0,8,98,111,117,110,100,115,95,120,2,
  0,8,98,111,117,110,100,115,95,121,2,0,9,98,111,117,110,100,115,95,
  99,120,3,254,0,9,98,111,117,110,100,115,95,99,121,2,16,12,102,114,
  97,109,101,46,108,101,118,101,108,111,2,0,17,102,114,97,109,101,46,99,
  111,108,111,114,99,108,105,101,110,116,4,3,0,0,128,16,102,114,97,109,
  101,46,108,111,99,97,108,112,114,111,112,115,11,10,102,114,108,95,108,101,
  118,101,108,111,10,102,114,108,95,108,101,118,101,108,105,15,102,114,108,95,
  99,111,108,111,114,99,108,105,101,110,116,0,11,102,114,97,109,101,46,100,
  117,109,109,121,2,0,8,116,97,98,111,114,100,101,114,2,1,7,118,105,
  115,105,98,108,101,8,9,100,97,116,97,102,105,101,108,100,6,5,116,101,
  120,116,49,10,100,97,116,97,115,111,117,114,99,101,7,15,116,109,115,101,
  100,97,116,97,115,111,117,114,99,101,49,13,114,101,102,102,111,110,116,104,
  101,105,103,104,116,2,14,0,0,0,12,116,109,115,101,115,113,108,113,117,
  101,114,121,13,116,109,115,101,115,113,108,113,117,101,114,121,49,11,108,111,
  103,102,105,108,101,110,97,109,101,6,7,116,101,115,116,46,100,98,16,105,
  110,100,101,120,108,111,99,97,108,46,99,111,117,110,116,2,1,16,105,110,
  100,101,120,108,111,99,97,108,46,105,116,101,109,115,14,1,12,102,105,101,
  108,100,115,46,99,111,117,110,116,2,1,12,102,105,101,108,100,115,46,105,
  116,101,109,115,14,1,9,102,105,101,108,100,110,97,109,101,6,5,116,101,
  120,116,49,7,111,112,116,105,111,110,115,11,19,105,102,111,95,99,97,115,
  101,105,110,115,101,110,115,105,116,105,118,101,0,0,0,6,97,99,116,105,
  118,101,9,0,0,19,98,101,102,111,114,101,101,110,100,102,105,108,116,101,
  114,101,100,105,116,7,14,98,101,102,101,110,100,102,105,108,116,101,114,101,
  100,18,97,102,116,101,114,101,110,100,102,105,108,116,101,114,101,100,105,116,
  7,16,97,102,116,101,114,101,110,100,102,105,108,116,101,114,101,100,6,112,
  97,114,97,109,115,14,0,9,73,110,100,101,120,68,101,102,115,14,0,6,
  65,99,116,105,118,101,9,14,79,110,70,105,108,116,101,114,82,101,99,111,
  114,100,7,9,102,105,108,116,101,114,114,101,99,9,70,105,101,108,100,68,
  101,102,115,14,1,4,78,97,109,101,6,5,116,101,120,116,49,8,68,97,
  116,97,84,121,112,101,7,8,102,116,83,116,114,105,110,103,4,83,105,122,
  101,2,50,0,0,18,99,111,110,116,114,111,108,108,101,114,46,111,112,116,
  105,111,110,115,11,9,100,115,111,95,108,111,99,97,108,0,4,108,101,102,
  116,2,16,3,116,111,112,3,184,0,0,15,116,109,115,101,115,116,114,105,
  110,103,102,105,101,108,100,7,116,101,120,116,49,102,105,12,68,105,115,112,
  108,97,121,87,105,100,116,104,2,50,9,70,105,101,108,100,78,97,109,101,
  6,5,116,101,120,116,49,4,83,105,122,101,2,50,4,108,101,102,116,2,
  24,3,116,111,112,3,240,0,0,0,0,14,116,109,115,101,100,97,116,97,
  115,111,117,114,99,101,15,116,109,115,101,100,97,116,97,115,111,117,114,99,
  101,49,7,68,97,116,97,83,101,116,7,13,116,109,115,101,115,113,108,113,
  117,101,114,121,49,4,108,101,102,116,2,16,3,116,111,112,3,208,0,0,
  0,0)
 );

initialization
 registerobjectdata(@objdata,tmainfo,'');
end.
