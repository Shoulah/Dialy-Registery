unit uMycollection;

interface
   uses math,extctrls,sysutils,stdctrls,dialogs;

    procedure scalemypanel(i,x:Integer;panel:TPanel);
    function returnNumberonly(key: char; str: string): char;
    procedure checkEditEmpty(myedit: tedit; strmsg: string);
    function ashdshfr(msg,pwd:string):string;
    function mydir_plus(path:string):string;
    Function UpperCaseFirstLetter (Str : String) : String;
implementation
//================= Scale my panel ========================
 procedure scalemypanel(i,x:Integer;panel:TPanel);
 var
  r:double;
 begin
   r:=min(i/panel.Width,x/panel.Height);
   panel.ScaleBy(trunc(r * 100),100);
 end;
 //--------------------------------------------------------
 //======== check if i enter float number only ============
 function returnNumberonly(key: char; str: string): char;
 begin
 if (trim(str) = '0') and not(CharInSet(key,[#13,#8,'.'])) then Key:=#0;
if (trim(str) = '0') and (CharInSet(key,['0']))  then Key:=#0;
if (trim(str) = '') and (CharInSet(key,['.'])) then Key:=#0;
if (pos('.',str) > 0) and (CharInSet(key,['.'])) then Key:=#0;
if not CharInSet(key,[#13,#8,'0'..'9','.']) then Key:=#0;
Result:=key;
end;
//-----------------------------------------------------------
//========= check if the edit is empty =====================
 procedure checkEditEmpty(myedit: tedit; strmsg: string);
 begin
if trim(myedit.Text) = '' then
begin
  ShowMessage(strmsg);
  myedit.SetFocus;
  abort;
end;
 end;
 //============================================================
 function ashdshfr(msg, pwd: string): string;
var
 i,ipwpos,iLoop,ip1,ip2:integer;
s1,s2:string;
begin

ipwpos:=0;
 s1:=copy(msg,1,pos('|',msg)-1);

 iLoop:=strtoint(s1);
 iLoop:= iLoop div length(pwd);
 for I := 1 to iloop do
   begin
     ipwpos:=ipwpos+1;
     Delete(msg,1,pos('|',msg));
     if pos('|',msg) >  0 then
     s2:=copy(msg,1,pos('|',msg) -1)
     else s2:=msg;
     ip1:=(strtoint(s2)); //div ord(pwd[ipwpos]);
     ip2:= (ip1 div  ord(pwd[ipwpos]));
     Result:=Result+chr(ip2);
     if ipwpos = Length(pwd) then  ipwpos:= 0;

   end;
end;
//==============================================================
function mydir_plus(path:string):string;  //====used in sybase backup
var i:integer;
newp:string;
begin

 for I := 1 to length(path)  do
 begin
   newp:=newp+path[i];
   if path[i] = '\' then newp:=newp+'\';

 end;
   Result:=newp;
end;
//=====================    UpperCaseFirstLetter    =======================
Function UpperCaseFirstLetter ( Str : String) : String;
var
 myStr : String;
begin

   while length(str) > 0 do
      begin
      if pos(' ',str) > 0 then
      begin

        myStr := myStr + UpperCase(Copy(Str,1,1)) + Copy(Str,2,pos(' ',Str)  - 1);
        Delete(str,1,pos(' ',Str) );

      end //End of if
   else
      begin

       myStr := myStr + UpperCase(Copy(Str,1,1)) + Copy(Str,2,length(Str)  - 1);
       Delete(str,1,length(Str));

      end;  // End of else
   end; // End of Do
      Result := myStr;
end;
 //----------------------------------------------------------
end.
