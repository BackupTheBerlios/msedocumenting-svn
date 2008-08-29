unit productlabels;
{$ifdef FPC}{$mode objfpc}{$h+}{$endif}
interface
uses
 mseglob,mseguiglob,mseapplication,msestat,msemenus,msegui,msegraphics,
 msegraphutils,mseevent,mseclasses,mseforms,msereport,db,mserichstring,
 msesplitter,msestrings,mseimage,msesimplewidgets,msewidgets;

type
 tproductlabelsre = class(treport)
   treportpage1: treportpage;
   tileLabels: ttilearea;
   trecordband1: trecordband;
   imageBarCode: timage;
   labelReference: tlabel;
   procedure doPaintLabel(const sender: tbasebandarea; const acanvas: tcanvas);
   procedure doBeforeRender(const sender: tbasebandarea);
   procedure doFirstArea(const sender: tbasebandarea);
   procedure doLastArea(const sender: tbasebandarea);
   procedure feedData(const sender: tcustomrecordband; var empty: Boolean);
   procedure doRestart(const sender: tcustomreport);
   procedure setRecordsPtr(ptr : pointer);

   procedure updateCounter(const sender: tcustomrecordband);
   protected
    recordsPtr : pointer;
    recNo, lastId : integer;
 end;
var
 productlabelsre: tproductlabelsre;
implementation
uses
 productlabels_mfm, sysutils, ubarcode, datagrid;
 
procedure tproductlabelsre.setRecordsPtr(ptr : pointer);
begin
	recordsPtr := ptr;
end;
 
procedure tproductlabelsre.doPaintLabel(const sender: tbasebandarea;
               const acanvas: tcanvas);
begin
    //writeln('onpaint');
end;

procedure tproductlabelsre.doBeforeRender(const sender: tbasebandarea);
begin
    //writeln('beforerender');
end;

procedure tproductlabelsre.doFirstArea(const sender: tbasebandarea);
begin
    //writeln('firstarea');
end;

procedure tproductlabelsre.doLastArea(const sender: tbasebandarea);
begin
    //writeln('lastarea');
end;

procedure tproductlabelsre.feedData(const sender: tcustomrecordband;
               var empty: Boolean);
var 
    b : TasBarcode;               
	records : tpricesrecartyPtr; 
	rec : tpricesrec;
begin
    //writeln('doRenderRecord');
	if recordsPtr = nil then exit;
	records := tpricesrecartyPtr(recordsPtr);
	if recNo >= length(records^) then exit;
	rec := records^[recNo];

    while lastId = rec.id do
    begin
        inc(recNo);
        if recNo >= length(records^) then exit;
        rec := records^[recNo];
    end; 
    lastId := rec.id;

    labelReference.caption := '<' +IntToStr(rec.id) + '> ' + rec.reference;

    b := TasBarcode.Create(Self);
    b.Text := IntToStr(rec.id);

    b.Typ := bcCode128B;
  
    //bcoNone, bcoCode, bcoTyp, bcoBoth
    b.showtext := bcoBoth;
  
    //    stpTopLeft,     stpTopRight,     stpTopCenter,     stpBottomLeft,    stpBottomRight,    stpBottomCenter
    b.ShowTextPosition := stpTopCenter;
  
    imageBarCode.bitmap.size := imageBarCode.size;
    imageBarCode.bitmap.init(cl_white);
    b.Height := imageBarCode.size.cy;
    b.Width := imageBarCode.size.cx;
    b.Left := round(((imageBarCode.size.cx - 4)/2) - (b.width/2));
    b.Checksum := true;  
    
    b.DrawBarcode(imageBarCode.bitmap.canvas);
  
    b.free;           
      
    empty := false;
end;

procedure tproductlabelsre.doRestart(const sender: tcustomreport);
begin
    recNo := 0;
    lastId := 0;
    //writeln('doRestart');
end;

procedure tproductlabelsre.updateCounter(const sender: tcustomrecordband);
begin
    inc(recNo);
end;

end.
