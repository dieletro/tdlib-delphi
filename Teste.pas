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
  Data.DB, Vcl.OleServer, Vcl.ExtCtrls,

  //Use JSON with X-SuperObject
  XSuperJSON,
  XSuperObject;

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
  if (Pointer(FClient) = Nil) or (IntPtr(FClient) = 0) then
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
  ReturnStr, SDebug:  String;
  X, XParam, TLAuthState,TLEvent: ISuperObject;
  JsonAnsiStr: AnsiString;
begin
  {$REGION 'IMPLEMENTATION'}
  ReturnStr := client_receive(FClient, WAIT_TIMEOUT);

  TLEvent := SO(ReturnStr);

  if TLEvent <> NIl then
  Begin
    {$IFDEF DEBUG}
      SDebug := TLEvent.AsJSON;
    {$ENDIF}

    //# process authorization states
    if TLEvent.S['@type'] = 'updateAuthorizationState' then
    Begin
      TLAuthState := TLEvent.O['authorization_state'];

      //# if client is closed, we need to destroy it and create new client
      if TLAuthState.S['@type'] = 'authorizationStateClosed' then
        Exit;
    //    break;

    //  # set TDLib parameters
    //  # you MUST obtain your own api_id and api_hash at https://my.telegram.org
    //  # and use them in the setTdlibParameters call
      if TLAuthState.S['@type'] = 'authorizationStateWaitTdlibParameters' then
      Begin
        X := nil;
        X := SO;
        X.S['@type'] := 'setTdlibParameters';
        X.O['parameters'] := SO;
        XParam := X.O['parameters'];
          XParam.B['use_test_dc'] := False;
          XParam.S['database_directory'] := 'tdlib';
          XParam.S['files_directory'] := 'myfiles';
          XParam.B['use_file_database'] := True;
          XParam.B['use_chat_info_database'] := True;
          XParam.B['use_message_database'] := True;
          XParam.B['use_secret_chats'] := true;

          JsonAnsiStr := '';
          JsonAnsiStr := txtAPI_ID.Text;
          XParam.I['api_id'] := StrToInt(JsonAnsiStr);

          JsonAnsiStr := '';
          JsonAnsiStr := txtAPI_HASH.Text;
          XParam.S['api_hash'] := JsonAnsiStr;

          XParam.S['system_language_code'] := 'pt';
          XParam.S['device_model'] := 'TInjectTDLibTelegram';
          {$IFDEF WIN32}
            XParam.S['system_version'] := 'WIN32';
          {$ENDIF}
          {$IFDEF WIN64}
            XParam.S['system_version'] := 'WIN64';
          {$ENDIF}
          XParam.S['application_version'] := '1.0';
          XParam.B['enable_storage_optimizer'] := True;
          XParam.B['ignore_file_names'] := False;

          //Send Request
          ReturnStr := td_send(X.AsJSON);
      End;

      //# set an encryption key for database to let know TDLib how to open the database
      if TLAuthState.S['@type'] = 'authorizationStateWaitEncryptionKey' then
      Begin

        X := nil;
        X := SO;
        X.S['@type'] := 'checkDatabaseEncryptionKey';
        X.S['encryption_key'] := '';

        //Send Request
        ReturnStr := td_send(X.AsJSON);
      End;

      //# enter phone number to log in
      if TLAuthState.S['@type'] = 'authorizationStateWaitPhoneNumber' then
      Begin
        //Clear Variable
        JsonAnsiStr:='';

        //Convert String to AnsiString Type
        JsonAnsiStr := txtPhoneNumber.Text;

        X := nil;
        X := SO;
        X.S['@type'] := 'setAuthenticationPhoneNumber';
        X.S['phone_number'] := JsonAnsiStr;

        //Send Request
        ReturnStr := td_send(X.AsJSON);
      End;

      //# wait for authorization code
      if TLAuthState.S['@type'] = 'authorizationStateWaitCode' then
      Begin
        //Clear Variable
        JsonAnsiStr:='';

        //Convert String to AnsiString Type
        JsonAnsiStr := InputBox('User Authorization', 'Enter the authorization code', '');

        X := nil;
        X := SO;
        X.S['@type'] := 'checkAuthenticationCode';
        X.S['code'] := JsonAnsiStr;

        //Send Request
        ReturnStr := td_send(X.AsJSON);
      End;

      //# wait for first and last name for new users
      if TLAuthState.S['@type'] = 'authorizationStateWaitRegistration' then
      Begin
        X := nil;
        X := SO;
        X.S['@type'] := 'registerUser';
        X.S['first_name'] := 'Ruan Diego';
        X.S['last_name'] := 'Lacerda Menezes';

        //send request
        ReturnStr := td_send(X.AsJSON);
      End;

      //# wait for password if present
      if TLAuthState.S['@type'] = 'authorizationStateWaitPassword' then
      Begin
        //Clear Variable
        JsonAnsiStr := '';

        //Convert String to AnsiString Type
        JsonAnsiStr := InputBox('User Authentication ',' Enter the access code', '');

        X := nil;
        X := SO;
        X.S['@type'] := 'checkAuthenticationPassword';
        X.S['password'] := JsonAnsiStr;

        //Send Request
        ReturnStr := td_send(X.AsJSON);
      End;

    End;

    if TLEvent.S['@type'] = 'error' then
    Begin
      //if an error is found, stop the process
      if is_Closed = 0 then
         is_Closed := 1
      else
          is_Closed := 0;

      Showmessage('An error was found:'+ #10#13 +
                  'code : ' + TLEvent.S['code'] + #10#13 +
                  'message : '+TLEvent.S['message']);
    end;

    //# handle an incoming update or an answer to a previously sent request
    if TLEvent.AsJSON() <> '{}' then
      Result := 'RECEIVING : '+ TLEvent.AsJSON;

  End
  Else
  //# destroy client when it is closed and isn't needed anymore
  Client_destroy(FClient);
  {$ENDREGION 'IMPLEMENTATION'}
