unit main_mfm;
{$ifdef FPC}{$mode objfpc}{$h+}{$endif}

interface

implementation
uses
 mseclasses,main;

const
 objdata: record size: integer; data: array[0..5051] of byte end =
      (size: 5052; data: (
  84,80,70,48,7,116,109,97,105,110,102,111,6,109,97,105,110,102,111,13,
  111,112,116,105,111,110,115,119,105,100,103,101,116,11,13,111,119,95,97,114,
  114,111,119,102,111,99,117,115,11,111,119,95,115,117,98,102,111,99,117,115,
  17,111,119,95,100,101,115,116,114,111,121,119,105,100,103,101,116,115,9,111,
  119,95,104,105,110,116,111,110,12,111,119,95,97,117,116,111,115,99,97,108,
  101,0,8,98,111,117,110,100,115,95,120,3,77,1,8,98,111,117,110,100,
  115,95,121,3,202,0,9,98,111,117,110,100,115,95,99,120,3,212,1,9,
  98,111,117,110,100,115,95,99,121,3,217,1,8,116,97,98,111,114,100,101,
  114,2,1,9,112,111,112,117,112,109,101,110,117,7,16,112,111,112,117,112,
  65,116,116,97,99,104,109,101,110,116,115,23,99,111,110,116,97,105,110,101,
  114,46,111,112,116,105,111,110,115,119,105,100,103,101,116,11,13,111,119,95,
  109,111,117,115,101,102,111,99,117,115,11,111,119,95,116,97,98,102,111,99,
  117,115,13,111,119,95,97,114,114,111,119,102,111,99,117,115,11,111,119,95,
  115,117,98,102,111,99,117,115,19,111,119,95,109,111,117,115,101,116,114,97,
  110,115,112,97,114,101,110,116,17,111,119,95,100,101,115,116,114,111,121,119,
  105,100,103,101,116,115,12,111,119,95,97,117,116,111,115,99,97,108,101,0,
  18,99,111,110,116,97,105,110,101,114,46,98,111,117,110,100,115,95,120,2,
  0,18,99,111,110,116,97,105,110,101,114,46,98,111,117,110,100,115,95,121,
  2,21,19,99,111,110,116,97,105,110,101,114,46,98,111,117,110,100,115,95,
  99,120,3,212,1,19,99,111,110,116,97,105,110,101,114,46,98,111,117,110,
  100,115,95,99,121,3,196,1,21,99,111,110,116,97,105,110,101,114,46,102,
  114,97,109,101,46,100,117,109,109,121,2,0,13,111,112,116,105,111,110,115,
  119,105,110,100,111,119,11,14,119,111,95,103,114,111,117,112,108,101,97,100,
  101,114,0,8,109,97,105,110,109,101,110,117,7,11,97,112,112,77,97,105,
  110,77,101,110,117,7,111,112,116,105,111,110,115,11,7,102,111,95,109,97,
  105,110,19,102,111,95,116,101,114,109,105,110,97,116,101,111,110,99,108,111,
  115,101,15,102,111,95,97,117,116,111,114,101,97,100,115,116,97,116,16,102,
  111,95,97,117,116,111,119,114,105,116,101,115,116,97,116,10,102,111,95,115,
  97,118,101,112,111,115,12,102,111,95,115,97,118,101,115,116,97,116,101,0,
  8,111,110,99,114,101,97,116,101,7,6,100,111,73,110,105,116,9,111,110,
  100,101,115,116,114,111,121,7,8,100,111,70,105,110,105,115,104,12,111,110,
  99,108,111,115,101,113,117,101,114,121,7,13,99,104,101,99,107,70,111,114,
  67,108,111,115,101,15,109,111,100,117,108,101,99,108,97,115,115,110,97,109,
  101,6,8,116,109,115,101,102,111,114,109,0,9,116,103,114,111,117,112,98,
  111,120,10,116,103,114,111,117,112,98,111,120,49,8,98,111,117,110,100,115,
  95,120,2,8,8,98,111,117,110,100,115,95,121,2,6,9,98,111,117,110,
  100,115,95,99,120,3,218,0,9,98,111,117,110,100,115,95,99,121,3,140,
  0,13,102,114,97,109,101,46,99,97,112,116,105,111,110,6,10,67,111,110,
  110,101,99,116,105,111,110,11,102,114,97,109,101,46,100,117,109,109,121,2,
  0,16,102,114,97,109,101,46,111,117,116,101,114,102,114,97,109,101,1,2,
  0,2,10,2,0,2,0,0,7,97,110,99,104,111,114,115,11,7,97,110,
  95,108,101,102,116,6,97,110,95,116,111,112,8,97,110,95,114,105,103,104,
  116,9,97,110,95,98,111,116,116,111,109,0,0,11,116,115,116,114,105,110,
  103,101,100,105,116,10,115,109,116,112,83,101,114,118,101,114,8,98,111,117,
  110,100,115,95,120,2,8,8,98,111,117,110,100,115,95,121,2,22,9,98,
  111,117,110,100,115,95,99,120,3,204,0,9,98,111,117,110,100,115,95,99,
  121,2,25,13,102,114,97,109,101,46,99,97,112,116,105,111,110,6,6,83,
  101,114,118,101,114,16,102,114,97,109,101,46,99,97,112,116,105,111,110,112,
  111,115,7,7,99,112,95,108,101,102,116,11,102,114,97,109,101,46,100,117,
  109,109,121,2,0,16,102,114,97,109,101,46,111,117,116,101,114,102,114,97,
  109,101,1,2,56,2,0,2,0,2,0,0,13,114,101,102,102,111,110,116,
  104,101,105,103,104,116,2,19,0,0,12,116,105,110,116,101,103,101,114,101,
  100,105,116,8,115,109,116,112,80,111,114,116,8,98,111,117,110,100,115,95,
  120,2,28,8,98,111,117,110,100,115,95,121,2,54,9,98,111,117,110,100,
  115,95,99,120,2,88,9,98,111,117,110,100,115,95,99,121,2,25,13,102,
  114,97,109,101,46,99,97,112,116,105,111,110,6,4,80,111,114,116,16,102,
  114,97,109,101,46,99,97,112,116,105,111,110,112,111,115,7,7,99,112,95,
  108,101,102,116,11,102,114,97,109,101,46,100,117,109,109,121,2,0,16,102,
  114,97,109,101,46,111,117,116,101,114,102,114,97,109,101,1,2,36,2,0,
  2,0,2,0,0,8,116,97,98,111,114,100,101,114,2,1,5,118,97,108,
  117,101,2,25,6,115,118,97,108,117,101,6,2,50,53,13,114,101,102,102,
  111,110,116,104,101,105,103,104,116,2,19,0,0,7,116,98,117,116,116,111,
  110,10,98,116,110,67,111,110,110,101,99,116,8,98,111,117,110,100,115,95,
  120,2,8,8,98,111,117,110,100,115,95,121,2,106,9,98,111,117,110,100,
  115,95,99,120,2,82,9,98,111,117,110,100,115,95,99,121,2,25,8,116,
  97,98,111,114,100,101,114,2,2,5,115,116,97,116,101,11,15,97,115,95,
  108,111,99,97,108,99,97,112,116,105,111,110,17,97,115,95,108,111,99,97,
  108,111,110,101,120,101,99,117,116,101,0,7,99,97,112,116,105,111,110,6,
  7,67,111,110,110,101,99,116,9,111,110,101,120,101,99,117,116,101,7,9,
  100,111,67,111,110,110,101,99,116,0,0,7,116,98,117,116,116,111,110,7,
  98,116,110,65,117,116,104,8,98,111,117,110,100,115,95,120,2,96,8,98,
  111,117,110,100,115,95,121,2,106,9,98,111,117,110,100,115,95,99,120,2,
  114,9,98,111,117,110,100,115,95,99,121,2,25,8,116,97,98,111,114,100,
  101,114,2,3,5,115,116,97,116,101,11,12,97,115,95,105,110,118,105,115,
  105,98,108,101,17,97,115,95,108,111,99,97,108,105,110,118,105,115,105,98,
  108,101,15,97,115,95,108,111,99,97,108,99,97,112,116,105,111,110,17,97,
  115,95,108,111,99,97,108,111,110,101,120,101,99,117,116,101,0,7,99,97,
  112,116,105,111,110,6,12,65,117,116,104,101,110,116,105,99,97,116,101,9,
  111,110,101,120,101,99,117,116,101,7,6,100,111,65,117,116,104,0,0,12,
  116,98,111,111,108,101,97,110,101,100,105,116,6,117,115,101,83,83,76,8,
  98,111,117,110,100,115,95,120,3,128,0,8,98,111,117,110,100,115,95,121,
  2,50,9,98,111,117,110,100,115,95,99,120,2,80,9,98,111,117,110,100,
  115,95,99,121,2,21,13,102,114,97,109,101,46,99,97,112,116,105,111,110,
  6,7,85,115,101,32,83,83,76,11,102,114,97,109,101,46,100,117,109,109,
  121,2,0,16,102,114,97,109,101,46,111,117,116,101,114,102,114,97,109,101,
  1,2,0,2,4,2,67,2,4,0,8,116,97,98,111,114,100,101,114,2,
  4,13,111,110,100,97,116,97,101,110,116,101,114,101,100,7,8,99,104,101,
  99,107,83,83,76,0,0,7,116,98,117,116,116,111,110,6,98,116,110,84,
  76,83,8,98,111,117,110,100,115,95,120,3,128,0,8,98,111,117,110,100,
  115,95,121,2,74,9,98,111,117,110,100,115,95,99,120,2,82,9,98,111,
  117,110,100,115,95,99,121,2,25,8,116,97,98,111,114,100,101,114,2,5,
  5,115,116,97,116,101,11,15,97,115,95,108,111,99,97,108,99,97,112,116,
  105,111,110,17,97,115,95,108,111,99,97,108,111,110,101,120,101,99,117,116,
  101,0,7,99,97,112,116,105,111,110,6,3,84,76,83,9,111,110,101,120,
  101,99,117,116,101,7,8,115,116,97,114,116,84,76,83,0,0,0,9,116,
  103,114,111,117,112,98,111,120,10,116,103,114,111,117,112,98,111,120,50,8,
  98,111,117,110,100,115,95,120,3,240,0,8,98,111,117,110,100,115,95,121,
  2,6,9,98,111,117,110,100,115,95,99,120,3,218,0,9,98,111,117,110,
  100,115,95,99,121,3,140,0,13,102,114,97,109,101,46,99,97,112,116,105,
  111,110,6,6,101,45,109,97,105,108,11,102,114,97,109,101,46,100,117,109,
  109,121,2,0,16,102,114,97,109,101,46,111,117,116,101,114,102,114,97,109,
  101,1,2,0,2,10,2,0,2,0,0,8,116,97,98,111,114,100,101,114,
  2,1,0,11,116,115,116,114,105,110,103,101,100,105,116,9,101,109,97,105,
  108,70,114,111,109,8,98,111,117,110,100,115,95,120,2,19,8,98,111,117,
  110,100,115,95,121,2,26,9,98,111,117,110,100,115,95,99,120,3,193,0,
  9,98,111,117,110,100,115,95,99,121,2,25,13,102,114,97,109,101,46,99,
  97,112,116,105,111,110,6,4,70,114,111,109,16,102,114,97,109,101,46,99,
  97,112,116,105,111,110,112,111,115,7,7,99,112,95,108,101,102,116,11,102,
  114,97,109,101,46,100,117,109,109,121,2,0,16,102,114,97,109,101,46,111,
  117,116,101,114,102,114,97,109,101,1,2,45,2,0,2,0,2,0,0,13,
  114,101,102,102,111,110,116,104,101,105,103,104,116,2,19,0,0,11,116,115,
  116,114,105,110,103,101,100,105,116,7,101,109,97,105,108,84,111,8,98,111,
  117,110,100,115,95,120,2,41,8,98,111,117,110,100,115,95,121,2,58,9,
  98,111,117,110,100,115,95,99,120,3,171,0,9,98,111,117,110,100,115,95,
  99,121,2,25,13,102,114,97,109,101,46,99,97,112,116,105,111,110,6,2,
  84,111,16,102,114,97,109,101,46,99,97,112,116,105,111,110,112,111,115,7,
  7,99,112,95,108,101,102,116,11,102,114,97,109,101,46,100,117,109,109,121,
  2,0,16,102,114,97,109,101,46,111,117,116,101,114,102,114,97,109,101,1,
  2,23,2,0,2,0,2,0,0,8,116,97,98,111,114,100,101,114,2,1,
  13,114,101,102,102,111,110,116,104,101,105,103,104,116,2,19,0,0,11,116,
  115,116,114,105,110,103,101,100,105,116,12,101,109,97,105,108,83,117,98,106,
  101,99,116,8,98,111,117,110,100,115,95,120,2,2,8,98,111,117,110,100,
  115,95,121,2,90,9,98,111,117,110,100,115,95,99,120,3,210,0,9,98,
  111,117,110,100,115,95,99,121,2,25,13,102,114,97,109,101,46,99,97,112,
  116,105,111,110,6,7,83,117,98,106,101,99,116,16,102,114,97,109,101,46,
  99,97,112,116,105,111,110,112,111,115,7,7,99,112,95,108,101,102,116,11,
  102,114,97,109,101,46,100,117,109,109,121,2,0,16,102,114,97,109,101,46,
  111,117,116,101,114,102,114,97,109,101,1,2,62,2,0,2,0,2,0,0,
  8,116,97,98,111,114,100,101,114,2,2,13,114,101,102,102,111,110,116,104,
  101,105,103,104,116,2,19,0,0,0,9,116,109,101,109,111,101,100,105,116,
  8,109,101,109,111,84,101,120,116,8,98,111,117,110,100,115,95,120,2,8,
  8,98,111,117,110,100,115,95,121,3,152,0,9,98,111,117,110,100,115,95,
  99,120,3,196,1,9,98,111,117,110,100,115,95,99,121,3,137,0,16,102,
  114,97,109,101,46,108,111,99,97,108,112,114,111,112,115,11,15,102,114,108,
  95,99,111,108,111,114,99,108,105,101,110,116,0,11,102,114,97,109,101,46,
  100,117,109,109,121,2,0,8,116,97,98,111,114,100,101,114,2,2,0,0,
  6,116,108,97,98,101,108,9,115,116,97,116,117,115,66,97,114,13,111,112,
  116,105,111,110,115,119,105,100,103,101,116,11,17,111,119,95,100,101,115,116,
  114,111,121,119,105,100,103,101,116,115,18,111,119,95,102,111,110,116,103,108,
  121,112,104,104,101,105,103,104,116,12,111,119,95,97,117,116,111,115,99,97,
  108,101,0,8,98,111,117,110,100,115,95,120,2,2,8,98,111,117,110,100,
  115,95,121,3,167,1,9,98,111,117,110,100,115,95,99,120,3,208,1,9,
  98,111,117,110,100,115,95,99,121,2,27,12,102,114,97,109,101,46,108,101,
  118,101,108,105,2,1,16,102,114,97,109,101,46,108,111,99,97,108,112,114,
  111,112,115,11,10,102,114,108,95,108,101,118,101,108,111,10,102,114,108,95,
  108,101,118,101,108,105,0,11,102,114,97,109,101,46,100,117,109,109,121,2,
  0,7,97,110,99,104,111,114,115,11,7,97,110,95,108,101,102,116,8,97,
  110,95,114,105,103,104,116,9,97,110,95,98,111,116,116,111,109,0,8,116,
  97,98,111,114,100,101,114,2,3,13,114,101,102,102,111,110,116,104,101,105,
  103,104,116,2,19,0,0,12,116,112,114,111,103,114,101,115,115,98,97,114,
  16,115,109,112,116,83,101,110,100,80,114,111,103,114,101,115,115,8,98,111,
  117,110,100,115,95,120,2,3,8,98,111,117,110,100,115,95,121,3,146,1,
  9,98,111,117,110,100,115,95,99,120,3,205,1,11,102,114,97,109,101,46,
  100,117,109,109,121,2,0,7,97,110,99,104,111,114,115,11,7,97,110,95,
  108,101,102,116,8,97,110,95,114,105,103,104,116,9,97,110,95,98,111,116,
  116,111,109,0,8,116,97,98,111,114,100,101,114,2,4,23,98,97,114,95,
  102,97,99,101,46,102,97,100,101,95,112,111,115,46,99,111,117,110,116,2,
  1,23,98,97,114,95,102,97,99,101,46,102,97,100,101,95,112,111,115,46,
  105,116,101,109,115,1,5,0,0,0,0,0,0,0,0,0,0,0,25,98,
  97,114,95,102,97,99,101,46,102,97,100,101,95,99,111,108,111,114,46,99,
  111,117,110,116,2,1,25,98,97,114,95,102,97,99,101,46,102,97,100,101,
  95,99,111,108,111,114,46,105,116,101,109,115,1,4,21,0,0,160,0,14,
  98,97,114,95,102,97,99,101,46,100,117,109,109,121,2,0,15,98,97,114,
  95,102,114,97,109,101,46,100,117,109,109,121,2,0,10,118,97,108,117,101,
  115,99,97,108,101,5,10,215,163,112,61,10,215,163,248,63,6,102,111,114,
  109,97,116,6,2,48,37,0,0,7,116,98,117,116,116,111,110,7,98,116,
  110,83,101,110,100,8,98,111,117,110,100,115,95,120,2,3,8,98,111,117,
  110,100,115,95,121,3,120,1,9,98,111,117,110,100,115,95,99,120,3,206,
  1,9,98,111,117,110,100,115,95,99,121,2,25,7,97,110,99,104,111,114,
  115,11,7,97,110,95,108,101,102,116,8,97,110,95,114,105,103,104,116,9,
  97,110,95,98,111,116,116,111,109,0,8,116,97,98,111,114,100,101,114,2,
  5,5,115,116,97,116,101,11,15,97,115,95,108,111,99,97,108,99,97,112,
  116,105,111,110,17,97,115,95,108,111,99,97,108,111,110,101,120,101,99,117,
  116,101,0,7,99,97,112,116,105,111,110,6,4,83,101,110,100,9,111,110,
  101,120,101,99,117,116,101,7,10,100,111,83,101,110,100,77,97,105,108,0,
  0,11,116,115,116,114,105,110,103,103,114,105,100,10,103,114,105,100,65,116,
  116,97,99,104,13,111,112,116,105,111,110,115,119,105,100,103,101,116,11,13,
  111,119,95,109,111,117,115,101,102,111,99,117,115,11,111,119,95,116,97,98,
  102,111,99,117,115,13,111,119,95,97,114,114,111,119,102,111,99,117,115,17,
  111,119,95,102,111,99,117,115,98,97,99,107,111,110,101,115,99,13,111,119,
  95,109,111,117,115,101,119,104,101,101,108,17,111,119,95,100,101,115,116,114,
  111,121,119,105,100,103,101,116,115,18,111,119,95,102,111,110,116,103,108,121,
  112,104,104,101,105,103,104,116,12,111,119,95,97,117,116,111,115,99,97,108,
  101,0,8,98,111,117,110,100,115,95,120,2,8,8,98,111,117,110,100,115,
  95,121,3,34,1,9,98,111,117,110,100,115,95,99,120,3,194,1,9,98,
  111,117,110,100,115,95,99,121,2,80,13,102,114,97,109,101,46,99,97,112,
  116,105,111,110,6,11,65,116,116,97,99,104,109,101,110,116,115,11,102,114,
  97,109,101,46,100,117,109,109,121,2,0,16,102,114,97,109,101,46,111,117,
  116,101,114,102,114,97,109,101,1,2,0,2,22,2,0,2,0,0,7,97,
  110,99,104,111,114,115,11,7,97,110,95,108,101,102,116,8,97,110,95,114,
  105,103,104,116,9,97,110,95,98,111,116,116,111,109,0,8,116,97,98,111,
  114,100,101,114,2,6,14,100,97,116,97,99,111,108,115,46,99,111,117,110,
  116,2,1,14,100,97,116,97,99,111,108,115,46,105,116,101,109,115,14,1,
  5,119,105,100,116,104,3,189,1,7,111,112,116,105,111,110,115,11,11,99,
  111,95,114,101,97,100,111,110,108,121,12,99,111,95,114,111,119,115,101,108,
  101,99,116,7,99,111,95,102,105,108,108,12,99,111,95,115,97,118,101,118,
  97,108,117,101,12,99,111,95,115,97,118,101,115,116,97,116,101,10,99,111,
  95,114,111,119,102,111,110,116,11,99,111,95,114,111,119,99,111,108,111,114,
  13,99,111,95,122,101,98,114,97,99,111,108,111,114,17,99,111,95,109,111,
  117,115,101,115,99,114,111,108,108,114,111,119,0,0,0,13,100,97,116,97,
  114,111,119,104,101,105,103,104,116,2,21,13,114,101,102,102,111,110,116,104,
  101,105,103,104,116,2,19,0,0,9,116,109,97,105,110,109,101,110,117,11,
  97,112,112,77,97,105,110,77,101,110,117,18,109,101,110,117,46,115,117,98,
  109,101,110,117,46,99,111,117,110,116,2,2,18,109,101,110,117,46,115,117,
  98,109,101,110,117,46,105,116,101,109,115,14,1,13,115,117,98,109,101,110,
  117,46,99,111,117,110,116,2,1,13,115,117,98,109,101,110,117,46,105,116,
  101,109,115,14,1,7,99,97,112,116,105,111,110,6,4,69,120,105,116,5,
  115,116,97,116,101,11,15,97,115,95,108,111,99,97,108,99,97,112,116,105,
  111,110,0,0,0,7,99,97,112,116,105,111,110,6,4,70,105,108,101,5,
  115,116,97,116,101,11,15,97,115,95,108,111,99,97,108,99,97,112,116,105,
  111,110,17,97,115,95,108,111,99,97,108,111,110,101,120,101,99,117,116,101,
  0,9,111,110,101,120,101,99,117,116,101,7,7,101,120,105,116,65,112,112,
  0,1,13,115,117,98,109,101,110,117,46,99,111,117,110,116,2,2,13,115,
  117,98,109,101,110,117,46,105,116,101,109,115,14,1,7,99,97,112,116,105,
  111,110,6,12,76,111,103,47,70,101,97,116,117,114,101,115,5,115,116,97,
  116,101,11,15,97,115,95,108,111,99,97,108,99,97,112,116,105,111,110,17,
  97,115,95,108,111,99,97,108,111,110,101,120,101,99,117,116,101,0,9,111,
  110,101,120,101,99,117,116,101,7,15,115,104,111,119,76,111,103,70,101,97,
  116,117,114,101,115,0,1,7,99,97,112,116,105,111,110,6,5,65,98,111,
  117,116,5,115,116,97,116,101,11,15,97,115,95,108,111,99,97,108,99,97,
  112,116,105,111,110,0,0,0,7,99,97,112,116,105,111,110,6,4,72,101,
  108,112,5,115,116,97,116,101,11,15,97,115,95,108,111,99,97,108,99,97,
  112,116,105,111,110,17,97,115,95,108,111,99,97,108,111,110,101,120,101,99,
  117,116,101,0,0,0,10,109,101,110,117,46,115,116,97,116,101,11,17,97,
  115,95,108,111,99,97,108,111,110,101,120,101,99,117,116,101,0,14,109,101,
  110,117,46,111,110,101,120,101,99,117,116,101,7,9,115,104,111,119,65,98,
  111,117,116,4,108,101,102,116,3,24,1,3,116,111,112,3,152,0,0,0,
  11,116,102,105,108,101,100,105,97,108,111,103,7,111,112,101,110,68,108,103,
  10,100,105,97,108,111,103,107,105,110,100,7,8,102,100,107,95,110,111,110,
  101,4,108,101,102,116,3,32,1,3,116,111,112,3,184,0,0,0,6,116,
  116,105,109,101,114,9,116,105,109,101,114,81,117,105,116,7,111,110,116,105,
  109,101,114,7,11,100,111,84,105,109,101,114,81,117,105,116,4,108,101,102,
  116,3,32,1,3,116,111,112,3,216,0,0,0,10,116,112,111,112,117,112,
  109,101,110,117,16,112,111,112,117,112,65,116,116,97,99,104,109,101,110,116,
  115,18,109,101,110,117,46,115,117,98,109,101,110,117,46,99,111,117,110,116,
  2,2,18,109,101,110,117,46,115,117,98,109,101,110,117,46,105,116,101,109,
  115,14,1,7,99,97,112,116,105,111,110,6,14,65,116,116,97,99,104,109,
  101,110,116,32,65,100,100,5,115,116,97,116,101,11,15,97,115,95,108,111,
  99,97,108,99,97,112,116,105,111,110,17,97,115,95,108,111,99,97,108,111,
  110,101,120,101,99,117,116,101,0,9,111,110,101,120,101,99,117,116,101,7,
  16,100,111,65,100,100,65,116,116,97,99,104,109,101,110,116,115,0,1,7,
  99,97,112,116,105,111,110,6,17,65,116,116,97,99,104,109,101,110,116,32,
  68,101,108,101,116,101,5,115,116,97,116,101,11,15,97,115,95,108,111,99,
  97,108,99,97,112,116,105,111,110,17,97,115,95,108,111,99,97,108,111,110,
  101,120,101,99,117,116,101,0,9,111,110,101,120,101,99,117,116,101,7,17,
  100,111,68,101,108,65,116,116,97,99,104,101,109,101,110,116,115,0,0,12,
  109,101,110,117,46,99,97,112,116,105,111,110,6,11,65,116,116,97,99,104,
  109,101,110,116,115,10,109,101,110,117,46,115,116,97,116,101,11,15,97,115,
  95,108,111,99,97,108,99,97,112,116,105,111,110,0,4,108,101,102,116,3,
  0,1,3,116,111,112,3,240,0,0,0,11,116,116,104,114,101,97,100,99,
  111,109,112,10,99,111,110,110,84,104,114,101,97,100,9,111,110,101,120,101,
  99,117,116,101,7,9,109,97,110,103,101,67,111,110,110,4,108,101,102,116,
  2,104,3,116,111,112,3,176,0,0,0,0)
 );

initialization
 registerobjectdata(@objdata,tmainfo,'');
end.
