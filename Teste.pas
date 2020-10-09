///#
///# Copyright Ruan Diego Lacerda Menezes (diegolacerdamenezes@gmail.com) - 2020
///#
///# Distributed under the Boost Software License, Version 1.0. (See accompanying
///# file LICENSE_1_0.txt or copy at http://www.boost.org/LICENSE_1_0.txt)
///#

unit Teste;

interface

uses
  ShareMem,
{$IFDEF WIN32 or DEFINED WIN64}
  Winapi.Windows,
{$ELSE}
  Wintypes, WinProcs,
{$ENDIF}
  Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.ComCtrls,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls,
  Data.DB, Vcl.OleServer, Vcl.ExtCtrls, ShellAPI, Math,

  //Use JSON with X-SuperObject
  XSuperJSON,
  XSuperObject, Vcl.WinXCtrls, ChatControl;

type
  MyPCharType = PAnsiChar;
  MyPVoid = IntPtr;

  //Definition of the Session
  TtgSession = record
    Name: String;
    ID: Integer;
    Client : MyPVoid;
  end;

var
  //Variable that receives the dll pointer
  tdjsonDll: THandle;

const
  //DLL name associated with the test project
  {$IFDEF MSWINDOWS}
    tdjsonDllName : String =
        {$IFDEF WIN32} 'tdjson.dll' {$ENDIF}
        {$IFDEF WIN64} 'tdjson-x64.dll' {$ENDIF} {+ SharedSuffix};   //TDLib.dll
  {$ELSE}
    tdjsonDllName : String = 'libtdjson.so' {+ SharedSuffix};
  {$ENDIF}

  //Setting the Receiver Timeout
  WAIT_TIMEOUT : double = 1.0; //1 seconds

var
  // should be set to 1, when updateAuthorizationState with authorizationStateClosed is received
  is_closed : integer  = 1;

  //Client Control
  FClient : MyPVoid;

  //Control Session...
  client_session : TtgSession;

  //Used to group contacts and groups
  ContactListTreeNode, GroupListTreeNode: TTreeNode;

  //Stores the logged user data
  CurrentChatStr: String = '';
  TLOGetMe, TLOMe  : ISuperObject;
type

  //internal delegate void Callback(IntPtr ptr);
  Ttd_log_fatal_error_callback_ptr = procedure (error_message: MyPCharType);

var

  client_create: function(): MyPVoid; cdecl;
  client_destroy: procedure(handle: MyPVoid); cdecl;
  client_send: procedure(handle: MyPVoid; data : MyPCharType); cdecl;
  client_receive: function(handle: MyPVoid; t: double ): MyPCharType; cdecl;
  client_execute: function(handle: MyPVoid; data : MyPCharType): MyPCharType; cdecl;
    set_log_file_path: function(path: MyPVoid): Int32; cdecl;   //Deprecated
    set_log_max_file_size: procedure(size: Int64); cdecl;       //Deprecated
  set_log_verbosity_level: procedure(level: Int32); cdecl;
  set_log_fatal_error_callback: procedure(callback : Ttd_log_fatal_error_callback_ptr); cdecl;


