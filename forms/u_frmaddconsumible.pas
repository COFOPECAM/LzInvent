unit u_frmaddconsumible;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, DBCtrls,
  ButtonPanel;

type

  { TFrmAddConsu }

  TFrmAddConsu = class(TForm)
    Button1: TButton;
    ButtonPanel1: TButtonPanel;
    CbUnidad: TDBLookupComboBox;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    TxtDescrip: TMemo;
  private

  public

  end;

var
  FrmAddConsu: TFrmAddConsu;

implementation

{$R *.lfm}

end.

