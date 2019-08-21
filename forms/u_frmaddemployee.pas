unit u_frmaddemployee;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, DBCtrls,
  ButtonPanel, m_empleados, db;

type

  { TFrmAddEmpleado }

  TFrmAddEmpleado = class(TForm)
    BP: TButtonPanel;
    CbAreas: TDBLookupComboBox;
    DSAreas: TDataSource;
    TxtHonor: TEdit;
    Label4: TLabel;
    TxtNombres: TEdit;
    TxtApellidos: TEdit;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    procedure CloseButtonClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: boolean);
    procedure FormShow(Sender: TObject);
    procedure OKButtonClick(Sender: TObject);
  private
    save:Boolean;

  public
    empl_id: integer;
    edit:Boolean;

  end;

var
  FrmAddEmpleado: TFrmAddEmpleado;

implementation

{$R *.lfm}

{ TFrmAddEmpleado }

procedure TFrmAddEmpleado.OKButtonClick(Sender: TObject);
var
  i: integer;
begin
  // Validar que toda la información este completa
  for i:=0 to ComponentCount - 1 do
  begin
    if (Components[i] is TEdit) then
    begin
      if TEdit(Components[i]).Text = '' then
      begin
        MessageDlg('Faltan datos', 'Todos los campos son obligatorios',
        mtInformation, [mbOK], 0);
        TEdit(Components[i]).SetFocus;
        save:=false;
        Exit;
      end;
    end;
  end;
  if CbAreas.KeyValue = 0 then
  begin
    MessageDlg('Faltan datos', 'Todos los campos son obligatorios',
        mtInformation, [mbOK], 0);
    CbAreas.SetFocus;
    save:=false;
    Exit;
  end;

  // Verificar si es una edición o un registro nuevo
  if not edit then
  begin
  dmempleados.ZQAdd.SQL.Text:='INSERT INTO empleados(nombres, apellidos, honorifico, '+
  'areas_id_area, estatus) VALUES(:name, :surname, :ho, :area_id, 1)';
  dmempleados.ZQAdd.Params.ParamByName('name').AsString:=TxtNombres.Text;
  dmempleados.ZQAdd.Params.ParamByName('surname').AsString:=TxtApellidos.Text;
  dmempleados.ZQAdd.Params.ParamByName('ho').AsString:=TxtHonor.Text;
  dmempleados.ZQAdd.Params.ParamByName('area_id').AsInteger:=CbAreas.KeyValue;
  dmempleados.ZQAdd.ExecSQL;
  MessageDlg('Operación exitosa', 'El empleado fue agregado exitosamente',
  mtInformation, [mbOK], 0);
  end
  else
  begin
    dmempleados.ZQAdd.SQL.Text:='UPDATE empleados SET nombres = :name, '+
    'apellidos = :surname, honorifico = :hor, areas_id_area = :area_id WHERE'+
    ' id_empleado = :empl_id';
    dmempleados.ZQAdd.Params.ParamByName('name').AsString:=TxtNombres.Text;
    dmempleados.ZQAdd.Params.ParamByName('surname').AsString:=TxtApellidos.Text;
    dmempleados.ZQAdd.Params.ParamByName('hor').AsString:=TxtHonor.Text;
    dmempleados.ZQAdd.Params.ParamByName('area_id').AsInteger:=CbAreas.KeyValue;
    dmempleados.ZQAdd.Params.ParamByName('empl_id').AsInteger:=empl_id;
    dmempleados.ZQAdd.ExecSQL;
    MessageDlg('Operación exitosa',
    'Los datos del empleado fueron actualizados exitosamente',
    mtInformation, [mbOK], 0);
  end;
  save:=true;
end;

procedure TFrmAddEmpleado.FormCloseQuery(Sender: TObject; var CanClose: boolean
  );
var
  i:integer;
begin
  for i:=0 to ComponentCount - 1 do
  begin
    if (Components[i] is TEdit) then
    begin
      TEdit(Components[i]).Text := ''
    end;
  end;
  CbAreas.KeyValue:=0;
  edit:=false;
  CanClose:=save;
end;

procedure TFrmAddEmpleado.CloseButtonClick(Sender: TObject);
begin
  save:=true;
end;

procedure TFrmAddEmpleado.FormShow(Sender: TObject);
begin
  save:=true;
  // Obtener datos del empleado a editar
  if edit then
  begin
      dmempleados.ZQAdd.SQL.Text:='SELECT nombres, apellidos, areas_id_area, '+
      'honorifico FROM empleados WHERE id_empleado = :empl_id';
      dmempleados.ZQAdd.Params.ParamByName('empl_id').AsInteger:=empl_id;
      dmempleados.ZQAdd.Open;
      if dmempleados.ZQAdd.RecordCount > 0 then
      begin
          TxtNombres.Text:=dmempleados.ZQAdd.FieldByName('nombres').Text;
          TxtApellidos.Text:=dmempleados.ZQAdd.FieldByName('apellidos').Text;
          TxtHonor.Text:=dmempleados.ZQAdd.FieldByName('honorifico').Text;
          CbAreas.KeyValue:=StrToInt(dmempleados.ZQAdd.FieldByName('areas_id_area').Text);
          dmempleados.ZQAdd.Close;
      end;
  end;
end;

end.

