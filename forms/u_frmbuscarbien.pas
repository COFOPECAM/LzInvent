unit u_frmbuscarbien;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, EditBtn,
  DBCtrls, ButtonPanel, m_bienes, strutils, LCLType;

type

  { TFrmBuscarBien }

  TFrmBuscarBien = class(TForm)
    Bp: TButtonPanel;
    CbAdq: TCheckBox;
    CbSubCat: TCheckBox;
    CbProveedor: TCheckBox;
    CbCodigo: TCheckBox;
    CbDesc: TCheckBox;
    CbEstatus: TCheckBox;
    CbFactura: TCheckBox;
    CbLugar: TCheckBox;
    CbMarca: TCheckBox;
    CbObs: TCheckBox;
    CbCat: TCheckBox;
    DeInicio: TDateEdit;
    DeFin: TDateEdit;
    CbxEstatus: TDBLookupComboBox;
    CbxLugar: TDBLookupComboBox;
    CbxMarca: TDBLookupComboBox;
    CbxCat: TDBLookupComboBox;
    CbxSubCat: TDBLookupComboBox;
    CbxProveedor: TDBLookupComboBox;
    TxtCodigo: TEdit;
    TxtDesc: TEdit;
    TxtFactura: TEdit;
    TxtObs: TEdit;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    procedure CbAdqChange(Sender: TObject);
    procedure CbCatChange(Sender: TObject);
    procedure CbCodigoChange(Sender: TObject);
    procedure CbDescChange(Sender: TObject);
    procedure CbEstatusChange(Sender: TObject);
    procedure CbFacturaChange(Sender: TObject);
    procedure CbLugarChange(Sender: TObject);
    procedure CbMarcaChange(Sender: TObject);
    procedure CbObsChange(Sender: TObject);
    procedure CbProveedorChange(Sender: TObject);
    procedure CbSubCatChange(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: boolean);
    procedure FormShow(Sender: TObject);
    procedure OKButtonClick(Sender: TObject);
  private

  public
    IsSearch:Boolean;

  end;

var
  FrmBuscarBien: TFrmBuscarBien;

implementation

{$R *.lfm}

{ TFrmBuscarBien }

procedure TFrmBuscarBien.CbAdqChange(Sender: TObject);
begin
  DeInicio.Enabled:=CbAdq.Checked;
  DeFin.Enabled:=CbAdq.Checked;
end;

procedure TFrmBuscarBien.CbCatChange(Sender: TObject);
begin
  CbxCat.Enabled:=CbCat.Checked;
end;

procedure TFrmBuscarBien.CbCodigoChange(Sender: TObject);
begin
  TxtCodigo.Enabled:=CbCodigo.Checked;
  TxtCodigo.Text:='';
end;

procedure TFrmBuscarBien.CbDescChange(Sender: TObject);
begin
  TxtDesc.Enabled:=CbDesc.Checked;
  TxtDesc.Text:='';
end;

procedure TFrmBuscarBien.CbEstatusChange(Sender: TObject);
begin
  CbxEstatus.Enabled:=CbEstatus.Checked;
end;

procedure TFrmBuscarBien.CbFacturaChange(Sender: TObject);
begin
  TxtFactura.Enabled:=CbFactura.Checked;
  TxtFactura.Text:='';
end;

procedure TFrmBuscarBien.CbLugarChange(Sender: TObject);
begin
  CbxLugar.Enabled:=CbLugar.Checked;
end;

procedure TFrmBuscarBien.CbMarcaChange(Sender: TObject);
begin
  CbxMarca.Enabled:=CbMarca.Checked;
end;

procedure TFrmBuscarBien.CbObsChange(Sender: TObject);
begin
  TxtObs.Enabled:=CbObs.Checked;
  TxtObs.Text:='';
end;

procedure TFrmBuscarBien.CbProveedorChange(Sender: TObject);
begin
  CbxProveedor.Enabled:=CbProveedor.Checked;
end;

procedure TFrmBuscarBien.CbSubCatChange(Sender: TObject);
begin
  CbxSubCat.Enabled:=CbSubCat.Checked;
end;

procedure TFrmBuscarBien.FormCloseQuery(Sender: TObject; var CanClose: boolean);
begin
  CanClose:=IsSearch;
end;

procedure TFrmBuscarBien.FormShow(Sender: TObject);
begin
  IsSearch:=true;
end;

procedure TFrmBuscarBien.OKButtonClick(Sender: TObject);
var
  sql, where: string;
