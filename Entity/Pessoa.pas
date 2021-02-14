unit Pessoa;

interface
Uses
  BoundObject,
  Mascara, Variants;

Type TPessoa = Class(TBoundObject)
  Private
    _Id : Integer;
    _Nome : String;
    _CpfCnpj : String;
    _IE : String;
    _RG : String;
    _Telefone : String;
    _Celular : String;
    _Endereco : String;
    _Numero : String;
    _BairroId : Integer;
    _Bairro : String;
    _CidadeId : Integer;
    _Cidade : String;
    _EstadoId : Integer;
    _EstadoAbreviatura : String;
    _Estado : String;
    _Cep : String;
    _DescontoMaximo : Double;
    _Profissional : String;
    _TabelaPreco : Double;
    _PercComissao : Double;
    _ConsumidorFinal : Boolean;
    _Sexo : String;
    _DataNasc : TDate;
    _Email : String;
    _VendedorId : Integer;

    {$Region 'SetBinding'}
    Procedure SetId(Id : Integer);
    Procedure SetNome(Nome : String);
    Procedure SetCpfCnpj(CpfCnpj : String);
    Procedure SetIE(IE : String);
    Procedure SetRG(RG : String);
    Procedure SetTelefone(Telefone : String);
    Procedure SetCelular(Celular : String);
    Procedure SetEndereco(Endereco : String);
    Procedure SetNumero(Numero : String);
    Procedure SetBairroId(BairroId : Integer);
    Procedure SetBairro(Bairro : String);
    Procedure SetCidadeId(CidadeId : Integer);
    Procedure SetCidade(Cidade : String);
    Procedure SetEstadoId(EstadoId : Integer);
    Procedure SetEstadoAbreviatura(EstadoAbreviatura : String);
    Procedure SetEstado(Estado : String);
    Procedure SetCep(Cep : String);
    Procedure SetDescontoMaximo(DescontoMaximo : Double);
    Procedure SetProfissional(Profissional : String);
    Procedure SetTabelaPreco(TabelaPreco : Double);
    Procedure SetPercComissao(PercComissao : Double);
    procedure SetConsumidorFinal(ConsumidorFinal : Boolean);
    procedure SetSexo(Sexo : String);
    procedure SetDataNasc(DataNasc : TDate);
    procedure SetEmail(Email : String);
    procedure SetVendedorId(VendedorId : Integer);
    {$EndRegion}

    Function GetCpfCnpjMarcara():String;
    function GetCpfCnpj():String;

    Procedure LimpaObjeto();

  Public
    Property Id : Integer Read _Id Write SetId;
    Property Nome : String Read _Nome Write SetNome;
    Property CpfCnpj : String Read GetCpfCnpj Write SetCpfCnpj;
    Property IE : String Read _IE Write SetIE;
    Property RG : String Read _RG Write SetRG;
    Property Telefone : String Read _Telefone Write SetTelefone;
    Property Celular : String Read _Celular Write SetCelular;
    Property Endereco : String Read _Endereco Write SetEndereco;
    Property Numero : String Read _Numero Write SetNumero;
    Property BairroId : Integer Read _BairroId Write SetBairroId;
    Property Bairro : String Read _Bairro Write SetBairro;
    Property CidadeId : Integer Read _CidadeId Write SetCidadeId;
    Property Cidade : String Read _Cidade Write SetCidade;
    Property EstadoId : Integer Read _EstadoId Write SetEstadoId;
    Property EstadoAbreviatura : String Read _EstadoAbreviatura Write SetEstadoAbreviatura;
    Property Estado : String Read _Estado Write SetEstado;
    Property Cep : String Read _Cep Write SetCep;
    Property DescontoMaximo : Double Read _DescontoMaximo Write SetDescontoMaximo;
    Property Profissional : String Read _Profissional Write SetProfissional;
    Property TabelaPreco : Double Read _TabelaPreco Write SetTabelaPreco;
    Property PercComissao : Double Read _PercComissao Write SetPercComissao;
    Property ConsumidorFinal : Boolean Read _ConsumidorFinal write SetConsumidorFinal;
    Property Sexo : String Read _Sexo Write SetSexo;
    Property DataNasc : TDate Read _DataNasc Write SetDataNasc;
    Property Email : String Read _Email Write SetEmail;
    Property VendedorId : Integer Read _VendedorId Write SetVendedorId;

    Function GetEnderecoCompleto():String;
    Function IsPessoaJuridica():Boolean;

    Constructor Create();

