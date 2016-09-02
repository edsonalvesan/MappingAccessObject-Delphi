{******************************************************************************}
{ Projeto: Classe Para Mapeamento de Object e Criação de Interface SQL         }
{ Esta classe busca agilizar o processo de manipulação de dados (DAO/CRUD),    }
{ ou seja,  gerar inserts, updates, deletes nas tabelas de forma automática,   }
{ sem a necessidade de criarmos classes DAOs para cada tabela. Passando        }
{ apenas o objeto para classe realizar o mepeamento e montar o SQL de acordo   }
{ com as propriedades que tenham valor no Objeto                               }
{                                                                              }
{                                                                              }
{                                                                              }
{ Direitos Autorais Reservados (c) 2014 Luiz Carlos Alves                      }
{                                                                              }
{ Colaboradores nesse arquivo:                                                 }
{    Edson Alves - edson.alvesan@gmail.com                                     }
{                                                                              }
{ Você pode obter a última versão desse arquivo no repositório                 }
{ https://github.com/edsonalvesan/MappingAccessObject-Delphi                   }
{                                                                              }
{  Esta biblioteca é software livre; você pode redistribuí-la e/ou modificá-la }
{ sob os termos da Licença Pública Geral Menor do GNU conforme publicada pela  }
{ Free Software Foundation; tanto a versão 2.1 da Licença, ou (a seu critério) }
{ qualquer versão posterior.                                                   }
{                                                                              }
{ Esta biblioteca é distribuída na expectativa de que seja útil, porém, SEM   }
{ NENHUMA GARANTIA; nem mesmo a garantia implícita de COMERCIABILIDADE OU      }
{ ADEQUAÇÃO A UMA FINALIDADE ESPECÍFICA. Consulte a Licença Pública Geral Menor}
{ do GNU para mais detalhes. (Arquivo LICENÇA.TXT ou LICENSE.TXT)              }
{                                                                              }
{ Você deve ter recebido uma cópia da Licença Pública Geral Menor do GNU junto}
{ com esta biblioteca; se não, escreva para a Free Software Foundation, Inc.,  }
{ no endereço 59 Temple Street, Suite 330, Boston, MA 02111-1307 USA.          }
{ Você também pode obter uma copia da licença em:                              }
{ http://www.opensource.org/licenses/lgpl-license.php                          }
{                                                                              }
{ Edson Alves - edson.alvesan@gmail.com
{                                                                              }
{******************************************************************************}
unit UnitDao.Base;

interface

  uses Classes, TypInfo, SysUtils, Dialogs, IBQuery;


type
   TDaoBase = class
 
   constructor Create;
   destructor  Destroy; override;
 
private
  procedure SetParamValueQuery(AProp: PPropInfo; ACampo: string; AQry: TIBQuery; sValue : Variant);
  
  function ValidateString(Value: string): Boolean;
  function ValidateInteger(Value: Integer): Boolean;
  function ValidateFloat(Value: Double): Boolean;
  function ValidateDate(Value: Double): Boolean;

  function setValueParamString(Value: Variant) : string;
  function setValueParamInteger(Value: Variant) : Integer;
  function setValueParamDouble(Value: Double) : Double;
  function setValueParamDate(Value: Double) : TDateTime;


public
  procedure ListObjectProperties(AObject: TObject; AStrings: TStrings);
  procedure SetParam(AQry: TIBQuery; AObject: TObject);
  
  function CrateSQLInsert(AObject: TObject; Table:string) :string;
  function CrateSQLUpdate(AObject: TObject; Table:string) :string;
  function CreateSQLDelete(Table:string) :string;
  function CreateSQLFind(Table:string):string;



end;



implementation


{ TDaoBase }



constructor TDaoBase.Create;
begin

end;

destructor TDaoBase.Destroy;
begin
  inherited;
end;

function TDaoBase.CrateSQLInsert(AObject: TObject; Table:string): string;
var
  QuantityFildList   : Integer;
  Separador   : string;
  Filds, ASql : TStringList;
begin
    Filds := TStringList.Create;
    ASql  := TStringList.Create;
    ListObjectProperties(AObject, Filds);
  try
        ASql.Add('insert into ' + Table + '(');
        Separador := '';
        for QuantityFildList := 0 to Filds.Count-1 do
        begin
          ASql.Add(Separador + Filds[QuantityFildList]);
          Separador := ',';
        end;

        ASql.Add(')');
        ASql.Add('values(');
        Separador := '';
        for QuantityFildList := 0 to Filds.Count-1 do
        begin
          ASql.Add(Separador + ':' + Filds[QuantityFildList]);
          Separador := ',';
        end;
        ASql.Add(')');


    Result := ASql.Text;

   except
   raise Exception.Create('Erro ao gerar script SQL');
   end;
    Filds.Free;
    ASql.Free;
end;

function TDaoBase.CrateSQLUpdate(AObject: TObject; Table: string): string;
var
  QuantityFildList   : Integer;
  Separador   : string;
  Filds, ASql : TStringList;
begin
  Filds := TStringList.Create;
  ASql  := TStringList.Create;
  ListObjectProperties(AObject, Filds);
  try
        ASql.Add('update ' + Table + ' set' );
        Separador := '';
        for QuantityFildList := 0 to Filds.Count-1 do
        begin
          ASql.Add(Separador + Filds[QuantityFildList] + '=:' + Filds[QuantityFildList]);
          Separador := ',';
        end;

    ASql.Add(' where ID =:ID');

    Result := ASql.Text;

   except
   raise Exception.Create('Erro ao gerar script SQL');
   end;

  Filds.Free;
  ASql.Free;
end;

function TDaoBase.CreateSQLDelete(Table: string): string;
var
 ASql : TStringList;
begin
  ASql  := TStringList.Create;
  try
    ASql.Add('delete from  ' + Table );
    ASql.Add(' where ID =:ID');
    Result := ASql.Text;

   except
   raise Exception.Create('Erro ao gerar script SQL');
   end;

  ASql.Free;
end;

function TDaoBase.CreateSQLFind(Table: string): string;
var
 ASql : TStringList;
begin
  ASql  := TStringList.Create;
  try
    ASql.Add('select * from  ' + Table );
    ASql.Add(' where ID =:ID');
    Result := ASql.Text;

   except
       raise Exception.Create('Erro ao gerar script SQL');
   end;

  ASql.Free;
end;

procedure TDaoBase.ListObjectProperties(AObject: TObject;
  AStrings: TStrings);
var 
  QtdePropertiesObject, Size, CountQtdePropertiesObject: Integer;
  List: PPropList; 
  PropInfo: PPropInfo;
  sValue : Variant;
begin
  QtdePropertiesObject := GetPropList(AObject.ClassInfo, tkAny, nil);
  Size := QtdePropertiesObject * SizeOf(Pointer);
  GetMem(List, Size);

  try
    QtdePropertiesObject := GetPropList(AObject.ClassInfo, tkAny, List);

    for CountQtdePropertiesObject := 0 to QtdePropertiesObject - 1 do
    begin
      PropInfo := List^[CountQtdePropertiesObject];
      if not(PropInfo^.PropType^.Kind in tkMethods) then
      begin
       sValue := GetPropValue(AObject, PropInfo^.Name, True);
       case PropInfo^.PropType^.Kind of
         tkInt64, tkInteger:
         begin
          begin
           if ValidateInteger(sValue) then
            AStrings.Add(PropInfo^.Name);
          end;
         end;
         tkChar, tkString, tkLString: // Para versões superiores ao Delphi 7 acrescentar tkUString
         begin
          begin
           if ValidateString(sValue) then
           AStrings.Add(PropInfo^.Name);
          end;
         end;
         tkFloat:
         begin
          begin
           if CompareText(PropInfo^.PropType^.Name, 'TDateTime') = 0
            then
             begin
              if ValidateDate(sValue) then
              AStrings.Add(PropInfo^.Name);
             end
           else
           begin
            if ValidateFloat(sValue) then
            AStrings.Add(PropInfo^.Name);
           end;
          end;
         end;
       end;
      end;
    end;

  finally
    FreeMem(List);
  end;
end;

procedure TDaoBase.SetParam(AQry: TIBQuery; AObject: TObject);
var
 QtdePropertiesObject, Size, CountQtdePropertiesObject: Integer;
 List: PPropList;
 PropInfo: PPropInfo;
 sValue : Variant;
begin
   QtdePropertiesObject := GetPropList(AObject.ClassInfo, tkAny, nil);
  Size := QtdePropertiesObject * SizeOf(Pointer);
  GetMem(List, Size);

  try
    QtdePropertiesObject := GetPropList(AObject.ClassInfo, tkAny, List);

    for CountQtdePropertiesObject := 0 to QtdePropertiesObject - 1 do
    begin
      PropInfo := List^[CountQtdePropertiesObject];
      if not(PropInfo^.PropType^.Kind in tkMethods) then
      begin
       sValue := GetPropValue(AObject, PropInfo^.Name, True);
       case PropInfo^.PropType^.Kind of
         tkInt64, tkInteger:
         begin
          begin
           if ValidateInteger(sValue) then
           SetParamValueQuery(PropInfo,PropInfo^.Name, AQry, sValue);
          end;
         end;
         tkChar, tkString, tkLString: // Para versões superiores ao Delphi 7 acrescentar tkUString
         begin
          begin
           if ValidateString(sValue) then
           SetParamValueQuery(PropInfo,PropInfo^.Name, AQry, sValue);
          end;
         end;
         tkFloat:
         begin
          begin
           if CompareText(PropInfo^.PropType^.Name, 'TDateTime') = 0
            then
             begin
              if ValidateDate(sValue) then
              SetParamValueQuery(PropInfo,PropInfo^.Name, AQry, sValue);
             end
           else
           begin
            if ValidateFloat(sValue) then
            SetParamValueQuery(PropInfo,PropInfo^.Name, AQry, sValue);
           end;
          end;
         end;
       end;
      end;
    end;

  finally
    FreeMem(List);
  end;
end;

procedure TDaoBase.SetParamValueQuery(AProp: PPropInfo; ACampo: string; AQry: TIBQuery; sValue : Variant);
begin
  case AProp^.PropType^.Kind of
    tkInt64, tkInteger:
    AQry.ParamByName(ACampo).AsInteger := sValue;
    tkChar, tkString, tkLString:  // Para versões superiores ao Delphi 7 acrescentar tkUString
    AQry.ParamByName(ACampo).AsString := sValue;
    tkFloat:
      begin
        if CompareText(AProp^.PropType^.Name, 'TDateTime') = 0 then
         AQry.ParamByName(ACampo).AsDate := setValueParamDate(sValue)
        else
          AQry.ParamByName(ACampo).AsFloat := sValue;
      end;
    tkVariant:
    AQry.ParamByName(ACampo).Value := sValue;
  else
    raise Exception.Create('Tipo de campo não conhecido: ' +
      AProp.Name);
  end;
end;



function TDaoBase.ValidateString(Value: string): Boolean;
begin
  Result := not(Value = EmptyStr);
end;

function TDaoBase.ValidateInteger(Value: Integer): Boolean;
begin
  Result := not(Value <= 0);
end;

function TDaoBase.ValidateFloat(Value: Double): Boolean;
begin
  Result := not(Value <= 0);
end;

function TDaoBase.ValidateDate(Value: Double): Boolean;
begin
  Result := not(Value = 0);
end;

function TDaoBase.setValueParamDate(Value: Double): TDateTime;
begin
 Result := FloatToDateTime(Value);
end;

function TDaoBase.setValueParamDouble(Value: Double): Double;
begin
 Result := Value;
end;

function TDaoBase.setValueParamInteger(Value: Variant): Integer;
begin
 Result := StrToInt(Value);
end;

function TDaoBase.setValueParamString(Value: Variant): string;
begin
 Result := Value;
end;

end.
