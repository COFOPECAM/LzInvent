unit u_frmaddconsumiblecat;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, db, Forms, Controls, Graphics, Dialogs, DBCtrls, StdCtrls,
  DBGrids, m_consumibles;

type

  { TFrmAddMaterialCat }

  TFrmAddMaterialCat = class(TForm)
    DSCat: TDataSource;
    DBCheckBox1: TDBCheckBox;
    DBEdit1: TDBEdit;
    DBGrid1: TDBGrid;
    DBNavigator1: TDBNavigator;
    Label1: TLabel;
    procedure FormShow(Sender: TObject);
  private

  public

  end;

var
  FrmAddMaterialCat: TFrmAddMaterialCat;

implementation

{$R *.lfm}

{ TFrmAddMaterialCat }

procedure TFrmAddMaterialCat.FormShow(Sender: TObject);
begin
  DmConsumibles.ZQCat.Open;
end;

end.

