program lzinvent;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}{$IFDEF UseCThreads}
  cthreads,
  {$ENDIF}{$ENDIF}
  Interfaces, // this includes the LCL widgetset
  Forms, zcomponent, rxnew, virtualdbgrid_package, u_frmprincipal, m_conn,
  u_frmlistarusuarios, u_frmadduser, u_frmrolespermisos, m_user, m_empleados,
  u_frmaddemployee, u_frmareas, u_frmcatsub, u_frmplaces, u_frmbajas,
  u_frmmarcas, u_frmestatus, u_frmproveedores, u_frmproveedor, u_frmaddbien,
  lazreportpdfexport, StringsFormat, u_frmconfig, u_frmlogin, u_frmbajabien,
  u_frmbuscarbien, m_bienes;

{$R *.res}

begin
  RequireDerivedFormResource:=True;
  Application.Scaled:=True;
  Application.Initialize;
  Application.CreateForm(Tdmconn, dmconn);
  Application.CreateForm(TFrmLogin, FrmLogin);
  Application.CreateForm(TFrmPrincipal, FrmPrincipal);
  Application.CreateForm(TFrmListaUsuarios, FrmListaUsuarios);
  Application.CreateForm(TFrmUser, FrmUser);
  Application.CreateForm(TFrmRolesPermisos, FrmRolesPermisos);
  Application.CreateForm(TDMUser, DMUser);
  Application.CreateForm(Tdmempleados, dmempleados);
  Application.CreateForm(TFrmAddEmpleado, FrmAddEmpleado);
  Application.CreateForm(TFrmAreas, FrmAreas);
  Application.CreateForm(TFrmCategorias, FrmCategorias);
  Application.CreateForm(TFrmPlaces, FrmPlaces);
  Application.CreateForm(TFrmBajas, FrmBajas);
  Application.CreateForm(TFrmMarca, FrmMarca);
  Application.CreateForm(TFrmEstatus, FrmEstatus);
  Application.CreateForm(TFrmProveedores, FrmProveedores);
  Application.CreateForm(TFrmProveedor, FrmProveedor);
  Application.CreateForm(TFrmAddBien, FrmAddBien);
  Application.CreateForm(TFrmConfig, FrmConfig);
  Application.CreateForm(TFrmBaja, FrmBaja);
  Application.CreateForm(TFrmBuscarBien, FrmBuscarBien);
  Application.CreateForm(TDmBienes, DmBienes);
  Application.Run;
end.

