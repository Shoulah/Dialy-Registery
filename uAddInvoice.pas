unit uAddInvoice;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uFloatEdit, ComCtrls, StdCtrls, ADODB;

type
  TfrAddInvoice = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    ComboBox1: TComboBox;
    Edit1: TEdit;
    Edit2: TEdit;
    DateTimePicker1: TDateTimePicker;
    FloatEdit1: TFloatEdit;
    Button1: TButton;
    CheckBox1: TCheckBox;
    GroupBox1: TGroupBox;
    procedure FormCreate(Sender: TObject);
    procedure ComboBox1Change(Sender: TObject);
    procedure Edit1KeyPress(Sender: TObject; var Key: Char);
    procedure Button1Click(Sender: TObject);
  private
  procedure ListAllSuppliers;
  function GetSupplierIdByName(s_Name : string):Integer;
  function GetSupplierByID(ID : Integer):string;
  procedure SaveInvoice;
  Function CheckForEmptyFields:Boolean;
  procedure ClearAllFields;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frAddInvoice: TfrAddInvoice;

implementation

uses uMain;

{$R *.dfm}

{ TfrAddInvoice }

procedure TfrAddInvoice.Button1Click(Sender: TObject);
begin
//check if there is an empty field befor saving
//if true then exit the saving proccess
if not CheckForEmptyFields then
begin
//save invoice to invoices table
SaveInvoice;
if MessageDlg('Invoice saved successfully .. Do you want add new invoice?',
                                          mtConfirmation,mbYesNo,0) = mrYes then
 //clear all fields for new invoice entering
ClearAllFields
else
// close the enter invoice form
frAddInvoice.Close;
end;
end;

function TfrAddInvoice.CheckForEmptyFields:Boolean;
begin
if ComboBox1.ItemIndex < 0  then
begin
  ShowMessage('Please select supplier before save ..!');
  Result := True;
  Exit;
end;
if Trim(Edit2.Text) = '' then
begin
  ShowMessage('Please enter invoice number..');
  Result := True;
  Exit;
end;
if Trim(FloatEdit1.Text) = '' then
begin
  ShowMessage('Please enter invoice value..');
  Result := True;
  Exit;
end;
Result := False;
end;

procedure TfrAddInvoice.ClearAllFields;
begin
//select nothing
ComboBox1.ItemIndex := -1;
Edit1.Text := '0';
//clear invoice number edit box
Edit2.Text := '';
//clear invoice value edit box
FloatEdit1.Text := '';
//uncheck paid checkbox
CheckBox1.Checked := False;
end;

procedure TfrAddInvoice.ComboBox1Change(Sender: TObject);
begin
//get supplier id using its name
Edit1.Text := IntToStr(GetSupplierIdByName(ComboBox1.Items[ComboBox1.ItemIndex]));
end;

procedure TfrAddInvoice.Edit1KeyPress(Sender: TObject; var Key: Char);
begin
// if user press enter key
if Key = #13 then
begin
// check if the supplier is in the database or not
  if GetSupplierByID(StrToInt(edit1.Text)) = '' then
  begin
  //showmessage if the supplier not available
    ShowMessage('Supplier not available ');
    //exit here not continue
    Exit;
  end;
//select the supplier name by id
end;
  ComboBox1.ItemIndex :=
                 ComboBox1.Items.IndexOf(GetSupplierByID(StrToInt(edit1.Text)));
end;

procedure TfrAddInvoice.FormCreate(Sender: TObject);
begin
// list all suppliers when form is created and fill combobox with supplier names
ListAllSuppliers;
// set date to current day date
DateTimePicker1.Date := Date;
end;

function TfrAddInvoice.GetSupplierByID(ID: Integer): string;
var
 MyQuery : TADOQuery;
begin
//create myquery
 MyQuery := TADOQuery.Create(nil);
 try
   with MyQuery do
   begin
   //using the adoconnection from main form
     Connection := frMain.ADOConnection1;
     sql.Text := 'select supplier_name from suppliers';
     //serach by supplier id
     sql.Add(' where Supplier_id = '+QuotedStr(IntToStr(ID)));
     // open query
     Open;
   end;
   // return the result
 Result := MyQuery.FieldByName('supplier_name').AsString;
 finally
 //close the connection
   MyQuery.Close;
   //free the query from memory
   MyQuery.Free;
 end;

end;

function TfrAddInvoice.GetSupplierIdByName(s_Name: String): Integer;
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

procedure TfrAddInvoice.ListAllSuppliers;
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
   ComboBox1.ItemIndex := -1;
   //get the id of the supplier selected
   Edit1.Text := IntToStr(GetSupplierIdByName(ComboBox1.Items[ComboBox1.ItemIndex]));
 finally
 //close the connection to the datatabase
   MyQuery.Close;
 //Destroys the query and frees its associated memory
   MyQuery.Free;
 end;
end;

procedure TfrAddInvoice.SaveInvoice;
var
 MyQuery : TADOQuery;
 p : byte;
begin
//if invoice paid or not
if CheckBox1.Checked then p := 1 else p := 0;
 //Create the query
 MyQuery := TADOQuery.Create(nil);
try
   with MyQuery do
 begin
  Connection := frMain.ADOConnection1;
  SQL.Text := 'insert into invoices (INVOICE_NO, INVOICE_DATE, SUPPLIER_ID, INVOICE_VALUE, PAID) values ('+
              QuotedStr(Edit2.Text) + ',' +
              QuotedStr(FormatDateTime('MM-dd-yyyy',DateTimePicker1.Date)) + ',' +
              QuotedStr(Edit1.Text) + ',' +
              QuotedStr(FloatEdit1.Text) + ',' +
              QuotedStr(inttostr(p))
             +')';
  ExecSQL;
 end;
finally
//Close the connection
 MyQuery.Close;
 //Destroys the query and frees its associated memory
MyQuery.Free;
end;
end;

end.
