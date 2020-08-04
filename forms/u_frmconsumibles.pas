unit u_frmconsumibles;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, db, Forms, Controls, Graphics, Dialogs, rxdbgrid,
  SpkToolbar, spkt_Tab, spkt_Pane, spkt_Buttons, m_conn, spkt_Appearance,
  u_frmaddconsumiblecat, u_frmaddbuy, m_consumibles;

type

  { TFrmConsumibles }

  TFrmConsumibles = class(TForm)
    DSStock: TDataSource;
    IlConsumibles: TImageList;
    RxDBGrid1: TRxDBGrid;
    BtnAdd: TSpkLargeButton;
    SpkLargeButton2: TSpkLargeButton;
    SpkLargeButton3: TSpkLargeButton;
    BtnMaterial: TSpkLargeButton;
    SpkPane1: TSpkPane;
    SpkPane2: TSpkPane;
    SpkTab1: TSpkTab;
    StMenu: TSpkToolbar;
    procedure BtnAddClick(Sender: TObject);
    procedure BtnMaterialClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private

  public

  end;

var
  FrmConsumibles: TFrmConsumibles;

implementation

{$R *.lfm}

{ TFrmConsumibles }

procedure TFrmConsumibles.FormCreate(Sender: TObject);
begin
  { Settear configuraciones de la aplicación }
  if dmconn.Theme = '1' then
  begin
    StMenu.Style:=spkOffice2007Blue;
    StMenu.Color:=clSkyBlue;
  end;
  if dmconn.Theme = '3' then
  begin
    StMenu.Style:=spkOffice2007Silver;
    StMenu.Color:=clWhite;
  end;
  if dmconn.Theme = '0' then
  begin
    StMenu.Style:=spkMetroDark;
    StMenu.Color:=$080808;
  end;
  if dmconn.Theme = '2' then
  begin
    StMenu.Style:=spkMetroLight;
    StMenu.Color:=clSilver;
  end;
end;

procedure TFrmConsumibles.BtnMaterialClick(Sender: TObject);
begin
  FrmAddMaterialCat:=TFrmAddMaterialCat.Create(FrmConsumibles);
  FrmAddMaterialCat.ShowModal;
  DmConsumibles.ZQStock.Refresh;
end;

procedure TFrmConsumibles.BtnAddClick(Sender: TObject);
begin
  FrmAddBuy:=TFrmAddBuy.Create(FrmConsumibles);
  if FrmAddBuy.ShowModal = mrOK then
  begin
    // Recargar lista de materiales disponibles
  end;
end;

end.

