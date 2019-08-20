unit u_frmlistarusuarios;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ComCtrls, DBGrids,
  ZDataset, SpkToolbar, spkt_Tab, spkt_Pane, spkt_Buttons, u_frmadduser, db,
  u_frmrolespermisos;

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
    SpkToolbar1: TSpkToolbar;
    StatusBar1: TStatusBar;
    ZQGetUsers: TZQuery;
    ZQBaja: TZQuery;
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

end.

