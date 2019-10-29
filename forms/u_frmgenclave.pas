unit u_frmgenclave;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, DBCtrls,
  ButtonPanel;

type

  { TFrmGenClave }

  TFrmGenClave = class(TForm)
    ButtonPanel1: TButtonPanel;
    Claves: TGroupBox;
    ComboBox1: TComboBox;
    ComboBox2: TComboBox;
    DBLookupComboBox1: TDBLookupComboBox;
    DBLookupComboBox2: TDBLookupComboBox;
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    procedure FormShow(Sender: TObject);
  private

  public

  end;

var
  FrmGenClave: TFrmGenClave;

implementation

{$R *.lfm}

{ TFrmGenClave }

procedure TFrmGenClave.FormShow(Sender: TObject);
begin
  // Obtener datos para los combos

end;

end.

