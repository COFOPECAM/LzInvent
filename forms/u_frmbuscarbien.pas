unit u_frmbuscarbien;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, EditBtn,
  DBCtrls, ButtonPanel;

type

  { TFrmBuscarBien }

  TFrmBuscarBien = class(TForm)
    Bp: TButtonPanel;
    CbAdq: TCheckBox;
    CbSubCat: TCheckBox;
    CbProveedor: TCheckBox;
    CbCodigo: TCheckBox;
    CbDesc: TCheckBox;
    CbEstatus: TCheckBox;
    CbFactura: TCheckBox;
    CbLugar: TCheckBox;
    CbMarca: TCheckBox;
    CbObs: TCheckBox;
    CbCat: TCheckBox;
    DeInicio: TDateEdit;
    DeFin: TDateEdit;
    CbxEstatus: TDBLookupComboBox;
    CbxLugar: TDBLookupComboBox;
    CbxMarca: TDBLookupComboBox;
    CbxCat: TDBLookupComboBox;
    CbxSubCat: TDBLookupComboBox;
    CbxProveedor: TDBLookupComboBox;
    TxtCodigo: TEdit;
    TxtDesc: TEdit;
    TxtFactura: TEdit;
    TxtObs: TEdit;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    procedure CbAdqChange(Sender: TObject);
    procedure CbCatChange(Sender: TObject);
    procedure CbCodigoChange(Sender: TObject);
    procedure CbDescChange(Sender: TObject);
    procedure CbEstatusChange(Sender: TObject);
    procedure CbFacturaChange(Sender: TObject);
    procedure CbLugarChange(Sender: TObject);
    procedure CbMarcaChange(Sender: TObject);
    procedure CbObsChange(Sender: TObject);
    procedure CbProveedorChange(Sender: TObject);
    procedure CbSubCatChange(Sender: TObject);
  private

  public

  end;

var
  FrmBuscarBien: TFrmBuscarBien;

implementation

{$R *.lfm}

{ TFrmBuscarBien }

procedure TFrmBuscarBien.CbAdqChange(Sender: TObject);
begin
  DeInicio.Enabled:=CbAdq.Checked;
  DeFin.Enabled:=CbAdq.Checked;
end;

procedure TFrmBuscarBien.CbCatChange(Sender: TObject);
begin
  CbxCat.Enabled:=CbCat.Checked;
end;

procedure TFrmBuscarBien.CbCodigoChange(Sender: TObject);
begin
  TxtCodigo.Enabled:=CbCodigo.Checked;
  TxtCodigo.Text:='';
end;

procedure TFrmBuscarBien.CbDescChange(Sender: TObject);
begin
  TxtDesc.Enabled:=CbDesc.Checked;
  TxtDesc.Text:='';
end;

procedure TFrmBuscarBien.CbEstatusChange(Sender: TObject);
begin
  CbxEstatus.Enabled:=CbEstatus.Checked;
end;

procedure TFrmBuscarBien.CbFacturaChange(Sender: TObject);
begin
  TxtFactura.Enabled:=CbFactura.Checked;
  TxtFactura.Text:='';
end;

procedure TFrmBuscarBien.CbLugarChange(Sender: TObject);
begin
  CbxLugar.Enabled:=CbLugar.Checked;
end;

procedure TFrmBuscarBien.CbMarcaChange(Sender: TObject);
begin
  CbxMarca.Enabled:=CbMarca.Checked;
end;

procedure TFrmBuscarBien.CbObsChange(Sender: TObject);
begin
  TxtObs.Enabled:=CbObs.Checked;
  TxtObs.Text:='';
end;

procedure TFrmBuscarBien.CbProveedorChange(Sender: TObject);
begin
  CbxProveedor.Enabled:=CbProveedor.Checked;
end;

procedure TFrmBuscarBien.CbSubCatChange(Sender: TObject);
begin
  CbxSubCat.Enabled:=CbSubCat.Checked;
end;

end.

