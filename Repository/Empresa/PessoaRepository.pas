  unit PessoaRepository;

interface

Uses
  Data.Db,
  DataBase,
  Pessoa,
  EnumPessoaTipo,
  EnumConexao,
  ConexaoBanco,
  SysUtils, CustomExcept, Variants, Usuario, Cidade;

Type TPessoaRepository = Class Abstract
  Private

    Class Procedure GetSqlPadrao(ConexaoBanco : TConexaoBanco; PessoaTipo : TEnumPessoaTipo);


  Public
    Class Procedure DataSetToPessoa(DataSet : TDataSet; Pessoa : TPessoa);

    Class Function Get(DataBase : TDataBase; Pessoa : TPessoa; PessoaTipo : TEnumPessoaTipo = TEnumPessoaTipo.Todos ) : Boolean;
    Class Function GetAll(DataBase : TDataBase; PessoaTipo : TEnumPessoaTipo = TEnumPessoaTipo.Todos) : TDataSet;
    class function AutoIncremento(Database : TDatabase):Integer;
    class procedure Gravar(Cliente : TPessoa; Database : TDatabase);
    class procedure GravarLog(Cliente : TPessoa; Database : TDatabase; Usuario : TUsuario; Cidade : TCidade);
    class function AutoIncrementoLog(Database : TDatabase):Integer;
End;

implementation

Class Function TPessoaRepository.Get(DataBase : TDataBase; Pessoa : TPessoa; PessoaTipo : TEnumPessoaTipo = TEnumPessoaTipo.Todos ) : Boolean;
Var
  ConexaoBanco : TConexaoBanco;
  DataSet : TDataSet;
Begin
  Result := False;
  ConexaoBanco := TConexaoBanco.Create(DataBase);
  GetSqlPadrao(ConexaoBanco, PessoaTipo);
  ConexaoBanco.SQL.Add('And P.PessoaCodigo = :Id                                                                         ');
  ConexaoBanco.Param.ParamByName('Id').AsInteger := Pessoa.Id;
  DataSet := ConexaoBanco.DataSetFactory.GetDataSet(TConexao.Empresa, ConexaoBanco.sql.Text, ConexaoBanco.Param);
  DataSet.First();
  DataSetToPessoa(DataSet, Pessoa);
  if Pessoa.Id <> 0 then
    Result := True;
End;

Class Function TPessoaRepository.GetAll(DataBase : TDataBase; PessoaTipo : TEnumPessoaTipo = TEnumPessoaTipo.Todos) : TDataSet;
Var
  ConexaoBanco : TConexaoBanco;
Begin
  ConexaoBanco := TConexaoBanco.Create(DataBase);
  GetSqlPadrao(ConexaoBanco, PessoaTipo);
  Result := ConexaoBanco.DataSetFactory.GetDataSet(TConexao.Empresa, ConexaoBanco.sql.Text);
End;

