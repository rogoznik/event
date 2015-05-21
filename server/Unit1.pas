unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, IdBaseComponent, IdComponent,
  IdTCPConnection, IdSimpleServer, Vcl.StdCtrls, IdCustomTCPServer, IdTCPServer,
  IdContext, Vcl.Mask, Vcl.ExtCtrls;

type
  TForm1 = class(TForm)
    srv: TIdTCPServer;
    log: TMemo;
    btnStart: TButton;
    Label1: TLabel;
    srvaddr: TMaskEdit;
    Timer1: TTimer;
    Timer2: TTimer;
    Timer3: TTimer;
    procedure srvExecute(AContext: TIdContext);
    procedure btnStartClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure Timer2Timer(Sender: TObject);
    procedure Timer3Timer(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    troom: Integer;
    troomset: Integer;
    twater: Integer;
    twaterset: integer;
    system: Boolean;

  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

function getSubStr(str, separator: string): string;
var p: integer;
begin
    p:=pos(separator,str);
    getSubStr:=copy(str,1,p-1);

end;

procedure TForm1.btnStartClick(Sender: TObject);
begin
  srv.Bindings.Add.IP:=srvaddr.Text;
  srv.Bindings.Add.Port:=25500;
  srv.Active:=true;
  btnStart.Enabled:=false;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  troom:=20;
  twater:=20;
  system:=false;
end;

procedure TForm1.srvExecute(AContext: TIdContext);
var
  str,s: string;
  x,p: Integer;
  filename: string;
  flags: TReplaceFlags;
begin
  str:=AContext.Connection.Socket.ReadLn();
  if Length(str)=1 then x:= strtoint(str);
  if Length(str)>1 then begin
    s:=getSubStr(str,'|');
    p:=pos('|',str);
    x:=strtoint(s);
    delete(str,1,p);
  end;

  case x of
    1: begin

          if system=false then begin
            AContext.Connection.Socket.WriteLn('off');
            log.Lines.Clear;
            log.Lines.Add('подключение клиента | '+timetostr(now));
          end
          else begin
            AContext.Connection.Socket.WriteLn('on'+inttostr(troom)+inttostr(twater));
            log.Lines.Add('подключение клиента | '+timetostr(now));
          end;
    end;
    2: begin
          if system=false then begin
            AContext.Connection.Socket.WriteLn('on'+inttostr(troom)+inttostr(twater));
            system:=True;
            log.Lines.Add('включение системы | '+timetostr(now));
            log.Lines.Add('температура помещения '+inttostr(troom)+' градусов | '+timetostr(now));
            log.Lines.Add('температура теплоносителя '+inttostr(twater)+ ' градусов | '+timetostr(now));
          end
          else
            AContext.Connection.Socket.WriteLn('on'+inttostr(troom)+inttostr(twater));
    end;
    3: begin
          if system=false then begin
            AContext.Connection.Socket.WriteLn('off');
            log.Lines.Add('отключение клиента | '+timetostr(now));
          end
          else begin
            system:=false;
            timer1.Enabled:=false;
            timer2.Enabled:=false;
            Timer3.Enabled:=true;
            log.Lines.Add('отключение клиента | '+timetostr(now));
            log.Lines.Add('выключение системы | '+timetostr(now));
            s:=timetostr(now);
            flags:= [ rfReplaceAll, rfIgnoreCase ];
            s:=StringReplace(s,':','.',flags);
            filename:='log_'+datetostr(now)+'_'+s+'.txt';
            log.Lines.SaveToFile(filename);
            AContext.Connection.Socket.WriteLn('off');
            log.Lines.Clear;
          end;
    end;
    4: begin     //программа нагрева помещения до 23 градусов
          twaterset:=43;
          troomset:=23;
          if troom>=troomset then
            AContext.Connection.Socket.WriteLn('0');
          if troom<troomset then begin
            log.Lines.Add('нагрев помещения до 23 градусов | '+timetostr(now));
            log.Lines.Add('нагрев теплоносителя до 43 градусов | '+timetostr(now));
            timer1.Enabled:=true;
            log.Lines.Add('температура помещения '+inttostr(troom)+' градусов | '+timetostr(now));
            log.Lines.Add('температура теплоносителя '+inttostr(twater)+ ' градусов | '+timetostr(now));
            AContext.Connection.Socket.WriteLn('1');
          end;
    end;
    5: begin  //значения полученные ручным вводом данных
          twaterset:=strtoint(getSubStr(str,'|'));
          p:=pos('|',str);
          delete(str,1,p);
          troomset:=strtoint(str);
          log.Lines.Add('нагрев помещения до '+inttostr(troomset)+' градусов | '+timetostr(now));
          log.Lines.Add('нагрев теплоносителя до '+inttostr(twaterset)+ ' градусов | '+timetostr(now));
          log.Lines.Add('температура помещения '+inttostr(troom)+' градусов | '+timetostr(now));
          log.Lines.Add('температура теплоносителя '+inttostr(twater)+ ' градусов | '+timetostr(now));
          if troom>=troomset then

          if troom<troomset then begin
            timer1.Enabled:=true;
            AContext.Connection.Socket.WriteLn('1');
          end;
    end;
  end;
  AContext.Connection.Disconnect;

end;


procedure TForm1.Timer1Timer(Sender: TObject);
begin
  twater:=twater+1;
  log.Lines.Add('температура теплоносителя '+inttostr(twater)+ ' градусов | '+timetostr(now));
  if twater=twaterset then begin
    Timer1.Enabled:=false;
    Timer2.Enabled:=true;
  end;

end;

procedure TForm1.Timer2Timer(Sender: TObject);
begin
  troom:=troom+1;
  log.Lines.Add('температура помещения '+inttostr(troom)+' градусов | '+timetostr(now));
  if troom=troomset then Timer2.Enabled:=false;
  
end;

procedure TForm1.Timer3Timer(Sender: TObject);
begin
  troom:=troom-1;
  log.Lines.Add('температура помещения '+inttostr(troom)+' градусов | '+timetostr(now));
  sleep(5000);

  if troom<=20 then begin
    troom:=21;
    twater:=twater-1;
    if twater<=20 then
        Timer3.Enabled:=false;
  end;
  log.Lines.Add('температура теплоносителя '+inttostr(twater)+ ' градусов | '+timetostr(now));
end;

end.
