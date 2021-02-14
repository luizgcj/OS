unit SetorRepository;

interface

Uses
  Data.Db,
  DataBase,
  Setor,
  EnumConexao,
  ConexaoBanco;

Type TSetorRepository = Class Abstract
  Private

    Class Procedure GetSqlPadrao(ConexaoBanco : TConexaoBanco);


  Public
    Class Procedure DataSetToSetor(DataSet : TDataSet; Setor : TSetor);

    Class Function Get(DataBase : TDataBase; Setor : TSetor) : Boolean;
    Class Function GetAll(DataBase : TDataBase) : TDataSet;
End;

implementation

Class Function TSetorRepository.Get(DataBase : TDataBase; Setor : TSetor) : Boolean;
Var
  ConexaoBanco : TConexaoBanco;
  DataSet : TDataSet;
Begin
  Result := False;
  ConexaoBanco := TConexaoBanco.Create(DataBase);
  GetSqlPadrao(ConexaoBanco);
  ConexaoBanco.SQL.Add('AND CODSETOR = :Id                                                                         ');
  ConexaoBanco.Param.ParamByName('Id').AsInteger := Setor.Id;
  DataSet := ConexaoBanco.DataSetFactory.GetDataSet(TConexao.Empresa, ConexaoBanco.sql.Text, ConexaoBanco.Param);
  DataSet.First();
  DataSetToSetor(DataSet, Setor);
  if Setor.Id <> 0 then
    Result := True;
End;

Class Function TSetorRepository.GetAll(DataBase : TDataBase) : TDataSet;
Var
  ConexaoBanco : TConexaoBanco;
Begin
  ConexaoBanco := TConexaoBanco.Create(DataBase);
  GetSqlPadrao(ConexaoBanco);
  Result := ConexaoBanco.DataSetFactory.GetDataSet(TConexao.Empresa, ConexaoBanco.sql.Text);
End;

Class Procedure TSetorRepository.GetSqlPadrao(ConexaoBanco : TConexaoBanco);
begin
  ConexaoBanco.SQL.Add('SELECT                                                                                            ');
  ConexaoBanco.SQL.Add('CODSETOR AS ID,                                                                                   ');
  ConexaoBanco.SQL.Add('SETOR AS NOME,                                                                                    ');
  ConexaoBanco.SQL.Add('STUDIO                                                                                            ');
  ConexaoBanco.SQL.Add('FROM SETOR                                                                                        ');
  ConexaoBanco.SQL.Add('WHERE                                                                                             ');
  ConexaoBanco.SQL.Add('CODSETOR > 0                                                                                      ');

end;

Class Procedure TSetorRepository.DataSetToSetor(DataSet : TDataSet; Setor : TSetor);
Begin
  Try
    if (Not DataSet.Eof) then
    Begin
      Setor.Id := DataSet.FieldByName('Id').AsInteger;
      Setor.Nome := DataSet.FieldByName('Nome').AsString;
      Setor.Studio := DataSet.FieldByName('Studio').AsString = 'S';
    End
    else
      Setor.Id := 0;
  Except
    Setor := TSetor.Create();
  End;
End;

end.
