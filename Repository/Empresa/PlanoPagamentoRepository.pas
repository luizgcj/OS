unit PlanoPagamentoRepository;

interface

Uses
  Data.Db,
  DataBase,
  ConexaoBanco,
  EnumConexao,
  PlanoPagamento;

Type TPlanoPagamentoRepository = Class
  Private
    Class Procedure ConsultaPadrao(ConexaoBanco : TConexaoBanco);
  Public
    Class Function Get(DataBase : TDataBase; PlanoPagamento : TPlanoPagamento):Boolean;
    Class Function GetAll(DataBase : TDataBase):TDataSet;
    Class Procedure DataSetToPlanoPagamento(DataSet : TDataSet; PlanoPagamento : TPlanoPagamento);
    Class Procedure ConsultaPlanoVista(DataBase : TDataBase; PlanoPagamento : TPlanoPagamento);
End;

implementation

Class Procedure TPlanoPagamentoRepository.ConsultaPadrao(ConexaoBanco : TConexaoBanco);
Begin
  ConexaoBanco.SQL.Add('SELECT                                                                                   ');
  ConexaoBanco.SQL.Add('CODIGOFORMA AS ID,                                                                       ');
  ConexaoBanco.SQL.Add('DESCRITIVO AS NOME,                                                                      ');
  ConexaoBanco.SQL.Add('DESDOFORMA AS PARCELAS,                                                                  ');
  ConexaoBanco.SQL.Add('DESCRICFORMA AS DESDOBRAMENTO                                                            ');
  ConexaoBanco.SQL.Add('FROM DGLOB030                                                                            ');
  ConexaoBanco.SQL.Add('WHERE                                                                                    ');
  ConexaoBanco.SQL.Add('CODIGOFORMA > 0                                                                          ');

End;

Class Procedure TPlanoPagamentoRepository.ConsultaPlanoVista(DataBase : TDataBase; PlanoPagamento : TPlanoPagamento);
Var
  ConexaoBanco : TConexaoBanco;
Begin
  ConexaoBanco := TConexaoBanco.Create(DataBase);
  TPlanoPagamentoRepository.ConsultaPadrao(ConexaoBanco);

  ConexaoBanco.Sql.Add('AND DESDOFORMA = 1 AND INTERVALO = 0');

  TPlanoPagamentoRepository.DataSetToPlanoPagamento(ConexaoBanco.DataSetFactory.GetDataSet(TConexao.Empresa, ConexaoBanco.sql.Text, ConexaoBanco.Param), PlanoPagamento);

End;

Class Function TPlanoPagamentoRepository.Get(DataBase : TDataBase; PlanoPagamento : TPlanoPagamento):Boolean;
Var
  ConexaoBanco : TConexaoBanco;
Begin
  Result := False;
  ConexaoBanco := TConexaoBanco.Create(DataBase);
  TPlanoPagamentoRepository.ConsultaPadrao(ConexaoBanco);
  ConexaoBanco.Sql.Add('AND CODIGOFORMA = :Id ');

  ConexaoBanco.Param.ParamByName('Id').AsInteger := PlanoPagamento.Id;

  TPlanoPagamentoRepository.DataSetToPlanoPagamento(ConexaoBanco.DataSetFactory.GetDataSet(TConexao.Empresa, ConexaoBanco.sql.Text, ConexaoBanco.Param), PlanoPagamento);
  if PlanoPagamento.Id <> 0 then
    Result := True;
End;

Class Function TPlanoPagamentoRepository.GetAll(DataBase : TDataBase):TDataSet;
Var
  ConexaoBanco : TConexaoBanco;
Begin
  ConexaoBanco := TConexaoBanco.Create(DataBase);
  TPlanoPagamentoRepository.ConsultaPadrao(ConexaoBanco);
  Result := ConexaoBanco.DataSetFactory.GetDataSet(TConexao.Empresa, ConexaoBanco.sql.Text, ConexaoBanco.Param);
End;

Class Procedure TPlanoPagamentoRepository.DataSetToPlanoPagamento(DataSet : TDataSet; PlanoPagamento : TPlanoPagamento);
Begin
  if (Not DataSet.Eof) then
  Begin
    PlanoPagamento.Id := DataSet.FieldByName('Id').AsInteger;
    PlanoPagamento.Nome := DataSet.FieldByName('Nome').AsString;
    PlanoPagamento.Desdobramento := DataSet.FieldByName('DESDOBRAMENTO').AsString;
    PlanoPagamento.Parcelas := DataSet.FieldByName('PARCELAS').AsInteger;

  End
  else
    PlanoPagamento.Id := 0;
End;

end.
