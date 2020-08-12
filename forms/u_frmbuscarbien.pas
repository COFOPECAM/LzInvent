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
    CbPrograma: TCheckBox;
    CbxPrograma: TDBLookupComboBox;
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
    procedure CancelButtonClick(Sender: TObject);
    procedure CbAdqChange(Sender: TObject);
    procedure CbCatChange(Sender: TObject);
    procedure CbCodigoChange(Sender: TObject);
    procedure CbDescChange(Sender: TObject);
    procedure CbEstatusChange(Sender: TObject);
    procedure CbFacturaChange(Sender: TObject);
    procedure CbLugarChange(Sender: TObject);
    procedure CbMarcaChange(Sender: TObject);
    procedure CbObsChange(Sender: TObject);
    procedure CbProgramaChange(Sender: TObject);
    procedure CbProveedorChange(Sender: TObject);
    procedure CbSubCatChange(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
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

procedure TFrmBuscarBien.CancelButtonClick(Sender: TObject);
begin
  IsSearch:=True;
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

procedure TFrmBuscarBien.CbProgramaChange(Sender: TObject);
begin
  CbxPrograma.Enabled:=CbPrograma.Checked;
end;

procedure TFrmBuscarBien.CbProveedorChange(Sender: TObject);
begin
  CbxProveedor.Enabled:=CbProveedor.Checked;
end;

procedure TFrmBuscarBien.CbSubCatChange(Sender: TObject);
begin
  CbxSubCat.Enabled:=CbSubCat.Checked;
end;

procedure TFrmBuscarBien.FormClose(Sender: TObject;
  var CloseAction: TCloseAction);
begin
  IsSearch:=True;
end;

procedure TFrmBuscarBien.FormCloseQuery(Sender: TObject; var CanClose: boolean);
begin
  CanClose:=IsSearch;
end;

procedure TFrmBuscarBien.FormShow(Sender: TObject);
begin
  IsSearch:=true;
  DmBienes.ZQProgs.Open;
end;

procedure TFrmBuscarBien.OKButtonClick(Sender: TObject);
var
  sql, where: string;
begin
  // Crear SQL para la busqueda
  sql:='select ift.id, ift.description, ib.name as marcar, ift.model, ift.no_'+
  'serie, ift.scode, ift.code, ift.bill, ift.acquisition, ist.name as estatus,'+
  ' aa.name as lugar, ift.price, ia.name as cuenta, trim(concat(ifnull(u2.hono'+
  'rific, ''''), '' '', u2.name, '' '', u2.surname)) as signned_to, isc.name as subc'+
  'ategoria, ic.name as categoria, ip.company, gpd.name as programa, ift.obser'+
  'vations from inventory_furniture ift inner join inventory_brand ib on ib.i'+
  'd_brand = ift.inventory_brand_id_brand inner join inventory_status ist on '+
  'ist.id = ift.inventory_status_id inner join area_apartments aa on aa.id = '+
  'ift.area_apartments_id left join inventory_accounts ia on ia.id = ift.inven'+
  'tory_accounts_id left join inventory_subcategorie isc on isc.id = ift.inven'+
  'tory_subcategorie_id inner join inventory_categories ic on ic.id = ift.inve'+
  'ntory_categories_id inner join inventory_provider ip on ip.id_provider = i'+
  'ft.inventory_provider_id_provider left join user_users u2 on u2.id = ift.si'+
  'gnned_to inner join general_program_disease gpd on gpd.id = ift.general_pr'+
  'ogram_disease_id where ift.status = 1 #where# order by ift.acquisition desc';

  // Crear sentencia where
  if CbAdq.Checked then
  begin
    where:=' and ift.acquisition >= :finicio and ift.acquisition <= :ffin';
  end;

  if CbCodigo.Checked then
  begin
    where:=where + ' and ift.code like :codigo';
  end;

  if CbDesc.Checked then
  begin
    where := where + ' and ift.description like :desc';
  end;

  if CbEstatus.Checked then
  begin
    where := where + ' and ist.id = :estatus';
  end;

  if CbFactura.Checked then
  begin
    where := where + ' and ift.bill like :fact';
  end;

  if CbLugar.Checked then
  begin
    where := where + ' and aa.id = :lugar_id';
  end;

  if CbMarca.Checked then
  begin
    where := where + ' and ib.i = :marca_id';
  end;

  if CbCat.Checked then
  begin
    where := where + ' and ic.id = :cat_id';
  end;

  if CbSubCat.Checked then
  begin
    where := where + ' and isc.id = :sub_id';
  end;

  if CbProveedor.Checked then
  begin
    where := where + ' and ip.id_provider = :prov_id';
  end;

  if CbObs.Checked then
  begin
    where := where + ' and ift.observations like :obs';
  end;

  if CbPrograma.Checked then
  begin
    where := where + ' and ift.general_program_disease_id = :program_id'
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
  if CbPrograma.Checked then
     DmBienes.ZQSearch.Params.ParamByName('program_id').AsInteger:=CbxPrograma.KeyValue;

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

