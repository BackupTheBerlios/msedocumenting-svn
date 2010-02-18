unit main_mfm;
{$ifdef FPC}{$mode objfpc}{$h+}{$endif}

interface

implementation
uses
 mseclasses,main;

const
 objdata: record size: integer; data: array[0..6460] of byte end =
      (size: 6461; data: (
  84,80,70,48,7,116,109,97,105,110,102,111,6,109,97,105,110,102,111,7,
  118,105,115,105,98,108,101,8,8,98,111,117,110,100,115,95,120,2,18,8,
  98,111,117,110,100,115,95,121,3,181,0,9,98,111,117,110,100,115,95,99,
  120,3,50,2,9,98,111,117,110,100,115,95,99,121,3,116,1,16,99,111,
  110,116,97,105,110,101,114,46,98,111,117,110,100,115,1,2,0,2,0,3,
  50,2,3,116,1,0,8,115,116,97,116,102,105,108,101,7,10,116,115,116,
  97,116,102,105,108,101,49,7,99,97,112,116,105,111,110,6,20,77,83,69,
  105,100,101,43,77,83,69,103,117,105,32,116,99,104,97,114,116,15,109,111,
  100,117,108,101,99,108,97,115,115,110,97,109,101,6,9,116,109,97,105,110,
  102,111,114,109,0,6,116,99,104,97,114,116,5,99,104,97,114,116,12,102,
  114,97,109,101,46,108,101,118,101,108,111,2,255,12,102,114,97,109,101,46,
  108,101,118,101,108,105,2,1,16,102,114,97,109,101,46,102,114,97,109,101,
  119,105,100,116,104,2,1,16,102,114,97,109,101,46,99,111,108,111,114,102,
  114,97,109,101,4,0,115,130,0,17,102,114,97,109,101,46,102,114,97,109,
  101,105,95,108,101,102,116,2,30,16,102,114,97,109,101,46,102,114,97,109,
  101,105,95,116,111,112,2,10,18,102,114,97,109,101,46,102,114,97,109,101,
  105,95,114,105,103,104,116,2,30,19,102,114,97,109,101,46,102,114,97,109,
  101,105,95,98,111,116,116,111,109,2,24,16,102,114,97,109,101,46,108,111,
  99,97,108,112,114,111,112,115,11,10,102,114,108,95,108,101,118,101,108,111,
  10,102,114,108,95,108,101,118,101,108,105,14,102,114,108,95,102,114,97,109,
  101,119,105,100,116,104,14,102,114,108,95,99,111,108,111,114,102,114,97,109,
  101,10,102,114,108,95,102,105,108,101,102,116,9,102,114,108,95,102,105,116,
  111,112,11,102,114,108,95,102,105,114,105,103,104,116,12,102,114,108,95,102,
  105,98,111,116,116,111,109,0,8,98,111,117,110,100,115,95,120,2,4,8,
  98,111,117,110,100,115,95,121,2,5,9,98,111,117,110,100,115,95,99,120,
  3,129,1,9,98,111,117,110,100,115,95,99,121,3,107,1,7,97,110,99,
  104,111,114,115,11,7,97,110,95,108,101,102,116,6,97,110,95,116,111,112,
  8,97,110,95,114,105,103,104,116,9,97,110,95,98,111,116,116,111,109,0,
  12,116,114,97,99,101,115,46,99,111,117,110,116,2,3,13,116,114,97,99,
  101,115,46,120,115,116,97,114,116,5,0,0,0,0,0,0,0,0,0,0,
  13,116,114,97,99,101,115,46,121,115,116,97,114,116,5,0,0,0,0,0,
  0,0,0,0,0,13,116,114,97,99,101,115,46,120,114,97,110,103,101,5,
  0,0,0,0,0,0,0,128,255,63,13,116,114,97,99,101,115,46,121,114,
  97,110,103,101,5,0,0,0,0,0,0,0,128,255,63,17,116,114,97,99,
  101,115,46,105,109,97,103,101,95,108,105,115,116,7,9,105,109,97,103,101,
  108,105,115,116,20,116,114,97,99,101,115,46,105,109,97,103,101,95,119,105,
  100,116,104,109,109,5,0,0,0,0,0,0,0,128,1,64,22,116,114,97,
  99,101,115,46,105,109,97,103,101,95,104,101,105,103,104,116,104,109,109,5,
  0,0,0,0,0,0,0,128,1,64,12,116,114,97,99,101,115,46,105,116,
  101,109,115,14,1,5,99,111,108,111,114,4,13,0,0,160,7,119,105,100,
  116,104,109,109,5,41,152,153,153,153,153,153,153,254,63,6,120,114,97,110,
  103,101,5,0,0,0,0,0,0,0,128,255,63,6,120,115,116,97,114,116,
  5,0,0,0,0,0,0,0,0,0,0,6,121,114,97,110,103,101,5,0,
  0,0,0,0,0,0,128,0,64,6,121,115,116,97,114,116,5,0,0,0,
  0,0,0,0,128,255,191,4,107,105,110,100,7,6,116,114,107,95,120,121,
  4,110,97,109,101,6,7,120,121,115,105,110,117,115,0,1,5,99,111,108,
  111,114,4,14,0,0,160,7,119,105,100,116,104,109,109,5,41,152,153,153,
  153,153,153,153,254,63,6,120,114,97,110,103,101,5,0,0,0,0,0,0,
  0,128,255,63,6,120,115,116,97,114,116,5,0,0,0,0,0,0,0,0,
  0,0,6,121,114,97,110,103,101,5,0,0,0,0,0,0,0,128,255,63,
  6,121,115,116,97,114,116,5,0,0,0,0,0,0,0,0,0,0,4,110,
  97,109,101,6,7,120,115,101,114,105,101,115,0,1,10,99,111,108,111,114,
  105,109,97,103,101,4,9,0,0,160,7,119,105,100,116,104,109,109,5,41,
  152,153,153,153,153,153,153,253,63,6,100,97,115,104,101,115,6,4,5,10,
  1,10,6,120,114,97,110,103,101,5,0,0,0,0,0,0,0,128,255,63,
  6,120,115,116,97,114,116,5,0,0,0,0,0,0,0,0,0,0,6,121,
  114,97,110,103,101,5,174,207,204,204,204,204,204,204,254,63,6,121,115,116,
  97,114,116,5,82,48,51,51,51,51,51,179,253,191,4,107,105,110,100,7,
  6,116,114,107,95,120,121,7,105,109,97,103,101,110,114,2,0,4,110,97,
  109,101,6,9,120,121,115,99,97,116,116,101,114,0,0,6,120,115,116,97,
  114,116,5,0,0,0,0,0,0,0,0,0,0,6,121,115,116,97,114,116,
  5,0,0,0,0,0,0,0,0,0,0,6,120,114,97,110,103,101,5,0,
  0,0,0,0,0,0,128,255,63,6,121,114,97,110,103,101,5,0,0,0,
  0,0,0,0,128,255,63,12,120,100,105,97,108,115,46,99,111,117,110,116,
  2,1,12,120,100,105,97,108,115,46,115,116,97,114,116,5,0,0,0,0,
  0,0,0,0,0,0,12,120,100,105,97,108,115,46,114,97,110,103,101,5,
  0,0,0,0,0,0,0,128,255,63,12,120,100,105,97,108,115,46,105,116,
  101,109,115,14,1,5,99,111,108,111,114,4,2,0,0,160,7,119,105,100,
  116,104,109,109,5,41,152,153,153,153,153,153,153,253,63,5,115,116,97,114,
  116,5,0,0,0,0,0,0,0,0,0,0,5,114,97,110,103,101,5,0,
  0,0,0,0,0,0,128,255,63,11,116,105,99,107,115,46,99,111,117,110,
  116,2,3,11,116,105,99,107,115,46,105,116,101,109,115,14,1,5,99,111,
  108,111,114,4,3,0,0,160,7,119,105,100,116,104,109,109,5,0,0,0,
  0,0,0,0,0,0,0,6,100,97,115,104,101,115,6,2,1,1,7,99,
  97,112,116,105,111,110,6,3,48,46,48,11,99,97,112,116,105,111,110,100,
  105,115,116,2,4,10,101,115,99,97,112,101,109,101,110,116,5,0,0,0,
  0,0,0,0,0,0,0,13,105,110,116,101,114,118,97,108,99,111,117,110,
  116,5,0,0,0,0,0,0,0,160,2,64,0,1,7,119,105,100,116,104,
  109,109,5,0,0,0,0,0,0,0,0,0,0,6,108,101,110,103,116,104,
  2,8,10,101,115,99,97,112,101,109,101,110,116,5,0,0,0,0,0,0,
  0,0,0,0,8,105,110,116,101,114,118,97,108,5,67,208,204,204,204,204,
  204,204,250,63,0,1,7,119,105,100,116,104,109,109,5,0,0,0,0,0,
  0,0,0,0,0,6,108,101,110,103,116,104,2,4,10,101,115,99,97,112,
  101,109,101,110,116,5,0,0,0,0,0,0,0,0,0,0,13,105,110,116,
  101,114,118,97,108,99,111,117,110,116,5,0,0,0,0,0,0,0,200,5,
  64,0,0,7,111,112,116,105,111,110,115,11,11,100,111,95,115,105,100,101,
  108,105,110,101,10,100,111,95,98,111,120,108,105,110,101,0,0,0,12,121,
  100,105,97,108,115,46,99,111,117,110,116,2,2,12,121,100,105,97,108,115,
  46,115,116,97,114,116,5,0,0,0,0,0,0,0,0,0,0,12,121,100,
  105,97,108,115,46,114,97,110,103,101,5,0,0,0,0,0,0,0,128,255,
  63,12,121,100,105,97,108,115,46,105,116,101,109,115,14,1,5,99,111,108,
  111,114,4,2,0,0,160,7,119,105,100,116,104,109,109,5,41,152,153,153,
  153,153,153,153,253,63,5,115,116,97,114,116,5,82,48,51,51,51,51,51,
  179,253,191,5,114,97,110,103,101,5,174,207,204,204,204,204,204,204,254,63,
  13,109,97,114,107,101,114,115,46,99,111,117,110,116,2,1,13,109,97,114,
  107,101,114,115,46,105,116,101,109,115,14,1,5,99,111,108,111,114,4,7,
  0,0,160,7,119,105,100,116,104,109,109,5,0,0,0,0,0,0,0,0,
  0,0,6,100,97,115,104,101,115,6,2,1,1,7,99,97,112,116,105,111,
  110,6,4,48,46,48,48,11,99,97,112,116,105,111,110,100,105,115,116,2,
  216,13,99,97,112,116,105,111,110,111,102,102,115,101,116,2,250,10,101,115,
  99,97,112,101,109,101,110,116,5,0,0,0,0,0,0,0,0,0,0,3,
  118,97,108,5,174,71,225,122,20,174,71,225,252,191,0,0,11,116,105,99,
  107,115,46,99,111,117,110,116,2,2,11,116,105,99,107,115,46,105,116,101,
  109,115,14,1,7,119,105,100,116,104,109,109,5,41,152,153,153,153,153,153,
  153,253,63,6,108,101,110,103,116,104,2,5,7,99,97,112,116,105,111,110,
  6,3,48,46,48,10,101,115,99,97,112,101,109,101,110,116,5,0,0,0,
  0,0,0,0,0,0,0,13,105,110,116,101,114,118,97,108,99,111,117,110,
  116,5,0,0,0,0,0,0,0,128,2,64,0,1,7,119,105,100,116,104,
  109,109,5,0,0,0,0,0,0,0,0,0,0,6,108,101,110,103,116,104,
  2,3,10,101,115,99,97,112,101,109,101,110,116,5,0,0,0,0,0,0,
  0,0,0,0,8,105,110,116,101,114,118,97,108,5,67,208,204,204,204,204,
  204,204,250,63,0,0,7,111,112,116,105,111,110,115,11,11,100,111,95,115,
  105,100,101,108,105,110,101,0,0,1,5,99,111,108,111,114,4,2,0,0,
  160,7,119,105,100,116,104,109,109,5,41,152,153,153,153,153,153,153,253,63,
  5,115,116,97,114,116,5,0,0,0,0,0,0,0,128,255,191,5,114,97,
  110,103,101,5,0,0,0,0,0,0,0,128,0,64,13,109,97,114,107,101,
  114,115,46,99,111,117,110,116,2,1,13,109,97,114,107,101,114,115,46,105,
  116,101,109,115,14,1,5,99,111,108,111,114,4,9,0,0,160,7,119,105,
  100,116,104,109,109,5,0,0,0,0,0,0,0,0,0,0,6,100,97,115,
  104,101,115,6,2,2,1,10,101,115,99,97,112,101,109,101,110,116,5,0,
  0,0,0,0,0,0,0,0,0,0,0,11,116,105,99,107,115,46,99,111,
  117,110,116,2,1,11,116,105,99,107,115,46,105,116,101,109,115,14,1,5,
  99,111,108,111,114,4,3,0,0,160,7,119,105,100,116,104,109,109,5,0,
  0,0,0,0,0,0,0,0,0,6,100,97,115,104,101,115,6,2,1,2,
  7,99,97,112,116,105,111,110,6,3,48,46,48,10,101,115,99,97,112,101,
  109,101,110,116,5,0,0,0,0,0,0,0,0,0,0,13,105,110,116,101,
  114,118,97,108,99,111,117,110,116,5,0,0,0,0,0,0,0,160,3,64,
  0,0,7,111,112,116,105,111,110,115,11,11,100,111,95,111,112,112,111,115,
  105,116,101,11,100,111,95,115,105,100,101,108,105,110,101,0,0,0,0,0,
  11,116,119,105,100,103,101,116,103,114,105,100,12,116,119,105,100,103,101,116,
  103,114,105,100,49,13,102,114,97,109,101,46,99,97,112,116,105,111,110,6,
  11,88,47,89,32,83,99,97,116,116,101,114,16,102,114,97,109,101,46,111,
  117,116,101,114,102,114,97,109,101,1,2,0,2,17,2,0,2,0,0,8,
  116,97,98,111,114,100,101,114,2,1,8,98,111,117,110,100,115,95,120,3,
  138,1,8,98,111,117,110,100,115,95,121,2,46,9,98,111,117,110,100,115,
  95,99,120,3,162,0,9,98,111,117,110,100,115,95,99,121,3,39,1,7,
  97,110,99,104,111,114,115,11,6,97,110,95,116,111,112,8,97,110,95,114,
  105,103,104,116,9,97,110,95,98,111,116,116,111,109,0,11,111,112,116,105,
  111,110,115,103,114,105,100,11,15,111,103,95,114,111,119,105,110,115,101,114,
  116,105,110,103,14,111,103,95,114,111,119,100,101,108,101,116,105,110,103,19,
  111,103,95,102,111,99,117,115,99,101,108,108,111,110,101,110,116,101,114,15,
  111,103,95,97,117,116,111,102,105,114,115,116,114,111,119,13,111,103,95,97,
  117,116,111,97,112,112,101,110,100,20,111,103,95,99,111,108,99,104,97,110,
  103,101,111,110,116,97,98,107,101,121,10,111,103,95,119,114,97,112,99,111,
  108,12,111,103,95,97,117,116,111,112,111,112,117,112,17,111,103,95,109,111,
  117,115,101,115,99,114,111,108,108,99,111,108,0,17,114,111,119,115,116,97,
  116,101,108,105,115,116,46,100,97,116,97,1,0,13,102,105,120,114,111,119,
  115,46,99,111,117,110,116,2,1,13,102,105,120,114,111,119,115,46,105,116,
  101,109,115,14,1,6,104,101,105,103,104,116,2,16,14,99,97,112,116,105,
  111,110,115,46,99,111,117,110,116,2,2,14,99,97,112,116,105,111,110,115,
  46,105,116,101,109,115,14,1,7,99,97,112,116,105,111,110,6,1,120,0,
  1,7,99,97,112,116,105,111,110,6,1,121,0,0,0,0,8,114,111,119,
  99,111,117,110,116,2,11,14,100,97,116,97,99,111,108,115,46,99,111,117,
  110,116,2,2,14,100,97,116,97,99,111,108,115,46,105,116,101,109,115,14,
  1,5,119,105,100,116,104,2,78,7,111,112,116,105,111,110,115,11,15,99,
  111,95,112,114,111,112,111,114,116,105,111,110,97,108,12,99,111,95,115,97,
  118,101,118,97,108,117,101,12,99,111,95,115,97,118,101,115,116,97,116,101,
  10,99,111,95,114,111,119,102,111,110,116,11,99,111,95,114,111,119,99,111,
  108,111,114,13,99,111,95,122,101,98,114,97,99,111,108,111,114,17,99,111,
  95,109,111,117,115,101,115,99,114,111,108,108,114,111,119,0,8,111,110,99,
  104,97,110,103,101,7,10,120,118,97,108,99,104,97,110,103,101,10,119,105,
  100,103,101,116,110,97,109,101,6,4,120,118,97,108,9,100,97,116,97,99,
  108,97,115,115,7,17,116,103,114,105,100,114,101,97,108,100,97,116,97,108,
  105,115,116,4,100,97,116,97,1,1,5,65,192,245,40,92,143,194,245,249,
  63,5,65,144,237,124,63,53,94,186,251,63,5,163,232,81,184,30,133,235,
  209,252,63,5,82,184,30,133,235,81,184,158,253,63,5,122,80,184,30,133,
  235,81,184,253,63,5,66,96,229,208,34,219,249,254,253,63,5,214,223,122,
  20,174,71,225,154,254,63,5,194,79,184,30,133,235,81,184,254,63,5,62,
  176,71,225,122,20,174,199,254,63,5,216,103,102,102,102,102,102,230,254,63,
  5,0,0,0,0,0,0,0,128,255,63,0,0,0,1,5,119,105,100,116,
  104,2,78,7,111,112,116,105,111,110,115,11,7,99,111,95,102,105,108,108,
  12,99,111,95,115,97,118,101,118,97,108,117,101,12,99,111,95,115,97,118,
  101,115,116,97,116,101,10,99,111,95,114,111,119,102,111,110,116,11,99,111,
  95,114,111,119,99,111,108,111,114,13,99,111,95,122,101,98,114,97,99,111,
  108,111,114,17,99,111,95,109,111,117,115,101,115,99,114,111,108,108,114,111,
  119,0,8,111,110,99,104,97,110,103,101,7,10,121,118,97,108,99,104,97,
  110,103,101,10,119,105,100,103,101,116,110,97,109,101,6,4,121,118,97,108,
  9,100,97,116,97,99,108,97,115,115,7,17,116,103,114,105,100,114,101,97,
  108,100,97,116,97,108,105,115,116,4,100,97,116,97,1,1,5,144,194,245,
  40,92,143,194,245,251,63,5,41,152,153,153,153,153,153,153,253,191,5,184,
  150,153,153,153,153,153,153,252,63,5,91,7,215,163,112,61,10,215,252,63,
  5,10,79,184,30,133,235,81,184,252,63,5,82,64,10,215,163,112,61,138,
  253,63,5,174,207,204,204,204,204,204,140,253,63,5,42,32,133,235,81,184,
  30,133,253,63,5,174,71,225,122,20,174,71,225,252,191,5,82,184,30,133,
  235,81,184,158,253,63,5,255,119,20,174,71,225,122,148,253,63,0,0,0,
  0,13,100,97,116,97,114,111,119,104,101,105,103,104,116,2,16,8,115,116,
  97,116,102,105,108,101,7,10,116,115,116,97,116,102,105,108,101,49,13,114,
  101,102,102,111,110,116,104,101,105,103,104,116,2,14,0,9,116,114,101,97,
  108,101,100,105,116,4,120,118,97,108,11,111,112,116,105,111,110,115,115,107,
  105,110,11,19,111,115,107,95,102,114,97,109,101,98,117,116,116,111,110,111,
  110,108,121,0,8,116,97,98,111,114,100,101,114,2,1,7,118,105,115,105,
  98,108,101,8,8,98,111,117,110,100,115,95,120,2,0,8,98,111,117,110,
  100,115,95,121,2,0,9,98,111,117,110,100,115,95,99,120,2,78,9,98,
  111,117,110,100,115,95,99,121,2,16,10,118,97,108,117,101,114,97,110,103,
  101,5,0,0,0,0,0,0,0,128,255,63,13,114,101,102,102,111,110,116,
  104,101,105,103,104,116,2,14,2,109,105,5,0,0,0,0,0,0,0,128,
  0,192,2,109,97,5,0,0,0,0,0,0,0,128,0,64,3,100,101,102,
  5,0,0,0,0,0,0,0,0,0,0,0,0,9,116,114,101,97,108,101,
  100,105,116,4,121,118,97,108,13,111,112,116,105,111,110,115,119,105,100,103,
  101,116,11,13,111,119,95,109,111,117,115,101,102,111,99,117,115,11,111,119,
  95,116,97,98,102,111,99,117,115,13,111,119,95,97,114,114,111,119,102,111,
  99,117,115,13,111,119,95,109,111,117,115,101,119,104,101,101,108,17,111,119,
  95,100,101,115,116,114,111,121,119,105,100,103,101,116,115,18,111,119,95,102,
  111,110,116,103,108,121,112,104,104,101,105,103,104,116,0,11,111,112,116,105,
  111,110,115,115,107,105,110,11,19,111,115,107,95,102,114,97,109,101,98,117,
  116,116,111,110,111,110,108,121,0,8,116,97,98,111,114,100,101,114,2,2,
  7,118,105,115,105,98,108,101,8,8,98,111,117,110,100,115,95,120,2,79,
  8,98,111,117,110,100,115,95,121,2,0,9,98,111,117,110,100,115,95,99,
  120,2,78,9,98,111,117,110,100,115,95,99,121,2,16,10,118,97,108,117,
  101,114,97,110,103,101,5,0,0,0,0,0,0,0,128,255,63,13,114,101,
  102,102,111,110,116,104,101,105,103,104,116,2,14,2,109,105,5,0,0,0,
  0,0,0,0,128,0,192,2,109,97,5,0,0,0,0,0,0,0,128,0,
  64,3,100,101,102,5,0,0,0,0,0,0,0,0,0,0,0,0,0,9,
  116,114,101,97,108,101,100,105,116,5,102,114,101,113,117,13,102,114,97,109,
  101,46,99,97,112,116,105,111,110,6,10,83,105,103,46,32,70,114,101,113,
  46,11,102,114,97,109,101,46,100,117,109,109,121,2,0,16,102,114,97,109,
  101,46,111,117,116,101,114,102,114,97,109,101,1,2,0,2,17,2,0,2,
  0,0,8,116,97,98,111,114,100,101,114,2,2,8,98,111,117,110,100,115,
  95,120,3,138,1,8,98,111,117,110,100,115,95,121,2,2,9,98,111,117,
  110,100,115,95,99,120,2,77,9,98,111,117,110,100,115,95,99,121,2,37,
  7,97,110,99,104,111,114,115,11,6,97,110,95,116,111,112,8,97,110,95,
  114,105,103,104,116,0,8,115,116,97,116,102,105,108,101,7,10,116,115,116,
  97,116,102,105,108,101,49,11,111,112,116,105,111,110,115,101,100,105,116,11,
  12,111,101,95,117,110,100,111,111,110,101,115,99,13,111,101,95,99,108,111,
  115,101,113,117,101,114,121,16,111,101,95,99,104,101,99,107,109,114,99,97,
  110,99,101,108,15,111,101,95,101,120,105,116,111,110,99,117,114,115,111,114,
  14,111,101,95,115,104,105,102,116,114,101,116,117,114,110,12,111,101,95,101,
  97,116,114,101,116,117,114,110,20,111,101,95,114,101,115,101,116,115,101,108,
  101,99,116,111,110,101,120,105,116,13,111,101,95,101,110,100,111,110,101,110,
  116,101,114,13,111,101,95,97,117,116,111,115,101,108,101,99,116,25,111,101,
  95,97,117,116,111,115,101,108,101,99,116,111,110,102,105,114,115,116,99,108,
  105,99,107,16,111,101,95,97,117,116,111,112,111,112,117,112,109,101,110,117,
  13,111,101,95,107,101,121,101,120,101,99,117,116,101,25,111,101,95,99,104,
  101,99,107,118,97,108,117,101,112,97,115,116,115,116,97,116,114,101,97,100,
  12,111,101,95,115,97,118,101,118,97,108,117,101,12,111,101,95,115,97,118,
  101,115,116,97,116,101,0,13,111,110,100,97,116,97,101,110,116,101,114,101,
  100,7,14,115,105,103,100,97,116,97,101,110,116,101,114,101,100,10,118,97,
  108,117,101,114,97,110,103,101,5,0,0,0,0,0,0,0,128,255,63,13,
  114,101,102,102,111,110,116,104,101,105,103,104,116,2,14,3,118,97,108,5,
  0,0,0,0,0,0,0,128,255,63,2,109,105,5,10,215,163,112,61,10,
  215,163,248,63,2,109,97,5,0,0,0,0,0,0,0,200,5,64,0,0,
  9,116,114,101,97,108,101,100,105,116,3,97,109,112,13,102,114,97,109,101,
  46,99,97,112,116,105,111,110,6,9,83,105,103,46,32,65,109,112,46,16,
  102,114,97,109,101,46,108,111,99,97,108,112,114,111,112,115,11,12,102,114,
  108,95,102,105,98,111,116,116,111,109,0,11,102,114,97,109,101,46,100,117,
  109,109,121,2,0,16,102,114,97,109,101,46,111,117,116,101,114,102,114,97,
  109,101,1,2,0,2,17,2,0,2,0,0,8,116,97,98,111,114,100,101,
  114,2,3,8,98,111,117,110,100,115,95,120,3,222,1,8,98,111,117,110,
  100,115,95,121,2,2,9,98,111,117,110,100,115,95,99,120,2,77,9,98,
  111,117,110,100,115,95,99,121,2,37,7,97,110,99,104,111,114,115,11,6,
  97,110,95,116,111,112,8,97,110,95,114,105,103,104,116,0,8,115,116,97,
  116,102,105,108,101,7,10,116,115,116,97,116,102,105,108,101,49,13,111,110,
  100,97,116,97,101,110,116,101,114,101,100,7,14,115,105,103,100,97,116,97,
  101,110,116,101,114,101,100,10,118,97,108,117,101,114,97,110,103,101,5,0,
  0,0,0,0,0,0,128,255,63,13,114,101,102,102,111,110,116,104,101,105,
  103,104,116,2,14,3,118,97,108,5,216,103,102,102,102,102,102,230,254,63,
  2,109,105,5,144,210,204,204,204,204,204,204,251,63,2,109,97,5,0,0,
  0,0,0,0,0,160,2,64,0,0,9,116,114,101,97,108,101,100,105,116,
  8,120,121,109,97,114,107,101,114,13,102,114,97,109,101,46,99,97,112,116,
  105,111,110,6,6,77,97,114,107,101,114,16,102,114,97,109,101,46,99,97,
  112,116,105,111,110,112,111,115,7,8,99,112,95,114,105,103,104,116,11,102,
  114,97,109,101,46,100,117,109,109,121,2,0,16,102,114,97,109,101,46,111,
  117,116,101,114,102,114,97,109,101,1,2,0,2,0,2,40,2,0,0,8,
  116,97,98,111,114,100,101,114,2,4,8,98,111,117,110,100,115,95,120,3,
  138,1,8,98,111,117,110,100,115,95,121,3,91,1,9,98,111,117,110,100,
  115,95,99,120,2,108,9,98,111,117,110,100,115,95,99,121,2,20,7,97,
  110,99,104,111,114,115,11,8,97,110,95,114,105,103,104,116,9,97,110,95,
  98,111,116,116,111,109,0,8,115,116,97,116,102,105,108,101,7,10,116,115,
  116,97,116,102,105,108,101,49,11,111,112,116,105,111,110,115,101,100,105,116,
  11,12,111,101,95,117,110,100,111,111,110,101,115,99,13,111,101,95,99,108,
  111,115,101,113,117,101,114,121,16,111,101,95,99,104,101,99,107,109,114,99,
  97,110,99,101,108,15,111,101,95,101,120,105,116,111,110,99,117,114,115,111,
  114,14,111,101,95,115,104,105,102,116,114,101,116,117,114,110,12,111,101,95,
  101,97,116,114,101,116,117,114,110,20,111,101,95,114,101,115,101,116,115,101,
  108,101,99,116,111,110,101,120,105,116,13,111,101,95,101,110,100,111,110,101,
  110,116,101,114,13,111,101,95,97,117,116,111,115,101,108,101,99,116,25,111,
  101,95,97,117,116,111,115,101,108,101,99,116,111,110,102,105,114,115,116,99,
  108,105,99,107,16,111,101,95,97,117,116,111,112,111,112,117,112,109,101,110,
  117,13,111,101,95,107,101,121,101,120,101,99,117,116,101,25,111,101,95,99,
  104,101,99,107,118,97,108,117,101,112,97,115,116,115,116,97,116,114,101,97,
  100,12,111,101,95,115,97,118,101,118,97,108,117,101,12,111,101,95,115,97,
  118,101,115,116,97,116,101,0,10,111,110,115,101,116,118,97,108,117,101,7,
  14,120,121,109,97,114,107,101,114,115,101,116,118,97,108,10,118,97,108,117,
  101,114,97,110,103,101,5,0,0,0,0,0,0,0,128,255,63,13,114,101,
  102,102,111,110,116,104,101,105,103,104,116,2,14,3,118,97,108,5,174,71,
  225,122,20,174,71,225,252,191,2,109,105,5,0,0,0,0,0,0,0,128,
  255,191,2,109,97,5,0,0,0,0,0,0,0,128,255,63,0,0,9,116,
  115,116,97,116,102,105,108,101,10,116,115,116,97,116,102,105,108,101,49,8,
  102,105,108,101,110,97,109,101,6,10,115,116,97,116,117,115,46,115,116,97,
  4,108,101,102,116,2,112,3,116,111,112,3,136,0,0,0,10,116,105,109,
  97,103,101,108,105,115,116,9,105,109,97,103,101,108,105,115,116,10,109,111,
  110,111,99,104,114,111,109,101,9,5,119,105,100,116,104,2,33,6,104,101,
  105,103,104,116,2,33,5,99,111,117,110,116,2,1,4,108,101,102,116,2,
  112,3,116,111,112,2,104,5,105,109,97,103,101,10,68,2,0,0,0,0,
  0,0,3,0,0,0,33,0,0,0,33,0,0,0,8,1,0,0,0,0,
  0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
  0,0,0,0,0,0,0,0,0,0,0,0,0,0,40,230,152,10,0,0,
  0,0,22,0,9,0,0,192,7,0,36,243,35,0,0,248,63,0,0,0,
  0,0,0,254,255,0,16,219,253,9,128,255,255,3,0,0,0,0,192,255,
  255,7,0,0,0,0,224,255,255,15,0,0,0,0,224,255,255,15,254,255,
  0,0,240,63,248,31,0,0,0,0,240,15,224,31,0,0,0,0,248,7,
  192,63,254,255,0,0,248,3,128,63,0,0,0,0,248,3,128,63,0,0,
  0,0,252,1,0,127,254,255,0,0,252,1,0,127,166,20,0,235,252,1,
  0,127,216,58,0,0,252,1,0,127,254,255,0,0,252,1,0,127,254,180,
  0,0,248,3,128,63,254,216,0,0,248,3,128,63,254,255,0,0,248,7,
  192,63,254,252,0,0,240,15,224,31,254,254,0,0,240,63,248,31,254,255,
  0,252,224,255,255,15,0,0,0,0,224,255,255,15,254,255,0,0,192,255,
  255,7,254,255,0,0,128,255,255,3,126,220,0,0,0,254,255,0,254,255,
  0,0,0,248,63,0,254,255,0,198,0,192,7,0,206,110,0,235,0,0,
  0,0,234,255,235,0,0,0,0,0,254,255,235,43,0,0,0,0,112,164,
  143,10,0,0,0,0,22,0,9,0,0,192,7,0,40,243,35,0,0,248,
  63,0,0,0,0,0,0,254,255,0,96,230,152,10,128,255,255,3,0,0,
  0,0,192,255,255,7,244,253,241,185,224,255,255,15,0,0,0,0,224,255,
  255,15,0,0,0,0,240,63,248,31,66,1,0,0,240,15,224,31,0,0,
  0,0,248,7,192,63,0,0,0,0,248,3,128,63,0,0,0,0,248,3,
  128,63,0,0,0,0,252,1,0,127,0,0,0,0,252,1,0,127,254,255,
  235,0,252,1,0,127,234,135,5,0,252,1,0,127,80,249,150,0,252,1,
  0,127,0,0,0,0,248,3,128,63,102,255,135,0,248,3,128,63,244,90,
  200,0,248,7,192,63,0,0,0,0,240,15,224,31,16,255,233,0,240,63,
  248,31,80,0,0,0,224,255,255,15,0,0,0,0,224,255,255,15,12,255,
  240,0,192,255,255,7,0,0,0,0,128,255,255,3,0,0,0,0,0,254,
  255,0,102,255,149,0,0,248,63,0,0,0,0,198,0,192,7,0,254,255,
  235,0,0,0,0,0,236,146,9,0,0,0,0,0,254,255,235,43,0,0,
  0)
 );

initialization
 registerobjectdata(@objdata,tmainfo,'');
end.
