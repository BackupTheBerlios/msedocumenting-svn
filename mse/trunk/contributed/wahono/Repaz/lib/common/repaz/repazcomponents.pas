{*********************************************************}
{                                                         }
{                 Repaz Components                        }
{             Core classes and interfaces                 }
{                                                         }
{            Originally file is msereport                 }
{            written by Martin Schreiber                  }
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
{ from or based on this library.                          }
{                                                         }
{ If you modify this library, and your modification is    }
{ added some usefull values for other Repaz user, please  }
{ send your modification to :                             }
{                                                         }
{               wahono@aztechsoft-int.com                 }
{                                                         }
{ I will evaluate it and if your modification is really   }
{ usefull and compatible with other library, I will       }
{ publish your modification.                              }
{                                                         }
{*********************************************************}

unit repazcomponents;
{$ifdef FPC}{$mode objfpc}{$h+}{$GOTO ON}{$interfaces corba}{$endif}
interface
uses
 mseclasses,classes,msegui,msegraphics,msetypes,msewidgets,msegraphutils,
 msestream,msearrayprops,mseguiglob,msesimplewidgets,repazdialog,repazlookupbuffers,
 msedrawtext,msestrings,mserichstring,msedb,db,mseobjectpicker,msestat,msestatfile,
 msepointer,mseevent,msesplitter,mselookupbuffer,mseformatstr,repazevaluatortype,
 msemenus,mseglob,msesys,msedbedit,repazdatasources,typinfo,osprinters,frmevaldialog,
 osprinter,psprinter,msedataedits,repazglob,repazpreviewform,repazevaluator;
 
type
 reportactionty = (ra_save,ra_print,ra_preview,ra_design,ra_showdialog);
 repactionsty = set of reportactionty;
 raunitty = (Milimeter,Inch);

const
 defaultreportactions = [ra_save,ra_print,ra_preview,ra_design,ra_showdialog];
 defaultrepppmm = 3;
 defaultreppagewidth = 210;
 defaultreppageheight = 297;
 defaultrepfontheight = 10;
 defaultrepfontname = 'Arial';
 tabpickthreshold = 3;
 endrendertag = 49125363;
 
 defaultreptabtextflags = [tf_ycentered];
 defaultbandanchors = [an_top];
 defaultbandoptionswidget = defaultoptionswidget;
               {(defaultoptionswidget + [ow_fontlineheight]) - 
                                    [ow_fontglyphheight];}
 
 defaultrepvaluedisptextflags = [tf_ycentered];
 defaultrepfontcolor = cl_black;
 defaultrepvaluedispoptionsscale = 
               [osc_expandx,osc_shrinkx,osc_expandy,osc_shrinky];
  
type
 lookupkindty = (lk_Text,lk_Integer,lk_Float,lk_Date,lk_Time,lk_DateTime);
 linevisiblety = (lv_TopOfPage,lv_NotTopOfPage,
                  lv_FirstOfPage,lv_Normal,lv_LastOfPage,
                  lv_FirstOfGroup,lv_LastOfGroup,
                  lv_FirstRecord,lv_LastRecord);
 linevisiblesty = set of linevisiblety;
  
 tablineinfoty = record
  widthmm: real;
  color: colorty;
  colorgap: colorty;
  capstyle: capstylety;
  dashes: string;
  dist: integer;
  visible: linevisiblesty; 
 end;
 tablinekindty = (tlk_top,tlk_vert,tlk_bottom);
 tablineinfoarty = array[tablinekindty] of tablineinfoty;
const
 defaulttablinewidth = 0;
 defaulttablinecolor = cl_black;
 defaulttablinecolorgap = cl_transparent;
 defaulttablinecapstyle = cs_projecting;
 defaulttablinedashes = '';
 defaulttablinedist = 0;
 defaulttablinevisible = [lv_TopOfPage,lv_NotTopOfPage,
                          lv_FirstOfPage,lv_Normal,lv_LastOfPage,
                          lv_FirstOfGroup,lv_LastOfGroup,    
                          lv_FirstRecord,lv_LastRecord];
 defaulttablineinfo: tablineinfoty = (widthmm: defaulttablinewidth; 
         color: defaulttablinecolor; colorgap: defaulttablinecolorgap;
         capstyle: defaulttablinecapstyle;
         dashes: defaulttablinedashes; dist: defaulttablinedist;
         visible: defaulttablinevisible);
type
 TraBaseBandArea = class;
 TraCustomRecordBand = class;
 TraReportPage = class;
 rendereventty = procedure(const sender: tobject;
                               const acanvas: tcanvas) of object;
 beforerenderrecordeventty = procedure(const sender: TraCustomRecordBand;
                                          var empty: boolean) of object;
 synceventty = procedure() of object;
 
 TraTabFont = class(tparentfont)
  protected
   class function getinstancepo(owner: tobject): pfont; override;
   procedure setname(const avalue: string); override;
  public
   constructor create; override;
  published
   property color default defaultrepfontcolor;
 end;

 TraStandardFont = class(twidgetfont)
  protected
   procedure setname(const avalue: string); override;
  public
   constructor create; override;
  published
   property color default defaultrepfontcolor;
 end;
 
 TraFont = class(tfont)
  protected
   procedure setname(const avalue: string); override;
  public
   constructor create; override;
  published
   property color default defaultrepfontcolor;
 end;
 
 TraTabulatorItem = class;
 
 TraTabItemDataLink = class(tfielddatalink)
  private
   fowner: TraTabulatorItem;
  protected
   procedure recordchanged(afield: tfield); override;
  public
   constructor create(const aowner: TraTabulatorItem);
 end;

 reptabulatoritemoptionty = (rto_Count,rto_Sum,rto_Average,rto_ShowNull,
                             rto_NoCurrentValue,rto_NoReset);
 reptabulatoritemoptionsty = set of reptabulatoritemoptionty;

 itemsumty = record
  count: integer;
  resetpending: boolean;
  reset: boolean;
  case tfieldtype of
   ftinteger,ftword,ftsmallint,ftboolean: (integervalue: integer);
   ftlargeint: (largeintvalue: int64);
   ftfloat: (floatvalue: double);
   ftbcd: (bcdvalue: currency);
 end;
  
 TraTabulatorItem = class(ttabulatoritem,idbeditinfo)
  private
   fvalue: richstringty;
   ffont: TraTabFont;
   ftextflags: textflagsty;
   fdatalink: TraTabItemDataLink;
   flineinfos: tablineinfoarty;
   flookupbuffer: tcustomlookupbuffer;
   flookupbufferstring: string;
   flookupkeyfieldno: integer;
   flookupvaluefieldno: integer;
   flookupkind: lookupkindty;
   fformat: msestring;
   fcolor: colorty;
   ftag: integer;
   foptions: reptabulatoritemoptionsty;
   fsum: itemsumty;
   frawfont: rawfontty;
   fexpression: msestring;
   
   procedure setvalue(const avalue: msestring);
   procedure setexpression(const avalue: msestring);
   procedure setrichvalue(const avalue: richstringty);
   function getdisptext: richstringty;
   function getfont: TraTabFont;
   procedure setfont(const avalue: TraTabFont);
   function isfontstored: boolean;
   procedure createfont;
   procedure changed;
   procedure fontchanged(const asender: tobject);
   procedure settextflags(const avalue: textflagsty);
   function getdatasource1: string;
   procedure setdatasource(const avalue: string);
   function getdatafield: string;
   procedure setdatafield(const avalue: string);

   procedure setLineTop_Widthmm(const avalue: real);
   procedure setLineTop_Color(const avalue: colorty);
   procedure setLineTop_ColorGap(const avalue: colorty);
   procedure setLineTop_CapStyle(const avalue: capstylety);
   procedure setLineTop_Dashes(const avalue: string);
   procedure setLineTop_Dist(const avalue: integer);
   procedure setLineTop_visible(const avalue: linevisiblesty);

   procedure setLineVertical_Widthmm(const avalue: real);
   procedure setLineVertical_Color(const avalue: colorty);
   procedure setLineVertical_ColorGap(const avalue: colorty);
   procedure setLineVertical_CapStyle(const avalue: capstylety);
   procedure setLineVertical_Dashes(const avalue: string);
   procedure setLineVertical_Dist(const avalue: integer);
   procedure setLineVertical_visible(const avalue: linevisiblesty);

   procedure setLineBottom_Widthmm(const avalue: real);
   procedure setLineBottom_Color(const avalue: colorty);
   procedure setLineBottom_ColorGap(const avalue: colorty);
   procedure setLineBottom_CapStyle(const avalue: capstylety);
   procedure setLineBottom_Dashes(const avalue: string);
   procedure setLineBottom_Dist(const avalue: integer);
   procedure setLineBottom_visible(const avalue: linevisiblesty);
   procedure recchanged;

               //idbeditinfo
   function getdatasource(const aindex: integer): tdatasource;
   procedure getfieldtypes(out apropertynames: stringarty;
                           out afieldtypes: fieldtypesarty);
   procedure setlookupbuffer(const avalue: string);
   procedure setlookupkeyfieldno(const avalue: integer);
   procedure setlookupvaluefieldno(const avalue: integer);
   procedure setlookupkind(const avalue: lookupkindty);
   procedure setformat(const avalue: msestring);
   procedure setcolor(avalue: colorty);
   
   function getsumasinteger: integer;
   function getsumaslargeint: int64;
   function getsumasfloat: double;
   function getsumascurrency: currency;
   procedure initsum;
   procedure setoptions(const avalue: reptabulatoritemoptionsty);
   function getsumcount: integer;
  protected
   procedure setpos(const avalue: real); override;
   function xlineoffset: integer;
   procedure dobeforenextrecord(const adatasource: tdatasource);
   procedure scale(const ascale: real);
  public 
   constructor create(aowner: tobject); override;
   destructor destroy; override;
   procedure resetsum(const skipcurrent: boolean);
   property sumcount: integer read getsumcount;
   property sumasinteger: integer read getsumasinteger;
   property sumaslargeint: int64 read getsumaslargeint;
   property sumasfloat: double read getsumasfloat;
   property sumascurrency: currency read getsumascurrency;
   property richvalue: richstringty read fvalue write setrichvalue;
   property reallookupbuffer: tcustomlookupbuffer read flookupbuffer;
  published
   property Tag: integer read ftag write ftag;
   property Options: reptabulatoritemoptionsty read foptions write setoptions;
   property Expression: msestring read fexpression write setexpression;
   property Value: msestring read fvalue.text write setvalue;
   property Font: TraTabFont read getfont write setfont stored isfontstored;
   property RawFont: rawfontty read frawfont write frawfont default rfNormal;
   property Color: colorty read fcolor write setcolor default cl_none;
   property TextFlags: textflagsty read ftextflags write settextflags 
                   default defaultreptabtextflags;
   property DataField: string read getdatafield write setdatafield;
   property DataSource: string read getdatasource1 write setdatasource;
   property LookupBuffer: string read flookupbufferstring 
                                      write setlookupbuffer;
   property LookupKeyFieldNo: integer read flookupkeyfieldno 
                                      write setlookupkeyfieldno default 0;
   property LookupValueFieldNo: integer read flookupvaluefieldno 
                                      write setlookupvaluefieldno default 0;
   property LookupKind: lookupkindty read flookupkind 
                                      write setlookupkind default lk_Text;
   property Format: msestring read fformat write setformat;

   property LineTop_Widthmm: real read flineinfos[tlk_top].widthmm write
                 setLineTop_Widthmm;
   property LineTop_Color: colorty read flineinfos[tlk_top].color write
                 setLineTop_Color default defaulttablinecolor;
   property LineTop_ColorGap: colorty read flineinfos[tlk_top].colorgap write
                 setLineTop_ColorGap default defaulttablinecolorgap;
   property LineTop_CapStyle: capstylety read flineinfos[tlk_top].capstyle write
                 setLineTop_CapStyle default defaulttablinecapstyle;
   property LineTop_Dashes: string read flineinfos[tlk_top].dashes write
                 setLineTop_Dashes;
   property LineTop_Dist: integer read flineinfos[tlk_top].dist write
                 setLineTop_Dist default defaulttablinedist;
   property LineTop_visible: linevisiblesty read flineinfos[tlk_top].visible write
                 setLineTop_visible default defaulttablinevisible;

   property LineVertical_Widthmm: real read flineinfos[tlk_vert].widthmm write
                           setLineVertical_Widthmm;
   property LineVertical_Color: colorty read flineinfos[tlk_vert].color write
                             setLineVertical_Color default defaulttablinecolor;
   property LineVertical_ColorGap: colorty read flineinfos[tlk_vert].colorgap write
                             setLineVertical_ColorGap default defaulttablinecolorgap;
   property LineVertical_CapStyle: capstylety read flineinfos[tlk_vert].capstyle write
                             setLineVertical_CapStyle default defaulttablinecapstyle;
   property LineVertical_Dashes: string read flineinfos[tlk_vert].dashes write
                             setLineVertical_Dashes;
   property LineVertical_Dist: integer read flineinfos[tlk_vert].dist write
                             setLineVertical_Dist default defaulttablinedist;
   property LineVertical_visible: linevisiblesty read flineinfos[tlk_vert].visible write
                 setLineVertical_visible default defaulttablinevisible;
                 
   property LineBottom_Widthmm: real read flineinfos[tlk_bottom].widthmm write
                 setLineBottom_Widthmm;
   property LineBottom_Color: colorty read flineinfos[tlk_bottom].color write
                 setLineBottom_Color default defaulttablinecolor;
   property LineBottom_ColorGap: colorty read flineinfos[tlk_bottom].colorgap write
                 setLineBottom_ColorGap default defaulttablinecolorgap;
   property LineBottom_CapStyle: capstylety read flineinfos[tlk_bottom].capstyle write
                 setLineBottom_CapStyle default defaulttablinecapstyle;
   property LineBottom_Dashes: string read flineinfos[tlk_bottom].dashes write
                                         setLineBottom_Dashes;
   property LineBottom_Dist: integer read flineinfos[tlk_bottom].dist write
                                 setLineBottom_Dist default defaulttablinedist;
   property LineBottom_visible: linevisiblesty read flineinfos[tlk_bottom].visible write
                 setLineBottom_visible default defaulttablinevisible;

   property DistLeft; //mm
   property DistRight; //mm
   property Pos;
   property Kind;
 end; 
                 
 TraTabulators = class(tcustomtabulators)
  private
   finfo: drawtextinfoty;
   fband: TraCustomRecordBand;
   fminsize: sizety;
   fsizevalid: boolean;
   flineinfos: tablineinfoarty;
   fLineLeft: tablineinfoty;
   fLineRight: tablineinfoty;
   fdistright: real;
   fdistleft: real;

   flinksource: TraCustomRecordBand;
   procedure setLineTop_Widthmm(const avalue: real);
   procedure setLineTop_Color(const avalue: colorty);
   procedure setLineTop_ColorGap(const avalue: colorty);
   procedure setLineTop_CapStyle(const avalue: capstylety);
   procedure setLineTop_Dashes(const avalue: string);
   procedure setLineTop_Dist(const avalue: integer);
   procedure setLineTop_visible(const avalue: linevisiblesty);

   procedure setLineLeft_Widthmm(const avalue: real);
   procedure setLineLeft_Color(const avalue: colorty);
   procedure setLineLeft_ColorGap(const avalue: colorty);
   procedure setLineLeft_CapStyle(const avalue: capstylety);
   procedure setLineLeft_Dashes(const avalue: string);
   procedure setLineLeft_Dist(const avalue: integer);
   procedure setLineLeft_visible(const avalue: linevisiblesty);

   procedure setLineVertical_Widthmm(const avalue: real);
   procedure setLineVertical_Color(const avalue: colorty);
   procedure setLineVertical_ColorGap(const avalue: colorty);
   procedure setLineVertical_CapStyle(const avalue: capstylety);
   procedure setLineVertical_Dashes(const avalue: string);
   procedure setLineVertical_Dist(const avalue: integer);
   procedure setLineVertical_visible(const avalue: linevisiblesty);

   procedure setLineRight_Widthmm(const avalue: real);
   procedure setLineRight_Color(const avalue: colorty);
   procedure setLineRight_ColorGap(const avalue: colorty);
   procedure setLineRight_CapStyle(const avalue: capstylety);
   procedure setLineRight_Dashes(const avalue: string);
   procedure setLineRight_Dist(const avalue: integer);
   procedure setLineRight_visible(const avalue: linevisiblesty);

   procedure setLineBottom_Widthmm(const avalue: real);
   procedure setLineBottom_Color(const avalue: colorty);
   procedure setLineBottom_ColorGap(const avalue: colorty);
   procedure setLineBottom_CapStyle(const avalue: capstylety);
   procedure setLineBottom_Dashes(const avalue: string);
   procedure setLineBottom_Dist(const avalue: integer);
   procedure setLineBottom_visible(const avalue: linevisiblesty);

   function getitems(const index: integer): TraTabulatorItem;
   procedure setitems(const index: integer; const avalue: TraTabulatorItem);
   procedure processvalues(const acanvas: tcanvas; const adest: rectty;
     const apaint: boolean; const isrendering:boolean);
   procedure setdistleft(const avalue: real);
   procedure setdistright(const avalue: real);
   procedure setlinksource(const avalue: TraCustomRecordBand);
  protected
   class function getitemclass: tabulatoritemclassty; override;
   procedure paint(const acanvas: tcanvas; const adest: rectty;
     const isrendering:boolean);
   procedure checksize;
   procedure recchanged;
   procedure sourcechanged;
   procedure dochange(const aindex: integer); override;
   procedure setcount1(acount: integer; doinit: boolean); override;
   procedure dobeforenextrecord(const adatasource: tdatasource);
   procedure initsums;
   procedure scale(const ascale: real);
  public
   constructor create(const aowner: TraCustomRecordBand);
   destructor destroy;override;
   procedure resetsums(const skipcurrent: boolean);
   property items[const index: integer]: TraTabulatorItem read getitems 
                       write setitems; default;
 published
                 
   property LineTop_Widthmm: real read flineinfos[tlk_top].widthmm write
                 setLineTop_Widthmm;
   property LineTop_Color: colorty read flineinfos[tlk_top].color write
                 setLineTop_Color default defaulttablinecolor;
   property LineTop_ColorGap: colorty read flineinfos[tlk_top].colorgap write
                 setLineTop_ColorGap default defaulttablinecolorgap;
   property LineTop_CapStyle: capstylety read flineinfos[tlk_top].capstyle write
                 setLineTop_CapStyle default defaulttablinecapstyle;
   property LineTop_Dashes: string read flineinfos[tlk_top].dashes write
                 setLineTop_Dashes;
   property LineTop_Dist: integer read flineinfos[tlk_top].dist write
                 setLineTop_Dist default defaulttablinedist;
   property LineTop_visible: linevisiblesty read flineinfos[tlk_top].visible write
                 setLineTop_visible default defaulttablinevisible;

   property LineLeft_Widthmm: real read fLineLeft.widthmm write
                 setLineLeft_Widthmm;
   property LineLeft_Color: colorty read fLineLeft.color write
                 setLineLeft_Color default defaulttablinecolor;
   property LineLeft_ColorGap: colorty read fLineLeft.colorgap write
                 setLineLeft_ColorGap default defaulttablinecolorgap;
   property LineLeft_CapStyle: capstylety read fLineLeft.capstyle write
                 setLineLeft_CapStyle default defaulttablinecapstyle;
   property LineLeft_Dashes: string read fLineLeft.dashes write
                 setLineLeft_Dashes;
   property LineLeft_Dist: integer read fLineLeft.dist write
                 setLineLeft_Dist default defaulttablinedist;
   property LineLeft_visible: linevisiblesty read fLineLeft.visible write
                 setLineLeft_visible default defaulttablinevisible;

   property LineVertical_Widthmm: real read flineinfos[tlk_vert].widthmm write
                 setLineVertical_Widthmm;
   property LineVertical_Color: colorty read flineinfos[tlk_vert].color write
                 setLineVertical_Color default defaulttablinecolor;
   property LineVertical_ColorGap: colorty read flineinfos[tlk_vert].colorgap write
                 setLineVertical_ColorGap default defaulttablinecolorgap;
   property LineVertical_CapStyle: capstylety read flineinfos[tlk_vert].capstyle write
                 setLineVertical_CapStyle default defaulttablinecapstyle;
   property LineVertical_Dashes: string read flineinfos[tlk_vert].dashes write
                 setLineVertical_Dashes;
   property LineVertical_Dist: integer read flineinfos[tlk_vert].dist write
                 setLineVertical_Dist default defaulttablinedist;
   property LineVertical_visible: linevisiblesty read flineinfos[tlk_vert].visible write
                 setLineVertical_visible default defaulttablinevisible;
                 
   property LineRight_Widthmm: real read fLineRight.widthmm write
                 setLineRight_Widthmm;
   property LineRight_Color: colorty read fLineRight.color write
                 setLineRight_Color default defaulttablinecolor;
   property LineRight_ColorGap: colorty read fLineRight.colorgap write
                 setLineRight_ColorGap default defaulttablinecolorgap;
   property LineRight_CapStyle: capstylety read fLineRight.capstyle write
                 setLineRight_CapStyle default defaulttablinecapstyle;
   property LineRight_Dashes: string read fLineRight.dashes write
                 setLineRight_Dashes;
   property LineRight_Dist: integer read fLineRight.dist write
                 setLineRight_Dist default defaulttablinedist;
   property LineRight_visible: linevisiblesty read fLineRight.visible write
                 setLineRight_visible default defaulttablinevisible;

   property LineBottom_Widthmm: real read flineinfos[tlk_bottom].widthmm write
                 setLineBottom_Widthmm;
   property LineBottom_Color: colorty read flineinfos[tlk_bottom].color write
                 setLineBottom_Color default defaulttablinecolor;
   property LineBottom_ColorGap: colorty read flineinfos[tlk_bottom].colorgap write
                 setLineBottom_ColorGap default defaulttablinecolorgap;
   property LineBottom_CapStyle: capstylety read flineinfos[tlk_bottom].capstyle
               write setLineBottom_CapStyle default defaulttablinecapstyle;
   property LineBottom_Dashes: string read flineinfos[tlk_bottom].dashes write
                 setLineBottom_Dashes;
   property LineBottom_Dist: integer read flineinfos[tlk_bottom].dist write
                 setLineBottom_Dist default defaulttablinedist;
   property LineBottom_visible: linevisiblesty read flineinfos[tlk_bottom].visible
               write setLineBottom_visible default defaulttablinevisible;               
   property DistLeft: real read fdistleft write setdistleft; //mm
   property DistRight: real read fdistright write setdistright; //mm
   property LinkSource: TraCustomRecordBand read flinksource write setlinksource;
   property DefaultDist;
 end;
  
 recordbandstatety = (rbs_rendering,rbs_showed,rbs_pageshowed,rbs_finish,
                      rbs_notfirstrecord,rbs_lastrecord,rbs_visibilitychecked{,
                      rbs_empty});
 recordbandstatesty = set of recordbandstatety; 
 
 ireportclient = interface(inullinterface)
  function getwidget: twidget;
  procedure updatevisibility;
  procedure beginrender(const arestart: boolean);
  procedure endrender;
  procedure adddatasets(var adatasets: datasetarty);
  procedure init;
  procedure resetzebra;
 end;
 ireportclientarty = array of ireportclient;
 
 ibandparent = interface(inullinterface)
                        ['{B02EE732-4686-4E0C-8C18-419D7D020386}']
  procedure registerclient(const aclient: ireportclient);
  procedure unregisterclient(const aclient: ireportclient);
  function beginband(const acanvas: tcanvas;
                              const sender: TraCustomRecordBand): boolean;
                   //true if area full
  procedure endband(const acanvas: tcanvas; const sender: TraCustomRecordBand);  
  function istopband: boolean;
  function isfirstband: boolean;
  function islastband(const addheight: integer = 0): boolean;
  function isfirstrecord: boolean;
  function islastrecord: boolean;
//  function isfirstofgroup: boolean;
//  function islastofgroup: boolean;
  procedure updatevisible;
  function getwidget: twidget;
  function remainingheight: integer;
  procedure setareafull(const avalue: boolean);
  function pagepagenum: integer; //null based
  function reppagenum: integer; //null based
  function getlastpagepagecount: integer;
  function getlastreppagecount: integer;
  function pageprintstarttime: tdatetime;
  function repprintstarttime: tdatetime;
  function getreppage: TraReportPage;
  procedure resetzebra;
 end;

 TraRecordBandDataLink = class(tmsedatalink)
 end;
 
 bandoptionty = (bo_Once,bo_EvenPage,bo_OddPage,
                  //defines hasdata, page nums are null based
                 bo_VisiGroupFirst,bo_VisiGroupNotFirst,
                 bo_VisiGroupLast,bo_VisiGroupNotLast,
                 bo_LocalValue,
                  //used in TraPageNumber to show the number of the current 
                  //TraReportPage instead the number of the printed pages
                  //and in trepprinttimedisp to show now instead of 
                  //print start time
                 bo_TopOfArea //sets areafull if not first of page before render
                 );
 bandoptionsty = set of bandoptionty;

 bandoptionshowty = (
                   //show only on first/last record of group
                 bos_ShowFirstPage,bos_HideFirstPage,
                 bos_ShowNormalPage,bos_HideNormalPage,
                  //checks current TraReportPage
                 bos_ShowEvenPage,bos_HideEvenPage,
                 bos_ShowOddPage,bos_HideOddPage,
                  //checks the printed page number
                 bos_ShowTopOfPage,bos_HideTopOfPage,
                 bos_ShowNotTopOfPage,bos_HideNotTopOfPage,
                 bos_ShowFirstOfPage,bos_HideFirstOfPage,
                 bos_ShowNormalOfPage,bos_HideNormalOfPage,                 
                 bos_ShowLastOfPage,bos_HideLastOfPage,
                  //checks the position in the bandarea                 
                 bos_ShowFirstRecord,bos_HideFirstRecord, 
                 bos_ShowNormalRecord,bos_HideNormalRecord,
                 bos_ShowLastRecord,bos_HideLastRecord
                  //checks the connected dataset
                  );
 bandoptionshowsty = set of bandoptionshowty;

const 
 visibilitymask = [bos_ShowFirstPage,bos_HideFirstPage,
                   bos_ShowNormalPage,bos_HideNormalPage,
                   bos_ShowEvenPage,bos_HideEvenPage,
                   bos_ShowOddPage,bos_HideOddPage,
                   bos_ShowTopOfPage,bos_HideTopOfPage,
                   bos_ShowNotTopOfPage,bos_HideNotTopOfPage,
                   bos_ShowFirstOfPage,bos_HideFirstOfPage,
                   bos_ShowNormalOfPage,bos_HideNormalOfPage,
                   bos_ShowLastOfPage,bos_HideLastOfPage,
                   bos_ShowFirstRecord,bos_HideFirstRecord,
                   bos_ShowNormalRecord,bos_HideNormalRecord,
                   bos_ShowLastRecord,bos_HideLastRecord
                   ];
 defaultrepvaluedispoptions = [bo_EvenPage,bo_OddPage];
