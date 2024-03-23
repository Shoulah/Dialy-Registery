object frAddInvoice: TfrAddInvoice
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Add invoice'
  ClientHeight = 193
  ClientWidth = 472
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object GroupBox1: TGroupBox
    Left = 8
    Top = 8
    Width = 457
    Height = 177
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    object Label1: TLabel
      Left = 3
      Top = 3
      Width = 115
      Height = 19
      Caption = 'Supplier Name :'
    end
    object Label2: TLabel
      Left = 3
      Top = 39
      Width = 89
      Height = 19
      Caption = 'Supplier Id :'
    end
    object Label3: TLabel
      Left = 3
      Top = 72
      Width = 84
      Height = 19
      Caption = 'Invoice NO.'
    end
    object Label4: TLabel
      Left = 3
      Top = 110
      Width = 99
      Height = 19
      Caption = 'Invoice Date :'
    end
    object Label5: TLabel
      Left = 3
      Top = 138
      Width = 107
      Height = 19
      Caption = 'Invoive Value :'
    end
    object CheckBox1: TCheckBox
      Left = 251
      Top = 140
      Width = 59
      Height = 17
      Caption = 'Paid'
      TabOrder = 0
    end
    object FloatEdit1: TFloatEdit
      Left = 124
      Top = 135
      Width = 121
      Height = 27
      Alignment = taCenter
      TabOrder = 1
    end
    object Edit2: TEdit
      Left = 124
      Top = 69
      Width = 121
      Height = 27
      TabOrder = 2
    end
    object Edit1: TEdit
      Left = 124
      Top = 36
      Width = 121
      Height = 27
      TabOrder = 3
      OnKeyPress = Edit1KeyPress
    end
    object DateTimePicker1: TDateTimePicker
      Left = 124
      Top = 102
      Width = 186
      Height = 27
      Date = 42470.994986759260000000
      Time = 42470.994986759260000000
      TabOrder = 4
    end
    object ComboBox1: TComboBox
      Left = 124
      Top = 3
      Width = 320
      Height = 27
      Style = csDropDownList
      TabOrder = 5
      OnChange = ComboBox1Change
    end
    object Button1: TButton
      Left = 368
      Top = 136
      Width = 76
      Height = 25
      Caption = 'Save'
      TabOrder = 6
      OnClick = Button1Click
    end
  end
end
