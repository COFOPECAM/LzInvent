unit u_frmbajas;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, db, Forms, Controls, Graphics, Dialogs, StdCtrls, DBCtrls,
  DBGrids, ZDataset;

type

  { TFrmBajas }

  TFrmBajas = class(TForm)
    DSBajas: TDataSource;
    DBCheckBox1: TDBCheckBox;
    TxtBaja: TDBEdit;
    DBGrid1: TDBGrid;
    DBNav: TDBNavigator;
    Label1: TLabel;
    ZQBajas: TZQuery;
    procedure DBNavClick(Sender: TObject; Button: TDBNavButtonType);
    procedure FormShow(Sender: TObject);
  private

  public

  end;

var
  FrmBajas: TFrmBajas;

implementation

{$R *.lfm}

{ TFrmBajas }

procedure TFrmBajas.DBNavClick(Sender: TObject; Button: TDBNavButtonType);
begin
  if Button = nbInsert then
  begin
    TxtBaja.SetFocus;
  end;
end;

procedure TFrmBajas.FormShow(Sender: TObject);
begin
  ZQBajas.Open;
end;

end.

