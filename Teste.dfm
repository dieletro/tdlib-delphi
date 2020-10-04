object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Tests for TDLib API from Telegram'
  ClientHeight = 548
  ClientWidth = 1123
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object PageControl1: TPageControl
    Left = 0
    Top = 0
    Width = 1123
    Height = 548
    ActivePage = TabSheet1
    Align = alClient
    TabOrder = 0
    object TabSheet1: TTabSheet
      Caption = 'Actions'
      ExplicitLeft = 0
      ExplicitTop = 28
      object Label1: TLabel
        Left = 42
        Top = 38
        Width = 31
        Height = 13
        Caption = 'API ID'
      end
      object Label2: TLabel
        Left = 26
        Top = 65
        Width = 47
        Height = 13
        Caption = 'API HASH'
      end
      object Label4: TLabel
        Left = 235
        Top = 3
        Width = 31
        Height = 13
        Caption = 'Status'
      end
      object Label5: TLabel
        Left = 8
        Top = 207
        Width = 62
        Height = 24
        Caption = 'Send...'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -20
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
      end
      object Label6: TLabel
        Left = 559
        Top = 207
        Width = 94
        Height = 24
        Caption = 'Receiver...'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -20
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
      end
      object Label7: TLabel
        Left = 3
        Top = 92
        Width = 70
        Height = 13
        Caption = 'Phone Number'
      end
      object shStatus: TShape
        Left = 270
        Top = 4
        Width = 14
        Height = 13
        Brush.Color = clYellow
        Pen.Style = psClear
        Pen.Width = 0
        Shape = stCircle
      end
      object lblNomeDLL: TLabel
        Left = 288
        Top = 3
        Width = 17
        Height = 13
        Caption = 'DLL'
      end
      object btnCreate: TButton
        Left = 110
        Top = 153
        Width = 75
        Height = 25
        Caption = 'Create Client'
        TabOrder = 0
        OnClick = btnCreateClick
      end
      object btnCusca: TButton
        Left = 585
        Top = 8
        Width = 75
        Height = 25
        Caption = 'Find Dll'
        TabOrder = 1
        OnClick = btnCuscaClick
      end
      object btnExecute: TButton
        Left = 191
        Top = 153
        Width = 75
        Height = 25
        Caption = 'Execute'
        TabOrder = 2
        OnClick = btnExecuteClick
      end
      object btnInit: TButton
        Left = 423
        Top = 8
        Width = 75
        Height = 25
        Caption = 'Init Dll'
        TabOrder = 3
        OnClick = btnInitClick
      end
      object btnSend: TButton
        Left = 434
        Top = 153
        Width = 75
        Height = 25
        Caption = 'Send'
        TabOrder = 4
        OnClick = btnSendClick
      end
      object btnStart: TButton
        Left = 272
        Top = 153
        Width = 75
        Height = 25
        Caption = 'Start Service'
        TabOrder = 5
        OnClick = btnStartClick
      end
      object btnStop: TButton
        Left = 353
        Top = 153
        Width = 75
        Height = 25
        Caption = 'Stop Service'
        TabOrder = 6
        OnClick = btnStopClick
      end
      object Button3: TButton
        Left = 504
        Top = 8
        Width = 75
        Height = 25
        Caption = 'Stop Dll'
        TabOrder = 7
        OnClick = Button3Click
      end
      object Button4: TButton
        Left = 3
        Top = 153
        Width = 101
        Height = 25
        Caption = 'log verbosity'
        TabOrder = 8
        OnClick = Button4Click
      end
      object txtAPI_HASH: TEdit
        Left = 79
        Top = 62
        Width = 297
        Height = 21
        PasswordChar = #248
        TabOrder = 9
        TextHint = 'API_HASH'
      end
      object txtAPI_ID: TEdit
        Left = 79
        Top = 35
        Width = 297
        Height = 21
        PasswordChar = #248
        TabOrder = 10
        TextHint = 'API_ID'
      end
      object txtPhoneNumber: TEdit
        Left = 79
        Top = 89
        Width = 297
        Height = 21
        TabOrder = 11
        TextHint = 'Phone Number to Login'
      end
      object btnDestroyClient: TButton
        Left = 110
        Top = 184
        Width = 75
        Height = 25
        Caption = 'Destroy Client'
        TabOrder = 12
        OnClick = btnDestroyClientClick
      end
      object memSend: TMemo
        Left = 3
        Top = 237
        Width = 550
        Height = 268
        TabOrder = 13
      end
      object memReceiver: TMemo
        Left = 559
        Top = 237
        Width = 550
        Height = 268
        TabOrder = 14
      end
    end
  end
end
