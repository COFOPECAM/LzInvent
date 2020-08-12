unit u_frmprincipal;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ComCtrls, rxdbgrid,
  RxDBGridFooterTools, RxDBGridExportSpreadSheet, RxSortZeos, SpkToolbar,
  spkt_Tab, spkt_Pane, spkt_Buttons, u_frmlistarusuarios, m_conn, db, ZDataset,
  spkt_Appearance, u_frmaddemployee, m_empleados, u_frmareas, LCLType, ExtCtrls,
  StdCtrls, uPoweredby, u_frmcatsub, u_frmplaces, u_frmbajas, u_frmmarcas,
  u_frmestatus, u_frmproveedores, u_frmaddbien, LR_Class, LR_DBSet, LR_Shape,
  PrintersDlgs, lr_e_pdf, u_frmconfig, u_frmbajabien, u_frmbuscarbien, m_bienes,
  u_frmcampanas, process, u_frmsearchproveedor, u_frmconsumibles, u_frmentrega,
  u_frmreports;

type

  { TFrmPrincipal }

  TFrmPrincipal = class(TForm)
    DSEntregas: TDataSource;
    DgBienes: TRxDBGrid;
    DSBienes: TDataSource;
    DBReport: TfrDBDataSet;
    DbResEmpleado: TfrDBDataSet;
    frShapeObject1: TfrShapeObject;
    Poweredby: TPoweredby;
    PrintDialog1: TPrintDialog;
    RpToPDF: TfrTNPDFExport;
    LzReports: TfrReport;
    ILRb: TImageList;
    RbBAgregar: TSpkLargeButton;
    DgEmpleados: TRxDBGrid;
    FGBienes: TRxDBGridFooterTools;
    FGConsumibles: TRxDBGridFooterTools;
    RxSortZeos1: TRxSortZeos;
    BtnCPrograma: TSpkLargeButton;
    BtnConsumibles: TSpkLargeButton;
    SpkLargeButton1: TSpkLargeButton;
    TConsumibles: TRxDBGrid;
    SDFile: TSaveDialog;
    RbBtnConfig: TSpkLargeButton;
    BtnGenEtiqueta: TSpkLargeButton;
    SpkLargeButton10: TSpkLargeButton;
    BtnAbout: TSpkLargeButton;
    SpkLargeButton12: TSpkLargeButton;
    SpkLargeButton2: TSpkLargeButton;
    BtnEConsumible: TSpkLargeButton;
    SpkLargeButton7: TSpkLargeButton;
    BtnHelp: TSpkLargeButton;
    SpkPane10: TSpkPane;
    SpkPane11: TSpkPane;
    SpkPane12: TSpkPane;
    SpkPane13: TSpkPane;
    SpkTab1: TSpkTab;
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
    BtnReportes: TSpkLargeButton;
    RbCfListar: TSpkLargeButton;
    SpkLargeButton25: TSpkLargeButton;
    RbBtnBBuscar: TSpkLargeButton;
    RBtnBBaja: TSpkLargeButton;
    BtnResguardoIndividual: TSpkLargeButton;
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
    procedure BtnAboutClick(Sender: TObject);
    procedure BtnConsumiblesClick(Sender: TObject);
    procedure BtnCProgramaClick(Sender: TObject);
    procedure BtnCtAreasClick(Sender: TObject);
    procedure BtnEAddClick(Sender: TObject);
    procedure BtnEBajaClick(Sender: TObject);
    procedure BtnEConsumibleClick(Sender: TObject);
    procedure BtnEToExcelClick(Sender: TObject);
    procedure BtnHelpClick(Sender: TObject);
    procedure BtnRbBEditarClick(Sender: TObject);
    procedure BtnRbBResguardoClick(Sender: TObject);
    procedure BtnRbBToExcelClick(Sender: TObject);
    procedure BtnRbCBajasClick(Sender: TObject);
    procedure BtnRbCLugaresClick(Sender: TObject);
    procedure BtnRbCMarcasClick(Sender: TObject);
    procedure BtnRbCProveedoresClick(Sender: TObject);
    procedure BtnRbEResguardoClick(Sender: TObject);
    procedure BtnReportesClick(Sender: TObject);
    procedure BtnResguardoIndividualClick(Sender: TObject);
    procedure DgBienesDblClick(Sender: TObject);
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
    procedure BtnGenEtiquetaClick(Sender: TObject);
    procedure StMenuTabChanged(Sender: TObject);
  private

  public

  end;

var
  FrmPrincipal: TFrmPrincipal;
  PrintEtiqueta: TProcess;

implementation

{$R *.lfm}

{ TFrmPrincipal }