type                     
 TraSpacer = class(tlayouter,ireportclient)
  private
   foptionsrep: bandoptionshowsty;   
   fparentintf: ibandparent;
   procedure setoptionsrep(const avalue: bandoptionshowsty);
  protected
   procedure parentchanged; override; //update fparentintf
   procedure updatevisibility;
   procedure beginrender(const arestart: boolean);
   procedure endrender;
   procedure adddatasets(var adatasets: datasetarty);
   procedure init;
   procedure resetzebra;
  published
   property OptionsRep: bandoptionshowsty read foptionsrep 
                                        write setoptionsrep default [];
 end;
 
 bandareaarty = array of TraBaseBandArea;
 
 recordbandarty = array of TraCustomRecordBand;
 recordbandeventty = procedure(const sender: TraCustomRecordBand) of object; 
 
 zebraoptionty = (zo_ResetOnPageStart,zo_ResetParent);
 zebraoptionsty = set of zebraoptionty;
 
 TraCustomRecordBand = class(twidget,idbeditinfo,ireccontrol,
                                iobjectpicker,ireportclient)
  private
   frecbands: recordbandarty;
   fparentintf: ibandparent;
   fstate: recordbandstatesty;
   ftabs: TraTabulators;
   fupdating: integer;
   fdatalink: TraRecordBandDataLink;
   fvisidatalink: tfielddatalink;
   fvisigrouplink: tfielddatalink;
   foptions: bandoptionsty;
   foptionsshow: bandoptionshowsty;
   fgroupnum: int64;
   fgroupstring: msestring;
   fnextgroupnum: integer;
   fnextgroupstring: msestring;
   fobjectpicker: tobjectpicker;
   fnextband: TraCustomRecordBand;
   fnextbandifempty: TraCustomRecordBand;
   fareas: bandareaarty;
   fZebra_Color: colorty;
   fZebra_Start: integer;
   fZebra_Height: integer;
   fZebra_Step: integer;
   fZebra_Counter: integer;
   fZebra_Options: zebraoptionsty;
   frawfont: rawfontty;
   fscaling: integer;
   foptionsscale: optionsscalety;
   fsizebefore: sizety;
   procedure setoptionsscale(const avalue: optionsscalety);
   procedure settabs(const avalue: TraTabulators);
   procedure setoptionsshow(const avalue: bandoptionshowsty);
   function getvisidatasource: string;
   procedure setvisidatasource(const avalue: string);
   function getvisidatafield: string;
   procedure setvisidatafield(const avalue: string);
   function getdatasource: string; overload;
   procedure setdatasource(const avalue: string); virtual;
   function getvisigroupfield: string;
   procedure setvisigroupfield(const avalue: string);
              //idbeditinfo
   function getdatasource(const aindex: integer): tdatasource; overload;
   procedure getfieldtypes(out apropertynames: stringarty;
                           out afieldtypes: fieldtypesarty);
              //ireccontrol
   procedure recchanged;
   procedure setnextband(const avalue: TraCustomRecordBand);
   procedure setnextbandifempty(const avalue: TraCustomRecordBand);
  protected
   procedure updateoptionsscale;
   procedure beginscaling;
   procedure endscaling;
   procedure setfont(const avalue: TraStandardFont);
   function getfont: TraStandardFont;
   function getfontclass: widgetfontclassty; override;
   
   procedure registerchildwidget(const child: twidget); override;
   procedure unregisterchildwidget(const child: twidget); override;
   procedure minclientsizechanged;
   procedure objectevent(const sender: tobject;
                          const event: objecteventty); override;
   procedure fontchanged; override;
   procedure inheritedpaint(const acanvas: tcanvas);
   procedure paint(const canvas: tcanvas); override;
   procedure parentchanged; override; //update fparentintf
   function getminbandsize: sizety; virtual;
   function calcminscrollsize: sizety; override;
   function actualcolor: colorty; override;
   procedure render(const acanvas: tcanvas; var empty: boolean); virtual;
   procedure init; virtual;
   procedure initpage; virtual;
   procedure beginrender(const arestart: boolean); virtual;
   procedure endrender; virtual;
   procedure adddatasets(var adatasets: datasetarty); virtual;
   procedure dopaint(const acanvas: tcanvas); override;
   procedure doonpaint(const acanvas: tcanvas); override;
   procedure doafterpaint(const acanvas: tcanvas); override;
   procedure dobeforenextrecord(const adatasource: tdatasource); virtual;
   procedure dosyncnextrecord; virtual;
   
   procedure nextrecord(const setflag: boolean = true);
   function rendering: boolean;
   function bandheight: integer;
   procedure dobeforerender(var empty: boolean); virtual;
   procedure synctofontheight; override;
   function bandisvisible(const checklast: boolean): boolean;
   function getvisibility: boolean;
   procedure updatevisibility; virtual;
   function lastbandheight: integer; virtual;
   procedure clientmouseevent(var info: mouseeventinfoty); override;
   procedure loaded; override;

      //iobjectpicker
   function getcursorshape(const apos: pointty; const ashiftstate: shiftstatesty; 
                                     var ashape: cursorshapety): boolean;
    //true if found
   procedure getpickobjects(const arect: rectty;  const ashiftstate: shiftstatesty;
                                     var aobjects: integerarty);
   procedure beginpickmove(const aobjects: integerarty);
   procedure endpickmove(const apos,aoffset: pointty; const aobjects: integerarty);
   procedure paintxorpic(const acanvas: tcanvas; const apos,aoffset: pointty;
                 const aobjects: integerarty);
  public
   constructor create(aowner: tcomponent); override;
   destructor destroy; override;
   procedure scale(const ascale: real); override;
   procedure beginupdate;
   procedure endupdate;
   function remainingbands: integer;
   function reppage: TraReportPage;
   procedure finish;
   function isfirstrecord: boolean;
   function islastrecord: boolean;
   function isfirstofgroup: boolean;
   function islastofgroup: boolean;
   procedure restart;
   procedure resetzebra; virtual;
   function expressiondialog(const aexpression: msestring): msestring;
   property Tabulators: TraTabulators read ftabs write settabs;
   property Font: TraStandardFont read getfont write setfont stored isfontstored;
   property RawFont: rawfontty read frawfont write frawfont default rfNormal;
   property DataSource: string read getdatasource write setdatasource;
   property VisiDataSource: string read getvisidatasource 
                          write setvisidatasource;
   property VisiDataField: string read getvisidatafield write setvisidatafield;
               //controls visibility not null -> visible
   property VisiGroupField: string read getvisigroupfield write setvisigroupfield;
   property Options: bandoptionsty read foptions write foptions default [];
   property OptionsShow: bandoptionshowsty read foptionsshow write setoptionsshow default [];
   property NextBand: TraCustomRecordBand read fnextband write setnextband;
                       //used by TraCustomBandArea
   property NextBandIfEmpty: TraCustomRecordBand read fnextbandifempty 
                                       write setnextbandifempty;
                       //used by TraCustomBandArea
   property Zebra_Counter: integer read fZebra_Counter write fZebra_Counter;
   property Zebra_Color: colorty read fZebra_Color write fZebra_Color default cl_infobackground;
   property Zebra_Start: integer read fZebra_Start write fZebra_Start default 0;
   property Zebra_Height: integer read fZebra_Height write fZebra_Height default 0;
   property Zebra_Step: integer read fZebra_Step write fZebra_Step default 2;
   property Zebra_Options: zebraoptionsty read fZebra_Options 
                                         write fZebra_Options default [];
   property OptionsWidget default defaultbandoptionswidget;
   property OptionsScale: optionsscalety read foptionsscale write setoptionsscale;
  published
   property Anchors default [an_left,an_top];
   property Left;
   property Top;
   property Height;
   property Width;
   property Color;
   property TabOrder;
 end;

 TraRecordBand = class(TraCustomRecordBand)
  public
   constructor create(aowner: tcomponent); override;
  published
   property Font;
   property Tabulators;
   property DataSource;
   property Options;
   property OptionsShow;
   property OptionsScale;
   property VisiDataSource;
   property VisiDataField;
   property VisiGroupField;
   property NextBand;
   property NextBandIfEmpty;
   
   property Zebra_Color;
   property Zebra_Start;
   property Zebra_Height;
   property Zebra_Step;
   property Zebra_Options;
   property RawFont;
  end;

 TraCustomValueDisplay = class; 
 getrepvaluetexteventty = procedure(const sender: TraCustomValueDisplay; 
                                          var atext: msestring) of object;
                                          
 TraCustomValueDisplay = class(TraCustomRecordBand)
  private
   ftextflags: textflagsty;
   fformat: msestring;
   fvalue: msestring;
   procedure setvalue(const avalue: msestring);
   procedure setformat(const avalue: msestring);
   procedure settextflags(const avalue: textflagsty);
  protected
   function calcminscrollsize: sizety; override;
   procedure dopaint(const acanvas: tcanvas); override;
   procedure dogettext(var atext: msestring);
   function getdisptext: msestring; virtual;
   procedure render(const acanvas: tcanvas; var empty: boolean); override;
   procedure dobeforerender(var empty: boolean); override;
  public
   constructor create(aowner: tcomponent); override;
   property TextFlags: textflagsty read ftextflags write settextflags default 
                                            defaultrepvaluedisptextflags;
   property Format: msestring read fformat write setformat;
   property OptionsScale default defaultrepvaluedispoptionsscale;
   property Options default defaultrepvaluedispoptions;
   property Value: msestring read fvalue write setvalue;
 end;
 
 TraValueDisplay = class(TraCustomValueDisplay)
  published
   property Value;
   property Font;
   property TextFlags;
   property Options;
   property OptionsShow;
   property OptionsScale;
   property VisiDataSource;
   property VisiDataField;
   property VisiGroupField;
   property Zebra_Color;
   property Zebra_Start;
   property Zebra_Height;
   property Zebra_Step;
   property Zebra_Options;
   property RawFont;
 end;

 TraPageNumber = class(TraCustomValueDisplay)
  private
   foffset: integer;
   procedure setoffset(const avalue: integer);
  protected
   function getdisptext: msestring; override;
   procedure initpage; override;
   procedure parentchanged; override;
  public
   constructor create(aowner: tcomponent); override;
  published
   property Offset: integer read foffset write setoffset default 1;
   property Format;   //'1' returns lastpagecount
   property Value;
   property Font;
   property RawFont;
   property TextFlags;
   property Options;
   property OptionsShow;
 end;

 TraDatePrint = class(TraCustomValueDisplay)
  protected
   procedure initpage; override;
   procedure parentchanged; override;
   function getdisptext: msestring; override;
  published
   property Format;   //'1' returns lastpagecount
   property Value;
   property Font;
   property RawFont;
   property TextFlags;
   property Options;
   property OptionsShow;
 end;
 
 TraCustomBandGroup = class(TraCustomRecordBand,ibandparent)
  private
   procedure setdatasource(const avalue: string); override;
           //ibandparent;
   procedure registerclient(const aclient: ireportclient);
   procedure unregisterclient(const aclient: ireportclient);
   function beginband(const acanvas: tcanvas;
                              const sender: TraCustomRecordBand): boolean;
                   //true if area full
   procedure endband(const acanvas: tcanvas; const sender: TraCustomRecordBand);  
   function istopband: boolean;
   function isfirstband: boolean;
   function islastband(const addheight: integer = 0): boolean;
   procedure updatevisible;
   function getwidget: twidget;
   function remainingheight: integer;
   function pagepagenum: integer; //null based
   function reppagenum: integer; //null based
   function getlastpagepagecount: integer;
   function getlastreppagecount: integer;
   function pageprintstarttime: tdatetime;
   function repprintstarttime: tdatetime;
   function getreppage: TraReportPage;
   procedure dobeforenextrecord(const adatasource: tdatasource); override;
   procedure dosyncnextrecord; override;
  protected
   procedure setparentwidget(const avalue: twidget); override;   
   procedure registerchildwidget(const child: twidget); override;
   procedure unregisterchildwidget(const child: twidget); override;
   procedure dobeforerender(var empty: boolean); override;
   procedure dopaint(const acanvas: tcanvas); override;
   function getminbandsize: sizety; override;
   procedure initpage; override;
   procedure init; override;
   procedure beginrender(const arestart: boolean); override;
   procedure endrender; override;
   procedure adddatasets(var adatasets: datasetarty); override;
   function lastbandheight: integer; override;
   procedure setareafull(const avalue: boolean);
  public
   procedure resetzebra; override;
   property Font: TraStandardFont read getfont write setfont stored isfontstored;
 end;

 TraBandGroup = class(TraCustomBandGroup)
  published
   property Font;
   property RawFont;
   property Tabulators;
   property DataSource;
   property NextBand;
   property NextBandIfEmpty;
   property Options;
   property OptionsShow;
   property OptionsScale;
   property VisiDataSource;
   property VisiDataField;
   property VisiGroupField;
   property Zebra_Color;
   property Zebra_Start;
   property Zebra_Height;
   property Zebra_Step;
   property Zebra_Options;
 end;
 
 bandareastatety = (bas_inited,bas_backgroundrendered,bas_areafull,
                    bas_rendering,
                    bas_top,bas_notfirstband,bas_lastband,bas_bandstarted,
                    bas_activebandchanged,bas_finished);
 bandareastatesty = set of bandareastatety; 
   
 bandareaeventty = procedure(const sender: TraBaseBandArea) of object;
 bandareapainteventty = procedure(const sender: TraBaseBandArea;
                              const acanvas: tcanvas) of object;
                              
 TraBaseBandArea = class(tactionwidget,ibandparent)
  private
   fareabands: recordbandarty;
   fstate: bandareastatesty;
   freportpage: TraReportPage;
   frecordband: TraCustomRecordBand;
   forigin: pointty;
   fsaveindex: integer;
   function getareafull: boolean;
   procedure setareafull(const avalue: boolean);
  protected
   procedure registerchildwidget(const child: twidget); override;
   procedure unregisterchildwidget(const child: twidget); override;
   procedure setparentwidget(const avalue: twidget); override;   
   procedure paint(const canvas: tcanvas); override;
   procedure renderbackground(const acanvas: tcanvas);
   function render(const acanvas: tcanvas): boolean; virtual;
          //true if finished
   function rendering: boolean;
   procedure beginrender(const arestart: boolean);
   procedure endrender;
   procedure adddatasets(var adatasets: datasetarty);
   procedure dofirstarea; virtual;
   procedure dobeforerender; virtual;
   procedure doonpaint(const acanvas: tcanvas); override;
   procedure doafterpaint1(const acanvas: tcanvas); virtual;
   procedure init; virtual;
   procedure initareapage; virtual;
   procedure initband; virtual;
   procedure initpage;
   procedure dobeforenextrecord(const adatasource: tdatasource);
   procedure dosyncnextrecord;
   function checkareafull(ay: integer): boolean;
           //ibandparent
   procedure registerclient(const aclient: ireportclient);
   procedure unregisterclient(const aclient: ireportclient);
   function beginband(const acanvas: tcanvas;
                               const sender: TraCustomRecordBand): boolean; virtual;
                    //true if area full
   procedure endband(const acanvas: tcanvas; 
                      const sender: TraCustomRecordBand); virtual;  
   procedure updatevisible;
   function getlastpagepagecount: integer;
   function getlastreppagecount: integer;
   procedure setfont(const avalue: TraStandardFont);
   function getfont: TraStandardFont;
   function getfontclass: widgetfontclassty; override;
  public
   function isfirstrecord: boolean;
   function islastrecord: boolean;
   function istopband: boolean; virtual;
   function isfirstband: boolean; virtual;
   function islastband(const addheight: integer = 0): boolean; virtual;
   function remainingheight: integer; virtual;

   function pagepagenum: integer; //null based
   function reppagenum: integer; //null based
   function pageprintstarttime: tdatetime;
   function repprintstarttime: tdatetime;
   function getreppage: TraReportPage;

   procedure restart; virtual;
   procedure resetzebra;
      
  published
   property Anchors;
   property Font: TraStandardFont read getfont write setfont stored isfontstored;
   property Left;
   property Top;
   property Width;
   property Height;
   property Color;
 end; 

 TraCustomBandArea = class(TraBaseBandArea)
  private
   factiveband: integer;
   facty: integer;
   factybefore: integer;
   fbandnum: integer;
   function getacty: integer;
  protected
   procedure init; override;
   procedure initband; override;
   procedure initareapage; override;
   function render(const acanvas: tcanvas): boolean; override;
          //true if finished
   function beginband(const acanvas: tcanvas;
                      const sender: TraCustomRecordBand): boolean; override;
                    //true if area full
   procedure endband(const acanvas: tcanvas; 
                      const sender: TraCustomRecordBand); override;  
  public
   function isfirstband: boolean; override;
   function islastband(const addheight: integer = 0): boolean; override;
   function remainingheight: integer; override;
   procedure restart; override;

   property acty: integer read getacty;
   property areafull: boolean read getareafull write setareafull;
 end;
  
 TraBandArea = class(TraCustomBandArea)
  published
   property Font;
 end;

 tileareaoptionty = (tao_vertical);
 tileareaoptionsty = set of tileareaoptionty;
 
 TraCustomTileArea = class(TraBaseBandArea)
  private
   fcolcount: integer;
   frowcount: integer;
   fcellorigin: pointty;
   fLineHorizontal: tablineinfoty;
   fLineVertical: tablineinfoty;
   fLineLeft: tablineinfoty;
   fLineTop: tablineinfoty;
   fLineRight: tablineinfoty;
   fLineBottom: tablineinfoty;
   foptions: tileareaoptionsty;
   procedure setcolcount(const avalue: integer);
   procedure setrowcount(const avalue: integer);

   procedure setLineVertical_Widthmm(const avalue: real);
   procedure setLineVertical_Color(const avalue: colorty);
   procedure setLineVertical_ColorGap(const avalue: colorty);
   procedure setLineVertical_CapStyle(const avalue: capstylety);
   procedure setLineVertical_Dashes(const avalue: string);

   procedure setLineHorizontal_Widthmm(const avalue: real);
   procedure setLineHorizontal_Color(const avalue: colorty);
   procedure setLineHorizontal_ColorGap(const avalue: colorty);
   procedure setLineHorizontal_CapStyle(const avalue: capstylety);
   procedure setLineHorizontal_Dashes(const avalue: string);

   procedure setLineLeft_Widthmm(const avalue: real);
   procedure setLineLeft_Color(const avalue: colorty);
   procedure setLineLeft_ColorGap(const avalue: colorty);
   procedure setLineLeft_CapStyle(const avalue: capstylety);
   procedure setLineLeft_Dashes(const avalue: string);
   procedure setLineLeft_Dist(const avalue: integer);

   procedure setLineTop_Widthmm(const avalue: real);
   procedure setLineTop_Color(const avalue: colorty);
   procedure setLineTop_ColorGap(const avalue: colorty);
   procedure setLineTop_CapStyle(const avalue: capstylety);
   procedure setLineTop_Dashes(const avalue: string);
   procedure setLineTop_Dist(const avalue: integer);

   procedure setLineRight_Widthmm(const avalue: real);
   procedure setLineRight_Color(const avalue: colorty);
   procedure setLineRight_ColorGap(const avalue: colorty);
   procedure setLineRight_CapStyle(const avalue: capstylety);
   procedure setLineRight_Dashes(const avalue: string);
   procedure setLineRight_Dist(const avalue: integer);

   procedure setLineBottom_Widthmm(const avalue: real);
   procedure setLineBottom_Color(const avalue: colorty);
   procedure setLineBottom_ColorGap(const avalue: colorty);
   procedure setLineBottom_CapStyle(const avalue: capstylety);
   procedure setLineBottom_Dashes(const avalue: string);
   procedure setLineBottom_Dist(const avalue: integer);

  protected
   procedure drawline(const acanvas: tcanvas; const ainfo: tablineinfoty;
                                     const start,stop: pointty);
   procedure drawlines(const acanvas: tcanvas);
   procedure dopaintoverlay(const canvas: tcanvas); override;
   function render(const acanvas: tcanvas): boolean; override;
          //true if finished
   function beginband(const acanvas: tcanvas;
                               const sender: TraCustomRecordBand): boolean; override;
   procedure endband(const acanvas: tcanvas; const sender: TraCustomRecordBand); override;  
  public
   constructor create(aowner: tcomponent); override;
   function cellwidthmm: real;
   function cellheightmm: real;
   
   property ColCount: integer read fcolcount write setcolcount default 2;
   property RowCount: integer read frowcount write setrowcount default 2;

   property LineVertical_Widthmm: real read fLineVertical.widthmm write
                 setLineVertical_Widthmm;
   property LineVertical_Color: colorty read fLineVertical.color write
                 setLineVertical_Color default defaulttablinecolor;
   property LineVertical_ColorGap: colorty read fLineVertical.colorgap write
                 setLineVertical_ColorGap default defaulttablinecolorgap;
   property LineVertical_CapStyle: capstylety read fLineVertical.capstyle write
                 setLineVertical_CapStyle default defaulttablinecapstyle;
   property LineVertical_Dashes: string read fLineVertical.dashes write
                 setLineVertical_Dashes;

   property LineHorizontal_Widthmm: real read fLineHorizontal.widthmm write
                 setLineHorizontal_Widthmm;
   property LineHorizontal_Color: colorty read fLineHorizontal.color write
                 setLineHorizontal_Color default defaulttablinecolor;
   property LineHorizontal_ColorGap: colorty read fLineHorizontal.colorgap write
                 setLineHorizontal_ColorGap default defaulttablinecolorgap;
   property LineHorizontal_CapStyle: capstylety read fLineHorizontal.capstyle write
                 setLineHorizontal_CapStyle default defaulttablinecapstyle;
   property LineHorizontal_Dashes: string read fLineHorizontal.dashes write
                 setLineHorizontal_Dashes;

   property LineLeft_Widthmm: real read fLineLeft.widthmm write
                 setLineLeft_Widthmm;
   property LineLeft_Color: colorty read fLineLeft.color write
                 setLineLeft_Color default defaulttablinecolor;
   property LineLeft_ColorGap: colorty read fLineLeft.colorgap write
                 setLineLeft_ColorGap default defaulttablinecolorgap;
   property LineLeft_CapStyle: capstylety read fLineLeft.capstyle write
                 setLineLeft_CapStyle default defaulttablinecapstyle;
   property LineLeft_Dashes: string read fLineLeft.dashes write
                 setLineLeft_Dashes;
   property LineLeft_Dist: integer read fLineLeft.dist write
                 setLineLeft_Dist default defaulttablinedist;
                 
   property LineTop_Widthmm: real read fLineTop.widthmm write
                 setLineTop_Widthmm;                 
   property LineTop_Color: colorty read fLineTop.color write
                 setLineTop_Color default defaulttablinecolor;
   property LineTop_ColorGap: colorty read fLineTop.colorgap write
                 setLineTop_ColorGap default defaulttablinecolorgap;
   property LineTop_CapStyle: capstylety read fLineTop.capstyle write
                 setLineTop_CapStyle default defaulttablinecapstyle;
   property LineTop_Dashes: string read fLineTop.dashes write
                 setLineTop_Dashes;
   property LineTop_Dist: integer read fLineTop.dist write
                 setLineTop_Dist default defaulttablinedist;

   property LineRight_Widthmm: real read fLineRight.widthmm write
                 setLineRight_Widthmm;
   property LineRight_Color: colorty read fLineRight.color write
                 setLineRight_Color default defaulttablinecolor;
   property LineRight_ColorGap: colorty read fLineRight.colorgap write
                 setLineRight_ColorGap default defaulttablinecolorgap;
   property LineRight_CapStyle: capstylety read fLineRight.capstyle write
                 setLineRight_CapStyle default defaulttablinecapstyle;
   property LineRight_Dashes: string read fLineRight.dashes write
                 setLineRight_Dashes;
   property LineRight_Dist: integer read fLineRight.dist write
                 setLineRight_Dist default defaulttablinedist;

   property LineBottom_Widthmm: real read fLineBottom.widthmm write
                 setLineBottom_Widthmm;
   property LineBottom_Color: colorty read fLineBottom.color write
                 setLineBottom_Color default defaulttablinecolor;
   property LineBottom_ColorGap: colorty read fLineBottom.colorgap write
                 setLineBottom_ColorGap default defaulttablinecolorgap;
   property LineBottom_CapStyle: capstylety read fLineBottom.capstyle write
                 setLineBottom_CapStyle default defaulttablinecapstyle;
   property LineBottom_Dashes: string read fLineBottom.dashes write
                 setLineBottom_Dashes;
   property LineBottom_Dist: integer read fLineBottom.dist write
                 setLineBottom_Dist default defaulttablinedist;

   property Options: tileareaoptionsty read foptions write foptions default [];
 end;
 
 TraTileArea = class(TraCustomTileArea)
  published
   property ColCount;
   property RowCount;

   property LineVertical_Widthmm;
   property LineVertical_Color;
   property LineVertical_ColorGap;
   property LineVertical_CapStyle;
   property LineVertical_Dashes;

   property LineHorizontal_Widthmm;
   property LineHorizontal_Color;
   property LineHorizontal_ColorGap;
   property LineHorizontal_CapStyle;
   property LineHorizontal_Dashes;

   property LineLeft_Widthmm;
   property LineLeft_Color;
   property LineLeft_ColorGap;
   property LineLeft_CapStyle;
   property LineLeft_Dashes;
   property LineLeft_Dist;
                 
   property LineTop_Widthmm;                 
   property LineTop_Color;
   property LineTop_ColorGap;
   property LineTop_CapStyle;
   property LineTop_Dashes;
   property LineTop_Dist;

   property LineRight_Widthmm;
   property LineRight_Color;
   property LineRight_ColorGap;
   property LineRight_CapStyle;
   property LineRight_Dashes;
   property LineRight_Dist;

   property LineBottom_Widthmm;
   property LineBottom_Color;
   property LineBottom_ColorGap;
   property LineBottom_CapStyle;
   property LineBottom_Dashes;
   property LineBottom_Dist;

   property Options;
   
   property Font;
 end;
 
 reportpagestatety = (rpps_inited,rpps_rendering,rpps_backgroundrendered,
                      rpps_restart,
                      rpps_showed,rpps_finish,rpps_notfirstrecord,rpps_lastrecord);
 reportpagestatesty = set of reportpagestatety;
 
 trepaz = class;
   
 TraReportPageDataLink = class(tmsedatalink)
 end;

 reportpageoptionty = (PageOnce,PageFirstEven,PageFirstOdd);
 reportpageoptionsty = set of reportpageoptionty;

 reportpageeventty = procedure(const sender: TraReportPage) of object;
 reportpagepainteventty = procedure(const sender: TraReportPage;
                              const acanvas: tcanvas) of object;
 beforerenderpageeventty = procedure(const sender: TraReportPage;
                                          var empty: boolean) of object;
 rapageorientationty = (Portrait,Landscape);
 
 TraReportPage = class(twidget,ibandparent)
  private
   fbands: recordbandarty;
   fclients: ireportclientarty;
   fareas: bandareaarty;
   fstate: reportpagestatesty;
   fpagewidth: real;
   fpageheight: real;
   fppmm: real;
   fvisiblepage: boolean;
   fpagenum: integer;
   fnextpage: TraReportPage;
   fnextpageifempty: TraReportPage;
   fsaveindex: integer;
   fdatalink: TraReportPageDataLink;
   foptions: reportpageoptionsty;
   fprintstarttime: tdatetime;
   freccontrols: pointerarty;
   fpageorientation: rapageorientationty;
   flastpagecount: integer;
   fpapersize: pagesizety;
   fcansetpapersize: boolean;
   procedure setpageorientation(const avalue: rapageorientationty);
   procedure setpagewidth(const avalue: real);
   procedure setpageheight(const avalue: real);
   procedure setpapersize(const avalue: pagesizety);
   procedure updatepapersize;
   procedure updatepagesize;
   procedure setppmm(const avalue: real);
   procedure setnextpage(const avalue: TraReportPage);
   procedure setnextpageifempty(const avalue: TraReportPage);
   function getdatasource: string;
   procedure setdatasource(const avalue: string);
   procedure setoptions(const avalue: reportpageoptionsty);
  protected
   freport: trepaz;
   procedure registerchildwidget(const child: twidget); override;
   procedure unregisterchildwidget(const child: twidget); override;
   procedure insertwidget(const awidget: twidget; const apos: pointty); override;
   procedure sizechanged; override;

   procedure setfont(const avalue: TraStandardFont);
   function getfont: TraStandardFont;
   function getfontclass: widgetfontclassty; override;

   procedure renderbackground(const acanvas: tcanvas);
   procedure beginrender(const arestart: boolean);
   procedure endrender;
   procedure adddatasets(var adatasets: datasetarty);
   function rendering: boolean;
   procedure beginarea(const acanvas: tcanvas; const sender: TraBaseBandArea);
   procedure dobeforerender(var empty: boolean); //virtual;
   procedure doafterpaint1(const acanvas: tcanvas); //virtual;
   procedure dobeforenextrecord(const adatasource: tdatasource);
   procedure dosyncnextrecord;
   
   function render(const acanvas: tcanvas): boolean;
          //true if empty
   
   procedure init; //virtual;

   //ibandparent
   function getppmm: real;
   procedure registerclient(const aclient: ireportclient);
   procedure unregisterclient(const aclient: ireportclient);
   function beginband(const acanvas: tcanvas;
                               const sender: TraCustomRecordBand): boolean;
   procedure endband(const acanvas: tcanvas; const sender: TraCustomRecordBand);  
   function istopband: boolean;
   function isfirstband: boolean;
   function islastband(const addheight: integer = 0): boolean;
   procedure setareafull(const avalue: boolean);
   
   procedure updatevisible;
   function remainingheight: integer;
   function pagepagenum: integer; //null based
   function reppagenum: integer; //null based
   function pageprintstarttime: tdatetime;
   function repprintstarttime: tdatetime;
   function getreppage: TraReportPage;
   function getlastpagepagecount: integer;
   function getlastreppagecount: integer;
  
  public
   constructor create(aowner: tcomponent); override;
   destructor destroy; override;

   function isfirstrecord: boolean;
   function islastrecord: boolean;
   
   procedure recordchanged;   
   property report: trepaz read freport write freport;
   property pagenum: integer read fpagenum write fpagenum; 
                 //null-based, local to this page
   property lastpagecount: integer read getlastpagepagecount write flastpagecount;
                 //local to this page
   property printstarttime: tdatetime read fprintstarttime write fprintstarttime;
   procedure activatepage;
   procedure finish;
   procedure restart;
   procedure resetzebra;
   property ppmm: real read fppmm write setppmm; //pixel per mm
   property VisiblePage: boolean read fvisiblepage write fvisiblepage default true;
   
  published
   property NextPage: TraReportPage read fnextpage write setnextpage;
   property NextPageIfEmpty: TraReportPage read fnextpageifempty write 
                          setnextpageifempty;
   property DataSource: string read getdatasource write setdatasource;
   property Options: reportpageoptionsty read foptions write setoptions default [];
   property PaperSize: pagesizety read fpapersize write setpapersize nodefault;
   property PageOrientation: rapageorientationty read fpageorientation 
                write setpageorientation default Portrait;   
   property PageWidth: real read fpagewidth write setpagewidth;
   property PageHeight: real read fpageheight write setpageheight;
   property Font: TraStandardFont read getfont write setfont stored isfontstored;
 end;
 
 reportpagearty = array of TraReportPage;
 
 repstatety = (rs_activepageset,rs_finish,rs_restart,rs_running,rs_endpass,rs_dummypage);
 repstatesty = set of repstatety;

 reporteventty = procedure(const sender: trepaz) of object;
 

 reportoptionty = (reo_prepass,reo_nodisablecontrols,reo_waitdialog,
                  reo_autoreadstat,reo_autowritestat);
 reportoptionsty = set of reportoptionty;
 printdestinationty = (preview,printer,postscript,pdf,html,text);

const
 defaultreportoptions = [reo_waitdialog];
 