End;

procedure TForm1.btnStartClick(Sender: TObject);
begin
  if (Pointer(FClient) = Nil) or (IntPtr(FClient) = 0) then
  Begin
    Showmessage('Create a client to start the service');
  end
  Else
  Begin
    is_closed := 0;

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
 X: ISuperObject;
 JSonAnsiStr: AnsiString;
begin

  //# setting TDLib log verbosity level to 1 (errors)
  X := SO;
  X.S['@type'] := 'setLogVerbosityLevel';
  X.I['new_verbosity_level'] := 1;
  X.F['@extra'] := 1.01234;

  //Convert String to AnsiString Type
  JSonAnsiStr := X.AsJSon;

  memSend.Lines.Add('SENDING : '+JSonAnsiStr);
  memSend.Lines.Add('');

  memReceiver.Lines.Add('RECEIVING : '+td_execute(JSonAnsiStr));
  memReceiver.Lines.Add('');

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
  X, Xp: ISuperObject;
  JSOnAnsiStr: AnsiString;
begin

  X := SO;
  X.S['@type']  := 'getTextEntities';
  X.S['text']   := '@telegram /test_command https://telegram.org telegram.me';
  X.A['@extra'] := SA;
  X.A['@extra'].S[0] := '5';
  X.A['@extra'].F[1] := 7.0;

  JSOnAnsiStr := X.AsJson;

  memSend.Lines.Add('SENDING... '+JSOnAnsiStr);
  memSend.Lines.Add('');

  memReceiver.Lines.Add('RECEIVING... '+td_execute(JSOnAnsiStr));
  memReceiver.Lines.Add('');
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

procedure TForm1.btnSendClick(Sender: TObject);
var
  X: ISuperObject;
  JSonAnsiStr: AnsiString;
begin
  if is_closed = 1 then
    Showmessage('No active service to send!')
  Else
  begin
    X := SO;
    X.S['@type'] := 'getAuthorizationState';
    X.F['@extra'] := 1.01234;

    JSonAnsiStr := X.AsJSon;

    memSend.Lines.Add('SENDING : '+X.AsJSon);
    memSend.Lines.Add('');

    td_send(JSonAnsiStr);
  end;

end;

procedure TForm1.FormClose(Sender: TObject; var Action: TCloseAction);
begin
 if (Pointer(FClient) <> Nil) or (IntPtr(FClient) <> 0) then
  Begin
    client_destroy(FClient);
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

end;

procedure TForm1.btnDestroyClientClick(Sender: TObject);
begin
  if (Pointer(FClient) <> Nil) or (IntPtr(FClient) <> 0) then
  Begin
    if is_Closed = 0 then
    begin
      Showmessage('Stop the service first');
      exit;
    end;

    client_session.Name := '';
    client_session.ID := 0;
    client_session.Client := 0;
    client_destroy(FClient);

    with memSend.Lines do
    Begin
      Add('Name : '+client_session.Name);
      Add('ID : '+client_session.ID.ToString);
      Add('*******Section Finished********');
    end;
  End
  Else
    Showmessage('No Client Created to Destroy!');
end;

end.
