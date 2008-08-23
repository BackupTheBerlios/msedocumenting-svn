unit productprices;
{$ifdef FPC}{$mode objfpc}{$h+}{$endif}
interface
uses
 mseglob,mseguiglob,mseapplication,msestat,msemenus,msegui,msegraphics,
 msegraphutils,mseevent,mseclasses,mseforms,msereport,msesimplewidgets,
 msewidgets,msedataedits,mseedit,msegdiprint,mseprinter,msestrings,msetypes,
 msepostscriptprinter,sysutils, msesplitter,mseimage,db,mserichstring;

type
 tproductpricesre = class(treport)
   treportpage1: treportpage;
   tlabel2: tlabel;
   psprn: tpostscriptprinter;
   tbandarea1: tbandarea;
   tgroupbox2: tgroupbox;
   treppagenumdisp1: treppagenumdisp;
   trepprintdatedisp1: trepprintdatedisp;
   tlabel1: tlabel;
   tlabel3: tlabel;
   timage2: timage;
   timage1: timage;
   treppagenumdisp2: treppagenumdisp;
   bandHeader: trecordband;
   gdiprn: tgdiprinter;
   bandProduct: trecordband;
   bandGroupTitle: trecordband;
   bandDummy: trecordband;
   procedure reportLoaded(const sender: TObject);
   procedure checkGroup(const sender: tcustomrecordband; var empty: Boolean);
   procedure doInit(const sender: TObject);
   procedure feedData(const sender: tcustomrecordband; var empty: Boolean);
   procedure updateCounter(const sender: tcustomrecordband);
   procedure setRecordsPtr(ptr : pointer);
   procedure resetCounter(const sender: tcustomreport);
   protected
    showGroup : boolean;
    recordsPtr : pointer;
    recNo : integer;
    gProductGroup, gProduct  : string;
 end;
var
 productpricesre: tproductpricesre;
implementation
uses
 productprices_mfm,msestream,msesys, datagrid, mseformatstr, msedrawtext;
 
procedure tproductpricesre.reportLoaded(const sender: TObject);
begin
	render(
		//{$ifdef mswindows}
		//gdiprn
		//{$else}
		psprn
		//{$endif}
		,ttextstream.create('test.ps',fm_create));
end;

procedure tproductpricesre.checkGroup(const sender: tcustomrecordband;
               var empty: Boolean);
begin
	if showGroup then empty := false;
end;

procedure tproductpricesre.doInit(const sender: TObject);
begin
	recordsPtr := nil;
end;

procedure tproductpricesre.setRecordsPtr(ptr : pointer);
begin
	recordsPtr := ptr;
end;

procedure tproductpricesre.feedData(const sender: tcustomrecordband;
               var empty: Boolean);
var
	records : tpricesrecartyPtr; 
	rec : tpricesrec; 
	procedure showBand(bnd : tcustomrecordband);
	var
		bo : boolean;
	begin
		showGroup := true;
		bnd.render(bo);
		showGroup := false;
	end;             
begin
	if recordsPtr = nil then exit;
	records := tpricesrecartyPtr(recordsPtr);
	if recNo >= length(records^) then exit;
	rec := records^[recNo];

	if gProductGroup <> rec.group then
	begin
		gProductGroup := rec.group;
		bandGroupTitle.tabs[0].value := gProductGroup;
		showBand(bandGroupTitle);
	end;

	if gProduct <> rec.description then
	begin
		gProduct := rec.description;
		bandProduct.tabs[0].value := IntToStr(rec.id);
		bandProduct.tabs[1].textflags := bandProduct.tabs[1].textflags - [tf_right];  
		bandProduct.tabs[1].value := gProduct;
		bandProduct.tabs[3].value := formatfloatmse(rec.main_price, '0.00');;
	end
	else
	begin
		bandProduct.tabs[0].value := '';
		bandProduct.tabs[1].textflags := bandProduct.tabs[1].textflags + [tf_right];  
		bandProduct.tabs[1].value := 'buys starting from';
		bandProduct.tabs[3].value := formatfloatmse(rec.qty_price, '0.00');
	end;
	bandProduct.tabs[2].value := formatfloatmse(rec.quantity, '0.###');
	showBand(bandProduct);
	empty := false;
end;

procedure tproductpricesre.updateCounter(const sender: tcustomrecordband);
begin
	inc(recNo);
end;

procedure tproductpricesre.resetCounter(const sender: tcustomreport);
begin
	showGroup := false;
	recNo := 0;
	gProductGroup := '';
	gProduct := '';
end;
 
end.
