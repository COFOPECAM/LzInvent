unit u_frmadduser;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, DBCtrls,
  ButtonPanel, ZDataset, m_conn, db, BCrypt, LCLType;

type

  { TFrmUser }

  TFrmUser = class(TForm)
    ButtonPanel1: TButtonPanel;
    DSRoles: TDataSource;
    Datos: TGroupBox;
    CbRoles: TDBLookupComboBox;
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
    procedure CancelButtonClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: boolean);
    procedure FormShow(Sender: TObject);
    procedure OKButtonClick(Sender: TObject);
  private
    save: Boolean;

  public

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
end;

procedure TFrmUser.FormCloseQuery(Sender: TObject; var CanClose: boolean);
begin
   CanClose:=save;
end;

procedure TFrmUser.CancelButtonClick(Sender: TObject);
begin
  save:=true;
end;

end.

