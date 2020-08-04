unit u_frmaddbuy;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, db, Forms, Controls, Graphics, Dialogs, StdCtrls, DBCtrls,
  Grids, ButtonPanel, DateTimePicker, LCLType, Buttons, ZDataset, m_conn,
  m_consumibles, u_frmaddconsumiblecat;

type

  { TFrmAddBuy }

  TFrmAddBuy = class(TForm)
    BtnAddConsu: TBitBtn;
    BtnDel: TBitBtn;
    BtnAdd: TButton;
    Bp: TButtonPanel;
    DSMaterial: TDataSource;
    DtCompra: TDateTimePicker;
    CbMaterial: TDBLookupComboBox;
    TxtNextRow: TEdit;
    TxtTotal: TEdit;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    SGMateriales: TStringGrid;
    ZQ: TZQuery;
    procedure BtnAddClick(Sender: TObject);
    procedure BtnAddConsuClick(Sender: TObject);
    procedure BtnDelClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCloseQuery(Sender: TObject; var CanClose: boolean);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure OKButtonClick(Sender: TObject);
  private
    Cerrar: Boolean;

  public

  end;

var
  FrmAddBuy: TFrmAddBuy;

implementation

{$R *.lfm}

{ TFrmAddBuy }

procedure TFrmAddBuy.BtnAddClick(Sender: TObject);
var
  i: integer;
  id: string;
begin
  // Verificar si el material ya esta en la lista

  for i := 0 to (SGMateriales.RowCount - 1) do begin
    id := CbMaterial.KeyValue;
    if SGMateriales.Cells[0, i] = id then
    begin
      Application.MessageBox('El material a agregar ya se encuetra en el listado',
      'Dato existente', MB_ICONEXCLAMATION);
      Exit;
    end;
  end;

  SGMateriales.RowCount:=SGMateriales.RowCount + 1;
  SGMateriales.Row:=SGMateriales.RowCount - 1;
  with SGMateriales do begin
    Cells[0, SGMateriales.Row]:=CbMaterial.KeyValue;
    Cells[1, SGMateriales.Row]:=CbMaterial.Text;
    Cells[2, SGMateriales.Row]:=TxtTotal.Text;
  end;
end;

procedure TFrmAddBuy.BtnAddConsuClick(Sender: TObject);
begin
  FrmAddMaterialCat:=TFrmAddMaterialCat.Create(FrmAddBuy);
  FrmAddMaterialCat.ShowModal;
  DmConsumibles.ZQCat.Refresh;
end;

procedure TFrmAddBuy.BtnDelClick(Sender: TObject);
var
  fila: integer;
begin
  fila:=SGMateriales.Row;
  if MessageDlg('Eliminar', 'Eliminar el material ' + SGMateriales.Cells[1, fila] + '?', mtConfirmation,
   [mbYes, mbNo, mbIgnore],0) = mrYes
  then
  begin
    SGMateriales.DeleteRow(fila);
  end;
end;

procedure TFrmAddBuy.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  Cerrar:=True;
end;

procedure TFrmAddBuy.FormCloseQuery(Sender: TObject; var CanClose: boolean);
begin
  CanClose:=Cerrar;
end;

procedure TFrmAddBuy.FormCreate(Sender: TObject);
begin
  DmConsumibles.ZQCat.Open;
end;

procedure TFrmAddBuy.FormShow(Sender: TObject);
begin
  // Obtener el ultimo ID mas uno
  ZQ.Close;
  ZQ.SQL.Text:='select (count(ibc.id) + 1) as next_row from inventory_buy_consumable ibc';
  ZQ.Open;
  TxtNextRow.Text:=ZQ.FieldByName('next_row').AsString;
  ZQ.Close;
end;

procedure TFrmAddBuy.OKButtonClick(Sender: TObject);
var
  i, id_buy, total, id_temp:integer;
begin
  // Guardar datos en la base de datos
  // *********************************************
  // agregar la compra
  dmconn.Conn.StartTransaction;
  try
    ZQ.Close;
    ZQ.SQL.Text:='insert into inventory_buy_consumable(date_buy, status) values(:compra, 1)';
    ZQ.Params.ParamByName('compra').AsDate:=DtCompra.Date;
    ZQ.ExecSQL;

    // Obtener el id de la tabla insertada
    ZQ.Close;
    ZQ.SQL.Text:='SELECT last_insert_id() AS id';
    ZQ.Open;
    id_buy:=ZQ.FieldByName('id').AsInteger;
    ZQ.Close;

    // Guardar la relación de la compra con el material y el total comprado
    for i:=1 to SGMateriales.RowCount - 1 do begin
      ZQ.SQL.Text:='insert into inventory_consumable_has_inventory_buy_consumable'+
      '(inventory_consumable_id, inventory_buy_consumable_id, counts) values('+
      ':con_id, :buy_id, :total)';
      ZQ.Params.ParamByName('con_id').AsInteger:=StrToInt(SGMateriales.Cells[0, i]);
      ZQ.Params.ParamByName('buy_id').AsInteger:=id_buy;
      ZQ.Params.ParamByName('total').AsInteger:=StrToInt(SGMateriales.Cells[2, i]);
      ZQ.ExecSQL;

      // Adicionar el total de compra al stock
      // - Obtener el total de stock y el id
      ZQ.Close;
      ZQ.SQL.Text:='select id, counts from inventory_stock where inventory_consumable_id = :ic_id';
      ZQ.Params.ParamByName('ic_id').AsInteger:=StrToInt(SGMateriales.Cells[0,i]);
      ZQ.Open;

      // checar si hay resultados
      if ZQ.RecordCount > 0 then
      begin
        // Actualizar stock
        total:=ZQ.FieldByName('counts').AsInteger;
        id_temp:=ZQ.FieldByName('id').AsInteger;
        ZQ.SQL.Text:='UPDATE inventory_stock SET counts = :total WHERE id = :id';
        ZQ.Params.ParamByName('total').AsInteger:=(total + StrToInt(SGMateriales.Cells[0,2]));
        ZQ.Params.ParamByName('id').AsInteger:=id_temp;
        ZQ.ExecSQL;
      end
      else
      begin
        // Registrar el nuevo stock
        ZQ.SQL.Text:='INSERT INTO inventory_stock(inventory_consumable_id, counts) values(:ic_id, :total)';
        ZQ.Params.ParamByName('ic_id').AsInteger:=StrToInt(SGMateriales.Cells[0, i]);
        ZQ.Params.ParamByName('total').AsInteger:=StrToInt(SGMateriales.Cells[2, i]);
        ZQ.ExecSQL;
      end;
    end;

    Cerrar:=True;

    // Realizar commit a la base de datos
    dmconn.Conn.Commit;
  except
    dmconn.Conn.Rollback;
  end;
end;

end.

