unit u_frmprincipal;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, rxdbgrid,
  SpkToolbar, spkt_Tab, spkt_Pane, spkt_Buttons, BCrypt, u_frmlistarusuarios;

type

  { TFrmPrincipal }

  TFrmPrincipal = class(TForm)
    RbBAgregar: TSpkLargeButton;
    RxDBGrid1: TRxDBGrid;
    SpkLargeButton10: TSpkLargeButton;
    SpkLargeButton11: TSpkLargeButton;
    SpkLargeButton12: TSpkLargeButton;
    SpkLargeButton13: TSpkLargeButton;
    SpkLargeButton14: TSpkLargeButton;
    SpkLargeButton15: TSpkLargeButton;
    SpkLargeButton16: TSpkLargeButton;
    SpkLargeButton17: TSpkLargeButton;
    SpkLargeButton18: TSpkLargeButton;
    SpkLargeButton19: TSpkLargeButton;
    SpkLargeButton2: TSpkLargeButton;
    SpkLargeButton20: TSpkLargeButton;
    SpkLargeButton21: TSpkLargeButton;
    SpkLargeButton22: TSpkLargeButton;
    SpkLargeButton23: TSpkLargeButton;
    RbCfListar: TSpkLargeButton;
    SpkLargeButton25: TSpkLargeButton;
    SpkLargeButton3: TSpkLargeButton;
    SpkLargeButton4: TSpkLargeButton;
    SpkLargeButton5: TSpkLargeButton;
    SpkLargeButton6: TSpkLargeButton;
    SpkLargeButton7: TSpkLargeButton;
    SpkLargeButton8: TSpkLargeButton;
    SpkLargeButton9: TSpkLargeButton;
    SpkPane1: TSpkPane;
    SpkPane2: TSpkPane;
    SpkPane3: TSpkPane;
    SpkPane4: TSpkPane;
    SpkPane5: TSpkPane;
    SpkPane6: TSpkPane;
    SpkPane7: TSpkPane;
    SpkPane8: TSpkPane;
    SpkPane9: TSpkPane;
    SpkTab1: TSpkTab;
    SpkTab2: TSpkTab;
    SpkTab3: TSpkTab;
    SpkTab4: TSpkTab;
    SpkToolbar1: TSpkToolbar;
    procedure RbBAgregarClick(Sender: TObject);
    procedure RbCfListarClick(Sender: TObject);
  private

  public

  end;

var
  FrmPrincipal: TFrmPrincipal;

implementation

{$R *.lfm}

{ TFrmPrincipal }

procedure TFrmPrincipal.RbBAgregarClick(Sender: TObject);
var
  Cifrar:TBCryptHash;
begin
  Cifrar:=TBCryptHash.Create;
  ShowMessage(Cifrar.CreateHash('MiContr@sena'));
  Cifrar.Free;
end;

procedure TFrmPrincipal.RbCfListarClick(Sender: TObject);
begin
  FrmListaUsuarios.ShowModal;
end;

end.

