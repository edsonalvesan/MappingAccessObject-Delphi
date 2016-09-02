//***************************************************************//
//                         Classe Cliente              //
//***************************************************************//
unit ClasseCliente;

interface
uses Classes;

type
  TCliente = class(TPersistent)

   constructor Create;
   destructor  Destroy; override;
 
private
    FLIMITE: Double;
    FCAPSOCIAL: Double;
    FID_CATEGORIA: Integer;
    FPESSOA: Integer;
    FINATIVO: Integer;
    FID_POTENCIAL: Integer;
    FID: Integer;
    FTIPO: Integer;
    FSEXO: Integer;
    FCNPJ: String;
    FCONJUGE: String;
    FEMPRESA: String;
    FNOMEFANTASIA: String;
    FCPF: String;
    FRAZAOSOCIAL: String;
    FRG: String;
    FNASCIMENTO: TDateTime;
    FATUALIZACAO: TDateTime;
    FFUNDACAO: TDateTime;
    FCADASTRO: TDateTime;
    FCONJUGENASCIMENTO: TDateTime;
    procedure setATUALIZACAO(const Value: TDateTime);
    procedure setCADASTRO(const Value: TDateTime);
    procedure setCAPSOCIAL(const Value: Double);
    procedure setCNPJ(const Value: String);
    procedure setCONJUGE(const Value: String);
    procedure setCONJUGENASCIMENTO(const Value: TDateTime);
    procedure setCPF(const Value: String);
    procedure setEMPRESA(const Value: String);
    procedure setFUNDACAO(const Value: TDateTime);
    procedure setID(const Value: Integer);
    procedure setID_CATEGORIA(const Value: Integer);
    procedure setID_POTENCIAL(const Value: Integer);
    procedure setINATIVO(const Value: Integer);
    procedure setLIMITE(const Value: Double);
    procedure setNASCIMENTO(const Value: TDateTime);
    procedure setNOMEFANTASIA(const Value: String);
    procedure setPESSOA(const Value: Integer);
    procedure setRAZAOSOCIAL(const Value: String);
    procedure setRG(const Value: String);
    procedure setSEXO(const Value: Integer);
    procedure setTIPO(const Value: Integer);


 
public
 
published
   property  ID                       :Integer   read FID                        write setID                       ;
   property  TIPO                     :Integer   read FTIPO                      write setTIPO                     ;
   property  PESSOA                   :Integer   read FPESSOA                    write setPESSOA                   ;
   property  ID_CATEGORIA             :Integer   read FID_CATEGORIA              write setID_CATEGORIA             ;
   property  ID_POTENCIAL             :Integer   read FID_POTENCIAL              write setID_POTENCIAL             ;
   property  NOMEFANTASIA             :String    read FNOMEFANTASIA              write setNOMEFANTASIA             ;
   property  RAZAOSOCIAL              :String    read FRAZAOSOCIAL               write setRAZAOSOCIAL              ;
   property  CPF                      :String    read FCPF                       write setCPF                      ;
   property  RG                       :String    read FRG                        write setRG                       ;
   property  CNPJ                     :String    read FCNPJ                      write setCNPJ                     ;
   property  FUNDACAO                 :TDateTime read FFUNDACAO                  write setFUNDACAO                 ;
   property  CAPSOCIAL                :Double    read FCAPSOCIAL                 write setCAPSOCIAL                ;
   property  NASCIMENTO               :TDateTime read FNASCIMENTO                write setNASCIMENTO               ;
   property  SEXO                     :Integer   read FSEXO                      write setSEXO                     ;
   property  EMPRESA                  :String    read FEMPRESA                   write setEMPRESA                  ;
   property  CONJUGE                  :String    read FCONJUGE                   write setCONJUGE                  ;
   property  CONJUGENASCIMENTO        :TDateTime read FCONJUGENASCIMENTO         write setCONJUGENASCIMENTO        ;
   property  CADASTRO                 :TDateTime read FCADASTRO                  write setCADASTRO                 ;
   property  ATUALIZACAO              :TDateTime read FATUALIZACAO               write setATUALIZACAO              ;
   property  LIMITE                   :Double    read FLIMITE                    write setLIMITE                   ;
   property  INATIVO                  :Integer   read FINATIVO                   write setINATIVO                  ;


end;
 

implementation

{ TCliente }



{ TCliente }

constructor TCliente.Create;
begin
end;

destructor TCliente.Destroy;
begin
  inherited;
end;

procedure TCliente.setATUALIZACAO(const Value: TDateTime);
begin
  FATUALIZACAO := Value;
end;

procedure TCliente.setCADASTRO(const Value: TDateTime);
begin
  FCADASTRO := Value;
end;

procedure TCliente.setCAPSOCIAL(const Value: Double);
begin
  FCAPSOCIAL := Value;
end;

procedure TCliente.setCNPJ(const Value: String);
begin
  FCNPJ := Value;
end;

procedure TCliente.setCONJUGE(const Value: String);
begin
  FCONJUGE := Value;
end;

procedure TCliente.setCONJUGENASCIMENTO(const Value: TDateTime);
begin
  FCONJUGENASCIMENTO := Value;
end;

procedure TCliente.setCPF(const Value: String);
begin
  FCPF := Value;
end;

procedure TCliente.setEMPRESA(const Value: String);
begin
  FEMPRESA := Value;
end;

procedure TCliente.setFUNDACAO(const Value: TDateTime);
begin
  FFUNDACAO := Value;
end;

procedure TCliente.setID(const Value: Integer);
begin
  FID := Value;
end;

procedure TCliente.setID_CATEGORIA(const Value: Integer);
begin
  FID_CATEGORIA := Value;
end;

procedure TCliente.setID_POTENCIAL(const Value: Integer);
begin
  FID_POTENCIAL := Value;
end;

procedure TCliente.setINATIVO(const Value: Integer);
begin
  FINATIVO := Value;
end;

procedure TCliente.setLIMITE(const Value: Double);
begin
  FLIMITE := Value;
end;

procedure TCliente.setNASCIMENTO(const Value: TDateTime);
begin
  FNASCIMENTO := Value;
end;

procedure TCliente.setNOMEFANTASIA(const Value: String);
begin
  FNOMEFANTASIA := Value;
end;

procedure TCliente.setPESSOA(const Value: Integer);
begin
  FPESSOA := Value;
end;

procedure TCliente.setRAZAOSOCIAL(const Value: String);
begin
  FRAZAOSOCIAL := Value;
end;

procedure TCliente.setRG(const Value: String);
begin
  FRG := Value;
end;

procedure TCliente.setSEXO(const Value: Integer);
begin
  FSEXO := Value;
end;

procedure TCliente.setTIPO(const Value: Integer);
begin
  FTIPO := Value;
end;

end.
