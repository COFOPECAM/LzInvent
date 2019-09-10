unit u_frmprincipal;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ComCtrls, rxdbgrid,
  RxDBGridExportSpreadSheet, SpkToolbar, spkt_Tab, spkt_Pane, spkt_Buttons,
  u_frmlistarusuarios, m_conn, db, ZDataset, spkt_Appearance, u_frmaddemployee,
  m_empleados, u_frmareas, LCLType, u_frmcatsub, u_frmplaces, u_frmbajas,
  u_frmmarcas, u_frmestatus, u_frmproveedores, u_frmaddbien, LR_Class, LR_DBSet,
  LR_Shape, lr_e_pdf, u_frmconfig, u_frmbajabien, u_frmbuscarbien;

type

  { TFrmPrincipal }

  TFrmPrincipal = class(TForm)
    DSBienes: TDataSource;
    DBReport: TfrDBDataSet;
    DbResEmpleado: TfrDBDataSet;
    frShapeObject1: TfrShapeObject;
    RpToPDF: TfrTNPDFExport;
    LzReports: TfrReport;
    ILRb: TImageList;
    RbBAgregar: TSpkLargeButton;
    DgBienes: TRxDBGrid;
    DgEmpleados: TRxDBGrid;
    SDFile: TSaveDialog;
    RbBtnConfig: TSpkLargeButton;
    SpkLargeButton10: TSpkLargeButton;
    SpkLargeButton11: TSpkLargeButton;
    SpkLargeButton2: TSpkLargeButton;
    SpkLargeButton7: TSpkLargeButton;
    SpkLargeButton9: TSpkLargeButton;
    SpkPane10: TSpkPane;
    SpkPane11: TSpkPane;
    ToExcel: TRxDBGridExportSpreadSheet;
    BtnRbCProveedores: TSpkLargeButton;
    BtnEAdd: TSpkLargeButton;
    BtmEEditar: TSpkLargeButton;
    BtnEBaja: TSpkLargeButton;
    SpkLargeButton13: TSpkLargeButton;
    SpkLargeButton14: TSpkLargeButton;
    BtnRbEResguardo: TSpkLargeButton;
    BtnEToExcel: TSpkLargeButton;
    BtnCtAreas: TSpkLargeButton;
    BtbCCat: TSpkLargeButton;
    BtnRbCLugares: TSpkLargeButton;
    BtnRbBEditar: TSpkLargeButton;
    BtnRbCBajas: TSpkLargeButton;
    BtnRbCMarcas: TSpkLargeButton;
    BtnRbCEstatus: TSpkLargeButton;
    SpkLargeButton23: TSpkLargeButton;
    RbCfListar: TSpkLargeButton;
    SpkLargeButton25: TSpkLargeButton;
    RbBtnBBuscar: TSpkLargeButton;
    RBtnBBaja: TSpkLargeButton;
    SpkLargeButton5: TSpkLargeButton;
    SpkLargeButton6: TSpkLargeButton;
    BtnRbBResguardo: TSpkLargeButton;
    SpkLargeButton8: TSpkLargeButton;
    BtnRbBToExcel: TSpkLargeButton;
    SpkPane1: TSpkPane;
    SpkPane2: TSpkPane;
    SpkPane3: TSpkPane;
    SpkPane4: TSpkPane;
    SpkPane5: TSpkPane;
    SpkPane6: TSpkPane;
    SpkPane7: TSpkPane;
    SpkPane8: TSpkPane;
    SpkPane9: TSpkPane;
    SbMsjs: TStatusBar;
    TBienes: TSpkTab;
    TEmpleados: TSpkTab;
    TCatalogos: TSpkTab;
    TConfig: TSpkTab;
    StMenu: TSpkToolbar;
    ZQBienes: TZQuery;
    ZQBienReport: TZQuery;
    ZQResEmpleado: TZQuery;
    procedure BtbCCatClick(Sender: TObject);
    procedure BtnCtAreasClick(Sender: TObject);
    procedure BtnEAddClick(Sender: TObject);
    procedure BtnEBajaClick(Sender: TObject);
    procedure BtnEToExcelClick(Sender: TObject);
    procedure BtnRbBEditarClick(Sender: TObject);
    procedure BtnRbBResguardoClick(Sender: TObject);
    procedure BtnRbBToExcelClick(Sender: TObject);
    procedure BtnRbCBajasClick(Sender: TObject);
    procedure BtnRbCLugaresClick(Sender: TObject);
    procedure BtnRbCMarcasClick(Sender: TObject);
    procedure BtnRbCProveedoresClick(Sender: TObject);
    procedure BtnRbEResguardoClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure LzReportsGetValue(const ParName: String; var ParValue: Variant);
    procedure RbBAgregarClick(Sender: TObject);
    procedure RbBtnBBuscarClick(Sender: TObject);
    procedure RbBtnConfigClick(Sender: TObject);
    procedure RbCfListarClick(Sender: TObject);
    procedure BtmEEditarClick(Sender: TObject);
    procedure BtnRbCEstatusClick(Sender: TObject);
    procedure RBtnBBajaClick(Sender: TObject);
    procedure StMenuTabChanged(Sender: TObject);
  private

  public

  end;

