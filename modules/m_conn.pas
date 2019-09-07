unit m_conn;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, ZConnection, ZDataset, IniFiles, BCrypt;

type

  { Tdmconn }

  Tdmconn = class(TDataModule)
    Conn: TZConnection;
    GetRoles: TZQuery;
    ZQFirmasReport: TZQuery;
    ZQs: TZQuery;
    procedure DataModuleCreate(Sender: TObject);
    function AuthUser(username, passwd: string): Boolean;
  private

  public
    Empresa: string;
    Autoriza: string;
    Entrega: string;
    FormatoCodigo: string;
    DirEmpresa: string;
    MostrarFechaResg: string;
    ImgEmpresa: string;
    Theme: string;
  end;

var
  dmconn: Tdmconn;

implementation

{$R *.lfm}

{ Tdmconn }

function Tdmconn.AuthUser(username, passwd: string) : Boolean;
begin
  // Obtener datos del usuario
  ZQs.Close;
  ZQs.SQL.Text:='SELECT id_usuarios, nombres, apellidos, contrasena, roles_id'+
  '_roles as role_id FROM usuarios WHERE usuario LIKE :user AND estatus = 1';
  ZQs.Params.ParamByName('user').AsString:=username;
  ZQs.ExecSQL;
  if ZQs.RecordCount > 0 then
  begin

  end;
end;

procedure Tdmconn.DataModuleCreate(Sender: TObject);
var
  INI: TIniFile;
begin
  if FileExists('config.ini') then
  begin
    INI:=TIniFile.Create('config.ini');
    Conn.Database:=INI.ReadString('database','db','');
    Conn.LibraryLocation:=INI.ReadString('database', 'dll', '');
    Conn.Connect;
    GetRoles.Open;
    Theme:=INI.ReadString('config', 'theme_app', '');

    // Obtener configuración de base de datos
    ZQs.SQL.Text:='select int, name, value from config where estatus = 1 '+
    'order by name asc';
    ZQs.Open;
    ZQs.First;
    while not ZQs.EOF do
    begin
      case ZQs.FieldByName('name').AsString of
      'entrega': Entrega:=ZQs.FieldByName('value').AsString;
      'autoriza': Autoriza:=ZQs.FieldByName('value').AsString;
      'dir_empresa': DirEmpresa:=ZQs.FieldByName('value').AsString;
      'empresa': Empresa:=ZQs.FieldByName('value').AsString;
      'formato_codigo': FormatoCodigo:=ZQs.FieldByName('value').AsString;
      'img_empresa': ImgEmpresa:=ZQs.FieldByName('value').AsString;
      'show_date_report_resguardo': MostrarFechaResg:=ZQs.FieldByName('value').AsString;
      end;
      ZQs.Next;
    end;
    ZQs.Close;
  end
  else
  begin
    Conn.Connect;
  end;
end;

end.

