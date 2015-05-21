unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, IdBaseComponent,
  IdComponent, IdTCPConnection, IdTCPClient, Vcl.Mask, Vcl.ExtCtrls;

type
  TForm1 = class(TForm)
    client: TIdTCPClient;
    log: TMemo;
    Button1: TButton;
    Label1: TLabel;
    srvaddr: TMaskEdit;
    Button2: TButton;
    Button3: TButton;
    RadioButton1: TRadioButton;
    RadioButton2: TRadioButton;
    Edit1: TEdit;
    Button4: TButton;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure RadioButton1Click(Sender: TObject);
    procedure RadioButton2Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    troom: integer;
    str: string;
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
begin
  client.Host:=srvaddr.Text;
  client.Connect;
  client.Socket.WriteLn('1');
  str:=client.Socket.ReadLn();
  if length(str)=3 then begin
    log.Lines.Add('Система выключена');
    Button2.Enabled:=true;
  end;
  if length(str)>3 then begin
    log.Lines.Add('Система включена');
    log.Lines.Add('Температура комнаты '+ copy(str,3,2)+' градусов');
    log.Lines.Add('Температура теплоносителя '+ copy(str,5,2)+' градусов');
    Button2.Visible:=false;
    Button3.Visible:=true;
    Button4.Visible:=true;
    RadioButton1.Visible:=true;
    RadioButton2.Visible:=true;
    troom:=strtoint(copy(str,3,2));
  end;

  client.Disconnect;

  Button1.Enabled:=false;
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  client.Host:=srvaddr.Text;
  client.Connect;
  client.Socket.WriteLn('2');
  str:=client.Socket.ReadLn();
  log.Lines.Add('Система включена');
  log.Lines.Add('Температура комнаты '+ copy(str,3,2)+' градусов');
  log.Lines.Add('Температура теплоносителя '+ copy(str,5,2)+' градусов');
  troom:=strtoint(copy(str,3,2));
  client.Disconnect;
  Button2.Visible:=false;
  Button3.Visible:=true;
  Button4.Visible:=true;
  RadioButton1.Visible:=true;
  RadioButton2.Visible:=true;

end;

procedure TForm1.Button3Click(Sender: TObject);
begin
  client.Host:=srvaddr.Text;
  client.Connect;
  client.Socket.WriteLn('3');
  str:=client.Socket.ReadLn();
  log.Lines.Add('Система выключена');
  log.Lines.Clear;
  Button1.Enabled:=true;
  Button2.Visible:=true;
  Button3.Visible:=false;
  Button4.Visible:=false;
  RadioButton1.Visible:=false;
  RadioButton2.Visible:=false;
  client.Disconnect;
end;

procedure TForm1.Button4Click(Sender: TObject);
begin
if RadioButton1.Checked then begin
    client.Host:=srvaddr.Text;
    client.Connect;
    client.Socket.WriteLn('4');
    str:=client.Socket.ReadLn();
    log.Lines.Add('Программа запущена');
    client.Disconnect;
    while troom<23 do begin
      client.Host:=srvaddr.Text;
      client.Connect;
      client.Socket.WriteLn('2');
      str:=client.Socket.ReadLn();
      log.Lines.Add('Температура комнаты '+ copy(str,3,2)+' градусов');
      log.Lines.Add('Температура теплоносителя '+ copy(str,5,2)+' градусов');
      troom:=strtoint(copy(str,3,2));
      client.Disconnect;
      sleep(1000);
    end;

  end;
  if RadioButton2.Checked then begin
    client.Host:=srvaddr.Text;
    client.Connect;
    client.Socket.WriteLn('5|'+inttostr(strtoint(Edit1.Text)+20)+'|'+Edit1.Text+'|');
    str:=client.Socket.ReadLn();
    log.Lines.Add('Программа запущена');
    client.Disconnect;
    while troom<strtoint(Edit1.Text) do begin
      client.Host:=srvaddr.Text;
      client.Connect;
      client.Socket.WriteLn('2');
      str:=client.Socket.ReadLn();
      log.Lines.Add('Температура комнаты '+ copy(str,3,2)+' градусов');
      log.Lines.Add('Температура теплоносителя '+ copy(str,5,2)+' градусов');
      troom:=strtoint(copy(str,3,2));
      client.Disconnect;
      sleep(1000);
    end;
  end;
  
end;

procedure TForm1.RadioButton1Click(Sender: TObject);
begin
  Edit1.Visible:=false;
end;

procedure TForm1.RadioButton2Click(Sender: TObject);
begin
  Edit1.Visible:=true;
end;

end.
