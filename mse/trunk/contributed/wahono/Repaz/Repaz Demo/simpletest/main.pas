unit main;
{$ifdef FPC}{$mode objfpc}{$h+}{$endif}
interface
uses
 mseglob,mseguiglob,mseapplication,msestat,msemenus,msegui,msegraphics,
 msegraphutils,mseevent,mseclasses,mseforms,msesimplewidgets,
 msewidgets,repazcomponents,db,msedb,msebufdataset,msedatabase,msesqldb,msqldb,
 sysutils,repazdatasources;

type
 tmainfo = class(tmseform)
   tbutton1: tbutton;
   TRepaz1: TRepaz;
   dso: tmsedatasource;
   dse: tmsesqlquery;
   tbutton2: tbutton;
   trepazdatasources1: trepazdatasources;
   tbutton3: tbutton;
   tbutton4: tbutton;
   tbutton5: tbutton;
   tbutton6: tbutton;
   tlabel1: tlabel;
   procedure showdesign(const sender: TObject);
   procedure filldb(const sender: TObject);
   procedure repexecute(const sender: TObject);
   procedure reppreview(const sender: TObject);
   procedure repprint(const sender: TObject);
   procedure repps(const sender: TObject);
 end;
var
 mainfo: tmainfo;
implementation
uses
 main_mfm,mseintegerenter;
procedure tmainfo.showdesign(const sender: TObject);
begin
	trepaz1.reportdesign;
end;

procedure tmainfo.filldb(const sender: TObject);
var
	int1,int2: integer;
begin
	dse.active:= true;
	int2:= 100;
	if integerenter(int2,1,9999999999,'How much record to add to database?','')=mr_ok then begin
		for int1:=0 to int2 do begin
 		dse.append;
 		dse.fieldbyname('field1').value:='This is field1 value for row '+ inttostr(int1);
 		dse.fieldbyname('field2').value:='This is field2 value for row ' + inttostr(int1);
 		dse.fieldbyname('value1').value:=int1;
 		dse.applyupdate;
		end;
	end;
end;

procedure tmainfo.repexecute(const sender: TObject);
begin
	trepaz1.reportexecute(true);
end;

procedure tmainfo.reppreview(const sender: TObject);
begin
	trepaz1.reportpreview;
end;

procedure tmainfo.repprint(const sender: TObject);
begin
	trepaz1.reportprint(true);
end;

procedure tmainfo.repps(const sender: TObject);
begin
	trepaz1.reportpostscript;
end;

end.
