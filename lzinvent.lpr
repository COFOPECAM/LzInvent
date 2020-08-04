program lzinvent;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}{$IFDEF UseCThreads}
  cthreads,
  {$ENDIF}{$ENDIF}
  Interfaces, // this includes the LCL widgetset
  Forms, printer4lazarus, datetimectrls, zcomponent, rxnew,
  virtualdbgrid_package, u_frmprincipal, m_conn, u_frmlistarusuarios,
  u_frmadduser, u_frmrolespermisos, m_user, m_empleados, u_frmaddemployee,
  u_frmareas, u_frmcatsub, u_frmplaces, u_frmbajas, u_frmmarcas, u_frmestatus,
  u_frmproveedores, u_frmproveedor, u_frmaddbien, lazreportpdfexport,
  StringsFormat, u_frmconfig, u_frmlogin, u_frmbajabien, u_frmbuscarbien,
  m_bienes, u_frmgenclave, u_frmsearchproveedor, u_frmcampanas,
  u_frmaddprograma, u_frmlistcampanas, u_frmconsumibles, m_consumibles,
  u_frmaddconsumible, u_frmaddconsumiblecat, u_frmaddbuy, u_frmentrega, u_frmreports;

{$R *.res}

begin
  RequireDerivedFormResource:=True;
  Application.Scaled:=True;
  Application.Initialize;
  Application.CreateForm(Tdmconn, dmconn);
  Application.CreateForm(TDmBienes, DmBienes);
  Application.CreateForm(Tdmempleados, dmempleados);
  Application.CreateForm(TDMUser, DMUser);
  Application.CreateForm(TDmConsumibles, DmConsumibles);
  Application.CreateForm(TFrmLogin, FrmLogin);
  Application.Run;
end.