Class Procedure TPessoaRepository.GetSqlPadrao(ConexaoBanco : TConexaoBanco; PessoaTipo : TEnumPessoaTipo);
begin
  ConexaoBanco.SQL.Add('Select                                                                                            ');
  ConexaoBanco.SQL.Add('P.PessoaCodigo As Id,                                                                             ');
  ConexaoBanco.SQL.Add('P.PessoaNome As Nome,                                                                             ');
  ConexaoBanco.SQL.Add('P.PessoaCpf_Cnpj As CpfCnpj,                                                                      ');
  ConexaoBanco.SQL.Add('P.PessoaInscrEst_Rg As IE,                                                                        ');
  ConexaoBanco.SQL.Add('P.PessoaRg As RG,                                                                                 ');
  ConexaoBanco.SQL.Add('P.PessoaTelefone As Telefone,                                                                     ');
  ConexaoBanco.SQL.Add('P.PessoaCelular As Celular,                                                                       ');
  ConexaoBanco.SQL.Add('P.PessoaEndereco As Endereco,                                                                     ');
  ConexaoBanco.SQL.Add('P.PessoaNumero As Numero,                                                                         ');
  ConexaoBanco.SQL.Add('P.PessoaBairro As BairroId,                                                                       ');
  ConexaoBanco.SQL.Add('B.Descricao As Bairro,                                                                            ');
  ConexaoBanco.SQL.Add('P.PessoaCidade As CidadeId,                                                                       ');
  ConexaoBanco.SQL.Add('C.Descricao As Cidade,                                                                            ');
  ConexaoBanco.SQL.Add('C.Uf As EstadoId,                                                                                 ');
  ConexaoBanco.SQL.Add('E.Sigla As EstadoAbreviatura,                                                                     ');
  ConexaoBanco.SQL.Add('E.Descricao As Estado,                                                                            ');
  ConexaoBanco.SQL.Add('P.PessoaCep As Cep,                                                                               ');
  ConexaoBanco.SQL.Add('Pe.PessoaPercMaxDescOSFunc As DescontoMaximo,                                                     ');
  ConexaoBanco.SQL.Add('P.PessoaProfissional,                                                                                   ');
  ConexaoBanco.SQL.Add('Coalesce(Tab.Percentual,0) As TabelaPreco,                                                        ');
  ConexaoBanco.SQL.Add('Pe.PessoaComissaoFunc As PercComissao,                                                             ');
  ConexaoBanco.SQL.Add('Pe.PessoaVendedorCli');
  ConexaoBanco.SQL.Add('From Pessoa P Inner Join Pessoa_Emp Pe On P.PessoaCodigo = Pe.PessoaCodigo ');
  ConexaoBanco.SQL.Add('Inner Join Bairros B On B.Codigo = P.PessoaBairro ');
  ConexaoBanco.SQL.Add('Inner Join Cidades C On C.Codigo = P.PessoaCidade ');
  ConexaoBanco.SQL.Add('Inner Join Estados E On E.Codigo = C.Uf ');
  ConexaoBanco.SQL.Add('Left Join TabelaPrecos Tab On Tab.Codigo = Pe.PESSOACODTABELAPRECOS and Tab.TipoTabela = ''D''');
  ConexaoBanco.SQL.Add('Where P.PessoaCodigo > 0  ');

  case (PessoaTipo) of
    TEnumPessoaTipo.Cliente : ConexaoBanco.SQL.Add('And P.PessoaTipo = ''C'' ');
    TEnumPessoaTipo.Fornecedor : ConexaoBanco.SQL.Add('And P.PessoaTipo = ''F'' ');
    TEnumPessoaTipo.Transportadora : ConexaoBanco.SQL.Add('And P.PessoaTipo = ''T'' ');
    TEnumPessoaTipo.Funcionario : ConexaoBanco.SQL.Add('And P.PessoaTipo = ''E'' ');
    TEnumPessoaTipo.Vendedor : ConexaoBanco.SQL.Add('And P.PessoaTipo = ''E'' And P.PessoaVendedorFunc = ''S'' ');
    TEnumPessoaTipo.Representante : ConexaoBanco.SQL.Add('And P.PessoaTipo = ''E'' And P.PessoaRepresentanteFunc = ''S'' ');
    TEnumPessoaTipo.Comprador : ConexaoBanco.SQL.Add('And P.PessoaTipo = ''E'' And P.PessoaCompradorFunc = ''S'' ');
  end;
end;

