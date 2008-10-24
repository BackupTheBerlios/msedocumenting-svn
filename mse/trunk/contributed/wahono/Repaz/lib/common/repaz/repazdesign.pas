{*********************************************************}
{                                                         }
{                 Repaz Designer                          }
{                                                         }
{*********************************************************}
{            Copyright (c) 2008 Sri Wahono                }
{*********************************************************}

{                                                         }
{ License Agreement:                                      }
{                                                         }
{ This library is distributed in the hope that it will be }
{ useful, but WITHOUT ANY WARRANTY; without even the      }
{ implied warranty of MERCHANTABILITY or FITNESS FOR      }
{ A PARTICULAR PURPOSE.  See the GNU Lesser General       }
{ Public License for more details.                        }
{                                                         }
{ The source code of the Repaz libraries and packages are }
{ distributed under the Library GNU General Public        }
{ License with the following  modification:               }
{ As a special exception, the copyright holders of this   }
{ library give you permission to link this library with   }
{ independent modules to produce an executable,           }
{ regardless of the license terms of these independent    }
{ modules, and to copy and distribute the resulting       }
{ executable under terms of your choice, provided that    }
{ you also meet, for each linked independent module,      }
{ the terms and conditions of the license of that module. }
{ An independent module is a module which is not derived  }
{ from or based on this library. If you modify this       }
{ library, you may extend this exception to your version  }
{ of the library, but you are not obligated to do so.     }
{ If you do not wish to do so, delete this exception      }
{ statement from your version.                            }
{                                                         }
{*********************************************************}

unit repazdesign;
{$ifdef FPC}{$mode objfpc}{$h+}{$endif}
interface
uses
 mseglob,mseguiglob,mseapplication,msestat,msemenus,msegui,msegraphics,
 msegraphutils,mseevent,mseclasses,mseforms,msesimplewidgets,msewidgets,
 msebitmap,msetabs,msedataedits,mseedit,msestrings,msetypes,classes,db,msegrids,
 msesplitter,compdesigner,msedial,msedispwidgets,msereal,mseimage,repazcomponents,
 repaz_bmp,compdesignintf,msedb,msedatanodes,msefiledialog,mselistbrowser,msesys,
 sysutils,mseact,msedatalist,typinfo,mselookupbuffer,msedbedit,msewidgetgrid,
 msestatfile,msetoolbar;
type
 raeditorstatety = (ras_tabupdating,ras_mouseinclient);
 raeditorstatesty = set of raeditorstatety;
 trepazdesignfo = class(tmseform)
   tsplitter1: tsplitter;
   ttabpage4: ttabpage;
   tstringgrid2: tstringgrid;
   tdropdownlistedit2: tdropdownlistedit;
   xdisp: trealdisp;
   ydisp: trealdisp;
   tbutton2: tbutton;
   tcomponentpallete1: tcomponentpallete;
   tmainmenu1: tmainmenu;
   tfiledialog1: tfiledialog;
   tstatfile1: tstatfile;
   tgroupbox1: tgroupbox;
   tobjectinspector1: tobjectinspector;
   ttoolbar1: ttoolbar;
   timagelist1: timagelist;
   tsplitter5: tsplitter;
   pagedisp: tstringdisp;
   tscrollbox1: tscrollbox;
   dialh: tdial;
   dialv: tdial;
   cpaper: tcomponentdesigner;
   procedure cpaper_onresize(const sender: TObject);
   procedure cpaper_onmouseevent(const sender: twidget;
                   var info: mouseeventinfoty);
   procedure reportcont_onchildscaled(const sender: TObject);
   procedure reportcont_onscroll(const sender: twidget; const point: pointty);
   procedure repazdesignfo_onloaded(const sender: TObject);
   procedure repazdesignfo_onshow(const sender: TObject);
   procedure reportexit(const sender: TObject);
   procedure reportopen(const sender: TObject);
   procedure reportsave(const sender: TObject);
   procedure reportnew(const sender: TObject);
   procedure reportpreview(const sender: TObject);
   procedure reportsaveas(const sender: TObject);
   procedure reportsetup(const sender: TObject);
   procedure reportoptions(const sender: TObject);
   procedure priorpage(const sender: TObject);
   function getactivepage: string;
   procedure newpage(const sender: TObject);
   procedure deletepage(const sender: TObject);
   procedure showhidegrid(const sender: TObject);
   procedure nextpage(const sender: TObject);
   procedure snaponoff(const sender: TObject);
  private
   fstate: raeditorstatesty;
  protected
   procedure updatedials;
   function unitscale: real;
   procedure setmousemarkers(const avalue: pointty; const source: twidget);                   
 end;

 tdatasourcepropeditor = class(tstringpropeditor)
  protected
   function getdefaultstate: propertystatesty; override;
  public
   //procedure setvalue(const value: msestring); override;
   function getvalues: msestringarty; override;
 end;

 tlookupbufferpropeditor = class(tstringpropeditor)
  protected
   function getdefaultstate: propertystatesty; override;
  public
   function getvalues: msestringarty; override;
 end;

 tdbfieldnamepropeditor = class(tstringpropeditor)
  private
   fnocalc: boolean;
  protected
   fdbeditinfointf: idbeditinfo;
   function getdefaultstate: propertystatesty; override;
  public
   function getvalues: msestringarty; override;
 end;

 treptabulatoreditor = class(tclasselementeditor)
  public
   function getvalue: msestring; override;
 end;
 
 treptabulatorseditor = class(tpersistentarraypropeditor)
  protected
   function geteditorclass: propeditorclassty; override;
 end;

 texpressionpropeditor = class(tstringpropeditor)
   function getdefaultstate: propertystatesty;override;
  public
   procedure edit; override;
   function getvalue: msestring; override;
   procedure setvalue(const value: msestring); override;
 end;
 
