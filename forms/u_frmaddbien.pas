unit u_frmaddbien;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, db, Forms, Controls, Graphics, Dialogs, ComCtrls, StdCtrls,
  DBCtrls, Spin, EditBtn, ButtonPanel, DBGrids, LR_Class, LR_DBSet, m_conn,
  ZDataset, StringsFormat, variants, u_frmgenclave, m_bienes;

type

  { TFrmAddBien }

  TFrmAddBien = class(TForm)
    BP: TButtonPanel;
    BtnCambiar: TButton;
    CbCuenta: TDBLookupComboBox;
    CxbGenerar: TCheckBox;
    CbPrograma: TDBLookupComboBox;
    DSAcc: TDataSource;
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
    Label18: TLabel;
    TxtNameProg: TEdit;
    Label15: TLabel;
    Label17: TLabel;
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
    LbCodigo: TLabel;
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
    ZQAcc: TZQuery;
    procedure BtnCambiarClick(Sender: TObject);
    procedure CancelButtonClick(Sender: TObject);
    procedure CbCategoriaEditingDone(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: boolean);
    procedure FormShow(Sender: TObject);
    procedure LbCodigoDblClick(Sender: TObject);
    procedure LzReportResguardoGetValue(const ParName: String;
      var ParValue: Variant);
    procedure OKButtonClick(Sender: TObject);
    procedure ZQEmplempleadoGetText(Sender: TField; var aText: string;
      DisplayText: Boolean);
  private
    save:Boolean;
    entrega, recibe, autoriza, codigo:string;
    new_id, prog_id: integer;

  public
    edit:Boolean;
    bien_id:Integer;
    show_baja: Boolean;
    Programa: string;

  end;

var
  FrmAddBien: TFrmAddBien;

implementation

{$R *.lfm}

{ TFrmAddBien }

procedure TFrmAddBien.FormShow(Sender: TObject);
var
  sf: TStringsFormat;
begin
  DmBienes.ZQProgs.Open;
  // Cargas listas despligables
  ZQMarcas.Open;
  ZQEstatus.Open;
  ZQLugar.Open;
  ZQCat.Open;
  ZQProv.Open;
   //ZQBaja.Open;
   ZQEmpl.Open;
  ZQAcc.Open;

  if show_baja then
  begin
    Height:=485;
    PcBien.Height:=432;
    LbBaja.Visible:=true;
    LbFechaBaja.Visible:=true;
    CbBaja.Visible:=true;
    DeFechaBaja.Visible:=true;
  end
  else
  begin
    PcBien.Height:=400;
    Height:=449;
  end;
  TsCambios.TabVisible:=edit;
  save:=true;

  if edit then
  begin
    // Obtener datos del bien a editar
    ZQBien.SQL.Text:='select id, description, inventory_brand_id_brand, model,'+
    ' no_serie, bill, acquisition, inventory_status_id, area_apartments_id, '+
    'price, inventory_accounts_id, inventory_subcategorie_id, inventory_'+
    'categories_id, inventory_provider_id_provider, observations, signned_to,'+
    ' general_program_disease_id, scode from inventory_furniture ift where id'+
    ' = :bien_id';
    ZQBien.Params.ParamByName('bien_id').AsInteger:=bien_id;
    ZQBien.Open;
    // Asignar datos a los campos
    TxtIdent.Text:=bien_id.ToString;
    TxtDescrip.Text:=ZQBien.FieldByName('description').AsString;
    TxtDescrip.Enabled:=edit;
    CbMarca.KeyValue:=ZQBien.FieldByName('inventory_brand_id_brand').AsInteger;
    CbMarca.Enabled:=edit;
    TxtModelo.Text:=ZQBien.FieldByName('model').AsString;
    TxtModelo.Enabled:=edit;
    TxtNoSerie.Text:=ZQBien.FieldByName('no_serie').AsString;
    TxtNoSerie.Enabled:=edit;
    TxtPrecio.Value:=ZQBien.FieldByName('price').AsFloat;
    TxtPrecio.Enabled:=edit;
    CbCuenta.KeyValue:=ZQBien.FieldByName('inventory_accounts_id').AsInteger;
    CbCuenta.Enabled:=edit;
    TxtFactura.Text:=ZQBien.FieldByName('bill').AsString;
    TxtFactura.Enabled:=edit;
    DtAdquisicion.Date:=ZQBien.FieldByName('acquisition').AsDateTime;
    DtAdquisicion.Enabled:=edit;
    CbEstado.KeyValue:=ZQBien.FieldByName('inventory_status_id').AsInteger;
    CbEstado.Enabled:=edit;
    CbLugar.KeyValue:=ZQBien.FieldByName('area_apartments_id').AsInteger;
    CbLugar.Enabled:=edit;
    CbCategoria.KeyValue:=ZQBien.FieldByName('inventory_categories_id').AsInteger;
    CbProveedor.KeyValue:=ZQBien.FieldByName('inventory_provider_id_provider').AsInteger;
    CbPrograma.Enabled:=edit;
    TxtObser.Text:=ZQBien.FieldByName('observations').AsString;
    TxtObser.Enabled:=edit;
    LbCodigo.Caption:=ZQBien.FieldByName('scode').AsString;
    TxtNameProg.Text:=Programa;
    CbSubC.KeyValue:=ZQBien.FieldByName('inventory_subcategorie_id').AsInteger;
    ZQHistorial.Params.ParamByName('bien_id').AsInteger:=bien_id;
    ZQHistorial.Open;
  end;
