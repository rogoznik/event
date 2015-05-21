object Form1: TForm1
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = #1057#1077#1088#1074#1077#1088' '#1089#1080#1089#1090#1077#1084#1099' '#1086#1090#1086#1087#1083#1077#1085#1080#1103
  ClientHeight = 358
  ClientWidth = 381
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 80
    Top = 17
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
    Top = 104
    Width = 335
    Height = 225
    ScrollBars = ssVertical
    TabOrder = 0
  end
  object btnStart: TButton
    Left = 215
    Top = 56
    Width = 136
    Height = 33
    Caption = #1057#1090#1072#1088#1090' '#1089#1077#1088#1074#1077#1088#1072
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 1
    OnClick = btnStartClick
  end
  object srvaddr: TMaskEdit
    Left = 215
    Top = 14
    Width = 136
    Height = 27
    EditMask = '000\.000\.000\.000;1;'
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
  object srv: TIdTCPServer
    Bindings = <
      item
        IP = '192.168.1.41'
        Port = 25500
      end>
    DefaultPort = 0
    OnExecute = srvExecute
    Left = 16
    Top = 8
  end
  object Timer1: TTimer
    Enabled = False
    OnTimer = Timer1Timer
    Left = 16
    Top = 56
  end
  object Timer2: TTimer
    Enabled = False
    Interval = 2500
    OnTimer = Timer2Timer
    Left = 56
    Top = 56
  end
  object Timer3: TTimer
    Enabled = False
    Interval = 5000
    OnTimer = Timer3Timer
    Left = 96
    Top = 56
  end
end
