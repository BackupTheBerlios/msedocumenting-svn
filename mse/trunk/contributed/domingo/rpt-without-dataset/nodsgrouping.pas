unit nodsgrouping;
{$ifdef FPC}{$mode objfpc}{$h+}{$endif}
interface
uses
 mseglob,mseguiglob,mseapplication,msestat,msemenus,msegui,msegraphics,
 msegraphutils,mseevent,mseclasses,mseforms,nods,db,msereport,mserichstring,
 msesplitter,msestrings;

type
 tnodsgroupingfo = class(tnodsre)
   bandGroup: trecordband;
   procedure doInit(const sender: TObject);override;
   procedure checkGroup(const sender: tcustomrecordband; var empty: Boolean);
   procedure checkNextRecord(const sender: TObject);
   procedure fillDataLine(const sender: tcustomrecordband; 
   		var empty: Boolean);override;
   protected
   	showGroup : boolean;
 end;
var
 nodsgroupingfo: tnodsgroupingfo;
implementation
uses
 nodsgrouping_mfm, sysutils;

procedure tnodsgroupingfo.doInit(const sender: TObject);
begin
	inherited;
	showGroup := false;
end;

procedure tnodsgroupingfo.fillDataLine(const sender: tcustomrecordband;
               var empty: Boolean);
var
	snum : string;   
	bo : boolean;   
	groupOf : string;         
begin
	if dataCount > 100 then exit;

	if (dataCount mod 10) = 0 then groupOf := '10'
	else if (dataCount mod 5) = 0 then groupOf := '5'
	else groupOf := '';

	if groupOf <> '' then
	begin
		application.unlock;
		try
			bandGroup.tabs[0].value := 'Group of ' + groupOf + '  / ' + IntToStr(dataCount);
			showGroup := true;
			bandGroup.render(canvas,bo);
		finally
			showGroup := false;
			application.lock;
		end;
	end;


	snum := IntToStr(dataCount);
	dataRec.tabs[0].value := snum;
	dataRec.tabs[1].value := 'A data name ' + snum;
	dataRec.tabs[2].value := 'phone n# ' + snum;
	empty := False;
end;
 
procedure tnodsgroupingfo.checkGroup(const sender: tcustomrecordband;
               var empty: Boolean);
begin
	if showGroup then empty := false;
end;

procedure tnodsgroupingfo.checkNextRecord(const sender: TObject);
begin
	writeln('next record for ' + twidget(sender).name);
end;
 
end.
