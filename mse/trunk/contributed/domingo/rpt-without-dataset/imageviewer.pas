unit imageviewer;
{$ifdef FPC}{$mode objfpc}{$h+}{$endif}
interface
uses
 mseglob,mseguiglob,mseapplication,msestat,msemenus,msegui,msegraphics,
 msegraphutils,mseevent,mseclasses,mseforms,msebitmap,mseimage,msedataedits,
 msedatanodes,mseedit,msefiledialog,msegrids,mselistbrowser,msestrings,msesys,
 msetypes,msesimplewidgets,msewidgets;
type
 timageviewerfo = class(tmseform)
   imgPreview: timage;
   imagFileName: tfilenameedit;
   btnLoadImage: tbutton;
   procedure doLoadImage(const sender: TObject);
 end;
var
 imageviewerfo: timageviewerfo;
implementation
uses
 imageviewer_mfm, mseformatbmpico, mseformatjpg, mseformatpng, 
 mseformatpnm, mseformattga, mseformatxpm;
 
procedure timageviewerfo.doLoadImage(const sender: TObject);
begin
	if imagFileName.value <> '' then
	begin
		imgPreview.bitmap.loadfromfile(imagFileName.value);
	end;
end;

end.
