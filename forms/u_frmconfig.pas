unit u_frmconfig;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ComCtrls, ButtonPanel,
  StdCtrls, ExtCtrls, m_conn;

type

  { TFrmConfig }

  TFrmConfig = class(TForm)
    Bevel1: TBevel;
    BtnLoadImg: TButton;
    ButtonPanel1: TButtonPanel;
    CbShowFecha: TCheckBox;
    CbTheme: TComboBox;
    TxtFormato: TEdit;
    TxtEntrega: TEdit;
    TxtAutoriza: TEdit;
    Image1: TImage;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    LbPlaceholder: TLabel;
    TxtNombre: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    TxtDir: TMemo;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    procedure FormShow(Sender: TObject);
  private

  public

  end;

var
  FrmConfig: TFrmConfig;

implementation

{$R *.lfm}

{ TFrmConfig }

procedure TFrmConfig.FormShow(Sender: TObject);
begin
  TxtNombre.Text:=dmconn.Empresa;
  TxtDir.Lines.Text:=dmconn.DirEmpresa;
  TxtFormato.Text:=dmconn.FormatoCodigo;
  // CbTheme.ite;
  TxtEntrega.Text:=dmconn.Entrega;
  TxtAutoriza.Text:=dmconn.Autoriza;
  CbShowFecha.Checked:=dmconn.MostrarFechaResg;
end;

end.

