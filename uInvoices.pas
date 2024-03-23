unit uInvoices;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, ADODB, Grids, DBGrids, DB, ComCtrls, DateUtils,
  Menus;

type
  TfrInvoices = class(TForm)
    Panel1: TPanel;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    ComboBox1: TComboBox;
    GroupBox2: TGroupBox;
    DBGrid1: TDBGrid;
    ADOQuery1: TADOQuery;
    DataSource1: TDataSource;
    Label2: TLabel;
    Label3: TLabel;
    GroupBox3: TGroupBox;
    DateTimePicker2: TDateTimePicker;
    DateTimePicker1: TDateTimePicker;
    Label4: TLabel;
    Label5: TLabel;
    CheckBox1: TCheckBox;
    PopupMenu1: TPopupMenu;
    Deletethisinvoice1: TMenuItem;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure ComboBox1Change(Sender: TObject);
    procedure ComboBox1Select(Sender: TObject);
    procedure CheckBox1Click(Sender: TObject);
    procedure DateTimePicker2Change(Sender: TObject);
    procedure Deletethisinvoice1Click(Sender: TObject);
  private
  procedure ListAllSuppliers;
  function GetSupplierIdByName(s_Name : string):Integer;
  procedure ListAllInvoiceForSupplierId(Supplier_ID : Integer);
  Function CalculateInvoiceBySipplier(SupplierID : string):string;
  procedure DisplayResult;
  procedure DeleteInvoice(InvoiceNo : string);
    { Private declarations }
  public
    { Public declarations }
  end;
  type
  ThackedDBgrid = class (TDBGrid);

var
  frInvoices: TfrInvoices;

implementation

uses uMain, uMycollection;

{$R *.dfm}

function TfrInvoices.CalculateInvoiceBySipplier(SupplierID: string): string;
var
 myQuery : TADOQuery;
begin
Result := '0';
 myQuery := TADOQuery.Create(nil);
 try
  with myQuery do
  begin
    Connection := frMain.ADOConnection1;
    SQL.Text := 'select sum (INVOICE_VALUE) as Total_sum from invoices';
    SQL.Add('where supplier_id = '+ QuotedStr(SupplierID));
    if CheckBox1.Checked then
    SQL.Add(' and invoice_date between '+
    QuotedStr(FormatDateTime('MM-dd-yyyy',DateTimePicker1.Date))+' and '+
    QuotedStr(FormatDateTime('MM-dd-yyyy',DateTimePicker2.Date)));
    Open;
    Result := FieldByName('Total_sum').AsString;
  end;
 finally
   //myQuery.Close;
   myQuery.Free;
 end;
end;

procedure TfrInvoices.CheckBox1Click(Sender: TObject);
begin
if CheckBox1.Checked then
    GroupBox3.Visible := True
   else
    GroupBox3.Visible := False;
    DisplayResult;
end;

procedure TfrInvoices.ComboBox1Change(Sender: TObject);
begin
ListAllInvoiceForSupplierId(GetSupplierIdByName(ComboBox1.Text[ComboBox1.ItemIndex]));
end;

procedure TfrInvoices.ComboBox1Select(Sender: TObject);
begin
DisplayResult;
end;
//==============================================================================
procedure TfrInvoices.DateTimePicker2Change(Sender: TObject);
begin
DisplayResult;
end;
procedure TfrInvoices.DeleteInvoice(InvoiceNo: string);
var
 myQuery : TADOQuery;
begin
 myQuery := TADOQuery.Create(nil);
 try
  myQuery.Connection := frMain.ADOConnection1;
  myQuery.SQL.Text := 'delete from invoices where invoice_id = '+QuotedStr(InvoiceNo);
  myQuery.ExecSQL;
 finally
   myQuery.Free;
 end;
end;

procedure TfrInvoices.Deletethisinvoice1Click(Sender: TObject);
begin
DeleteInvoice(ADOQuery1.FieldByName('invoice_id').AsString);
DisplayResult;
end;

//------------------------------------------------------------------------------
procedure TfrInvoices.DisplayResult;
begin
ListAllInvoiceForSupplierId(GetSupplierIdByName(ComboBox1.items[ComboBox1.ItemIndex]));
Label2.Caption := CalculateInvoiceBySipplier(IntToStr(GetSupplierIdByName(ComboBox1.items[ComboBox1.ItemIndex])));
end;

procedure TfrInvoices.FormClose(Sender: TObject; var Action: TCloseAction);
begin
 Action := caFree;
end;

procedure TfrInvoices.FormCreate(Sender: TObject);
begin
ListAllSuppliers;
DateTimePicker1.Date := StartOfTheMonth(Date);
DateTimePicker2.Date := Date;
DisplayResult;

end;

procedure TfrInvoices.FormResize(Sender: TObject);
begin
scalemypanel(ClientWidth,ClientHeight,Panel1);
end;

function TfrInvoices.GetSupplierIdByName(s_Name: string): Integer;
var
 MyQuery : TADOQuery;
begin
//create the query
 MyQuery := TADOQuery.Create(nil);
 try
   with MyQuery do
   begin
   //using the adoconnection from main form
     Connection := frMain.ADOConnection1;
     sql.Text := 'select supplier_ID from suppliers';
     //search by name
     sql.Add(' where Supplier_name = '+QuotedStr(s_Name));
     Open;
   end;
   //return the result as integer
 Result := MyQuery.FieldByName('supplier_ID').AsInteger;
 finally
 //close the query connection to the datatbase
   MyQuery.Close;
 //Destroys the query and frees its associated memory
   MyQuery.Free;
 end;

end;

procedure TfrInvoices.ListAllInvoiceForSupplierId(Supplier_ID: Integer);
begin
with ADOQuery1 do
begin
  close;
  sql.Clear;
  sql.Text := 'select * from invoices';
  sql.Add(' where supplier_id = '+inttostr(Supplier_ID));
  if CheckBox1.Checked then
    SQL.Add(' and invoice_date between '+
    QuotedStr(FormatDateTime('MM-dd-yyyy',DateTimePicker1.Date))+' and '+
    QuotedStr(FormatDateTime('MM-dd-yyyy',DateTimePicker2.Date)));
  Open;
end;
end;

procedure TfrInvoices.ListAllSuppliers;
var
 MyQuery : TADOQuery;
begin
//create the query
 MyQuery := TADOQuery.Create(nil);
 try
   with MyQuery do
   begin
   //using the adoconnection from main form
     Connection := frMain.ADOConnection1;
     //select all suppliers names
     sql.Text := 'select supplier_name from suppliers';
     //open the query
     Open;
   end;
   //clear all the items in the combobox
   ComboBox1.Items.Clear;
   //fill the combobox with names
   while not MyQuery.Eof do
   begin
     ComboBox1.Items.Add(MyQuery.FieldByName('supplier_name').AsString);
     //move to next record
     MyQuery.Next;
   end;
   //select the first supplier name 'item' in the combobox
   ComboBox1.ItemIndex := 0;
   //get the id of the supplier selected
 finally
 //close the connection to the datatabase
   MyQuery.Close;
 //Destroys the query and frees its associated memory
   MyQuery.Free;
 end;

end;

end.