Class Procedure TPessoaRepository.DataSetToPessoa(DataSet : TDataSet; Pessoa : TPessoa);
Begin
  Try
    if (Not DataSet.Eof) then
    Begin
      Pessoa.Id := DataSet.FieldByName('Id').AsInteger;
      Pessoa.Nome := DataSet.FieldByName('Nome').AsString;
      Pessoa.CpfCnpj := DataSet.FieldByName('CpfCnpj').AsString;
      Pessoa.IE := DataSet.FieldByName('IE').AsString;
      Pessoa.RG := DataSet.FieldByName('RG').AsString;
      Pessoa.Telefone := DataSet.FieldByName('Telefone').AsString;
      Pessoa.Celular := DataSet.FieldByName('Celular').AsString;
      Pessoa.Endereco := DataSet.FieldByName('Endereco').AsString;
      Pessoa.Numero := DataSet.FieldByName('Numero').AsString;
      Pessoa.BairroId := DataSet.FieldByName('BairroId').AsInteger;
      Pessoa.Bairro := DataSet.FieldByName('Bairro').AsString;
      Pessoa.CidadeId := DataSet.FieldByName('CidadeId').AsInteger;
      Pessoa.Cidade := DataSet.FieldByName('Cidade').AsString;
      Pessoa.EstadoId := DataSet.FieldByName('EstadoId').AsInteger;
      Pessoa.EstadoAbreviatura := DataSet.FieldByName('EstadoAbreviatura').AsString;
      Pessoa.Estado := DataSet.FieldByName('Estado').AsString;
      Pessoa.Cep := DataSet.FieldByName('Cep').AsString;
      Pessoa.DescontoMaximo := DataSet.FieldByName('DescontoMaximo').AsFloat;
      Pessoa.Profissional := DataSet.FieldByName('PessoaProfissional').AsString;
      Pessoa.TabelaPreco := DataSet.FieldByName('TabelaPreco').AsFloat;
      Pessoa.PercComissao := DataSet.FieldByName('PercComissao').AsFloat;
      Pessoa.VendedorId := Dataset.FieldByName('PessoaVendedorCli').AsInteger;
    End
    else
      Pessoa.Id := 0;
  Except
    Pessoa := TPessoa.Create();
  End;
End;

class function TPessoaRepository.AutoIncremento(Database : TDatabase):Integer;
var ConexaoBanco : TConexaoBanco;
begin
  Result := 0;
  ConexaoBanco := TConexaoBanco.Create(Database);
  try
    ConexaoBanco.SQL.Add('SELECT COALESCE(MAX(P.PESSOACODIGO),0) + 1 AS ID');
    ConexaoBanco.SQL.Add('FROM PESSOA P JOIN PESSOA_EMP PE ON P.PESSOACODIGO = PE.PESSOACODIGO');
    ConexaoBanco.SQL.Add('WHERE PE.CODIGOEMP = :CODIGOEMP');
    ConexaoBanco.Param.ParamByName('CODIGOEMP').AsInteger := DataBase.CodigoEmpresa;
    Result := ConexaoBanco.DataSetFactory.GetDataSet(TConexao.Empresa, ConexaoBanco.Sql.Text, ConexaoBanco.Param).FieldByName('ID').AsInteger;
  Except
    On E : Exception do
    Begin
      TCustomExcept.Show(e, 'Erro ao tentar executar AutoIncremento');
    End;
  End;
  ConexaoBanco.Free;
end;

class function TPessoaRepository.AutoIncrementoLog(Database : TDatabase):Integer;
var ConexaoBanco : TConexaoBanco;
begin
  Result := 0;
  ConexaoBanco := TConexaoBanco.Create(Database);
  try
    ConexaoBanco.SQL.Add('SELECT COALESCE(MAX(L.CODLOG),0) + 1 AS ID');
    ConexaoBanco.SQL.Add('FROM LOGPESSOA L');
    ConexaoBanco.SQL.Add('WHERE L.CODIGOEMP = :CODIGOEMP');
    ConexaoBanco.Param.ParamByName('CODIGOEMP').AsInteger := DataBase.CodigoEmpresa;
    Result := ConexaoBanco.DataSetFactory.GetDataSet(TConexao.Empresa, ConexaoBanco.Sql.Text, ConexaoBanco.Param).FieldByName('ID').AsInteger;
  Except
    On E : Exception do
    Begin
      TCustomExcept.Show(e, 'Erro ao tentar executar AutoIncremento');
    End;
  End;
  ConexaoBanco.Free;
end;

class procedure TPessoaRepository.Gravar(Cliente : TPessoa; Database : TDatabase);
var ConexaoBanco : TConexaoBanco;
  Date : TDate;
