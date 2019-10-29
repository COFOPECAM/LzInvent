unit u_frmaddprograma;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, db, Forms, Controls, Graphics, Dialogs, StdCtrls, DBCtrls,
  ButtonPanel, ZDataset;

type

  { TFrmAddProg }

  TFrmAddProg = class(TForm)
    Bp: TButtonPanel;
    CbCampana: TDBLookupComboBox;
    CbCoord: TDBLookupComboBox;
    DSCamp: TDataSource;
    DSCoord: TDataSource;
    TxtProg: TEdit;
    TxtCons: TEdit;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    ZQCamp: TZQuery;
    ZQCoord: TZQuery;
    ZQCoordempleado: TStringField;
    ZQCoordid: TLongintField;
    ZQ: TZQuery;
    procedure FormCloseQuery(Sender: TObject; var CanClose: boolean);
    procedure FormShow(Sender: TObject);
    procedure OKButtonClick(Sender: TObject);
    function GetNextCode(): integer;
  private
    NextCode: integer;
    Save: Boolean;

  public
    ProgId: integer;
    EditMode: Boolean;

  end;

var
  FrmAddProg: TFrmAddProg;

implementation

{$R *.lfm}

{ TFrmAddProg }

procedure TFrmAddProg.OKButtonClick(Sender: TObject);
begin
  if not EditMode then
  begin
  ZQ.Close;
  ZQ.SQL.Text:='insert into general_program_disease(name, general_programs_id,'+
  'code,view_app,status,user_users_id) values(:name,:prog_id,:code,''all'',1, '+
  ':coord)';
  ZQ.Params.ParamByName('name').AsString:=TxtProg.Text;
  ZQ.Params.ParamByName('prog_id').AsInteger:=CbCampana.KeyValue;
  ZQ.Params.ParamByName('code').AsString:=TxtCons.Text;
  ZQ.Params.ParamByName('coord').AsInteger:=CbCoord.KeyValue;
  ZQ.ExecSQL;
  Save:=true;
  end
  else
  begin
    // Editar el programa
  end;
end;

procedure TFrmAddProg.FormShow(Sender: TObject);
begin
  NextCode:=GetNextCode();
  TxtCons.Text:=NextCode.ToString;
end;

procedure TFrmAddProg.FormCloseQuery(Sender: TObject; var CanClose: boolean);
begin
  CanClose:=Save;
end;

function TFrmAddProg.GetNextCode(): integer;
var
  CodeId: integer;
begin
  ZQ.Close;
  // Obtener el siguiente codigo
  ZQ.SQL.Text:='select (cast(gpd.code as integer) + 1) as next_code from '+
  'general_program_disease gpd order by gpd.code desc limit 0, 1';
  ZQ.Open;
  if ZQ.RecordCount > 0 then
  begin
    CodeId:=ZQ.FieldByName('next_code').AsInteger;
    ZQ.Close;
    Result:=CodeId;
  end
  else
  begin
    Result:=0;
  end;
end;

end.

