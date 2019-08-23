unit u_frmestatus;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, db, Forms, Controls, Graphics, Dialogs, DBCtrls, DBGrids,
  StdCtrls, ZDataset;

type

  { TFrmEstatus }

  TFrmEstatus = class(TForm)
    DSEstatus: TDataSource;
    DBCheckBox1: TDBCheckBox;
    TxtEstatus: TDBEdit;
    DBGrid1: TDBGrid;
    DBNav: TDBNavigator;
    Label1: TLabel;
    ZQEstatus: TZQuery;
    procedure DBNavClick(Sender: TObject; Button: TDBNavButtonType);
  private

  public

  end;

var
  FrmEstatus: TFrmEstatus;

implementation

{$R *.lfm}

{ TFrmEstatus }

procedure TFrmEstatus.DBNavClick(Sender: TObject; Button: TDBNavButtonType);
begin
  if Button = nbInsert then
  begin
    TxtEstatus.SetFocus;
  end;
end;

end.

