unit Unit1;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.StdCtrls,
  FMX.Layouts, FMX.Memo, FMX.Edit, IdBaseComponent, IdComponent,
  IdTCPConnection, IdTCPClient;

type
  TForm1 = class(TForm)
    client: TIdTCPClient;
    srvaddr: TEdit;
    log: TMemo;
    Button1: TButton;
    Label1: TLabel;
    Button2: TButton;
    Button3: TButton;
    RadioButton1: TRadioButton;
    RadioButton2: TRadioButton;
    Edit1: TEdit;
    Button4: TButton;
    procedure Button1Click(Sender: TObject);
    procedure RadioButton1Change(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure RadioButton2Change(Sender: TObject);
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

{$R *.fmx}

procedure TForm1.Button1Click(Sender: TObject);
begin
  client.Host:=srvaddr.Text;
  client.Connect;
  client.Socket.WriteLn('1');
  str:=client.Socket.ReadLn();
  if length(str)=3 then begin
    log.Lines.Add('Система выключена');
    Button2.Visible:=True;
  end;
  if length(str)>3 then begin
    log.Lines.Add('Система включена');
    log.Lines.Add('Температура комнаты '+ copy(str,3,2)+' градусов');
    log.Lines.Add('Температура теплоносителя '+ copy(str,5,2)+' градусов');
    Button2.Visible:=false;
    Button3.Visible:=false;
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
  Button2.Visible:=true;
  Button3.Visible:=false;
  Button4.Visible:=false;
  RadioButton1.Visible:=false;
  RadioButton2.Visible:=false;
  client.Disconnect;
end;

procedure TForm1.Button4Click(Sender: TObject);
begin

  if RadioButton1.IsChecked then begin
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
      //sleep(1000);
    end;

  end;

  if RadioButton2.IsChecked then begin
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
      //sleep(1000);
    end;
  end;
  client.Disconnect;
end;

procedure TForm1.RadioButton1Change(Sender: TObject);
begin
  Edit1.Visible:=false;
end;

procedure TForm1.RadioButton2Change(Sender: TObject);
begin
  Edit1.Visible:=true;
end;

end.
