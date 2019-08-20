unit m_user;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, ZDataset;

type

  { TDMUser }

  TDMUser = class(TDataModule)
    ZQPermisos: TZQuery;
  private

  public

  end;

var
  DMUser: TDMUser;

implementation

{$R *.lfm}

end.

