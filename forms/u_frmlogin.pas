unit u_frmlogin;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, ButtonPanel,
  ExtCtrls, u_frmprincipal, m_conn, LCLType;

type

  { TFrmLogin }

  TFrmLogin = class(TForm)
    Bp: TButtonPanel;
    TxtUser: TEdit;
    TxtPass: TEdit;
    Image1: TImage;
    procedure TxtUserChange(Sender: TObject);
    procedure OKButtonClick(Sender: TObject);
  private

  public

  end;

var
  FrmLogin: TFrmLogin;

implementation

{$R *.lfm}

{ TFrmLogin }

procedure TFrmLogin.TxtUserChange(Sender: TObject);
begin

end;

procedure TFrmLogin.OKButtonClick(Sender: TObject);
var
  user, passwd: string;
begin
  user:=TxtUser.Text;
  passwd:=TxtPass.Text;
  TxtUser.Text:='';
  TxtPass.Text:='';
  if dmconn.AuthUser(user, passwd) then
  begin
    FrmPrincipal:=TFrmPrincipal.Create(FrmLogin);
    FrmPrincipal.ShowModal;
  end
  else
  begin
    Application.MessageBox('Usuario y/o contraseña incorrectas', 'Error',
    MB_ICONEXCLAMATION);
  end;
end;

end.