type 

 trepaz = class(tmsecomponent,istatfile)
  private
   freportactions: repactionsty;
   foptions: reportoptionsty;
   funits: raunitty;
   fscale: real;
   fppmm: real;
   //event
   fonpagebeforerender: beforerenderpageeventty;
   fonpageafterpaint: reportpagepainteventty;
   fonpagepaint: reportpagepainteventty;
   fonreportstart: reporteventty;
   fonbeforerender: reporteventty;
   fonafterrender: reporteventty;
   fonreportfinished: notifyeventty;
   fonfirstpage: reportpageeventty;
   fonafterlastpage: reportpageeventty;
   fonprogress: notifyeventty;
   fonrenderfinish: reporteventty;
   foncreate: notifyeventty;
   fondestroy: notifyeventty;
   fondestroyed: notifyeventty;
   
   fpagenum: integer;
   fcanceled: boolean;
   fstate: repstatesty;
   factivepage: integer;
   fprintstarttime: tdatetime;
   flastpagecount: integer;
   reportcanvas: tcanvas;
   tmpcanvas: twidget;
   fdialogtext: msestring;
   fdialogcaption: msestring;
   fdatasets: datasetarty;
   ffilename: filenamety;
   freportowner: tcomponent;
   fdatasources: trepazdatasources;
   flookupbuffers: trepazlookupbuffers;
   frootcomp: tcomponent;
   fprintdestination: printdestinationty;
   isreportfinished: boolean;
   fstatfile: tstatfile;
   fstatvarname: msestring;

   procedure setprintdestination(const avalue: printdestinationty);
   procedure setunits(const avalue: raunitty);
   procedure setppmm(const avalue: real);
   procedure setdatasources(const avalue: trepazdatasources);
   procedure setlookupbuffers(const avalue: trepazlookupbuffers);
   function getreppages(index: integer): TraReportPage;
   procedure setreppages(index: integer; const avalue: TraReportPage);
   function exec: integer;
   function getcanceled: boolean;
   function getfilename: filenamety;
   procedure setcanceled(const avalue: boolean);
   function getrunning: boolean;
   procedure setactivepage(const avalue: integer);
   procedure doexec(const sender: tobject);
   procedure docancel(const sender: tobject);
   //for load component from file
   procedure findcomponentclass(Reader: TReader; const aClassName: string;
                   var ComponentClass: TComponentClass);
   procedure createcomponent(Reader: TReader; ComponentClass: TComponentClass;
                   var Component: TComponent);
   procedure readstringproperty(Sender:TObject; const Instance: TPersistent;
    PropInfo: PPropInfo; var Content:string);
   procedure onreferencename(Reader: TReader; var aName: string);
   //end of load component from file
   procedure setstatfile(const avalue: tstatfile);
  protected
   freppages: reportpagearty;
   procedure dopagebeforerender(const sender: TraReportPage;
                                          var empty: boolean);
   procedure dopagepaint(const sender: TraReportPage;
                              const acanvas: tcanvas);
   procedure dopageafterpaint(const sender: TraReportPage;
                              const acanvas: tcanvas);
   procedure dofirstpage(const apage:TraReportPage); //virtual;
   procedure doafterlastpage(const apage:TraReportPage); //virtual;
   procedure doonreportfinished;
   
   procedure addpage(apage: TraReportPage);
   procedure internalrender;
   procedure removepage(const apage: TraReportPage);
   procedure nextpage(const acanvas: tcanvas; const apage: TraReportPage);
   procedure doprogress;
   procedure doasyncevent(var atag: integer); override;
   procedure loadfromfile(afilename: filenamety; var isloaded: boolean);
   procedure converttoformattedtext(var atext: msestringarty; var aformat: printercodearty);
   //istatfile
   procedure dostatread(const reader: tstatreader);
   procedure dostatwrite(const writer: tstatwriter);
   procedure statreading;
   procedure statread;
   function getstatvarname: msestring;

  public
   fosprinter: tosprinter;
   fpsprinter: tpsprinter;
   constructor create(aowner: tcomponent); override;
   destructor destroy; override;
   procedure assign(sender: tpersistent);override;
   procedure reportdesign;
   procedure reportexecute;
   procedure reportexecute(const usedialog: boolean);
   procedure reportpreview;
   procedure reportprint(const withdialog: boolean);
   procedure reportposprint;
   procedure reportpdf;
   procedure reportpostscript;
   procedure savemetapages;
   procedure restart;
   procedure recordchanged;  
     //calls recordchanged of active page
   function reppagecount: integer;
   property reppages[index: integer]: TraReportPage read getreppages 
                                                write setreppages; default;
   property pagenum: integer read fpagenum {write fpagenum}; 
                            //null-based
   property lastpagecount: integer read flastpagecount write flastpagecount;
   property activepage: integer read factivepage write setactivepage;
   procedure finish;
   function prepass: boolean; //true if in prepass render state
   property printstarttime: tdatetime read fprintstarttime write fprintstarttime;

   property canceled: boolean read getcanceled write setcanceled;
   property running: boolean read getrunning;
   property reportowner: tcomponent read freportowner write freportowner;
  published
   property FileName: filenamety read getfilename write ffilename;
   property ReportAction: repactionsty read freportactions 
                 write freportactions{ default defaultreportactions};
   property ReportUnit: raunitty read funits write setunits default Milimeter;
   property UnitScale: real read fscale write fscale;
   property ppmm: real read fppmm write setppmm; //pixel per mm
   property Options: reportoptionsty read foptions write foptions 
                                  default defaultreportoptions;
   property PrintDestination: printdestinationty read fprintdestination write setprintdestination;
   property DialogText: msestring read fdialogtext write fdialogtext;
   property DialogCaption: msestring read fdialogcaption write fdialogcaption;
   property DataSources: trepazdatasources read fdatasources write setdatasources;
   property LookUpBuffers: trepazlookupbuffers read flookupbuffers write setlookupbuffers;
   property statfile: tstatfile read fstatfile write setstatfile;
   property statvarname: msestring read fstatvarname write fstatvarname;
   property onreportstart: reporteventty read fonreportstart write fonreportstart;
   property onbeforerender: reporteventty read fonbeforerender
                               write fonbeforerender;
   property onafterrender: reporteventty read fonafterrender
                               write fonafterrender;
   property onreportfinished: notifyeventty read fonreportfinished 
                                                     write fonreportfinished;
   property onpagebeforerender: beforerenderpageeventty read fonpagebeforerender
                               write fonpagebeforerender;
   property onpagepaint: reportpagepainteventty read fonpagepaint 
                        write fonpagepaint;
   property onpageafterpaint: reportpagepainteventty read fonpageafterpaint 
                        write fonpageafterpaint;
   property onprogress: notifyeventty read fonprogress write fonprogress;
   property oncreate: notifyeventty read foncreate write foncreate;
   property ondestroy: notifyeventty read fondestroy write fondestroy;
   property ondestroyed: notifyeventty read fondestroyed write fondestroyed;
   property onfirstpage: reportpageeventty read fonfirstpage
                               write fonfirstpage;
   property onafterlastpage: reportpageeventty read fonafterlastpage
                               write fonafterlastpage;
 end;

 TPreviewForm = class(trepazpreviewfo)
  private
   freport: trepaz;
  protected
   procedure reportprint(const sender: TObject);
   procedure reportpostscript(const sender: TObject);
   procedure reportpdf(const sender: TObject);
  public
   constructor create(aowner: tcomponent); override;
 end;
 
 TRepazDialog = class(trepazdialogfo)
 private
  freport: trepaz;
 protected
  procedure changesetting(const sender: TObject);
  procedure showdlgagain(const sender: TObject);
 public
  constructor create(aowner: tcomponent); override;
 end;
 
var
 fdatasourcereport: trepazdatasources;
 flookupbufferreport: trepazlookupbuffers;
 fmetapages: tmetapages;
 frepazevaluator: trepazevaluator;
 
implementation
uses
 msedatalist,sysutils,msestreaming,msebits,msereal,math,repazdesign,
 msefiledialog,msefileutils;
type
 tcustomframe1 = class(tcustomframe);
 twidget1 = class(twidget);
 tcomponent1 = class(tcomponent);
 tmsecomponent1 = class(tmsecomponent);

var
 fmetapagecount: integer;
 fmetatextobjectcount: integer;
 fmetalineobjectcount: integer;
 fmetarectobjectcount: integer;

function checkdashes(const avalue: string): string;
var
 int1: integer;
begin
 result:= avalue;
 for int1:= 1 to length(avalue) do begin
  if avalue[int1] = #0 then begin
   setlength(result,int1-1);     //remove nulls
   break;
  end;
 end;
end;

procedure setevaluatordatasource(const adatasource: trepazdatasources);
begin
 if frepazevaluator=nil then frepazevaluator:= trepazevaluator.create(nil);
 frepazevaluator.datasource:= adatasource;
end;

function getevaluator: trepazevaluator;
begin
 result:= frepazevaluator;
end;

procedure evalexpression(const aexpression: msestring);
begin
 frepazevaluator.expression:= aexpression;
end;

function getexpressionresult: msestring;
begin
 try
  frepazevaluator.evaluate;
  result:= frepazevaluator.evalresultstring;
 except
  raise;
 end;
end;

procedure setnewmetareportpage(const apage: TraReportPage);
begin
 inc(fmetapagecount);
 setlength(fmetapages,fmetapagecount);
 fmetatextobjectcount:=0;
 fmetalineobjectcount:=0;
 fmetarectobjectcount:= 0;
end;

function getmetapages: tmetapages;
begin
 result:= fmetapages;
end;

procedure createnewmetareport;
begin
 fmetapages:=nil;
 fmetapagecount:= 0;
 fmetatextobjectcount:= 0;
 fmetalineobjectcount:= 0;
 fmetarectobjectcount:= 0;
end;

procedure addlinetoreport(const ainfo: replineinfoty);
begin
 setlength(fmetapages[fmetapagecount-1].lineobjects,fmetalineobjectcount+1);
 fmetapages[fmetapagecount-1].lineobjects[fmetalineobjectcount]:= ainfo;
 inc(fmetalineobjectcount);
end;

procedure addtexttoreport(const ainfo: reptextinfoty);
begin
 setlength(fmetapages[fmetapagecount-1].textobjects,fmetatextobjectcount+1);
 fmetapages[fmetapagecount-1].textobjects[fmetatextobjectcount]:= ainfo;
 inc(fmetatextobjectcount);
end;

procedure addrecttoreport(const ainfo: reprectinfoty);
begin
 setlength(fmetapages[fmetapagecount-1].rectobjects,fmetarectobjectcount+1);
 fmetapages[fmetapagecount-1].rectobjects[fmetarectobjectcount]:= ainfo;
 inc(fmetarectobjectcount);
end;

procedure renderingerror;
begin
 raise exception.create('Operation not possible while rendering');
end;

function checkislastrecord(const adatalink: tmsedatalink; 
                               const syncproc: synceventty): boolean;
var
 bm: string;
 int1: integer;
begin                     
 with adatalink do begin          //todo: optimize   
  if active then begin
   if not dataset.eof then begin
//    bm:= dataset.7; //boookmarks are broken for TFixedFormatDataSet
// and recnos are faster anyway
    int1:= dataset.recno; 
    dataset.next;
    result:= dataset.eof;
    if assigned(syncproc) and not result then begin
     syncproc;
    end;
//    dataset.bookmark:= bm;
    dataset.recno:= int1;
   end
   else begin
    result:= true;
   end;
  end
  else begin
   result:= false;
  end;
 end;
end;

procedure setdatasourcereport(const avalue: trepazdatasources);
begin
 fdatasourcereport:= avalue;
end;

function getdatasourcereport(const aname: string): tdatasource;
var
 int1: integer;
begin
 result:= nil;
 if fdatasourcereport<>nil then begin
  with fdatasourcereport do begin
   for int1:=0 to count-1 do begin
    if lowercase(aname)=lowercase(DataSource[int1].DataSource.name) then begin
     result:= DataSource[int1].DataSource;
     exit;
    end;
   end;
  end;
 end;
end;

procedure setlookupbufferreport(const avalue: trepazlookupbuffers);
begin
 flookupbufferreport:= avalue;
end;

function getlookupbufferreport(const aname: string): tcustomlookupbuffer;
var
 int1: integer;
begin
 result:= nil;
 if flookupbufferreport<>nil then begin
  with flookupbufferreport do begin
   for int1:=0 to count-1 do begin
    if lowercase(aname)=lowercase(lookupbuffer[int1].lookupbuffer.name) then begin
     result:= lookupbuffer[int1].lookupbuffer;
     exit;
    end;
   end;
  end;
 end;
end;

{ TPreviewForm }

constructor TPreviewForm.create(aowner: tcomponent);
begin
 inherited;
 freport:= trepaz(aowner);
 btnprint.onexecute:=@reportprint;
 tmainmenu1.menu.items[0].itembyname('mnuprint').onexecute:= @reportprint;
 btnps.onexecute:=@reportpostscript;
 tmainmenu1.menu.items[0].itembyname('mnupostscript').onexecute:= @reportpostscript;
 btnpdf.onexecute:=@reportpdf;
 tmainmenu1.menu.items[0].itembyname('mnupdf').onexecute:= @reportpdf;
end;

procedure TPreviewForm.reportprint(const sender: TObject);
begin
 freport.reportprint(true); 
end;

procedure TPreviewForm.reportpostscript(const sender: TObject);
begin
 freport.reportpostscript; 
end;

procedure TPreviewForm.reportpdf(const sender: TObject);
begin
 freport.reportpdf; 
end;

{ TRepaDialog }

constructor TRepazDialog.create(aowner: tcomponent);
begin
 inherited;
 freport:= trepaz(aowner);
 btnsetting.onexecute:=@changesetting;
 showagain.ondataentered:=@showdlgagain;
 cactions.dropdown.itemindex:=ord(freport.printdestination);
 cdescription.caption:= cactions.dropdown.cols[1].items[cactions.dropdown.itemindex];
end;

procedure TRepazDialog.changesetting(const sender: TObject);
begin
 if cactions.dropdown.itemindex=0 then begin
  showmessage('Preview does not need to be configured!');
 end else if cactions.dropdown.itemindex=1 then begin
  freport.fosprinter.showdialog;
 end else if cactions.dropdown.itemindex=2 then begin
  //freport.fposprinter.showdialog;
 end else if cactions.dropdown.itemindex=3 then begin
  freport.fpsprinter.showdialog;
 end;
end;

procedure TRepazDialog.showdlgagain(const sender: TObject);
begin
 freport.reportaction:= freport.reportaction - [ra_showdialog];
end;

{ TraTabFont }

class function TraTabFont.getinstancepo(owner: tobject): pfont;
begin
 result:= @TraTabulatorItem(owner).ffont;
end;

constructor TraTabFont.create;
begin
 inherited;
 finfo.color:= defaultrepfontcolor;
 finfo.name:= defaultrepfontname;
end;

procedure TraTabFont.setname(const avalue: string);
begin
 if avalue = '' then begin
  inherited setname(defaultrepfontname);
 end
 else begin
  inherited;
 end;
end;

{ TraTabItemDataLink }

constructor TraTabItemDataLink.create(const aowner: TraTabulatorItem);
begin
 fowner:= aowner;
 inherited create;
end;

procedure TraTabItemDataLink.recordchanged(afield: tfield);
begin
 if (afield = nil) or (afield = field) then begin
  fowner.changed;
 end;
end;

{ TraTabulatorItem }

constructor TraTabulatorItem.create(aowner: tobject);
var
 kind1: tablinekindty;
begin
 fcolor:= cl_none;
 ftextflags:= defaultreptabtextflags;
 fdatalink:= TraTabItemDataLink.create(self);
 for kind1:= low(tablinekindty) to high(tablinekindty) do begin
  flineinfos[kind1]:= defaulttablineinfo;
 end;
 inherited;
 with TraTabulators(aowner),fband do begin
  self.flineinfos[tlk_vert]:= flineinfos[tlk_vert];
  if not (csloading in componentstate) then begin
   self.fdatalink.DataSource:= getdatasourcereport(DataSource); //ragu
   self.fdistleft:= distleft;
   self.fdistright:= distright;
  end;
 end;
 frawfont:= rfNormal;
 fexpression:= '';
end;

destructor TraTabulatorItem.destroy;
begin
 flookupbuffer:= nil;
 inherited;
 ffont.free;
 fdatalink.free;
end;

procedure TraTabulatorItem.setvalue(const avalue: msestring);
begin
 fvalue.text:= avalue;
 fvalue.format:= nil;
 changed;
end;

procedure TraTabulatorItem.setexpression(const avalue: msestring);
begin
 if avalue<>fexpression then begin
  fexpression:= avalue;
  if fexpression<>'' then begin
   evalexpression(fexpression);
   setvalue(getexpressionresult);
  end;
 end;
end;

procedure TraTabulatorItem.setrichvalue(const avalue: richstringty);
begin
 fvalue:= avalue;
 changed;
end;

function TraTabulatorItem.getfont: TraTabFont;
begin
 getoptionalobject(TraTabulators(fowner).fband.componentstate,ffont,
                     {$ifdef FPC}@{$endif}createfont);
 if ffont <> nil then begin
  result:= ffont;
 end
 else begin
  result:= TraTabFont(TraTabulators(fowner).fband.getfont);
 end;
end;

procedure TraTabulatorItem.createfont;
begin
 if ffont = nil then begin
  ffont:= TraTabFont.create;
  ffont.onchange:= {$ifdef FPC}@{$endif}fontchanged;
 end;
end;

procedure TraTabulatorItem.setfont(const avalue: TraTabFont);
begin
 if avalue <> ffont then begin
  setoptionalobject(TraTabulators(fowner).fband.componentstate,avalue,
                 ffont,{$ifdef fpc}@{$endif}createfont);
  changed;
 end;
end;

function TraTabulatorItem.isfontstored: boolean;
begin
 result:= ffont <> nil;
end;

procedure TraTabulatorItem.changed;
begin
 with TraTabulators(fowner),fband do begin
  fsizevalid:= false;
  if rendering or ([csdesigning,csdestroying] * componentstate = 
                                                   [csdesigning]) then begin
   minclientsizechanged;
//   change(-1);
  end;
 end;
end;

procedure TraTabulatorItem.setpos(const avalue: real);
begin
 inherited;
 TraTabulators(fowner).fband.sendchangeevent(oe_designchanged);  
         //syncronize linked Tabulators
end;

procedure TraTabulatorItem.fontchanged(const asender: tobject);
begin
 changed;
end;

procedure TraTabulatorItem.settextflags(const avalue: textflagsty);
begin
 if ftextflags <> avalue then begin
  ftextflags:= checktextflags(ftextflags,avalue);
  changed;
 end;
end;

function TraTabulatorItem.getdatasource1: string;
begin
 if fdatalink.DataSource=nil then begin
  result:= '';
 end else begin
  result:= fdatalink.DataSource.name;
 end;
end;

procedure TraTabulatorItem.setdatasource(const avalue: string);
begin
 if avalue='' then begin
  fdatalink.DataSource:= nil;
 end else begin
  fdatalink.DataSource:= getdatasourcereport(avalue);
  changed;
 end;
end;

function TraTabulatorItem.getdatafield: string;
begin
 result:= fdatalink.fieldname;
end;

procedure TraTabulatorItem.setdatafield(const avalue: string);
begin
 fdatalink.fieldname:= avalue;
end;

function TraTabulatorItem.getdatasource(const aindex: integer): tdatasource;
begin
 result:= fdatalink.DataSource;
end;

procedure TraTabulatorItem.getfieldtypes(out apropertynames: stringarty;
               out afieldtypes: fieldtypesarty);
begin
 apropertynames:= nil;
 afieldtypes:= nil;
end;

function TraTabulatorItem.getdisptext: richstringty;
var
 key: integer;
 int1: integer;
 rea1: realty; 
begin
 if fexpression<>'' then begin
  //if fdatalink.fieldactive then begin
   evalexpression(fexpression);
   result.format:= nil;
   result.text:= getexpressionresult;
  //end; 
 end else begin
  if fdatalink.fieldactive then begin
   result.format:= nil;
   if flookupbuffer <> nil then begin
    try
     result.text:= '';
     key:= fdatalink.field.asinteger;
     case flookupkind of
      lk_Text: begin
       result.text:= fformat + flookupbuffer.lookuptext(flookupkeyfieldno,
                    flookupvaluefieldno,key);
      end;
      lk_Integer: begin
       int1:= flookupbuffer.lookupinteger(flookupkeyfieldno,
                    flookupvaluefieldno,key);
 //      result.text:= inttostr(int1);
       result.text:= realtytostr(int1,fformat);
      end;
      lk_Float: begin
       rea1:= flookupbuffer.lookupfloat(flookupkeyfieldno,
                    flookupvaluefieldno,key);
       result.text:= realtytostr(rea1,fformat)
      end;
      lk_Date,lk_DateTime: begin
       rea1:= flookupbuffer.lookupfloat(flookupkeyfieldno,
                    flookupvaluefieldno,key);
       result.text:= mseformatstr.datetimetostring(rea1,fformat);
      end;
      lk_Time: begin
       rea1:= flookupbuffer.lookupfloat(flookupkeyfieldno,
                    flookupvaluefieldno,key);
       result.text:= mseformatstr.timetostring(rea1,fformat);
      end;
     end;
    except
     on e: exception do begin
      e.message:= 'Error : ' +e.message;
      raise;
     end;
    end;
   end
   else begin
    if foptions * [rto_Sum,rto_Count,rto_Average] <> [] then begin
     with fdatalink.field do begin
      if not (rto_ShowNull in foptions) and 
       ((rto_NoCurrentValue in foptions) or fsum.resetpending or 
                    isnull and not (rto_Count in foptions)) and 
                                                (fsum.count = 0) then begin
       result.text:= '';
      end
      else begin
       if rto_Count in foptions then begin
        result.text:= realtytostr(sumcount,fformat);
       end
       else begin
        if rto_Average in foptions then begin
         int1:= sumcount;
         if int1 = 0 then begin
          result.text:= realtytostr(0,fformat);
         end
         else begin
          case datatype of 
           ftinteger,ftword,ftsmallint,ftboolean: begin
            result.text:= realtytostr(sumasinteger/int1,fformat);
           end;
           ftlargeint: begin
            result.text:= realtytostr(sumaslargeint/int1,fformat);
           end;
           ftfloat: begin
            result.text:= realtytostr(sumasfloat/int1,fformat);
           end;
           ftbcd: begin
            result.text:= realtytostr(sumascurrency/int1,fformat);
           end;
          end;
         end;
        end
        else begin
         case datatype of 
          ftinteger,ftword,ftsmallint,ftboolean: begin
           result.text:= realtytostr(sumasinteger,fformat);
          end;
          ftlargeint: begin
           result.text:= realtytostr(sumaslargeint,fformat);
          end;
          ftfloat: begin
           result.text:= realtytostr(sumasfloat,fformat);
          end;
          ftbcd: begin
           result.text:= realtytostr(sumascurrency,fformat);
          end;
         end;
        end;
       end;
      end;
     end;
    end
    else begin
     result.text:= fdatalink.msedisplaytext(fformat);
    end;
   end;
  end
  else begin
   if rto_Count in foptions then begin
    if not (rto_ShowNull in foptions) and 
         ((rto_NoCurrentValue in foptions) or fsum.resetpending) and 
                                                (fsum.count = 0) then begin
     result.text:= '';
    end
    else begin
     result.text:= realtytostr(sumcount,fformat);
    end
   end
   else begin
    result:= fvalue;
   end;
  end;
 end;
end;

procedure TraTabulatorItem.setLineTop_Widthmm(const avalue: real);
begin
 flineinfos[tlk_top].widthmm:= avalue;
 changed;
end;

procedure TraTabulatorItem.setLineTop_Color(const avalue: colorty);
begin
 flineinfos[tlk_top].color:= avalue;
 changed;
end;

procedure TraTabulatorItem.setLineTop_ColorGap(const avalue: colorty);
begin
 flineinfos[tlk_top].colorgap:= avalue;
 changed;
end;

procedure TraTabulatorItem.setLineTop_CapStyle(const avalue: capstylety);
begin
 flineinfos[tlk_top].capstyle:= avalue;
 changed;
end;

procedure TraTabulatorItem.setLineTop_Dashes(const avalue: string);
begin
 flineinfos[tlk_top].dashes:= checkdashes(avalue);
 changed;
end;

procedure TraTabulatorItem.setLineTop_Dist(const avalue: integer);
begin
 flineinfos[tlk_top].dist:= avalue;
 changed;
end;

procedure TraTabulatorItem.setLineTop_visible(const avalue: linevisiblesty);
begin
 flineinfos[tlk_top].visible:= avalue;
 changed;
end;

procedure TraTabulatorItem.setLineVertical_Widthmm(const avalue: real);
begin
 flineinfos[tlk_vert].widthmm:= avalue;
 changed;
end;

procedure TraTabulatorItem.setLineVertical_Color(const avalue: colorty);
begin
 flineinfos[tlk_vert].color:= avalue;
 changed;
end;

procedure TraTabulatorItem.setLineVertical_ColorGap(const avalue: colorty);
begin
 flineinfos[tlk_vert].colorgap:= avalue;
 changed;
end;

procedure TraTabulatorItem.setLineVertical_CapStyle(const avalue: capstylety);
begin
 flineinfos[tlk_vert].capstyle:= avalue;
 changed;
end;

procedure TraTabulatorItem.setLineVertical_Dashes(const avalue: string);
begin
 flineinfos[tlk_vert].dashes:= checkdashes(avalue);
 changed;
end;

procedure TraTabulatorItem.setLineVertical_Dist(const avalue: integer);
begin
 flineinfos[tlk_vert].dist:= avalue;
 changed;
end;

procedure TraTabulatorItem.setLineVertical_visible(const avalue: linevisiblesty);
begin
 flineinfos[tlk_vert].visible:= avalue;
 changed;
end;

procedure TraTabulatorItem.setLineBottom_Widthmm(const avalue: real);
begin
 flineinfos[tlk_bottom].widthmm:= avalue;
 changed;
end;

procedure TraTabulatorItem.setLineBottom_Color(const avalue: colorty);
begin
 flineinfos[tlk_bottom].color:= avalue;
 changed;
end;

procedure TraTabulatorItem.setLineBottom_ColorGap(const avalue: colorty);
begin
 flineinfos[tlk_bottom].colorgap:= avalue;
 changed;
end;

procedure TraTabulatorItem.setLineBottom_CapStyle(const avalue: capstylety);
begin
 flineinfos[tlk_bottom].capstyle:= avalue;
 changed;
end;

procedure TraTabulatorItem.setLineBottom_Dashes(const avalue: string);
begin
 flineinfos[tlk_bottom].dashes:= checkdashes(avalue);
 changed;
end;

procedure TraTabulatorItem.setLineBottom_Dist(const avalue: integer);
begin
 flineinfos[tlk_bottom].dist:= avalue;
 changed;
end;

procedure TraTabulatorItem.setLineBottom_visible(const avalue: linevisiblesty);
begin
 flineinfos[tlk_bottom].visible:= avalue;
 changed;
end;

function TraTabulatorItem.xlineoffset: integer;
begin
 with flineinfos[tlk_vert] do begin
  if kind = tak_left then begin
   result:= -dist;
  end
  else begin
   result:= dist;
  end;
 end; 
end;

procedure TraTabulatorItem.recchanged;
begin
 fdatalink.recordchanged(nil);
end;

procedure TraTabulatorItem.setlookupbuffer(const avalue: string);
begin
 flookupbufferstring:= avalue;
 TraTabulators(fowner).fband.setlinkedvar(getlookupbufferreport(avalue),tmsecomponent(flookupbuffer));
 changed;
end;

procedure TraTabulatorItem.setlookupkeyfieldno(const avalue: integer);
begin
 flookupkeyfieldno:= avalue;
 changed;
end;

procedure TraTabulatorItem.setlookupvaluefieldno(const avalue: integer);
begin
 flookupvaluefieldno:= avalue;
 changed;
end;

procedure TraTabulatorItem.setlookupkind(const avalue: lookupkindty);
begin
 flookupkind:= avalue;
 changed;
end;

procedure TraTabulatorItem.setformat(const avalue: msestring);
begin
 fformat:= avalue;
 changed;
end;

procedure TraTabulatorItem.setcolor(avalue: colorty);
begin
 if avalue = cl_invalid then begin
  avalue:= cl_none;
 end;
 if fcolor <> avalue then begin
  fcolor:= avalue;
  TraTabulators(fowner).fband.invalidate;  
 end
end;

procedure TraTabulatorItem.resetsum(const skipcurrent: boolean);
begin
 fillchar(fsum,sizeof(fsum),0);
 fsum.resetpending:= skipcurrent;
 fsum.reset:= true;
end;

procedure TraTabulatorItem.initsum;
begin
 fillchar(fsum,sizeof(fsum),0);
end;

procedure TraTabulatorItem.dobeforenextrecord(const adatasource: tdatasource);
begin
 if (foptions * [rto_Count,rto_Sum,rto_Average] <>  []) and 
          (fdatalink.DataSource = adatasource) then begin
  if fdatalink.active then begin
   if fdatalink.field = nil then begin
    inc(fsum.count);
   end
   else begin
    with fdatalink.field,fsum do begin
     if not isnull then begin
      inc(count);
      case datatype of
       ftinteger,ftword,ftsmallint,ftboolean: begin
        integervalue:= integervalue + asinteger;
       end;
       ftlargeint: begin
        largeintvalue:= largeintvalue + aslargeint;
       end;
       ftfloat: begin
        floatvalue:= floatvalue + asfloat;
       end;
       ftbcd: begin
        bcdvalue:= bcdvalue + ascurrency;
       end;
      end;
     end;
    end;
   end;
  end;
  if fsum.resetpending then begin
   initsum;
  end;
 end;
end;

function TraTabulatorItem.getsumasinteger: integer;
begin
 if fsum.resetpending and fsum.reset or not fdatalink.fieldactive then begin
  result:= 0;
 end
 else begin
  result:= fsum.integervalue;
  if not (rto_NoCurrentValue in foptions) then begin
   result:= result + fdatalink.field.asinteger;
  end;
 end;
end;

function TraTabulatorItem.getsumaslargeint: int64;
begin
 if fsum.resetpending and fsum.reset or not fdatalink.fieldactive then begin
  result:= 0;
 end
 else begin
  result:= fsum.largeintvalue;
  if not (rto_NoCurrentValue in foptions) then begin
   result:= result + fdatalink.field.aslargeint;
  end;
 end;
end;

function TraTabulatorItem.getsumasfloat: double;
begin
 if fsum.resetpending and fsum.reset or not fdatalink.fieldactive then begin
  result:= 0;
 end
 else begin
  result:= fsum.floatvalue;
  if not (rto_NoCurrentValue in foptions) then begin
   result:= result + fdatalink.field.asfloat;
  end;
 end;
end;

function TraTabulatorItem.getsumascurrency: currency;
begin
 if fsum.resetpending and fsum.reset or not fdatalink.fieldactive then begin
  result:= 0;
 end
 else begin
  result:= fsum.bcdvalue;
  if not (rto_NoCurrentValue in foptions) then begin
   result:= result + fdatalink.field.ascurrency;
  end;
 end;
end;

function TraTabulatorItem.getsumcount: integer;
begin
 if fsum.resetpending and fsum.reset or not fdatalink.active then begin
  result:= 0;
 end
 else begin
  result:= fsum.count;
  if not (rto_NoCurrentValue in foptions) then begin
   result:= result + 1;
  end;
 end;
end;

procedure TraTabulatorItem.setoptions(const avalue: reptabulatoritemoptionsty);
var
 mask: reptabulatoritemoptionsty = [rto_Count,rto_Sum,rto_Average];
begin
 if avalue <> foptions then begin
  foptions:= reptabulatoritemoptionsty(setsinglebit(longword(avalue),
                                 longword(foptions),longword(mask)));
  changed;
 end;
end;

procedure TraTabulatorItem.scale(const ascale: real);
begin
 if ffont <> nil then begin
  ffont.scale(ascale);
 end;
end;

{ TraTabulators }

constructor TraTabulators.create(const aowner: TraCustomRecordBand);
var
 kind1: tablinekindty;
begin
 fband:= aowner;
 fLineLeft:= defaulttablineinfo;
 fLineRight:= defaulttablineinfo;
 for kind1:= low(tablinekindty) to high(tablinekindty) do begin
  flineinfos[kind1]:= defaulttablineinfo;
 end;
 inherited create;
end;

destructor TraTabulators.destroy;
begin
 inherited; 
end;

class function TraTabulators.getitemclass: tabulatoritemclassty;
begin
 result:= TraTabulatorItem;
end;

function TraTabulators.getitems(const index: integer): TraTabulatorItem;
begin
 result:= TraTabulatorItem(inherited items[index]);
end;

procedure TraTabulators.setitems(const index: integer;
               const avalue: TraTabulatorItem);
begin
 inherited items[index]:= avalue;
end;

procedure TraTabulators.processvalues(const acanvas: tcanvas;
   const adest: rectty; const apaint: boolean; const isrendering:boolean);