var
 repazdesignfo: trepazdesignfo;
 report: trepaz;
 
procedure editrepaz(arepaz: trepaz);

implementation
uses
 repazdesign_mfm,msefileutils;
type
 tcomponent1 = class(tcomponent);
 tpropeditor1 =  class(tpropeditor);

procedure editrepaz(arepaz: trepaz);
var
 dialog: trepazdesignfo;
 int1: integer;
 tmpfilename: filenamety;
 bo1,bo2: boolean;
begin
 report:= arepaz;
 report.assign(arepaz);
 dialog:= trepazdesignfo.create(nil);
 dialog.visible:= false;
 try
  with dialog do begin
   updatedials;
   if report.filename<>'' then begin
    bo1:= isrelativepath(report.filename);
    if bo1 then begin
     tmpfilename:= getcurrentdir + copy(report.filename,3,length(report.filename)-2);
    end else begin 
     tmpfilename:= report.filename;
    end;
    bo2:= findfile(tmpfilename);
   end else begin
    bo2:= false;
   end;
   if not bo2 then begin
    if askyesno('Report file not found! Create new report?','Confirmation',mr_ok) then begin
     tmpfilename:= getcurrentdir + 'report1.raz'; 
     arepaz.filename:= '../report1.raz';
     report.filename:= '../report1.raz';
     reportnew(nil);
     show(true);
    end;
   end else begin
    dialog.cpaper.loadfromfile(tmpfilename);
    pagedisp.value:= dialog.getactivepage;
    show(true);
   end;
  end;
 except
  dialog.Free;
 end;
end;
 
function getreport: TRepaz;
begin
 result:= report;
end;

procedure showpreview;
begin
 if not (csdesigning in report.componentstate) then begin
  report.reportpreview;
 end else begin
  tcomponent1(report).setdesigning(false);
  tcomponent1(report).loaded;
  report.reportpreview;
 end;
end;

procedure trepazdesignfo.updatedials;
 procedure adjustticks(const adial: tcustomdialcontroller);
 begin
  with adial do begin
   if report.reportunit=Milimeter then begin
    ticks[0].intervalcount:= range/10.0;
    ticks[1].intervalcount:= range/5.0;
    ticks[2].intervalcount:= range/1.0;
    xdisp.format:= '0.0 mm';
    ydisp.format:= '0.0 mm';
   end else if report.reportunit=Inch then begin
    ticks[0].intervalcount:= range; ///16.0;
    ticks[1].intervalcount:= range*2.0;
    ticks[2].intervalcount:= range*16.0;
    xdisp.format:= '0.0 inch';
    ydisp.format:= '0.0 inch';
   end;
  end;
 end; 
begin
 dialh.bounds_cx:= cpaper.bounds_cx;
 dialv.bounds_cy:= cpaper.bounds_cy;
 if dialh.bounds_cx > 0 then begin
  dialh.dial.range:= dialh.bounds_cx / report.unitscale; //mm
 end;
 if dialv.bounds_cy > 0 then begin
  dialv.dial.range:= dialv.bounds_cy / report.unitscale; //mm
 end;
 dialh.dial.offset:= -cpaper.clientpos.x / report.unitscale;
 dialv.dial.offset:= -cpaper.clientpos.y / report.unitscale;
 adjustticks(dialh.dial);
 adjustticks(dialv.dial);