procedure TFrmPrincipal.RbBAgregarClick(Sender: TObject);
begin
  FrmAddBien:=TFrmAddBien.Create(FrmPrincipal);
  FrmAddBien.show_baja:=false;
  if FrmAddBien.ShowModal = mrOK then
  begin
   DgBienes.DataSource:=DSBienes;
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
   DgBienes.DataSource:=DmBienes.DSSearch;
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
  // Ajustar tablas al client
  DgBienes.Align:=alClient;
  DgEmpleados.Align:=alClient;
  TConsumibles.Align:=alClient;
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
{  dmconn.ZQFirmasReport.Close;
  dmconn.ZQFirmasReport.Params.ParamByName('bien_id').AsInteger:=StrToInt(DgBienes.DataSource.DataSet.Fields[0].Value);
  dmconn.ZQFirmasReport.Open;}
  if ParName = 'recibe' then
     // ParValue:=dmconn.ZQFirmasReport.FieldByName('empleado').AsString;
  if ParName = 'entrega' then
     ParValue:=dmconn.Entrega;
  if ParName = 'fechaif' then
     ParValue:=dmconn.MostrarFechaResg;
  if ParName = 'direccion' then
     ParValue:=dmconn.DirEmpresa;
  if ParName = 'empresa' then
     ParValue:=dmconn.Empresa;

  // Datos de la etiqueta
  if ParName = 'lugar' then
     ParValue:=DgBienes.DataSource.DataSet.Fields[10].AsString;
  if ParName = 'clave' then
     ParValue:=DgBienes.DataSource.DataSet.Fields[5].AsString;
  if ParName = 'fecha' then
     ParValue:=DgBienes.DataSource.DataSet.Fields[8].AsDateTime;
  if ParName = 'codigo' then
     ParValue:=DgBienes.DataSource.DataSet.Fields[6].AsString;
  if ParName = 'programa' then
     ParValue:=DgBienes.DataSource.DataSet.Fields[17].AsString;
end;

procedure TFrmPrincipal.BtnEAddClick(Sender: TObject);
begin
  FrmAddEmpleado:=TFrmAddEmpleado.Create(FrmPrincipal);
  if FrmAddEmpleado.ShowModal = mrOK then
  begin
    dmempleados.ZQGetEmpleados.Close;
    // dmempleados.ZQGetEmpleados.Params.ParamByName('estatus').AsInteger:=1;
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

procedure TFrmPrincipal.BtnEConsumibleClick(Sender: TObject);
begin
  // Entregar material
  FrmEntrega:=TFrmEntrega.Create(FrmPrincipal);
  if FrmEntrega.ShowModal = mrOK then
  begin
    // Actualizar datos de las entregas
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

procedure TFrmPrincipal.BtnHelpClick(Sender: TObject);
var
  Pros: TProcess;
begin
  // Abrir pdf con la ayuda del programa
  try
    Pros:=TProcess.Create(nil);
    Pros.Executable:='docs/help.pdf';
    Pros.Execute;
  except
    Application.MessageBox('No fue encontrado el manual de usuario',
    'Archivo no encontrado', MB_ICONEXCLAMATION);
  end;
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
   FrmAddBien.Programa:=DgBienes.DataSource.DataSet.Fields[17].AsString;
   FrmAddBien.ShowModal;
   ZQBienes.Refresh;
  end;
end;

procedure TFrmPrincipal.BtnRbBResguardoClick(Sender: TObject);
var
  bien_id:integer;
  empleado: string;
begin
  empleado:=DgBienes.DataSource.DataSet.Fields[13].AsString;
  if empleado.IsEmpty then
  begin
   Application.MessageBox('El bien no se encuentra asignado a ningun empleado',
   'Falta asignación', MB_ICONINFORMATION);
   exit;
  end;

  if DgBienes.DataSource.DataSet.RecordCount > 0 then
  begin
    bien_id:=StrToInt(DgBienes.DataSource.DataSet.Fields[0].Value);
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
  FrmBajas:=TFrmBajas.Create(FrmPrincipal);
  FrmBajas.ShowModal;
end;

procedure TFrmPrincipal.BtnRbCLugaresClick(Sender: TObject);
begin
  FrmPlaces:=TFrmPlaces.Create(FrmPrincipal);
  FrmPlaces.ShowModal;
end;

procedure TFrmPrincipal.BtnRbCMarcasClick(Sender: TObject);
begin
  FrmMarca:=TFrmMarca.Create(FrmPrincipal);
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
  ZQResEmpleado.Params.ParamByName('empl').AsInteger:=emp_id;
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

procedure TFrmPrincipal.BtnReportesClick(Sender: TObject);
begin
  // Ver lista de reportes
  FrmReports:=TFrmReports.Create(FrmPrincipal);
  FrmReports.ShowModal;
end;

