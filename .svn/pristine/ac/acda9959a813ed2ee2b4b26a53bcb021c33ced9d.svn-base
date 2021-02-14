unit EmpresaRepository;

interface
Uses
  Data.Db,
  System.Classes,
  Empresa,
  DataBase,
  ConexaoBanco,
  EnumConexao;


Type TEmpresaRepository = Class Abstract
  Private
    Class Function SqlPadrao():String;
  Public
    Class Function GetEmpresa(DataBase : TDataBase):TDataSet;

End;

implementation

Class Function TEmpresaRepository.SqlPadrao():String;
var
  Sql :TStringList;
Begin
  Sql := TStringList.Create();
  Sql.Add('Select                                     ');
  Sql.Add('d.CgcEmpresa As Cnpj,                      ');
  Sql.Add('d.NomeEmpresa As Nome,                     ');
  Sql.Add('d.EnderecoEmpresa As Endereco,             ');
  Sql.Add('d.NumeroEmpresa As Numero,                 ');
  Sql.Add('d.ComplementoEmpresa As Complemento,       ');
  Sql.Add('d.BairroEmpresa As Bairro,                 ');
  Sql.Add('d.CidadeEmpresa As Cidade,                 ');
  Sql.Add('d.EstadoEmpresa As Uf,                     ');
  Sql.Add('d.CepEmpresa As Cep,                       ');
  Sql.Add('d.TelefoneEmpresa As Telefone,             ');
  Sql.Add('d.FaxEmpresa As Fax                        ');
  Sql.Add('From Dglob000 d                            ');
  Sql.Add('Where                                      ');
  Sql.Add('1 = 1                                      ');
  Result := sql.Text;
End;

Class Function TEmpresaRepository.GetEmpresa(DataBase : TDataBase) : TDataSet;
Var
  ConexaoBanco : TConexaoBanco;
Begin
  ConexaoBanco := TConexaoBanco.Create(DataBase);
  ConexaoBanco.Sql.Text := TEmpresaRepository.SqlPadrao();
  ConexaoBanco.Sql.Add('And CodigoEmpresa = :CodigoEmpresa');
  ConexaoBanco.Param.ParamByName('CodigoEmpresa').AsInteger := DataBase.CodigoEmpresa;
  Result := ConexaoBanco.DataSetFactory.GetDataSet(TConexao.BaseDados, ConexaoBanco.Sql.Text, ConexaoBanco.Param);
End;


end.
