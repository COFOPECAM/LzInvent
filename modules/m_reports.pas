unit m_reports;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, LR_Class, LR_DBSet, LR_E_HTM, LR_Desgn, lr_e_pdf;

type

  { TDmReports }

  TDmReports = class(TDataModule)
  private

  public

  end;

var
  DmReports: TDmReports;

implementation

{$R *.lfm}

end.

