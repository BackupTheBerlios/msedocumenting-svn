unit repazdialog_mfm;
{$ifdef FPC}{$mode objfpc}{$h+}{$endif}

interface

implementation
uses
 mseclasses,repazdialog;

const
 objdata: record size: integer; data: array[0..2753] of byte end =
      (size: 2754; data: (
  84,80,70,48,14,116,114,101,112,97,122,100,105,97,108,111,103,102,111,13,
  114,101,112,97,122,100,105,97,108,111,103,102,111,8,98,111,117,110,100,115,
  95,120,3,250,0,8,98,111,117,110,100,115,95,121,3,255,0,9,98,111,
  117,110,100,115,95,99,120,3,70,1,9,98,111,117,110,100,115,95,99,121,
  3,180,0,12,98,111,117,110,100,115,95,99,120,109,105,110,3,70,1,12,
  98,111,117,110,100,115,95,99,121,109,105,110,3,180,0,12,98,111,117,110,
  100,115,95,99,120,109,97,120,3,70,1,12,98,111,117,110,100,115,95,99,
  121,109,97,120,3,180,0,8,116,97,98,111,114,100,101,114,2,1,23,99,
  111,110,116,97,105,110,101,114,46,111,112,116,105,111,110,115,119,105,100,103,
  101,116,11,13,111,119,95,109,111,117,115,101,102,111,99,117,115,11,111,119,
  95,116,97,98,102,111,99,117,115,13,111,119,95,97,114,114,111,119,102,111,
  99,117,115,11,111,119,95,115,117,98,102,111,99,117,115,19,111,119,95,109,
  111,117,115,101,116,114,97,110,115,112,97,114,101,110,116,13,111,119,95,109,
  111,117,115,101,119,104,101,101,108,17,111,119,95,100,101,115,116,114,111,121,
  119,105,100,103,101,116,115,12,111,119,95,97,117,116,111,115,99,97,108,101,
  0,18,99,111,110,116,97,105,110,101,114,46,98,111,117,110,100,115,95,120,
  2,0,18,99,111,110,116,97,105,110,101,114,46,98,111,117,110,100,115,95,
  121,2,0,19,99,111,110,116,97,105,110,101,114,46,98,111,117,110,100,115,
  95,99,120,3,70,1,19,99,111,110,116,97,105,110,101,114,46,98,111,117,
  110,100,115,95,99,121,3,180,0,21,99,111,110,116,97,105,110,101,114,46,
  102,114,97,109,101,46,100,117,109,109,121,2,0,13,111,112,116,105,111,110,
  115,119,105,110,100,111,119,11,10,119,111,95,109,101,115,115,97,103,101,0,
  7,111,112,116,105,111,110,115,11,17,102,111,95,115,99,114,101,101,110,99,
  101,110,116,101,114,101,100,15,102,111,95,97,117,116,111,114,101,97,100,115,
  116,97,116,16,102,111,95,97,117,116,111,119,114,105,116,101,115,116,97,116,
  10,102,111,95,115,97,118,101,112,111,115,13,102,111,95,115,97,118,101,122,
  111,114,100,101,114,12,102,111,95,115,97,118,101,115,116,97,116,101,0,7,
  99,97,112,116,105,111,110,6,12,82,101,112,97,122,32,68,105,97,108,111,
  103,15,109,111,100,117,108,101,99,108,97,115,115,110,97,109,101,6,8,116,
  109,115,101,102,111,114,109,0,17,116,100,114,111,112,100,111,119,110,108,105,
  115,116,101,100,105,116,8,99,97,99,116,105,111,110,115,8,98,111,117,110,
  100,115,95,120,2,8,8,98,111,117,110,100,115,95,121,2,11,9,98,111,
  117,110,100,115,95,99,120,3,243,0,9,98,111,117,110,100,115,95,99,121,
  2,19,13,102,114,97,109,101,46,99,97,112,116,105,111,110,6,13,82,101,
  112,111,114,116,32,65,99,116,105,111,110,16,102,114,97,109,101,46,99,97,
  112,116,105,111,110,112,111,115,7,7,99,112,95,108,101,102,116,11,102,114,
  97,109,101,46,100,117,109,109,121,2,0,16,102,114,97,109,101,46,111,117,
  116,101,114,102,114,97,109,101,1,2,69,2,0,2,0,2,0,0,13,111,
  110,100,97,116,97,101,110,116,101,114,101,100,7,22,99,97,99,116,105,111,
  110,115,95,111,110,100,97,116,97,101,110,116,101,114,101,100,16,100,114,111,
  112,100,111,119,110,46,111,112,116,105,111,110,115,11,14,100,101,111,95,115,
  101,108,101,99,116,111,110,108,121,16,100,101,111,95,97,117,116,111,100,114,
  111,112,100,111,119,110,15,100,101,111,95,107,101,121,100,114,111,112,100,111,
  119,110,19,100,101,111,95,97,117,116,111,115,97,118,101,104,105,115,116,111,
  114,121,0,19,100,114,111,112,100,111,119,110,46,99,111,108,115,46,99,111,
  117,110,116,2,2,19,100,114,111,112,100,111,119,110,46,99,111,108,115,46,
  105,116,101,109,115,14,1,4,100,97,116,97,1,6,16,80,114,101,118,105,
  101,119,32,40,83,99,114,101,101,110,41,6,7,80,114,105,110,116,101,114,
  6,23,83,97,118,101,32,116,111,32,80,111,115,116,83,99,114,105,112,116,
  32,70,105,108,101,6,16,83,97,118,101,32,116,111,32,80,68,70,32,70,
  105,108,101,0,0,1,7,111,112,116,105,111,110,115,11,11,99,111,95,114,
  101,97,100,111,110,108,121,12,99,111,95,105,110,118,105,115,105,98,108,101,
  17,99,111,95,109,111,117,115,101,109,111,118,101,102,111,99,117,115,14,99,
  111,95,102,111,99,117,115,115,101,108,101,99,116,12,99,111,95,114,111,119,
  115,101,108,101,99,116,7,99,111,95,102,105,108,108,0,4,100,97,116,97,
  1,6,81,83,104,111,119,32,114,101,112,111,114,116,32,111,110,32,115,99,
  114,101,101,110,32,116,104,97,110,32,99,97,110,32,98,101,32,112,114,105,
  110,116,32,111,110,32,112,114,105,110,116,101,114,44,32,115,97,118,101,32,
  116,111,32,80,111,115,116,115,99,114,105,112,116,44,32,80,68,70,44,32,
  101,116,99,46,6,71,80,114,105,110,116,32,114,101,112,111,114,116,32,111,
  110,32,103,101,110,101,114,97,108,32,112,114,105,110,116,101,114,32,108,105,
  107,101,32,76,97,115,101,114,74,101,116,44,32,73,110,107,74,101,116,44,
  32,68,111,116,32,77,97,116,114,105,120,44,32,101,116,99,46,6,104,83,
  97,118,101,32,116,111,32,80,111,115,116,83,99,114,105,112,116,32,102,105,
  108,101,32,97,110,100,32,116,104,97,110,32,99,97,110,32,112,114,105,110,
  116,32,116,104,97,116,32,105,115,32,115,117,112,112,111,114,116,32,80,111,
  115,116,83,99,114,105,112,116,32,111,114,32,99,111,110,118,101,114,116,32,
  116,111,32,97,110,111,116,104,101,114,32,102,105,108,101,32,102,111,114,109,
  97,116,46,6,126,83,97,118,101,32,116,111,32,80,68,70,32,40,80,111,
  114,116,97,98,108,101,32,68,111,99,117,109,101,110,116,32,70,111,114,109,
  97,116,41,32,102,105,108,101,32,97,110,100,32,116,104,97,110,32,99,97,
  110,32,98,101,32,118,105,101,119,101,100,32,119,105,116,104,32,80,68,70,
  32,82,101,97,100,101,114,32,65,112,112,108,105,99,97,116,105,111,110,32,
  108,105,107,101,32,65,100,111,98,101,32,65,99,114,111,98,97,116,32,82,
  101,97,100,101,114,44,32,101,116,99,46,0,0,0,13,114,101,102,102,111,
  110,116,104,101,105,103,104,116,2,13,0,0,9,116,103,114,111,117,112,98,
  111,120,10,116,103,114,111,117,112,98,111,120,49,8,98,111,117,110,100,115,
  95,120,2,6,8,98,111,117,110,100,115,95,121,2,40,9,98,111,117,110,
  100,115,95,99,120,3,246,0,9,98,111,117,110,100,115,95,99,121,2,102,
  13,102,114,97,109,101,46,99,97,112,116,105,111,110,6,11,68,101,115,99,
  114,105,112,116,105,111,110,11,102,114,97,109,101,46,100,117,109,109,121,2,
  0,16,102,114,97,109,101,46,111,117,116,101,114,102,114,97,109,101,1,2,
  0,2,7,2,0,2,0,0,8,116,97,98,111,114,100,101,114,2,2,0,
  6,116,108,97,98,101,108,12,99,100,101,115,99,114,105,112,116,105,111,110,
  13,111,112,116,105,111,110,115,119,105,100,103,101,116,11,17,111,119,95,100,
  101,115,116,114,111,121,119,105,100,103,101,116,115,18,111,119,95,102,111,110,
  116,103,108,121,112,104,104,101,105,103,104,116,12,111,119,95,97,117,116,111,
  115,99,97,108,101,0,8,98,111,117,110,100,115,95,120,2,6,8,98,111,
  117,110,100,115,95,121,2,20,9,98,111,117,110,100,115,95,99,120,3,234,
  0,9,98,111,117,110,100,115,95,99,121,2,71,9,116,101,120,116,102,108,
  97,103,115,11,12,116,102,95,119,111,114,100,98,114,101,97,107,0,13,114,
  101,102,102,111,110,116,104,101,105,103,104,116,2,13,0,0,0,12,116,98,
  111,111,108,101,97,110,101,100,105,116,9,115,104,111,119,97,103,97,105,110,
  8,98,111,117,110,100,115,95,120,2,6,8,98,111,117,110,100,115,95,121,
  3,152,0,9,98,111,117,110,100,115,95,99,120,3,4,1,9,98,111,117,
  110,100,115,95,99,121,2,15,13,102,114,97,109,101,46,99,97,112,116,105,
  111,110,6,51,83,38,104,111,119,32,116,104,105,115,32,100,105,97,108,111,
  103,32,97,103,97,105,110,32,101,118,101,114,121,32,101,120,101,99,117,116,
  101,32,114,101,112,111,114,116,32,97,99,116,105,111,110,11,102,114,97,109,
  101,46,100,117,109,109,121,2,0,16,102,114,97,109,101,46,111,117,116,101,
  114,102,114,97,109,101,1,2,0,2,1,3,247,0,2,1,0,8,116,97,
  98,111,114,100,101,114,2,1,5,118,97,108,117,101,9,0,0,7,116,98,
  117,116,116,111,110,10,98,116,110,115,101,116,116,105,110,103,8,98,111,117,
  110,100,115,95,120,3,2,1,8,98,111,117,110,100,115,95,121,2,11,9,
  98,111,117,110,100,115,95,99,120,2,60,9,98,111,117,110,100,115,95,99,
  121,2,19,8,116,97,98,111,114,100,101,114,2,3,5,115,116,97,116,101,
  11,15,97,115,95,108,111,99,97,108,99,97,112,116,105,111,110,0,7,99,
  97,112,116,105,111,110,6,8,83,101,38,116,116,105,110,103,0,0,7,116,
  98,117,116,116,111,110,5,98,116,110,111,107,13,111,112,116,105,111,110,115,
  119,105,100,103,101,116,11,13,111,119,95,109,111,117,115,101,102,111,99,117,
  115,11,111,119,95,116,97,98,102,111,99,117,115,13,111,119,95,97,114,114,
  111,119,102,111,99,117,115,17,111,119,95,100,101,115,116,114,111,121,119,105,
  100,103,101,116,115,18,111,119,95,102,111,110,116,103,108,121,112,104,104,101,
  105,103,104,116,12,111,119,95,97,117,116,111,115,99,97,108,101,0,8,98,
  111,117,110,100,115,95,120,3,2,1,8,98,111,117,110,100,115,95,121,2,
  48,9,98,111,117,110,100,115,95,99,120,2,60,9,98,111,117,110,100,115,
  95,99,121,2,19,7,97,110,99,104,111,114,115,11,6,97,110,95,116,111,
  112,8,97,110,95,114,105,103,104,116,0,8,116,97,98,111,114,100,101,114,
  2,4,5,115,116,97,116,101,11,10,97,115,95,100,101,102,97,117,108,116,
  15,97,115,95,108,111,99,97,108,100,101,102,97,117,108,116,15,97,115,95,
  108,111,99,97,108,99,97,112,116,105,111,110,0,7,99,97,112,116,105,111,
  110,6,3,38,79,75,11,109,111,100,97,108,114,101,115,117,108,116,7,5,
  109,114,95,111,107,13,114,101,102,102,111,110,116,104,101,105,103,104,116,2,
  13,0,0,7,116,98,117,116,116,111,110,9,98,116,110,99,97,110,99,101,
  108,13,111,112,116,105,111,110,115,119,105,100,103,101,116,11,13,111,119,95,
  109,111,117,115,101,102,111,99,117,115,11,111,119,95,116,97,98,102,111,99,
  117,115,13,111,119,95,97,114,114,111,119,102,111,99,117,115,17,111,119,95,
  100,101,115,116,114,111,121,119,105,100,103,101,116,115,18,111,119,95,102,111,
  110,116,103,108,121,112,104,104,101,105,103,104,116,12,111,119,95,97,117,116,
  111,115,99,97,108,101,0,8,98,111,117,110,100,115,95,120,3,2,1,8,
  98,111,117,110,100,115,95,121,2,73,9,98,111,117,110,100,115,95,99,120,
  2,60,9,98,111,117,110,100,115,95,99,121,2,19,7,97,110,99,104,111,
  114,115,11,6,97,110,95,116,111,112,8,97,110,95,114,105,103,104,116,0,
  8,116,97,98,111,114,100,101,114,2,5,5,115,116,97,116,101,11,15,97,
  115,95,108,111,99,97,108,99,97,112,116,105,111,110,0,7,99,97,112,116,
  105,111,110,6,7,38,67,97,110,99,101,108,11,109,111,100,97,108,114,101,
  115,117,108,116,7,9,109,114,95,99,97,110,99,101,108,13,114,101,102,102,
  111,110,116,104,101,105,103,104,116,2,13,0,0,0)
 );

initialization
 registerobjectdata(@objdata,trepazdialogfo,'');
end.
