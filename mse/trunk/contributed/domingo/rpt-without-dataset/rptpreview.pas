unit rptpreview;
{$ifdef FPC}{$mode objfpc}{$h+}{$endif}
interface
uses
 mseglob,mseguiglob,mseapplication,msestat,msemenus,msegui,msegraphics,
 msegraphutils,mseevent,mseclasses,mseforms,msebitmap,mseimage,msedataedits,
 msedatanodes,mseedit,msefiledialog,msegrids,mselistbrowser,msestrings,msesys,
 msetypes,msesimplewidgets,msewidgets, msereport;
type
 trptpreviewfo = class(tmseform)
   imgPreview: timage;
   gridPages: tstringgrid;
   tbutton1: tbutton;
   tbutton2: tbutton;
   fileSaveDialog: tfiledialog;
   procedure doInit(const sender: TObject);
   procedure pageFinished(const sender: tcustomreportpage;
                   const acanvas: tcanvas);
   procedure pageFinished2(const sender: tcustomreportpage;
                   const acanvas: tcanvas);
   procedure rptFinished(const sender: TObject);                   
   procedure doFinish(const sender: TObject);
   procedure gridCellEvent(const sender: TObject; var info: celleventinfoty);
   procedure doSavePageImage(const sender: TObject);

   procedure showReport(rpt: TReport);
   
   protected
    bitmapCanvas : tmaskedbitmap;
    imagePages : array of tmaskedbitmap;
    imagePagesCompressed : array of cardinalarty;
    rptImgSize: sizety
 end;
var
 rptpreviewfo: trptpreviewfo;
implementation
uses
 rptpreview_mfm, mseformatbmpico, mseformatjpg, mseformatpng, 
 mseformatpnm, mseformattga, mseformatxpm, nods, sysutils, 
 msestream, fpwritejpeg;
 
procedure trptpreviewfo.doInit(const sender: TObject);
begin
	bitmapCanvas := tmaskedbitmap.Create(false);
end;

procedure trptpreviewfo.showReport(rpt: TReport);
begin
	rpt.onpageafterpaint := @pageFinished;
	rpt.onreportfinished := @rptFinished;
	bitmapCanvas.size := rpt.size;
	rpt.color := cl_white;
	rpt.render(bitmapCanvas.canvas);
end;

procedure trptpreviewfo.pageFinished(const sender: tcustomreportpage;
               const acanvas: tcanvas);
var
	ipage : cardinalarty;               
begin
	//writeln('Page finished ' + IntToStr(sender.pagenum));
	if not sender.report.prepass then
	begin
		gridPages.appendrow(IntToStr(sender.pagenum+1));
		setLength(imagePagesCompressed, sender.pagenum+1);
		rptImgSize := bitmapCanvas.size;
		ipage := bitmapCanvas.compressdata;
		imagePagesCompressed[high(imagePagesCompressed)] := ipage;
	end;
end;

procedure trptpreviewfo.pageFinished2(const sender: tcustomreportpage;
               const acanvas: tcanvas);
var
	ipage : tmaskedbitmap;               
begin
	//writeln('Page finished ' + IntToStr(sender.pagenum));
	if not sender.report.prepass then
	begin
		gridPages.appendrow(IntToStr(sender.pagenum+1));
		setLength(imagePages, sender.pagenum+1);
		ipage := tmaskedbitmap.Create(false);
		ipage.Assign(bitmapCanvas);
		imagePages[high(imagePages)] := ipage;
		imgPreview.bitmap.alignment := [al_xcentered];
	end;
end;

procedure trptpreviewfo.doFinish(const sender: TObject);
var
	i : integer;
begin
	bitmapCanvas.Destroy;
	for i := 0 to high(imagePages) do
		imagePages[i].Destroy;
end;

procedure trptpreviewfo.gridCellEvent(const sender: TObject;
               var info: celleventinfoty);
var
	i : integer;               
begin
	if (info.eventkind = cek_focusedcellchanged) then
	begin
		if gridPages.row >= 0 then
		begin
			//writeln(gridPages[0][gridPages.row]);
			i := StrToInt(gridPages[0][gridPages.row]);
			//imgPreview.bitmap := imagePages[i-1];
			imgPreview.bitmap.decompressdata(rptImgSize, imagePagesCompressed[i-1]);
		end;
	end;
end;

procedure trptpreviewfo.rptFinished(const sender: TObject);
begin
	if gridPages.RowCount > 0 then gridPages.Row := 0;
end;

procedure trptpreviewfo.doSavePageImage(const sender: TObject);
var
	fn : string;
	stream: tmsefilestream;
	jpgwriter : TFPWriterJPEG;
begin
	if gridPages.RowCount = 0 then exit;
	if fileSaveDialog.execute = mr_Ok then
	begin
		fn := fileSaveDialog.controller.filename;
		//writeln(fn);
		stream:= tmsefilestream.create(fn,fm_create);
		jpgwriter := TFPWriterJPEG.Create;
 		try
 			//jpgwriter.ImageWrite(stream, imagePages[gridPages.row]);
 		finally
  			stream.free;
  			jpgwriter.free;
  		end;
	end;
end;

end.
