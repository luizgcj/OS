unit CidadeRepository;

interface
uses
  Data.Db, Database, ConexaoBanco, Cidade, EnumConexao, CustomExcept, System.SysUtils, Variants;

Type TCidadeRepository = class Abstract
  private
    class procedure GetSQLPadrao(ConexaoBanco : TConexaoBanco);

  public
    class procedure DataSetToCidade(Dataset : TDataset; Cidade : TCidade);
    class function GetAll(Database : TDatabase):TDataset;
    class function Get(DataBase : TDataBase; Cidade : TCidade) : Boolean;
    class function GetOrCreateCidade(Cidade : TCidade; Database  : TDatabase) : TCidade;
    class function AtualizaCidade(Cidade : TCidade; Database  : TDatabase) : TCidade;
    class function AutoIncremento(Database : TDatabase):Integer;
end;

implementation

class function TCidadeRepository.Get(Database : TDatabase; Cidade : TCidade) : Boolean;
Var
  ConexaoBanco : TConexaoBanco;
  DataSet : TDataSet;
begin
  Result := False;
  ConexaoBanco := TConexaoBanco.Create(DataBase);
  GetSqlPadrao(ConexaoBanco);
  ConexaoBanco.SQL.Add('AND C.CODIGO = :ID');
  ConexaoBanco.SQL.Add('ORDER BY C.CODIGO');
  ConexaoBanco.Param.ParamByName('ID').AsInteger := Cidade.Id;
  DataSet := ConexaoBanco.DataSetFactory.GetDataSet(TConexao.Empresa, ConexaoBanco.sql.Text, ConexaoBanco.Param);
  Dataset.First();
  DataSetToCidade(Dataset, Cidade);
  Result := Cidade.Id <> 0;
  DataSet.Free();
  ConexaoBanco.Free();
end;

Class Function TCidadeRepository.GetAll(DataBase : TDataBase) : TDataSet;
Var
  ConexaoBanco : TConexaoBanco;
Begin
  ConexaoBanco := TConexaoBanco.Create(DataBase);
  GetSqlPadrao(ConexaoBanco);
  ConexaoBanco.SQL.Add('ORDER BY C.CODIGO');
  Result := ConexaoBanco.DataSetFactory.GetDataSet(TConexao.Empresa, ConexaoBanco.sql.Text);
  ConexaoBanco.Free();
End;

Class Procedure TCidadeRepository.DataSetToCidade(DataSet : TDataSet; Cidade : TCidade);
Begin
  Try
    if (Not DataSet.Eof) then
    Begin
      Cidade.Id := DataSet.FieldByName('CODIGO').AsInteger;
      Cidade.Nome := DataSet.FieldByName('DESCRICAO').AsString;
      Cidade.EstadoId := DataSet.FieldByName('UF').AsInteger;
      Cidade.Estado := DataSet.FieldByName('ESTADO').AsString;
      Cidade.Ibge := DataSet.FieldByName('CODCIDADE_IBGE').AsInteger;
      Cidade.SiglaEstado := DataSet.FieldByName('SIGLA').AsString;
    End
    else
      Cidade.Id := 0;
  Except
    Cidade := TCidade.Create();
  End;
End;

Class Procedure TCidadeRepository.GetSqlPadrao(ConexaoBanco : TConexaoBanco);
begin
  ConexaoBanco.SQL.Add('SELECT C.CODIGO, C.DESCRICAO, C.UF, E.DESCRICAO AS ESTADO, C.CODCIDADE_IBGE, E.SIGLA');
  ConexaoBanco.SQL.Add('FROM CIDADES C JOIN ESTADOS E ON C.UF = E.CODIGO');
  ConexaoBanco.SQL.Add('WHERE C.CODIGO > 0');
end;

Class function TCidadeRepository.GetOrCreateCidade(Cidade : TCidade; Database : TDatabase) : TCidade;
var
  DsCidades : TDataSet;
  ConexaoBanco : TConexaoBanco;
