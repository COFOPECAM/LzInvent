unit u_frmreports;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, db, Forms, Controls, Graphics, Dialogs, ExtCtrls, ComCtrls,
  DBGrids, StdCtrls, DBCtrls, LR_Class, LR_Desgn, ZDataset, SpkToolbar,
  spkt_Tab, spkt_Pane, spkt_Buttons, spkt_Appearance, m_conn;

type

  { TFrmReports }

  TFrmReports = class(TForm)
    Button1: TButton;
    DBMemo1: TDBMemo;
    DSReports: TDataSource;
    DBReports: TDBGrid;
    frReport1: TfrReport;
    GroupBox1: TGroupBox;
    IlRb: TImageList;
    Panel1: TPanel;
    BtnEdit: TSpkLargeButton;
    SpkPane1: TSpkPane;
    SpkTab1: TSpkTab;
    StMenu: TSpkToolbar;
    StatusBar1: TStatusBar;
    ZQReports: TZQuery;
    procedure BtnEditClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private

  public

  end;

var
  FrmReports: TFrmReports;

implementation

{$R *.lfm}

{ TFrmReports }

procedure TFrmReports.FormCreate(Sender: TObject);
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

procedure TFrmReports.BtnEditClick(Sender: TObject);
var
  file_dir: string;
begin
  file_dir:=DBReports.DataSource.DataSet.Fields[2].AsString;
  frReport1.LoadFromFile(file_dir);
  frReport1.DesignReport;
end;

end.

