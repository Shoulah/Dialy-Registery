unit uMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, ADODB, Grids, DBGrids, StdCtrls, Menus, ComCtrls;

type
  TfrMain = class(TForm)
    ADOConnection1: TADOConnection;
    MainMenu1: TMainMenu;
    File1: TMenuItem;
    AddSupplier1: TMenuItem;
    Invoices1: TMenuItem;
    Addinvoice1: TMenuItem;
    N1: TMenuItem;
    Displayinvoices1: TMenuItem;
    StatusBar1: TStatusBar;
    File2: TMenuItem;
    Exit1: TMenuItem;
    procedure AddSupplier1Click(Sender: TObject);
    procedure Addinvoice1Click(Sender: TObject);
    procedure Displayinvoices1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Exit1Click(Sender: TObject);

  private
  procedure DisplayHint(Sender: TObject);
    { Private declarations }
  public
  procedure LoadAddSupplierForm;
  procedure LoadAddInvoiceForm;
  procedure LoadInvoicesForm;
    { Public declarations }
  end;

var
  frMain: TfrMain;

implementation

uses uAddSupplier, uAddInvoice, uInvoices;

{$R *.dfm}

procedure TfrMain.Addinvoice1Click(Sender: TObject);
begin
 LoadAddInvoiceForm;
end;
procedure TfrMain.AddSupplier1Click(Sender: TObject);
begin
LoadAddSupplierForm;
end;


procedure TfrMain.DisplayHint(Sender: TObject);
begin
StatusBar1.SimpleText := GetLongHint(Application.Hint);
end;

procedure TfrMain.Displayinvoices1Click(Sender: TObject);
begin
LoadInvoicesForm;
end;

procedure TfrMain.Exit1Click(Sender: TObject);
begin
// Close program
frMain.Close;
end;

procedure TfrMain.FormCreate(Sender: TObject);
begin
Application.OnHint := DisplayHint;
end;

//------------------------------------------------------------------------------
//******************** Load Add Invoice Form ***********************************
//------------------------------------------------------------------------------
procedure TfrMain.LoadAddInvoiceForm;
begin
frAddInvoice := TfrAddInvoice.Create(nil);
try
  frAddInvoice.ShowModal;
finally
  frAddInvoice.Release;
end;
end;
//------------------------------------------------------------------------------

//------------------------------------------------------------------------------
//******************* Load Add Supplier Form ***********************************
//------------------------------------------------------------------------------
procedure TfrMain.LoadAddSupplierForm;
begin
 frAddSupplier := TfrAddSupplier.Create(nil);
try
  frAddSupplier.ShowModal;
finally
  frAddSupplier.Release;
end;
end;
//------------------------------------------------------------------------------

//------------------------------------------------------------------------------
//******************* Load invoices Form ***************************************
//------------------------------------------------------------------------------
procedure TfrMain.LoadInvoicesForm;
var
 i : Integer;
 isFormCreated : Boolean;
begin
//initialize of x value .
isFormCreated := False;
//-- loop to find mdichild form with class name 'TfrInvoices'
for I := 0 to MDIChildCount - 1 do
 if MDIChildren[i].ClassType = TfrInvoices then
 //if there is a created instance set x to true
 isFormCreated := True
  else isFormCreated := False;
//--
 if isFormCreated then
    begin
    //set window state to maximized
      frInvoices.WindowState := wsMaximized;
    //show the invoices form
      frInvoices.Show;
    end
else
// if not isFormCreated then
 begin
// create invoices form and let application responsible for release it from memory
frInvoices := TfrInvoices.Create(Application);
//set window state to maximized
frInvoices.WindowState := wsMaximized;
//show the invoices form
frInvoices.Show;
 end; //end of else
end;
//------------------------------------------------------------------------------
end.