var
  FrmPrincipal: TFrmPrincipal;

implementation

{$R *.lfm}

{ TFrmPrincipal }

procedure TFrmPrincipal.RbBAgregarClick(Sender: TObject);
begin
  FrmAddBien:=TFrmAddBien.Create(FrmPrincipal);
  FrmAddBien.show_baja:=false;
  if FrmAddBien.ShowModal = mrOK then
  begin
   ZQBienes.Close;
   ZQBienes.Open;
  end;
end;

procedure TFrmPrincipal.RbBtnBBuscarClick(Sender: TObject);
begin
  FrmBuscarBien:=TFrmBuscarBien.Create(FrmPrincipal);
  if FrmBuscarBien.ShowModal = mrOK then
  begin
   // Mostrar datos en la tabla principal de bienes
  end;
end;

procedure TFrmPrincipal.RbBtnConfigClick(Sender: TObject);
begin
  FrmConfig:=TFrmConfig.Create(FrmPrincipal);
  FrmConfig.ShowModal;
end;

procedure TFrmPrincipal.FormCreate(Sender: TObject);
begin
  { Settear configuraciones de la aplicación }
  if dmconn.Theme = '1' then
  begin
    StMenu.Style:=spkOffice2007Blue;
    StMenu.Color:=clSkyBlue;
  end;
  if dmconn.Theme = '3' then
  begin
    StMenu.Style:=spkOffice2007Silver;
    StMenu.Color:=clWhite;
  end;
  if dmconn.Theme = '0' then
  begin
    StMenu.Style:=spkMetroDark;
    StMenu.Color:=$080808;
  end;
  if dmconn.Theme = '2' then
  begin
    StMenu.Style:=spkMetroLight;
    StMenu.Color:=clSilver;
  end;
end;

procedure TFrmPrincipal.FormShow(Sender: TObject);
begin
  // Abrir conexiones y llenar tablas
  ZQBienes.Params.ParamByName('limit_show').AsInteger:=50;
  ZQBienes.Open;
  // Cargar permisos de la aplicación

  // Cargar configuraciones
  SbMsjs.Panels[0].Text:='Usuario: ' + dmconn.Apellido + ', ' + dmconn.Nombre;
end;

procedure TFrmPrincipal.LzReportsGetValue(const ParName: String;
  var ParValue: Variant);
begin
  if ParName = 'autoriza' then
     ParValue:=dmconn.Autoriza;
  dmconn.ZQFirmasReport.Close;
  dmconn.ZQFirmasReport.Params.ParamByName('bien_id').AsInteger:=StrToInt(DgBienes.DataSource.DataSet.Fields[0].Value);
  dmconn.ZQFirmasReport.Open;
  if ParName = 'recibe' then
     ParValue:=dmconn.ZQFirmasReport.FieldByName('empleado').AsString;
  if ParName = 'entrega' then
     ParValue:=dmconn.Entrega;
  if ParName = 'fechaif' then
     ParValue:=dmconn.MostrarFechaResg;
  if ParName = 'direccion' then
     ParValue:=dmconn.DirEmpresa;
  if ParName = 'empresa' then
     ParValue:=dmconn.Empresa;
end;

procedure TFrmPrincipal.BtnEAddClick(Sender: TObject);
begin
  if FrmAddEmpleado.ShowModal = mrOK then
  begin
    dmempleados.ZQGetEmpleados.Close;
    dmempleados.ZQGetEmpleados.Params.ParamByName('estatus').AsInteger:=1;
    dmempleados.ZQGetEmpleados.Open;
  end;
