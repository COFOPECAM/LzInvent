unit u_frmentrega;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, db, Forms, Controls, Graphics, Dialogs, StdCtrls, DBCtrls,
  Buttons, Grids, ButtonPanel, LCLType, ZDataset, m_conn;

type

  { TFrmEntrega }

  TFrmEntrega = class(TForm)
    BtnAgregar: TBitBtn;
    BtnDel: TBitBtn;
    Bp: TButtonPanel;
    DSEmpleado: TDataSource;
    DSConsu: TDataSource;
    CbEmpleado: TDBLookupComboBox;
    CbConsumible: TDBLookupComboBox;
    ILimgs: TImageList;
    TxtEntregar: TEdit;
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    TxtExistencia: TLabel;
    SGMateriales: TStringGrid;
    ZQ: TZQuery;
    procedure BtnAgregarClick(Sender: TObject);
    procedure CancelButtonClick(Sender: TObject);
    procedure CbConsumibleChange(Sender: TObject);
    procedure CbConsumibleSelect(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCloseQuery(Sender: TObject; var CanClose: boolean);
    procedure OKButtonClick(Sender: TObject);
    procedure TxtEntregarEditingDone(Sender: TObject);
  private
    Cerrar: Boolean;
    existencia: integer;

  public

  end;

var
  FrmEntrega: TFrmEntrega;

implementation

{$R *.lfm}

{ TFrmEntrega }

procedure TFrmEntrega.CbConsumibleSelect(Sender: TObject);
begin
  // Obtener la existencia
  ZQ.Close;
  ZQ.SQL.Text:='select counts from inventory_stock where inventory_consumable_id = :inv';
  ZQ.Params.ParamByName('inv').AsInteger:=CbConsumible.KeyValue;
  ZQ.Open;

  existencia:=ZQ.FieldByName('counts').AsInteger;
  TxtExistencia.Caption:='Existencia: ' + IntToStr(existencia);
end;

procedure TFrmEntrega.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  Cerrar:=True;
end;

procedure TFrmEntrega.FormCloseQuery(Sender: TObject; var CanClose: boolean);
begin
  CanClose:=Cerrar;
end;

procedure TFrmEntrega.OKButtonClick(Sender: TObject);
var
  id_del, i: integer;
begin
  dmconn.Conn.StartTransaction;
  try
    ZQ.Close;
    // Guardar relacion de entrega con el empleado
    ZQ.SQL.Text:='insert into inventory_deliveries(date_delivery, user_users_id)'+
    ' values(:fecha, :user)';
    ZQ.Params.ParamByName('fecha').AsDate:=Now;
    ZQ.Params.ParamByName('user').AsInteger:=CbEmpleado.KeyValue;
    ZQ.ExecSQL;

    // Obtener el id de la tabla insertada
    ZQ.Close;
    ZQ.SQL.Text:='SELECT last_insert_id() AS id';
    ZQ.Open;
    id_del:=ZQ.FieldByName('id').AsInteger;
    ZQ.Close;

    // Crear relación de la entrega y los bienes
    for i:=1 to SGMateriales.RowCount - 1 do begin
      ZQ.SQL.Text:='insert into inventory_consumable_has_inventory_deliveries'+
      '(inventory_consumable_id, inventory_deliveries_id, total_delivery) '+
      'values(:con_id, :del_id, :total)';
      ZQ.Params.ParamByName('con_id').AsInteger:=StrToInt(SGMateriales.Cells[0,i]);
      ZQ.Params.ParamByName('del_id').AsInteger:=id_del;
      ZQ.Params.ParamByName('total').AsInteger:=StrToInt(SGMateriales.Cells[2,i]);
      ZQ.ExecSQL;

      // Descontar del inventario


    end;

    dmconn.Conn.Commit;
    Cerrar:=True;
  except
    dmconn.Conn.Rollback;
  end;
end;

procedure TFrmEntrega.TxtEntregarEditingDone(Sender: TObject);
begin

end;

procedure TFrmEntrega.CbConsumibleChange(Sender: TObject);
begin
  //ShowMessage(CbConsumible.DataSource.DataSet.FieldValues['id']);
  //TxtExistencia.Caption:='Existencia: ' + DSConsu.DataSet.Fields[2].AsString;
end;

procedure TFrmEntrega.BtnAgregarClick(Sender: TObject);
var
  i: integer;
  id: string;
begin
  // Verificar si ya se encuentra el consumible en la lista
  for i := 0 to (SGMateriales.RowCount - 1) do begin
    id := CbConsumible.KeyValue;
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
    Cells[0, SGMateriales.Row]:=CbConsumible.KeyValue;
    Cells[1, SGMateriales.Row]:=CbConsumible.Text;
    Cells[2, SGMateriales.Row]:=TxtEntregar.Text;
  end;
end;

procedure TFrmEntrega.CancelButtonClick(Sender: TObject);
begin
  Cerrar:=True;
end;

end.

