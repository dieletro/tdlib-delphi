object Form1: TForm1
  Left = 146
  Top = 0
  Caption = 'Tests for Telegram'#39's TDLib API on Delphi'
  ClientHeight = 513
  ClientWidth = 1123
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesigned
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object PageControl1: TPageControl
    Left = 0
    Top = 0
    Width = 1123
    Height = 513
    ActivePage = TabSheet1
    Align = alClient
    TabOrder = 0
    ExplicitHeight = 661
    object TabSheet1: TTabSheet
      Caption = 'Actions'
      ExplicitHeight = 633
      object Label1: TLabel
        Left = 3
        Top = 30
        Width = 31
        Height = 13
        Caption = 'API ID'
      end
      object Label2: TLabel
        Left = 130
        Top = 30
        Width = 47
        Height = 13
        Caption = 'API HASH'
      end
      object Label4: TLabel
        Left = 3
        Top = 3
        Width = 31
        Height = 13
        Caption = 'Status'
      end
      object Label5: TLabel
        Left = 8
        Top = 190
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
        Top = 190
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
        Top = 57
        Width = 70
        Height = 13
        Caption = 'Phone Number'
      end
      object shStatus: TShape
        Left = 38
        Top = 4
        Width = 14
        Height = 13
        Brush.Color = clYellow
        Pen.Style = psClear
        Pen.Width = 0
        Shape = stCircle
      end
      object lblNomeDLL: TLabel
        Left = 56
        Top = 3
        Width = 17
        Height = 13
        Caption = 'DLL'
      end
      object Label3: TLabel
        Left = 207
        Top = 57
        Width = 77
        Height = 13
        Caption = 'Chat ID to Send'
      end
      object Label8: TLabel
        Left = 3
        Top = 84
        Width = 62
        Height = 13
        Caption = 'Text to Send'
      end
      object Label12: TLabel
        Left = 114
        Top = 175
        Width = 170
        Height = 13
        Caption = 'UserName or GroupName to Search'
      end
      object btnCreate: TButton
        Left = 94
        Top = 108
        Width = 75
        Height = 25
        Caption = 'Create Client'
        TabOrder = 0
        OnClick = btnCreateClick
      end
      object btnCusca: TButton
        Left = 721
        Top = 3
        Width = 75
        Height = 25
        Caption = 'Find Dll'
        TabOrder = 1
        OnClick = btnCuscaClick
      end
      object btnExecute: TButton
        Left = 175
        Top = 108
        Width = 75
        Height = 25
        Caption = 'Execute'
        TabOrder = 2
        OnClick = btnExecuteClick
      end
      object btnInit: TButton
        Left = 559
        Top = 3
        Width = 75
        Height = 25
        Caption = 'Init Dll'
        TabOrder = 3
        OnClick = btnInitClick
      end
      object btnSend: TButton
        Left = 290
        Top = 139
        Width = 122
        Height = 25
        Caption = 'getAuthorizationState'
        TabOrder = 4
        OnClick = btnSendClick
      end
      object btnStart: TButton
        Left = 256
        Top = 108
        Width = 75
        Height = 25
        Caption = 'Start Service'
        TabOrder = 5
        OnClick = btnStartClick
      end
      object btnStop: TButton
        Left = 337
        Top = 108
        Width = 75
        Height = 25
        Caption = 'Stop Service'
        TabOrder = 6
        OnClick = btnStopClick
      end
      object Button3: TButton
        Left = 640
        Top = 3
        Width = 75
        Height = 25
        Caption = 'Stop Dll'
        TabOrder = 7
        OnClick = Button3Click
      end
      object Button4: TButton
        Left = 3
        Top = 108
        Width = 85
        Height = 25
        Caption = 'log verbosity'
        TabOrder = 8
        OnClick = Button4Click
      end
      object txtAPI_HASH: TEdit
        Left = 183
        Top = 27
        Width = 229
        Height = 21
        PasswordChar = #248
        TabOrder = 9
        TextHint = 'API_HASH'
      end
      object txtAPI_ID: TEdit
        Left = 42
        Top = 27
        Width = 74
        Height = 21
        PasswordChar = #248
        TabOrder = 10
        TextHint = 'API_ID'
      end
      object txtPhoneNumber: TEdit
        Left = 79
        Top = 54
        Width = 122
        Height = 21
        TabOrder = 11
        TextHint = 'Phone Number to Login'
      end
      object btnDestroyClient: TButton
        Left = 94
        Top = 139
        Width = 75
        Height = 25
        Caption = 'Destroy Client'
        TabOrder = 12
        OnClick = btnDestroyClientClick
      end
      object memSend: TMemo
        Left = 3
        Top = 220
        Width = 550
        Height = 244
        ScrollBars = ssVertical
        TabOrder = 13
      end
      object memReceiver: TMemo
        Left = 559
        Top = 220
        Width = 550
        Height = 244
        ScrollBars = ssVertical
        TabOrder = 14
      end
      object btnSendMessage: TButton
        Left = 418
        Top = 81
        Width = 120
        Height = 25
        Caption = 'SendMessage'
        TabOrder = 15
        OnClick = btnSendMessageClick
      end
      object txtChatIdToSend: TEdit
        Left = 290
        Top = 54
        Width = 122
        Height = 21
        TabOrder = 16
        Text = '-1001387521713'
        TextHint = 'Chat Idor UserID to send'
      end
      object txtMsgToSend: TEdit
        Left = 79
        Top = 81
        Width = 333
        Height = 21
        TabOrder = 17
        Text = 'Hello, this is a sample message from tdlib with Delphi!!!'
        TextHint = 'Text to send'
      end
      object Button1: TButton
        Left = 418
        Top = 110
        Width = 120
        Height = 25
        Caption = 'getChat'
        TabOrder = 18
        OnClick = Button1Click
      end
      object btnCreatePrivateChat: TButton
        Left = 418
        Top = 54
        Width = 120
        Height = 25
        Caption = 'createPrivateChat'
        TabOrder = 19
        OnClick = btnCreatePrivateChatClick
      end
      object Button5: TButton
        Left = 418
        Top = 141
        Width = 120
        Height = 25
        Caption = 'openChat'
        TabOrder = 20
        OnClick = Button5Click
      end
      object Button2: TButton
        Left = 418
        Top = 172
        Width = 120
        Height = 25
        Caption = 'searchPublicChat'
        TabOrder = 21
        OnClick = Button2Click
      end
      object txtNameToSearch: TEdit
        Left = 290
        Top = 172
        Width = 122
        Height = 21
        TabOrder = 22
        TextHint = 'username or groupname'
      end
      object Button9: TButton
        Left = 418
        Top = 27
        Width = 120
        Height = 25
        Caption = 'getUser'
        TabOrder = 23
        OnClick = Button9Click
      end
      object Button7: TButton
        Left = 418
        Top = 0
        Width = 120
        Height = 25
        Caption = 'searchChatsOnServer'
        TabOrder = 24
        OnClick = Button7Click
      end
      object GroupBox1: TGroupBox
        Left = 559
        Top = 34
        Width = 550
        Height = 159
        Caption = 'Proxy Options'
        TabOrder = 25
        object Label9: TLabel
          Left = 12
          Top = 137
          Width = 42
          Height = 13
          Caption = 'Proxy ID'
        end
        object Label11: TLabel
          Left = 185
          Top = 47
          Width = 32
          Height = 13
          Caption = 'Server'
        end
        object Label13: TLabel
          Left = 305
          Top = 47
          Width = 20
          Height = 13
          Caption = 'Port'
        end
        object Label14: TLabel
          Left = 421
          Top = 47
          Width = 24
          Height = 13
          Caption = 'Type'
        end
        object Button13: TButton
          Left = 185
          Top = 16
          Width = 86
          Height = 25
          Caption = 'AddProxy'
          ImageIndex = 2
          TabOrder = 0
          OnClick = Button13Click
        end
        object Button14: TButton
          Left = 369
          Top = 16
          Width = 86
          Height = 25
          Caption = 'GetProxies'
          TabOrder = 1
          OnClick = Button14Click
        end
        object Button15: TButton
          Left = 12
          Top = 106
          Width = 133
          Height = 25
          Caption = 'GetProxyLink'
          TabOrder = 2
          OnClick = Button15Click
        end
        object Button16: TButton
          Left = 12
          Top = 44
          Width = 133
          Height = 25
          Caption = 'PingProxy'
          TabOrder = 3
          OnClick = Button16Click
        end
        object Button17: TButton
          Left = 12
          Top = 75
          Width = 133
          Height = 25
          Caption = 'RemoveProxy'
          TabOrder = 4
          OnClick = Button17Click
        end
        object Button18: TButton
          Left = 461
          Top = 16
          Width = 86
          Height = 25
          Caption = 'DisableProxy'
          TabOrder = 5
          OnClick = Button18Click
        end
        object Button19: TButton
          Left = 12
          Top = 13
          Width = 133
          Height = 25
          Caption = 'EnableProxy'
          TabOrder = 6
          OnClick = Button19Click
        end
        object Button20: TButton
          Left = 277
          Top = 16
          Width = 86
          Height = 25
          Caption = 'EditProxy'
          TabOrder = 7
          OnClick = Button20Click
        end
        object txtProxyID: TEdit
          Left = 58
          Top = 134
          Width = 87
          Height = 21
          TabOrder = 8
          TextHint = 'Proxy ID'
        end
        object txtServer: TEdit
          Left = 185
          Top = 66
          Width = 106
          Height = 21
          TabOrder = 9
          Text = '65.52.166.119'
          TextHint = 'Proxy ID'
        end
        object txtPort: TEdit
          Left = 305
          Top = 66
          Width = 106
          Height = 21
          TabOrder = 10
          Text = '443'
          TextHint = 'Proxy ID'
        end
        object cbType: TComboBox
          Left = 417
          Top = 66
          Width = 126
          Height = 21
          ItemIndex = 0
          TabOrder = 11
          Text = 'proxyTypeHttp'
          TextHint = 'Type'
          Items.Strings = (
            'proxyTypeHttp'
            'proxyTypeMtproto'
            'proxyTypeSocks5')
        end
        object chbEnable: TCheckBox
          Left = 185
          Top = 99
          Width = 97
          Height = 17
          Caption = 'Enable'
          Checked = True
          State = cbChecked
          TabOrder = 12
        end
      end
    end
    object TabSheet2: TTabSheet
      Caption = 'Contacts'
      ImageIndex = 1
      ExplicitHeight = 633
      object Label10: TLabel
        Left = 0
        Top = 3
        Width = 62
        Height = 13
        Caption = 'Contacts List'
      end
      object lblCurrentChat: TLabel
        Left = 383
        Top = 3
        Width = 73
        Height = 13
        Caption = 'Current Chat : '
      end
      object Button6: TButton
        Left = 255
        Top = 22
        Width = 100
        Height = 25
        Caption = 'getContacts'
        TabOrder = 0
        OnClick = Button6Click
      end
      object ViewCtt: TTreeView
        Left = 0
        Top = 49
        Width = 249
        Height = 436
        Indent = 19
        SortType = stText
        TabOrder = 1
        OnChange = ViewCttChange
        OnDblClick = ViewCttDblClick
      end
      object SearchBox1: TSearchBox
        Left = 0
        Top = 22
        Width = 249
        Height = 21
        TabOrder = 2
        TextHint = 'Search your contact here'
        OnInvokeSearch = SearchBox1InvokeSearch
      end
      object btnsearchChatMessages: TButton
        Left = 255
        Top = 116
        Width = 122
        Height = 25
        Caption = 'searchChatMessages'
        TabOrder = 3
        OnClick = btnsearchChatMessagesClick
      end
      object txtMSG: TEdit
        Left = 383
        Top = 460
        Width = 729
        Height = 24
        AutoSize = False
        BorderStyle = bsNone
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 10720131
        Font.Height = -18
        Font.Name = 'Tahoma'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
        TabOrder = 4
        TextHint = 'Write a message ...'
        OnKeyDown = txtMSGKeyDown
      end
      object Button8: TButton
        Left = 255
        Top = 147
        Width = 122
        Height = 25
        Caption = 'createCall (Beta)'
        TabOrder = 5
        OnClick = Button8Click
      end
      object Button10: TButton
        Left = 255
        Top = 53
        Width = 100
        Height = 25
        Caption = 'getChats'
        TabOrder = 6
        OnClick = Button10Click
      end
      object Button11: TButton
        Left = 255
        Top = 85
        Width = 100
        Height = 25
        Caption = 'getMe'
        TabOrder = 7
        OnClick = Button11Click
      end
      object memChatMSG: TInjectChatControl
        Left = 383
        Top = 22
        Width = 729
        Height = 432
        Color = 14927224
        Color1 = clWhite
        Color2 = 16643808
        DoubleBuffered = True
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentColor = False
        ParentDoubleBuffered = False
        ParentFont = False
        TabOrder = 8
      end
      object Button12: TButton
        Left = 255
        Top = 178
        Width = 122
        Height = 25
        Caption = 'createPrivateChat'
        TabOrder = 9
        OnClick = Button12Click
      end
    end
  end
end
