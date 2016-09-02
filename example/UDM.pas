unit UDM;

interface

uses
  SysUtils, Classes, DB, IBQuery, IBDatabase, IBTable, IniFiles, Forms, Windows,
  DBClient, DateUtils, ExtCtrls;


type
  TDM = class(TDataModule)
    IBConexao: TIBDatabase;
    IBTranzacao: TIBTransaction;
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  DM: TDM;

implementation

{$R *.dfm}

procedure TDM.DataModuleCreate(Sender: TObject);
var
iniConf : TIniFile;
sCaminho, sIPServidor : String;
begin
  IBConexao.Connected := False;
 Try
    iniConf := TiniFile.Create( ExtractFilePath ( Application.ExeName) + 'Config.ini');
    sIPServidor := iniConf.ReadString('INF_BD','IP_Servidor','');
    sCaminho := iniConf.ReadString('INF_BD','Caminho','');
    IBConexao.DatabaseName := sIPServidor +':'+sCaminho;
    IBConexao.LoginPrompt := false;
    IBConexao.Connected := true; 
 except
    Application.MessageBox( 'Não foi possivel se conectar com o banco de dados.',
                                'Error Interno', MB_OK + mb_IconError );
        Application.Terminate;
 end;
end;

end.
