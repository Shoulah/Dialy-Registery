program DialyRegister;

uses
  Forms,
  uMain in 'uMain.pas' {frMain},
  uAddSupplier in 'uAddSupplier.pas' {frAddSupplier},
  uAddInvoice in 'uAddInvoice.pas' {frAddInvoice},
  uInvoices in 'uInvoices.pas' {frInvoices},
  uMycollection in 'uMycollection.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrMain, frMain);
  Application.Run;
end.
