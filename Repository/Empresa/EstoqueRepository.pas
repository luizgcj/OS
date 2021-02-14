unit EstoqueRepository;

interface

Uses
  Data.Db,
  System.Classes,
  System.SysUtils,
  ConexaoBanco,
  EnumConexao,
  DataBase,
  CustomExcept;

Type TCusto = (CustoAtual, CustoMedio);

Type TEstoqueRepository = Class
  Private

  Public
    Class Function SqlPadrao(Custo : TCusto; ExcetoOrdemServicoId : Integer = 0): String;
    Class Function GetEstoque(CodigoProduto : Integer; Custo : TCusto; DataBase : TDataBase; ExcetoOrdemServicoId : Integer = 0):Double;

End;

implementation

Class Function TEstoqueRepository.SqlPadrao(Custo : TCusto; ExcetoOrdemServicoId : Integer = 0): String;
Var
  Sql :TStringList;
  sCusto : String;
Begin
  Result := '';
  case Custo of
    CustoAtual: sCusto := 'Pe.PrCustoProduto';
    CustoMedio: sCusto := 'Pe.PrCustoMedio';
  end;

  Sql := TStringList.Create();
  SQL.Add('Select Pe.CodigoProduto As ProdutoId,                                                             ');
  SQL.Add('P.DescricProduto As Produto,                                                                      ');
  SQL.Add('(Pe.QtdeAtualProduto) As Quantidade,                                 ');
  SQL.Add(sCusto+' As Custo,                                                                                 ');
  SQL.Add('Round('+sCusto+' * Pe.QtdeAtualProduto,2) As ValorTotal           ');
  SQL.Add('From Produtos_Emp Pe                                                                              ');
  SQL.Add('Inner Join Produtos P On                                                                          ');
  SQL.Add('    P.CodigoProduto = Pe.CodigoProduto                                                            ');
  SQL.Add('Where                                                                                             ');
  SQL.Add('Pe.CodigoEmp = :CodigoEmp                                                                         ');
  Result := Sql.Text;
End;

Class Function TEstoqueRepository.GetEstoque(CodigoProduto : Integer; Custo : TCusto; DataBase : TDataBase; ExcetoOrdemServicoId : Integer = 0):Double;
Var
  ConexaoBanco : TConexaoBanco;
  DataSet : TDataSet;
Begin
  try
    ConexaoBanco := TConexaoBanco.Create(DataBase);
    ConexaoBanco.Sql.Text := TEstoqueRepository.SqlPadrao(Custo, ExcetoOrdemServicoId);
    ConexaoBanco.SQL.Add('and Pe.CodigoProduto = :ProdutoId ');
    ConexaoBanco.Param.ParamByName('CodigoEmp').AsInteger := DataBase.CodigoEmpresa;
    ConexaoBanco.Param.ParamByName('ProdutoId').AsInteger := CodigoProduto;

    DataSet := ConexaoBanco.DataSetFactory.GetDataSet(TConexao.Empresa, ConexaoBanco.Sql.Text, ConexaoBanco.Param);
    DataSet.First();
    if (Not DataSet.Eof) then
      Result := DataSet.FieldByName('Quantidade').AsFloat;
  Except
    On E : Exception do
    Begin
      TCustomExcept.Show(e,'GetEstoque('+IntToStr(CodigoProduto),False);
      Result := 0;
    End;
  end;
End;

end.
