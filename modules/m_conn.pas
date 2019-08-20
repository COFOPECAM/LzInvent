unit m_conn;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, ZConnection, ZDataset, IniFiles;

type

  { Tdmconn }

  Tdmconn = class(TDataModule)
    Conn: TZConnection;
    GetRoles: TZQuery;
    procedure DataModuleCreate(Sender: TObject);
  private

  public
    theme_app:string;

  end;

var
  dmconn: Tdmconn;

implementation

{$R *.lfm}

{ Tdmconn }

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
    theme_app:=INI.ReadString('config', 'theme_app', '');
  end
  else
  begin
    Conn.Connect;
  end;
end;

end.