end;

procedure TFrmAddBien.LbCodigoDblClick(Sender: TObject);
begin
  if (edit = true) or (show_baja = true) then
  begin
    exit;
  end;
  // Mostrar ventana para generar la clave
  FrmGenClave:=TFrmGenClave.Create(FrmAddBien);
  if FrmGenClave.ShowModal = mrOK then
  begin
    // Mostrar clave generada
    LbCodigo.Caption:=FrmGenClave.Clave;
    codigo:=FrmGenClave.Codigo;
    prog_id:=FrmGenClave.ProgId;
    TxtNameProg.Text:=FrmGenClave.NameProgr;

    // Habilitar los campos
    TxtDescrip.Enabled:=true;
    CbMarca.Enabled:=true;
    TxtModelo.Enabled:=true;
    TxtNoSerie.Enabled:=true;
    TxtFactura.Enabled:=true;
    DtAdquisicion.Enabled:=true;
    CbEstado.Enabled:=true;
    CbLugar.Enabled:=true;
    TxtPrecio.Enabled:=true;
    CbCuenta.Enabled:=true;
    CbCategoria.Enabled:=true;
    CbSubC.Enabled:=true;
    CbProveedor.Enabled:=true;
    TxtObser.Enabled:=true;

    TxtDescrip.SetFocus;
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

procedure TFrmAddBien.CbCategoriaEditingDone(Sender: TObject);
begin
  if not VarIsNull(CbCategoria.KeyValue) then
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
    ZQBien.SQL.Text:='insert into inventory_history_changes(inventory_furnitur'+
    'e_id, siggned_to, date_change, user_change, general_program_disease_id) '+
    'values(:bien_id, :empleado_id, :fecha, :usuario_cambio, :programa_id)';
    ZQBien.Params.ParamByName('bien_id').AsInteger:=bien_id;
    ZQBien.Params.ParamByName('empleado_id').AsInteger:=CbEmpleados.KeyValue;
    ZQBien.Params.ParamByName('fecha').AsDateTime:=Now;
    ZQBien.Params.ParamByName('usuario_cambio').AsInteger:=dmconn.UserId;
    ZQBien.Params.ParamByName('programa_id').AsInteger:=CbPrograma.KeyValue;

    ZQBien.ExecSQL;
    ZQHistorial.Close;
    ZQHistorial.Params.ParamByName('bien_id').AsInteger:=bien_id;
    ZQHistorial.Open;

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

procedure TFrmAddBien.CancelButtonClick(Sender: TObject);
begin
  save:=true;
end;

procedure TFrmAddBien.FormCloseQuery(Sender: TObject; var CanClose: boolean);
begin
  CanClose:=save;
end;

procedure TFrmAddBien.OKButtonClick(Sender: TObject);
var
  sf: TStringsFormat;
