unit u_frmaddbien;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ComCtrls, StdCtrls,
  DBCtrls, Spin, EditBtn, ButtonPanel, DBGrids;

type

  { TFrmAddBien }

  TFrmAddBien = class(TForm)
    BP: TButtonPanel;
    BtnCambiar: TButton;
    CxbGenerar: TCheckBox;
    DtAdquisicion: TDateEdit;
    DgCambios: TDBGrid;
    CbEmpleados: TDBLookupComboBox;
    DeFechaBaja: TDateEdit;
    CbMarca: TDBLookupComboBox;
    CbEstado: TDBLookupComboBox;
    CbLugar: TDBLookupComboBox;
    CbCategoria: TDBLookupComboBox;
    CbSubC: TDBLookupComboBox;
    CbProveedor: TDBLookupComboBox;
    CbBaja: TDBLookupComboBox;
    TxtIdent: TEdit;
    TxtModelo: TEdit;
    TxtNoSerie: TEdit;
    TxtFactura: TEdit;
    TxtPrecio: TFloatSpinEdit;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    LbBaja: TLabel;
    LbFechaBaja: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    TxtObser: TMemo;
    TxtDescrip: TMemo;
    PcBien: TPageControl;
    TsCambios: TTabSheet;
    TsBien: TTabSheet;
    procedure FormShow(Sender: TObject);
  private
    save:Boolean;

  public
    edit:Boolean;
    bien_id:Integer;
    show_baja: Boolean;

  end;

var
  FrmAddBien: TFrmAddBien;

implementation

{$R *.lfm}

{ TFrmAddBien }

procedure TFrmAddBien.FormShow(Sender: TObject);
begin
  // Cargas listas despligables

  if show_baja then
  begin
    Height:=470;
    PcBien.Height:=416;
    LbBaja.Visible:=true;
    LbFechaBaja.Visible:=true;
    CbBaja.Visible:=true;
    DeFechaBaja.Visible:=true;
  end
  else
  begin
    PcBien.Height:=380;
    Height:=434;
  end;
end;

end.

