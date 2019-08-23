unit u_frmmarcas;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, db, Forms, Controls, Graphics, Dialogs, StdCtrls, DBCtrls,
  DBGrids, ZDataset;

type

  { TFrmMarca }

  TFrmMarca = class(TForm)
    DSMarcas: TDataSource;
    DBCheckBox1: TDBCheckBox;
    TxtMarca: TDBEdit;
    DBGrid1: TDBGrid;
    DBNav: TDBNavigator;
    Label1: TLabel;
    ZQMarcas: TZQuery;
    procedure DBNavClick(Sender: TObject; Button: TDBNavButtonType);
  private

  public

  end;

var
  FrmMarca: TFrmMarca;

implementation

{$R *.lfm}

{ TFrmMarca }

procedure TFrmMarca.DBNavClick(Sender: TObject; Button: TDBNavButtonType);
begin
  if Button = nbInsert then
  begin
    TxtMarca.SetFocus;
  end;
end;

end.

