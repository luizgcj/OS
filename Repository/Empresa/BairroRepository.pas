unit BairroRepository;

interface

uses
  Data.Db, Database, ConexaoBanco, Bairro, EnumConexao, CustomExcept, System.SysUtils;

Type TBairroRepository = class Abstract
  private
    class procedure GetSQLPadrao(ConexaoBanco : TConexaoBanco);

  public
    class procedure DataSetToBairro(Dataset : TDataset; Bairro : TBairro);
    class function GetAll(Database : TDatabase):TDataset;
    class function Get(DataBase : TDataBase; Bairro : TBairro) : Boolean;
    class function GetOrCreateBairro(Bairro : TBairro; Database  : TDatabase) : TBairro;
    class function AtualizaBairro(Bairro : TBairro; Database  : TDatabase) : TBairro;
    class function AutoIncremento(Database : TDatabase):Integer;
end;

implementation

class function TBairroRepository.Get(Database : TDatabase; Bairro : TBairro) : Boolean;
Var
  ConexaoBanco : TConexaoBanco;
  DataSet : TDataSet;
begin
  Result := False;
  ConexaoBanco := TConexaoBanco.Create(DataBase);
  GetSqlPadrao(ConexaoBanco);
  ConexaoBanco.SQL.Add('AND B.CODIGO = :ID');
  ConexaoBanco.Param.ParamByName('Id').AsInteger := Bairro.Id;
  DataSet := ConexaoBanco.DataSetFactory.GetDataSet(TConexao.Empresa, ConexaoBanco.sql.Text, ConexaoBanco.Param);
  Dataset.First();
  DataSetToBairro(Dataset, Bairro);
  Result := Bairro.Id <> 0;
  DataSet.Free();
  ConexaoBanco.Free();
end;

Class Function TBairroRepository.GetAll(DataBase : TDataBase) : TDataSet;
Var
  ConexaoBanco : TConexaoBanco;
Begin
  ConexaoBanco := TConexaoBanco.Create(DataBase);
  GetSqlPadrao(ConexaoBanco);
  Result := ConexaoBanco.DataSetFactory.GetDataSet(TConexao.Empresa, ConexaoBanco.sql.Text);
  ConexaoBanco.Free();
End;

Class Procedure TBairroRepository.DataSetToBairro(DataSet : TDataSet; Bairro : TBairro);
Begin
  Try
    if (Not DataSet.Eof) then
    Begin
      Bairro.Id := DataSet.FieldByName('CODIGO').AsInteger;
      Bairro.Nome := DataSet.FieldByName('DESCRICAO').AsString;
      Bairro.COdigoemp := DataSet.FieldByName('CODIGOEMP').AsInteger;
    End
    else
      Bairro.Id := 0;
  Except
    Bairro := TBairro.Create();
  End;
End;

Class Procedure TBairroRepository.GetSqlPadrao(ConexaoBanco : TConexaoBanco);
begin
  ConexaoBanco.SQL.Add('SELECT B.CODIGO, B.DESCRICAO, B.CODIGOEMP');
  ConexaoBanco.SQL.Add('FROM BAIRROS B');
  ConexaoBanco.SQL.Add('WHERE B.CODIGO > 0');
end;

Class function TBairroRepository.GetOrCreateBairro(Bairro : TBairro; Database : TDatabase) : TBairro;
var
  DsBairros : TDataSet;
  ConexaoBanco : TConexaoBanco;
  Erro : String;
begin
  ConexaoBanco := TConexaoBanco.Create(Database);
  ConexaoBanco.SQL.Add('SELECT B.* FROM BAIRROS B WHERE B.CODIGOEMP = :CODIGOEMP AND B.DESCRICAO = :DESCRICAO');

  ConexaoBanco.Param.ParamByName('CODIGOEMP').AsInteger := Bairro.Codigoemp;
  ConexaoBanco.Param.ParamByName('DESCRICAO').AsString := Bairro.Nome;

  DsBairros := ConexaoBanco.DataSetFactory.GetDataSet(TConexao.Empresa, ConexaoBanco.sql.Text, ConexaoBanco.Param);
  if DsBairros.Eof then
  begin
    Bairro := AtualizaBairro(Bairro, Database);

    ConexaoBanco.SQL.Clear();
    ConexaoBanco.SQL.Add('INSERT INTO BAIRROS (CODIGO, DESCRICAO, CODIGOEMP) ');
    ConexaoBanco.SQL.Add('VALUES (:CODIGO, :DESCRICAO, :CODIGOEMP)');

    ConexaoBanco.Param.ParamByName('CODIGO').AsInteger := Bairro.Id;
    ConexaoBanco.Param.ParamByName('DESCRICAO').AsString := Bairro.Nome;
    ConexaoBanco.Param.ParamByName('CODIGOEMP').AsInteger := Bairro.Codigoemp;

    ConexaoBanco.DataSetFactory.PostDataSet(TConexao.Empresa, ConexaoBanco.sql.Text, ConexaoBanco.Param);
    Result := Bairro;
  end
  else
  begin
    Bairro.Id := DsBairros.FieldByName('CODIGO').AsInteger;
    Bairro.Nome := DsBairros.FieldByName('DESCRICAO').AsString;
    Bairro.Codigoemp := DsBairros.FieldByName('CODIGOEMP').AsInteger;
    Result := Bairro;
  end;
  DsBairros.Close;

end;

class function TBairroRepository.AtualizaBairro(Bairro : TBairro; Database  : TDatabase) : TBairro;
var DsEstado: TDataset;
    ConexaoBanco : TConexaoBanco;
begin
  if Bairro.Id = 0 then
    Bairro.Id := AutoIncremento(Database);
  if Bairro.Codigoemp = 0 then
    Bairro.Codigoemp := Database.CodigoEmpresa;

  Result := Bairro;
end;

class function TBairroRepository.AutoIncremento(Database : TDatabase):Integer;
var ConexaoBanco : TConexaoBanco;
  DataSet : TDataset;
begin
  Result := 0;
  ConexaoBanco := TConexaoBanco.Create(Database);
  try
    ConexaoBanco.SQL.Clear();
    ConexaoBanco.SQL.Add('SELECT COALESCE(MAX(B.CODIGO),0) + 1 AS ID');
    ConexaoBanco.SQL.Add('FROM BAIRROS B WHERE B.CODIGOEMP = :CODIGOEMP ');
    ConexaoBanco.Param.ParamByName('CODIGOEMP').AsInteger := Database.CodigoEmpresa;

    Result := ConexaoBanco.DataSetFactory.GetDataSet(TConexao.Empresa, ConexaoBanco.Sql.Text, ConexaoBanco.Param).FieldByName('ID').AsInteger;
  Except
    On E : Exception do
    Begin
      TCustomExcept.Show(e, 'Erro ao tentar executar AutoIncremento');
    End;
  End;
  ConexaoBanco.Free;
end;

end.
