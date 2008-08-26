unit main;
{$ifdef FPC}{$mode objfpc}{$h+}{$endif}
interface
uses
 mseglob,mseguiglob,mseapplication,msestat,msemenus,msegui,msegraphics,
 msegraphutils,mseevent,mseclasses,mseforms,msedataedits,mseedit,msegrids,
 msestrings,msetypes,msewidgetgrid,msedatanodes,mselistbrowser,msestatfile;

type
 tmainfo = class(tmseform)
   grid: twidgetgrid;
   treeedit: ttreeitemedit;
   stredit: tstringedit;
   intedit: tintegeredit;
   procedure initdata(const sender: TObject);
   procedure updaterowvalues(const sender: TObject; const aindex: Integer;
                   const aitem: tlistitem);
   procedure strsetvalue(const sender: TObject; var avalue: msestring;
                   var accept: Boolean);
   procedure intsetvalue(const sender: TObject; var avalue: Integer;
                   var accept: Boolean);
 end;
 
 tmynode = class(ttreelistedititem)
  private
   fint: integer;
   fstr: msestring;
  public
   property int: integer read fint write fint;
   property str: msestring read fstr write fstr;
 end;
 
var
 mainfo: tmainfo;
implementation
uses
 main_mfm;
 
{tmainfo }

procedure tmainfo.initdata(const sender: TObject);
begin
 treeedit.itemlist.add(tmynode.create); //root nodes
 treeedit.itemlist.add(tmynode.create); 
 with tmynode(treeedit[0]) do begin
  caption:= 'AAAAA';
  add(3,tmynode);
  items[0].caption:= 'A0';
  items[1].caption:= 'A1';
  items[2].caption:= 'A2';
 end;
 with tmynode(treeedit[1]) do begin
  caption:= 'BBBBBBBBBB';
  add(5,tmynode);
  items[0].caption:= 'BB0';
  items[1].caption:= 'B1';
  with tmynode(items[1]) do begin
   add(5,tmynode);
   items[0].caption:= 'B1a';
   items[1].caption:= 'B1b';
   items[2].caption:= 'B1c';
   items[3].caption:= 'B1d';
   items[4].caption:= 'B1e';
  end;
  items[2].caption:= 'BBBBBB2';
  items[3].caption:= 'B3';
  items[4].caption:= 'B4';
 end;
end;

procedure tmainfo.updaterowvalues(const sender: TObject; const aindex: Integer;
               const aitem: tlistitem);
begin
 with tmynode(aitem) do begin
  stredit[aindex]:= str;
  intedit[aindex]:= int;
 end;
end;

procedure tmainfo.strsetvalue(const sender: TObject; var avalue: msestring;
               var accept: Boolean);
begin
 with tmynode(treeedit.item) do begin
  str:= avalue;
 end;
end;

procedure tmainfo.intsetvalue(const sender: TObject; var avalue: Integer;
               var accept: Boolean);
begin
 with tmynode(treeedit.item) do begin
  int:= avalue;
 end;
end;

end.