begin
  ConexaoBanco := TConexaoBanco.Create(Database);
  ConexaoBanco.SQL.Add('SELECT C.*, E.SIGLA, E.CODIGO AS ESTADOID, E.DESCRICAO AS ESTADO');
  ConexaoBanco.SQL.Add('FROM CIDADES C JOIN ESTADOS E ON E.CODIGO = C.UF');
  ConexaoBanco.SQL.Add('WHERE C.DESCRICAO = :DESCRICAO AND E.SIGLA = :SIGLA AND C.CODCIDADE_IBGE = :CODCIDADE_IBGE');

  ConexaoBanco.Param.ParamByName('DESCRICAO').AsString := Cidade.Nome;
  ConexaoBanco.Param.ParamByName('SIGLA').AsString := Cidade.SiglaEstado;
  ConexaoBanco.Param.ParamByName('CODCIDADE_IBGE').AsInteger := Cidade.Ibge;

  DsCidades := ConexaoBanco.DataSetFactory.GetDataSet(TConexao.Empresa, ConexaoBanco.sql.Text, ConexaoBanco.Param);

  if DsCidades.Eof then
  begin
    Cidade := AtualizaCidade(Cidade, Database);

    ConexaoBanco.SQL.Clear();
    ConexaoBanco.SQL.Add('INSERT INTO CIDADES (CODIGO, DESCRICAO, UF, CODCIDADE_IBGE, CODIGOREGIAO) ');
    ConexaoBanco.SQL.Add('VALUES (:CODIGO, :DESCRICAO, :UF, :CODCIDADE_IBGE, :CODIGOREGIAO)');

    ConexaoBanco.Param.ParamByName('CODIGO').AsInteger := Cidade.Id;
    ConexaoBanco.Param.ParamByName('DESCRICAO').AsString := Cidade.Nome;
    ConexaoBanco.Param.ParamByName('UF').AsInteger := Cidade.EstadoId;
    ConexaoBanco.Param.ParamByName('CODCIDADE_IBGE').AsInteger := Cidade.Ibge;
    ConexaoBanco.Param.ParamByName('CODREGIAO').Value := null;

    ConexaoBanco.DataSetFactory.PostDataSet(TConexao.Empresa, ConexaoBanco.sql.Text, ConexaoBanco.Param);
    Result := Cidade;
  end
  else
  begin
    Cidade.Id := DsCidades.FieldByName('CODIGO').AsInteger;
    Cidade.Nome := DsCidades.FieldByName('DESCRICAO').AsString;
    Cidade.EstadoId := DsCidades.FieldByName('ESTADOID').AsInteger;
    Cidade.Estado := DsCidades.FieldByName('ESTADO').AsString;
    Cidade.SiglaEstado := DsCidades.FieldByName('SIGLA').AsString;
    Cidade.Ibge := DsCidades.FieldByName('CODCIDADE_IBGE').AsInteger;

    Result := Cidade;
  end;
  DsCidades.Close;

end;

class function TCidadeRepository.AtualizaCidade(Cidade : TCidade; Database  : TDatabase) : TCidade;
var DsEstado: TDataset;
    ConexaoBanco : TConexaoBanco;
begin
  if Cidade.Id = 0 then
    Cidade.Id := AutoIncremento(Database);
  if Cidade.EstadoId = 0 then
  begin
    ConexaoBanco := TConexaoBanco.Create(Database);
    ConexaoBanco.SQL.Add('SELECT CODIGO, DESCRICAO FROM ESTADOS E WHERE E.SIGLA = :SIGLA');
    ConexaoBanco.Param.ParamByName('SIGLA').AsString := Cidade.SiglaEstado;

    DsEstado := ConexaoBanco.DataSetFactory.GetDataSet(TConexao.Empresa, ConexaoBanco.sql.Text, ConexaoBanco.Param);
    if not DsEstado.Eof then
    begin
      Cidade.EstadoId := DsEstado.FieldByName('CODIGO').AsInteger;
      Cidade.Estado := DsEstado.FieldByName('DESCRICAO').AsString;
    end;
  end;

end;

class function TCidadeRepository.AutoIncremento(Database : TDatabase):Integer;
var ConexaoBanco : TConexaoBanco;
begin
  Result := 0;
  ConexaoBanco := TConexaoBanco.Create(Database);
  try
    ConexaoBanco.SQL.Add('SELECT COALESCE(MAX(C.CODIGO),0) + 1 AS ID');
    ConexaoBanco.SQL.Add('FROM CIDADES C ');
    Result := ConexaoBanco.DataSetFactory.GetDataSet(TConexao.Empresa, ConexaoBanco.Sql.Text).FieldByName('ID').AsInteger;
  Except
    On E : Exception do
    Begin
      TCustomExcept.Show(e, 'Erro ao tentar executar AutoIncremento');
    End;
  End;
  ConexaoBanco.Free;
end;


end.