begin
  if not edit then
  begin
    ZQBien.SQL.Text:='INSERT INTO inventory_furniture(description, inventory_'+
    'brand_id_brand, model, no_serie, bill, acquisition, inventory_status_id, '+
    'area_apartments_id, price, inventory_accounts_id, inventory_subcategorie_'+
    'id, inventory_categories_id, inventory_provider_id_provider, observations,'+
    ' general_program_disease_id, date_capture, user_capture, '+
    'status, code, scode) VALUES(:desc, :brand, :model, :nserie, :bill, '+
    ':acq, :status_id, :apartments_id, :price, :accounts_id, :subcategorie_id,'+
    ' :categories_id, :id_provider, :obs, :program_id, NOW(), :user_'+
    'capture, 1, :code, :scode)';
    ZQBien.Params.ParamByName('desc').AsString:=TxtDescrip.Lines.Text;
    ZQBien.Params.ParamByName('brand').AsInteger:=CbMarca.KeyValue;
    ZQBien.Params.ParamByName('model').AsString:=TxtModelo.Text;
    ZQBien.Params.ParamByName('nserie').AsString:=TxtNoSerie.Text;
    ZQBien.Params.ParamByName('price').AsFloat:=StrToFloat(TxtPrecio.Text);
    ZQBien.Params.ParamByName('bill').AsString:=TxtFactura.Text;
    ZQBien.Params.ParamByName('acq').AsDate:=DtAdquisicion.Date;
    ZQBien.Params.ParamByName('status_id').AsInteger:=CbEstado.KeyValue;
    ZQBien.Params.ParamByName('apartments_id').AsInteger:=CbLugar.KeyValue;
    ZQBien.Params.ParamByName('accounts_id').AsInteger:=CbCuenta.KeyValue;
    if CbSubC.KeyValue <> null then
      ZQBien.Params.ParamByName('subcategorie_id').AsInteger:=CbSubC.KeyValue
    else
      ZQBien.Params.ParamByName('subcategorie_id').Clear;
    ZQBien.Params.ParamByName('categories_id').AsInteger:=CbCategoria.KeyValue;
    ZQBien.Params.ParamByName('id_provider').AsInteger:=CbProveedor.KeyValue;
    ZQBien.Params.ParamByName('program_id').AsInteger:=prog_id;
    ZQBien.Params.ParamByName('obs').AsString:=TxtObser.Lines.Text;
    ZQBien.Params.ParamByName('user_capture').AsInteger:=1; // Obtener el id del usuario
    ZQBien.Params.ParamByName('code').AsString:=codigo;
    ZQBien.Params.ParamByName('scode').AsString:=LbCodigo.Caption;
    try
      ZQBien.ExecSQL;
      save:=true;
    except
      on E:Exception do
      begin
      end;
    end;
  end
  else
  begin
    if MessageDlg('Confirmación', '¿Desea guardar los cambios hechos?',
    mtConfirmation, [mbYes, mbNo],0) = mrNo
    then
    begin
      save:=false;
      Exit;
    end;
    ZQBien.SQL.Text:='UPDATE bienes SET adquisicion=:adq,'+
    'descripcion=:descr,estatus_id_estatus=:est,'+
    'factura=:fact,lugares_id_lugar=:lugar_id,marcas_id_marcas=:marca_id,'+
    'modelo=:modelo,no_serie=:no_serie,observaciones=:obs,precio=:precio,'+
    'proveedores_id_proveedor=:prov_id,subcategoria_id_subcategoria=:sub_id'+
    ' WHERE id_biene = :bien_id';
    ZQBien.Params.ParamByName('adq').AsDate:=DtAdquisicion.Date;
    ZQBien.Params.ParamByName('descr').AsString:=TxtDescrip.Text;
    ZQBien.Params.ParamByName('est').AsInteger:=CbEstado.KeyValue;
    ZQBien.Params.ParamByName('fact').AsString:=TxtFactura.Text;
    ZQBien.Params.ParamByName('lugar_id').AsInteger:=CbLugar.KeyValue;
    ZQBien.Params.ParamByName('marca_id').AsInteger:=CbMarca.KeyValue;
    ZQBien.Params.ParamByName('modelo').AsString:=TxtModelo.Text;
    ZQBien.Params.ParamByName('no_serie').AsString:=TxtNoSerie.Text;
    ZQBien.Params.ParamByName('obs').AsString:=TxtObser.Lines.Text;
    ZQBien.Params.ParamByName('precio').AsFloat:=TxtPrecio.Value;
    ZQBien.Params.ParamByName('prov_id').AsInteger:=CbProveedor.KeyValue;
    ZQBien.Params.ParamByName('sub_id').AsInteger:=CbSubC.KeyValue;
    ZQBien.Params.ParamByName('bien_id').AsInteger:=bien_id;
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

