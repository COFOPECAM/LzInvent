unit u_frmconfig;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ComCtrls, ButtonPanel,
  StdCtrls, ExtCtrls, ZDataset, m_conn, LCLType;

type

  { TFrmConfig }

  TFrmConfig = class(TForm)
    Bevel1: TBevel;
    BtnLoadImg: TButton;
    Bp: TButtonPanel;
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
    ZQConfig: TZQuery;
    procedure FormCloseQuery(Sender: TObject; var CanClose: boolean);
    procedure FormShow(Sender: TObject);
    procedure OKButtonClick(Sender: TObject);
  private
    save:Boolean;

  public

  end;

var
  FrmConfig: TFrmConfig;

implementation

{$R *.lfm}

{ TFrmConfig }

procedure TFrmConfig.FormShow(Sender: TObject);
var
  showdate: Boolean;
begin
  showdate:=false;
  save:=true;
  TxtNombre.Text:=dmconn.Empresa;
  TxtDir.Lines.Text:=dmconn.DirEmpresa;
  TxtFormato.Text:=dmconn.FormatoCodigo;
  CbTheme.ItemIndex:=StrToInt(dmconn.Theme);
  TxtEntrega.Text:=dmconn.Entrega;
  TxtAutoriza.Text:=dmconn.Autoriza;
  if dmconn.MostrarFechaResg = '1' then
     showdate:=true;
  CbShowFecha.Checked:=showdate;
end;

procedure TFrmConfig.OKButtonClick(Sender: TObject);
begin
  ZQConfig.Close;
  ZQConfig.SQL.Text:='UPDATE config SET value=:valor WHERE name LIKE ''dir_empresa''';
  ZQConfig.Params.ParamByName('valor').AsString:=TxtDir.Lines.Text;
  ZQConfig.ExecSQL;

  // Al finalizar de actualizar los datos
  Application.MessageBox('Se requiere reiniciar la aplicación para aplicar los cambios',
  'Reinicio', MB_ICONINFORMATION);
end;

procedure TFrmConfig.FormCloseQuery(Sender: TObject; var CanClose: boolean);
begin
  CanClose:=save;
end;

end.

