unit UnitDaoCliente;

interface
 uses UnitDao.Base, ClasseCliente, TypInfo, SysUtils, Dialogs, IBQuery;

type
  TDaoCliente = class(TDaoBase)

   constructor Create;
   destructor  Destroy; override;

   private
     Query : TIBQuery;

   public
    function Insert(Classe: TCliente): Boolean;
    function Update(Classe: TCliente): Boolean;
    function Delete(Classe: TCliente): Boolean;
    function Find(ID : Integer): TCliente;
end;

const
  table = 'CLIENTE';

implementation


uses
  UDM;

{ TDaoCliente }

constructor TDaoCliente.Create;
begin
   Query := TIBQuery.Create(nil);
   Query.Database := DM.IBConexao;
end;

destructor TDaoCliente.Destroy;
begin
  FreeAndNil(Query);
  inherited;
end;


function TDaoCliente.Insert(Classe: TCliente): Boolean;
begin
 Query.SQL.Clear;
 Query.SQL.Text := CreateSQLInsert(Classe, table);
 SetParam(Query, Classe);
 Query.ExecSQL;
end;

function TDaoCliente.Update(Classe: TCliente): Boolean;
begin
 Query.SQL.Clear;
 Query.SQL.Text := CreateSQLUpdate(Classe, table);
 SetParam(Query, Classe);
 Query.ExecSQL;
end;

function TDaoCliente.Delete(Classe: TCliente): Boolean;
begin
 Query.SQL.Clear;
 Query.SQL.Text := CreateSQLDelete(table);
 Query.ParamByName('ID').AsInteger := Classe.ID;
 Query.ExecSQL;
end;

function TDaoCliente.Find(ID: Integer): TCliente;
begin
 Query.SQL.Clear;
 Query.SQL.Text := CreateSQLFind(table);
 Query.ParamByName('ID').AsInteger := ID;
 Query.Open;
end;

end.
