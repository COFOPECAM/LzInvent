unit u_frmcatsub;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, db, Forms, Controls, Graphics, Dialogs, ComCtrls, StdCtrls,
  DBCtrls, DBGrids, ZDataset;

type

  { TFrmCategorias }

  TFrmCategorias = class(TForm)
    DSAddSub: TDataSource;
    DBCheckBox2: TDBCheckBox;
    TxtSub: TDBEdit;
    DBGrid2: TDBGrid;
    CbCategorias: TDBLookupComboBox;
    NavBtnsSub: TDBNavigator;
    DSCat: TDataSource;
    DSSub: TDataSource;
    DBCheckBox1: TDBCheckBox;
    DBEdit1: TDBEdit;
    DBGrid1: TDBGrid;
    NavBtns: TDBNavigator;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    ZQCat: TZQuery;
    ZQCatid: TLongintField;
    ZQCatname: TStringField;
    ZQCatstatus: TSmallintField;
    ZQSub: TZQuery;
    ZQAddSub: TZQuery;
    procedure CbCategoriasChange(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure NavBtnsSubClick(Sender: TObject; Button: TDBNavButtonType);
  private

  public

  end;

var
  FrmCategorias: TFrmCategorias;

implementation

{$R *.lfm}

{ TFrmCategorias }

procedure TFrmCategorias.FormShow(Sender: TObject);
begin
  ZQCat.Open;
end;

procedure TFrmCategorias.NavBtnsSubClick(Sender: TObject;
  Button: TDBNavButtonType);
begin
  if Button = nbPost then
  begin
    ZQSub.Close;
    ZQSub.Open;
  end;
end;

procedure TFrmCategorias.CbCategoriasChange(Sender: TObject);
begin
  ZQSub.Close;
  ZQSub.Params.ParamByName('cat_id').AsInteger:=CbCategorias.KeyValue;
  ZQSub.Open;
end;

end.

