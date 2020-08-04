unit u_frmlistcampanas;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, db, Forms, Controls, Graphics, Dialogs, DBGrids, DBCtrls,
  StdCtrls, Buttons, ZDataset;

type

  { TFrmListCam }

  TFrmListCam = class(TForm)
    BitBtn1: TBitBtn;
    DBEdit2: TDBEdit;
    DBEdit3: TDBEdit;
    DSCamp: TDataSource;
    CbEstatus: TDBCheckBox;
    DBEdit1: TDBEdit;
    Label3: TLabel;
    TCamp: TDBGrid;
    DBNavigator1: TDBNavigator;
    Label1: TLabel;
    Label2: TLabel;
    ZQCamp: TZQuery;
    procedure CbEstatusChange(Sender: TObject);
    procedure DSCampDataChange(Sender: TObject; Field: TField);
    procedure FormShow(Sender: TObject);
  private

  public

  end;

var
  FrmListCam: TFrmListCam;

implementation

{$R *.lfm}

{ TFrmListCam }

procedure TFrmListCam.CbEstatusChange(Sender: TObject);
begin
  if CbEstatus.Checked then
  begin
    CbEstatus.Caption:='Activo';
  end
  else
  begin
    CbEstatus.Caption:='Inactivo';
  end;
end;

procedure TFrmListCam.DSCampDataChange(Sender: TObject; Field: TField);
begin
  if CbEstatus.Checked then
  begin
    CbEstatus.Caption:='Activo';
  end
  else
  begin
    CbEstatus.Caption:='Inactivo';
  end;
end;

procedure TFrmListCam.FormShow(Sender: TObject);
begin
  ZQCamp.Open;
end;

end.

