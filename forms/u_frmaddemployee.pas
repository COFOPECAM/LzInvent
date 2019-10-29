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
    CbTipo: TComboBox;
    DSAreas: TDataSource;
    Label5: TLabel;
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
  dmempleados.ZQAdd.SQL.Text:='INSERT INTO user_users(name, surname, honorific,'+
  ' status, employee, apartments_id, user_job_id, user_apps) values(:name, '+
  ':surname, :honorific, 1, :employee, :apartment, 1, 0)';
  dmempleados.ZQAdd.Params.ParamByName('name').AsString:=TxtNombres.Text;
  dmempleados.ZQAdd.Params.ParamByName('surname').AsString:=TxtApellidos.Text;
  dmempleados.ZQAdd.Params.ParamByName('honorific').AsString:=TxtHonor.Text;
  dmempleados.ZQAdd.Params.ParamByName('employee').AsInteger:=CbTipo.ItemIndex;
  dmempleados.ZQAdd.Params.ParamByName('apartment').AsInteger:=CbAreas.KeyValue;
  dmempleados.ZQAdd.ExecSQL;
  MessageDlg('Operación exitosa', 'El empleado fue agregado exitosamente',
  mtInformation, [mbOK], 0);
  end
  else
  begin
    dmempleados.ZQAdd.SQL.Text:='UPDATE user_users SET name = :name, '+
    'surname = :surname, honorific = :hor, apartments_id = :area_id, employee '+
    '= :emple_type WHERE id = :empl_id';
    dmempleados.ZQAdd.Params.ParamByName('name').AsString:=TxtNombres.Text;
    dmempleados.ZQAdd.Params.ParamByName('surname').AsString:=TxtApellidos.Text;
    dmempleados.ZQAdd.Params.ParamByName('hor').AsString:=TxtHonor.Text;
    dmempleados.ZQAdd.Params.ParamByName('area_id').AsInteger:=CbAreas.KeyValue;
    dmempleados.ZQAdd.Params.ParamByName('empl_id').AsInteger:=empl_id;
    dmempleados.ZQAdd.Params.ParamByName('emple_type').AsInteger:=CbTipo.ItemIndex;
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
      dmempleados.ZQAdd.SQL.Text:='SELECT name, surname, apartments_id, '+
      'honorific, employee FROM user_users WHERE id = :empl_id';
      dmempleados.ZQAdd.Params.ParamByName('empl_id').AsInteger:=empl_id;
      dmempleados.ZQAdd.Open;
      if dmempleados.ZQAdd.RecordCount > 0 then
      begin
          TxtNombres.Text:=dmempleados.ZQAdd.FieldByName('name').Text;
          TxtApellidos.Text:=dmempleados.ZQAdd.FieldByName('surname').Text;
          TxtHonor.Text:=dmempleados.ZQAdd.FieldByName('honorific').Text;
          CbAreas.KeyValue:=StrToInt(dmempleados.ZQAdd.FieldByName('apartments_id').Text);
          CbTipo.ItemIndex:=dmempleados.ZQAdd.FieldByName('employee').AsInteger;
          dmempleados.ZQAdd.Close;
      end;
  end;
end;

end.

