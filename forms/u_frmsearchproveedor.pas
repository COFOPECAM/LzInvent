unit u_frmsearchproveedor;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, db, Forms, Controls, Graphics, Dialogs, StdCtrls, DBCtrls,
  ButtonPanel, LR_Class, LR_DBSet, ZDataset, m_conn, m_bienes;

type

  { TFrmResguardo }

  TFrmResguardo = class(TForm)
    Bp: TButtonPanel;
    CbAlmacen: TCheckBox;
    CxbGenerar: TCheckBox;
    DSEmpleado: TDataSource;
    CbEmpleados: TDBLookupComboBox;
    CbPrograma: TDBLookupComboBox;
    DBResguardo: TfrDBDataSet;
    LzReportResguardo: TfrReport;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    ZQEmpleado: TZQuery;
    ZQBien: TZQuery;
    ZQResguardoBien: TZQuery;
    procedure CbAlmacenChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure OKButtonClick(Sender: TObject);
  private

  public
    bien_id: integer;

  end;

var
  FrmResguardo: TFrmResguardo;

implementation

{$R *.lfm}

{ TFrmResguardo }

procedure TFrmResguardo.OKButtonClick(Sender: TObject);
var
  nombre:string;
begin
  // Realizar cambio y recargar datos de la tabla
  nombre:=CbEmpleados.Text;
  if MessageDlg('Confirmación', '¿Desea realizar la asignación del bien a ' +
  nombre + '?', mtConfirmation, [mbYes, mbNo],0) = mrYes
  then
  begin
    ZQBien.SQL.Text:='insert into inventory_history_changes(inventory_furnitur'+
    'e_id, siggned_to, date_change, user_change, general_program_disease_id) '+
    'values(:bien_id, :empleado_id, :fecha, :usuario_cambio, :programa_id)';
    ZQBien.Params.ParamByName('bien_id').AsInteger:=bien_id;
    ZQBien.Params.ParamByName('empleado_id').AsInteger:=CbEmpleados.KeyValue;
    ZQBien.Params.ParamByName('fecha').AsDateTime:=Now;
    ZQBien.Params.ParamByName('usuario_cambio').AsInteger:=dmconn.UserId;
    ZQBien.Params.ParamByName('programa_id').AsInteger:=CbPrograma.KeyValue;
    ZQBien.ExecSQL;

    // Actualizar datos del bien
    dmconn.ZQs.Close;
    dmconn.ZQs.SQL.Text:='update inventory_furniture set signned_to = '+
    ':empleado_id where id = :bien_id';
    dmconn.ZQs.Params.ParamByName('empleado_id').AsInteger:=CbEmpleados.KeyValue;
    dmconn.ZQs.Params.ParamByName('bien_id').AsInteger:=bien_id;
    dmconn.ZQs.ExecSQL;

    // Checar si se generar el resguardo
    if CxbGenerar.Checked then
    begin
      ZQResguardoBien.Close;
      ZQResguardoBien.Params.ParamByName('bien_id').AsInteger:=bien_id;
      ZQResguardoBien.Open;

      // Obtener datos para las firmas
      //dmconn.ZQFirmasReport.Params.ParamByName('bien_id').AsInteger:=bien_id;
      //dmconn.ZQFirmasReport.Open;
      //recibe:=dmconn.ZQFirmasReport.FieldByName('empleado').AsString;
      //dmconn.ZQFirmasReport.Close;
      //entrega:='Alexis Fuentes';

      LzReportResguardo.LoadFromFile('../../reports/rpResguardoBien.lrf');
      LzReportResguardo.ShowReport;
    end;
  end;
end;

procedure TFrmResguardo.FormShow(Sender: TObject);
begin
  ZQEmpleado.Open;
end;

procedure TFrmResguardo.FormCreate(Sender: TObject);
begin
  ZQEmpleado.Open;
  DmBienes.ZQProgs.Open;
end;

procedure TFrmResguardo.CbAlmacenChange(Sender: TObject);
begin
  // Bloquear empleado
  CbEmpleados.Enabled:=not CbAlmacen.Checked;
  CxbGenerar.Enabled:=not CbAlmacen.Checked;
  CxbGenerar.Checked:=not CbAlmacen.Checked;
end;

end.

