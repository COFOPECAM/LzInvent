unit m_empleados;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, db, ZDataset;

type

  { Tdmempleados }

  Tdmempleados = class(TDataModule)
    DSEmpleados: TDataSource;
    ZQGetEmpleados: TZQuery;
  private

  public

  end;

var
  dmempleados: Tdmempleados;

implementation

{$R *.lfm}

end.