End;

implementation

Constructor TPessoa.Create();
Begin
  Inherited Create();
End;


{$Region 'SetBinding'}
Procedure TPessoa.SetId(Id : Integer);
Begin
  if (_Id <> Id) then
  Begin
    _Id := Id;
    Notify('Id');

    if _Id = 0 then
      LimpaObjeto();
  End;
End;

Procedure TPessoa.SetNome(Nome : String);
Begin
  if (_Nome <> Nome) then
  Begin
    _Nome := Nome;
    Notify('Nome');
  End;
End;

Procedure TPessoa.SetConsumidorFinal(ConsumidorFinal : Boolean);
Begin
  if (_ConsumidorFinal <> ConsumidorFinal) then
  Begin
    _ConsumidorFinal := ConsumidorFinal;
  End;
End;

Procedure TPessoa.SetSexo(Sexo : String);
Begin
  if (_Sexo <> Sexo) then
  Begin
    _Sexo := Sexo;
  End;
End;

Procedure TPessoa.SetDataNasc(DataNasc : TDate);
Begin
  if (_DataNasc <> DataNasc) then
  Begin
    _DataNasc := DataNasc;
  End;
End;

Procedure TPessoa.SetEmail(Email : String);
Begin
  if (_Email <> Email) then
  Begin
    _Email := Email;
  End;
End;

Procedure TPessoa.SetVendedorId(VendedorId : Integer);
Begin
  if (_VendedorId <> VendedorId) then
  Begin
    _VendedorId := VendedorId;
  End;
End;

Procedure TPessoa.SetCpfCnpj(CpfCnpj : String);
Begin
  if (_CpfCnpj <> CpfCnpj) then
  Begin
    _CpfCnpj := CpfCnpj;
    Notify('CpfCnpj');
  End;
End;

Procedure TPessoa.SetIE(IE : String);
Begin
  if (_IE <> IE) then
  Begin
    _IE := IE;
    Notify('IE');
  End;
End;

Procedure TPessoa.SetRG(RG : String);
Begin
  if (_RG <> RG) then
  Begin
    _RG := RG;
    Notify('RG');
  End;
End;

Procedure TPessoa.SetTelefone(Telefone : String);
Begin
  if (_Telefone <> Telefone) then
  Begin
    _Telefone := Telefone;
    Notify('Telefone');
  End;
End;

Procedure TPessoa.SetCelular(Celular : String);
Begin
  if (_Celular <> Celular) then
  Begin
    _Celular := Celular;
    Notify('Celular');
  End;
End;

Procedure TPessoa.SetEndereco(Endereco : String);
Begin
  if (_Endereco <> Endereco) then
  Begin
    _Endereco := Endereco;
    Notify('Endereco');
  End;
End;

Procedure TPessoa.SetNumero(Numero : String);
Begin
  if (_Numero <> Numero) then
  Begin
    _Numero := Numero;
    Notify('Numero');
  End;
End;

Procedure TPessoa.SetBairroId(BairroId : Integer);
Begin
  if (_BairroId <> BairroId) then
  Begin
    _BairroId := BairroId;
    Notify('BairroId');
  End;
End;

Procedure TPessoa.SetBairro(Bairro : String);
Begin
  if (_Bairro <> Bairro) then
  Begin
    _Bairro := Bairro;
    Notify('Bairro');
  End;
