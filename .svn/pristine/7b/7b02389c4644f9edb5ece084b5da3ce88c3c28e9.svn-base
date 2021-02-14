unit FormaPagamentoRepository;

interface

Uses
  Data.Db,
  DataBase,
  ConexaoBanco,
  EnumConexao,
  FormaPagamento;

Type TFormaPagamentoRepository = Class
  Private
    Class Procedure ConsultaPadrao(ConexaoBanco : TConexaoBanco);
  Public
    Class Function Get(DataBase : TDataBase; FormaPagamento : TFormaPagamento):Boolean;
    Class Function GetAll(DataBase : TDataBase):TDataSet;
    Class Procedure DataSetToFormaPagamento(DataSet : TDataSet; FormaPagamento : TFormaPagamento);
End;

implementation

Class Procedure TFormaPagamentoRepository.ConsultaPadrao(ConexaoBanco : TConexaoBanco);
Begin
  ConexaoBanco.SQL.Add('SELECT                                                                                            ');
  ConexaoBanco.SQL.Add('CODIGO AS ID,                                                                                     ');
  ConexaoBanco.SQL.Add('DESCRICAO AS NOME,                                                                                ');
  ConexaoBanco.SQL.Add('MAISCAIXA,                                                                                        ');
  ConexaoBanco.SQL.Add('CARTAO,                                                                                           ');
  ConexaoBanco.SQL.Add('CHEQUE, BAIXAALTCTRECEBER                                                                         ');
  ConexaoBanco.SQL.Add('FROM FORMASPAGAMENTO                                                                              ');
  ConexaoBanco.SQL.Add('WHERE                                                                                             ');
  ConexaoBanco.SQL.Add('CODIGO > 0                                                                                        ');
End;

Class Function TFormaPagamentoRepository.Get(DataBase : TDataBase; FormaPagamento : TFormaPagamento):Boolean;
Var
  ConexaoBanco : TConexaoBanco;
Begin
  Result := False;
  ConexaoBanco := TConexaoBanco.Create(DataBase);
  TFormaPagamentoRepository.ConsultaPadrao(ConexaoBanco);
  ConexaoBanco.Sql.Add('AND CODIGO = :Id ');

  ConexaoBanco.Param.ParamByName('Id').AsInteger := FormaPagamento.Id;

  TFormaPagamentoRepository.DataSetToFormaPagamento(ConexaoBanco.DataSetFactory.GetDataSet(TConexao.Empresa, ConexaoBanco.sql.Text, ConexaoBanco.Param), FormaPagamento);
  if FormaPagamento.Id <> 0 then
    Result := True;
End;

Class Function TFormaPagamentoRepository.GetAll(DataBase : TDataBase):TDataSet;
Var
  ConexaoBanco : TConexaoBanco;
Begin
  ConexaoBanco := TConexaoBanco.Create(DataBase);
  TFormaPagamentoRepository.ConsultaPadrao(ConexaoBanco);
  Result := ConexaoBanco.DataSetFactory.GetDataSet(TConexao.Empresa, ConexaoBanco.sql.Text, ConexaoBanco.Param);
End;

Class Procedure TFormaPagamentoRepository.DataSetToFormaPagamento(DataSet : TDataSet; FormaPagamento : TFormaPagamento);
Begin
  if (Not DataSet.Eof) then
  Begin
    FormaPagamento.Id             := DataSet.FieldByName('ID').AsInteger;
    FormaPagamento.Nome           := DataSet.FieldByName('NOME').AsString;
    FormaPagamento.Cartao         := DataSet.FieldByName('CARTAO').AsString;
    FormaPagamento.Cheque         := DataSet.FieldByName('CHEQUE').AsString;
    FormaPagamento.EnviaMaisCaixa := DataSet.FieldByName('MAISCAIXA').AsString;
    FormaPagamento.BaixaAutomatica := DataSet.FieldByName('BAIXAALTCTRECEBER').AsString = 'S';
  End
  else
    FormaPagamento.Id := 0;
End;

end.
