unit m_consumibles;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, db, ZDataset;

type

  { TDmConsumibles }

  TDmConsumibles = class(TDataModule)
    ZQConsu: TZQuery;
    ZQCat: TZQuery;
    ZQStock: TZQuery;
    ZQStockid: TLongintField;
    ZQStockname: TStringField;
    ZQStocktotal: TLongintField;
  private

  public

  end;

var
  DmConsumibles: TDmConsumibles;

implementation

{$R *.lfm}

end.

