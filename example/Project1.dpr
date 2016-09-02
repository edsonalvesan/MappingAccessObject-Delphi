program Project1;

uses
  Forms,
  Unit1 in 'Unit1.pas' {Form1},
  UDM in 'UDM.pas' {DM: TDataModule},
  ClasseCliente in 'Model\ClasseCliente.pas',
  UnitDaoCliente in 'Model\UnitDaoCliente.pas',
  UnitDao.Base in '..\source\UnitDao.Base.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TDM, DM);
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
