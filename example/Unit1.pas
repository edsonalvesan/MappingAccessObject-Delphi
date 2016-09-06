unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TForm1 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

uses
  ClasseCliente, UnitDaoCliente;

{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
var
  Cliente : TCliente;
  DaoCliente : TDaoCliente;
begin
  Cliente    := TCliente.Create;
  DaoCliente := TDaoCliente.Create;

  //Cliente.ID   := 1;
  Cliente.TIPO := 2;
  Cliente.NOMEFANTASIA := 'EDSON ALVES';
  Cliente.RAZAOSOCIAL  := 'MEIRIELLE RODRIGUES';
  Cliente.CPF          := '00000000000';
  Cliente.NASCIMENTO   := Date;
  DaoCliente.Insert(Cliente);

  FreeAndNil(Cliente);
  FreeAndNil(DaoCliente);


end;

procedure TForm1.Button2Click(Sender: TObject);
var
  Cliente : TCliente;
  DaoCliente : TDaoCliente;
begin
  Cliente    := TCliente.Create;
  DaoCliente := TDaoCliente.Create;

  Cliente.ID   := 1;
  Cliente.TIPO := 2;
  Cliente.NOMEFANTASIA := 'EDSON ALVES';
  Cliente.RAZAOSOCIAL  := 'MEIRIELLE RODRIGUES';
  Cliente.CPF          := '00000000000';
  Cliente.NASCIMENTO   := Date + 1;
  DaoCliente.Update(Cliente);

  FreeAndNil(Cliente);
  FreeAndNil(DaoCliente);


end;

procedure TForm1.Button3Click(Sender: TObject);
var
  Cliente : TCliente;
  DaoCliente : TDaoCliente;
begin
  Cliente    := TCliente.Create;
  DaoCliente := TDaoCliente.Create;

  Cliente.ID   := 2;
  DaoCliente.Delete(Cliente);

  FreeAndNil(Cliente);
  FreeAndNil(DaoCliente);


end;

end.
