object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Tests for Telegram'#39's TDLib API on Delphi'
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
        Left = 58
        Top = 30
        Width = 31
        Height = 13
        Caption = 'API ID'
      end
      object Label2: TLabel
        Left = 42
        Top = 57
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
        Left = 19
        Top = 84
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
      object Label3: TLabel
        Left = 12
        Top = 111
        Width = 77
        Height = 13
        Caption = 'Chat ID to Send'
      end
      object Label8: TLabel
        Left = 12
        Top = 138
        Width = 62
        Height = 13
        Caption = 'Text to Send'
      end
      object Label9: TLabel
        Left = 559
        Top = 51
        Width = 190
        Height = 24
        Caption = 'Received Messages...'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -20
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
      end
      object btnCreate: TButton
        Left = 110
        Top = 162
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
        Top = 162
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
        Top = 162
        Width = 75
        Height = 25
        Caption = 'Send'
        TabOrder = 4
        OnClick = btnSendClick
      end
      object btnStart: TButton
        Left = 272
        Top = 162
        Width = 75
        Height = 25
        Caption = 'Start Service'
        TabOrder = 5
        OnClick = btnStartClick
      end
      object btnStop: TButton
        Left = 353
        Top = 162
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
        Top = 162
        Width = 101
        Height = 25
        Caption = 'log verbosity'
        TabOrder = 8
        OnClick = Button4Click
      end
      object txtAPI_HASH: TEdit
        Left = 95
        Top = 54
        Width = 297
        Height = 21
        PasswordChar = #248
        TabOrder = 9
        TextHint = 'API_HASH'
      end
      object txtAPI_ID: TEdit
        Left = 95
        Top = 27
        Width = 297
        Height = 21
        PasswordChar = #248
        TabOrder = 10
        TextHint = 'API_ID'
      end
      object txtPhoneNumber: TEdit
        Left = 95
        Top = 81
        Width = 297
        Height = 21
        TabOrder = 11
        TextHint = 'Phone Number to Login'
      end
      object btnDestroyClient: TButton
        Left = 110
        Top = 193
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
        ScrollBars = ssVertical
        TabOrder = 13
      end
      object memReceiver: TMemo
        Left = 559
        Top = 237
        Width = 550
        Height = 268
        ScrollBars = ssBoth
        TabOrder = 14
      end
      object btnSendMessage: TButton
        Left = 398
        Top = 133
        Width = 75
        Height = 25
        Caption = 'SendMessage'
        TabOrder = 15
        OnClick = btnSendMessageClick
      end
      object txtChatIdToSend: TEdit
        Left = 95
        Top = 108
        Width = 297
        Height = 21
        TabOrder = 16
        Text = '-1001387521713'
        TextHint = 'Chat Id to send'
      end
      object txtMsgToSend: TEdit
        Left = 95
        Top = 135
        Width = 297
        Height = 21
        TabOrder = 17
        Text = 'Hello, this is a sample message from tdlib with Delphi!!!'
        TextHint = 'Text to send'
      end
      object memReceivedMessages: TMemo
        Left = 562
        Top = 81
        Width = 550
        Height = 120
        Lines.Strings = (
          
            'You can obtain a ChatID for testing using our Group that is alre' +
            'ady filled out or send a message, after '
          
            'Starting the Service, using your smartphone to the contact you w' +
            'ish to use as a test, which will appear in '
          'this memo the ChatID and UserID')
        ScrollBars = ssVertical
        TabOrder = 18
        WantTabs = True
      end
    end
  end
end
