object frInvoices: TfrInvoices
  Left = 0
  Top = 0
  Caption = 'Invoices'
  ClientHeight = 357
  ClientWidth = 567
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  FormStyle = fsMDIChild
  OldCreateOrder = False
  Visible = True
  OnClose = FormClose
  OnCreate = FormCreate
  OnResize = FormResize
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 567
    Height = 357
    ParentShowHint = False
    ShowHint = True
    TabOrder = 0
    object GroupBox1: TGroupBox
      Left = 8
      Top = 8
      Width = 553
      Height = 65
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      object Label1: TLabel
        Left = 11
        Top = 11
        Width = 75
        Height = 13
        Caption = 'Supplier Name :'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
      end
      object Label2: TLabel
        Left = 374
        Top = 11
        Width = 31
        Height = 13
        Caption = 'Label2'
      end
      object Label3: TLabel
        Left = 279
        Top = 11
        Width = 91
        Height = 13
        Caption = 'Total invoices sum:'
      end
      object ComboBox1: TComboBox
        Left = 92
        Top = 8
        Width = 181
        Height = 21
        Hint = 'Select supplier to display invoices'
        ParentCustomHint = False
        Style = csDropDownList
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        ParentShowHint = False
        ShowHint = True
        TabOrder = 0
        OnSelect = ComboBox1Select
      end
      object GroupBox3: TGroupBox
        Left = 11
        Top = 29
        Width = 262
        Height = 33
        TabOrder = 1
        object Label4: TLabel
          Left = 3
          Top = 9
          Width = 31
          Height = 13
          Caption = 'From :'
        end
        object Label5: TLabel
          Left = 136
          Top = 9
          Width = 16
          Height = 13
          Caption = 'To:'
        end
        object DateTimePicker2: TDateTimePicker
          Left = 157
          Top = 6
          Width = 97
          Height = 21
          Hint = 'Search till this date'
          Date = 42479.798562800930000000
          Time = 42479.798562800930000000
          TabOrder = 0
          OnChange = DateTimePicker2Change
        end
        object DateTimePicker1: TDateTimePicker
          Left = 33
          Top = 6
          Width = 97
          Height = 21
          Hint = 'Start search from this date'
          Date = 42479.798403912030000000
          Time = 42479.798403912030000000
          TabOrder = 1
        end
      end
      object CheckBox1: TCheckBox
        Left = 11
        Top = 21
        Width = 51
        Height = 17
        Hint = 'Invoices in certain period of time'
        Caption = 'period'
        Checked = True
        State = cbChecked
        TabOrder = 2
        OnClick = CheckBox1Click
      end
    end
    object GroupBox2: TGroupBox
      Left = 8
      Top = 79
      Width = 553
      Height = 272
      ParentCustomHint = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 1
      object DBGrid1: TDBGrid
        Left = 2
        Top = 15
        Width = 549
        Height = 255
        Align = alClient
        DataSource = DataSource1
        ParentShowHint = False
        PopupMenu = PopupMenu1
        ShowHint = True
        TabOrder = 0
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'Tahoma'
        TitleFont.Style = []
        Columns = <
          item
            Expanded = False
            FieldName = 'INVOICE_ID'
            Title.Caption = 'Serial'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'INVOICE_NO'
            Title.Caption = 'Invoice number'
            Width = 85
            Visible = True
          end
          item
            Alignment = taCenter
            Expanded = False
            FieldName = 'INVOICE_DATE'
            Title.Alignment = taCenter
            Title.Caption = 'Invoice date'
            Visible = True
          end
          item
            Alignment = taCenter
            Expanded = False
            FieldName = 'INVOICE_VALUE'
            Title.Alignment = taCenter
            Title.Caption = 'Value'
            Visible = True
          end
          item
            Alignment = taCenter
            Expanded = False
            FieldName = 'PAID'
            Title.Alignment = taCenter
            Visible = True
          end>
      end
    end
  end
  object ADOQuery1: TADOQuery
    Connection = frMain.ADOConnection1
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'select * from invoices')
    Left = 416
    Top = 80
  end
  object DataSource1: TDataSource
    DataSet = ADOQuery1
    Left = 352
    Top = 112
  end
  object PopupMenu1: TPopupMenu
    Left = 408
    Top = 136
    object Deletethisinvoice1: TMenuItem
      Caption = 'Delete this invoice'
      OnClick = Deletethisinvoice1Click
    end
  end
end
