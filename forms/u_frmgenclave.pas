unit u_frmgenclave;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, db, Forms, Controls, Graphics, Dialogs, StdCtrls, DBCtrls,
  ButtonPanel, ZDataset;

type

  { TFrmGenClave }

  TFrmGenClave = class(TForm)
    ButtonPanel1: TButtonPanel;
    Claves: TGroupBox;
    CbCta: TComboBox;
    CbClas: TComboBox;
    CbCam: TDBLookupComboBox;
    CbProg: TDBLookupComboBox;
    DSCamp: TDataSource;
    DSProg: TDataSource;
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    LbClave: TLabel;
    LbCodigo: TLabel;
    ZQOps: TZQuery;
    ZQCamp: TZQuery;
    ZQProg: TZQuery;
    procedure CancelButtonClick(Sender: TObject);
    procedure CbCamSelect(Sender: TObject);
    procedure CbClasChange(Sender: TObject);
    procedure CbCtaChange(Sender: TObject);
    procedure CbProgSelect(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: boolean);
    procedure FormShow(Sender: TObject);
    function GenClave(cuenta, clasificacion, prog: string) :string;
    function GetConsecutivo(partclave: string) : string;
    procedure CallGenClave();
    procedure OKButtonClick(Sender: TObject);
  private
    save: Boolean;

  public
    Clave, Codigo, NameProgr: string;
    ProgId: integer;

  end;

var
  FrmGenClave: TFrmGenClave;

implementation

{$R *.lfm}

{ TFrmGenClave }

procedure TFrmGenClave.CallGenClave();
var
   cta, clas, prog: string;
begin
  if CbCta.ItemIndex <> -1 then
  begin
    if CbCta.ItemIndex = 0 then
    begin
      cta:='1201';
    end
    else
    begin
      cta:='1202';
    end;
  end
  else
  begin
    cta:='';
  end;

  if CbClas.ItemIndex > -1 then
  begin
    clas:='0' + (CbClas.ItemIndex + 1).ToString;
  end
  else
  begin
    clas:='';
  end;

  if CbProg.KeyValue = null then
  begin
    prog:='';
  end
  else
  begin
    // Obtener el valor de
    ZQProg.First;
    while not ZQProg.EOF do
    begin
      if ZQProg.FieldByName('id').AsInteger = CbProg.KeyValue then
      begin
        prog:=ZQProg.FieldByName('code').AsString;
        Break;
      end;
      ZQProg.Next;
    end;
    ProgId:=CbProg.KeyValue;
  end;
  // Llamar a la funcion para generar la clave
  LbClave.Caption:=GenClave(cta, clas, prog);
end;

procedure TFrmGenClave.OKButtonClick(Sender: TObject);
begin
  if (Codigo <> '') and (Clave <> '') then
  begin
    NameProgr:=CbProg.Text;
    save:=true;
  end;
end;

function TFrmGenClave.GetConsecutivo(partclave: string) :string;
var
  c:integer;
begin
  ZQOps.Close;
  ZQOps.SQL.Text:='select SUBSTRING(scode, 16, 4) as sig from inventory_furniture where '+
  'scode like :parte order by scode DESC limit 0, 1';
  ZQOps.Params.ParamByName('parte').AsString:=partclave + '%';
  ZQops.Open;
  if ZQOps.RecordCount = 1 then
  begin
    c:=ZQOps.FieldByName('sig').AsInteger;
    c:=c+1;
    ZQOps.Close;
    if c < 10 then
    begin
      Result:='000' + c.ToString;
    end
    else
    begin
      if (c > 9) and (c < 100) then
      begin
        Result:='00' + c.ToString;
      end
      else
      begin
        if c < 1000 then
        begin
          Result:='0' + c.ToString;
        end
        else
        begin
          Result:=c.ToString;
        end;
      end;
    end;
  end
  else
  begin
    Result:='0001';
  end;
end;

function TFrmGenClave.GenClave(cuenta, clasificacion, prog: string) : string;
var
   cl, cd ,temp: string;
begin
  // Generar la clave con los parametros pasados
  if cuenta <> '' then
  begin
    cl:='CEF-' + cuenta;
    cd:=cuenta;
  end
  else
  begin
    cl:='CEF-0000';
    cd:='0000';
  end;

  if clasificacion <> '' then
  begin
    cl:=cl + '-' +clasificacion;
    cd:=cd + clasificacion;
  end
  else
  begin
    cl:=cl + '-00';
    cd:=cd+'00';
  end;

  if prog <> '' then
  begin
    cl:=cl + '-' + prog;
    temp:=GetConsecutivo(cl);
    cl := cl + '-' + temp;
    cd:=cd + prog;
    cd:=cd+temp;
  end
  else
  begin
    cl:=cl + '-00-0000';
    cd:=cd+'000000';
  end;

  // Obtener el consecutivo dependiendo del codigo
  Clave:=cl;
  Codigo:=cd;
  LbCodigo.Caption:=cd;
  Result:=cl;
end;

procedure TFrmGenClave.FormShow(Sender: TObject);
begin
  // Obtener datos para los combos

end;

procedure TFrmGenClave.CbCtaChange(Sender: TObject);
begin
  CallGenClave();
end;

procedure TFrmGenClave.CbProgSelect(Sender: TObject);
begin
  CallGenClave();
end;

procedure TFrmGenClave.FormCloseQuery(Sender: TObject; var CanClose: boolean);
begin
  CanClose:=save;
end;

procedure TFrmGenClave.CbClasChange(Sender: TObject);
begin
  CallGenClave();
end;

procedure TFrmGenClave.CbCamSelect(Sender: TObject);
begin
  ZQProg.Close;
  ZQProg.Params.ParamByName('cam_id').AsInteger:=CbCam.KeyValue;
  ZQProg.Open;
end;

procedure TFrmGenClave.CancelButtonClick(Sender: TObject);
begin
  save:=true;
end;

end.

