object frMain: TfrMain
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Dialy register'
  ClientHeight = 485
  ClientWidth = 736
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  FormStyle = fsMDIForm
  Menu = MainMenu1
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object StatusBar1: TStatusBar
    Left = 0
    Top = 466
    Width = 736
    Height = 19
    Panels = <>
    SimplePanel = True
  end
  object ADOConnection1: TADOConnection
    Connected = True
    ConnectionString = 
      'Provider=MSDASQL.1;Password=masterkey;Persist Security Info=True' +
      ';User ID=SYSDBA;Data Source=DailyReg'
    LoginPrompt = False
    Left = 608
    Top = 8
  end
  object MainMenu1: TMainMenu
    Left = 592
    Top = 64
    object File2: TMenuItem
      Caption = 'File'
      object Exit1: TMenuItem
        Caption = 'Exit'
        OnClick = Exit1Click
      end
    end
    object Invoices1: TMenuItem
      Caption = 'Invoices'
      object Addinvoice1: TMenuItem
        Caption = 'Add invoice'
        Hint = 'Add invoice information'
        OnClick = Addinvoice1Click
      end
      object N1: TMenuItem
        Caption = '-'
      end
      object Displayinvoices1: TMenuItem
        Caption = 'Display invoices'
        Hint = 'Display supplier invoices in details'
        OnClick = Displayinvoices1Click
      end
    end
    object File1: TMenuItem
      Caption = 'Suppliers'
      object AddSupplier1: TMenuItem
        Caption = 'Add Supplier'
        Hint = 'Add new supplier'
        OnClick = AddSupplier1Click
      end
    end
  end
end
