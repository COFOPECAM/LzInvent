unit u_frmlistarusuarios;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ComCtrls, DBGrids,
  ZDataset, SpkToolbar, spkt_Tab, spkt_Pane, spkt_Buttons, u_frmadduser, db;

type

  { TFrmListaUsuarios }

  TFrmListaUsuarios = class(TForm)
    DSGetUsers: TDataSource;
    DBGrid1: TDBGrid;
    ImageList1: TImageList;
    RbAdd: TSpkLargeButton;
    SpkLargeButton2: TSpkLargeButton;
    SpkLargeButton3: TSpkLargeButton;
    SpkLargeButton4: TSpkLargeButton;
    SpkPane1: TSpkPane;
    SpkPane2: TSpkPane;
    SpkTab1: TSpkTab;
    SpkToolbar1: TSpkToolbar;
    StatusBar1: TStatusBar;
    ZQGetUsers: TZQuery;
    procedure RbAddClick(Sender: TObject);
  private

  public

  end;

var
  FrmListaUsuarios: TFrmListaUsuarios;

implementation

{$R *.lfm}

{ TFrmListaUsuarios }

procedure TFrmListaUsuarios.RbAddClick(Sender: TObject);
begin
  if FrmUser.ShowModal = mrOK then
  begin
    ZQGetUsers.Close;
    ZQGetUsers.Open;
  end;
end;

end.

