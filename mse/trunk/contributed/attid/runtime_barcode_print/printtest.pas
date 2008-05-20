program printtest;

{$ifdef FPC}{$mode objfpc}{$h+}{$INTERFACES CORBA}{$endif}
{$ifdef FPC}
 {$ifdef mswindows}{$apptype console}{$endif}
{$endif}

uses
 {$ifdef FPC}{$ifdef linux}cthreads,{$endif}{$endif}msegui,
 mseforms,main;

begin
 application.createform(tmainfo,mainfo);
 application.run;
end.
