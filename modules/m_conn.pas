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
    CPrinter: string;
    IPrinter: integer;
    // Datos del usuario
    Nombre: string;
    Apellido: string;
    UserId: integer;
    RoleId: integer;
  end;

var
  dmconn: Tdmconn;

implementation

{$R *.lfm}

{ Tdmconn }

function Tdmconn.AuthUser(username, passwd: string) : Boolean;
var
  Cifrar : TBCryptHash;
  Verify : Boolean;
begin
  Verify:=false;
  // Obtener datos del usuario
  ZQs.Close;
  ZQs.SQL.Text:='SELECT id, name, surname, username, passwd FROM user_users'+
  ' WHERE username LIKE :user';
  ZQs.Params.ParamByName('user').AsString:=username;
  ZQs.Open;
  if ZQs.RecordCount > 0 then
  begin
    Cifrar := TBCryptHash.Create;
    Verify := Cifrar.VerifyHash(passwd, ZQs.FieldByName('passwd').AsString);
    Cifrar.Free;
    if Verify then
    begin
      Nombre:=ZQs.FieldByName('name').AsString;
      Apellido:=ZQs.FieldByName('surname').AsString;
      UserId:=ZQs.FieldByName('id').AsInteger;
      // RoleId:=ZQs.FieldByName('role_id').AsInteger;

      // Obtener permisos del usuario
    end;
  end;
  Result:=Verify;
end;

procedure Tdmconn.DataModuleCreate(Sender: TObject);
var
  INI: TIniFile;
begin
  if FileExists('config.ini') then
  begin
    INI:=TIniFile.Create('config.ini');
    Conn.Connect;
    // GetRoles.Open;
    Theme:=INI.ReadString('config', 'theme_app', '');
    CPrinter:=INI.ReadString('config', 'cprinter', '');
    IPrinter:=StrToInt(INI.ReadString('config', 'iprinter', ''));

    // Obtener configuración de base de datos
    ZQs.SQL.Text:='SELECT id, skey, svalue FROM general_config WHERE '+
    'applications_id = 4 and status = 1';
    ZQs.Open;
    ZQs.First;
    while not ZQs.EOF do
    begin
      case ZQs.FieldByName('skey').AsString of
      'inventory_entrega': Entrega:=ZQs.FieldByName('svalue').AsString;
      'inventory_autoriza': Autoriza:=ZQs.FieldByName('svalue').AsString;
      'inventory_dir_empresa': DirEmpresa:=ZQs.FieldByName('svalue').AsString;
      'inventory_empresa': Empresa:=ZQs.FieldByName('svalue').AsString;
      'inventory_show_report_entrega': MostrarFechaResg:=ZQs.FieldByName('svalue').AsString;
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

