unit u_frmprincipal;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ComCtrls, rxdbgrid,
  SpkToolbar, spkt_Tab, spkt_Pane, spkt_Buttons, BCrypt, u_frmlistarusuarios,
  m_conn, db, ZDataset, spkt_Appearance;

type

  { TFrmPrincipal }

  TFrmPrincipal = class(TForm)
    DSBienes: TDataSource;
    ILRb: TImageList;
    RbBAgregar: TSpkLargeButton;
    DgBienes: TRxDBGrid;
    DgEmpleados: TRxDBGrid;
    SpkLargeButton1: TSpkLargeButton;
    SpkLargeButton10: TSpkLargeButton;
    SpkLargeButton11: TSpkLargeButton;
    SpkLargeButton12: TSpkLargeButton;
    SpkLargeButton13: TSpkLargeButton;
    SpkLargeButton14: TSpkLargeButton;
    SpkLargeButton15: TSpkLargeButton;
    SpkLargeButton16: TSpkLargeButton;
    SpkLargeButton17: TSpkLargeButton;
    SpkLargeButton18: TSpkLargeButton;
    SpkLargeButton19: TSpkLargeButton;
    SpkLargeButton2: TSpkLargeButton;
    SpkLargeButton20: TSpkLargeButton;
    SpkLargeButton21: TSpkLargeButton;
    SpkLargeButton22: TSpkLargeButton;
    SpkLargeButton23: TSpkLargeButton;
    RbCfListar: TSpkLargeButton;
    SpkLargeButton25: TSpkLargeButton;
    SpkLargeButton3: TSpkLargeButton;
    SpkLargeButton4: TSpkLargeButton;
    SpkLargeButton5: TSpkLargeButton;
    SpkLargeButton6: TSpkLargeButton;
    SpkLargeButton7: TSpkLargeButton;
    SpkLargeButton8: TSpkLargeButton;
    SpkLargeButton9: TSpkLargeButton;
    SpkPane1: TSpkPane;
    SpkPane2: TSpkPane;
    SpkPane3: TSpkPane;
    SpkPane4: TSpkPane;
    SpkPane5: TSpkPane;
    SpkPane6: TSpkPane;
    SpkPane7: TSpkPane;
    SpkPane8: TSpkPane;
    SpkPane9: TSpkPane;
    StatusBar1: TStatusBar;
    TBienes: TSpkTab;
    TEmpleados: TSpkTab;
    TCatalogos: TSpkTab;
    TConfig: TSpkTab;
    StMenu: TSpkToolbar;
    ZQBienes: TZQuery;
    procedure FormCreate(Sender: TObject);
    procedure RbBAgregarClick(Sender: TObject);
    procedure RbCfListarClick(Sender: TObject);
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
var
  Cifrar:TBCryptHash;
begin

end;

procedure TFrmPrincipal.FormCreate(Sender: TObject);
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
end;

procedure TFrmPrincipal.RbCfListarClick(Sender: TObject);
begin
  FrmListaUsuarios.ShowModal;
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
  end;
end;

end.

