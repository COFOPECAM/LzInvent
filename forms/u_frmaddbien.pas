unit u_frmaddbien;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, db, Forms, Controls, Graphics, Dialogs, ComCtrls, StdCtrls,
  DBCtrls, Spin, EditBtn, ButtonPanel, DBGrids, LR_Class, LR_DBSet, m_conn,
  ZDataset;

type

  { TFrmAddBien }

  TFrmAddBien = class(TForm)
    BP: TButtonPanel;
    BtnCambiar: TButton;
    CxbGenerar: TCheckBox;
    DSHistorial: TDataSource;
    DSMarcas: TDataSource;
    DSEstatus: TDataSource;
    DSLugar: TDataSource;
    DSCat: TDataSource;
    DSSub: TDataSource;
    DSProv: TDataSource;
    DSBaja: TDataSource;
    DSEmpl: TDataSource;
    DtAdquisicion: TDateEdit;
    DgCambios: TDBGrid;
    CbEmpleados: TDBLookupComboBox;
    DeFechaBaja: TDateEdit;
    CbMarca: TDBLookupComboBox;
    CbEstado: TDBLookupComboBox;
    CbLugar: TDBLookupComboBox;
    CbCategoria: TDBLookupComboBox;
    CbSubC: TDBLookupComboBox;
    CbProveedor: TDBLookupComboBox;
    CbBaja: TDBLookupComboBox;
    DBResguardo: TfrDBDataSet;
    LzReportResguardo: TfrReport;
    TxtIdent: TEdit;
    TxtModelo: TEdit;
    TxtNoSerie: TEdit;
    TxtFactura: TEdit;
    TxtPrecio: TFloatSpinEdit;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    LbBaja: TLabel;
    LbFechaBaja: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    TxtObser: TMemo;
    TxtDescrip: TMemo;
    PcBien: TPageControl;
    TsCambios: TTabSheet;
    TsBien: TTabSheet;
    ZQEmplempleado: TMemoField;
    ZQEmplid_empleado: TLargeintField;
    ZQMarcas: TZQuery;
    ZQEstatus: TZQuery;
    ZQLugar: TZQuery;
    ZQCat: TZQuery;
    ZQSub: TZQuery;
    ZQProv: TZQuery;
    ZQBaja: TZQuery;
    ZQEmpl: TZQuery;
    ZQBien: TZQuery;
    ZQResguardoBien: TZQuery;
    ZQHistorial: TZQuery;
    procedure BtnCambiarClick(Sender: TObject);
    procedure CbCategoriaChange(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: boolean);
    procedure FormShow(Sender: TObject);
    procedure LzReportResguardoGetValue(const ParName: String;
      var ParValue: Variant);
    procedure OKButtonClick(Sender: TObject);
    procedure ZQEmplempleadoGetText(Sender: TField; var aText: string;
      DisplayText: Boolean);
  private
    save:Boolean;
    entrega, recibe, autoriza:string;

  public
    edit:Boolean;
    bien_id:Integer;
    show_baja: Boolean;

  end;

var
  FrmAddBien: TFrmAddBien;

implementation

{$R *.lfm}

{ TFrmAddBien }

procedure TFrmAddBien.FormShow(Sender: TObject);
begin
  // Cargas listas despligables
  ZQMarcas.Open;
  ZQEstatus.Open;
  ZQLugar.Open;
  ZQCat.Open;
  ZQProv.Open;
  ZQBaja.Open;
  ZQEmpl.Open;

  if show_baja then
  begin
    Height:=470;
    PcBien.Height:=416;
    LbBaja.Visible:=true;
    LbFechaBaja.Visible:=true;
    CbBaja.Visible:=true;
    DeFechaBaja.Visible:=true;
  end
  else
  begin
    PcBien.Height:=380;
    Height:=434;
  end;
  TsCambios.TabVisible:=edit;
  save:=true;
  if edit then
  begin
    ZQHistorial.Params.ParamByName('bien_id').AsInteger:=bien_id;
    ZQHistorial.Open;
  end;
end;

procedure TFrmAddBien.LzReportResguardoGetValue(const ParName: String;
  var ParValue: Variant);
begin
  // Pasar variables al reporte
  if ParName='recibe' then
     ParValue:=recibe;
  if ParName='entrega' then
     ParValue:=entrega;
  if ParName='autoriza' then
     ParValue:=autoriza;
end;

