unit u_frmcampanas;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, db, Forms, Controls, Graphics, Dialogs, ComCtrls, ZDataset,
  rxdbgrid, RxSortZeos, SpkToolbar, spkt_Tab, spkt_Pane, spkt_Buttons, m_conn,
  spkt_Appearance, u_frmaddprograma;

type

  { TFrmCampanas }

  TFrmCampanas = class(TForm)
    DSProg: TDataSource;
    ILRibbon: TImageList;
    TProgr: TRxDBGrid;
    RxSortZeos1: TRxSortZeos;
    BtnAdd: TSpkLargeButton;
    BtnEdit: TSpkLargeButton;
    BtnDown: TSpkLargeButton;
    BtnList: TSpkLargeButton;
    SpkPane1: TSpkPane;
    SpkPane2: TSpkPane;
    SpkTab1: TSpkTab;
    StMenu: TSpkToolbar;
    SbMsjs: TStatusBar;
    ZQProg: TZQuery;
    procedure BtnAddClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private

  public

  end;

var
  FrmCampanas: TFrmCampanas;

implementation

{$R *.lfm}

{ TFrmCampanas }

procedure TFrmCampanas.FormShow(Sender: TObject);
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
  // Obtener los programas
  ZQProg.Open;
  SbMsjs.Panels[0].Text:='Total de programas: ' + ZQProg.RecordCount.ToString;
end;

procedure TFrmCampanas.BtnAddClick(Sender: TObject);
begin
  FrmAddProg:=TFrmAddProg.Create(FrmCampanas);
  if FrmAddProg.ShowModal = mrOK then
  begin
    // Recargar lista de programas
    ZQProg.Close;
    ZQProg.Open;
  end;
end;

end.