type
  TForm1 = class(TForm)
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    btnCreate: TButton;
    btnCusca: TButton;
    btnExecute: TButton;
    btnInit: TButton;
    btnSend: TButton;
    btnStart: TButton;
    btnStop: TButton;
    Button3: TButton;
    Button4: TButton;
    Label1: TLabel;
    Label2: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    shStatus: TShape;
    txtAPI_HASH: TEdit;
    txtAPI_ID: TEdit;
    txtPhoneNumber: TEdit;
    lblNomeDLL: TLabel;
    btnDestroyClient: TButton;
    memSend: TMemo;
    memReceiver: TMemo;
    btnSendMessage: TButton;
    txtChatIdToSend: TEdit;
    Label3: TLabel;
    Label8: TLabel;
    txtMsgToSend: TEdit;
    Button1: TButton;
    btnCreatePrivateChat: TButton;
    Button5: TButton;
    Button2: TButton;
    TabSheet2: TTabSheet;
    Label10: TLabel;
    Button6: TButton;
    ViewCtt: TTreeView;
    txtNameToSearch: TEdit;
    Label12: TLabel;
    SearchBox1: TSearchBox;
    Button9: TButton;
    btnsearchChatMessages: TButton;
    txtMSG: TEdit;
    Button7: TButton;
    Button8: TButton;
    Button10: TButton;
    Button11: TButton;
    memChatMSG: TInjectChatControl;
    Button12: TButton;
    lblCurrentChat: TLabel;
    GroupBox1: TGroupBox;
    Button13: TButton;
    Button14: TButton;
    Button15: TButton;
    Button16: TButton;
    Button17: TButton;
    Button18: TButton;
    Button19: TButton;
    Button20: TButton;
    txtProxyID: TEdit;
    Label9: TLabel;
    txtServer: TEdit;
    Label11: TLabel;
    txtPort: TEdit;
    Label13: TLabel;
    cbType: TComboBox;
    Label14: TLabel;
    chbEnable: TCheckBox;
    procedure btnInitClick(Sender: TObject);
    procedure btnCuscaClick(Sender: TObject);
    procedure btnCreateClick(Sender: TObject);
    procedure btnStartClick(Sender: TObject);
    procedure btnStopClick(Sender: TObject);
    procedure btnExecuteClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnSendClick(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnDestroyClientClick(Sender: TObject);
    procedure btnSendMessageClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure btnCreatePrivateChatClick(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure Button9Click(Sender: TObject);
    procedure ViewCttDblClick(Sender: TObject);
    procedure SearchBox1InvokeSearch(Sender: TObject);
    procedure btnsearchChatMessagesClick(Sender: TObject);
    procedure ViewCttChange(Sender: TObject; Node: TTreeNode);
    procedure Button7Click(Sender: TObject);
    procedure Button8Click(Sender: TObject);
    procedure Button10Click(Sender: TObject);
    procedure txtMSGKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure Button11Click(Sender: TObject);
    procedure Button12Click(Sender: TObject);
    procedure Button13Click(Sender: TObject);
    procedure Button14Click(Sender: TObject);
    procedure Button15Click(Sender: TObject);
    procedure Button16Click(Sender: TObject);
    procedure Button17Click(Sender: TObject);
    procedure Button18Click(Sender: TObject);
    procedure Button19Click(Sender: TObject);
    procedure Button20Click(Sender: TObject);
  private
    function td_execute(JsonUTF8: String): String;
    function td_send(JsonUTF8: String): String;
    function td_receive: String;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

function DLLInitialize: Boolean;
var
  dllFilePath: String;
begin
  Form1.shStatus.Brush.Color := clYellow;
  Result := False;
  dllFilePath := ExtractFilePath(Application.ExeName)+tdjsonDllName;
  if tdjsonDll = 0 then
    tdjsonDll := SafeLoadLibrary(tdjsonDllName);

    if tdjsonDll <> 0 then
    begin
      @client_create := GetProcAddress(tdjsonDll, 'td_json_client_create');
      if not Assigned(client_create) then
        Exit;
      @client_destroy := GetProcAddress(tdjsonDll, 'td_json_client_destroy');
      if not Assigned(client_destroy) then
        Exit;
      @client_send := GetProcAddress(tdjsonDll, 'td_json_client_send');
      if not Assigned(client_send) then
        Exit;
      @client_receive := GetProcAddress(tdjsonDll, 'td_json_client_receive');
      if not Assigned(client_receive) then
        Exit;
      @client_execute := GetProcAddress(tdjsonDll, 'td_json_client_execute');
      if not Assigned(client_execute) then
        Exit;
          //Deprecated
          @set_log_file_path := GetProcAddress(tdjsonDll, 'td_set_log_file_path');
          if not Assigned(set_log_file_path) then
            Exit;
          //Deprecated
          @set_log_max_file_size := GetProcAddress(tdjsonDll, 'td_set_log_max_file_size');
          if not Assigned(set_log_max_file_size) then
            Exit;
      @set_log_verbosity_level := GetProcAddress(tdjsonDll, 'td_set_log_verbosity_level');
      if not Assigned(set_log_verbosity_level) then
        Exit;
      @set_log_fatal_error_callback := GetProcAddress(tdjsonDll, 'td_set_log_fatal_error_callback');
      if not Assigned(set_log_fatal_error_callback) then
        Exit;
    end;

  Result := tdjsonDll <> 0;
end;

procedure TForm1.btnInitClick(Sender: TObject);
begin
  shStatus.Brush.Color := clYellow;
  if DLLInitialize then
    shStatus.Brush.Color := clGreen
  else
    shStatus.Brush.Color := clRed;
end;

procedure TForm1.btnCuscaClick(Sender: TObject);
begin
  if FileExists(ExtractFilePath(Application.ExeName)+tdjsonDllName) then
    Showmessage('Dll Found!')
  else
    Showmessage('Dll Not Found!');
end;

procedure TForm1.btnCreateClick(Sender: TObject);
begin
  if FClient = 0 then
  Begin
    FClient := client_create;

    with client_session do
    Begin
      Client := FClient;
      ID := MyPVoid(FClient);
      Name := 'Section Desktop TDLib TInjectTelegram';
    End;

    with memSend.Lines do
    Begin
      Add('Name : '+client_session.Name);
      Add('ID : '+client_session.ID.ToString);
      Add('*******Section Initialized********');
    end;

  End
  Else
    Showmessage('There is already a Created Customer!');
end;

function TForm1.td_receive(): String;
var
  ReturnStr :  String;
  JsonAnsiStr: AnsiString;
  I: Integer;
  J, CTInt: Integer;

  XO, XOParam, TLOAuthState,
  TLOEvent, TLOUpdateMessage,
  TLOContent, TLOText, TLOChat,
  TLOUsers, TLOUser : ISuperObject;

  TLAContacts, TLAMessages: ISuperArray;
  ContactTreeNode, GroupTreeNode : TTreeNode;

begin

  {$REGION 'IMPLEMENTATION'}
  ReturnStr := client_receive(FClient, WAIT_TIMEOUT);

  TLOEvent := SO(ReturnStr);

  if TLOEvent <> NIl then
  Begin

    {$REGION 'Authorization'}
    //# process authorization states
    if TLOEvent.S['@type'] = 'updateAuthorizationState' then
    Begin
      CTInt := 0; //Test....
      TLOAuthState := TLOEvent.O['authorization_state'];

      //# if client is closed, we need to destroy it and create new client
      if TLOAuthState.S['@type'] = 'authorizationStateClosed' then
      Begin
        is_closed := 1; //Stop Service
        Exit;
      End;

    //  # set TDLib parameters
    //  # you MUST obtain your own api_id and api_hash at https://my.telegram.org
    //  # and use them in the setTdlibParameters call
      if TLOAuthState.S['@type'] = 'authorizationStateWaitTdlibParameters' then
      Begin
        XO := nil;
        XO := SO;
        XO.S['@type'] := 'setTdlibParameters';
        XO.O['parameters'] := SO;
        XOParam := XO.O['parameters'];
          XOParam.B['use_test_dc'] := False;
          XOParam.S['database_directory'] := 'tdlib';
          XOParam.S['files_directory'] := 'myfiles';
          XOParam.B['use_file_database'] := True;
          XOParam.B['use_chat_info_database'] := True;
          XOParam.B['use_message_database'] := True;
          XOParam.B['use_secret_chats'] := true;

          JsonAnsiStr := '';
          JsonAnsiStr := txtAPI_ID.Text;
          XOParam.I['api_id'] := StrToInt(JsonAnsiStr);

          JsonAnsiStr := '';
          JsonAnsiStr := txtAPI_HASH.Text;
          XOParam.S['api_hash'] := JsonAnsiStr;

          XOParam.S['system_language_code'] := 'pt';
          XOParam.S['device_model'] := 'TInjectTDLibTelegram';
          {$IFDEF WIN32}
            XOParam.S['system_version'] := 'WIN32';
          {$ENDIF}
          {$IFDEF WIN64}
            XOParam.S['system_version'] := 'WIN64';
          {$ENDIF}
          XOParam.S['application_version'] := '1.0';
          XOParam.B['enable_storage_optimizer'] := True;
          XOParam.B['ignore_file_names'] := False;

          //Send Request
          ReturnStr := td_send(XO.AsJSON);
      End;

      //# set an encryption key for database to let know TDLib how to open the database
      if TLOAuthState.S['@type'] = 'authorizationStateWaitEncryptionKey' then
      Begin

        XO := nil;
        XO := SO;
        XO.S['@type'] := 'checkDatabaseEncryptionKey';
        XO.S['encryption_key'] := '';

        //Send Request
        ReturnStr := td_send(XO.AsJSON);
      End;

      //# enter phone number to log in
      if TLOAuthState.S['@type'] = 'authorizationStateWaitPhoneNumber' then
      Begin
        //Clear Variable
        JsonAnsiStr:='';

        //Convert String to AnsiString Type
        JsonAnsiStr := txtPhoneNumber.Text;

        XO := nil;
        XO := SO;
        XO.S['@type'] := 'setAuthenticationPhoneNumber';
        XO.S['phone_number'] := JsonAnsiStr;

        //Send Request
        ReturnStr := td_send(XO.AsJSON);
      End;

      //# wait for authorization code
      if TLOAuthState.S['@type'] = 'authorizationStateWaitCode' then
      Begin
        //Clear Variable
        JsonAnsiStr:='';

        //Convert String to AnsiString Type
        JsonAnsiStr := InputBox('User Authorization', 'Enter the authorization code', '');

        XO := nil;
        XO := SO;
        XO.S['@type'] := 'checkAuthenticationCode';
        XO.S['code'] := JsonAnsiStr;

        //Send Request
        ReturnStr := td_send(XO.AsJSON);
      End;

      //# wait for first and last name for new users
      if TLOAuthState.S['@type'] = 'authorizationStateWaitRegistration' then
      Begin
        XO := nil;
        XO := SO;
        XO.S['@type'] := 'registerUser';
        XO.S['first_name'] := 'Ruan Diego';
        XO.S['last_name'] := 'Lacerda Menezes';

        //send request
        ReturnStr := td_send(XO.AsJSON);
      End;

      //# wait for password if present
      if TLOAuthState.S['@type'] = 'authorizationStateWaitPassword' then
      Begin
        //Clear Variable
        JsonAnsiStr := '';

        //Convert String to AnsiString Type
        JsonAnsiStr := InputBox('User Authentication ',' Enter the access code', '');

        XO := nil;
        XO := SO;
        XO.S['@type'] := 'checkAuthenticationPassword';
        XO.S['password'] := JsonAnsiStr;

        //Send Request
        ReturnStr := td_send(XO.AsJSON);
      End;

    End;
    {$ENDREGION 'Authorization'}

    {$REGION 'error'}
    if TLOEvent.S['@type'] = 'error' then
    Begin
      //if an error is found, stop the process
      if is_Closed = 0 then  //Restart Service
      Begin
         is_Closed := 1;
         is_Closed := 0;
      End;

      Showmessage('An error was found:'+ #10#13 +
                  'code : ' + TLOEvent.S['code'] + #10#13 +
                  'message : '+TLOEvent.S['message']);
    end;
    {$ENDREGION 'error'}

    {$REGION 'getMe'}
    if TLOAuthState <> Nil then
      if TLOAuthState.S['@type'] = 'authorizationStateReady' then
      Begin
        //{"@type":"user","id":1042366601,"first_name":"Ruan Diego","last_name":"Lacerda
        if TLOGetMe = Nil then
        Begin
          TLOGetMe := SO;
          TLOGetMe.S['@type'] := 'getMe';
          memSend.Lines.Add(td_send(TLOGetMe.Cast.ToAnsiString));
          memReceiver.Lines.Add(TLOGetMe.Cast.ToAnsiString);
        End;
      End;


    if TLOEvent.S['@type'] = 'user' then  //updateUser
    Begin
      TLOMe := TLOEvent.AsObject;
    End;

    {$ENDREGION 'getMe'}

    {$REGION 'getContacts FULL'}
    //  getContacts - Ok
    if TLOEvent.S['@type'] = 'updateUser' then  //updateUser
    Begin
      TLOUsers := Nil;
      TLOUsers := TLOEvent.O['user'];
      if TLOUsers.S['@type'] = 'user' then
      Begin
        with ViewCtt.Items do
        begin
          if TLOUsers.S['first_name'] <> '' then
          begin
            { Add the root node }
            ContactTreeNode := AddChild(ContactListTreeNode,  TLOUsers.S['first_name']+' '+TLOUsers.S['last_name']);

            { Add child nodes }
            if TLOUsers.S['username'] <> '' then
              AddChild(ContactTreeNode,'UserName : '+TLOUsers.S['username']);
            if TLOUsers.S['phone_number'] <> '' then
              AddChild(ContactTreeNode,'Phone : '+TLOUsers.S['phone_number']);
            if TLOUsers.I['id'].ToString <> '' then
              AddChild(ContactTreeNode, 'ID : '+TLOUsers.I['id'].ToString);
          end
          else
            if TLOUsers.S['username'] <> '' then
            Begin
              { Add the root node }
              ContactTreeNode := AddChild(ContactListTreeNode, 'UserName : '+TLOUsers.S['username']);

              { Add child nodes }
              if TLOUsers.S['phone_number'] <> '' then
                AddChild(ContactTreeNode,'Phone : '+TLOUsers.S['phone_number']);
              if TLOUsers.I['id'].ToString <> '' then
                AddChild(ContactTreeNode, 'ID : '+TLOUsers.I['id'].ToString);
            End
            else
              if TLOUsers.I['id'].ToString <> '' then
              Begin
                { Add the root node }
                ContactTreeNode := AddChild(ContactListTreeNode, 'ID : '+TLOUsers.I['id'].ToString);

                { Add child nodes }
                if TLOUsers.S['phone_number'] <> '' then
                  AddChild(ContactTreeNode,'Phone : '+TLOUsers.S['phone_number']);
              End;

        end;
      End;
    End;
    {$ENDREGION 'getContacts'}

    {$REGION 'searchPublicChat'}
    //Return of searchPublicChat - OK....
    if TLOEvent.S['@type'] = 'chat' then
    Begin
      TLOChat := Nil;
      TLOChat := TLOEvent.AsObject;
      with ViewCtt.Items do
      begin
        if TLOChat.S['title'] <> '' then
        Begin
          { Add the root node in group type }
          GroupTreeNode := AddChild(GroupListTreeNode,  TLOChat.S['title']);

          { Add child nodes in root node}
          if TLOChat.I['id'].ToString <> '' then
          AddChild(GroupTreeNode,'ID : '+TLOChat.I['id'].ToString);
        End
        Else
          if TLOChat.I['id'].ToString <> '' then
          Begin
            { Add the root node }
            GroupTreeNode := AddChild(GroupListTreeNode, TLOChat.I['id'].ToString);
            { Add child nodes }
            AddChild(GroupTreeNode,'ID : '+TLOChat.I['id'].ToString);
          End;
      End;
    End;
    {$ENDREGION 'searchPublicChat'}

    {$REGION 'updateNewMessage'}
    //Handling New incoming messages  //updateNewMessage - OK
    if TLOEvent.S['@type'] = 'updateNewMessage' then
    Begin
//      TLOUpdateMessage := Nil;
//      TLOContent :=  Nil;
      TLOUpdateMessage := TLOEvent.O['message'];
      TLOContent :=  TLOUpdateMessage.O['content'];

      //If it's a text message
      if TLOContent.S['@type'] = 'messageText' then
      Begin
        TLOText := TLOContent.O['text'];
        if CurrentChatStr = TLOUpdateMessage.I['chat_id'].ToString then
        Begin
          if TLOMe.I['id'].ToString = TLOUpdateMessage.I['sender_user_id'].ToString then
            memChatMSG.Say(User2, TLOUpdateMessage.I['sender_user_id'].ToString, TLOText.S['text'])
          else
            memChatMSG.Say(User1, TLOUpdateMessage.I['sender_user_id'].ToString, TLOText.S['text']);
        End;
      End;

    end;
    {$ENDREGION 'updateNewMessage'}

    {$REGION 'searchChatMessage'}
    if TLOEvent.S['@type'] = 'messages' then  //updateUser
    Begin
//      TLAMessages := Nil;
//      TLOContent  := Nil;
//      TLOText := Nil;
      for I := TLOEvent.I['total_count'] - 1 Downto 0 do
      Begin
        TLAMessages := TLOEvent.A['messages'];
        TLOContent := TLAMessages.O[I];
        TLOText := TLOContent.O['content'].O['text'];

        if TLOText.S['text'] <> '' then
        Begin
          if CurrentChatStr = TLOContent.I['chat_id'].ToString then
          Begin
            if TLOMe.I['id'].ToString = TLOContent.I['sender_user_id'].ToString then
              memChatMSG.Say(User2, TLOContent.I['sender_user_id'].ToString, TLOText.S['text'])
            else
              memChatMSG.Say(User1, TLOContent.I['sender_user_id'].ToString, TLOText.S['text']);
          End;
        End;
      End;


    End;
    {$ENDREGION 'searchChatMessage'}

    //# handle an incoming update or an answer to a previously sent request
    if TLOEvent.AsJSON() <> '{}' then
      Result := 'RECEIVING : '+ TLOEvent.AsJSON;

  End;

  XO := NIl;
  XOParam := NIl;
  TLOAuthState := NIl;
  TLOEvent := NIl;
  TLOUpdateMessage := NIl;
  TLOContent := NIl;
  TLOText := NIl;
  TLOUsers := NIl;
  TLAContacts := NIl;
  ContactTreeNode := NIl;
  {$ENDREGION 'IMPLEMENTATION'}
End;

procedure TForm1.btnStartClick(Sender: TObject);
begin
  if FClient = 0 then
  Begin
    Showmessage('Create a client to start the service');
  end
  Else
    Begin
      if is_closed = 0 then
        Showmessage('The service is active!')
      Else
        begin

          is_closed := 0; //Start Service

          TThread.CreateAnonymousThread(
          procedure
          begin
            while is_closed = 0 do
            Begin
              memReceiver.Lines.Add(td_receive);
            End
          end).Start;

          memSend.Lines.Add('Service Started!!!');

        end;
    end;
end;

procedure TForm1.btnStopClick(Sender: TObject);
begin
  if is_closed = 1 then
    Showmessage('No active service to stop!')
  Else
  begin
    is_closed := 1;
    memSend.Lines.Add('Service Paused!!!');
  end;
end;

procedure TForm1.btnSendMessageClick(Sender: TObject);
var
  XO: ISuperObject;
begin
  if is_closed = 1 then
    Showmessage('No active service to send!')
  Else
  begin
    //ChatID from the TInjectTelegram Group for you to use and test
    //-1001387521713
    XO := SO;
    XO.S['@type'] := 'sendMessage';
    XO.S['chat_id'] := txtChatIdToSend.Text;
    XO.O['input_message_content'] := SO;
    XO.O['input_message_content'].S['@type'] := 'inputMessageText';
    XO.O['input_message_content'].O['text'] := SO;
    XO.O['input_message_content'].O['text'].S['@type'] := 'formattedText';
    XO.O['input_message_content'].O['text'].S['text'] := txtMsgToSend.Text;

    memSend.Lines.Add('SENDING : '+XO.AsJSon);
    memSend.Lines.Add('');

    td_send(XO.Cast.ToAnsiString);

    XO := Nil;
  end;

end;

procedure TForm1.Button10Click(Sender: TObject);
var
  XO: ISuperObject;
begin
  if is_closed = 1 then
    Showmessage('No active service to get!')
  Else
  begin
    XO := SO;
    XO.S['@type'] := 'getChats';
    //XO.O['chat_list_'] := SO; //chatListArchive, and chatListMain
    //XO.O['chat_list_'].S['@type'] := 'chatListMain';
    XO.F['offset_order_'] := (Power(2, 63) - 1); //This is a big number
    XO.I['offset_chat_id_'] := 0;
    XO.I['limit_'] := 10; //Get 10 first messages

    memSend.Lines.Add('SENDING : '+XO.AsJSon);
    memSend.Lines.Add('');

    td_send(XO.Cast.ToAnsiString);

    XO := Nil;
  end;

end;

procedure TForm1.Button11Click(Sender: TObject);
var
  XO: ISuperObject;
begin

  if is_closed = 1  then
    Showmessage('No active service to send!')
  Else
  begin

    XO := SO;
    XO.S['@type'] := 'getMe';

    memSend.Lines.Add('SENDING : '+XO.AsJSon);
    memSend.Lines.Add('');

    memReceiver.Lines.Add(td_send(XO.Cast.ToAnsiString));
    XO := Nil;
  end;
end;

procedure TForm1.Button12Click(Sender: TObject);
var
  XO: ISuperObject;
begin
  if ViewCtt.Items.Item[ViewCtt.Selected.AbsoluteIndex].Text.Contains('ID') then
  Begin
    if is_closed = 1  then
      Showmessage('No active service to send!')
    Else
    begin
      XO := SO;
      XO.S['@type'] := 'createPrivateChat';
      XO.S['user_id'] := StringReplace(ViewCtt.Items.Item[ViewCtt.Selected.AbsoluteIndex].Text,'ID : ','',[rfReplaceAll]);
      XO.B['force'] := True;

      memSend.Lines.Add('SENDING : '+XO.Cast.ToAnsiString);
      memSend.Lines.Add('');

      memReceiver.Lines.Add(td_send(XO.Cast.ToAnsiString));

      XO := Nil;
    end;
  End
  Else
    Showmessage('Select a valid chat id!');

end;



procedure TForm1.Button13Click(Sender: TObject);
var
  XO: ISuperObject;
begin

  if is_closed = 1  then
    Showmessage('No active service to send!')
  Else
  begin

    XO := SO;
    XO.S['@type'] := 'addProxy';
    XO.S['server'] := txtServer.Text;
    XO.I['port'] := StrToInt(txtPort.Text);
    XO.B['enable'] := chbEnable.Checked;
    XO.O['type'] := SO;
    XO.O['type'].S['@type'] := cbType.Text;

    memSend.Lines.Add('SENDING : '+XO.AsJSon);
    memSend.Lines.Add('');

    memReceiver.Lines.Add(td_send(XO.Cast.ToAnsiString));
    XO := Nil;
  end;

end;

procedure TForm1.Button14Click(Sender: TObject);
var
  XO: ISuperObject;
begin

  if is_closed = 1  then
    Showmessage('No active service to send!')
  Else
  begin
    XO := SO;
    XO.S['@type'] := 'getProxies';

    memSend.Lines.Add('SENDING : '+XO.AsJSon);
    memSend.Lines.Add('');

    memReceiver.Lines.Add(td_send(XO.Cast.ToAnsiString));
    XO := Nil;
  end;
//**
end;

procedure TForm1.Button15Click(Sender: TObject);
var
  XO: ISuperObject;
begin

  if is_closed = 1  then
    Showmessage('No active service to send!')
  Else
  begin

    XO := SO;
    XO.S['@type'] := 'getProxyLink';
    XO.I['proxy_id'] := StrToInt(txtProxyID.Text);

    memSend.Lines.Add('SENDING : '+XO.AsJSon);
    memSend.Lines.Add('');

    memReceiver.Lines.Add(td_send(XO.Cast.ToAnsiString));
    XO := Nil;
  end;

end;

procedure TForm1.Button16Click(Sender: TObject);
var
  XO: ISuperObject;
begin

  if is_closed = 1  then
    Showmessage('No active service to send!')
  Else
  begin

    XO := SO;
    XO.S['@type'] := 'pingProxy';
    XO.I['proxy_id'] := StrToInt(txtProxyID.Text);

    memSend.Lines.Add('SENDING : '+XO.AsJSon);
    memSend.Lines.Add('');

    memReceiver.Lines.Add(td_send(XO.Cast.ToAnsiString));
    XO := Nil;
  end;
end;

procedure TForm1.Button17Click(Sender: TObject);
var
  XO: ISuperObject;
begin

  if is_closed = 1  then
    Showmessage('No active service to send!')
  Else
  begin

    XO := SO;
    XO.S['@type'] := 'removeProxy';
    XO.I['proxy_id'] := StrToInt(txtProxyID.Text);

    memSend.Lines.Add('SENDING : '+XO.AsJSon);
    memSend.Lines.Add('');

    memReceiver.Lines.Add(td_send(XO.Cast.ToAnsiString));
    XO := Nil;
  end;

end;

procedure TForm1.Button18Click(Sender: TObject);
var
  XO: ISuperObject;
begin

  if is_closed = 1  then
    Showmessage('No active service to send!')
  Else
  begin
    XO := SO;
    XO.S['@type'] := 'disableProxy';

    memSend.Lines.Add('SENDING : '+XO.AsJSon);
    memSend.Lines.Add('');

    memReceiver.Lines.Add(td_send(XO.Cast.ToAnsiString));
    XO := Nil;
  end;

end;

procedure TForm1.Button19Click(Sender: TObject);
var
  XO: ISuperObject;
begin

  if is_closed = 1  then
    Showmessage('No active service to send!')
  Else
  begin

    XO := SO;
    XO.S['@type'] := 'enableProxy';
    XO.I['proxy_id'] := StrToInt(txtProxyID.Text);

    memSend.Lines.Add('SENDING : '+XO.AsJSon);
    memSend.Lines.Add('');

    memReceiver.Lines.Add(td_send(XO.Cast.ToAnsiString));
    XO := Nil;
  end;
end;

procedure TForm1.Button1Click(Sender: TObject);
var
  XO: ISuperObject;
begin

  if is_closed = 1  then
    Showmessage('No active service to send!')
  Else
  begin

    XO := SO;
    XO.S['@type'] := 'getChat';
    XO.S['chat_id'] := txtChatIdToSend.text;

    memSend.Lines.Add('SENDING : '+XO.AsJSon);
    memSend.Lines.Add('');

    memReceiver.Lines.Add(td_send(XO.Cast.ToAnsiString));
    XO := Nil;
  end;

end;

procedure TForm1.Button20Click(Sender: TObject);
var
  XO: ISuperObject;
begin

  if is_closed = 1  then
    Showmessage('No active service to send!')
  Else
  begin

    XO := SO;
    XO.S['@type'] := 'editProxy';
    XO.S['server'] := txtServer.Text;
    XO.I['port'] := StrToInt(txtPort.Text);
    XO.B['enable'] := chbEnable.Checked;
    XO.O['type'] := SO;
    XO.O['type'].S['@type'] := cbType.Text;

    memSend.Lines.Add('SENDING : '+XO.AsJSon);
    memSend.Lines.Add('');

    memReceiver.Lines.Add(td_send(XO.Cast.ToAnsiString));
    XO := Nil;
  end;

end;

procedure TForm1.Button2Click(Sender: TObject);
var
  XO: ISuperObject;
begin

  if is_closed = 1  then
    Showmessage('No active service to send!')
  Else
  begin

    XO := SO;
    XO.S['@type'] := 'searchPublicChat';
    XO.S['username'] := txtNameToSearch.text;

    memSend.Lines.Add('SENDING  : '+XO.Cast.ToAnsiString);

    memReceiver.Lines.Add(td_send(XO.Cast.ToAnsiString));

    XO := Nil;
  end;


end;

procedure TForm1.btnCreatePrivateChatClick(Sender: TObject);
var
  XO: ISuperObject;
begin

  if is_closed = 1  then
    Showmessage('No active service to send!')
  Else
  begin
    XO := SO;
    XO.S['@type'] := 'createPrivateChat';
    XO.S['user_id'] := txtChatIdToSend.text;
    XO.B['force'] := True;

    memSend.Lines.Add('SENDING : '+XO.Cast.ToAnsiString);
    memSend.Lines.Add('');

    memReceiver.Lines.Add(td_send(XO.Cast.ToAnsiString));

    XO := Nil;
  end;

end;

procedure TForm1.Button3Click(Sender: TObject);
begin
  FreeLibrary(tdjsonDll);
  tdjsonDll := 0;

  if tdjsonDll <> 0 then
    shStatus.Brush.Color := clGreen
  else
    shStatus.Brush.Color := clRed;
end;

procedure TForm1.Button4Click(Sender: TObject);
var
 XO: ISuperObject;
begin

  //# setting TDLib log verbosity level to 1 (errors)
  XO := SO;
  XO.S['@type'] := 'setLogVerbosityLevel';
  XO.I['new_verbosity_level'] := 1;
  XO.F['@extra'] := 1.01234;

  memSend.Lines.Add('SENDING : '+XO.Cast.ToAnsiString);
  memSend.Lines.Add('');

  memReceiver.Lines.Add('RECEIVING : '+td_execute(XO.Cast.ToAnsiString));
  memReceiver.Lines.Add('');
  XO := NIl;
end;

procedure TForm1.Button5Click(Sender: TObject);
var
  XO: ISuperObject;
begin
  if is_closed = 1  then
    Showmessage('No active service to send!')
  Else
  begin
    XO := SO;
    XO.S['@type'] := 'openChat';
    XO.S['user_id'] := txtChatIdToSend.text;

    memSend.Lines.Add('SENDING : '+XO.AsJSon);
    memSend.Lines.Add('');

    memReceiver.Lines.Add(td_send(XO.Cast.ToAnsiString));
    XO := NIl;
  end;

end;

procedure TForm1.Button6Click(Sender: TObject);
var
  XO: ISuperObject;
begin

  if is_closed = 1  then
    Showmessage('No active service to get!')
  Else
  begin
    XO := SO;
    XO.S['@type'] := 'getContacts';

    memSend.Lines.Add('SENDING  : '+XO.Cast.ToAnsiString);
    memReceiver.Lines.Add(td_send(XO.Cast.ToAnsiString));

    XO := NIl;
  end;

end;

procedure TForm1.Button7Click(Sender: TObject);
Var
  XO: ISuperObject;
begin
  XO := SO;
  XO.S['@type'] := 'searchChatsOnServer';
  XO.S['&query_'] := txtNameToSearch.Text;
  XO.I['limit_'] := 100;

  memSend.Lines.Add(td_send(XO.Cast.ToAnsiString));

  XO := NIl;
end;

procedure TForm1.Button8Click(Sender: TObject);
Var
  XO: ISuperObject;
begin
  //#Beta version in test...
  if ViewCtt.Items.Item[ViewCtt.Selected.AbsoluteIndex].Text.Contains('ID') then
  Begin
    XO := SO;
    XO.S['@type'] := 'createCall';
    XO.I['user_id'] := StrToInt64(StringReplace(ViewCtt.Items.Item[ViewCtt.Selected.AbsoluteIndex].Text,'ID : ','',[rfReplaceAll]));
    XO.O['protocol'] := SO;
    XO.O['protocol'].B['udp_p2p'] := True;
    XO.O['protocol'].B['udp_reflector'] := True;
    XO.O['protocol'].I['min_layer'] := 65;
    XO.O['protocol'].I['max_layer'] := 65;

    memSend.Lines.Add(td_send(XO.Cast.ToAnsiString));

    XO := NIl;
  End
  Else
    Showmessage('Select a valid chat id!');
end;

procedure TForm1.btnsearchChatMessagesClick(Sender: TObject);
Var
  XO: ISuperObject;
begin
  if ViewCtt.Items.Item[ViewCtt.Selected.AbsoluteIndex].Text.Contains('ID') then
  Begin
    memChatMSG.Strings.Clear;
    XO := SO;
    XO.S['@type'] := 'searchChatMessages';
    XO.S['chat_id'] := StringReplace(ViewCtt.Items.Item[ViewCtt.Selected.AbsoluteIndex].Text,'ID : ','',[rfReplaceAll]);
    XO.S['query'] := '';
    XO.I['sender_user'] := 0;
    XO.I['from_message_id'] := 0;
    XO.I['limit'] := 100;
    XO.I['offset'] := 0;
    XO.O['filter'] := SO;
    XO.O['filter'].S['@type'] := 'searchMessagesFilterEmpty';
    memSend.Lines.Add(td_send(XO.Cast.ToAnsiString));
    XO := NIl;
  End
  Else
    Showmessage('Select a valid chat id!');

end;

procedure TForm1.Button9Click(Sender: TObject);
Var
  XO: ISuperObject;
begin
  XO := SO;
  XO.S['@type'] := 'getUser';
  XO.S['user_id_'] := txtChatIdToSend.Text;
  memSend.Lines.Add(td_send(XO.Cast.ToAnsiString));
  XO := NIl;
end;

function TForm1.td_execute(JsonUTF8: String): String;
var
  JSonAnsiStr: AnsiString;
begin
  JSonAnsiStr := JsonUTF8;
  Result := client_execute(0, MyPCharType(JSonAnsiStr));
End;

procedure TForm1.btnExecuteClick(Sender: TObject);
var
  XO : ISuperObject;
begin

  XO := SO;
  XO.S['@type']  := 'getTextEntities';
  XO.S['text']   := '@telegram /test_command https://telegram.org telegram.me';
  XO.A['@extra'] := SA;
  XO.A['@extra'].S[0] := '5';
  XO.A['@extra'].F[1] := 7.0;

  memSend.Lines.Add('SENDING... '+XO.Cast.ToAnsiString);
  memSend.Lines.Add('');

  memReceiver.Lines.Add('RECEIVING... '+td_execute(XO.Cast.ToAnsiString));
  memReceiver.Lines.Add('');
  XO := Nil;
end;

function TForm1.td_send(JsonUTF8: String): String;
var
  X: ISuperObject;
  JsonAnsiStr: AnsiString;
begin
  JsonAnsiStr := JsonUTF8;
  client_send(FClient, MyPCharType(JsonAnsiStr));
  Result := JsonAnsiStr;
end;

procedure TForm1.txtMSGKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
  XO: ISuperObject;
begin
  if Key = VK_RETURN then
    if ViewCtt.Items.Item[ViewCtt.Selected.AbsoluteIndex].Text.Contains('ID') then
    Begin
      if is_closed = 1 then
        Showmessage('No active service to send!')
      Else
      begin
        XO := SO;
        XO.S['@type'] := 'sendMessage';
        XO.S['chat_id'] := StringReplace(ViewCtt.Items.Item[ViewCtt.Selected.AbsoluteIndex].Text,'ID : ','',[rfReplaceAll]);;
        XO.O['input_message_content'] := SO;
        XO.O['input_message_content'].S['@type'] := 'inputMessageText';
        XO.O['input_message_content'].O['text'] := SO;
        XO.O['input_message_content'].O['text'].S['@type'] := 'formattedText';
        XO.O['input_message_content'].O['text'].S['text'] := txtMsg.Text;

        memSend.Lines.Add('SENDING : '+XO.AsJSon);
        memSend.Lines.Add('');

        td_send(XO.Cast.ToAnsiString);

        XO := Nil;
        txtMsg.Text := '';
      end;

      Key := Ord(#0);
    End
    Else
      Showmessage('Select a valid id!');

end;

procedure TForm1.ViewCttChange(Sender: TObject; Node: TTreeNode);
Var
  XO: ISuperObject;
begin
  if ViewCtt.Items.Item[ViewCtt.Selected.AbsoluteIndex].Text.Contains('ID : ') then
  Begin
    memChatMSG.Strings.Clear;
    XO := SO;
    XO.S['@type'] := 'searchChatMessages';
    CurrentChatStr := StringReplace(ViewCtt.Items.Item[ViewCtt.Selected.AbsoluteIndex].Text,'ID : ','',[rfReplaceAll]);
    lblCurrentChat.Caption :=  'Current Chat : '+CurrentChatStr;
    XO.S['chat_id'] := StringReplace(ViewCtt.Items.Item[ViewCtt.Selected.AbsoluteIndex].Text,'ID : ','',[rfReplaceAll]);
    XO.S['query'] := '';
    XO.I['sender_user'] := 0;
    XO.I['from_message_id'] := 0;
    XO.I['limit'] := 30;
    XO.I['offset'] := 0;
    XO.O['filter'] := SO;
    XO.O['filter'].S['@type'] := 'searchMessagesFilterEmpty';
    memSend.Lines.Add(td_send(XO.Cast.ToAnsiString));
    XO := NIl;
  End;
end;

procedure TForm1.ViewCttDblClick(Sender: TObject);
begin

  if ViewCtt.Items.Item[ViewCtt.Selected.AbsoluteIndex].Text.Contains('ID') then
  Begin
    PageControl1.TabIndex := 0;
    txtChatIdToSend.Text := StringReplace(ViewCtt.Items.Item[ViewCtt.Selected.AbsoluteIndex].Text,'ID : ','',[rfReplaceAll]);
  End;

  if (ViewCtt.Items.Item[ViewCtt.Selected.AbsoluteIndex].Text.Contains('UserName')) and
  (Length(ViewCtt.Items.Item[ViewCtt.Selected.AbsoluteIndex].Text) > 10) then
  Begin
    PageControl1.TabIndex := 0;
    txtNameToSearch.Text := StringReplace(ViewCtt.Items.Item[ViewCtt.Selected.AbsoluteIndex].Text,'UserName : ','',[rfReplaceAll]);
  End;
end;

procedure TForm1.btnSendClick(Sender: TObject);
var
  XO: ISuperObject;
begin
  if is_closed = 1 then
    Showmessage('No active service to send!')
  Else
  begin
    XO := SO;
    XO.S['@type'] := 'getAuthorizationState';
    XO.F['@extra'] := 1.01234;

    memSend.Lines.Add('SENDING : '+XO.AsJSon);
    memSend.Lines.Add('');

    td_send(XO.Cast.ToAnsiString);
    XO := Nil;
  end;

end;

procedure TForm1.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if FClient <> 0 then
  Begin
    if is_Closed = 0 then
    begin
      is_closed := 1; //Now the Service is Closed
    end;

    client_session.Name := '';
    client_session.ID := 0;
    client_session.Client := 0;
    client_destroy(FClient);
    FClient := 0;

    TLOMe := Nil;
    TLOGetMe := Nil;
  End;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin

  shStatus.Brush.Color := clGreen;
  if DLLInitialize then
    shStatus.Brush.Color := clGreen
  else
    shStatus.Brush.Color := clRed;

  lblNomeDLL.Caption := tdjsonDllName;

  with ViewCtt.Items do
  begin
    if GroupListTreeNode = Nil then
      GroupListTreeNode := Add(nil,  'Group List');

    if ContactListTreeNode = Nil then
      ContactListTreeNode := Add(nil,  'Contacts List');
  end;
end;

procedure TForm1.SearchBox1InvokeSearch(Sender: TObject);
var i:integer;
begin
  {Browsing the Items}
  for i:=0 to ViewCtt.Items.Count-1 do
    if (ViewCtt.Items.Item[i].Text.Contains(SearchBox1.Text)) then
    begin
       // Expanding the desired Node. The False parameter does not
       // enable recursion (it will not expand whoever is
       // within the Node located) and True enables recursion,
       // that way it expands what you've located and all the others
       // internal nodes to it (obviously only those with children)}}
      ViewCtt.Items.Item[i].Expand(False);
    end;

end;

procedure TForm1.btnDestroyClientClick(Sender: TObject);
begin
  if FClient <> 0 then
  Begin
    if is_Closed = 0 then
    begin
      is_closed := 1; //Now the Service is Closed
    end;

    client_session.Name := '';
    client_session.ID := 0;
    client_session.Client := 0;
    client_destroy(FClient);
    FClient := 0;

    with memSend.Lines do
    Begin
      Add('Name : '+client_session.Name);
      Add('ID : '+client_session.ID.ToString);
      Add('Client : '+client_session.Client.ToString);
      Add('*******Section Finished********');
    end;
  End
  Else
    Showmessage('No Client Created to Destroy!');
end;

end.
