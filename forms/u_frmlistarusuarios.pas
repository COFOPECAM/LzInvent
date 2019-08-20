unit u_frmlistarusuarios;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ComCtrls, DBGrids,
  ZDataset, SpkToolbar, spkt_Tab, spkt_Pane, spkt_Buttons, u_frmadduser, db,
  u_frmrolespermisos, m_conn, spkt_Appearance;

type

  { TFrmListaUsuarios }

  TFrmListaUsuarios = class(TForm)
    DSGetUsers: TDataSource;
    DgUsuarios: TDBGrid;
    LBRibbon: TImageList;
    RbAdd: TSpkLargeButton;
    RbEditar: TSpkLargeButton;
    RbBaja: TSpkLargeButton;
    RbRoles: TSpkLargeButton;
    SpkPane1: TSpkPane;
    SpkPane2: TSpkPane;
    SpkTab1: TSpkTab;
    StMenu: TSpkToolbar;
    StatusBar1: TStatusBar;
    ZQGetUsers: TZQuery;
    ZQBaja: TZQuery;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure RbAddClick(Sender: TObject);
    procedure RbBajaClick(Sender: TObject);
    procedure RbEditarClick(Sender: TObject);
    procedure RbRolesClick(Sender: TObject);
  private

  public
    user_id:integer;

  end;

var
  FrmListaUsuarios: TFrmListaUsuarios;

implementation

{$R *.lfm}

{ TFrmListaUsuarios }

procedure TFrmListaUsuarios.RbAddClick(Sender: TObject);
begin
  if FrmUser.ShowModal = mrOK then
  begin
    ZQGetUsers.Close;
    ZQGetUsers.Open;
  end;
end;

procedure TFrmListaUsuarios.RbBajaClick(Sender: TObject);
var
  id_user: integer;
  name_full: string;
begin
  // Obtener el id del usuario seleccionado
  id_user:=StrToInt(DgUsuarios.DataSource.DataSet.Fields[0].Value);
  name_full:=DgUsuarios.DataSource.DataSet.Fields[1].Value + ' ' +
  DgUsuarios.DataSource.DataSet.Fields[2].Value;

  if MessageDlg('Confirmación', '¿Desea eliminar al usuario ' + name_full + '?',
  mtConfirmation, [mbYes, mbNo],0) = mrYes
  then
  begin
    ZQBaja.Params.ParamByName('estatus').AsInteger:=0;
    ZQBaja.Params.ParamByName('user_id').AsInteger:=id_user;
    ZQBaja.ExecSQL;
    ZQGetUsers.Close;
    ZQGetUsers.Open;
  end;
end;

procedure TFrmListaUsuarios.RbEditarClick(Sender: TObject);
var
  id_user:integer;
begin
  id_user:=StrToInt(DgUsuarios.DataSource.DataSet.Fields[0].Value);
  FrmUser.user_id:=id_user;
  FrmUser.edit:=true;
  if FrmUser.ShowModal = mrOK then
  begin
    ZQGetUsers.Close;
    ZQGetUsers.Open;
  end;
end;

procedure TFrmListaUsuarios.RbRolesClick(Sender: TObject);
begin
  FrmRolesPermisos.ShowModal;
end;

procedure TFrmListaUsuarios.FormShow(Sender: TObject);
begin
  ZQGetUsers.Open;
end;

procedure TFrmListaUsuarios.FormCreate(Sender: TObject);
begin
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

end.