end;

function trepazdesignfo.unitscale: real;
begin
 if report = nil then begin
  result:= 3;
 end
 else begin
  result:= report.unitscale;
 end;
end;

procedure trepazdesignfo.cpaper_onresize(const sender: TObject);
begin
 updatedials;
end;

procedure trepazdesignfo.cpaper_onmouseevent(const sender: twidget;
               var info: mouseeventinfoty);
begin
 with info do begin
  case eventkind of
   ek_mouseleave: begin
    exclude(fstate,ras_mouseinclient);
    xdisp.value:= emptyreal;
    ydisp.value:= emptyreal;
    dialh.dial.markers[0].value:= emptyreal;
    dialv.dial.markers[0].value:= emptyreal;
   end;
   ek_mouseenter: begin
    include(fstate,ras_mouseinclient);
   end;
  end;
  if (eventkind in mouseposevents) and (ras_mouseinclient in fstate) then begin
   setmousemarkers(pos,sender);
  end;
 end;
end;

procedure trepazdesignfo.setmousemarkers(const avalue: pointty;
                                                    const source: twidget);
var
 pt1: pointty;
begin
 pt1:= avalue;
 xdisp.value:= pt1.x/report.unitscale + dialh.dial.offset;
 dialh.dial.markers[0].value:= xdisp.value;
 ydisp.value:= pt1.y/report.unitscale + dialv.dial.offset;
 dialv.dial.markers[0].value:= ydisp.value;
end;

procedure trepazdesignfo.reportcont_onchildscaled(const sender: TObject);
begin
 updatedials;
end;

procedure trepazdesignfo.reportcont_onscroll(const sender: twidget;
               const point: pointty);
begin
 //updatedials;
end;

procedure trepazdesignfo.repazdesignfo_onloaded(const sender: TObject);
begin
 registeredcomponents.regcomponents('Repaz',[TraBandArea,TraTileArea,TraBandGroup,TraReportPage,
                    TraRecordBand,TraValueDisplay,TraPageNumber,TraDatePrint,
                    TraSpacer]); 
 registeredcomponents.regcomponenttabhints(['Repaz'],['Report Components']);
 registeredcomponents.setinvisiblecomponents('Repaz',[TraReportPage]); 
 regpropeditor(typeinfo(msestring),TraTabulatorItem,'expression',texpressionpropeditor);
 regpropeditor(typeinfo(string),nil,'lookupbuffer',tlookupbufferpropeditor);
 regpropeditor(typeinfo(string),nil,'datasource',tdatasourcepropeditor);
 regpropeditor(typeinfo(string),nil,'visidatasource',tdatasourcepropeditor);
 regpropeditor(typeinfo(TraTabulators),nil,'',treptabulatorseditor);
 regpropeditor(typeinfo(TraCustomRecordBand),TraTabulators,'linksource',
                           tlocallinkcomponentpropeditor);
 regpropeditor(typeinfo(string),nil,'datafield',
        tdbfieldnamepropeditor);
 regpropeditor(typeinfo(string),TraCustomRecordBand,'visidatafield',
        tdbfieldnamepropeditor);
 regpropeditor(typeinfo(string),TraCustomRecordBand,'visigroupfield',
        tdbfieldnamepropeditor);
 regpropeditor(typeinfo(TraCustomRecordBand),TraCustomRecordBand,'nextband',
                                 tsisterwidgetpropeditor);
 regpropeditor(typeinfo(TraCustomRecordBand),TraCustomRecordBand,'nextbandifempty',
                                 tsisterwidgetpropeditor);
 tcomponentpallete1.updatebuttons;
 updatedials;
end;

procedure trepazdesignfo.repazdesignfo_onshow(const sender: TObject);
begin
 updatedials;
end;

procedure trepazdesignfo.reportexit(const sender: TObject);
begin
 window.close;
end;

procedure trepazdesignfo.reportopen(const sender: TObject);
var
 xx: filenamety;
 int1: integer;
