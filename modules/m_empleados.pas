unit m_empleados;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, db, ZDataset;

type

  { Tdmempleados }

  Tdmempleados = class(TDataModule)
    DSEmpleados: TDataSource;
    ZQAreaid: TLongintField;
    ZQAreaname: TStringField;
    ZQAreastatus: TSmallintField;
    ZQGetEmpleados: TZQuery;
    ZQAdd: TZQuery;
    ZQArea: TZQuery;
    procedure DataModuleCreate(Sender: TObject);
  private

  public

  end;

var
  dmempleados: Tdmempleados;

implementation

{$R *.lfm}

{ Tdmempleados }

procedure Tdmempleados.DataModuleCreate(Sender: TObject);
begin
  // ZQGetEmpleados.Open;
  ZQArea.Open;
end;

end.

