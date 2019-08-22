unit u_frmplaces;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, db, Forms, Controls, Graphics, Dialogs, DBCtrls, DBGrids,
  StdCtrls, ZDataset;

type

  { TFrmPlaces }

  TFrmPlaces = class(TForm)
    DSPlace: TDataSource;
    DBCheckBox1: TDBCheckBox;
    TxtPlace: TDBEdit;
    DBGrid1: TDBGrid;
    DBNav: TDBNavigator;
    Label1: TLabel;
    ZQPlace: TZQuery;
    procedure DBNavClick(Sender: TObject; Button: TDBNavButtonType);
    procedure FormShow(Sender: TObject);
  private

  public

  end;

var
  FrmPlaces: TFrmPlaces;

implementation

{$R *.lfm}

{ TFrmPlaces }

procedure TFrmPlaces.FormShow(Sender: TObject);
begin
  ZQPlace.Open;
end;

procedure TFrmPlaces.DBNavClick(Sender: TObject; Button: TDBNavButtonType);
begin
  if Button = nbInsert then
  begin
    TxtPlace.SetFocus;
  end;
end;

end.

