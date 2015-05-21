object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Form1'
  ClientHeight = 427
  ClientWidth = 378
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 72
    Top = 8
    Width = 124
    Height = 19
    Caption = #1040#1076#1088#1077#1089' '#1089#1077#1088#1074#1077#1088#1072
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object log: TMemo
    Left = 8
    Top = 205
    Width = 344
    Height = 201
    ReadOnly = True
    ScrollBars = ssVertical
    TabOrder = 0
  end
  object Button1: TButton
    Left = 216
    Top = 41
    Width = 136
    Height = 33
    Caption = #1055#1086#1076#1082#1083#1102#1095#1080#1090#1100#1089#1103
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 1
    OnClick = Button1Click
  end
  object srvaddr: TMaskEdit
    Left = 216
    Top = 8
    Width = 136
    Height = 27
    EditMask = '000\.000\.000\.000;1;_'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Tahoma'
    Font.Style = []
    MaxLength = 15
    ParentFont = False
    TabOrder = 2
    Text = '192.168.001.041'
  end
  object Button2: TButton
    Left = 8
    Top = 78
    Width = 344
    Height = 36
    Caption = #1042#1082#1083#1102#1095#1080#1090#1100' '#1089#1080#1089#1090#1077#1084#1091
    Enabled = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 3
    OnClick = Button2Click
  end
  object Button3: TButton
    Left = 8
    Top = 78
    Width = 344
    Height = 36
    Caption = #1042#1099#1082#1083#1102#1095#1080#1090#1100' '#1089#1080#1089#1090#1077#1084#1091
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 4
    Visible = False
    OnClick = Button3Click
  end
  object RadioButton1: TRadioButton
    Left = 8
    Top = 128
    Width = 188
    Height = 25
    Caption = #1042#1089#1090#1088#1086#1077#1085#1085#1072#1103' '#1087#1088#1086#1075#1088#1072#1084#1084#1072
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 5
    Visible = False
    OnClick = RadioButton1Click
  end
  object RadioButton2: TRadioButton
    Left = 8
    Top = 168
    Width = 113
    Height = 17
    Caption = #1056#1091#1095#1085#1086#1081' '#1074#1074#1086#1076
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 6
    Visible = False
    OnClick = RadioButton2Click
  end
  object Edit1: TEdit
    Left = 136
    Top = 163
    Width = 41
    Height = 27
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Tahoma'
    Font.Style = []
    MaxLength = 2
    ParentFont = False
    TabOrder = 7
    Visible = False
  end
  object Button4: TButton
    Left = 202
    Top = 120
    Width = 150
    Height = 79
    Caption = #1047#1072#1087#1091#1089#1082
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 8
    Visible = False
    OnClick = Button4Click
  end
  object client: TIdTCPClient
    ConnectTimeout = 0
    IPVersion = Id_IPv4
    Port = 25500
    ReadTimeout = -1
    Left = 16
    Top = 8
  end
end