begin
 tfiledialog1.dialogkind:= fdk_open;
 if tfiledialog1.execute=mr_ok then begin
  xx:= tfiledialog1.controller.filename;
  cpaper.loadfromfile(xx);
  for int1:=0 to cpaper.widgetcount-1 do begin
   if cpaper.widgets[int1] is TraReportPage then begin
    TraReportPage(cpaper.widgets[int1]).report:= report;
   end;
  end;
 end;
end;

procedure trepazdesignfo.reportsave(const sender: TObject);
var
 ffilename: filenamety;
 bo1: boolean;
 tmpfilename: filenamety;
begin
 ffilename:= getreport.filename;
 if ffilename<>'' then begin
  bo1:= isrelativepath(ffilename);
  if bo1 then begin
   tmpfilename:= getcurrentdir + copy(ffilename,3,length(ffilename)-2);
  end else begin 
   tmpfilename:= ffilename;
  end;
  cpaper.savetofile(tmpfilename);
 end else begin
  tfiledialog1.controller.captionsave:= 'Save Report';
  tfiledialog1.dialogkind:= fdk_save;
  if tfiledialog1.execute=mr_ok then begin
   ffilename:= tfiledialog1.controller.filename;
   if ffilename<>'' then begin
    cpaper.savetofile(ffilename);
    getreport.filename:= ffilename;
   end else begin
    showmessage('Please type report filename!');
   end;
  end; 
 end;
end;

procedure trepazdesignfo.reportnew(const sender: TObject);
var
 int1: integer;
 fnewpage: TraReportPage;
begin
 for int1:=0 to cpaper.widgetcount-1 do begin
  cpaper.widgets[int1].free;
 end;
 fnewpage:= TraReportPage.create(nil);
 fnewpage.report:= report;
 fnewpage.parentwidget:= cpaper;
 tcomponent1(fnewpage).setdesigning(true);
 cpaper.insertwidget(fnewpage,makepoint(0,0));
 fnewpage.name:= 'Page' + inttostr(cpaper.widgetcount);
 fnewpage.initnewwidget(1.0);
 fnewpage.visible:= true;
end;

procedure trepazdesignfo.reportpreview(const sender: TObject);
begin
 showpreview;
end;

procedure trepazdesignfo.reportsaveas(const sender: TObject);
var
 ffilename: filenamety;
 bo1: boolean;
 tmpfilename: filenamety;
begin
 ffilename:= getreport.filename;
 if ffilename<>'' then begin
  bo1:= isrelativepath(ffilename);
  if bo1 then begin
   tmpfilename:= getcurrentdir + copy(ffilename,3,length(ffilename)-2);
  end else begin 
   tmpfilename:= ffilename;
  end;
  tfiledialog1.controller.filename:= tmpfilename;
 end;
 tfiledialog1.controller.captionsave:= 'Save Report As';
 tfiledialog1.dialogkind:= fdk_save;
 if tfiledialog1.execute=mr_ok then begin
  ffilename:= tfiledialog1.controller.filename;
  if ffilename<>'' then begin
    cpaper.savetofile(ffilename);
  end else begin
   showmessage('Please type report filename!');
  end;
 end; 
end;

procedure trepazdesignfo.reportsetup(const sender: TObject);
begin
end;

procedure trepazdesignfo.reportoptions(const sender: TObject);
begin
end;

function trepazdesignfo.getactivepage: string;
var
 int1: integer;
begin
 result:='';
 for int1:=0 to cpaper.widgetcount-1 do begin
  if (cpaper.widgets[int1] is TraReportPage) and (cpaper.widgets[int1].visible) then begin
   result:= cpaper.widgets[int1].name;
   break;
  end;
 end;
end;

procedure trepazdesignfo.priorpage(const sender: TObject);
var
 int1: integer;
begin
 for int1:=0 to cpaper.widgetcount-1 do begin
  if pagedisp.value=cpaper.widgets[int1].name then begin
   if int1>0 then begin
    cpaper.widgets[int1].visible:= false;
    cpaper.widgets[int1-1].visible:= true;
    pagedisp.value:= cpaper.widgets[int1-1].name;
    break;
   end else begin
    showmessage('This is first page!');
   end;
  end;
 end;
end;

procedure trepazdesignfo.newpage(const sender: TObject);
var
 int1: integer;
 fnewpage: TraReportPage;
 fwidth,fheight: integer;
