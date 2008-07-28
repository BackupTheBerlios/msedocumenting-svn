unit nods;
{$ifdef FPC}{$mode objfpc}{$h+}{$endif}
interface
uses
 mseglob,mseguiglob,mseapplication,msestat,msemenus,msegui,msegraphics,
 msegraphutils,mseevent,mseclasses,mseforms,msereport,msesplitter,msestrings,
 msesimplewidgets,msewidgets,msedataedits,mseedit,msepostscriptprinter,
 mseprinter,msetypes;

type
 tnodsre = class(treport)
   treportpage1: treportpage;
   tbandarea1: tbandarea;
   tlabel1: tlabel;
   header: trecordband;
   dataRec: trecordband;
   psprn: tpostscriptprinter;
   procedure fillDataLine(const sender: tcustomrecordband; var empty: Boolean);
   procedure doInit(const sender: TObject);
   procedure reportLoaded(const sender: TObject);
   
   protected
   dataCount : Integer;
 end;
var
 nodsre: tnodsre;
implementation
uses
 nods_mfm, sysutils;
 
procedure tnodsre.fillDataLine(const sender: tcustomrecordband;
               var empty: Boolean);
var
	snum : string;               
begin
	if dataCount > 10 then 
	begin
		exit;
	end;
	inc(dataCount);
	snum := IntToStr(dataCount);
	dataRec.tabs[0].value := snum;
	dataRec.tabs[1].value := 'A data name ' + snum;
	dataRec.tabs[2].value := 'phone n# ' + snum;
	empty := False;
end;

procedure tnodsre.doInit(const sender: TObject);
begin
	dataCount := 0;
end;

procedure tnodsre.reportLoaded(const sender: TObject);
begin
	render(psprn{,ttextstream.create('test.ps',fm_create)});
end;

end.
