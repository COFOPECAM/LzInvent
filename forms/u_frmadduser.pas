unit u_frmadduser;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, DBCtrls,
  ButtonPanel, ZDataset, m_conn, db, BCrypt, LCLType, Buttons;

type

  { TFrmUser }

  TFrmUser = class(TForm)
    BtnViewPass: TBitBtn;
    ButtonPanel1: TButtonPanel;
    DSRoles: TDataSource;
    Datos: TGroupBox;
    CbRoles: TDBLookupComboBox;
    ILimgs: TImageList;
    TxtNombres: TEdit;
    TxtApellidos: TEdit;
    TxtUsuario: TEdit;
    TxtContrasena: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    ZQUser: TZQuery;
    procedure BtnViewPassClick(Sender: TObject);
    procedure CancelButtonClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: boolean);
    procedure FormShow(Sender: TObject);
    procedure OKButtonClick(Sender: TObject);
  private
    save: Boolean;

  public
    edit: Boolean;
    user_id: integer;
    view_pass: Boolean;

  end;

var
  FrmUser: TFrmUser;

implementation

{$R *.lfm}

{ TFrmUser }

procedure TFrmUser.OKButtonClick(Sender: TObject);
var
  Cifrar: TBCryptHash;
  i: integer;
begin
   // Validar formulario
   for i := 0 to ComponentCount-1 do
    begin
      if (Components[i] is TEdit) then
        begin
          if TEdit(Components[i]).Text = '' then
            begin
              MessageDlg('Faltan datos', 'Todos los campos son obligatorios',
              mtInformation, [mbOK], 0);
              TEdit(Components[i]).SetFocus;
              save:=false;
              Exit;
            end;
        end;
    end;
  Cifrar:=TBCryptHash.Create;
  ZQUser.Params.ParamByName('nombres').AsString:=TxtNombres.Text;
  ZQUser.Params.ParamByName('apellidos').AsString:=TxtApellidos.Text;
  ZQUser.Params.ParamByName('usuario').AsString:=TxtUsuario.Text;
  ZQUser.Params.ParamByName('contrasena').AsString:=Cifrar.CreateHash(TxtContrasena.Text);
  ZQUser.Params.ParamByName('role_id').AsInteger:=CbRoles.KeyValue;
  ZQUser.ExecSQL;
  Cifrar.Free;
  save:=true
end;

procedure TFrmUser.FormShow(Sender: TObject);
begin
  save:=true;
  if edit then
  begin
    ZQUser.SQL.Text:='select u.nombres, u.apellidos, u.usuario, u.roles_id_roles'+
    ' as role_id from usuarios u where id_usuarios = :id';
    ZQUser.Params.ParamByName('id').AsInteger:=user_id;
    ZQUser.Open;
    TxtNombres.Text:=ZQUser.FieldByName('nombres').Text;
    TxtApellidos.Text:=ZQUser.FieldByName('apellidos').Text;
    TxtUsuario.Text:=ZQUser.FieldByName('usuario').Text;
    CbRoles.KeyValue:=StrToInt(ZQUser.FieldByName('role_id').Text);
  end;
  view_pass:=false;
  BtnViewPass.ImageIndex:=0;
end;

procedure TFrmUser.FormCloseQuery(Sender: TObject; var CanClose: boolean);
var
  i:integer;
begin
  for i := 0 to ComponentCount-1 do
  begin
    if (Components[i] is TEdit) then
    begin
      TEdit(Components[i]).Text:='';
    end;
  end;
  CbRoles.KeyValue:=0;
  edit:=false;
  CanClose:=save;
end;

procedure TFrmUser.CancelButtonClick(Sender: TObject);
begin
  save:=true;
end;

procedure TFrmUser.BtnViewPassClick(Sender: TObject);
begin
  if not view_pass then
  begin
    BtnViewPass.ImageIndex:=1;
    TxtContrasena.EchoMode:=emNormal;
    view_pass:=true;
  end
  else
  begin
    view_pass:=false;
    TxtContrasena.EchoMode:=emPassword;
    BtnViewPass.ImageIndex:=0;
  end;
end;

end.