begin
  ConexaoBanco := TConexaoBanco.Create(Database);
  try
    ConexaoBanco.SQL.Clear();
    ConexaoBanco.SQL.Add('INSERT INTO PESSOA (PESSOACODIGO, PESSOATIPO, PESSOANOME, PESSOABAIRRO, PESSOACIDADE, PESSOACPF_CNPJ,');
    ConexaoBanco.SQL.Add('PESSOATIPOPESSOA, PESSOAINSCREST_RG, PESSOABAIRROPAI, PESSOACIDADEPAI, PESSOABAIRROMAE, PESSOACIDADEMAE,');
    ConexaoBanco.SQL.Add('PESSOABAIRROTRABCONJ, PESSOACIDADETRABCONJ, PESSOABAIRROENTREGACLI, PESSOACIDADEENTREGACLI,');
    ConexaoBanco.SQL.Add('PESSOABAIRROCOBRACLI, PESSOACIDADECOBRACLI, PESSOAATIVIDADECLI, PESSOABAIRROTRABCLI, PESSOACIDADETRABCLI,');
    ConexaoBanco.SQL.Add('PESSOACARGOFUNC, CODIGOEMP, PESSOAINATIVOCLI, PESSOATIPOEMP, PESSOARETEMPISCOFINS, PESSOANATUREZARETENCAO,');
    ConexaoBanco.SQL.Add('PESSOANUMERO, PESSOATELEFONE, PESSOACELULAR, PESSOACONSUMIDORFINAL, PESSOASEXO, PESSOADATANASC, PESSOACEP,');
    ConexaoBanco.SQL.Add('PESSOAEMAIL, PESSOAGRUPOCLIENTE, PESSOAENDERECO, PESSOARG, PESSOAESTADOCIVIL)');
    ConexaoBanco.SQL.Add('VALUES (:PESSOACODIGO, :PESSOATIPO, :PESSOANOME, :PESSOABAIRRO, :PESSOACIDADE, :PESSOACPF_CNPJ,');
    ConexaoBanco.SQL.Add(':PESSOATIPOPESSOA, :PESSOAINSCREST_RG, :PESSOABAIRROPAI, :PESSOACIDADEPAI, :PESSOABAIRROMAE, :PESSOACIDADEMAE,');
    ConexaoBanco.SQL.Add(':PESSOABAIRROTRABCONJ, :PESSOACIDADETRABCONJ, :PESSOABAIRROENTREGACLI, :PESSOACIDADEENTREGACLI,');
    ConexaoBanco.SQL.Add(':PESSOABAIRROCOBRACLI, :PESSOACIDADECOBRACLI, :PESSOAATIVIDADECLI, :PESSOABAIRROTRABCLI, :PESSOACIDADETRABCLI,');
    ConexaoBanco.SQL.Add(':PESSOACARGOFUNC, :CODIGOEMP, :PESSOAINATIVOCLI, :PESSOATIPOEMP, :PESSOARETEMPISCOFINS, :PESSOANATUREZARETENCAO,');
    ConexaoBanco.SQL.Add(':PESSOANUMERO, :PESSOATELEFONE, :PESSOACELULAR, :PESSOACONSUMIDORFINAL, :PESSOASEXO, :PESSOADATANASC, :PESSOACEP,');
    ConexaoBanco.SQL.Add(':PESSOAEMAIL, :PESSOAGRUPOCLIENTE, :PESSOAENDERECO, :PESSOARG, :PESSOAESTADOCIVIL)');

    Cliente.Id := AutoIncremento(Database);
    ConexaoBanco.Param.ParamByName('PESSOACODIGO').AsInteger := Cliente.Id;
    ConexaoBanco.Param.ParamByName('PESSOATIPO').AsString:= 'C';
    ConexaoBanco.Param.ParamByName('PESSOANOME').AsString := Cliente.Nome;
    ConexaoBanco.Param.ParamByName('PESSOABAIRRO').AsInteger:= Cliente.BairroId;
    ConexaoBanco.Param.ParamByName('PESSOACIDADE').AsInteger:= Cliente.CidadeId;
    ConexaoBanco.Param.ParamByName('PESSOACPF_CNPJ').AsString:= Cliente.CpfCnpj;
    if Cliente.IsPessoaJuridica() then
    begin
      ConexaoBanco.Param.ParamByName('PESSOATIPOPESSOA').AsString := 'J';
      ConexaoBanco.Param.ParamByName('PESSOAINSCREST_RG').AsString := Cliente.IE;
      ConexaoBanco.Param.ParamByName('PESSOARG').AsString := '';
    end
    else
    begin
      ConexaoBanco.Param.ParamByName('PESSOATIPOPESSOA').AsString := 'F';
      ConexaoBanco.Param.ParamByName('PESSOAINSCREST_RG').AsString := 'NAO CONTRIBUINTE';
      ConexaoBanco.Param.ParamByName('PESSOARG').AsString := Cliente.RG;
    end;
    ConexaoBanco.Param.ParamByName('PESSOABAIRROPAI').AsInteger:= 0;
    ConexaoBanco.Param.ParamByName('PESSOACIDADEPAI').AsInteger:= 0;
    ConexaoBanco.Param.ParamByName('PESSOABAIRROMAE').AsInteger:= 0;
    ConexaoBanco.Param.ParamByName('PESSOACIDADEMAE').AsInteger:= 0;
    ConexaoBanco.Param.ParamByName('PESSOABAIRROTRABCONJ').AsInteger:= 0;
    ConexaoBanco.Param.ParamByName('PESSOACIDADETRABCONJ').AsInteger:= 0;
    ConexaoBanco.Param.ParamByName('PESSOABAIRROENTREGACLI').AsInteger:= 0;
    ConexaoBanco.Param.ParamByName('PESSOACIDADEENTREGACLI').AsInteger:= 0;
    ConexaoBanco.Param.ParamByName('PESSOABAIRROCOBRACLI').AsInteger:= 0;
    ConexaoBanco.Param.ParamByName('PESSOACIDADECOBRACLI').AsInteger:= 0;
    ConexaoBanco.Param.ParamByName('PESSOAATIVIDADECLI').AsInteger:= 1;
    ConexaoBanco.Param.ParamByName('PESSOABAIRROTRABCLI').AsInteger:= 0;
    ConexaoBanco.Param.ParamByName('PESSOACIDADETRABCLI').AsInteger:= 0;
    ConexaoBanco.Param.ParamByName('PESSOACARGOFUNC').AsInteger:= 0;
    ConexaoBanco.Param.ParamByName('CODIGOEMP').AsInteger:= Database.CodigoEmpresa;
    ConexaoBanco.Param.ParamByName('PESSOAINATIVOCLI').AsString := 'N';
    ConexaoBanco.Param.ParamByName('PESSOATIPOEMP').AsInteger:= 2;
    ConexaoBanco.Param.ParamByName('PESSOARETEMPISCOFINS').AsString := 'N';
    ConexaoBanco.Param.ParamByName('PESSOANATUREZARETENCAO').AsInteger:= 0;
    ConexaoBanco.Param.ParamByName('PESSOANUMERO').AsString := Cliente.Numero;
    ConexaoBanco.Param.ParamByName('PESSOATELEFONE').AsString := Cliente.Telefone;
    ConexaoBanco.Param.ParamByName('PESSOACELULAR').AsString:= Cliente.Celular;
    if Cliente.ConsumidorFinal then
      ConexaoBanco.Param.ParamByName('PESSOACONSUMIDORFINAL').AsString := 'S'
    else
      ConexaoBanco.Param.ParamByName('PESSOACONSUMIDORFINAL').AsString := 'N';
    ConexaoBanco.Param.ParamByName('PESSOASEXO').AsString := Cliente.Sexo;
    if Cliente.DataNasc <> Date then
      ConexaoBanco.Param.ParamByName('PESSOADATANASC').AsDatetime := Cliente.DataNasc
    else
      ConexaoBanco.Param.ParamByName('PESSOADATANASC').Value := null;
    ConexaoBanco.Param.ParamByName('PESSOACEP').AsString := Cliente.Cep;
    ConexaoBanco.Param.ParamByName('PESSOAEMAIL').AsString := Cliente.Email;
    ConexaoBanco.Param.ParamByName('PESSOAGRUPOCLIENTE').AsInteger := 0;
    ConexaoBanco.Param.ParamByName('PESSOAENDERECO').AsString := Cliente.Endereco;
    ConexaoBanco.Param.ParamByName('PESSOAESTADOCIVIL').AsString := 'O';

    ConexaoBanco.DataSetFactory.PostDataSet(TConexao.Empresa, ConexaoBanco.Sql.Text, ConexaoBanco.Param);

    ConexaoBanco.SQL.Clear();
    ConexaoBanco.SQL.Add('INSERT INTO PESSOA_EMP (PESSOACODIGO, CODIGOEMP, PESSOAPLANOPAGCLI, PESSOAVENDEDORCLI,');
    ConexaoBanco.SQL.Add('PESSOAENTREGADORCLI, PESSOACOBRADORCLI, PESSOAROTACLI,');
    ConexaoBanco.SQL.Add('PESSOATIPODEEMPRESA, PESSOATRANSPCLI)');
    ConexaoBanco.SQL.Add('VALUES (:PESSOACODIGO, :CODIGOEMP, :PESSOAPLANOPAGCLI, :PESSOAVENDEDORCLI,');
    ConexaoBanco.SQL.Add(':PESSOAENTREGADORCLI, :PESSOACOBRADORCLI, :PESSOAROTACLI,');
    ConexaoBanco.SQL.Add(':PESSOATIPODEEMPRESA, :PESSOATRANSPCLI)');

    ConexaoBanco.Param.ParamByName('PESSOACODIGO ').AsInteger := Cliente.Id;
    ConexaoBanco.Param.ParamByName('CODIGOEMP').AsInteger := Database.CodigoEmpresa;
    ConexaoBanco.Param.ParamByName('PESSOAPLANOPAGCLI ').AsInteger := 0;
    ConexaoBanco.Param.ParamByName('PESSOAVENDEDORCLI').AsInteger := Cliente.VendedorId;
    ConexaoBanco.Param.ParamByName('PESSOAENTREGADORCLI ').AsInteger := 0;
    ConexaoBanco.Param.ParamByName('PESSOACOBRADORCLI ').AsInteger := 0;
    ConexaoBanco.Param.ParamByName('PESSOAROTACLI').AsInteger := 0;
    ConexaoBanco.Param.ParamByName('PESSOATIPODEEMPRESA').AsInteger := 0;
    ConexaoBanco.Param.ParamByName('PESSOATRANSPCLI').AsInteger := 0;

    ConexaoBanco.DataSetFactory.PostDataSet(TConexao.Empresa, ConexaoBanco.Sql.Text, ConexaoBanco.Param);
  Except
    On E : Exception do
    Begin
      TCustomExcept.Show(e, 'Erro ao tentar gravar pessoa!');
    End;
  end;
  ConexaoBanco.Free;
