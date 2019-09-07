unit u_frmlogin;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, ButtonPanel,
  ExtCtrls;

type

  { TFrmLogin }

  TFrmLogin = class(TForm)
    ButtonPanel1: TButtonPanel;
    Edit1: TEdit;
    Edit2: TEdit;
    Image1: TImage;
    procedure Edit1Change(Sender: TObject);
  private

  public

  end;

var
  FrmLogin: TFrmLogin;

implementation

{$R *.lfm}

{ TFrmLogin }

procedure TFrmLogin.Edit1Change(Sender: TObject);
begin

end;

end.

