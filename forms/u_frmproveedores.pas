unit u_frmproveedores;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ComCtrls, Menus,
  SpkToolbar, spkt_Tab, spkt_Pane, spkt_Buttons, m_conn, db, ZDataset, rxdbgrid,
  RxDBGridExportSpreadSheet, spkt_Appearance, u_frmproveedor, LCLType;

type

  { TFrmProveedores }

  TFrmProveedores = class(TForm)
    BtnAgregar: TSpkLargeButton;
    BtnEditar: TSpkLargeButton;
    BtnBaja: TSpkLargeButton;
    BtnBuscar: TSpkLargeButton;
    BtnExcel: TSpkLargeButton;
    DSProveedores: TDataSource;
    LBRibbon: TImageList;
    DgProveedores: TRxDBGrid;
    MICompleta: TMenuItem;
    MIVista: TMenuItem;
    PMExportXLS: TPopupMenu;
    ToExcel: TRxDBGridExportSpreadSheet;
    SDFile: TSaveDialog;
    SpkPane1: TSpkPane;
    SpkPane2: TSpkPane;
    SpkTab1: TSpkTab;
    SbMsjs: TStatusBar;
    StMenu: TSpkToolbar;
    ZQProveedores: TZQuery;
    ZQProv: TZQuery;
    ZQAllData: TZQuery;
    procedure BtnAgregarClick(Sender: TObject);
    procedure BtnBajaClick(Sender: TObject);
    procedure BtnEditarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure MICompletaClick(Sender: TObject);
    procedure MIVistaClick(Sender: TObject);
  private

  public

  end;

var
  FrmProveedores: TFrmProveedores;

implementation

{$R *.lfm}

{ TFrmProveedores }

procedure TFrmProveedores.FormCreate(Sender: TObject);
begin
  { Settear configuraciones de la aplicación }
  if dmconn.theme_app = 'blue' then
  begin
    StMenu.Style:=spkOffice2007Blue;
    StMenu.Color:=clSkyBlue;
  end;
  if dmconn.theme_app = 'silver' then
  begin
    StMenu.Style:=spkOffice2007Silver;
    StMenu.Color:=clWhite;
  end;
  if dmconn.theme_app = 'black' then
  begin
    StMenu.Style:=spkMetroDark;
    StMenu.Color:=$080808;
  end;
  if dmconn.theme_app = 'ligth' then
  begin
    StMenu.Style:=spkMetroLight;
    StMenu.Color:=clSilver;
  end;
  ZQProveedores.Open;
  SbMsjs.Panels[0].Text:='Total de proveedores: ' +
  ZQProveedores.RecordCount.ToString;
end;

procedure TFrmProveedores.MICompletaClick(Sender: TObject);
begin
  { Exportación completa de proveedores }
end;

procedure TFrmProveedores.MIVistaClick(Sender: TObject);
begin
  SDFile.Filter:='Excel|*.xlsx';
  SDFile.Title:='Exportar proveedores';

  if DgProveedores.DataSource.DataSet.RecordCount = 0 then
    begin
         Application.MessageBox('No hay datos para exportar', 'Datos necesarios',
         MB_ICONEXCLAMATION);
         exit;
    end;
  if SDFile.Execute then
    begin
     ToExcel.RxDBGrid:=DgProveedores;
     ToExcel.Caption:='Exportar vista';
     ToExcel.FileName:=SDFile.FileName;
     ToExcel.OpenAfterExport:=True;
     ToExcel.PageName:='Proveedores';
     if ToExcel.Execute then
       begin
            Application.MessageBox('Exportación finalizada exitosamente',
            'Exportación', MB_ICONINFORMATION);
            ToExcel.Free;
       end
    end
end;

procedure TFrmProveedores.BtnAgregarClick(Sender: TObject);
begin
  FrmProveedor:=TFrmProveedor.Create(FrmProveedores);
  FrmProveedor.edit:=false;
  if FrmProveedor.ShowModal = mrOK then
  begin
    // Recargar datos de la tabla de proveedores
    ZQProveedores.Close;
    ZQProveedores.Open;
  end;
end;

procedure TFrmProveedores.BtnBajaClick(Sender: TObject);
var
  prov_id:integer;
  empresa:string;
begin
  prov_id:=StrToInt(DgProveedores.DataSource.DataSet.Fields[0].Value);
  empresa:=DgProveedores.DataSource.DataSet.Fields[1].Value;

  if MessageDlg('Confirmación', '¿Desea eliminar la empresa ' + empresa + '?',
  mtConfirmation, [mbYes, mbNo],0) = mrYes
  then
  begin
    ZQProv.SQL.Text:='UPDATE proveedores SET estatus = 0 WHERE id_proveedor ='+
    ' :prov_id';
    ZQProv.Params.ParamByName('prov_id').AsInteger:=prov_id;
    ZQProv.ExecSQL;
    ZQProveedores.Close;
    ZQProveedores.Open;
  end;
end;

procedure TFrmProveedores.BtnEditarClick(Sender: TObject);
var
  prov_id:integer;
begin
  FrmProveedor:=TFrmProveedor.Create(FrmProveedores);
  //Obtener datos del proveedor
  prov_id:=StrToInt(DgProveedores.DataSource.DataSet.Fields[0].Value);
  FrmProveedor.prov_id:=prov_id;
  FrmProveedor.edit:=true;
  if FrmProveedor.ShowModal = mrOK then
  begin
    // Recargar datos de la tabla de proveedores
    ZQProveedores.Close;
    ZQProveedores.Open;
  end;
end;

end.