begin
 for int1:=0 to cpaper.widgetcount-1 do begin
  cpaper.widgets[int1].visible:=false;
  fwidth:=cpaper.widgets[int1].width;
  fheight:=cpaper.widgets[int1].height;
 end;
 fnewpage:= TraReportPage.create(nil);
 fnewpage.report:= report;
 fnewpage.parentwidget:= cpaper;
 tcomponent1(fnewpage).setdesigning(true);
 fnewpage.height:= fheight;
 fnewpage.width:= fwidth;
 cpaper.insertwidget(fnewpage,makepoint(0,0));
 fnewpage.name:= 'Page' + inttostr(cpaper.widgetcount);
 fnewpage.initnewwidget(1.0);
 fnewpage.visible:= true;
end;

procedure trepazdesignfo.deletepage(const sender: TObject);
var
 fdelpage: twidget;
 int1: integer; 
begin
 if cpaper.widgetcount<=1 then begin
  showmessage('Report should have at least 1 page!');
 end else begin
  fdelpage:= cpaper.findwidget(pagedisp.value);
  if fdelpage<>nil then begin
   if askyesno('Are you sure to delete this page?','Delete page',mr_cancel) then begin
    for int1:=0 to cpaper.widgetcount-1 do begin
     if cpaper.widgets[int1]=TraReportPage(fdelpage) then begin
      if int1>0 then begin
       cpaper.widgets[int1-1].visible:=true;
       pagedisp.value:= cpaper.widgets[int1-1].name;
      end else begin
       cpaper.widgets[int1+1].visible:=true;
       pagedisp.value:= cpaper.widgets[int1+1].name;       
      end;
     end;
    end;
    fdelpage.free;
   end;
  end;  
 end;
end;

procedure trepazdesignfo.showhidegrid(const sender: TObject);
begin
 cpaper.showgrid:= (sender as ttoolbutton).checked;
end;

procedure trepazdesignfo.nextpage(const sender: TObject);
var
 int1: integer;
begin
 for int1:=0 to cpaper.widgetcount-1 do begin
  if pagedisp.value=cpaper.widgets[int1].name then begin
   if int1<cpaper.widgetcount-1 then begin
    cpaper.widgets[int1].visible:= false;
    cpaper.widgets[int1+1].visible:= true;
    pagedisp.value:= cpaper.widgets[int1+1].name;
    break;
   end else begin
    showmessage('This is last page!');
   end;
  end;
 end;
end;

procedure trepazdesignfo.snaponoff(const sender: TObject);
begin
 cpaper.snaptogrid:= (sender as ttoolbutton).checked;
end;

function getdatasourcelist: msestringarty;
var
 int1: integer;
begin
 result:=nil;
 if report.datasources<>nil then begin
  setlength(result,report.datasources.count);
  for int1:= 0 to high(result) do begin
   result[int1]:= report.datasources.datasource[int1].datasource.name;
  end;
 end;
end;

function getlookupbufferlist: msestringarty;
var
 int1: integer;
begin
 result:= nil;
 if report.lookupbuffers<>nil then begin
  setlength(result,report.lookupbuffers.count);
  for int1:= 0 to high(result) do begin
   result[int1]:= report.lookupbuffers.lookupbuffer[int1].lookupbuffer.name;
  end;
 end;
end;

{ tdatasourcecomponenteditor }

function tdatasourcepropeditor.getvalues: msestringarty;
var
 int1: integer;
begin
 result:= getdatasourcelist;
end;

function tdatasourcepropeditor.getdefaultstate: propertystatesty;
begin
 result:= inherited getdefaultstate + [ps_valuelist, ps_sortlist,ps_volatile,ps_refresh,ps_refreshall];
end;

{ tlookupbuffercomponenteditor }

function tlookupbufferpropeditor.getvalues: msestringarty;
var
 int1: integer;
begin
 result:= getlookupbufferlist;
end;

function tlookupbufferpropeditor.getdefaultstate: propertystatesty;
begin
 result:= inherited getdefaultstate + [ps_valuelist, ps_sortlist,ps_volatile,ps_refresh,ps_refreshall];
end;

{ tdbfieldnamepropeditor }

function tdbfieldnamepropeditor.getdefaultstate: propertystatesty;
var
 datasource1: tdatasource;
 obj1: tobject;
 ar1: stringarty;
 ar2: fieldtypesarty;
 int1,int2: integer;
