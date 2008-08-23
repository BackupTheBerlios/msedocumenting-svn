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
   bandDummy: trecordband;
   procedure doInit(const sender: TObject);override;
   procedure checkGroup(const sender: tcustomrecordband; var empty: Boolean);
   procedure checkNextRecord(const sender: TObject);
   procedure fillDataLine(const sender: tcustomrecordband; 
   		var empty: Boolean);override;
   procedure goNext(const sender: tcustomrecordband);
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
	procedure showBand(bnd : tcustomrecordband);
	var
		bo : boolean;
	begin
		showGroup := true;
		bnd.render(bo);
		showGroup := false;
	end;             
begin
	if dataCount > 100 then exit;
	snum := IntToStr(dataCount);

	if (dataCount mod 10) = 0 then groupOf := '10'
	else if (dataCount mod 5) = 0 then groupOf := '5'
	else groupOf := '';

	if groupOf <> '' then
	begin
		bandGroup.tabs[0].value := 'Group of ' + groupOf + '  / ' + snum;
		showBand(bandGroup);
	end;

	dataRec.tabs[0].value := snum;
	dataRec.tabs[1].value := 'A data name ' + snum;
	dataRec.tabs[2].value := 'phone n# ' + snum;
	showBand(dataRec);

	empty := false;
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

procedure tnodsgroupingfo.goNext(const sender: tcustomrecordband);
begin
	advanceCounter(sender);
end;
 
end.
