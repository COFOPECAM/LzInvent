unit u_frmcampanas;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, db, Forms, Controls, Graphics, Dialogs, ComCtrls, ZDataset,
  rxdbgrid, RxSortZeos, SpkToolbar, spkt_Tab, spkt_Pane, spkt_Buttons, m_conn,
  spkt_Appearance, u_frmaddprograma, LCLType, u_frmlistcampanas;

type

  { TFrmCampanas }

  TFrmCampanas = class(TForm)
    DSInac: TDataSource;
    DSProg: TDataSource;
    ILRibbon: TImageList;
    PcProgs: TPageControl;
    BtnActivar: TSpkLargeButton;
    TActivos: TTabSheet;
    TInactivos: TTabSheet;
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
    TProgIn: TRxDBGrid;
    ZQProg: TZQuery;
    ZQInac: TZQuery;
    ZQOp: TZQuery;
    procedure BtnActivarClick(Sender: TObject);
    procedure BtnAddClick(Sender: TObject);
    procedure BtnDownClick(Sender: TObject);
    procedure BtnEditClick(Sender: TObject);
    procedure BtnListClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure PcProgsChange(Sender: TObject);
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

  // Configuraciones del formulario
  BtnAdd.Visible:=true;
  BtnEdit.Visible:=true;
  BtnDown.Visible:=true;
  BtnActivar.Visible:=false;
end;

procedure TFrmCampanas.PcProgsChange(Sender: TObject);
begin
  if PcProgs.TabIndex = 1 then
  begin
    // Deshabilitar botones del ribbon
    BtnAdd.Visible:=false;
    BtnEdit.Visible:=false;
    BtnDown.Visible:=false;
    BtnActivar.Visible:=true;
    // Obtener los programas activos
    ZQInac.Close;
    ZQInac.Open;
  end;
  if PcProgs.TabIndex = 0 then
  begin
    BtnAdd.Visible:=true;
    BtnEdit.Visible:=true;
    BtnDown.Visible:=true;
    BtnActivar.Visible:=false;
    // Obtener los datos de los programas inactivos
    ZQProg.Close;
    ZQProg.Open;
  end;
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

procedure TFrmCampanas.BtnActivarClick(Sender: TObject);
var
  Prog:integer;
  NameProg: string;
begin
  NameProg:=TProgIn.DataSource.DataSet.Fields[1].AsString;
  Prog:=TProgIn.DataSource.DataSet.Fields[0].AsInteger;
  if MessageDlg('Confirmación', 'Desea activar el programa ' + NameProg + '?'
     , mtConfirmation, [mbYes, mbNo],0) = mrYes
  then
  begin
    ZQOp.Close;
    ZQOp.Params.ParamByName('estado').AsInteger:=1;
    ZQOp.Params.ParamByName('prog_id').AsInteger:=Prog;
    ZQOp.ExecSQL;
    Application.MessageBox('Programa activado satisfactoriamente', 'Inventario',
    MB_ICONINFORMATION);
    BtnAdd.Visible:=true;
    BtnEdit.Visible:=true;
    BtnDown.Visible:=true;
    BtnActivar.Visible:=false;
    PcProgs.TabIndex:=0;
    ZQProg.Close;
    ZQProg.Open;
  end;
end;

procedure TFrmCampanas.BtnDownClick(Sender: TObject);
var
  Prog:integer;
  NameProg: string;
begin
  NameProg:=TProgr.DataSource.DataSet.Fields[1].AsString;
  Prog:=TProgr.DataSource.DataSet.Fields[0].AsInteger;
  if MessageDlg('Confirmación', 'Desea desactivar el programa ' + NameProg + '?'
     , mtConfirmation, [mbYes, mbNo],0) = mrYes
  then
  begin
    ZQOp.Close;
    ZQOp.Params.ParamByName('estado').AsInteger:=0;
    ZQOp.Params.ParamByName('prog_id').AsInteger:=Prog;
    ZQOp.ExecSQL;
    Application.MessageBox('Programa desactivado satisfactoriamente', 'Inventario',
    MB_ICONINFORMATION);
    BtnAdd.Visible:=false;
    BtnEdit.Visible:=false;
    BtnDown.Visible:=false;
    BtnActivar.Visible:=true;
    PcProgs.TabIndex:=1;
    ZQInac.Close;
    ZQInac.Open;
  end;
end;

procedure TFrmCampanas.BtnEditClick(Sender: TObject);
begin
  FrmAddProg:=TFrmAddProg.Create(FrmCampanas);
  FrmAddProg.ProgId:=TProgr.DataSource.DataSet.Fields[0].AsInteger;
  FrmAddProg.EditMode:=true;
  if FrmAddProg.ShowModal = mrOK then
  begin
    // Recargar datos de la lista
    ZQProg.Close;
    ZQProg.Open;
  end;
end;

procedure TFrmCampanas.BtnListClick(Sender: TObject);
begin
  FrmListCam:=TFrmListCam.Create(FrmCampanas);
  FrmListCam.ShowModal;
end;

end.