begin
  // Crear SQL para la busqueda
  sql:='select b.id_biene as ''id'', b.descripcion as ''Descripcion'', m.nombre'+
  ' as ''Marca'', b.modelo as ''Modelo'', b.no_serie as ''No. serie'', b.precio'+
  ' as ''Monto'', b.factura as ''No. Factura'', b.adquisicion as ''Fecha de '+
  'compra'', b.codigo as ''Codigo'', sc.nombre as ''Subcategoria'', c.nombre '+
  'as ''Categoria'', l.nombre as ''Lugar'', p.empresa as ''Proveedor'', est.'+
  'nombre as ''Estatus'', cb.nombre as ''Motivo baja'', b.baja as ''Fecha baja'''+
  ' from bienes b inner join marcas m on m.id_marcas = b.marcas_id_marcas inner'+
  ' join subcategoria sc on sc.id_subcategoria = b.subcategoria_id_subcategoria'+
  ' inner join categorias c on c.id_categoria = sc.id_categoria inner join '+
  'lugares l on l.id_lugar = b.lugares_id_lugar inner join estatus est on est.'+
  'id_estatus = b.estatus_id_estatus inner join proveedores p on p.id_proveedor'+
  ' = b.proveedores_id_proveedor left join cat_bajas cb on cb.id_cat_baja = '+
  'b.cat_bajas_id_cat_baja where b.cat_bajas_id_cat_baja is null #where# order'+
  ' by b.adquisicion desc';

  // Crear sentencia where
  if CbAdq.Checked then
  begin
    where:=' and b.adquisicion >= :finicio and b.adquisicion <= :ffin';
  end;

  if CbCodigo.Checked then
  begin
    where:=where + ' and b.codigo like :codigo';
  end;

  if CbDesc.Checked then
  begin
    where := where + ' and b.descripcion like :desc';
  end;

  if CbEstatus.Checked then
  begin
    where := where + ' and b.estatus_id_estatus = :estatus';
  end;

  if CbFactura.Checked then
  begin
    where := where + ' and b.factura like :fact';
  end;

  if CbLugar.Checked then
  begin
    where := where + ' and b.lugares_id_lugar = :lugar_id';
  end;

  if CbMarca.Checked then
  begin
    where := where + ' and b.marcas_id_marcas = :marca_id';
  end;

  if CbCat.Checked then
  begin
    where := where + ' and sc.id_categoria = :cat_id';
  end;

  if CbSubCat.Checked then
  begin
    where := where + ' and sc.id_subcategoria = :sub_id';
  end;

  if CbProveedor.Checked then
  begin
    where := where + ' and b.proveedores_id_proveedor = :prov_id';
  end;

  if CbObs.Checked then
  begin
    where := where + ' and b.observaciones like :obs';
  end;

  // Crear y asignar SQL
  DmBienes.ZQSearch.Close;
  DmBienes.ZQSearch.SQL.Text:=ReplaceStr(sql, '#where#', where);
  // Agregar parametros

  if CbAdq.Checked then
  begin
    DmBienes.ZQSearch.Params.ParamByName('finicio').AsDate:=DeInicio.Date;
    DmBienes.ZQSearch.Params.ParamByName('ffin').AsDate:=DeFin.Date;
  end;

  if CbCodigo.Checked then
     DmBienes.ZQSearch.Params.ParamByName('codigo').AsString:=TxtCodigo.Text;
  if CbDesc.Checked then
     DmBienes.ZQSearch.Params.ParamByName('desc').AsString:='%' + TxtDesc.Text + '%';
  if CbEstatus.Checked then
     DmBienes.ZQSearch.Params.ParamByName('estatus').AsInteger:=CbxEstatus.KeyValue;
  if CbFactura.Checked then
     DmBienes.ZQSearch.Params.ParamByName('fact').AsString:='%' + TxtFactura.Text + '%';
  if CbLugar.Checked then
     DmBienes.ZQSearch.Params.ParamByName('lugar_id').AsInteger:=CbxLugar.KeyValue;
  if CbMarca.Checked then
     DmBienes.ZQSearch.Params.ParamByName('marca_id').AsInteger:=CbxMarca.KeyValue;
  if CbCat.Checked then
     DmBienes.ZQSearch.Params.ParamByName('cat_id').AsInteger:=CbxCat.KeyValue;
  if CbSubCat.Checked then
     DmBienes.ZQSearch.Params.ParamByName('sub_id').AsInteger:=CbxSubCat.KeyValue;
  if CbProveedor.Checked then
     DmBienes.ZQSearch.Params.ParamByName('prov_id').AsInteger:=CbxProveedor.KeyValue;
  if CbObs.Checked then
     DmBienes.ZQSearch.Params.ParamByName('obs').AsString:='%'+TxtObs.Text+'%';

  // Ejecutar consulta
  DmBienes.ZQSearch.Open;
  if DmBienes.ZQSearch.RecordCount = 0 then
  begin
    Application.MessageBox('No se encontraron coincidencias con tu busqueda',
    'Ningun registro', MB_ICONINFORMATION);
    IsSearch:=false;
  end;
end;

end.

