unit DataSetFactory;

interface

uses  Db, FireDAC.Comp.Client, FireDac.Stan.Param, FireDac.Dapt, EnumConexao, Classes, SysUtils, DataBase,
      FireDAC.Stan.Option;

type TParams = class (TFDParams)
  public
    function ParamByName(const AValue: String): TFDParam;
    constructor Create;
    destructor Destroy;
end;

type TDataSetFactory = class
  private
    fConnectionEmpresa : TFDConnection;
    fConnectionBaseDados : TFDConnection;
    fConnectionRecursos : TFDConnection;
    fTransactionEmp : TFDTransaction;
    fTransactionBase : TFDTransaction;
    function GetConnection(conexao : TConexao) : TFDConnection;
    function GetFDQuery(conexao : TConexao) : TFDQuery;
    procedure SetSqlQuery(fQuery : TFDQUery; sql : string; params : TParams = nil);
  public
    constructor Create(vDataBase:TDataBase);
    procedure StartTransaction(conexao : TConexao);
    procedure Commit(conexao : TConexao);
    procedure RollBack (conexao : TConexao);
    function GetDataSet(conexao : TConexao; sql : string; params : TParams = nil): TDataSet;
    procedure PostDataSet(conexao : TConexao; sql : string; params : TParams = nil);
    function AutoIncremento(conexao : TConexao; tabela:String; campo:String; codigoEmpresa : integer; empresa:Boolean):Integer;

end;


implementation


{$Region 'Private'}

function TDataSetFactory.GetConnection(conexao : TConexao) : TFDConnection;
begin
  if (conexao = TConexao.BaseDados) then
    Result := fConnectionBaseDados
  else if (conexao = TConexao.Empresa) then
    Result := fConnectionEmpresa
  else if (conexao = TConexao.Recursos) then
    Result := fConnectionRecursos;
end;

function TDataSetFactory.GetFDQuery(conexao : TConexao) : TFDQuery;
  var fQuery : TFDQuery;
begin
  fQuery := TFDQuery.Create(nil);
  fQuery.Connection := GetConnection(conexao);
  Result := fQuery;
end;

procedure TDataSetFactory.SetSqlQuery(fQuery : TFDQuery; sql : string; params: TParams =nil);
begin
  fQuery.SQL.Text := sql;
  if (params <> nil) then
    fQuery.Params := params;
end;

{$endRegion}


constructor TParams.Create;
begin
  inherited;
end;

destructor TParams.Destroy;
begin
  inherited;
end;

function TParams.ParamByName(const AValue: String): TFDParam;
begin
  Add.Name := AValue;
  Result := inherited;
end;


constructor TDataSetFactory.Create(vDataBase:TDataBase);
var
  parametro : TParams;
begin
  Inherited Create();

  fConnectionEmpresa := vDataBase.Empresa;
  fConnectionBaseDados := vDataBase.Basedados;
  fConnectionRecursos := vDataBase.Recursos;
  if fConnectionEmpresa.Connected then
  begin
    fTransactionEmp := TFDTransaction.Create(nil);
    fTransactionEmp.Connection := fConnectionEmpresa;
    fTransactionEmp.Options.ReadOnly := False;
    fTransactionEmp.Options.Isolation := xiReadCommitted;
  end;
  if fConnectionBaseDados.Connected then
  begin
    fTransactionBase := TFDTransaction.Create(nil);
    fTransactionBase.Connection := fConnectionBaseDados;
    fTransactionBase.Options.ReadOnly := False;
    fTransactionBase.Options.Isolation := xiReadCommitted;
  end;
end;

function TDataSetFactory.GetDataSet(conexao : TConexao; sql : string; params : TParams = nil) : TDataSet;
var
  fQuery : TFDQuery;
begin
  fQuery := GetFDQuery(conexao);
  SetSqlQuery(fQuery, sql, params);
  FQuery.FetchOptions.Mode := fmAll;
  Result := fQuery;

  Result.Open;
  Result.First;
end;

procedure TDataSetFactory.PostDataSet(conexao : TConexao; sql : string; params : TParams = nil);
var
  fQuery : TFDQuery;
begin
  fQuery := GetFDQuery(conexao);
  SetSqlQuery(fQuery, sql, params);
  fQuery.ExecSQL;

end;

procedure TDataSetFactory.StartTransaction(conexao : TConexao);
begin

  GetConnection(conexao).UpdateOptions.LockWait := False;
  if conexao = TConexao.Empresa then
    GetConnection(conexao).Transaction := fTransactionEmp
  else if conexao = TConexao.BaseDados then
    GetConnection(conexao).Transaction := fTransactionBase;
  GetConnection(conexao).StartTransaction;
end;

procedure TDataSetFactory.Commit(conexao : TConexao);
begin
  GetConnection(conexao).Commit;
end;

procedure TDataSetFactory.RollBack (conexao : TConexao);
begin
   GetConnection(conexao).RollBack;
end;


function TDataSetFactory.AutoIncremento(conexao : TConexao; tabela:String; campo:String; codigoEmpresa : integer; empresa:Boolean):Integer;
var
  dataSet : TDataSet;
  sql  : TStringList;
  int : Integer;
begin
  Sql := TStringList.Create;

  Sql.Clear;
  Sql.Add('Select Max(' + campo +') as Proximo');
  Sql.Add('From '+ tabela);
  if empresa then
    Sql.Add('WHERE CODIGOEMP=' + IntToStr(codigoEmpresa));

  dataSet := GetDataSet(conexao, sql.text);

  int := dataSet.FieldByName('Proximo').asInteger + 1;
  Result := int;
end;




end.