End;

Procedure TPessoa.SetCidadeId(CidadeId : Integer);
Begin
  if (_CidadeId <> CidadeId) then
  Begin
    _CidadeId := CidadeId;
    Notify('CidadeId');
  End;
End;

Procedure TPessoa.SetCidade(Cidade : String);
Begin
  if (_Cidade <> Cidade) then
  Begin
    _Cidade := Cidade;
    Notify('Cidade');
  End;
End;

Procedure TPessoa.SetEstadoId(EstadoId : Integer);
Begin
  if (_EstadoId <> EstadoId) then
  Begin
    _EstadoId := EstadoId;
    Notify('EstadoId');
  End;
End;

Procedure TPessoa.SetEstadoAbreviatura(EstadoAbreviatura : String);
Begin
  if (_EstadoAbreviatura <> EstadoAbreviatura) then
  Begin
    _EstadoAbreviatura := EstadoAbreviatura;
    Notify('EstadoAbreviatura');
  End;
End;

Procedure TPessoa.SetEstado(Estado : String);
Begin
  if (_Estado <> Estado) then
  Begin
    _Estado := Estado;
    Notify('Estado');
  End;
End;

Procedure TPessoa.SetCep(Cep : String);
Begin
  if (_Cep <> Cep) then
  Begin
    _Cep := Cep;
    Notify('Cep');
  End;
End;

Procedure TPessoa.SetDescontoMaximo(DescontoMaximo : Double);
Begin
  if (_DescontoMaximo <> DescontoMaximo) then
  Begin
    _DescontoMaximo := DescontoMaximo;
    Notify('DescontoMaximo');
  End;
End;

Procedure TPessoa.SetProfissional(Profissional : String);
Begin
  if (_Profissional <> Profissional) then
  Begin
    _Profissional := Profissional;
    Notify('Profissional');
  End;
End;

Procedure TPessoa.SetTabelaPreco(TabelaPreco : Double);
Begin
  if (_TabelaPreco <> TabelaPreco) then
  Begin
    _TabelaPreco := TabelaPreco;
    Notify('TabelaPreco');
  End;
End;

Procedure TPessoa.SetPercComissao(PercComissao : Double);
Begin
  if (_PercComissao <> PercComissao) then
  Begin
    _PercComissao := PercComissao;
    Notify('PercComissao');
  End;
End;

{$EndRegion}

{$Region 'Get'}
Function TPessoa.GetCpfCnpjMarcara():String;
Begin
  Result := TMascara.AplicaCpfCnpj(_CpfCnpj);
End;

Function TPessoa.GetCpfCnpj():String;
Begin
  Result := _CpfCnpj;
End;

Function TPessoa.GetEnderecoCompleto():String;
Begin
  Result := _Endereco
            + ', ' + _Numero
            + ', ' + _Bairro
            + ', ' + _Cidade
            + ' - ' + _EstadoAbreviatura
            + ' - ' + _Cep;
End;

Function TPessoa.IsPessoaJuridica():Boolean;
Begin
  if (Length(_CpfCnpj)=14) then
    Result := True
  else
    Result := False;
End;
{$EndRegion}

Procedure TPessoa.LimpaObjeto();
Begin
  SetNome('');
  SetCpfCnpj('');
  SetIE('');
  SetRG('');
  SetTelefone('');
  SetCelular('');
  SetEndereco('');
  SetNumero('');
  SetBairroId(0);
  SetBairro('');
  SetCidadeId(0);
  SetCidade('');
  SetEstadoId(0);
  SetEstadoAbreviatura('');
  SetEstado('');
  SetCep('');
  SetDescontoMaximo(0);
  SetProfissional('');
  SetTabelaPreco(0);
  SetPercComissao(0);
  SetConsumidorFinal(False);
  SetSexo('');
  SetVendedorId(0);
  SetDataNasc(Null);
  SetEmail('');
End;

end.