procedure TFrmPrincipal.BtnResguardoIndividualClick(Sender: TObject);
begin
  FrmResguardo:=TFrmResguardo.Create(FrmPrincipal);
  FrmResguardo.bien_id:=DgBienes.DataSource.DataSet.Fields[0].AsInteger;
  if FrmResguardo.ShowModal = mrOK then
  begin
   ZQBienes.Refresh;
  end;
end;

procedure TFrmPrincipal.DgBienesDblClick(Sender: TObject);
var
  bien_id: integer;
begin
  // Editar los datos del bien
  bien_id:=StrToInt(DgBienes.DataSource.DataSet.Fields[0].Value);
  if bien_id <> 0 then
  begin
   FrmAddBien:=TFrmAddBien.Create(nil);
   FrmAddBien.edit:=true;
   FrmAddBien.bien_id:=bien_id;
   FrmAddBien.Programa:=DgBienes.DataSource.DataSet.Fields[17].AsString;
   FrmAddBien.ShowModal;
   ZQBienes.Refresh;
  end;
end;

procedure TFrmPrincipal.BtnCtAreasClick(Sender: TObject);
begin
  FrmAreas := TFrmAreas.Create(FrmPrincipal);
  FrmAreas.ShowModal;
end;

procedure TFrmPrincipal.BtbCCatClick(Sender: TObject);
begin
  // Categorias
  FrmCategorias:=TFrmCategorias.Create(FrmPrincipal);
  FrmCategorias.ShowModal;
end;

procedure TFrmPrincipal.BtnAboutClick(Sender: TObject);
begin
  Poweredby.ShowPoweredByForm;
end;

procedure TFrmPrincipal.BtnConsumiblesClick(Sender: TObject);
begin
  FrmConsumibles:=TFrmConsumibles.Create(FrmPrincipal);
  FrmConsumibles.ShowModal;
end;

procedure TFrmPrincipal.BtnCProgramaClick(Sender: TObject);
begin
  FrmCampanas:=TFrmCampanas.Create(FrmPrincipal);
  FrmCampanas.ShowModal;
end;

procedure TFrmPrincipal.RbCfListarClick(Sender: TObject);
begin
  FrmListaUsuarios := TFrmListaUsuarios.Create(FrmPrincipal);
  FrmListaUsuarios.ShowModal;
end;

procedure TFrmPrincipal.BtmEEditarClick(Sender: TObject);
var
  empl_id:integer;
begin
  empl_id:=StrToInt(DgEmpleados.DataSource.DataSet.Fields[0].Value);
  FrmAddEmpleado:=TFrmAddEmpleado.Create(FrmPrincipal);
  FrmAddEmpleado.empl_id:=empl_id;
  FrmAddEmpleado.edit:=true;
  if FrmAddEmpleado.ShowModal = mrOK then
  begin
    dmempleados.ZQGetEmpleados.Close;
    // dmempleados.ZQGetEmpleados.Params.ParamByName('estatus').AsInteger:=1;
    dmempleados.ZQGetEmpleados.Open;
  end;
end;

procedure TFrmPrincipal.BtnRbCEstatusClick(Sender: TObject);
begin
  FrmEstatus:=TFrmEstatus.Create(nil);
  FrmEstatus.ShowModal;
end;

procedure TFrmPrincipal.RBtnBBajaClick(Sender: TObject);
begin
  // Dar de baja el bien
  // Preguntar si se dara de baja
  FrmAddBien:=TFrmAddBien.Create(FrmPrincipal);
  FrmAddBien.bien_id:=StrToInt(DgBienes.DataSource.DataSet.Fields[0].Value);
  FrmAddBien.show_baja:=true;
  FrmAddBien.edit:=True;
  if FrmAddBien.ShowModal = mrOK then
  begin
   // Recargar tabla para eliminar registro de la vista
   ZQBienes.Refresh;
  end;
end;

procedure TFrmPrincipal.BtnGenEtiquetaClick(Sender: TObject);
begin
  {Obtener los datos para generar el codigo de barras}
  LzReports.LoadFromFile('../../reports/rpEtiqueta.lrf');
  LzReports.Title:='Etiqueta';
  LzReports.ShowReport;
end;

procedure TFrmPrincipal.StMenuTabChanged(Sender: TObject);
begin
  if StMenu.TabIndex = 0 then
  begin
    DgBienes.BringToFront;
  end;
  if StMenu.TabIndex = 1 then
  begin
   TConsumibles.BringToFront;
  end;
  if StMenu.TabIndex = 2 then
  begin
    DgEmpleados.BringToFront;
    // dmempleados.ZQGetEmpleados.Close;
    // dmempleados.ZQGetEmpleados.Params.ParamByName('estatus').AsInteger:=1;
    // dmempleados.ZQGetEmpleados.Open;
  end;
end;

end.