end;

class procedure TPessoaRepository.GravarLog(Cliente : TPessoa; Database : TDatabase; Usuario : TUsuario; Cidade : TCidade);
var ConexaoBanco : TConexaoBanco;
begin
  ConexaoBanco := TConexaoBanco.Create(Database);
  try
    ConexaoBanco.SQL.Clear();
    ConexaoBanco.SQL.Add('INSERT INTO LOGPESSOA(CODLOG,DATA,HORA,USUARIO,PESSOACODIGO,PESSOATIPO,PESSOANOME,PESSOABLOQUEADO,TIPOLOG,PESSOAVENDEDORCLI,');
    ConexaoBanco.SQL.Add('PESSOANOME_ANTERIOR,PESSOABLOQUEADO_ANTERIOR,PESSOAVENDEDORCLI_ANTERIOR,CODIGOEMP,PESSOACPF_CNPJ,PESSOACODPAIS,');
    ConexaoBanco.SQL.Add('PESSOAINSCREST_RG,CODIBGECIDADE,PESSOACODSUFRAMA,PESSOAENDERECO,DESCBAIRRO,PESSOATIPOPESSOA,EXPORTOU)');
    ConexaoBanco.SQL.Add('VALUES(:CODLOG,:DATA,:HORA,:USUARIO,:PESSOACODIGO,:PESSOATIPO,:PESSOANOME,:PESSOABLOQUEADO,:TIPOLOG,:PESSOAVENDEDORCLI,');
    ConexaoBanco.SQL.Add(':PESSOANOME_ANTERIOR,:PESSOABLOQUEADO_ANTERIOR,:PESSOAVENDEDORCLI_ANTERIOR,:CODIGOEMP,:PESSOACPF_CNPJ,:PESSOACODPAIS,');
    ConexaoBanco.SQL.Add(':PESSOAINSCREST_RG,:CODIBGECIDADE,:PESSOACODSUFRAMA,:PESSOAENDERECO,:DESCBAIRRO,:PESSOATIPOPESSOA,:EXPORTOU);');

    ConexaoBanco.Param.ParamByName('CODLOG').AsInteger := AutoIncrementoLog(Database);
    ConexaoBanco.Param.ParamByName('DATA').AsDate := Date;
    ConexaoBanco.Param.ParamByName('HORA').AsDatetime := Now;
    ConexaoBanco.Param.ParamByName('USUARIO').AsString := Usuario.Nome;
    ConexaoBanco.Param.ParamByName('PESSOACODIGO').AsInteger := Cliente.Id;
    ConexaoBanco.Param.ParamByName('PESSOATIPO').AsString := 'C';
    ConexaoBanco.Param.ParamByName('PESSOANOME').AsString := Cliente.Nome;
    ConexaoBanco.Param.ParamByName('PESSOABLOQUEADO').AsString := 'N';
    ConexaoBanco.Param.ParamByName('TIPOLOG').AsString := 'I';
    ConexaoBanco.Param.ParamByName('PESSOAVENDEDORCLI').AsInteger := Cliente.VendedorId;
    ConexaoBanco.Param.ParamByName('PESSOANOME_ANTERIOR').AsString := Cliente.Nome;
    ConexaoBanco.Param.ParamByName('PESSOABLOQUEADO_ANTERIOR').AsString := 'N';
    ConexaoBanco.Param.ParamByName('PESSOAVENDEDORCLI_ANTERIOR').AsInteger := Cliente.VendedorId;
    ConexaoBanco.Param.ParamByName('CODIGOEMP').AsInteger := Database.CodigoEmpresa;
    ConexaoBanco.Param.ParamByName('PESSOACPF_CNPJ').AsString := Cliente.CpfCnpj;
    ConexaoBanco.Param.ParamByName('PESSOACODPAIS').AsInteger := 1058;
    ConexaoBanco.Param.ParamByName('PESSOAINSCREST_RG').AsString := Cliente.IE;
    ConexaoBanco.Param.ParamByName('CODIBGECIDADE').AsInteger := Cidade.Ibge;
    ConexaoBanco.Param.ParamByName('PESSOACODSUFRAMA').AsString := '';
    ConexaoBanco.Param.ParamByName('PESSOAENDERECO').AsString := Cliente.Endereco;
    ConexaoBanco.Param.ParamByName('DESCBAIRRO').AsString := Cliente.Bairro;
    if Cliente.IsPessoaJuridica then
      ConexaoBanco.Param.ParamByName('PESSOATIPOPESSOA').AsString := 'J'
    else
      ConexaoBanco.Param.ParamByName('PESSOATIPOPESSOA').AsString := 'F';
    ConexaoBanco.Param.ParamByName('EXPORTOU').AsString := 'N';

    ConexaoBanco.DataSetFactory.PostDataSet(TConexao.Empresa, ConexaoBanco.Sql.Text, ConexaoBanco.Param);
  Except
    On E : Exception do
    Begin
      TCustomExcept.Show(e, 'Erro ao tentar gravar pessoa!');
    End;
  end;
  ConexaoBanco.Free;
end;

end.
