unit u_frmbajabien;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, DBCtrls,
  ButtonPanel, ZDataset, m_conn, db;

type

  { TFrmBaja }

  TFrmBaja = class(TForm)
    Bp: TButtonPanel;
    DSBaja: TDataSource;
    CbBaja: TDBLookupComboBox;
    TxtAsignado: TEdit;
    TxtEstatus: TEdit;
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    TxtDesc: TMemo;
    ZQBaja: TZQuery;
    procedure FormShow(Sender: TObject);
    function EditBien(Bien_id, Motivo_id: integer) : Boolean;
    procedure OKButtonClick(Sender: TObject);
  private
    save:Boolean;

  public
    Bien_id: integer;

  end;

var
  FrmBaja: TFrmBaja;

implementation

{$R *.lfm}

{ TFrmBaja }

procedure TFrmBaja.FormShow(Sender: TObject);
begin
  // Obtener datos del bien
  dmconn.ZQs.SQL.Text:='select b.descripcion, e.nombre as estatus, '+
  '(e.nombres || '' '' || e.apellidos) as empleado from bienes b inner join '+
  'estatus e on e.id_estatus = b.estatus_id_estatus inner join historico h '+
  'on h.bienes_id_biene = b.id_biene inner join empleados e on e.id_empleado'+
  ' = h.empleados_id_empleado where b.id_biene = :bien_id and h.estatus = '+
  '1 order by h.fecha_cambio desc limit 0, 1';
  dmconn.ZQs.Params.ParamByName('bien_id').AsInteger:=Bien_id;
  dmconn.ZQs.Open;

  if dmconn.ZQs.RecordCount > 0 then
  begin
    TxtDesc.Lines.Text:=dmconn.ZQs.FieldByName('descripcion').AsString;
    TxtEstatus.Text:=dmconn.ZQs.FieldByName('estatus').AsString;
    TxtAsignado.Text:=dmconn.ZQs.FieldByName('empleado').AsString;
  end;

  dmconn.ZQs.Close;

  ZQBaja.Open;
  save:=true;
end;

function TFrmBaja.EditBien(Bien_id, Motivo_id: integer) : Boolean;
begin
  if MessageDlg('Confirmación', '¿Desea dar de baja el bien?',
  mtConfirmation, [mbYes, mbNo],0) = mrYes
  then
  begin
    dmconn.ZQs.SQL.Text:='update bienes set baja=:fecha_baja, cat_bajas_id_cat_'+
    'baja=:cat_baja where id_biene = :bien_id';
    dmconn.ZQs.Params.ParamByName('fecha_baja').AsDate:=Now;
    dmconn.ZQs.Params.ParamByName('cat_baja').AsInteger:=Motivo_id;
    dmconn.ZQs.Params.ParamByName('bien_id').AsInteger:=Bien_id;
    dmconn.ZQs.ExecSQL;
    Result:=true;
  end
  else
  begin
    Result:=false;
  end;
end;

procedure TFrmBaja.OKButtonClick(Sender: TObject);
begin
  save:=EditBien(Bien_id, CbBaja.KeyValue);
end;

end.