end;

procedure TFrmPrincipal.BtnEBajaClick(Sender: TObject);
var
  empl_id: integer;
  nombre: string;
begin
  empl_id:=StrToInt(DgEmpleados.DataSource.DataSet.Fields[0].Value);
  nombre:=DgEmpleados.DataSource.DataSet.Fields[1].Value + ' ' +
  DgEmpleados.DataSource.DataSet.Fields[2].Value;

  if MessageDlg('Confirmación', '¿Desea dar de baja al empleado ' + nombre + '?',
  mtConfirmation, [mbYes, mbNo],0) = mrYes
  then
  begin
    dmempleados.ZQAdd.SQL.Text:='UPDATE empleados SET estatus = :estatus WHERE'+
    ' id_empleado = :empl_id';
    dmempleados.ZQAdd.Params.ParamByName('estatus').AsInteger:=0;
    dmempleados.ZQAdd.Params.ParamByName('empl_id').AsInteger:=empl_id;
    dmempleados.ZQAdd.ExecSQL;
    dmempleados.ZQGetEmpleados.Close;
    dmempleados.ZQGetEmpleados.Open;
  end;
end;

procedure TFrmPrincipal.BtnEToExcelClick(Sender: TObject);
begin
  SDFile.Filter:='Excel|*.xlsx';
  SDFile.Title:='Exportar empleados';

  if DgEmpleados.DataSource.DataSet.RecordCount = 0 then
    begin
         Application.MessageBox('No hay datos para exportar', 'Datos necesarios',
         MB_ICONEXCLAMATION);
         exit;
    end;
  if SDFile.Execute then
    begin
     ToExcel.RxDBGrid:=DgEmpleados;
     ToExcel.Caption:='Exportar vista';
     ToExcel.FileName:=SDFile.FileName;
     ToExcel.OpenAfterExport:=True;
     ToExcel.PageName:='Empleados';
     if ToExcel.Execute then
       begin
            Application.MessageBox('Exportación finalizada exitosamente',
            'Exportación', MB_ICONINFORMATION);
            ToExcel.Free;
       end
    end
end;

procedure TFrmPrincipal.BtnRbBEditarClick(Sender: TObject);
var
  bien_id:integer;
begin
  // Editar los datos del bien
  bien_id:=StrToInt(DgBienes.DataSource.DataSet.Fields[0].Value);
  if bien_id <> 0 then
  begin
   FrmAddBien:=TFrmAddBien.Create(nil);
   FrmAddBien.edit:=true;
   FrmAddBien.bien_id:=bien_id;
   if FrmAddBien.ShowModal = mrOK then
   begin
    ZQBienes.Close;
    ZQBienes.Open;
   end;
  end;
end;

procedure TFrmPrincipal.BtnRbBResguardoClick(Sender: TObject);
var
  bien_id:integer;
begin
  bien_id:=StrToInt(DgBienes.DataSource.DataSet.Fields[0].Value);
  if bien_id <> 0 then
  begin
   // ToDo: Verificar si el bien ya fue asignado a un empleado, en caso contrario
   // Mostrar mensaje de que el bien se encuentra en almancen
   ZQBienReport.Close;
   // Buscar bien por id
   ZQBienReport.Params.ParamByName('bien_id').AsInteger:=bien_id;
   ZQBienReport.Open;
   LzReports.LoadFromFile('../../reports/rpResguardoBien.lrf');
   LzReports.ShowReport;
  end;
end;

procedure TFrmPrincipal.BtnRbBToExcelClick(Sender: TObject);
begin
  SDFile.Filter:='Excel|*.xlsx';
  SDFile.Title:='Exportar bienes';

  if DgBienes.DataSource.DataSet.RecordCount = 0 then
    begin
         Application.MessageBox('No hay datos para exportar', 'Datos necesarios',
         MB_ICONEXCLAMATION);
         exit;
    end;
  if SDFile.Execute then
    begin
     ToExcel.RxDBGrid:=DgBienes;
     ToExcel.Caption:='Exportar vista';
     ToExcel.FileName:=SDFile.FileName;
     ToExcel.OpenAfterExport:=True;
     ToExcel.PageName:='Bienes';
     if ToExcel.Execute then
       begin
            Application.MessageBox('Exportación finalizada exitosamente',
            'Exportación', MB_ICONINFORMATION);
            ToExcel.Free;
       end
    end
