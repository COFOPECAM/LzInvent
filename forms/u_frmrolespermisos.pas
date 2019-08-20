unit u_frmrolespermisos;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, DBCtrls, StdCtrls,
  ButtonPanel, ExtCtrls, Buttons, CheckLst, VirtualDBCheckGroup, VirtualTrees;

type

  { TFrmRolesPermisos }

  TFrmRolesPermisos = class(TForm)
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    ButtonPanel1: TButtonPanel;
    DBLookupComboBox1: TDBLookupComboBox;
    Edit1: TEdit;
    ILimgs: TImageList;
    Memo1: TMemo;
    VirtualStringTree1: TVirtualStringTree;
  private

  public

  end;

var
  FrmRolesPermisos: TFrmRolesPermisos;

implementation

{$R *.lfm}

end.