begin
 result:= inherited getdefaultstate;
 if fremote <> nil then begin
  obj1:= tobject(tpropeditor1(fremote.getparenteditor).getordvalue);
  if obj1 <> nil then begin
   getcorbainterface(obj1,typeinfo(idbeditinfo),fdbeditinfointf);
  end;
 end
 else begin
  if (high(fprops) = 0) then begin
   with fprops[0] do begin
    getcorbainterface(instance,typeinfo(idbeditinfo),fdbeditinfointf);
   end;
  end;
 end;
 if fdbeditinfointf <> nil then begin
  fdbeditinfointf.getfieldtypes(ar1,ar2);
  int2:= 0;
  for int1:= 0 to high(ar1) do begin
   if ar1[int1] = name then begin
    int2:= int1;
    break;
   end;
  end;
  datasource1:= fdbeditinfointf.getdatasource(int2);
  result:= result + [ps_valuelist,ps_sortlist];
 end;
end;

function tdbfieldnamepropeditor.getvalues: msestringarty;
var
 propertynames: stringarty;
 fieldtypes: fieldtypesarty;
 ft: fieldtypesty;
 int1,int2: integer;
 ds: tdataset;
 dataso: tdatasource;
 
begin
 result:= nil;
 if (fdbeditinfointf <> nil) then begin
  int2:= 0;
  fdbeditinfointf.getfieldtypes(propertynames,fieldtypes);
  if high(propertynames) >= 0 then begin
   for int1:= 0 to high(propertynames) do begin
    if propertynames[int1] = fname then begin
     int2:= int1;
     break;
    end;
   end; 
  end;
  if int2 <= high(fieldtypes) then begin
   ft:= fieldtypes[int2];
  end
  else begin
   ft:= [];
  end;
  dataso:= fdbeditinfointf.getdatasource(int2);
  if dataso <> nil then begin
   ds:= dataso.dataset;
  end
  else begin
   ds:= nil;
  end;
  if ds <> nil then begin
   if ds.active or (ds.fields.count > 0) then begin
    for int1:= 0 to ds.fields.count -1 do begin
     with ds.fields[int1] do begin
      if ((ft = []) or (datatype = ftunknown) or (datatype in ft)) and
             (not fnocalc or (fieldkind <> fkcalculated)) then begin
       additem(result,msestring(fieldname));
      end;
     end;
    end;
   end
   else begin
    for int1:= 0 to ds.fielddefs.count -1 do begin
     with ds.fielddefs[int1] do begin
      if (ft = []) or (datatype = ftunknown) or (datatype in ft) then begin
       additem(result,msestring(name));
      end;
     end;
    end;
   end;
  end;
 end;
end;

{ treptabulatoreditor }

function treptabulatoreditor.getvalue: msestring;
var
 mstr1: msestring;
begin
 with TraTabulatorItem(getordvalue) do begin
  if datafield = '' then begin
   mstr1:= value;
  end
  else begin
   mstr1:= datafield;
   if (reallookupbuffer <> nil) and (reallookupbuffer is tdblookupbuffer) and 
    (lookupvaluefieldno >= 0) then begin
    with tdblookupbuffer(reallookupbuffer) do begin
     case lookupkind of
      lk_text: begin
       if lookupvaluefieldno < reallookupbuffer.fieldcounttext then begin
        mstr1:= mstr1+'><'+textfields[lookupvaluefieldno];
       end;
      end;
      lk_integer: begin
       if lookupvaluefieldno < reallookupbuffer.fieldcountinteger then begin
        mstr1:= mstr1+'><'+integerfields[lookupvaluefieldno];
       end;
      end;
      lk_float,lk_date,lk_time,lk_datetime: begin
       if lookupvaluefieldno < reallookupbuffer.fieldcountfloat then begin
        mstr1:= mstr1+'><'+floatfields[lookupvaluefieldno];
       end;
      end;
     end;
    end;
   end;
  end;
  result:= '<'+formatfloat('0.0',pos)+'><'+mstr1+'>';
 end;
end;

{ treptabulatorseditor }

function treptabulatorseditor.geteditorclass: propeditorclassty;
begin
 result:= treptabulatoreditor;
end;

{ texpressionpropeditor }

function texpressionpropeditor.getdefaultstate: propertystatesty;
begin
 result:= inherited getdefaultstate + [ps_isordprop,ps_dialog];
end;

procedure texpressionpropeditor.edit;
begin
 setvalue((component as TraCustomRecordBand).expressiondialog(getvalue));
 modified;
end;

function texpressionpropeditor.getvalue: msestring;
begin
 result:= getmsestringvalue(0);
end;

procedure texpressionpropeditor.setvalue(const value: msestring);
begin
 setmsestringvalue(value);
end;

end.
