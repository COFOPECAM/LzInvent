unit u_frmareas;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, db, Forms, Controls, Graphics, Dialogs, DBCtrls, StdCtrls,
  DBGrids;

type

  { TFrmAreas }

  TFrmAreas = class(TForm)
    DBCheckBox1: TDBCheckBox;
    DSAreas: TDataSource;
    TxtArea: TDBEdit;
    DBGrid1: TDBGrid;
    DBNavigator1: TDBNavigator;
    Label1: TLabel;
  private

  public

  end;

var
  FrmAreas: TFrmAreas;

implementation

{$R *.lfm}

end.