procedure TFrmAddBien.CbCategoriaChange(Sender: TObject);
begin
  if CbCategoria.KeyValue <> 0 then
  begin
    ZQSub.Close;
    ZQSub.Params.ParamByName('id_cat').AsInteger:=CbCategoria.KeyValue;
    ZQSub.Open;
  end;
end;

procedure TFrmAddBien.BtnCambiarClick(Sender: TObject);
var
  nombre:string;
begin
  // Realizar cambio y recargar datos de la tabla
  nombre:=CbEmpleados.Text;
  if MessageDlg('Confirmación', '¿Desea realizar la asignación del bien a ' +
  nombre + '?', mtConfirmation, [mbYes, mbNo],0) = mrYes
  then
  begin
    ZQBien.SQL.Text:='INSERT INTO historico(bienes_id_biene, fecha_cambio, empleados_id_'+
    'empleado, estatus) VALUES(:bien_id, :cambio, :empl_id, 1)';
    ZQBien.Params.ParamByName('bien_id').AsInteger:=bien_id;
    ZQBien.Params.ParamByName('empl_id').AsInteger:=CbEmpleados.KeyValue;
    ZQBien.Params.ParamByName('cambio').AsDateTime:=Now;
    ZQBien.ExecSQL;
    ZQHistorial.Close;
    ZQHistorial.Params.ParamByName('bien_id').AsInteger:=bien_id;
    ZQHistorial.Open;

    // Checar si se generar el resguardo
    if CxbGenerar.Checked then
    begin
      ZQResguardoBien.Close;
      ZQResguardoBien.Params.ParamByName('bien_id').AsInteger:=bien_id;
      ZQResguardoBien.Open;

      // Obtener datos para las firmas
      dmconn.ZQFirmasReport.Params.ParamByName('bien_id').AsInteger:=bien_id;
      dmconn.ZQFirmasReport.Open;
      recibe:=dmconn.ZQFirmasReport.FieldByName('empleado').AsString;
      dmconn.ZQFirmasReport.Close;
      entrega:='Alexis Fuentes';

      LzReportResguardo.LoadFromFile('../../reports/rpResguardoBien.lrf');
      LzReportResguardo.ShowReport;
    end;
  end;
end;

procedure TFrmAddBien.FormCloseQuery(Sender: TObject; var CanClose: boolean);
begin
  CanClose:=save;
end;

procedure TFrmAddBien.OKButtonClick(Sender: TObject);
begin
  if not edit then
  begin
    ZQBien.SQL.Text:='insert into bienes(adquisicion, codigo, descripcion, '+
    'estatus_id_estatus, factura, lugares_id_lugar, marcas_id_marcas, modelo, '+
    'no_serie, observaciones, precio, proveedores_id_proveedor, '+
    'subcategoria_id_subcategoria) values(:adquision, :codigo, :descripcion, '+
    ':est_id, :factura, :lug_id, :marc_id, :modelo, :no_serie, :obs, :precio, '+
    ':prov_id, :sub)';
    ZQBien.Params.ParamByName('descripcion').AsString:=TxtDescrip.Lines.Text;
    ZQBien.Params.ParamByName('marc_id').AsInteger:=CbMarca.KeyValue;
    ZQBien.Params.ParamByName('modelo').AsString:=TxtModelo.Text;
    ZQBien.Params.ParamByName('no_serie').AsString:=TxtNoSerie.Text;
    ZQBien.Params.ParamByName('precio').AsFloat:=StrToFloat(TxtPrecio.Text);
    ZQBien.Params.ParamByName('factura').AsString:=TxtFactura.Text;
    ZQBien.Params.ParamByName('adquision').AsDate:=DtAdquisicion.Date;
    ZQBien.Params.ParamByName('est_id').AsInteger:=CbEstado.KeyValue;
    ZQBien.Params.ParamByName('lug_id').AsInteger:=CbLugar.KeyValue;
    ZQBien.Params.ParamByName('sub').AsInteger:=CbSubC.KeyValue;
    ZQBien.Params.ParamByName('prov_id').AsInteger:=CbProveedor.KeyValue;
    ZQBien.Params.ParamByName('obs').AsString:=TxtObser.Lines.Text;
    ZQBien.Params.ParamByName('codigo').AsString:='LZI000001';
    ZQBien.ExecSQL;
    save:=true;
  end;

end;

procedure TFrmAddBien.ZQEmplempleadoGetText(Sender: TField; var aText: string;
  DisplayText: Boolean);
begin
  aText := Sender.AsString;
  DisplayText:=true;
end;

end.

