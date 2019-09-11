unit m_bienes;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, db, ZDataset;

type

  { TDmBienes }

  TDmBienes = class(TDataModule)
    DSSearch: TDataSource;
    DSEstatus: TDataSource;
    DSLugar: TDataSource;
    DSMarca: TDataSource;
    DSCat: TDataSource;
    DSSub: TDataSource;
    DSProv: TDataSource;
    ZQEstatus: TZQuery;
    ZQLugar: TZQuery;
    ZQMarca: TZQuery;
    ZQCat: TZQuery;
    ZQSub: TZQuery;
    ZQProv: TZQuery;
    ZQSearch: TZQuery;
  private

  public

  end;

var
  DmBienes: TDmBienes;

implementation

{$R *.lfm}

end.

