unit main;
{$ifdef FPC}{$mode objfpc}{$h+}{$endif}
interface
uses
 mseglob,mseguiglob,mseapplication,msestat,msemenus,msegui,msegraphics,
 msegraphutils,mseevent,mseclasses,mseforms,msesimplewidgets,msewidgets;

type
 tmainfo = class(tmseform)
   tbutton1: tbutton;
   procedure doPrint(const sender: TObject);
 end;
var
 mainfo: tmainfo;
implementation
uses
 main_mfm, nods;
procedure tmainfo.doPrint(const sender: TObject);
begin
	tnodsre.create(nil);
end;

end.
