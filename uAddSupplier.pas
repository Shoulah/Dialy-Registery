unit uAddSupplier;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ADODB;

type
  TfrAddSupplier = class(TForm)
    Label1: TLabel;
    Edit1: TEdit;
    Button1: TButton;
    GroupBox1: TGroupBox;
    procedure Button1Click(Sender: TObject);
  private
  function isSupplierExists(supplier_name : string):Boolean;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frAddSupplier: TfrAddSupplier;

implementation

uses uMain;

{$R *.dfm}
 //-Add Supplier button onclick event
procedure TfrAddSupplier.Button1Click(Sender: TObject);
var
 MyQuery : TADOQuery;
begin
//Check if the user entered the supplier name or name field is empty
if Trim(Edit1.Text) = '' then
begin
  ShowMessage('Please enter the supplier name !');
  Exit;
end;
//check if the supplier exists
if isSupplierExists(Trim(Edit1.Text)) then
begin
  ShowMessage('This supplier is exists ...!');
  //if exists cancel the insertion
  Exit;
end;
//-- insert new supplier--
//create the query
  MyQuery := TADOQuery.Create(nil);
  try
  //using the Adoconnection from main form
    MyQuery.Connection := frmain.ADOConnection1;
    //insert the new supplier name in suppliers Table
    MyQuery.SQL.Text := 'insert into suppliers (Supplier_name) values ('
                        +QuotedStr(Trim(Edit1.Text)) + ')';
    //Execute the insertion SQL statement
    MyQuery.ExecSQL;
    //ask the user if he want add new supplier or close the add supplier form
    if MessageDlg('The supplier has been added successfully .. Do you want add new supplier ?',
                                         mtConfirmation,mbYesNo,0) = mrYes  then
     //clear the supplier name edit box for new supplier bame
     Edit1.Text := ''
     else
     //close the add supplier form
     frAddSupplier.Close;
  finally
  //close the connection
    MyQuery.Close;
    //Destroys the query and frees its associated memory
    MyQuery.Free;
  end;
end;
//******************************************************************************
//---------------------- isSupplierExists Function -----------------------------
//******************************************************************************
function TfrAddSupplier.isSupplierExists(supplier_name: string): Boolean;
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
     //select supplier by name
     sql.Text := 'select * from suppliers where supplier_name = '
                                                     + QuotedStr(supplier_name);
     //Open and execute the query
     Open;
   end;
   //check if the supplier exists ..if exists it should be more than one record
   if MyQuery.RecordCount = 0 then
   // return false if supplier not exits
     Result := False
     else
     //return True if the supplier is exits
     Result := True;
 finally
 //close the connection to the database
  MyQuery.Close;
  //Destroys the query and frees its associated memory
  MyQuery.Free;
 end;
end;

end.