end;

procedure TFrmPrincipal.BtnRbCBajasClick(Sender: TObject);
begin
  FrmBajas:=TFrmBajas.Create(nil);
  FrmBajas.ShowModal;
end;

procedure TFrmPrincipal.BtnRbCLugaresClick(Sender: TObject);
begin
  FrmPlaces:=TFrmPlaces.Create(nil);
  FrmPlaces.ShowModal;
end;

procedure TFrmPrincipal.BtnRbCMarcasClick(Sender: TObject);
begin
  FrmMarca:=TFrmMarca.Create(nil);
  FrmMarca.ShowModal;
end;

procedure TFrmPrincipal.BtnRbCProveedoresClick(Sender: TObject);
begin
  FrmProveedores:=TFrmProveedores.Create(FrmPrincipal);
  FrmProveedores.ShowModal;
end;

procedure TFrmPrincipal.BtnRbEResguardoClick(Sender: TObject);
var
  emp_id:integer;
begin
  // Obtener un resguardo general de bienes del empleado
  emp_id:=StrToInt(DgEmpleados.DataSource.DataSet.Fields[0].Value);
  ZQResEmpleado.Close;
  ZQResEmpleado.Params.ParamByName('empl_id').AsInteger:=emp_id;
  ZQResEmpleado.Open;
  if ZQResEmpleado.RecordCount > 0 then
  begin
    LzReports.LoadFromFile('../../reports/rpResguardoEmpleado.lrf');
    LzReports.ShowReport;
  end
  else
  begin
    Application.MessageBox('No se obtuvieron bienes asignado al empleado',
    'Sin datos', MB_ICONINFORMATION);
  end;

end;

procedure TFrmPrincipal.BtnCtAreasClick(Sender: TObject);
begin
  FrmAreas.ShowModal;
end;

procedure TFrmPrincipal.BtbCCatClick(Sender: TObject);
begin
  // Categorias
  FrmCategorias.ShowModal;
end;

procedure TFrmPrincipal.RbCfListarClick(Sender: TObject);
begin
  FrmListaUsuarios.ShowModal;
end;

procedure TFrmPrincipal.BtmEEditarClick(Sender: TObject);
var
  empl_id:integer;
begin
  empl_id:=StrToInt(DgEmpleados.DataSource.DataSet.Fields[0].Value);
  FrmAddEmpleado.empl_id:=empl_id;
  FrmAddEmpleado.edit:=true;
  if FrmAddEmpleado.ShowModal = mrOK then
  begin
    dmempleados.ZQGetEmpleados.Close;
    dmempleados.ZQGetEmpleados.Params.ParamByName('estatus').AsInteger:=1;
    dmempleados.ZQGetEmpleados.Open;
  end;
end;

procedure TFrmPrincipal.BtnRbCEstatusClick(Sender: TObject);
begin
  FrmEstatus:=TFrmEstatus.Create(nil);
  FrmEstatus.ShowModal;
end;

procedure TFrmPrincipal.RBtnBBajaClick(Sender: TObject);
var
  bien_id: integer;
begin
  // Dar de baja el bien
  bien_id:=StrToInt(DgBienes.DataSource.DataSet.Fields[0].Value);
  // Preguntar si se dara de baja
  FrmBaja:=TFrmBaja.Create(FrmPrincipal);
  FrmBaja.Bien_id:=bien_id;
  if FrmBaja.ShowModal = mrOK then
  begin
   // Recargar tabla para eliminar registro de la vista
   ZQBienes.Close;
   ZQBienes.Open;
  end;
end;

procedure TFrmPrincipal.StMenuTabChanged(Sender: TObject);
begin
  if StMenu.TabIndex = 0 then
  begin
    DgBienes.BringToFront;
    DgBienes.Align:=alClient;

    DgEmpleados.Align:=alNone;
    DgEmpleados.SendToBack;
  end;
  if StMenu.TabIndex = 1 then
  begin
    DgEmpleados.Align:=alClient;
    DgEmpleados.BringToFront;

    DgBienes.SendToBack;
    DgBienes.Align:=alNone;
    dmempleados.ZQGetEmpleados.Close;
    dmempleados.ZQGetEmpleados.Params.ParamByName('estatus').AsInteger:=1;
    dmempleados.ZQGetEmpleados.Open;
  end;
end;

end.

