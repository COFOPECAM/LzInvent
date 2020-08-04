uses
  Printers, WinSpool;

procedure Print;
var 
  ADevice, ADeviceName, ADevicePort: array[0..255]of Char;
  PrinterHandle: THandle
  DocInfo: TDocInfo1;
  dwJob: cardinal;
  dwBytesWritten: cardinal;
  AUtf8: UTF8string;
  ADeviceMode: THandle;
begin
  //your printer (a windows generic printer works fine)
  Printer.PrinterIndex := LocalPrinterIndex; 
  Printer.GetPrinter(ADevice, ADeviceName, ADevicePort, ADeviceMode);

  //Need a handle to the printer
  if not OpenPrinter(ADevice, FPrinterHandle, nil) then 
    Exit;

  //Fill in the structure with info about this "document"
  DocInfo.pDocName := PChar('Spooler Document Name');
  DocInfo.pOutputFile := nil;
  DocInfo.pDatatype := 'RAW';

  //Inform the spooler the document is beginning
  dwJob := StartDocPrinter(PrinterHandle, 1, @DocInfo);
  if dwJob = 0 then 
  begin
    ClosePrinter(PrinterHandle);
    FPrinterHandle := 0;
    Exit;
  end;

  //Start a page
  if not StartPagePrinter(PrinterHandle) then 
  begin
    EndDocPrinter(PrinterHandle);
    ClosePrinter(PrinterHandle);
    FPrinterHandle := 0;
    Exit;
  end;

  //your zebra code... 
  AUtf8 := UTF8string('Hello world');
  WritePrinter(PrinterHandle, @AUtf8[1], Length(AUtf8), dwBytesWritten);

  //End the page
  if not EndPagePrinter(PrinterHandle) then 
  begin
    EndDocPrinter(PrinterHandle);
    ClosePrinter(PrinterHandle);
    FPrinterHandle := 0;
    Exit;
  end;

  //Inform the spooler that the document is ending
  if not EndDocPrinter(PrinterHandle) then 
  begin
    ClosePrinter(PrinterHandle);
    FPrinterHandle := 0;
    Exit;
  end;

  //Tidy up the printer handle
  ClosePrinter(PrinterHandle);
  FPrinterHandle := 0;
end;