var
 bo1: boolean;
 bandcx: integer;
 visiblemask: linevisiblesty;
 
 procedure checkinit(const ainfo: tablineinfoty);
 begin
  if not bo1 then begin
   bo1:= true;
   acanvas.save;
   acanvas.move(makepoint(adest.x,0));
   acanvas.addcliprect(inflaterect(makerect(nullpoint,fband.size),1000));
                   //allow line drawing everywhere
  end;
  with ainfo do begin
   acanvas.linewidthmm:= widthmm;
   acanvas.capstyle:= capstyle;
   if (dashes <> '') and (colorgap <> cl_transparent) then begin
    acanvas.dashes:= copy(dashes+#0,1,high(dashesstringty));
    acanvas.colorbackground:= colorgap;
   end
   else begin
    acanvas.dashes:= copy(dashes,1,high(dashesstringty));
   end;
  end;
 end;
 
 procedure drawhorzline(const aindex: integer; const akind: tablinekindty);
  function nextx: integer;
  begin
   if aindex < high(ftabs) then begin
    with ftabs[aindex+1] do begin
     result:= linepos + TraTabulatorItem(fitems[index]).xlineoffset;
    end;
   end
   else begin
    result:= bandcx;
   end;
  end;
  
 var
  startx,endx,y: integer;
 begin
  with TraTabulatorItem(fitems[ftabs[aindex].index]) do begin
   with flineinfos[akind] do begin
    if widthmm > 0 then begin
     if visible * visiblemask <> [] then begin
      checkinit(flineinfos[akind]);
      with ftabs[aindex] do begin     
       case kind of
        tak_left: begin
         startx:=linepos + xlineoffset;
         endx:= nextx;
        end;
        else begin
         if aindex > 0 then begin
          with ftabs[aindex-1] do begin
           startx:= linepos + TraTabulatorItem(fitems[index]).xlineoffset;
          end;
         end
         else begin
          startx:= 0;
         end;
         if kind = tak_centered then begin
          endx:= nextx;
         end
         else begin
          endx:= linepos + xlineoffset;
         end;
        end;
       end;
      end;
      if akind = tlk_top then begin
       y:= - flineinfos[tlk_top].dist;
      end
      else begin
       y:= TraTabulators(fowner).fband.clientheight + 
                      flineinfos[tlk_bottom].dist;
      end;
      if isrendering then begin
        addlinetoreport(createlineinfo(acanvas,makepoint(startx,y),makepoint(endx,y),color));
      end else begin
       acanvas.drawline(makepoint(startx,y),makepoint(endx,y),color);
      end;
     end;
    end;
   end;
  end;
 end;
  
var
 int1,int2,int3,int4: integer;
 bo2: boolean;
 rstr1: richstringty;
 isdecimal: boolean;
 cellrect: rectty;
 arawfont: rawfontty;
begin
 fminsize:= nullsize;
 bandcx:= adest.cx;
 bo1:= false;
 if apaint then begin  
  with fband do begin
   cellrect:= adest;
   if not rendering or (fparentintf = nil) then begin 
    visiblemask:= [lv_TopOfPage,lv_NotTopOfPage,
                   lv_FirstOfPage,lv_Normal,lv_LastOfPage,
                   lv_FirstOfGroup,lv_LastOfGroup,
                   lv_FirstRecord,lv_LastRecord];
   end
   else begin
    visiblemask:= [lv_Normal];    
    with fparentintf do begin
     if istopband then begin
      include(visiblemask,lv_TopOfPage);
      exclude(visiblemask,lv_NotTopOfPage);
     end
     else begin
      include(visiblemask,lv_NotTopOfPage);
      exclude(visiblemask,lv_TopOfPage);
     end;
     if isfirstband then begin
      include(visiblemask,lv_FirstOfPage);
      exclude(visiblemask,lv_Normal);
     end;
     if islastband then begin
      include(visiblemask,lv_LastOfPage);
      exclude(visiblemask,lv_Normal);
     end;
     if fband.isfirstofgroup then begin
      include(visiblemask,lv_FirstOfGroup);
     end;
     if fband.islastofgroup then begin
      include(visiblemask,lv_LastOfGroup);
     end;
    end;
    if isfirstrecord then begin
     include(visiblemask,lv_FirstRecord);
     exclude(visiblemask,lv_Normal);
    end;
    if islastrecord then begin
     include(visiblemask,lv_LastRecord);
     exclude(visiblemask,lv_Normal);
    end;
   end;
  end;
 end;
 if count > 0 then begin
  checkuptodate;
  with finfo do begin
   for int1:= 0 to count - 1 do begin
    with ftabs[int1] do begin
     with TraTabulatorItem(fitems[index]) do begin
      text:= getdisptext;
      arawfont:= rawfont;
      if apaint and (foptions*[rto_Count,rto_Sum,rto_Average] <> []) and 
                        not (rto_NoReset in foptions) then begin
       fsum.resetpending:= true;
      end;
      finfo.font:= font;
      flags:= ftextflags;
      dest:= adest;
      if width <= 0 then begin
       case kind of
        tak_left: begin
         dest.cx:= adest.cx - textpos + width;
        end;
        else begin
         dest.cx:= adest.cx + width;
        end;
       end;
      end
      else begin
       dest.cx:= width;
      end;
      dest.x:= adest.x + textpos;
      if apaint and (fcolor <> cl_none) then begin
       cellrect.x:= adest.x + linepos;
       if int1 < high(ftabs) then begin
        cellrect.cx:= cellwidth;
       end
       else begin
        cellrect.cx:= adest.cx - linepos;
       end;
       if isrendering then begin
        addrecttoreport(createrectinfo(makerect(
         addpoint(acanvas.origin,cellrect.pos),cellrect.size),fcolor));
       end else begin
        acanvas.fillrect(cellrect,fcolor);
       end;
      end;
     end;
     isdecimal:= tabkind = tak_decimal;
     case tabkind of 
      tak_centered: begin
       flags:= (flags - [tf_right]) + [tf_xcentered];
       dec(dest.x,dest.cx div 2);
      end;
      tak_right,tak_decimal: begin   
       flags:= (flags - [tf_xcentered]) + [tf_right];
       dec(dest.x,dest.cx);
      end;
     end;
    end;
    if isdecimal then begin
     int2:= findlastchar(text.text,msechar(decimalseparator));
     if int2 > 0 then begin
      rstr1:= text;
      text:= richcopy(rstr1,1,int2-1);
      if apaint then begin
       if isrendering then begin
        addtexttoreport(createtextinfo(finfo,arawfont,addpoint(acanvas.origin,dest.pos)));
       end else begin
        drawtext(acanvas,finfo);
       end;
      end
      else begin
       textrect(acanvas,finfo);
      end;
      int3:= res.x;
      int4:= res.cx;
      text:= richcopy(rstr1,int2,bigint);
      inc(dest.x,dest.cx);
      exclude(flags,tf_right);
      if apaint then begin
       if isrendering then begin
        addtexttoreport(createtextinfo(finfo,arawfont,addpoint(acanvas.origin,dest.pos)));
       end else begin
        drawtext(acanvas,finfo);
       end;
      end
      else begin
       textrect(acanvas,finfo);
      end;
      res.x:= int3;
      res.cx:= res.cx + int4;
      text:= rstr1;
     end
     else begin
      if apaint then begin
       if isrendering then begin
        addtexttoreport(createtextinfo(finfo,arawfont,addpoint(acanvas.origin,dest.pos)));
       end else begin
        drawtext(acanvas,finfo);
       end;
      end
      else begin
       textrect(acanvas,finfo);
      end;
     end;
    end
    else begin            //not decimal
     if apaint then begin
      if isrendering then begin
       addtexttoreport(createtextinfo(finfo,arawfont,addpoint(acanvas.origin,dest.pos)));
      end else begin
       drawtext(acanvas,finfo);
      end;
     end
     else begin
      textrect(acanvas,finfo);
     end;
    end;
    int2:= res.x + res.cx;
    if int2 > fminsize.cx then begin
     fminsize.cx:= int2;
    end;
    if res.cy = 0 then begin
     res.cy:= font.lineheight;
    end;
    int2:= dest.y + res.cy;
    if int2 > fminsize.cy then begin
     fminsize.cy:= int2;
    end;
   end;
  end;
  if apaint then begin
   for int1:= 0 to count - 1 do begin
    with TraTabulatorItem(fitems[ftabs[int1].index]) do begin
     with flineinfos[tlk_vert] do begin
      if widthmm > 0 then begin
       if visible * visiblemask <> [] then begin
        checkinit(flineinfos[tlk_vert]);
        with ftabs[int1] do begin
         case kind of 
          tak_left: begin
           int2:= linepos - dist
          end
          else begin
           int2:= linepos + dist;
          end;
         end;
        end;
        if isrendering then begin
         addlinetoreport(createlineinfo(acanvas,makepoint(int2,fband.clientheight+LineBottom_Dist),
          makepoint(int2,-LineTop_Dist),color));
        end else begin
         acanvas.drawline(makepoint(int2,fband.clientheight+LineBottom_Dist),
          makepoint(int2,-LineTop_Dist),color);
        end;
       end;
      end;
     end;
    end;
    drawhorzline(int1,tlk_top);
    drawhorzline(int1,tlk_bottom);
   end;
  end;
 end;
 bo2:= bo1;
 acanvas.remove(makepoint(adest.x,0));
 if apaint then begin
  bandcx:= fband.clientwidth;
  with fLineLeft do begin
   if widthmm > 0 then begin
    if visible * visiblemask <> [] then begin
     checkinit(fLineLeft);
     if isrendering then begin
      addlinetoreport(createlineinfo(acanvas,makepoint(-dist,fband.clientheight+
       flineinfos[tlk_bottom].dist),makepoint(-dist,-flineinfos[tlk_top].dist),color));
     end else begin
      acanvas.drawline(makepoint(-dist,
            fband.clientheight+flineinfos[tlk_bottom].dist),
                          makepoint(-dist,-flineinfos[tlk_top].dist),color);
     end;
    end;
   end;
  end;
  with fLineRight do begin
   if widthmm > 0 then begin
    if visible * visiblemask <> [] then begin
     checkinit(fLineRight);
     if isrendering then begin
      addlinetoreport(createlineinfo(acanvas,makepoint(bandcx+dist,fband.clientheight+
        flineinfos[tlk_bottom].dist),makepoint(bandcx+dist,-flineinfos[tlk_top].dist),color));
     end else begin
      acanvas.drawline(makepoint(bandcx+dist,fband.clientheight+
        flineinfos[tlk_bottom].dist),makepoint(bandcx+dist,-flineinfos[tlk_top].dist),color);
     end;
    end;
   end;
  end;
  with flineinfos[tlk_top] do begin
   if widthmm > 0 then begin
    if visible * visiblemask <> [] then begin
     checkinit(flineinfos[tlk_top]);
     if isrendering then begin
      addlinetoreport(createlineinfo(acanvas,makepoint(-fLineLeft.dist,-dist),
        makepoint(bandcx+fLineRight.dist,-dist),color));
     end else begin
      acanvas.drawline(makepoint(-fLineLeft.dist,-dist),
        makepoint(bandcx+fLineRight.dist,-dist),color);
     end;
    end;
   end;
  end;
  with flineinfos[tlk_bottom] do begin
   if widthmm > 0 then begin
    if visible * visiblemask <> [] then begin
     checkinit(flineinfos[tlk_bottom]);
     int2:= fband.clientheight+dist;
     if isrendering then begin
      addlinetoreport(createlineinfo(acanvas,makepoint(-fLineLeft.dist,int2),
       makepoint(bandcx+fLineRight.dist,int2),color));
     end else begin
      acanvas.drawline(makepoint(-fLineLeft.dist,int2),
       makepoint(bandcx+fLineRight.dist,int2),color);
     end;
    end;
   end;
  end;
 end;
 if bo1 then begin
  acanvas.restore;
  if not bo2 then begin
   acanvas.move(makepoint(adest.x,0));
  end;
 end;
 fsizevalid:= true;
end;

procedure TraTabulators.paint(const acanvas: tcanvas; const adest: rectty;
  const isrendering:boolean);
begin
 processvalues(acanvas,adest,true,isrendering);
end;

procedure TraTabulators.checksize;
begin
 if not fsizevalid then begin
  processvalues(fband.getcanvas,fband.innerclientrect,false,false);
 end;
end;

procedure TraTabulators.setLineTop_Widthmm(const avalue: real);
begin
 if avalue <> flineinfos[tlk_top].widthmm then begin
  flineinfos[tlk_top].widthmm:= avalue;
  fband.invalidate;
 end;
end;

procedure TraTabulators.setLineTop_Color(const avalue: colorty);
begin
 if avalue <> flineinfos[tlk_top].color then begin
  flineinfos[tlk_top].color:= avalue;
  fband.invalidate;
 end;
end;

procedure TraTabulators.setLineTop_ColorGap(const avalue: colorty);
begin
 if avalue <> flineinfos[tlk_top].colorgap then begin
  flineinfos[tlk_top].colorgap:= avalue;
  fband.invalidate;
 end;
end;

procedure TraTabulators.setLineTop_CapStyle(const avalue: capstylety);
begin
 if avalue <> flineinfos[tlk_top].capstyle then begin
  flineinfos[tlk_top].capstyle:= avalue;
  fband.invalidate;
 end;
end;

procedure TraTabulators.setLineTop_Dashes(const avalue: string);
begin
 if avalue <> flineinfos[tlk_top].dashes then begin
  flineinfos[tlk_top].dashes:= checkdashes(avalue);
  fband.invalidate;
 end;
end;

procedure TraTabulators.setLineTop_Dist(const avalue: integer);
begin
 if avalue <> flineinfos[tlk_top].dist then begin
  flineinfos[tlk_top].dist:= avalue;
  fband.invalidate;
 end;
end;

procedure TraTabulators.setLineTop_visible(const avalue: linevisiblesty);
begin
 if avalue <> flineinfos[tlk_top].visible then begin
  flineinfos[tlk_top].visible:= avalue;
  fband.invalidate;
 end;
end;

procedure TraTabulators.setLineLeft_Widthmm(const avalue: real);
begin
 if avalue <> fLineLeft.widthmm then begin
  fLineLeft.widthmm:= avalue;
  fband.invalidate;
 end;
end;

procedure TraTabulators.setLineLeft_Color(const avalue: colorty);
begin
 if avalue <> fLineLeft.color then begin
  fLineLeft.color:= avalue;
  fband.invalidate;
 end;
end;

procedure TraTabulators.setLineLeft_ColorGap(const avalue: colorty);
begin
 if avalue <> fLineLeft.colorgap then begin
  fLineLeft.colorgap:= avalue;
  fband.invalidate;
 end;
end;

procedure TraTabulators.setLineLeft_CapStyle(const avalue: capstylety);
begin
 if avalue <> fLineLeft.capstyle then begin
  fLineLeft.capstyle:= avalue;
  fband.invalidate;
 end;
end;

procedure TraTabulators.setLineLeft_Dashes(const avalue: string);
begin
 if avalue <> fLineLeft.dashes then begin
  fLineLeft.dashes:= checkdashes(avalue);
  fband.invalidate;
 end;
end;

procedure TraTabulators.setLineLeft_Dist(const avalue: integer);
begin
 if avalue <> fLineLeft.dist then begin
  fLineLeft.dist:= avalue;
  fband.invalidate;
 end;
end;

procedure TraTabulators.setLineLeft_visible(const avalue: linevisiblesty);
begin
 if avalue <> fLineLeft.visible then begin
  fLineLeft.visible:= avalue;
  fband.invalidate;
 end;
end;

procedure TraTabulators.setLineVertical_Widthmm(const avalue: real);
var
 int1: integer;
begin
// if (avalue <> flineinfos[tlk_vert].widthmm) then begin
  flineinfos[tlk_vert].widthmm:= avalue;
  if not (csloading in fband.componentstate) then begin
   for int1:= 0 to high(fitems) do begin
    TraTabulatorItem(fitems[int1]).LineVertical_Widthmm:= avalue;
   end;
  end;
// end;
end;

procedure TraTabulators.setLineVertical_Color(const avalue: colorty);
var
 int1: integer;
begin
// if (avalue <> flineinfos[tlk_vert].color) then begin
  flineinfos[tlk_vert].color:= avalue;
  if not (csloading in fband.componentstate) then begin
   for int1:= 0 to high(fitems) do begin
    TraTabulatorItem(fitems[int1]).LineVertical_Color:= avalue;
   end;
  end;
// end;
end;

procedure TraTabulators.setLineVertical_ColorGap(const avalue: colorty);
var
 int1: integer;
begin
// if (avalue <> flineinfos[tlk_vert].colorgap) then begin
  flineinfos[tlk_vert].colorgap:= avalue;
  if not (csloading in fband.componentstate) then begin
   for int1:= 0 to high(fitems) do begin
    TraTabulatorItem(fitems[int1]).LineVertical_ColorGap:= avalue;
   end;
  end;
// end;
end;

procedure TraTabulators.setLineVertical_CapStyle(const avalue: capstylety);
var
 int1: integer;
begin
// if (avalue <> flineinfos[tlk_vert].capstyle) then begin
  flineinfos[tlk_vert].capstyle:= avalue;
  if not (csloading in fband.componentstate) then begin
   for int1:= 0 to high(fitems) do begin
    TraTabulatorItem(fitems[int1]).LineVertical_CapStyle:= avalue;
   end;
  end;
// end;
end;

procedure TraTabulators.setLineVertical_Dashes(const avalue: string);
var
 int1: integer;
begin
// if (avalue <> flineinfos[tlk_vert].dashes) then begin
  flineinfos[tlk_vert].dashes:= checkdashes(avalue);
  if not (csloading in fband.componentstate) then begin
   for int1:= 0 to high(fitems) do begin
    TraTabulatorItem(fitems[int1]).LineVertical_Dashes:= checkdashes(avalue);
   end;
  end;
// end;
end;

procedure TraTabulators.setLineVertical_Dist(const avalue: integer);
var
 int1: integer;
begin
// if (avalue <> flineinfos[tlk_vert].dist) then begin
  flineinfos[tlk_vert].dist:= avalue;
  if not (csloading in fband.componentstate) then begin
   for int1:= 0 to high(fitems) do begin
    TraTabulatorItem(fitems[int1]).LineVertical_Dist:= avalue;
   end;
  end;
// end;
end;

procedure TraTabulators.setLineVertical_visible(const avalue: linevisiblesty);
var
 int1: integer;
begin
// if (avalue <> flineinfos[tlk_vert].visible) and 
//              not (csloading in fband.componentstate) then begin
  flineinfos[tlk_vert].visible:= avalue;
  if not (csloading in fband.componentstate) then begin
   for int1:= 0 to high(fitems) do begin
    TraTabulatorItem(fitems[int1]).LineVertical_visible:= avalue;
   end;
  end;
// end;
end;

procedure TraTabulators.setdistleft(const avalue: real);
var
 int1: integer;
begin
// if avalue <> fdistleft then begin
  fdistleft:= avalue;
  if not (csloading in fband.componentstate) then begin
   for int1:= 0 to high(fitems) do begin
    TraTabulatorItem(fitems[int1]).distleft:= fdistleft;
   end;
  end;
// end;
end;

procedure TraTabulators.setdistright(const avalue: real);
var
 int1: integer;
begin
// if avalue <> fdistright then begin
  fdistright:= avalue;
  if not (csloading in fband.componentstate) then begin
   for int1:= 0 to high(fitems) do begin
    TraTabulatorItem(fitems[int1]).distright:= fdistright;
   end;
  end;
// end;
end;

procedure TraTabulators.setLineRight_Widthmm(const avalue: real);
begin
 if avalue <> fLineRight.widthmm then begin
  fLineRight.widthmm:= avalue;
  fband.invalidate;
 end;
end;

procedure TraTabulators.setLineRight_Color(const avalue: colorty);
begin
 if avalue <> fLineRight.color then begin
  fLineRight.color:= avalue;
  fband.invalidate;
 end;
end;

procedure TraTabulators.setLineRight_ColorGap(const avalue: colorty);
begin
 if avalue <> fLineRight.colorgap then begin
  fLineRight.colorgap:= avalue;
  fband.invalidate;
 end;
end;

procedure TraTabulators.setLineRight_CapStyle(const avalue: capstylety);
begin
 if avalue <> fLineRight.capstyle then begin
  fLineRight.capstyle:= avalue;
  fband.invalidate;
 end;
end;

procedure TraTabulators.setLineRight_Dashes(const avalue: string);
begin
 if avalue <> fLineRight.dashes then begin
  fLineRight.dashes:= checkdashes(avalue);
  fband.invalidate;
 end;
end;

procedure TraTabulators.setLineRight_Dist(const avalue: integer);
begin
 if avalue <> fLineRight.dist then begin
  fLineRight.dist:= avalue;
  fband.invalidate;
 end;
end;

procedure TraTabulators.setLineRight_visible(const avalue: linevisiblesty);
begin
 if avalue <> fLineRight.visible then begin
  fLineRight.visible:= avalue;
  fband.invalidate;
 end;
end;

procedure TraTabulators.setLineBottom_Widthmm(const avalue: real);
begin
 if avalue <> flineinfos[tlk_bottom].widthmm then begin
  flineinfos[tlk_bottom].widthmm:= avalue;
  fband.invalidate;
 end;
end;

procedure TraTabulators.setLineBottom_Color(const avalue: colorty);
begin
 if avalue <> flineinfos[tlk_bottom].color then begin
  flineinfos[tlk_bottom].color:= avalue;
  fband.invalidate;
 end;
end;

procedure TraTabulators.setLineBottom_ColorGap(const avalue: colorty);
begin
 if avalue <> flineinfos[tlk_bottom].colorgap then begin
  flineinfos[tlk_bottom].colorgap:= avalue;
  fband.invalidate;
 end;
end;

procedure TraTabulators.setLineBottom_CapStyle(const avalue: capstylety);
begin
 if avalue <> flineinfos[tlk_bottom].capstyle then begin
  flineinfos[tlk_bottom].capstyle:= avalue;
  fband.invalidate;
 end;
end;

procedure TraTabulators.setLineBottom_Dashes(const avalue: string);
begin
 if avalue <> flineinfos[tlk_bottom].dashes then begin
  flineinfos[tlk_bottom].dashes:= checkdashes(avalue);
  fband.invalidate;
 end;
end;

procedure TraTabulators.setLineBottom_Dist(const avalue: integer);
begin
 if avalue <> flineinfos[tlk_bottom].dist then begin
  flineinfos[tlk_bottom].dist:= avalue;
  fband.invalidate;
 end;
end;

procedure TraTabulators.setLineBottom_visible(const avalue: linevisiblesty);
begin
 if avalue <> flineinfos[tlk_bottom].visible then begin
  flineinfos[tlk_bottom].visible:= avalue;
  fband.invalidate;
 end;
end;

procedure TraTabulators.recchanged;
var
 int1: integer;
begin
 for int1:= 0 to high(fitems) do begin
  TraTabulatorItem(fitems[int1]).recchanged;
 end;
end;

procedure TraTabulators.setlinksource(const avalue: TraCustomRecordBand);
var
 band1: TraCustomRecordBand;
begin
 if avalue <> flinksource then begin
  band1:= avalue;
  while band1 <> nil do begin
   if band1 = fband then begin
    raise exception.create('Recursive linksource.');
   end;
   band1:= band1.ftabs.flinksource;
  end;
  fband.setlinkedvar(avalue,flinksource);
  sourcechanged;
 end;
end;

procedure TraTabulators.sourcechanged;
var
 int1: integer;
begin
 if (flinksource <> nil) and 
                   not (csloading in flinksource.componentstate) then begin
  beginupdate;
  try
   count:= flinksource.ftabs.count;
   for int1:= 0 to high(fitems) do begin
    with TraTabulatorItem(fitems[int1]) do begin
     pos:= TraTabulatorItem(flinksource.ftabs.fitems[int1]).pos;
    end;
   end;
  finally
   endupdate;
  end;
 end;
end;

procedure TraTabulators.dochange(const aindex: integer);
begin
 fsizevalid:= false;
 inherited;
// fband.sendchangeevent(oe_designchanged); 
end;

procedure TraTabulators.setcount1(acount: integer; doinit: boolean);
const
 step = 10;
var
 countbefore: integer;
 int1,int2: integer;
begin
 with fband do begin
  if (componentstate * [csdesigning,csloading] = [csdesigning]) and
              (acount > count) then begin
   countbefore:= count;
   checkuptodate;
   if countbefore > 0 then begin
    int2:= self.pos[countbefore-1] + step;
   end
   else begin
    int2:= 0;
   end;
   inherited;
   for int1:= countbefore to count - 1 do begin
    items[int1].pos:= int2;    
    inc(int2,step); //offset
   end;
  end
  else begin
   inherited;
  end;
 end;
end;

procedure TraTabulators.resetsums(const skipcurrent: boolean);
var
 int1: integer;
begin
 for int1:= 0 to high(fitems) do begin
  TraTabulatorItem(fitems[int1]).resetsum(skipcurrent);
 end;
end;

procedure TraTabulators.dobeforenextrecord(const adatasource: tdatasource);
var
 int1: integer;
begin
 for int1:= 0 to high(fitems) do begin
  TraTabulatorItem(fitems[int1]).dobeforenextrecord(adatasource);
 end;
end;

procedure TraTabulators.initsums;
var
 int1: integer;
begin
 for int1:= 0 to high(fitems) do begin
  TraTabulatorItem(fitems[int1]).initsum;
 end;
end;

procedure TraTabulators.scale(const ascale: real);
var
 int1: integer;
begin
 for int1:= 0 to high(fitems) do begin
  TraTabulatorItem(fitems[int1]).scale(ascale);
 end;
end;

procedure setbandoptionsshow(const avalue: bandoptionshowsty;
                                           var foptions: bandoptionshowsty);
const
 topmask: bandoptionshowsty = [bos_ShowTopOfPage,bos_HideTopOfPage];
 nottopmask: bandoptionshowsty = [bos_ShowNotTopOfPage,bos_HideNotTopOfPage];
 firstmask: bandoptionshowsty = [bos_ShowFirstPage,bos_HideFirstPage];
 normalmask: bandoptionshowsty = [bos_ShowNormalPage,bos_HideNormalPage];
 evenmask: bandoptionshowsty = [bos_ShowEvenPage,bos_HideEvenPage];
 oddmask: bandoptionshowsty = [bos_ShowOddPage,bos_HideOddPage];
 firstofpagemask: bandoptionshowsty = [bos_ShowFirstOfPage,bos_HideFirstOfPage];
 normalofpagemask: bandoptionshowsty = [bos_ShowNormalOfPage,bos_HideNormalOfPage];
 lastofpagemask: bandoptionshowsty = [bos_ShowLastOfPage,bos_HideLastOfPage];
 firstrecmask: bandoptionshowsty = [bos_ShowFirstRecord,bos_HideFirstRecord];
 normalrecmask: bandoptionshowsty = [bos_ShowNormalRecord,bos_HideNormalRecord];
 lastrecmask: bandoptionshowsty = [bos_ShowLastRecord,bos_HideLastRecord];
var
 vis1: bandoptionshowsty;
begin
 vis1:= bandoptionshowsty(setsinglebit(longword(avalue),longword(foptions),
                                 longword(topmask)));
 vis1:= bandoptionshowsty(setsinglebit(longword(avalue),longword(foptions),
                                 longword(nottopmask)));
 vis1:= bandoptionshowsty(setsinglebit(longword(avalue),longword(foptions),
                                 longword(firstmask)));
 vis1:= bandoptionshowsty(setsinglebit(longword(vis1),longword(foptions),
                                 longword(normalmask)));
 vis1:= bandoptionshowsty(setsinglebit(longword(vis1),longword(foptions),
                                 longword(evenmask)));
 vis1:= bandoptionshowsty(setsinglebit(longword(vis1),longword(foptions),
                                 longword(oddmask)));
 vis1:= bandoptionshowsty(setsinglebit(longword(vis1),longword(foptions),
                                 longword(firstofpagemask)));
 vis1:= bandoptionshowsty(setsinglebit(longword(vis1),longword(foptions),
                                 longword(normalofpagemask)));
 vis1:= bandoptionshowsty(setsinglebit(longword(vis1),
                                 longword(foptions),longword(lastofpagemask)));
 vis1:= bandoptionshowsty(setsinglebit(longword(vis1),longword(foptions),
                                 longword(firstrecmask)));
 vis1:= bandoptionshowsty(setsinglebit(longword(vis1),longword(foptions),
                                 longword(normalrecmask)));
 foptions:= bandoptionshowsty(setsinglebit(longword(vis1),longword(foptions),
                                 longword(lastrecmask)));
end;

function checkvisibility(const fparentintf: ibandparent;
                 const foptions: bandoptionshowsty; checklast: boolean;
                 var aresult: boolean; out show: boolean): boolean;
                  //true if more checks possible
label
 endlab;
var
 topofpage,firstofpage,lastofpage: boolean;
 even1,first1: boolean;
begin
 result:= false;
 show:= false;
 if foptions * visibilitymask <> [] then begin
  if fparentintf <> nil then begin
   first1:= fparentintf.pagepagenum = 0;
   if first1 and (bos_HideFirstPage in foptions) then begin
    aresult:= false;
    goto endlab;
   end;
   if first1 and (bos_ShowFirstPage in foptions) then begin
    aresult:= true;
    goto endlab;
   end;
   if not first1 and (bos_HideNormalPage in foptions) then begin
    aresult:= false;
    goto endlab;
   end;
   if not first1 and (bos_ShowNormalPage in foptions) then begin
    aresult:= true;
    goto endlab;
   end;

   even1:= not odd(fparentintf.reppagenum);
   if even1 and (bos_HideEvenPage in foptions) then begin
    aresult:= false;
    goto endlab;
   end;
   if not even1 and (bos_HideOddPage in foptions) then begin
    aresult:= false;
    goto endlab;
   end;
   show:= even1 and (bos_ShowEvenPage in foptions);
   show:= show or not even1 and (bos_ShowOddPage in foptions);

   topofpage:= fparentintf.istopband;
   firstofpage:= fparentintf.isfirstband;
   lastofpage:= checklast and fparentintf.islastband;
   if topofpage then begin
    if bos_ShowTopOfPage in foptions then begin
     aresult:= true;
     goto endlab;
    end
    else begin
     if bos_HideTopOfPage in foptions then begin
      aresult:= false;
     end;
    end;
   end
   else begin
    if bos_ShowNotTopOfPage in foptions then begin
     aresult:= true;
     goto endlab;
    end
    else begin
     if bos_HideNotTopOfPage in foptions then begin
      aresult:= false;
     end;
    end;
   end;
   if firstofpage then begin
    if bos_ShowFirstOfPage in foptions then begin
     aresult:= true;
     goto endlab;
    end
    else begin
     if bos_HideFirstOfPage in foptions then begin
      aresult:= false;
     end;
    end;
   end;
   if lastofpage then begin
    if bos_ShowLastOfPage in foptions then begin
     aresult:= true;
     goto endlab;
    end
    else begin
     if bos_HideLastOfPage in foptions then begin
      aresult:= false;
      show:= false;
     end;
    end;
   end;
   if not firstofpage and not lastofpage then begin
    if bos_ShowNormalOfPage in foptions then begin
     aresult:= true;
     goto endlab;
    end
    else begin
     if bos_HideNormalOfPage in foptions then begin
      aresult:= false;
      show:= false;
     end;
    end;
   end;   
  end;
 end;
 result:= true;
endlab:
end;
 
procedure updateparentintf(const sender: ireportclient;
                                 var fparentintf: ibandparent);
var
 widget1: twidget;
begin
 with twidget1(sender.getwidget) do begin
  if fparentwidget <> nil then begin
   if fparentintf <> nil then begin
    fparentintf.unregisterclient(sender);
   end;
   widget1:= fparentwidget;
   while (widget1 <> nil) and 
     not widget1.getcorbainterface(typeinfo(ibandparent),fparentintf) do begin
    widget1:= widget1.parentwidget;
   end; 
   if fparentintf <> nil then begin
    fparentintf.registerclient(sender);
   end;
  end
  else begin
   if fparentintf <> nil then begin
    fparentintf.unregisterclient(sender);
   end;
   fparentintf:= nil;
  end;
 end;
end;

{ TraSpacer }

procedure TraSpacer.updatevisibility;
var
 bo1,bo2: boolean;
begin
 bo1:= visible;
 checkvisibility(fparentintf,foptionsrep,true,bo1,bo2);
 visible:= bo1 or bo2;
end;

procedure TraSpacer.setoptionsrep(const avalue: bandoptionshowsty);
const
 spacerbandoptions =  [
                 bos_ShowTopOfPage,bos_HideTopOfPage,
                 bos_ShowNotTopOfPage,bos_HideNotTopOfPage,
                 bos_ShowFirstPage,bos_HideFirstPage,
                 bos_ShowNormalPage,bos_HideNormalPage,
                 bos_ShowEvenPage,bos_HideEvenPage,
                 bos_ShowOddPage,bos_HideOddPage,
                 bos_ShowFirstOfPage,bos_HideFirstOfPage,
                 bos_ShowNormalOfPage,bos_HideNormalOfPage,                 
                 bos_ShowLastOfPage,bos_HideLastOfPage
 //                bo_showfirstrecord,bo_hidefirstrecord, 
 //                bo_shownormalrecord,bo_hidenormalrecord,
 //                bo_showlastrecord,bo_hidelastrecord,
            //todo: check first-last record
 //                bo_LocalValue
                 ];
                 

begin
 setbandoptionsshow(avalue * spacerbandoptions,foptionsrep);
end;

procedure TraSpacer.parentchanged;
begin
 updateparentintf(ireportclient(self),fparentintf);
 inherited;
end;

procedure TraSpacer.beginrender(const arestart: boolean);
begin
 include(fwidgetstate1,ws1_noclipchildren);
end;

procedure TraSpacer.endrender;
begin
 exclude(fwidgetstate1,ws1_noclipchildren);
end;

procedure TraSpacer.adddatasets(var adatasets: datasetarty);
begin
 //dummy
end;

procedure TraSpacer.init;
begin
 //dummy
end;

procedure TraSpacer.resetzebra;
begin
 //dummy
end;

{ TraCustomRecordBand }

constructor TraCustomRecordBand.create(aowner: tcomponent);
begin
 inherited;
 ftabs:= TraTabulators.create(self);
 fdatalink:= TraRecordBandDataLink.create;
 fvisidatalink:= tfielddatalink.create;
 fvisigrouplink:= tfielddatalink.create;
 fZebra_Step:= 2;
 fZebra_Color:= cl_infobackground;
 fanchors:= defaultbandanchors;
 foptionswidget:= defaultbandoptionswidget;
 frawfont:= rfNormal;
end;

destructor TraCustomRecordBand.destroy;
begin
 fobjectpicker.free;
 ftabs.free;
 fdatalink.free;
 fvisidatalink.free;
 fvisigrouplink.free;
 inherited;
end;

procedure TraCustomRecordBand.loaded;
begin
 inherited;
 if (csdesigning in componentstate) and (fobjectpicker = nil) then begin
  fobjectpicker:= tobjectpicker.create(iobjectpicker(self));
 end;
end;

procedure TraCustomRecordBand.parentchanged;
begin
 updateparentintf(ireportclient(self),fparentintf);
 inherited;
end;

procedure TraCustomRecordBand.dobeforerender(var empty: boolean);
begin
 if fdatalink.active then begin
  empty:= (rbs_finish in fstate) or fdatalink.dataset.eof;
 end;
 if not empty and visible and (bo_TopOfArea in foptions) and 
         (fparentintf <> nil) and not fparentintf.isfirstband  then begin
  fparentintf.setareafull(true);
 end;
end;

procedure TraCustomRecordBand.doonpaint(const acanvas: tcanvas);
begin
 //
end;

function TraCustomRecordBand.actualcolor: colorty;
var
 bo1: boolean;
 int1: integer;
begin
 bo1:= false;
 if (rbs_rendering in fstate) and (fZebra_Height > 0) and (fZebra_Step > 0) then begin
  int1:= (fZebra_Counter - fZebra_Start) mod fZebra_Step;
  if int1 < 0 then begin
   if int1  < fZebra_Height - fZebra_Step then begin
    bo1:= true;
   end;
  end
  else begin
   if int1 < fZebra_Height then begin
    bo1:= true;
   end;
  end;
 end;
 if bo1 then begin
  result:= fZebra_Color;
 end
 else begin
  result:= inherited actualcolor;
 end;
end;

procedure TraCustomRecordBand.render(const acanvas: tcanvas; var empty: boolean);
var
 int1: integer;
 ainfo: reprectinfoty;
begin
 application.checkoverload;
 fparentintf.updatevisible; //??
 include(fstate,rbs_visibilitychecked);
 empty:= empty or (rbs_finish in fstate);
 dobeforerender(empty);
 if not empty then begin
  if not (rbs_visibilitychecked in fstate) then begin
   fparentintf.updatevisible;
  end;
  if visible then begin
   if fparentintf.beginband(acanvas,self) then begin
    exit; //area full
   end;
   try
    for int1:= 0 to high(fareas) do begin
     fareas[int1].initband;
    end;
    inheritedpaint(acanvas);
   finally
    fparentintf.endband(acanvas,self);
   end;
  end;
  nextrecord;
 end;
end;

procedure TraCustomRecordBand.init;
var
 int1: integer;
begin
 exclude(fstate,rbs_finish);
 if fvisigrouplink.fieldactive then begin
  if fvisigrouplink.isstringfield then begin
   fgroupstring:= fvisigrouplink.asmsestring;
  end
  else begin
   fgroupnum:= fvisigrouplink.aslargeint;
  end;
//  fnextgroupnum:= fgroupnum; set by beginrender
 end;
 for int1:= 0 to high(fareas) do begin
  fareas[int1].init;
 end;
end;

procedure TraCustomRecordBand.initpage;
var
 int1: integer;
begin
 if (zo_ResetOnPageStart in fZebra_Options) then begin
  fZebra_Counter:= 0;
 end;
 exclude(fstate,rbs_pageshowed);
 for int1:= 0 to high(fareas) do begin
  fareas[int1].initpage;
 end;
end;

function TraCustomRecordBand.rendering: boolean;
begin
 result:= rbs_rendering in fstate;
end;

function TraCustomRecordBand.bandheight: integer;
begin
 result:= bounds_cy;
end;

procedure TraCustomRecordBand.inheritedpaint(const acanvas: tcanvas);
var
 ainfo: reprectinfoty;
begin
 inherited paint(acanvas);
 if actualcolor<>cl_transparent then begin
  ainfo.rectarea:= makerect(addpoint(acanvas.origin,clientpos),fwidgetrect.size);
  ainfo.color:= actualcolor;
  addrecttoreport(ainfo);
 end;
 inc(fZebra_Counter);
 if (zo_ResetParent in fZebra_Options) and (fparentintf <> nil) then begin
  fparentintf.resetzebra;
 end;
end;

procedure TraCustomRecordBand.paint(const canvas: tcanvas);
begin
 if not rendering then begin
  inherited;
 end;
end;

procedure TraCustomRecordBand.beginrender(const arestart: boolean);
var
 int1: integer;
begin
 ftabs.initsums;
 fZebra_Counter:= 0;
 if arestart then begin
  fstate:= (fstate * [rbs_pageshowed]) + [rbs_rendering]
 end
 else begin
  fstate:= [rbs_rendering];
 end;
 include(fwidgetstate1,ws1_noclipchildren);
 if fdatalink.active then begin
  application.lock;
  try
   fdatalink.dataset.first;
   if checkislastrecord(fdatalink,@dosyncnextrecord) then begin
    include(fstate,rbs_lastrecord);
   end;
   recchanged;
  finally
   application.unlock;
  end;
 end; 
 for int1:= 0 to high(fareas) do begin
  fareas[int1].beginrender(arestart);
 end;
end;

procedure TraCustomRecordBand.restart;
begin
 beginrender(true);
end;

procedure TraCustomRecordBand.resetzebra;
var
 int1: integer;
begin
 fZebra_Counter:= 0;
 for int1:= 0 to high(fareas) do begin
  fareas[int1].resetzebra;
 end;
end;

function TraCustomRecordBand.expressiondialog(const aexpression: msestring): msestring;   
var
 dialog: trepazevaldialog;
begin
 try
  dialog:= trepazevaldialog.create(nil);
  dialog.evaluator:= getevaluator;
  dialog.expression:= aexpression;
  if dialog.execute then begin
   result:= dialog.expression;
  end;
 finally
  dialog.free;
 end;
end;

procedure TraCustomRecordBand.endrender;
var
 int1: integer;
begin
 for int1:= 0 to high(fareas) do begin
  fareas[int1].endrender;
 end;
 exclude(fstate,rbs_rendering);
 exclude(fwidgetstate1,ws1_noclipchildren);
end;

procedure TraCustomRecordBand.adddatasets(var adatasets: datasetarty);
var
 int1: integer;
begin
 for int1:= 0 to high(fareas) do begin
  fareas[int1].adddatasets(adatasets);
 end;
 if fdatalink.dataset <> nil then begin
  adduniqueitem(pointerarty(adatasets),fdatalink.dataset);
 end;
end;

procedure TraCustomRecordBand.settabs(const avalue: TraTabulators);
begin
 ftabs.assign(avalue);
end;

procedure TraCustomRecordBand.setoptionsscale(const avalue: optionsscalety);
begin
 if foptionsscale <> avalue then begin
  foptionsscale:= avalue;
  updateoptionsscale;
 end;
end;

procedure TraCustomRecordBand.updateoptionsscale;
var
 size1,size2: sizety;
 rect1: rectty;
 bo1: boolean;
 box,boy: boolean;
begin
 if foptionsscale * [osc_expandx,osc_expandy,
                    osc_shrinkx,osc_shrinky,
                    osc_invisishrinkx,osc_invisishrinky] <> [] then begin
  if (componentstate * [csloading,csdestroying] = []) then begin
   if fscaling <> 0 then begin    
    include(fwidgetstate1,ws1_scaled);
   end
   else begin
    inc(fscaling);
    try
     exclude(fwidgetstate1,ws1_scaled);
     size1:= calcminscrollsize;
     bo1:= not isvisible;
     size2:= paintsize;
     box:= false;
     boy:= false;
//     bo1:= not (visible or (csdesigning in componentstate));
     if (osc_invisishrinkx in foptionsscale) then begin
      if bo1 then begin
       if fsizebefore.cx = 0 then begin
        fsizebefore.cx:= size2.cx;
       end;
       size1.cx:= paintsize.cx-bounds_cx;
      end
      else begin
       if fsizebefore.cx <> 0 then begin
        if foptionsscale * [osc_shrinkx,osc_expandx] <> 
                                         [osc_shrinkx,osc_expandx] then begin
         size1.cx:= fsizebefore.cx;
        end;
        fsizebefore.cx:= 0;
        box:= true;
       end;
      end;
     end;
     if (osc_invisishrinky in foptionsscale) then begin
      if bo1 then begin
       if fsizebefore.cy = 0 then begin
        fsizebefore.cy:= size2.cy;
       end;
       size1.cy:= paintsize.cy-bounds_cy;
      end
      else begin
       if fsizebefore.cy <> 0 then begin
        if foptionsscale * [osc_shrinky,osc_expandy] <> 
                                         [osc_shrinky,osc_expandy] then begin
         size1.cy:= fsizebefore.cy;
        end;
        fsizebefore.cy:= 0;
        boy:= true;
       end;
      end;
     end;
     rect1.cx:= size1.cx - size2.cx;
     rect1.cy:= size1.cy - size2.cy;
     if not (bo1 and (osc_invisishrinkx in foptionsscale)) then begin
      if not (osc_expandx in foptionsscale) and not box then begin
       if rect1.cx > 0 then begin
        rect1.cx:= 0;
       end;
      end;
      if not (osc_shrinkx in foptionsscale) then begin
       if rect1.cx < 0 then begin
        rect1.cx:= 0;
       end;
      end;
     end;
     if not (bo1 and (osc_invisishrinky in foptionsscale)) then begin
      if not (osc_expandy in foptionsscale) and not boy then begin
       if rect1.cy > 0 then begin
        rect1.cy:= 0;
       end;
      end;
      if not (osc_shrinky in foptionsscale) then begin
       if rect1.cy < 0 then begin
        rect1.cy:= 0;
       end;
      end;
     end;
     rect1.pos:= fwidgetrect.pos;
     if an_right in fanchors then begin
      dec(rect1.x,rect1.cx);
     end;
     if an_bottom in fanchors then begin
      dec(rect1.y,rect1.cy);
     end;
     addsize1(rect1.size,fwidgetrect.size);
     internalsetwidgetrect(rect1,false);
     if bo1 then begin
      parentwidgetregionchanged(self);
     end;
    finally
     dec(fscaling)
    end;
   end;
  end;
 end;
end;

procedure TraCustomRecordBand.beginscaling;
begin
 if fscaling = 0 then begin
  exclude(fwidgetstate1,ws1_scaled);
 end;
 inc(fscaling);
end;

procedure TraCustomRecordBand.endscaling;
begin
 dec(fscaling);
 if (fscaling = 0) and (ws1_scaled in fwidgetstate1) then begin
  updateoptionsscale;
 end;
end;

procedure TraCustomRecordBand.dobeforenextrecord(const adatasource: tdatasource);
begin
 ftabs.dobeforenextrecord(adatasource);
 if fvisigrouplink.fieldactive then begin
  if fvisigrouplink.isstringfield then begin
   fgroupstring:= fvisigrouplink.asmsestring;
  end
  else begin
   fgroupnum:= fvisigrouplink.field.aslargeint;
  end;
 end;
end;

procedure TraCustomRecordBand.dosyncnextrecord;
begin
 if fvisigrouplink.fieldactive then begin
  if fvisigrouplink.isstringfield then begin
   fnextgroupstring:= fvisigrouplink.asmsestring;
  end
  else begin
   fnextgroupnum:= fvisigrouplink.field.aslargeint;
  end;
 end;
end;

procedure TraCustomRecordBand.nextrecord(const setflag: boolean = true);
begin
 application.lock;
 try
  if setflag then begin
   include(fstate,rbs_notfirstrecord);
   dobeforenextrecord(fdatalink.DataSource);
  end;
  if fdatalink.active then begin
   fdatalink.dataset.next;
   if setflag then begin
    if checkislastrecord(fdatalink,@dosyncnextrecord) then begin
     include(fstate,rbs_lastrecord);
    end; 
    fparentintf.getreppage.recordchanged;
   end;
  end;
 finally
  application.unlock;
 end;
end;

procedure TraCustomRecordBand.doafterpaint(const acanvas: tcanvas);
var
 ar1: segmentarty;
 ar2: tabulatorarty;
 int1,int2: integer;
begin
 inherited;
 if (rbs_rendering in fstate) then begin
  //
 end;
 if csdesigning in componentstate then begin
  ar2:= ftabs.tabs;
  setlength(ar1,length(ar2));
  int2:= innerclientwidgetpos.x;
  for int1:= 0 to high(ar1) do begin
   with ar1[int1] do begin
    a.x:= ar2[int1].linepos+int2;
    a.y:= 0;
    b.x:= a.x;
    b.y:= fwidgetrect.cy;
   end;
  end;
  acanvas.dashes:= #2#2;
  acanvas.drawlinesegments(ar1,cl_red);
  acanvas.dashes:= '';
 end;
end;

procedure TraCustomRecordBand.dopaint(const acanvas: tcanvas);
begin
 inherited;
 if (rbs_rendering in fstate) then begin
  ftabs.paint(acanvas,innerclientrect,true);
 end else begin
  ftabs.paint(acanvas,innerclientrect,false);
 end;
end;

function TraCustomRecordBand.getminbandsize: sizety;
begin
 ftabs.checksize;
 result:= ftabs.fminsize;
end;

function TraCustomRecordBand.calcminscrollsize: sizety;
var
 size1: sizety;
begin
 result:= inherited calcminscrollsize;
 size1:= getminbandsize;
 if fframe <> nil then begin
  addsize1(size1,tcustomframe1(fframe).fi.innerframe.bottomright);
 end;
 with size1 do begin
  if cx > result.cx then begin
   result.cx:= cx;
  end;
  if cy > result.cy then begin
   result.cy:= cy
  end;
 end;
end;

procedure TraCustomRecordBand.minclientsizechanged;
begin
 if (fupdating <= 0) and not (csloading in componentstate) then begin
  clientrectchanged;
 end;
end;

procedure TraCustomRecordBand.fontchanged;
begin
 ftabs.fsizevalid:= false;
 inherited;
 minclientsizechanged;
end;

procedure TraCustomRecordBand.beginupdate;
begin
 inc(fupdating);
end;

procedure TraCustomRecordBand.endupdate;
begin
 dec(fupdating);
 if fupdating = 0 then begin
  clientrectchanged;
 end;
end;

procedure TraCustomRecordBand.setdatasource(const avalue: string);
var
 int1: integer;
 tmpdatasource: tdatasource;
begin
 tmpdatasource:= getdatasourcereport(avalue);
 fdatalink.DataSource:= tmpdatasource;
 if (componentstate*[csdesigning,csloading] = [csdesigning]) and 
                           (avalue <> '') then begin
  for int1:= 0 to ftabs.count - 1 do begin
   ftabs[int1].DataSource:= avalue;
  end;
 end;
end;

function TraCustomRecordBand.getdatasource: string;
begin
 if fdatalink.DataSource=nil then begin
  result:='';
 end else begin
  result:= fdatalink.DataSource.name;
 end;
end;

procedure TraCustomRecordBand.setoptionsshow(const avalue: bandoptionshowsty);
begin
 setbandoptionsshow(avalue,foptionsshow);
end;

procedure TraCustomRecordBand.synctofontheight;
begin
 syncsinglelinefontheight(true);
end;

function TraCustomRecordBand.isfirstrecord: boolean;
begin
 if fdatalink.active then begin
  result:= not (rbs_notfirstrecord in fstate);
 end
 else begin
  if fparentintf <> nil then begin
   result:= fparentintf.isfirstrecord;
  end
  else begin
   result:= false;
  end;
 end;
end;

function TraCustomRecordBand.islastrecord: boolean;
begin
 if fdatalink.active then begin
  result:= rbs_lastrecord in fstate;
 end
 else begin
  if fparentintf <> nil then begin
   result:= fparentintf.islastrecord;
  end
  else begin
   result:= false;
  end;
 end;
end;

function TraCustomRecordBand.isfirstofgroup: boolean;
begin
 if fvisigrouplink.isstringfield then begin
  result:= fvisigrouplink.fieldactive and (isfirstrecord or 
                   (fvisigrouplink.asmsestring <> fgroupstring));
 end
 else begin
  result:= fvisigrouplink.fieldactive and (isfirstrecord or 
                   (fvisigrouplink.field.aslargeint <> fgroupnum));
 end;
end;

function TraCustomRecordBand.islastofgroup: boolean;
begin
 if fvisigrouplink.isstringfield then begin
  result:= fvisigrouplink.fieldactive and (islastrecord or 
                   (fvisigrouplink.asmsestring <> fnextgroupstring));
 end
 else begin
  result:= fvisigrouplink.fieldactive and (islastrecord or 
                   (fvisigrouplink.field.aslargeint <> fnextgroupnum));
 end;
end;

function TraCustomRecordBand.bandisvisible(const checklast: boolean): boolean;
label
 endlab;
var
 firstrecord,lastrecord: boolean;
 bo1: boolean;
begin
 result:= visible;
 firstrecord:= isfirstrecord;
 lastrecord:= islastrecord;
 if fvisigrouplink.fieldactive then begin
  if fvisigrouplink.isstringfield then begin
   if (bo_VisiGroupFirst in foptions) and (firstrecord or 
                   (fvisigrouplink.asmsestring <> fgroupstring)) or
          (bo_VisiGroupLast in foptions) and (lastrecord or 
                   (fvisigrouplink.asmsestring <> fnextgroupstring)) or 
          (bo_VisiGroupNotFirst in foptions) and not (firstrecord or 
                   (fvisigrouplink.asmsestring <> fgroupstring)) or
          (bo_VisiGroupNotLast in foptions) and not(lastrecord or 
                   (fvisigrouplink.asmsestring <> fnextgroupstring)) then begin
    result:= true;
   end
   else begin
    result:= false;
   end;
  end
  else begin
   if (bo_VisiGroupFirst in foptions) and (firstrecord or 
                   (fvisigrouplink.field.aslargeint <> fgroupnum)) or
          (bo_VisiGroupLast in foptions) and (lastrecord or 
                   (fvisigrouplink.field.aslargeint <> fnextgroupnum)) or 
          (bo_VisiGroupNotFirst in foptions) and not (firstrecord or 
                   (fvisigrouplink.field.aslargeint <> fgroupnum)) or
          (bo_VisiGroupNotLast in foptions) and not(lastrecord or 
                   (fvisigrouplink.field.aslargeint <> fnextgroupnum)) then begin
    result:= true;
   end
   else begin
    result:= false;
   end;
  end;
 end; 
 if fvisidatalink.fieldactive then begin
  if fvisidatalink.field.isnull then begin
   result:= false;
  end
  else begin
   result:= true;
  end;
 end;
 if checkvisibility(fparentintf,foptionsshow,checklast,result,bo1) then begin
  if firstrecord then begin
   if bos_ShowFirstRecord in foptionsshow then begin
    result:= true;
    goto endlab;
   end
   else begin
    if bos_HideFirstRecord in foptionsshow then begin
     result:= false;
     bo1:= false;
    end;
   end;
  end;
  if lastrecord then begin
   if bos_ShowLastRecord in foptionsshow then begin
    result:= true;
    goto endlab;
   end
   else begin
    if bos_HideLastRecord in foptionsshow then begin
     result:= false;
     bo1:= false;
    end;
   end;
  end;
  if not firstrecord and not lastrecord then begin
   if bos_ShowNormalRecord in foptionsshow then begin
    result:= true;
    goto endlab;
   end
   else begin
    if bos_HideNormalRecord in foptionsshow then begin
     result:= false;
     bo1:= false;
    end;
   end;
  end;
  if bo1 then begin
   result:= true;
  end;
 end;
 endlab:
end;

function TraCustomRecordBand.getvisibility: boolean;
begin
 result:= bandisvisible(true);
end;

procedure TraCustomRecordBand.updatevisibility;
var
 int1: integer;
begin
 visible:= getvisibility;
 beginscaling;
 for int1:= 0 to high(frecbands) do begin
  with frecbands[int1] do begin
   updatevisibility;
  end;
 end;
 endscaling;
end;

function TraCustomRecordBand.lastbandheight: integer;
begin
 result:= bounds_cy;
end;

function TraCustomRecordBand.remainingbands: integer;
var
 widget1,widget2,widget3: twidget;
 int2: integer;
begin
 result:= 0;
 if fparentintf <> nil then begin
  widget3:= fparentintf.getwidget;
  widget1:= self;
  repeat
   widget2:= widget1;
   widget1:= widget1.parentwidget;
  until (widget1 = widget3);
  if widget2 is TraCustomRecordBand then begin
   with TraCustomRecordBand(widget2) do begin
    int2:= fparentintf.remainingheight - lastbandheight;
    if int2 >= 0 then begin
     if bounds_cy <= 0 then begin
      result:= bigint;
     end
     else begin
      result:= 1 + int2 div bounds_cy;
     end;
    end;
   end;
  end;
 end;
end;

function TraCustomRecordBand.reppage: TraReportPage;
begin
 if fparentintf <> nil then  begin
  result:= fparentintf.getreppage;
 end
 else begin
  result:= nil;
 end;
end;

procedure TraCustomRecordBand.finish;
begin
 include(fstate,rbs_finish);
end;

function TraCustomRecordBand.getvisidatasource: string;
begin
 if fvisidatalink.DataSource=nil then begin
  result:= '';
 end else begin
  result:= fvisidatalink.DataSource.name;
 end;
end;

procedure TraCustomRecordBand.setvisidatasource(const avalue: string);
var
 tmpdatasource: tdatasource;
begin
 tmpdatasource:= getdatasourcereport(avalue);
 fvisidatalink.DataSource:= tmpdatasource;
 fvisigrouplink.DataSource:= tmpdatasource;
end;

function TraCustomRecordBand.getvisidatafield: string;
begin
 result:= fvisidatalink.fieldname;
end;

procedure TraCustomRecordBand.setvisidatafield(const avalue: string);
begin
 fvisidatalink.fieldname:= avalue;
end;

function TraCustomRecordBand.getdatasource(const aindex: integer): tdatasource;
begin
 result:= fvisidatalink.DataSource;
end;

procedure TraCustomRecordBand.getfieldtypes(out apropertynames: stringarty;
               out afieldtypes: fieldtypesarty);
begin
 setlength(apropertynames,2);
 apropertynames[0]:= 'VisiDataField';
 apropertynames[1]:= 'VisiGroupField';
 setlength(afieldtypes,2);
 afieldtypes[0]:= [];
 afieldtypes[1]:= [ftinteger,ftlargeint,ftsmallint,
                     ftword,ftboolean] + textfields;
end;

function TraCustomRecordBand.getvisigroupfield: string;
begin
 result:= fvisigrouplink.fieldname;
end;

procedure TraCustomRecordBand.setvisigroupfield(const avalue: string);
begin
 fvisigrouplink.fieldname:= avalue;
end;

procedure TraCustomRecordBand.recchanged;
begin
 fdatalink.recordchanged(nil);
 ftabs.recchanged;
end;

function TraCustomRecordBand.getcursorshape(const apos: pointty;
               const ashiftstate: shiftstatesty;
               var ashape: cursorshapety): boolean;
var
 ar1: integerarty;
begin
 getpickobjects(makerect(apos,nullsize),ashiftstate,ar1);
 result:= ar1 <> nil;
 if result then begin
  ashape:= cr_sizehor;
 end;
end;

procedure TraCustomRecordBand.getpickobjects(const arect: rectty;
               const ashiftstate: shiftstatesty; var aobjects: integerarty);
var
 int1,int2,int3: integer;
begin
 if fframe <> nil then begin
  int3:= arect.x - frame.framei_left;
 end
 else begin
  int3:= arect.x;
 end;
 for int1:= 0 to ftabs.count - 1 do begin
  int2:= abs(int3 - ftabs.linepos[int1]);
  if int2 < tabpickthreshold then begin
   setlength(aobjects,1);
   aobjects[0]:= int1;
   break;
  end;
 end;
end;

procedure TraCustomRecordBand.beginpickmove(const aobjects: integerarty);
begin
end;

procedure TraCustomRecordBand.endpickmove(const apos: pointty;
               const aoffset: pointty; const aobjects: integerarty);
begin
 ftabs.linepos[aobjects[0]]:= ftabs.linepos[aobjects[0]] + aoffset.x;
 designchanged;
end;

procedure TraCustomRecordBand.paintxorpic(const acanvas: tcanvas;
               const apos: pointty; const aoffset: pointty;
               const aobjects: integerarty);
begin
 acanvas.fillxorrect(makerect(aoffset.x+ftabs.linepos[aobjects[0]],0,
                               1,clientheight));
end;

procedure TraCustomRecordBand.clientmouseevent(var info: mouseeventinfoty);
begin
 if fobjectpicker <> nil then begin
  fobjectpicker.mouseevent(info);
 end;
 inherited;
end;

procedure TraCustomRecordBand.objectevent(const sender: tobject;
               const event: objecteventty);
begin
 inherited;
 if (event = oe_designchanged) and (sender = ftabs.flinksource) then begin
  ftabs.sourcechanged;
//  designchanged;
 end;
end;

procedure TraCustomRecordBand.setfont(const avalue: TraStandardFont);
begin
 inherited setfont(avalue);
end;

function TraCustomRecordBand.getfont: TraStandardFont;
begin
 result:= TraStandardFont(inherited getfont);
end;

function TraCustomRecordBand.getfontclass: widgetfontclassty;
begin
 result:= TraStandardFont;
end;

procedure TraCustomRecordBand.setnextband(const avalue: TraCustomRecordBand);
begin
 setlinkedvar(avalue,fnextband);
end;

procedure TraCustomRecordBand.setnextbandifempty(const avalue: TraCustomRecordBand);
begin
 setlinkedvar(avalue,fnextbandifempty);
end;

procedure TraCustomRecordBand.registerchildwidget(const child: twidget);
begin
 inherited;
 if child is TraBaseBandArea then begin
  additem(pointerarty(fareas),child);
 end;
 if child is TraCustomRecordBand then begin
  additem(pointerarty(frecbands),child);
 end;
end;

procedure TraCustomRecordBand.unregisterchildwidget(const child: twidget);
begin
 removeitem(pointerarty(fareas),child);
 removeitem(pointerarty(frecbands),child);
 inherited;
end;

procedure TraCustomRecordBand.scale(const ascale: real);
begin
 inherited;
 ftabs.scale(ascale);
end;

{ TraRecordBand }

constructor TraRecordBand.create(aowner: tcomponent);
begin
 inherited;
end;

{ TraCustomBandGroup }

procedure TraCustomBandGroup.registerchildwidget(const child: twidget);
begin
 if child is TraCustomRecordBand then begin
  inherited;
//  additem(pointerarty(fbands),child);
  with TraCustomRecordBand(child) do begin
   fparentintf:= ibandparent(self);
   include(fwidgetstate1,ws1_nominsize);
  end;
 end
 else begin
  raise exception.create('Widget must be TraCustomRecordBand.');
 end;
end;

procedure TraCustomBandGroup.unregisterchildwidget(const child: twidget);
begin
// removeitem(pointerarty(fbands),child);
 TraCustomRecordBand(child).fparentintf:= nil;
 inherited;
 exclude(TraCustomRecordBand(child).fwidgetstate1,ws1_nominsize);
end;

procedure TraCustomBandGroup.registerclient(const aclient: ireportclient);
begin
 //dummy, register children only
end;

procedure TraCustomBandGroup.unregisterclient(const aclient: ireportclient);
begin
 //dummy, register children only
end;

procedure TraCustomBandGroup.dobeforerender(var empty: boolean);
var
 int1: integer;
 bo1: boolean;
begin
 inherited;
 for int1:= 0 to high(frecbands) do begin
  bo1:= empty;
  frecbands[int1].dobeforerender(bo1);
 end;
end;

procedure TraCustomBandGroup.dopaint(const acanvas: tcanvas);
var
 int1,int2,int3: integer;
 pt1: pointty;
begin
 inherited;
 if rendering then begin
  pt1:= acanvas.origin;
  int2:= pt1.x - paintpos.x;
  int3:= pt1.y + innerclientpos.y;
  for int1:= 0 to high(frecbands) do begin
   with frecbands[int1] do begin
    if visible then begin
     acanvas.origin:= makepoint(int2 + bounds_x,int3);
     inheritedpaint(acanvas);
     inc(int3,bounds_cy);
//     acanvas.move(makepoint(0,bounds_cy));
     nextrecord;
    end;
   end;
  end;
  acanvas.origin:= pt1;
 end else begin
  acanvas.drawrect(inflaterect(clientrect,-1),$FFCCBF);
 end;
end;

procedure TraCustomBandGroup.setdatasource(const avalue: string);
var
 int1,int2: integer;
begin
 inherited;
 if (componentstate*[csdesigning,csloading] = [csdesigning]) and 
                                               (avalue <> '') then begin
  for int1:= 0 to high(frecbands) do begin
   with frecbands[int1] do begin
    if DataSource = '' then begin
     for int2:= 0 to ftabs.count - 1 do begin
      ftabs[int2].DataSource:= avalue;
     end;
    end;
   end;
  end;
 end; 
end;

procedure TraCustomBandGroup.setparentwidget(const avalue: twidget);
var
 int1: integer;
begin
 inherited;
 for int1:= 0 to high(frecbands) do begin
  frecbands[int1].fparentintf:= fparentintf;
 end;
end;
{
procedure TraCustomBandGroup.updatevisibility;
var
 int1: integer;
begin
 inherited;
 beginscaling;
 for int1:= 0 to high(fbands) do begin
  with fbands[int1] do begin
   updatevisibility;
  end;
 end;
 endscaling;
end;
}
function TraCustomBandGroup.getminbandsize: sizety;
var
 int1,int2,int3: integer;
begin
 result:= inherited getminbandsize;
 int2:= 0;
 for int1:= 0 to high(frecbands) do begin
  with frecbands[int1] do begin
   if visible then begin
    int3:= bounds_x + bounds_cx;
    if int3 > result.cx then begin
     result.cx:= int3;
    end;
    inc(int2,bounds_cy);
   end;
  end;
 end;
 if int2 > result.cy then begin
  result.cy:= int2;
 end;
end;

function TraCustomBandGroup.lastbandheight: integer;
var
 int1,int2: integer;
begin
 result:= inherited lastbandheight;
 if osc_expandy in optionsscale then begin
  int2:= innerclientframewidth.cy;
  for int1:= 0 to high(frecbands) do begin
   with frecbands[int1] do begin
    if bandisvisible(false) and not (bos_HideLastOfPage in foptionsshow) or 
           (bos_ShowLastOfPage in foptionsshow) then begin
     int2:= int2 + bounds_cy;
    end;
   end;
  end;
  if int2 > result then begin
   result:= int2;
  end;
 end;
end;

procedure TraCustomBandGroup.setareafull(const avalue: boolean);
begin
 if fparentintf <> nil then begin
  fparentintf.setareafull(avalue);
 end;
end;

procedure TraCustomBandGroup.init;
var
 int1: integer;
begin
 sortwidgetsyorder(widgetarty(frecbands));
 inherited;
 for int1:= 0 to high(frecbands) do begin
  frecbands[int1].init;
 end;
end;

procedure TraCustomBandGroup.beginrender(const arestart: boolean);
var
 int1: integer;
begin
 inherited;
 for int1:= 0 to high(frecbands) do begin
  frecbands[int1].beginrender(arestart);
 end;
end;

procedure TraCustomBandGroup.resetzebra;
var
 int1: integer;
begin
 inherited;
 for int1:= 0 to high(frecbands) do begin
  frecbands[int1].resetzebra;
 end;
end;

procedure TraCustomBandGroup.endrender;
var
 int1: integer;
begin
 inherited;
 for int1:= 0 to high(frecbands) do begin
  frecbands[int1].endrender;
 end;
end;

procedure TraCustomBandGroup.adddatasets(var adatasets: datasetarty);
var
 int1: integer;
begin
 inherited;
 for int1:= 0 to high(frecbands) do begin
  frecbands[int1].adddatasets(adatasets);
 end;
end;

function TraCustomBandGroup.beginband(const acanvas: tcanvas;
               const sender: TraCustomRecordBand): boolean;
begin
 result:= fparentintf.beginband(acanvas,sender);
end;

procedure TraCustomBandGroup.endband(const acanvas: tcanvas;
               const sender: TraCustomRecordBand);
begin
 fparentintf.endband(acanvas,sender);
end;

function TraCustomBandGroup.istopband: boolean;
begin
 result:= fparentintf.istopband;
end;

function TraCustomBandGroup.isfirstband: boolean;
begin
 result:= fparentintf.isfirstband;
end;

function TraCustomBandGroup.islastband(const addheight: integer = 0): boolean;
begin
 result:= fparentintf.islastband;
end;

procedure TraCustomBandGroup.updatevisible;
begin
 fparentintf.updatevisible;
end;

function TraCustomBandGroup.getwidget: twidget;
begin
 result:= fparentintf.getwidget;
end;

function TraCustomBandGroup.remainingheight: integer;
begin
 result:= fparentintf.remainingheight;
end;

function TraCustomBandGroup.pagepagenum: integer;
begin
 result:= fparentintf.pagepagenum;
end;

function TraCustomBandGroup.reppagenum: integer;
begin
 result:= fparentintf.reppagenum;
end;

function TraCustomBandGroup.getlastpagepagecount: integer;
begin
 result:= fparentintf.getlastpagepagecount;
end;

function TraCustomBandGroup.getlastreppagecount: integer;
begin
 result:= fparentintf.getlastreppagecount;
end;

function TraCustomBandGroup.pageprintstarttime: tdatetime;
begin
 result:= fparentintf.pageprintstarttime;
end;

function TraCustomBandGroup.repprintstarttime: tdatetime;
begin
 result:= fparentintf.repprintstarttime;
end;

function TraCustomBandGroup.getreppage: TraReportPage;
begin
 result:= fparentintf.getreppage;
end;

procedure TraCustomBandGroup.dobeforenextrecord(const adatasource: tdatasource);
var
 int1: integer;
begin
 inherited;
 for int1:= 0 to high(frecbands) do begin
  frecbands[int1].dobeforenextrecord(adatasource);
 end;
end;

procedure TraCustomBandGroup.dosyncnextrecord;
var
 int1: integer;
begin
 inherited;
 for int1:= 0 to high(frecbands) do begin
  frecbands[int1].dosyncnextrecord;
 end;
end;

procedure TraCustomBandGroup.initpage;
var
 int1: integer;
begin
 inherited;
 for int1:= 0 to high(frecbands) do begin
  frecbands[int1].initpage;
 end;
end;

{ TraBaseBandArea }

function TraBaseBandArea.getareafull: boolean;
begin
 result:= bas_areafull in fstate;
end;

procedure TraBaseBandArea.setareafull(const avalue: boolean);
begin
 if avalue then begin
  include(fstate,bas_areafull);
 end
 else begin
  exclude(fstate,bas_areafull);
 end;
end;

procedure TraBaseBandArea.registerchildwidget(const child: twidget);
begin
 inherited;
 if child is TraCustomRecordBand then begin
  additem(pointerarty(fareabands),child);
 end;
end;

procedure TraBaseBandArea.unregisterchildwidget(const child: twidget);
begin
 removeitem(pointerarty(fareabands),child);
 inherited;
end;

procedure TraBaseBandArea.registerclient(const aclient: ireportclient);
begin
 //dummy, register children only
end;

procedure TraBaseBandArea.unregisterclient(const aclient: ireportclient);
begin
 //dummy, register children only
end;

procedure TraBaseBandArea.setparentwidget(const avalue: twidget);
var
 widget1: twidget;
begin
 if avalue is TraCustomRecordBand then begin
  frecordband:= TraCustomRecordBand(avalue);
 end
 else begin
  frecordband:= nil;
 end;
 if avalue is TraReportPage then begin
  freportpage:= TraReportPage(avalue);
 end
 else begin
  freportpage:= nil;
  widget1:= avalue.parentwidget;
  while widget1 <> nil do begin
   if widget1 is TraReportPage then begin
    freportpage:= TraReportPage(widget1);
    break;
   end;
   widget1:= widget1.parentwidget;
  end;
 end;
 inherited;
end;

procedure TraBaseBandArea.init;
var
 int1: integer;
begin
 include(fstate,bas_inited);
 sortwidgetsyorder(widgetarty(fareabands));
 for int1:= 0 to high(fareabands) do begin
  fareabands[int1].init;
 end;
 initareapage;
end;

procedure TraBaseBandArea.initband;
begin
 sortwidgetsyorder(widgetarty(fareabands));
 fstate:= fstate - [bas_areafull,bas_backgroundrendered,bas_notfirstband,
                             bas_lastband];
end;

procedure TraBaseBandArea.initpage;
var
 int1: integer;
begin
 include(fstate,bas_top);
 for int1:= 0 to high(fareabands) do begin
  fareabands[int1].initpage;
 end;
 initband;
end;

function TraBaseBandArea.render(const acanvas: tcanvas): boolean;
begin
 //dummy
end;

procedure TraBaseBandArea.initareapage;
begin
 exclude(fstate,bas_notfirstband);
 include(fstate,bas_top);
end;

procedure TraBaseBandArea.dofirstarea;
begin
 //
end;

procedure TraBaseBandArea.dobeforerender;
begin
 //
end;

procedure TraBaseBandArea.doonpaint(const acanvas: tcanvas);
begin
 //
end;

procedure TraBaseBandArea.doafterpaint1(const acanvas: tcanvas);
begin
 //
end;

procedure TraBaseBandArea.renderbackground(const acanvas: tcanvas);
begin
 if frecordband = nil then begin
  freportpage.beginarea(acanvas,self);
  acanvas.origin:= pos;
 end
 else begin
  acanvas.origin:= forigin;
 end;
 inherited paint(acanvas);
end;

function TraBaseBandArea.checkareafull(ay: integer): boolean;
begin
 if frame <> nil then begin
  ay:= ay + fframe.innerframe.bottom;
 end;
 result:= ay > bounds_y + bounds_cy;
end;

function TraBaseBandArea.beginband(const acanvas: tcanvas;
                             const sender: TraCustomRecordBand): boolean;
begin
 result:= false; //dummy
end;

procedure TraBaseBandArea.endband(const acanvas: tcanvas;
                                      const sender: TraCustomRecordBand);
begin
 //dummy
end;

procedure TraBaseBandArea.paint(const canvas: tcanvas);
begin
 if not rendering then begin
  inherited;
  canvas.drawrect(inflaterect(clientrect,-1),$C9FFBD); 
 end
 else begin
  if (frecordband <> nil) then begin
   forigin:= canvas.origin;
   render(canvas);
  end;
 end;
end;

function TraBaseBandArea.rendering: boolean;
begin
 result:= bas_rendering in fstate;
end;

procedure TraBaseBandArea.beginrender(const arestart: boolean);
var
 int1: integer;
begin
 if arestart then begin
  fstate:= fstate - [bas_notfirstband,bas_finished];
 end
 else begin
  fstate:= [bas_rendering];
 end;
 include(fwidgetstate1,ws1_noclipchildren);
 for int1:= 0 to high(fareabands) do begin
  with fareabands[int1] do begin
   beginrender(false);
  end;
 end;
end;

procedure TraBaseBandArea.resetzebra;
var
 int1: integer;
begin
 for int1:= 0 to high(fareabands) do begin
  fareabands[int1].resetzebra;
 end;
end;

procedure TraBaseBandArea.endrender;
var
 int1: integer;
begin
 exclude(fstate,bas_rendering);
 exclude(fwidgetstate1,ws1_noclipchildren);
 for int1:= 0 to high(fareabands) do begin
  fareabands[int1].endrender;
 end;
end;

procedure TraBaseBandArea.adddatasets(var adatasets: datasetarty);
var
 int1: integer;
begin
 for int1:= 0 to high(fareabands) do begin
  fareabands[int1].adddatasets(adatasets);
 end;
end;

function TraBaseBandArea.istopband: boolean;
begin
 result:= bas_top in fstate;
end;

function TraBaseBandArea.isfirstband: boolean;
begin
 result:= false; //dummy
end;

function TraBaseBandArea.islastband(const addheight: integer = 0): boolean;
begin
 result:= false; //dummy
end;

function TraBaseBandArea.remainingheight: integer;
begin
 result:= 0; //dummy
end;

procedure TraBaseBandArea.updatevisible;
var
 int1: integer;
begin
 for int1:= 0 to high(fareabands) do begin
  fareabands[int1].updatevisibility;
 end;
end;

function TraBaseBandArea.pagepagenum: integer;
begin
 result:= freportpage.pagenum;
end;

function TraBaseBandArea.reppagenum: integer;
begin
 if freportpage.freport<>nil then begin
  result:= freportpage.freport.pagenum;
 end else begin
  result:=0;
 end;
end;

function TraBaseBandArea.pageprintstarttime: tdatetime;
begin
 result:= freportpage.fprintstarttime;
end;

function TraBaseBandArea.getlastpagepagecount: integer;
begin
 result:= freportpage.flastpagecount;
end;

function TraBaseBandArea.getlastreppagecount: integer;
begin
 result:= freportpage.freport.flastpagecount;
end;

function TraBaseBandArea.repprintstarttime: tdatetime;
begin
 if freportpage.freport<>nil then begin
  result:= freportpage.freport.fprintstarttime;
 end else begin
  result:= now;
 end;
end;

function TraBaseBandArea.getreppage: TraReportPage;
begin
 result:= freportpage;
end;

function TraBaseBandArea.isfirstrecord: boolean;
begin
 if frecordband <> nil then begin
  result:= frecordband.isfirstrecord;
 end
 else begin
  result:= freportpage.isfirstrecord;
 end;
end;

function TraBaseBandArea.islastrecord: boolean;
begin
 if frecordband <> nil then begin
  result:= frecordband.islastrecord;
 end
 else begin
  result:= freportpage.islastrecord;
 end;
end;

procedure TraBaseBandArea.dobeforenextrecord(const adatasource: tdatasource);
var
 int1: integer;
begin
 for int1:= 0 to high(fareabands) do begin
  fareabands[int1].dobeforenextrecord(adatasource);
 end;
end;

procedure TraBaseBandArea.dosyncnextrecord;
var
 int1: integer;
begin
 for int1:= 0 to high(fareabands) do begin
  fareabands[int1].dosyncnextrecord;
 end;
end;

procedure TraBaseBandArea.setfont(const avalue: TraStandardFont);
begin
 inherited setfont(avalue);
end;

function TraBaseBandArea.getfont: TraStandardFont;
begin
 result:= TraStandardFont(inherited getfont);
end;

function TraBaseBandArea.getfontclass: widgetfontclassty;
begin
 result:= TraStandardFont;
end;

procedure TraBaseBandArea.restart;
begin
 beginrender(true);
 if freportpage <> nil then begin
  freportpage.recordchanged;
 end;
end;

{ TraReportPage }

constructor TraReportPage.create(aowner: tcomponent);
begin
 fcansetpapersize:= true;
 fprintstarttime:= now;
 fvisiblepage:= true;
 fdatalink:= TraReportPageDataLink.create;
 inherited;
 fwidgetstate1:= fwidgetstate1 + [ws1_nodesignvisible,ws1_nodesignhandles,
                                       ws1_nodesigndelete];
 fpagewidth:= defaultreppagewidth;
 fpageheight:= defaultreppageheight; 
 fppmm:= defaultrepppmm;
 width:= round(defaultreppagewidth*defaultrepppmm);
 height:= round(defaultreppageheight*defaultrepppmm);
 fpageorientation:= Portrait;
 color:= cl_white;
 ffont:= twidgetfont(TraFont.create);
 //ffont.height:= round(defaultrepfontheight * (fppmm/defaultrepppmm));
 ffont.height:= defaultrepfontheight;
 ffont.onchange:= {$ifdef FPC}@{$endif}dofontchanged;
end;

destructor TraReportPage.destroy;
begin
 inherited;
 fdatalink.free;
end;

procedure TraReportPage.registerchildwidget(const child: twidget);
begin
 inherited;
 if child is TraBaseBandArea then begin
  additem(pointerarty(fareas),child);
 end;
end;

procedure TraReportPage.unregisterchildwidget(const child: twidget);
begin
 removeitem(pointerarty(fareas),child);
 inherited;
end;

procedure TraReportPage.registerclient(const aclient: ireportclient);
var
 widget1: twidget;
begin
 if finditem(pointerarty(fclients),aclient) < 0 then begin
  additem(pointerarty(fclients),aclient);
 end;
 widget1:= aclient.getwidget;
 if widget1 is TraCustomRecordBand then begin
  if finditem(pointerarty(fbands),widget1) < 0 then begin
   additem(pointerarty(fbands),widget1);
  end;
 end;
end;

procedure TraReportPage.unregisterclient(const aclient: ireportclient);
begin
 removeitem(pointerarty(fclients),aclient);
 removeitem(pointerarty(fbands),aclient.getwidget);
end;

procedure TraReportPage.init;
var
 int1: integer;
begin
 include(fstate,rpps_inited);
 exclude(fstate,rpps_showed);
 for int1:= 0 to high(fclients) do begin
  fclients[int1].init;
 end;
// for int1:= 0 to high(fareas) do begin
//  fareas[int1].init;
// end;
end;

procedure TraReportPage.dosyncnextrecord;
var
 int1: integer;
begin
 for int1:= 0 to high(fareas) do begin
  fareas[int1].dosyncnextrecord;
 end;
 for int1:= 0 to high(fbands) do begin
  fbands[int1].dosyncnextrecord;
 end;
end;

procedure TraReportPage.dobeforenextrecord(const adatasource: tdatasource);
var
 int1: integer;
begin
 for int1:= 0 to high(fareas) do begin
  fareas[int1].dobeforenextrecord(adatasource);
 end;
 for int1:= 0 to high(fbands) do begin
  fbands[int1].dobeforenextrecord(adatasource);
 end;
end;

function TraReportPage.render(const acanvas: tcanvas): boolean;
var
 int1: integer;
 bo1,bo2,bo4: boolean;
 customdataempty: boolean;
 backgroundrendered: boolean;
 hascustomdata: boolean;
 
 procedure renderband(const aband: TraCustomRecordBand);
 begin
  with aband do begin
   bo4:= (not customdataempty or backgroundrendered) and 
          (bo2 and (bo_OddPage in foptions) or 
           not bo2 and (bo_EvenPage in foptions)); //has data
   bo4:= not(bo4 or ((bo_Once in foptions) and not (rbs_showed in fstate)));
                //empty
  
   render(acanvas,bo4);
   bo1:= bo1 and bo4;
  end;
 end;

begin
 if not (rpps_inited in fstate) then begin
  init; 
 end;
 fprintstarttime:= now;
 bo1:= odd(reppagenum);
 if bo1 and (PageFirstEven in foptions) or not bo1 and 
                         (PageFirstOdd in foptions) then begin
  freport.nextpage(acanvas,self);  
  with freport do begin
   if fpagenum = 0 then begin
    include(fstate,rs_dummypage);
   end; 
   inc(fpagenum);
  end;
 end;
 fpagenum:= 0;
 updatepagesize;
 exclude(fstate,rpps_finish);
 recordchanged;
 freport.dofirstpage(self);
 result:= true;
 repeat
  if rpps_finish in fstate then begin
   break;
  end;
  exclude(fstate,rpps_backgroundrendered);
  acanvas.reset;
  acanvas.intersectcliprect(makerect(nullpoint,fwidgetrect.size));
  updatevisible;
  bo1:= (not fdatalink.active or fdatalink.dataset.eof) and
         not ((PageOnce in foptions) and not (rpps_showed in fstate));
  dobeforerender(bo1);
  customdataempty:= bo1;
  for int1:= 0 to high(fareas) do begin
   fareas[int1].initpage;
  end;
  for int1:= 0 to high(fbands) do begin
   fbands[int1].initpage;
  end;
  updatevisible;
  for int1:= 0 to high(fareas) do begin
   with fareas[int1] do begin
    if visible then begin
     bo1:= render(acanvas) and bo1;
    end;
   end;
  end;
  sortwidgetsyorder(widgetarty(fbands),self);
  bo2:= odd(reppagenum);
//  bo5:= true;
  backgroundrendered:= rpps_backgroundrendered in fstate;
  for int1:= 0 to high(fbands) do begin
   if not (fbands[int1] is TraCustomValueDisplay) then begin
    renderband(fbands[int1]);
   end;
  end;
  backgroundrendered:= rpps_backgroundrendered in fstate;
  for int1:= 0 to high(fbands) do begin
   if fbands[int1] is TraCustomValueDisplay then begin
    renderband(fbands[int1]);
   end;
  end;
  if not (rpps_backgroundrendered in fstate) and not customdataempty then begin
   renderbackground(acanvas);  
  end;
              
  if rpps_backgroundrendered in fstate then begin
   doafterpaint1(acanvas);
   if not (rpps_finish in fstate) and  fdatalink.active then begin
    bo1:= false;
    application.lock;
    try
     dobeforenextrecord(fdatalink.DataSource);
     fdatalink.dataset.next;
     if checkislastrecord(fdatalink,@dosyncnextrecord) then begin
      include(fstate,rpps_lastrecord);
     end; 
    finally
     application.unlock;
    end;
    recordchanged;
   end;
   inc(fpagenum);
   inc(freport.fpagenum);
   include(fstate,rpps_showed);
  end;
  freport.doprogress;
  result:= result and bo1;
  if bo1 or (fnextpage <> nil) or (rpps_finish in fstate) then begin 
                        //next page
   exclude(fstate,rpps_restart);
   freport.doafterlastpage(self);
   if rpps_restart in fstate then begin
    bo1:= false;
   end;
  end;
 until bo1 or (fnextpage <> nil);
end;

function TraReportPage.rendering: boolean;
begin
 result:= rpps_rendering in fstate;
end;

procedure TraReportPage.dobeforerender(var empty: boolean);
begin
 freport.dopagebeforerender(self,empty);
end;

procedure TraReportPage.doafterpaint1(const acanvas: tcanvas);
begin
 freport.dopageafterpaint(self,acanvas);
end;

procedure TraReportPage.renderbackground(const acanvas: tcanvas);
begin
 if (freport.fpagenum <> 0) and not (rs_dummypage in freport.fstate) then begin
  freport.nextpage(acanvas,self);
 end;
 exclude(freport.fstate,rs_dummypage);
 acanvas.origin:= pos;
 inherited paint(acanvas);
 include(fstate,rpps_backgroundrendered);
end;

procedure TraReportPage.beginarea(const acanvas: tcanvas;
                                              const sender: TraBaseBandArea);
begin
 if not (rpps_backgroundrendered in fstate) then begin
  include(fstate,rpps_backgroundrendered);
  renderbackground(acanvas);
 end;
end;

procedure TraReportPage.beginrender(const arestart: boolean);
 procedure addreccontrols(const awidget: twidget);
 var
  int1: integer;
  po1: pointer;
 begin
  for int1:= 0 to awidget.widgetcount -1 do begin
   addreccontrols(awidget.widgets[int1]);
   if awidget.widgets[int1].getcorbainterface(typeinfo(ireccontrol),po1) then begin
    additem(freccontrols,po1);
   end;
  end;
 end;
var
 int1: integer;
begin
 freccontrols:= nil;
 addreccontrols(self);
 if arestart then begin
  fstate:= fstate * [rpps_inited,rpps_rendering];
 end
 else begin
  fstate:= [rpps_rendering];
 end;
 include(fwidgetstate1,ws1_noclipchildren);
 with fdatalink do begin
  if active then begin
   application.lock;
   try
    dataset.first;
    if checkislastrecord(fdatalink,@dosyncnextrecord) then begin
     include(fstate,rpps_lastrecord);
    end;
   finally
    application.unlock;
   end;
   self.recordchanged;
  end;
 end;
 for int1:= 0 to high(fclients) do begin
  fclients[int1].beginrender(false);
 end;
 for int1:= 0 to high(fareas) do begin
  fareas[int1].beginrender(false);
 end;
end;

procedure TraReportPage.resetzebra;
var
 int1: integer;
begin
 for int1:= 0 to high(fclients) do begin
  fclients[int1].resetzebra;
 end;
 for int1:= 0 to high(fareas) do begin
  fareas[int1].resetzebra;
 end;
end;

procedure TraReportPage.endrender;
var
 int1: integer;
begin
 flastpagecount:= fpagenum;
 freccontrols:= nil;
 exclude(fstate,rpps_rendering);
 exclude(fwidgetstate1,ws1_noclipchildren);
 for int1:= 0 to high(fclients) do begin
  fclients[int1].endrender;
 end;
 for int1:= 0 to high(fareas) do begin
  fareas[int1].endrender;
 end;
end;

procedure TraReportPage.adddatasets(var adatasets: datasetarty);
var
 int1: integer;
begin
 if fdatalink.dataset <> nil then begin
  adduniqueitem(pointerarty(adatasets),fdatalink.dataset);
 end;
 for int1:= 0 to high(fclients) do begin
  fclients[int1].adddatasets(adatasets);
 end;
 for int1:= 0 to high(fareas) do begin
  fareas[int1].adddatasets(adatasets);
 end;
end;

procedure TraReportPage.setpageorientation(const avalue: rapageorientationty);
begin
 if fpageorientation <> avalue then begin
  fpageorientation:= avalue;
  updatepagesize;
 end;
end;

procedure TraReportPage.updatepapersize;
var
 int1: pagesizety;
begin
 fpapersize:= Custom;
 for int1:=Letter to Custom do begin
  if (abs(fpagewidth-pagesizes[int1].width)<=1) and 
   (abs(fpageheight-pagesizes[int1].height)<=1) then begin
   fpapersize:= int1;
   break;
  end;
 end;
end;

procedure TraReportPage.setpagewidth(const avalue: real);
begin
 if fpagewidth <> avalue then begin
  fpagewidth:= avalue;
  if fcansetpapersize then begin
   updatepapersize;
  end;
  updatepagesize;
 end;
end;

procedure TraReportPage.setpageheight(const avalue: real);
begin
 if fpageheight <> avalue then begin
  fpageheight:= avalue;
  if fcansetpapersize then begin
   updatepapersize;
  end;
  updatepagesize;
 end;
end;

procedure TraReportPage.setpapersize(const avalue: pagesizety);
begin
 if avalue<>fpapersize then begin
  fpapersize:= avalue;
  if fpapersize <> Custom then begin
   fcansetpapersize:= false;
   setpagewidth(pagesizes[fpapersize].width);
   setpageheight(pagesizes[fpapersize].height);
   fcansetpapersize:= true;
  end;
 end;
end;

procedure TraReportPage.updatepagesize;
begin
 if fpageorientation=Portrait then begin
  size:= makesize(round(fpagewidth*fppmm),round(fpageheight*fppmm));
 end else begin
  size:= makesize(round(fpageheight*fppmm),round(fpagewidth*fppmm));
 end;
end;

procedure TraReportPage.setppmm(const avalue: real);
var
 rea1: real;
 int1: integer;
begin
 if avalue <> fppmm then begin
  fppmm:= avalue;
  updatepagesize;
  if not (csloading in componentstate) then begin
   postchildscaled;
  end;
 end;
end;

procedure TraReportPage.insertwidget(const awidget: twidget;
               const apos: pointty);
begin
 if (awidget is TraReportPage) and (fparentwidget <> nil) then begin
  fparentwidget.insertwidget(awidget,addpoint(apos,pos));
 end
 else begin
  inherited;
 end;  
end;

procedure TraReportPage.sizechanged;
begin
 if parentwidget<>nil then begin
  parentwidget.size:= size;
 end;
 inherited;
end;

procedure TraReportPage.setnextpage(const avalue: TraReportPage);
begin
 setlinkedvar(avalue,fnextpage);
end;

procedure TraReportPage.setnextpageifempty(const avalue: TraReportPage);
begin
 setlinkedvar(avalue,fnextpageifempty);
end;

function TraReportPage.beginband(const acanvas: tcanvas;
               const sender: TraCustomRecordBand): boolean;
begin
 fsaveindex:= acanvas.save;
 if not (rpps_backgroundrendered in fstate) then begin
  renderbackground(acanvas);
 end;
 acanvas.origin:= translatewidgetpoint(sender.pos,sender.parentwidget,self);
 result:= false;
end;

procedure TraReportPage.endband(const acanvas: tcanvas;
               const sender: TraCustomRecordBand);
begin
 acanvas.restore(fsaveindex);
 include(sender.fstate,rbs_showed);
end;

function TraReportPage.istopband: boolean;
begin
 result:= false;
end;

function TraReportPage.isfirstband: boolean;
begin
 result:= false;
end;

function TraReportPage.islastband(const addheight: integer = 0): boolean;
begin
 result:= false;
end;

procedure TraReportPage.setareafull(const avalue: boolean);
begin
 //dummy
end;

procedure TraReportPage.updatevisible;
var
 int1: integer;
begin
 for int1:= 0 to high(fclients) do begin
  fclients[int1].updatevisibility;
 end;
 for int1:= 0 to high(fareas) do begin
  fareas[int1].updatevisible;
 end;
end;

function TraReportPage.remainingheight: integer;
begin
 result:= 0;
end;

function TraReportPage.pagepagenum: integer;
begin
 result:= fpagenum;
end;

function TraReportPage.reppagenum: integer;
begin
 if freport<>nil then begin
  result:= freport.fpagenum;
 end else begin
  result:=0;
 end;
end;

function TraReportPage.getdatasource: string;
begin
 if fdatalink.DataSource=nil then begin
  result:='';
 end else begin
  result:= fdatalink.DataSource.name;
 end;
end;

function TraReportPage.pageprintstarttime: tdatetime;
begin
 result:= fprintstarttime;
end;

function TraReportPage.repprintstarttime: tdatetime;
begin
 if freport<>nil then begin
  result:= freport.fprintstarttime;
 end else begin
  result:= now;
 end;
end;

procedure TraReportPage.setdatasource(const avalue: string);
var
 tmpdatasource: tdatasource;
begin
 tmpdatasource:= getdatasourcereport(avalue);
 fdatalink.DataSource:= tmpdatasource;
end;

procedure TraReportPage.activatepage;
begin
 freport.activepage:= finditem(pointerarty(freport.freppages),self);
end;

procedure TraReportPage.finish;
begin
 include(fstate,rpps_finish);
end;

procedure TraReportPage.restart;
begin
 beginrender(true);
 include(fstate,rpps_restart);
 recordchanged;
end;

procedure TraReportPage.setoptions(const avalue: reportpageoptionsty);
const
 mask: reportpageoptionsty = [PageFirstEven,PageFirstOdd];
begin
 foptions:= reportpageoptionsty(setsinglebit(longword(avalue),
                 longword(foptions),longword(mask)));
end;

function TraReportPage.getreppage: TraReportPage;
begin
 result:= self;
end;

function TraReportPage.isfirstrecord: boolean;
begin
 if fdatalink.active then begin
  result:= not (rpps_notfirstrecord in fstate);
 end
 else begin
  result:= false;
 end;
end;

function TraReportPage.islastrecord: boolean;
begin
 if fdatalink.active then begin
  result:= rpps_lastrecord in fstate;
 end
 else begin
  result:= false;
 end;
end;

procedure TraReportPage.recordchanged;
var
 int1: integer;
begin
 application.lock;
 try
  for int1:= 0 to high(freccontrols) do begin
   ireccontrol(freccontrols[int1]).recchanged;
  end;
 finally
  application.unlock;
 end;
end;

function TraReportPage.getlastpagepagecount: integer;
begin
 result:= flastpagecount;
end;

function TraReportPage.getlastreppagecount: integer;
begin
 if freport<>nil then begin
  result:= freport.flastpagecount;
 end else begin
  result:=0;
 end;
end;

procedure TraReportPage.setfont(const avalue: TraStandardFont);
begin
 inherited setfont(avalue);
end;

function TraReportPage.getfont: TraStandardFont;
begin
 result:= TraStandardFont(inherited getfont);
end;

function TraReportPage.getfontclass: widgetfontclassty;
begin
 result:= TraStandardFont;
end;

function TraReportPage.getppmm: real;
begin
 result:= fppmm;
end;

 {trepaz}
 
constructor trepaz.create(aowner: tcomponent);
begin
 funits:= Milimeter;
 fscale:= 3;
 fprintstarttime:= now;
 fppmm:= defaultrepppmm;
 freportactions:= defaultreportactions;
 foptions:= defaultreportoptions;
 freportowner:= aowner;
 fdialogtext:= 'Processing report...';
 fdialogcaption:= 'Repaz';
 fprintdestination:= preview;
 freppages:=nil;
 isreportfinished:= false;
 fosprinter:= tosprinter.create(nil);
 fpsprinter:= tpsprinter.create(nil);
 if canevent(tmethod(foncreate)) then begin
  foncreate(self);
 end;
 inherited;
end;

destructor trepaz.destroy;
var
 bo1: boolean;
begin
 bo1:= csdesigning in componentstate;
 freeandnil(frootcomp);
 fosprinter.free;
 fpsprinter.free;
 if not bo1 and candestroyevent(tmethod(fondestroyed)) then begin
  fondestroyed(self);
 end;
 inherited; //csdesigningflag is removed
end;

procedure trepaz.assign(sender: tpersistent);
begin
 if sender is trepaz then begin
  self.foptions:= trepaz(sender).foptions;
  self.freportactions:= trepaz(sender).freportactions;
  self.reportunit:= trepaz(sender).funits;
  self.unitscale:= trepaz(sender).fscale;
  self.freppages:= nil;
  self.freppages:= trepaz(sender).freppages;
  self.reportowner:= trepaz(sender).reportowner;
  self.datasources:= trepaz(sender).datasources;
 end else begin
  inherited;
 end;
end;

procedure trepaz.reportdesign;
begin
 if ra_design in freportactions then begin
  editrepaz(self); 
  isreportfinished:= false;
 end else begin
  showmessage('Repaz Design is not activated!');
 end;
end;

procedure trepaz.reportpreview;
var
 dia: TPreviewForm;
begin
 if ra_preview in freportactions then begin
  fprintdestination:= preview;
  if not isreportfinished then begin
   reportexecute;
   exit;
  end;
  if isreportfinished then begin
   try
    dia:= TPreviewForm.create(self);
    dia.tpreview1.width:= freppages[0].width;
    dia.tpreview1.height:= freppages[0].height;
    dia.tpreview1.metapages:=getmetapages;
    dia.tpreview1.visible:=true;
    dia.show(true);
   finally
    isreportfinished:= false;
    dia.free;
   end; 
  end;
 end else begin
  showmessage('Form preview is not activated!');
 end;
end;

procedure trepaz.reportprint(const withdialog: boolean);
var
 int1: integer;
 fmetapages: tmetapages;
 bo1: boolean;
begin
 if ra_print in freportactions then begin
  fprintdestination:= printer;
  if not isreportfinished then begin
   reportexecute;
   exit;
  end;
  if isreportfinished then begin
   fmetapages:= getmetapages;
   if length(fmetapages)>=1 then begin
    if not fosprinter.rawmode then begin
     fosprinter.canvas.ppmm:= fppmm;
    end;
    fosprinter.pa_paperheight:= freppages[0].pageheight;
    fosprinter.pa_paperwidth:= freppages[0].pagewidth;
    fosprinter.pa_orientation:= pageorientationty(ord(freppages[0].PageOrientation));
    fosprinter.pa_marginleft:=0;
    fosprinter.pa_marginright:=0;
    fosprinter.pa_margintop:=0;
    fosprinter.pa_marginbottom:=0;
    bo1:= true;
    if withdialog then begin
     bo1:=fosprinter.showdialog=mr_ok;
    end;
    if bo1 then begin
     if not fosprinter.rawmode then begin
      fosprinter.beginprint;
      for int1:=0 to length(fmetapages)-1 do begin
       printmetapages(fosprinter.canvas,fmetapages,int1);
       if (int1<length(fmetapages)-1) then begin
        fosprinter.canvas.nextpage;
       end;
      end;
      fosprinter.endprint;
     end else begin
      reportposprint;
     end;
    end;
   end;
  end;
 end else begin
  showmessage('Print to printer is not activated!');
 end;
end;

procedure trepaz.reportposprint;
var
 ftext: msestringarty;
 int1: longint;
 int2,col1: integer;
 fcodeprint: printercodearty;
 lastrowcode: longint;
 rowfound: longint;
 tmpcode: array of colprintercodety;
begin
 converttoformattedtext(ftext,fcodeprint);
 if length(ftext)>=1 then begin
  fosprinter.beginprint;
  fosprinter.senddata(fcodeprint[0].col[0].codetext);
  lastrowcode:=0;
  for int1:=0 to length(ftext)-1 do begin
   rowfound:= -1;
   for int2:= lastrowcode to length(fcodeprint)-1 do begin
    if fcodeprint[int2].row=int1 then begin
     rowfound:= int2;
     lastrowcode:= int2+1;
     break;
    end;
   end;
   if rowfound=-1 then begin
    fosprinter.senddata(ftext[int1] + fosprinter.esclist[esc_line_feed]);
   end else begin
    setlength(tmpcode,0);
    tmpcode:=nil;
    setlength(tmpcode,length(fcodeprint[rowfound].col));
    for int2:=0 to length(fcodeprint[rowfound].col)-1 do begin
     col1:= fcodeprint[rowfound].col[int2].pos;
     if ((int2+1)<=(length(fcodeprint[rowfound].col)-1)) then begin
      tmpcode[int2].codetext:= fcodeprint[rowfound].col[int2].codetext + 
         copy(ftext[int1],col1,fcodeprint[rowfound].col[int2+1].pos-col1);
     end else begin
      tmpcode[int2].codetext:= fcodeprint[rowfound].col[int2].codetext + 
         copy(ftext[int1],col1,length(ftext[int1])-col1-1);      
     end;
    end;
    for int2:=0 to length(tmpcode)-1 do begin
     fosprinter.senddata(tmpcode[int2].codetext);
    end;
    fosprinter.senddata(fosprinter.esclist[esc_line_feed]);
   end;
  end;
  for int1:=lastrowcode to length(fcodeprint)-1 do begin
   for int2:=0 to length(fcodeprint[int1].col)-1 do begin
    fosprinter.senddata(fcodeprint[int1].col[int2].codetext);
   end;
  end;
  fosprinter.endprint;
 end;
end;

procedure trepaz.reportpdf;
begin
 showmessage('Not yet created!');
end;

procedure trepaz.reportpostscript;
var
 int1: integer;
 fmetapages: tmetapages;
 tfiledialog1: tfiledialog;
 xx: filenamety;
begin
 if ra_save in freportactions then begin
  fprintdestination:= postscript;
  if not isreportfinished then begin
   reportexecute;
   exit;
  end;
  if isreportfinished then begin
   tfiledialog1:= tfiledialog.create(nil);
   tfiledialog1.dialogkind:= fdk_save;
   with tfiledialog1.controller do begin
    captionsave:='Save PostScript file';
    filterlist.add('PostScript files','*.ps');
    filterlist.add('All files','*.*');
   end;
   if tfiledialog1.execute=mr_ok then begin
    xx:= tfiledialog1.controller.filename;
    if xx='' then begin
     showmessage('Please type name of PostScript file output!');
     tfiledialog1.free;
     exit;
    end;
    fpsprinter.outputfilename:= xx;
   end;
   tfiledialog1.free;
   fpsprinter.pa_height:= freppages[0].pageheight;
   fpsprinter.pa_width:= freppages[0].pagewidth;
   fpsprinter.pa_orientation:= pageorientationty(ord(freppages[0].PageOrientation));
   fpsprinter.pa_marginleft:=0;
   fpsprinter.pa_marginright:=0;
   fpsprinter.pa_margintop:=0;
   fpsprinter.pa_marginbottom:=0;
   fmetapages:= getmetapages;
   if length(fmetapages)>=1 then begin
    fpsprinter.beginprint;
    for int1:=0 to length(fmetapages)-1 do begin
     printmetapages(fpsprinter.canvas,fmetapages,int1);
     if (int1<length(fmetapages)-1) then begin
      fpsprinter.canvas.nextpage;
     end;
    end;
    fpsprinter.endprint;
   end;
  end;
 end else begin
  showmessage('Save to file is not activated!');
 end;
end;

procedure trepaz.reportexecute(const usedialog: boolean);
var
 dia: TRepazDialog;
begin
 if ra_showdialog in freportactions then begin
  try
   dia:= TRepazDialog.create(self);
   dia.cactions.dropdown.itemindex:= ord(fprintdestination);
   if dia.show(true)=mr_ok then begin
    printdestination:= printdestinationty(dia.cactions.dropdown.itemindex);
    reportexecute;
   end else begin
    dia.close;
   end;
  finally
   dia.free;
  end; 
 end else begin
  reportexecute;
 end;
end;

procedure trepaz.reportexecute;
var
 bo1: boolean;
 tmpfilename: filenamety;
begin
 isreportfinished:= false;
 bo1:= isrelativepath(ffilename);
 if bo1 then begin
  tmpfilename:= getcurrentdir + copy(ffilename,3,length(ffilename)-2);
 end else begin 
  tmpfilename:= ffilename;
 end;
 bo1:= false;
 loadfromfile(tmpfilename,bo1);
 if not bo1 then begin
  showmessage('Report file can''t be opened!');
  exit;
 end;
 createnewmetareport;
 internalrender;
end;

procedure trepaz.savemetapages;
begin
 showmessage('Not yet created!');
end;

procedure trepaz.removepage(const apage: TraReportPage);
begin
 removeitem(pointerarty(freppages),apage);
end;

procedure trepaz.setprintdestination(const avalue: printdestinationty);
begin
 if avalue<>fprintdestination then begin
  fprintdestination:= avalue;
 end;
end;

procedure trepaz.setunits(const avalue: raunitty);
begin
 if funits<>avalue then begin
  funits:= avalue;
  if avalue=Milimeter then
   fscale:=3
  else if avalue=Inch then
   fscale:=74;
 end;
end;

procedure trepaz.setppmm(const avalue: real);
var
 int1: integer;
begin
 if avalue <> fppmm then begin
  if avalue <= 0 then begin
   raise exception.create('Invalid value');
  end;
  fppmm:= avalue;
  for int1:= 0 to high(freppages) do begin
   freppages[int1].ppmm:= avalue;
  end;
 end;
end;

procedure trepaz.setdatasources(const avalue: trepazdatasources);
begin
 fdatasources:= avalue;
 setdatasourcereport(avalue);
 setevaluatordatasource(avalue);
end;

procedure trepaz.setlookupbuffers(const avalue: trepazlookupbuffers);
begin
 flookupbuffers:= avalue;
end;

procedure trepaz.addpage(apage: TraReportPage);
var
 int1: integer;
begin
 apage.freport:=self;
 apage.visible:=false;
 additem(pointerarty(freppages),apage);
end;

procedure trepaz.doasyncevent(var atag: integer);
begin
 inherited;
 if (atag = endrendertag) then begin
  doonreportfinished;
  try
   if canevent(tmethod(fonreportfinished)) then begin
    fonreportfinished(self);
   end;
   if canevent(tmethod(fonrenderfinish)) then begin
    fonrenderfinish(self);
   end;
  finally
   //
  end; 
 end;
end;

function trepaz.exec: integer;

 function checkterminated: boolean;
 begin
  result:= fcanceled;
 end;

 procedure fakevisible(const awidget: twidget; const aset: boolean);
 var 
  int1: integer;
 begin
  with twidget1(awidget) do begin
   if aset then begin
    include(fwidgetstate1,ws1_fakevisible);
   end
   else begin
    exclude(fwidgetstate1,ws1_fakevisible);
   end;
   for int1:= 0 to high(fwidgets) do begin
    fakevisible(fwidgets[int1],aset);
   end;
  end;
 end;
 
var
 terminated1: boolean; 
 recnos: integerarty;
 renderbegin: boolean;
 
 procedure dofinish(const islast: boolean);
 var
  int1: integer;
 begin
  application.lock;
  try
   for int1:= 0 to high(freppages) do begin
    fakevisible(freppages[int1],false);
   end;
   flastpagecount:= fpagenum;
   if renderbegin then begin
    for int1:= 0 to high(freppages) do begin
     freppages[int1].endrender;
    end;
   end;
   terminated1:= checkterminated;
   if islast or (rs_endpass in fstate) or terminated1 then begin
    exclude(fstate,rs_running);
    asyncevent(endrendertag);
    for int1:= 0 to high(fdatasets) do begin
     with fdatasets[int1] do begin
      if active then begin
       try
        recno:= recnos[int1];
       except
        on e: exception do begin
         e.message:= 'Error : ' +e.message;
         raise;
        end;
       end;
      end;
      try
       enablecontrols;
      except
       on e: exception do begin
        e.message:= 'Error : ' +e.message;
        raise;
       end;
      end;
     end;
    end;
    fdatasets:= nil;
   end;
  finally
   application.unlock;
  end;
 end;

var               
 int1: integer;
 bo1: boolean;
 page1: TraReportPage;
 str1: string;
 restarted: boolean;
 
begin
 fstate:= [rs_running];
 result:= 0; 
 if not (reo_prepass in foptions) then begin
  include(fstate,rs_endpass);
 end;
 for int1:= 0 to high(freppages) do begin
  freppages[int1].adddatasets(fdatasets);
 end;
 setlength(recnos,length(fdatasets));
 for int1:= 0 to high(fdatasets) do begin
  with fdatasets[int1] do begin
   if not (reo_nodisablecontrols in foptions) then begin
    disablecontrols;
   end;
   recnos[int1]:= recno;
  end;
 end;
 try
  repeat //until terminated1
   fpagenum:= 0;
   factivepage:= 0;
   renderbegin:= false;
   for int1:= 0 to high(freppages) do begin
    fakevisible(freppages[int1],true);
   end;
   try
    if canevent(tmethod(fonreportstart)) then begin
     application.lock;
     try
      fonreportstart(self);
     finally
      application.unlock;
     end;
    end;
   except
    dofinish(true);
    raise;
   end;
   restarted:= false;
   repeat //until not restarted
    try
     if canevent(tmethod(fonbeforerender)) then begin
      application.lock;
      try
       fonbeforerender(self);
      finally
       application.unlock;
      end;
     end;
     renderbegin:= true;
     for int1:= 0 to high(freppages) do begin
      freppages[int1].beginrender(false);
     end;
     if high(freppages) >= factivepage then begin
      page1:= freppages[factivepage];
      while true do begin
       for int1:= finditem(pointerarty(freppages),page1) to high(freppages) do begin
        if freppages[int1].visiblepage then begin
         page1:= freppages[int1];
         break;
        end;
       end;
       if page1.visiblepage and not checkterminated then begin
        exclude(fstate,rs_activepageset);
        factivepage:= finditem(pointerarty(freppages),page1);
        bo1:= page1.render(reportcanvas);
        if rs_finish in fstate then begin
         break;
        end;
        if rs_activepageset in fstate then begin
         page1:= freppages[factivepage];
        end
        else begin
         if not bo1 and (page1.nextpage <> nil) then begin
           page1:= page1.nextpage;
         end
         else begin
          if bo1 and (page1.nextpageifempty <> nil) then begin
           page1:= page1.nextpageifempty;
          end
          else begin
           int1:= finditem(pointerarty(freppages),page1);
           if (int1 >= 0) and (int1 < high(freppages)) then begin
            page1:= freppages[int1+1];
           end
           else begin
            page1:= nil;
           end;
          end;
         end;
        end;
        if finditem(pointerarty(freppages),page1) < 0 then begin
         break;
        end;
       end
       else begin
        break;
       end;
      end;
     end;
    except
     dofinish(true);
     raise;
    end;
    restarted:= false;
    if canevent(tmethod(fonafterrender)) then begin
     application.lock;
     try
      exclude(fstate,rs_restart);
      fonafterrender(self);
      restarted:= rs_restart in fstate;
     finally
      application.unlock;
     end;
    end;
   until not restarted;
   dofinish(false);
   if (rs_endpass in fstate) then begin
    break;
   end;
   fstate:= [rs_endpass];
  until terminated1;
 finally
  application.lock;
  if (reo_waitdialog in foptions) then begin
   application.terminatewait;
  end;
 end;
end;

procedure trepaz.doexec(const sender: tobject);
begin
 exec;
end;

function trepaz.prepass: boolean;
begin
 result:= not (rs_endpass in fstate);
end;

procedure trepaz.docancel(const sender: tobject);
begin
 canceled:= true;
end;

procedure trepaz.findcomponentclass(Reader: TReader; const aClassName: string;
        var ComponentClass: TComponentClass);
var
 lname: string;
begin
 if componentclass = nil then begin
  lname:= lowercase(aClassName);
  if lname='trareportpage' then componentclass:= TraReportPage
  else if lname='trabandarea' then componentclass:= TraBandArea
  else if lname='tratilearea' then componentclass:= TraTileArea
  else if lname='trabandgroup' then componentclass:= TraBandGroup
  else if lname='trarecordband' then componentclass:= TraRecordBand
  else if lname='travaluedisplay' then componentclass:= TraValueDisplay
  else if lname='trapagenumber' then componentclass:= TraPageNumber
  else if lname='tradateprint' then componentclass:= TraDatePrint
  else if lname='traspacer' then componentclass:= TraSpacer;                    
 end;
end;

procedure trepaz.createcomponent(Reader: TReader; ComponentClass: TComponentClass;
                   var Component: TComponent);
begin
 //
end;

procedure trepaz.readstringproperty(Sender:TObject; const Instance: TPersistent;
    PropInfo: PPropInfo; var Content:string);
begin
 //
end;

procedure trepaz.onreferencename(Reader: TReader; var aName: string);
begin
 //
end;

procedure trepaz.internalrender;
begin
 if running then begin
  raise exception.create('Already rendering.');
 end;
 include(fstate,rs_running);
 fprintstarttime:= now;
 tmpcanvas:= twidget.create(nil);
 tmpcanvas.size:= makesize(round(reppages[0].pagewidth * fppmm),
   round(reppages[0].pageheight * fppmm));
 tmpcanvas.visible:=false;
 reportcanvas:= tmpcanvas.getcanvas;
 fcanceled:= false;
 application.beginwait;
 try
  if reo_waitdialog in foptions then begin
   application.waitdialog(nil,fdialogtext,fdialogcaption,@docancel,@doexec);
   if not canceled then begin
    application.terminatewait;
   end;
  end
  else begin
   exec;
  end;
 finally
  application.endwait;
 end;
end;

function trepaz.getreppages(index: integer): TraReportPage;
begin
 checkarrayindex(freppages,index);
 result:= freppages[index];
end;

procedure trepaz.setreppages(index: integer;
               const avalue: TraReportPage);
begin
 checkarrayindex(freppages,index);
 freppages[index].assign(avalue);
end;

function trepaz.reppagecount: integer;
begin
 result:= length(freppages);
end;

procedure trepaz.nextpage(const acanvas: tcanvas; const apage: TraReportPage);
begin
 setnewmetareportpage(apage);
end;

function trepaz.getcanceled: boolean;
begin
 result:= ((reo_waitdialog in foptions) and 
                            application.waitcanceled) or fcanceled;
end;

function trepaz.getfilename: filenamety;
begin
 result:= ffilename;
end;

procedure trepaz.loadfromfile(afilename: filenamety; var isloaded: boolean);
var
 binstream: tmemorystream;
 textstream,stream1: ttextstream;
 int1: integer;
 reader: treader;
 comp2: tcomponent; 
 listend: tvaluetype;
begin
 isloaded:=false;
 if afilename='' then begin
  exit;
 end;
 try
  textstream:= ttextstream.Create;
  for int1:=0 to high(freppages)-1 do begin
   freppages[int1].free;
  end;
  freppages:= nil;
  freeandnil(frootcomp);
  frootcomp:= tcomponent.create(nil);
  tcomponent1(frootcomp).SetDesigning(true{$ifndef FPC},false{$endif});
  lockfindglobalcomponent;
  try
   listend:= vanull;
   textstream.writeln('object frootcomp: tcomponent');
   stream1:= ttextstream.create(afilename,fm_read);
   textstream.copyfrom(stream1,stream1.size);
   stream1.free;
   textstream.writeln('end');
   textstream.Position:= 0;
   binstream:= tmemorystream.Create;
   try
    while textstream.position < textstream.Size do begin
     binstream.Position:= 0;
     objecttexttobinary(textstream,binstream);
     binstream.Write(listend,sizeof(listend));
     binstream.Position:= 0;
     reader:= treader.create(binstream,4096);
     try
      begingloballoading;
      reader.onfindcomponentclass:= {$ifdef FPC}@{$endif}findcomponentclass;
      {reader.oncreatecomponent:= {$ifdef FPC}@{$endif}createcomponent;
      reader.onreadstringproperty:= {$ifdef FPC}@{$endif}readstringproperty;
      reader.onreferencename:= {$ifdef FPC}@{$endif}onreferencename;}
      reader.readrootcomponent(frootcomp);
      tcomponent1(frootcomp).SetDesigning(false{$ifndef FPC},false{$endif});
      for int1:= frootcomp.componentcount - 1 downto 0 do begin
       comp2:= frootcomp.components[int1]; 
       if comp2.getparentcomponent = nil then begin
        addpage(TraReportPage(comp2));
        isloaded:=true;
       end;
      end;
      notifygloballoading;
     finally
      endgloballoading;
      reader.Free;
     end;
    end;
   finally
    binstream.Free;
   end;
  finally
   unlockfindglobalcomponent;
   textstream.Free;
  end;
 except
  on e: exception do begin
   e.message:= 'Error : ' +e.message;
   raise;
  end;
 end;
end;

procedure trepaz.dostatread(const reader: tstatreader);
begin
 with reader do begin
  fosprinter.rawmode:= readboolean('OSPrinter_RawMode',fosprinter.rawmode);
  fosprinter.raw_printercode:= trawprintercommand(readinteger('OSPrinter_PrinterCode',ord(fosprinter.raw_printercode)));
  fosprinter.raw_ejectonfinish:= readboolean('OSPriter_EjectOnFinished',fosprinter.raw_ejectonfinish);
  fosprinter.raw_continuespage:= readboolean('OSPrinter_ContinuesPage',fosprinter.raw_continuespage);
  fosprinter.raw_pixelperchar:= readinteger('OSPrinter_PixelPerChar',fosprinter.raw_pixelperchar);
  fosprinter.printername:= readstring('OSPrinter_PrinterName',fosprinter.printername);
  fosprinter.pa_paperwidth:= readreal('OSPrinter_PaperWidth',fosprinter.pa_paperwidth);
  fosprinter.pa_paperheight:= readreal('OSPrinter_PaperHeight',fosprinter.pa_paperheight);
  fosprinter.pa_orientation:= osprinter.pageorientationty(readinteger('OSPrinter_Orientation',
             ord(fosprinter.pa_orientation),0,ord(high(pageorientationty))));
  fosprinter.pa_marginleft:= readreal('OSPrinter_MarginLeft',fosprinter.pa_marginleft);
  fosprinter.pa_margintop:= readreal('OSPrinter_Margintop',fosprinter.pa_margintop);
  fosprinter.pa_marginright:= readreal('OSPrinter_MarginRight',fosprinter.pa_marginright);
  fosprinter.pa_marginbottom:= readreal('OSPrinter_MarginBottom',fosprinter.pa_marginbottom);
  fosprinter.canvas.colorspace:= colorspacety(readinteger('OSPrinter_ColorSpace',
                           ord(fosprinter.canvas.colorspace),0,ord(high(colorspacety))));
  fosprinter.raw_cutpaperonfinish:= readboolean('OSPrinter_CutPaperOnFinish',fosprinter.raw_cutpaperonfinish);
  fosprinter.raw_draweraction:= draweractionty(readinteger('OSPrinter_DrawerAction',ord(fosprinter.raw_draweraction)));
  fprintdestination:= printdestinationty(readinteger('PrintDestination',ord(fprintdestination)));
 end;
end;

procedure trepaz.dostatwrite(const writer: tstatwriter);
begin
 with writer do begin
  writeboolean('OSPrinter_RawMode',fosprinter.rawmode);
  writeinteger('OSPrinter_PrinterCode',ord(fosprinter.raw_printercode));
  writeboolean('OSPrinter_EjectOnFinished',fosprinter.raw_ejectonfinish);
  writeboolean('OSPrinter_ContinuesPage',fosprinter.raw_continuespage);
  writeinteger('OSPrinter_PixelPerChar',fosprinter.raw_pixelperchar);
  writestring('OSPrinter_PrinterName',fosprinter.printername);
  writereal('OSPrinter_PaperWidth',fosprinter.pa_paperwidth);
  writereal('OSPrinter_PaperHeight',fosprinter.pa_paperheight);
  writeinteger('OSPrinter_Orientation',ord(fosprinter.pa_orientation));
  writereal('OSPrinter_MarginLeft',fosprinter.pa_marginleft);
  writereal('OSPrinter_MarginTop',fosprinter.pa_margintop);
  writereal('OSPrinter_MarginRight',fosprinter.pa_marginright);
  writereal('OSPrinter_MarginBottom',fosprinter.pa_marginbottom);
  writeinteger('OSPrinter_ColorSpace',ord(fosprinter.canvas.colorspace));
  writeboolean('OSPrinter_CutPaperOnFinish',fosprinter.raw_cutpaperonfinish);
  writeinteger('OSPrinter_DrawerAction',ord(fosprinter.raw_draweraction));
  writeinteger('PrintDestination',ord(fprintdestination));
 end;
end;

procedure trepaz.statreading;
begin
 //dummy
end;

procedure trepaz.statread;
begin
 //dummy
end;

function trepaz.getstatvarname: msestring;
begin
 result:= fstatvarname;
end;

procedure trepaz.setstatfile(const avalue: tstatfile);
begin
 setstatfilevar(istatfile(self),avalue,fstatfile);
end;

procedure trepaz.converttoformattedtext(var atext: msestringarty; var aformat: printercodearty);
var
 fmetapages: tmetapages;
 int1,int2: integer;
 frow: longint;
 fpage: integer;
 x,y,z : integer;
 lentext,widthtext: integer;
 ftext: msestring;
 laststyle,currentstyle: fontstylesty;
 lastfont: rawfontty; 
 fadded: boolean;
 trimtext: msestring;
begin
 fmetapages:= getmetapages;
 atext:= nil;
 aformat:= nil;
 setlength(atext,1);
 setlength(aformat,1);
 fpage:= 0;
 z:= 0;
 y:= -1;
 frow:=0;
 aformat[frow].row:=-1;
 setlength(aformat[frow].col,1);
 aformat[frow].col[0].pos:= 0;
 aformat[frow].col[0].codetext:= fosprinter.esclist[esc_init]+fosprinter.esclist[esc_normal];
 laststyle:= [];
 lastfont:= rfNormal;
 while fpage<length(fmetapages) do begin
  for int1:=0 to length(fmetapages[fpage].textobjects)-1 do begin
   if z<>fmetapages[fpage].textobjects[int1].dest.pos.y then begin
    y:= y+1;
   end;
   z:= fmetapages[fpage].textobjects[int1].dest.pos.y;
   ftext:= fmetapages[fpage].textobjects[int1].text.text;
   lentext:= length(ftext);
   x:= ceil((fmetapages[fpage].textobjects[int1].dest.pos.x / fosprinter.raw_pixelperchar));
   widthtext:= ceil((fmetapages[fpage].textobjects[int1].dest.cx / fosprinter.raw_pixelperchar));
   fadded:= false;
   if fmetapages[fpage].textobjects[int1].rawfont<>lastfont then begin
    if aformat[frow].row<y then begin
     setlength(aformat,frow+2);
     inc(frow);
    end;
    setlength(aformat[frow].col,length(aformat[frow].col)+1);
    aformat[frow].col[length(aformat[frow].col)-1].pos:= x;
    lastfont:= fmetapages[fpage].textobjects[int1].rawfont;
    aformat[frow].col[length(aformat[frow].col)-1].codetext:= fosprinter.esclist[ord(lastfont)+1];
    fadded:= true;
   end;
   currentstyle:= [];
   if fmetapages[fpage].textobjects[int1].font.bold then currentstyle:= currentstyle + [fs_bold];
   if fmetapages[fpage].textobjects[int1].font.italic then currentstyle:= currentstyle + [fs_italic];
   if fmetapages[fpage].textobjects[int1].font.underline then currentstyle:= currentstyle + [fs_underline];
   if fmetapages[fpage].textobjects[int1].font.strikeout then currentstyle:= currentstyle + [fs_strikeout];
   if currentstyle<>laststyle then begin
    if not fadded then begin
     if aformat[frow].row<y then begin
      setlength(aformat,frow+2);
      inc(frow);
      aformat[frow].row:=y;
     end;
     setlength(aformat[frow].col,length(aformat[frow].col)+1);
     aformat[frow].col[length(aformat[frow].col)-1].pos:= x;
     aformat[frow].col[length(aformat[frow].col)-1].codetext:='';
     fadded:= true;
    end;
    //close style
    if (fs_strikeout in laststyle) and (not (fs_strikeout in currentstyle)) then begin
     aformat[frow].col[length(aformat[frow].col)-1].codetext:= aformat[frow].col[length(aformat[frow].col)-1].codetext + fosprinter.esclist[esc_not_strike];
    end;
    if (fs_underline in laststyle) and (not (fs_underline in currentstyle)) then begin
     aformat[frow].col[length(aformat[frow].col)-1].codetext:= aformat[frow].col[length(aformat[frow].col)-1].codetext + fosprinter.esclist[esc_not_underline];
    end;
    if (fs_italic in laststyle) and (not (fs_italic in currentstyle)) then begin
     aformat[frow].col[length(aformat[frow].col)-1].codetext:= aformat[frow].col[length(aformat[frow].col)-1].codetext + fosprinter.esclist[esc_not_italic];
    end;
    if (fs_bold in laststyle) and (not (fs_bold in currentstyle)) then begin
     aformat[frow].col[length(aformat[frow].col)-1].codetext:= aformat[frow].col[length(aformat[frow].col)-1].codetext + fosprinter.esclist[esc_not_bold];
    end;
    //open style
    if (fs_bold in currentstyle) and (not (fs_bold in laststyle)) then begin
     aformat[frow].col[length(aformat[frow].col)-1].codetext:= aformat[frow].col[length(aformat[frow].col)-1].codetext + fosprinter.esclist[esc_bold];
    end;
    if (fs_italic in currentstyle) and (not (fs_italic in laststyle)) then begin
     aformat[frow].col[length(aformat[frow].col)-1].codetext:= aformat[frow].col[length(aformat[frow].col)-1].codetext + fosprinter.esclist[esc_italic];
    end;
    if (fs_underline in currentstyle) and (not (fs_underline in laststyle)) then begin
     aformat[frow].col[length(aformat[frow].col)-1].codetext:= aformat[frow].col[length(aformat[frow].col)-1].codetext + fosprinter.esclist[esc_underline];
    end;
    if (fs_strikeout in currentstyle) and (not (fs_strikeout in laststyle)) then begin
     aformat[frow].col[length(aformat[frow].col)-1].codetext:= aformat[frow].col[length(aformat[frow].col)-1].codetext + fosprinter.esclist[esc_strike];
    end;
    laststyle:= currentstyle;
   end;
   if y>=length(atext) then begin
    setlength(atext,y+1);
   end;
   if x>length(atext[y]) then begin
    if atext[y]='' then begin
     atext[y]:= charstring(' ',x+widthtext);
    end else begin
     atext[y]:= atext[y] + charstring(' ',x+widthtext);
    end;
   end;
   trimtext:= copy(ftext,1,widthtext);
   if length(trimtext)<widthtext then begin
    if tf_xcentered in fmetapages[fpage].textobjects[int1].flags then begin
     int2:= (widthtext-length(trimtext)) div 2;
     trimtext:= charstring(' ',int2) + trimtext + charstring(' ',int2);
     trimtext:= copy(trimtext,1,widthtext);
    end else if tf_right in fmetapages[fpage].textobjects[int1].flags then begin
     int2:= widthtext-length(trimtext);
     trimtext:= charstring(' ',int2) + trimtext;
    end;
   end;
   atext[y]:=copy(atext[y],1,x) + trimtext + copy(atext[y],x+widthtext,length(atext[y])-x+widthtext);
  end;
  if fosprinter.raw_continuespage then begin
   aformat[frow].col[length(aformat[frow].col)-1].codetext:= aformat[frow].col[length(aformat[frow].col)-1].codetext + 
    fosprinter.esclist[esc_form_feed];   
  end;
  inc(fpage);
 end;
 if fosprinter.raw_ejectonfinish then begin
  setlength(aformat,length(aformat)+1);
  inc(frow);
  aformat[frow].row:= 2147483647;
  setlength(aformat[frow].col,1);
  aformat[frow].col[0].pos:= 0;
  aformat[frow].col[0].codetext:= fosprinter.esclist[esc_form_feed];   
 end;
end;

procedure trepaz.setcanceled(const avalue: boolean);
begin
 fcanceled:= fcanceled or avalue;
end;

function trepaz.getrunning: boolean;
begin
 result:= rs_running in fstate;
end;

procedure trepaz.setactivepage(const avalue: integer);
begin
 checkarrayindex(freppages,avalue);
 include(fstate,rs_activepageset);
 factivepage:= avalue;
end;

procedure trepaz.finish;
begin
 include(fstate,rs_finish);
end;

procedure trepaz.doprogress;
begin
 if canevent(tmethod(fonprogress)) then begin
  application.lock;
  try
   fonprogress(self);
  finally
   application.unlock;
  end;
 end;  
 if (reo_waitdialog in foptions) and not canceled then begin
  application.processmessages;
 end;
end;

procedure trepaz.doonreportfinished;
begin
 tmpcanvas.free;
 isreportfinished:= true;
 if fprintdestination=preview then begin
  reportpreview;
 end else if fprintdestination=printer then begin
  reportprint(false);
 end else if fprintdestination=postscript then begin
  reportpostscript;
 end else if fprintdestination=pdf then begin
  reportpdf;
 end;
end;

procedure trepaz.restart;
var
 int1: integer;
begin
 include(fstate,rs_restart);
 for int1:= 0 to high(freppages) do begin
  freppages[int1].restart;
 end;
 activepage:= 0;
end;

procedure trepaz.recordchanged;
begin
 freppages[factivepage].recordchanged;
end;

procedure trepaz.dopagebeforerender(const sender: TraReportPage;
               var empty: boolean);
begin
 if canevent(tmethod(fonpagebeforerender)) then begin
  application.lock;
  try
   fonpagebeforerender(sender,empty);
  finally
   application.unlock;
  end;
 end;
end;

procedure trepaz.dopageafterpaint(const sender: TraReportPage;
               const acanvas: tcanvas);
begin
 if canevent(tmethod(fonpageafterpaint)) then begin
  application.lock;
  try
   fonpageafterpaint(sender,acanvas);
  finally
   application.unlock;
  end;
 end;
end;

procedure trepaz.dofirstpage(const apage:TraReportPage);
begin
 setnewmetareportpage(apage);
 if canevent(tmethod(fonfirstpage)) then begin
  application.lock;
  try
   fonfirstpage(apage);
  finally
   application.unlock;
  end;
 end;
end;

procedure trepaz.doafterlastpage(const apage:TraReportPage);
begin
 if canevent(tmethod(fonafterlastpage)) then begin
  application.lock;
  try
   fonafterlastpage(apage);
  finally
   application.unlock;
  end;
 end;
end;

procedure trepaz.dopagepaint(const sender: TraReportPage;
               const acanvas: tcanvas);
begin
 if canevent(tmethod(fonpagepaint)) then begin
  application.lock;
  try
   fonpagepaint(sender,acanvas);
  finally
   application.unlock;
  end;
 end;
end;

{ TraCustomValueDisplay }

constructor TraCustomValueDisplay.create(aowner: tcomponent);
begin
 ftextflags:= defaultrepvaluedisptextflags;
 foptionsscale:= defaultrepvaluedispoptionsscale;
 inherited;
 foptions:= defaultrepvaluedispoptions;
 fanchors:= [an_left,an_top];
end;

procedure TraCustomValueDisplay.setvalue(const avalue: msestring);
begin
 if fvalue <> avalue then begin
  fvalue:= avalue;
  minclientsizechanged;
 end;
end;

procedure TraCustomValueDisplay.dopaint(const acanvas: tcanvas);
var
 finfo: drawtextinfoty;
begin
 inherited;
 if not rendering then begin
  drawtext(acanvas,getdisptext,innerclientrect,ftextflags,font);
 end else begin 
  finfo.text.text:= getdisptext;
  finfo.dest:= innerclientrect;
  finfo.clip:= innerclientrect;
  finfo.flags:= ftextflags;
  finfo.font:= font;
  finfo.tabulators:= nil;
  finfo.res:= innerclientrect;
  addtexttoreport(createtextinfo(finfo,rawfont,addpoint(acanvas.origin,clientrect.pos)));
 end;
end;

procedure TraCustomValueDisplay.dogettext(var atext: msestring);
begin
 //
end;

function TraCustomValueDisplay.getdisptext: msestring;
begin
 result:= fvalue;
 if (csdesigning in componentstate) and (result = '') then begin
  result:= name;
 end;
 if rendering then begin
  dogettext(result);
 end;
end;

procedure TraCustomValueDisplay.setformat(const avalue: msestring);
begin
 if fformat <> avalue then begin
  fformat:= avalue;
  minclientsizechanged;
 end;
// invalidate;
end;

procedure TraCustomValueDisplay.settextflags(const avalue: textflagsty);
begin
 if ftextflags <> avalue then begin
  ftextflags:= avalue;
  minclientsizechanged;
 end;
end;

function TraCustomValueDisplay.calcminscrollsize: sizety;
var
 size1: sizety;
begin
 result:= inherited calcminscrollsize;
 size1:= textrect(getcanvas,getdisptext,innerclientrect,ftextflags,font).size;
 if fframe <> nil then begin
  with fframe do begin
   size1.cx:= size1.cx + framei_left + framei_right;
   size1.cy:= size1.cy + framei_top + framei_bottom;
  end;
 end;
 if size1.cx > result.cx then begin
  result.cx:= size1.cx;
 end;
 if size1.cy > result.cy then begin
  result.cy:= size1.cy;
 end;
end;

procedure TraCustomValueDisplay.dobeforerender(var empty: boolean);
begin
 inherited;
 minclientsizechanged;
end;

procedure TraCustomValueDisplay.render(const acanvas: tcanvas;
               var empty: boolean);
begin
 inherited;
// empty:= true;
end;

{ TraPageNumber }

constructor TraPageNumber.create(aowner: tcomponent);
begin
 foffset:= 1;
 inherited;
end;

function TraPageNumber.getdisptext: msestring;
var
 int1,int2: integer;
 mstr1: msestring; 
 squote,dquote: boolean;
begin
 if fparentintf <> nil then  begin
  squote:= false;
  dquote:= false;
  mstr1:= fformat;
  for int1:= 1 to length(fformat) do begin
   case fformat[int1] of
    '''': begin
     if not dquote then begin
      squote:= not squote;
     end;
    end;
    '"': begin
     if not squote then begin
      dquote:= not dquote;
     end;
    end;
    '1': begin
     if not (squote or dquote) then begin

      if bo_LocalValue in foptions then begin
       int2:= fparentintf.getlastpagepagecount;
      end
      else begin
       int2:= fparentintf.getlastreppagecount;
      end;
      mstr1:= copy(fformat,1,int1-1) + '"' +inttostr(int2) +'"' +
                              copy(fformat,int1+1,bigint);
     end;
    end;
   end;
  end;
  if bo_LocalValue in foptions then begin
   int1:= fparentintf.pagepagenum;
  end
  else begin
   int1:= fparentintf.reppagenum
  end;
  result:= formatfloatmse(int1+foffset,mstr1);
  dogettext(result);
 end
 else begin
  result:= inherited getdisptext;
 end;
end;

procedure TraPageNumber.setoffset(const avalue: integer);
begin
 if foffset <> avalue then begin
  foffset:= avalue;
  minclientsizechanged;
 end;
end;

procedure TraPageNumber.initpage;
begin
 inherited;
 minclientsizechanged;
end;

procedure TraPageNumber.parentchanged;
begin
 inherited;
 minclientsizechanged;
end;

{ TraDatePrint }

function TraDatePrint.getdisptext: msestring;
var
 ti1: tdatetime;
 str1: string;
begin
 if fparentintf <> nil then begin
  if bo_LocalValue in foptions then begin
   ti1:= fparentintf.pageprintstarttime;
  end
  else begin
   ti1:= fparentintf.repprintstarttime;
  end;
  if fformat = '' then begin
   str1:= 'c';
  end
  else begin
   str1:= fformat;
  end;
  result:= formatdatetime(str1,ti1);
  dogettext(result);
 end
 else begin
  result:= inherited getdisptext;
 end;
end;

procedure TraDatePrint.initpage;
begin
 inherited;
 minclientsizechanged;
end;

procedure TraDatePrint.parentchanged;
begin
 inherited;
 minclientsizechanged;
end;

{ TraStandardFont }

constructor TraStandardFont.create;
begin
 inherited;
 finfo.color:= defaultrepfontcolor;
 finfo.name:= defaultrepfontname;
end;

procedure TraStandardFont.setname(const avalue: string);
begin
 if avalue = '' then begin
  inherited setname(defaultrepfontname);
 end
 else begin
  inherited;
 end;
end;

{ TraFont }

constructor TraFont.create;
begin
 inherited;
 finfo.color:= defaultrepfontcolor;
 finfo.name:= defaultrepfontname;
end;

procedure TraFont.setname(const avalue: string);
begin
 if avalue = '' then begin
  inherited setname(defaultrepfontname);
 end
 else begin
  inherited;
 end;
end;

{ TraCustomBandArea }

procedure TraCustomBandArea.init;
begin
 factiveband:= 0;
 inherited;
end;

procedure TraCustomBandArea.initband;
begin
 factiveband:= 0;
 inherited;
end;

procedure TraCustomBandArea.initareapage;
begin
 facty:= innerclientwidgetpos.y + bounds_y;
 fbandnum:= 0;
 inherited;
end;

function TraCustomBandArea.render(const acanvas: tcanvas): boolean;
var                     //true if finished
 bo1,bo2: boolean;
 int1,int2: integer;
 isfinished: boolean;
begin
 result:= true;
 if not (bas_inited in fstate) then begin
  init;
  dofirstarea;
 end;
 try
  if factiveband <= high(fareabands) then begin
   updatevisible;
   dobeforerender;
   isfinished:= true;
   while (factiveband <= high(fareabands)) and not areafull do begin
    exclude(fstate,bas_bandstarted);
    while (factiveband <= high(fareabands)) and 
                            not fareabands[factiveband].visible do begin
     inc(factiveband);
    end;
    if factiveband <= high(fareabands) then begin
     exclude(fstate,bas_activebandchanged);
     with fareabands[factiveband] do begin
      if not (bas_finished in self.fstate) then begin
       bo2:= odd(fparentintf.reppagenum);
       bo2:= bo2 and (bo_OddPage in foptions) or 
             not bo2 and (bo_EvenPage in foptions); //has data
      end
      else begin
       bo2:= false;
      end;
      bo1:= ((rbs_showed in fstate) or not(bo_Once in foptions)) and
            ((rbs_pageshowed in fstate) or not bo2);   //empty    
      render(acanvas,bo1);
      if bas_activebandchanged in self.fstate then begin
       updatevisible;
       continue;
      end;
      if not bo2 then begin
       isfinished:= bo1;
      end;
      bo1:= bo1 or bo2;
      result:= result and bo1;
      if bo1 then begin //empty
       if fnextbandifempty <> nil then begin
        for int1:= 0 to high(fareabands) do begin
         if fareabands[int1] = fnextbandifempty then begin
          for int2:= int1 to factiveband do begin
           exclude(fareabands[int2].fstate,rbs_showed);
          end;
          factiveband:= int1-1;
          break;
         end;         
        end;
       end;
       repeat
        inc(factiveband);
       until (factiveband > high(fareabands)) or fareabands[factiveband].visible;
      end
      else begin
       if not (bas_areafull in self.fstate) and (fnextband <> nil) and 
                  not (fdatalink.active and fdatalink.dataset.eof) then begin
        for int1:= 0 to high(fareabands) do begin
         if fareabands[int1] = fnextband then begin
          for int2:= int1 to factiveband do begin
           exclude(fareabands[int2].fstate,rbs_showed);
          end;
          factiveband:= int1;
          while (factiveband <= high(fareabands)) and 
                          not fareabands[factiveband].visible do begin
           inc(factiveband);
          end;
          break;
         end;         
        end;
       end;
      end;
     end;
    end;
   end;
   if isfinished then begin
    include(fstate,bas_finished);
   end;
  end;
 finally
  if result then begin
   exclude(fstate,bas_inited);
  end;
 end;
 if bas_backgroundrendered in fstate then begin
  doafterpaint1(acanvas);
 end;
end;

function TraCustomBandArea.beginband(const acanvas: tcanvas;
                              const sender: TraCustomRecordBand): boolean;
                    //true if area full
var
 bo1: boolean;
 pt1: pointty;
begin
 result:= bas_areafull in fstate;
 if not result then begin
  fsaveindex:= acanvas.save;
  bo1:= (bas_backgroundrendered in fstate);
  if not bo1 then begin
   include(fstate,bas_backgroundrendered);
   renderbackground(acanvas);
   initareapage;
  end;
  if frecordband <> nil then begin
   pt1.x:= sender.bounds_x + forigin.x;
   pt1.y:= forigin.y + facty - sender.bounds_y;
  end
  else begin
   pt1:= makepoint(sender.bounds_x+bounds_x,facty);
  end;
  acanvas.origin:= pt1;
  factybefore:= facty;
  inc(facty,sender.bandheight);
  include(fstate,bas_bandstarted);
  result:= bo1 and checkareafull(facty);
                 //print minimum one band
 end;
 if result then begin
  include(fstate,bas_areafull);
  initareapage;
 end;
end;
    
procedure TraCustomBandArea.endband(const acanvas: tcanvas; 
                      const sender: TraCustomRecordBand);
begin
 acanvas.restore(fsaveindex); 
 include(fstate,bas_notfirstband);
 exclude(fstate,bas_top);
 sender.fstate:= sender.fstate + [rbs_showed,rbs_pageshowed];
 inc(fbandnum);
end;

function TraCustomBandArea.getacty: integer;
begin
 if (bas_bandstarted in fstate) then begin
  result:= factybefore;
 end
 else begin
  result:= facty;
 end;
 result:= result - (innerclientwidgetpos.y + bounds_y);
end;

function TraCustomBandArea.remainingheight: integer;
begin
 result:= facty - (bounds_y + bounds_cy);
 if fframe <> nil then begin
  result:= result - fframe.innerframe.bottom;
 end;
end;

procedure TraCustomBandArea.restart;
begin
 factiveband:= 0;
 include(fstate,bas_activebandchanged);
 inherited;
end;

function TraCustomBandArea.isfirstband: boolean;
begin
 result:= (factiveband <= high(fareabands)) and 
                    not (rbs_pageshowed in fareabands[factiveband].fstate);
// result:= not (bas_notfirstband in fstate);
end;

function TraCustomBandArea.islastband(const addheight: integer = 0): boolean;
var
 int1: integer;
begin
 result:= fstate * [bas_lastband{,bas_lastchecking}] <> [];
 if not result and (factiveband <= high(fareabands)) then begin
  with fareabands[factiveband] do begin
   int1:= facty + addheight + lastbandheight;
   if not (bas_bandstarted in self.fstate) then begin
    int1:= int1 + bounds_cy;
   end;
  end;
  result:= checkareafull(int1);
 end;
end;

{ TraCustomTileArea }

constructor TraCustomTileArea.create(aowner: tcomponent);
begin
 fcolcount:= 2;
 frowcount:= 2;
 fLineVertical:= defaulttablineinfo;
 fLineHorizontal:= defaulttablineinfo;
 fLineLeft:= defaulttablineinfo;
 fLineTop:= defaulttablineinfo;
 fLineRight:= defaulttablineinfo;
 fLineBottom:= defaulttablineinfo;
 inherited;
end;

function TraCustomTileArea.cellwidthmm: real;
begin
 result:= innerclientsize.cx / (fcolcount);
end;

function TraCustomTileArea.cellheightmm: real;
begin
 result:= innerclientsize.cy / (frowcount);
end;

function TraCustomTileArea.render(const acanvas: tcanvas): boolean;
var                     //true if finished
 bo1,bo2: boolean;
 int1,int2: integer;
 isfinished: boolean;
 col,row: integer;
 cellwidthmm1,cellheightmm1: real;
 y: real;
begin
 result:= true;
 if not (bas_inited in fstate) then begin
  init;
  dofirstarea;
 end;
 col:= 0;
 row:= 0;
 cellwidthmm1:= cellwidthmm;
 cellheightmm1:= cellheightmm;
 try
  updatevisible;
  dobeforerender;
  isfinished:= true;
  repeat
   fcellorigin.x:= round(col*cellwidthmm1);
   fcellorigin.y:= round(row*cellheightmm1);
   isfinished:= true;
   for int1:= 0 to high(fareabands) do begin
    with fareabands[int1] do begin
     if visible then begin
      if not (bas_finished in self.fstate) then begin
       bo2:= odd(fparentintf.reppagenum);
       bo2:= bo2 and (bo_OddPage in foptions) or 
             not bo2 and (bo_EvenPage in foptions); //has data
      end
      else begin
       bo2:= false; //has no autodata
      end;
      bo1:= ((rbs_showed in fstate) or not(bo_Once in foptions)) and
            ((rbs_pageshowed in fstate) or not bo2);   //empty    
      render(acanvas,bo1);
      if not bo2 then begin
       isfinished:= isfinished and bo1;
      end;
      bo1:= bo1 or bo2;
      result:= result and bo1;
     end;
    end;
   end;
   if isfinished then begin
    include(fstate,bas_finished);
   end;
   if tao_vertical in foptions then begin
    inc(row);
    if row >= frowcount then begin
     row:= 0;
     inc(col);
     if col >= fcolcount then begin
      break;
     end;
    end;
   end
   else begin
    inc(col);
    if col >= fcolcount then begin
     col:= 0;
     inc(row);
     if row >= frowcount then begin
      break;
     end;
    end;
   end;
  until isfinished;
 finally
  if result then begin
   exclude(fstate,bas_inited);
  end;
 end;
 if bas_backgroundrendered in fstate then begin
  acanvas.save;
  try
   if frecordband <> nil then begin
    acanvas.move(forigin);
   end
   else begin
    acanvas.move(pos);
   end;
   drawlines(acanvas);
   doafterpaint1(acanvas);
  finally
   acanvas.restore;
  end;
 end;
end;

procedure TraCustomTileArea.setcolcount(const avalue: integer);
begin
 fcolcount:= avalue;
 if avalue <= 0 then begin
  fcolcount:= 1;
 end;
 invalidate;
end;

procedure TraCustomTileArea.setrowcount(const avalue: integer);
begin
 frowcount:= avalue;
 if avalue <= 0 then begin
  frowcount:= 1;
 end;
 invalidate;
end;

function TraCustomTileArea.beginband(const acanvas: tcanvas;
               const sender: TraCustomRecordBand): boolean;
var
 bo1: boolean;
 pt1: pointty;
begin
 fsaveindex:= acanvas.save;
 bo1:= (bas_backgroundrendered in fstate);
 if not bo1 then begin
  include(fstate,bas_backgroundrendered);
  renderbackground(acanvas);
  initareapage;
 end;
 pt1:= sender.pos;
 if frecordband <> nil then begin
  addpoint1(pt1,forigin);
 end
 else begin
  addpoint1(pt1,pos);
 end;
 addpoint1(pt1,fcellorigin);
 acanvas.origin:= pt1;
 include(fstate,bas_bandstarted);
 result:= false;
end;

procedure TraCustomTileArea.endband(const acanvas: tcanvas;
               const sender: TraCustomRecordBand);
begin
 acanvas.restore(fsaveindex); 
 include(fstate,bas_notfirstband);
 exclude(fstate,bas_top);
 sender.fstate:= sender.fstate + [rbs_showed,rbs_pageshowed];
// inc(fbandnum);
end;

procedure TraCustomTileArea.setLineVertical_Widthmm(const avalue: real);
begin
 if avalue <> fLineVertical.widthmm then begin
  fLineVertical.widthmm:= avalue;
  invalidate;
 end;
end;

procedure TraCustomTileArea.setLineVertical_Color(const avalue: colorty);
begin
 if avalue <> fLineVertical.color then begin
  fLineVertical.color:= avalue;
  invalidate;
 end;
end;

procedure TraCustomTileArea.setLineVertical_ColorGap(const avalue: colorty);
begin
 if avalue <> fLineVertical.colorgap then begin
  fLineVertical.colorgap:= avalue;
  invalidate;
 end;
end;

procedure TraCustomTileArea.setLineVertical_CapStyle(const avalue: capstylety);
begin
 if avalue <> fLineVertical.capstyle then begin
  fLineVertical.capstyle:= avalue;
  invalidate;
 end;
end;

procedure TraCustomTileArea.setLineVertical_Dashes(const avalue: string);
begin
 if avalue <> fLineVertical.dashes then begin
  fLineVertical.dashes:= checkdashes(avalue);
  invalidate;
 end;
end;

procedure TraCustomTileArea.setLineHorizontal_Widthmm(const avalue: real);
begin
 if avalue <> fLineHorizontal.widthmm then begin
  fLineHorizontal.widthmm:= avalue;
  invalidate;
 end;
end;

procedure TraCustomTileArea.setLineHorizontal_Color(const avalue: colorty);
begin
 if avalue <> fLineHorizontal.color then begin
  fLineHorizontal.color:= avalue;
  invalidate;
 end;
end;

procedure TraCustomTileArea.setLineHorizontal_ColorGap(const avalue: colorty);
begin
 if avalue <> fLineHorizontal.colorgap then begin
  fLineHorizontal.colorgap:= avalue;
  invalidate;
 end;
end;

procedure TraCustomTileArea.setLineHorizontal_CapStyle(const avalue: capstylety);
begin
 if avalue <> fLineHorizontal.capstyle then begin
  fLineHorizontal.capstyle:= avalue;
  invalidate;
 end;
end;

procedure TraCustomTileArea.setLineHorizontal_Dashes(const avalue: string);
begin
 if avalue <> fLineHorizontal.dashes then begin
  fLineHorizontal.dashes:= checkdashes(avalue);
  invalidate;
 end;
end;

procedure TraCustomTileArea.setLineLeft_Widthmm(const avalue: real);
begin
 if avalue <> fLineLeft.widthmm then begin
  fLineLeft.widthmm:= avalue;
  invalidate;
 end;
end;

procedure TraCustomTileArea.setLineLeft_Color(const avalue: colorty);
begin
 if avalue <> fLineLeft.color then begin
  fLineLeft.color:= avalue;
  invalidate;
 end;
end;

procedure TraCustomTileArea.setLineLeft_ColorGap(const avalue: colorty);
begin
 if avalue <> fLineLeft.colorgap then begin
  fLineLeft.colorgap:= avalue;
  invalidate;
 end;
end;

procedure TraCustomTileArea.setLineLeft_CapStyle(const avalue: capstylety);
begin
 if avalue <> fLineLeft.capstyle then begin
  fLineLeft.capstyle:= avalue;
  invalidate;
 end;
end;

procedure TraCustomTileArea.setLineLeft_Dashes(const avalue: string);
begin
 if avalue <> fLineLeft.dashes then begin
  fLineLeft.dashes:= checkdashes(avalue);
  invalidate;
 end;
end;

procedure TraCustomTileArea.setLineLeft_Dist(const avalue: integer);
begin
 if avalue <> fLineLeft.dist then begin
  fLineLeft.dist:= avalue;
  invalidate;
 end;
end;

procedure TraCustomTileArea.setLineTop_Widthmm(const avalue: real);
begin
 if avalue <> fLineTop.widthmm then begin
  fLineTop.widthmm:= avalue;
  invalidate;
 end;
end;

procedure TraCustomTileArea.setLineTop_Color(const avalue: colorty);
begin
 if avalue <> fLineTop.color then begin
  fLineTop.color:= avalue;
  invalidate;
 end;
end;

procedure TraCustomTileArea.setLineTop_ColorGap(const avalue: colorty);
begin
 if avalue <> fLineTop.colorgap then begin
  fLineTop.colorgap:= avalue;
  invalidate;
 end;
end;

procedure TraCustomTileArea.setLineTop_CapStyle(const avalue: capstylety);
begin
 if avalue <> fLineTop.capstyle then begin
  fLineTop.capstyle:= avalue;
  invalidate;
 end;
end;

procedure TraCustomTileArea.setLineTop_Dashes(const avalue: string);
begin
 if avalue <> fLineTop.dashes then begin
  fLineTop.dashes:= checkdashes(avalue);
  invalidate;
 end;
end;

procedure TraCustomTileArea.setLineTop_Dist(const avalue: integer);
begin
 if avalue <> fLineTop.dist then begin
  fLineTop.dist:= avalue;
  invalidate;
 end;
end;

procedure TraCustomTileArea.setLineRight_Widthmm(const avalue: real);
begin
 if avalue <> fLineRight.widthmm then begin
  fLineRight.widthmm:= avalue;
  invalidate;
 end;
end;

procedure TraCustomTileArea.setLineRight_Color(const avalue: colorty);
begin
 if avalue <> fLineRight.color then begin
  fLineRight.color:= avalue;
  invalidate;
 end;
end;

procedure TraCustomTileArea.setLineRight_ColorGap(const avalue: colorty);
begin
 if avalue <> fLineRight.colorgap then begin
  fLineRight.colorgap:= avalue;
  invalidate;
 end;
end;

procedure TraCustomTileArea.setLineRight_CapStyle(const avalue: capstylety);
begin
 if avalue <> fLineRight.capstyle then begin
  fLineRight.capstyle:= avalue;
  invalidate;
 end;
end;

procedure TraCustomTileArea.setLineRight_Dashes(const avalue: string);
begin
 if avalue <> fLineRight.dashes then begin
  fLineRight.dashes:= checkdashes(avalue);
  invalidate;
 end;
end;

procedure TraCustomTileArea.setLineRight_Dist(const avalue: integer);
begin
 if avalue <> fLineRight.dist then begin
  fLineRight.dist:= avalue;
  invalidate;
 end;
end;

procedure TraCustomTileArea.setLineBottom_Widthmm(const avalue: real);
begin
 if avalue <> fLineBottom.widthmm then begin
  fLineBottom.widthmm:= avalue;
  invalidate;
 end;
end;

procedure TraCustomTileArea.setLineBottom_Color(const avalue: colorty);
begin
 if avalue <> fLineBottom.color then begin
  fLineBottom.color:= avalue;
  invalidate;
 end;
end;

procedure TraCustomTileArea.setLineBottom_ColorGap(const avalue: colorty);
begin
 if avalue <> fLineBottom.colorgap then begin
  fLineBottom.colorgap:= avalue;
  invalidate;
 end;
end;

procedure TraCustomTileArea.setLineBottom_CapStyle(const avalue: capstylety);
begin
 if avalue <> fLineBottom.capstyle then begin
  fLineBottom.capstyle:= avalue;
  invalidate;
 end;
end;

procedure TraCustomTileArea.setLineBottom_Dashes(const avalue: string);
begin
 if avalue <> fLineBottom.dashes then begin
  fLineBottom.dashes:= checkdashes(avalue);
  invalidate;
 end;
end;

procedure TraCustomTileArea.setLineBottom_Dist(const avalue: integer);
begin
 if avalue <> fLineBottom.dist then begin
  fLineBottom.dist:= avalue;
  invalidate;
 end;
end;

procedure TraCustomTileArea.drawline(const acanvas: tcanvas; const ainfo: tablineinfoty;
                  const start,stop: pointty);
begin
 if ainfo.widthmm > 0 then begin
  with acanvas do begin
   linewidthmm:= ainfo.widthmm;
   colorbackground:= ainfo.colorgap;
   capstyle:= ainfo.capstyle;
   dashes:= ainfo.dashes;
   if not rendering then begin
    acanvas.drawline(start,stop,ainfo.color);
   end else begin
    addlinetoreport(createlineinfo(acanvas,start,stop,ainfo.color));
   end;
  end;
 end
 else begin
  if csdesigning in componentstate then begin
   with acanvas do begin
    linewidth:= 0;
    dashes:= #2#3;
    capstyle:= cs_butt;
    acanvas.drawline(start,stop,cl_black);
   end;
  end;
 end;
end;

procedure TraCustomTileArea.drawlines(const acanvas: tcanvas);
var
 rect1: rectty;
 pt1,pt2: pointty;
 int1: integer; 
 cellh,cellv: real; 
begin
 acanvas.save;
 acanvas.addcliprect(inflaterect(widgetsizerect,1000));
 rect1:= innerwidgetrect;
 with rect1 do begin
  cellh:= cellwidthmm;
  cellv:= cellheightmm;

  pt1.y:= y - fLineTop.dist;
  pt2.y:= y + cy + fLineBottom.dist;
  for int1:= 1 to fcolcount - 1 do begin
   pt1.x:= x + round(int1 * cellh);
   pt2.x:= pt1.x;
   drawline(acanvas,fLineVertical,pt1,pt2);
  end;

  pt1.x:= x - fLineLeft.dist;
  pt2.x:= x + cx + fLineRight.dist;
  for int1:= 1 to frowcount - 1 do begin
   pt1.y:= y + round(int1 * cellv);
   pt2.y:= pt1.y;
   drawline(acanvas,fLineHorizontal,pt1,pt2);
  end;
  
  pt1.y:= y - fLineTop.dist;  
  pt2.y:= pt1.y;
  drawline(acanvas,fLineTop,pt1,pt2);
  pt1.y:= y + cy + fLineBottom.dist;
  pt2.y:= pt1.y;
  drawline(acanvas,fLineBottom,pt1,pt2);

  pt1.y:= y - fLineTop.dist;
  pt2.y:= y + cy + fLineBottom.dist;
  pt1.x:= x - fLineLeft.dist;  
  pt2.x:= pt1.x;
  drawline(acanvas,fLineLeft,pt1,pt2);
  pt1.x:= x + cx + fLineRight.dist;
  pt2.x:= pt1.x;
  drawline(acanvas,fLineRight,pt1,pt2);
 end;

 acanvas.restore;
end;

procedure TraCustomTileArea.dopaintoverlay(const canvas: tcanvas);
begin
 if not rendering then begin
  drawlines(canvas);
 end;
 inherited;
end;
finalization
 if frepazevaluator<>nil then frepazevaluator.free;
end.
