program lzinvent;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}{$IFDEF UseCThreads}
  cthreads,
  {$ENDIF}{$ENDIF}
  Interfaces, // this includes the LCL widgetset
  Forms, zcomponent, rxnew, u_frmprincipal, m_conn, u_frmlistarusuarios, u_frmadduser
  { you can add units after this };

{$R *.res}

begin
  RequireDerivedFormResource:=True;
  Application.Scaled:=True;
  Application.Initialize;
  Application.CreateForm(Tdmconn, dmconn);
  Application.CreateForm(TFrmPrincipal, FrmPrincipal);
  Application.CreateForm(TFrmListaUsuarios, FrmListaUsuarios);
  Application.CreateForm(TFrmUser, FrmUser);
  Application.Run;
end.

