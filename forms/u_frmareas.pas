unit u_frmareas;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, db, Forms, Controls, Graphics, Dialogs, DBCtrls, StdCtrls,
  DBGrids, m_empleados;

type

  { TFrmAreas }

  TFrmAreas = class(TForm)
    DBCheckBox1: TDBCheckBox;
    DSAreas: TDataSource;
    TxtArea: TDBEdit;
    DBGrid1: TDBGrid;
    DBNavigator1: TDBNavigator;
    Label1: TLabel;
    procedure FormShow(Sender: TObject);
  private

  public

  end;

var
  FrmAreas: TFrmAreas;

implementation

{$R *.lfm}

{ TFrmAreas }

procedure TFrmAreas.FormShow(Sender: TObject);
begin

end;

end.

