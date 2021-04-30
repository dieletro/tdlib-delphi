program testando;





{$R *.dres}

uses
  Vcl.Forms,
  Teste in 'Teste.pas' {Form1},
  XSuperJSON in 'XSuperJSON.pas',
  XSuperObject in 'XSuperObject.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
