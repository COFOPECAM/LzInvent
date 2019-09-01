unit StringsFormat;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, StrUtils;

type
  TStringsFormat = class
    // Funciones de la clase
    public
      function GetCode(format : string; number: integer): string;
    private

  end;

implementation

function TStringsFormat.GetCode(format: string; number: integer): string;
var
  i: integer;
  sreplace, new_string: string;
begin
  sreplace:='';
  // Obtener parte para reemplazar
  for i:=1 to Length(format) do
  begin
    if format[i] = '#' then
    begin
      sreplace:=sreplace + format[i];
    end;
  end;
  new_string:=AddChar('0', number.ToString, Length(sreplace));
  Result:=StringReplace(format, sreplace, new_string, [rfReplaceAll]);
end;

end.

