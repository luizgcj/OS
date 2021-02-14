unit Empresa;

interface
Uses
 BoundObject,
 System.SysUtils,
 System.StrUtils;

Type TEmpresa = Class(TBoundObject)
  Private
    _Cnpj : String;
    _Nome : String;
    _Endereco : String;
    _Numero : String;
    _Complemento : String;
    _Bairro : String;
    _Cidade : String;
    _Uf : String;
    _Cep : String;
    _Telefone : String;
    _Fax : String;

    {$Region 'Set'}
    Procedure SetCnpj(Cnpj : string);
    Procedure SetNome(Nome : string);
    Procedure SetEndereco(Endereco : string);
    Procedure SetNumero(Numero : string);
    Procedure SetComplemento(Complemento : string);
    Procedure SetBairro(Bairro : string);
    Procedure SetCidade(Cidade : string);
    Procedure SetUf(Uf : string);
    Procedure SetCep(Cep : string);
    Procedure SetTelefone(Telefone : string);
    Procedure SetFax(Fax : String);
    {$EndRegion}

    Function GetEnderecoCompleto():String;
  Public
    Property Cnpj : String Read _Cnpj Write SetCnpj;
    Property Nome : String Read _Nome Write SetNome;
    Property Endereco : String Read _Endereco Write SetEndereco;
    Property Numero : String Read _Numero Write SetNumero;
    Property Complemento : String Read _Complemento Write SetComplemento;
    Property Bairro : String Read _Bairro Write SetBairro;
    Property Cidade : String Read _Cidade Write SetCidade;
    Property Uf : String Read _Uf Write SetUf;
    Property Cep : String Read _Cep Write SetCep;
    Property Telefone : String Read _Telefone Write SetTelefone;
    Property Fax : String Read _Fax Write SetFax;
    Property EnderecoCompleto : String Read GetEnderecoCompleto;

End;

implementation

{$Region 'Set'}
Procedure TEmpresa.SetCnpj(Cnpj : string);
Begin
  if (Cnpj <>_Cnpj) then
  Begin
    _Cnpj := Cnpj;
    Notify('Cnpj');
  End;
End;

Procedure TEmpresa.SetNome(Nome : string);
Begin
  if (Nome <> _Nome) then
  Begin
    _Nome := Nome;
    Notify('Nome');
  End;
End;

Procedure TEmpresa.SetEndereco(Endereco : string);
Begin
  if (Endereco <> _Endereco) then
  Begin
    _Endereco := Endereco;
    Notify('Endereco');
  End;
End;

Procedure TEmpresa.SetNumero(Numero : string);
Begin
  if (Numero <> _Numero) then
  Begin
    _Numero := Numero;
    Notify('Numero');
  End;
End;

Procedure TEmpresa.SetComplemento(Complemento : string);
Begin
  if (complemento <> _Complemento) then
  Begin
    _Complemento := Complemento;
    Notify('Complemento');
  End;
End;

Procedure TEmpresa.SetBairro(Bairro : string);
Begin
  if (Bairro <> _Bairro) then
  Begin
    _Bairro := Bairro;
    Notify('Bairro');
  End;
End;

Procedure TEmpresa.SetCidade(Cidade : string);
Begin
  if (Cidade <> _Cidade) then
  Begin
    _Cidade := Cidade;
    Notify('Cidade');
  End;
End;

Procedure TEmpresa.SetUf(Uf : string);
Begin
  if (Uf <> _Uf) then
  Begin
    _Uf := Uf;
    Notify('Uf');
  End;
End;

Procedure TEmpresa.SetCep(Cep : string);
Begin
  if (Cep <>_Cep) then
  Begin
    _Cep := Cep;
    Notify('Cep');
  End;
End;

Procedure TEmpresa.SetTelefone(Telefone : string);
Begin
  if (Telefone <> _Telefone) then
  Begin
    _Telefone := Telefone;
    Notify('Telefone');
  End;
End;

Procedure TEmpresa.SetFax(Fax : String);
Begin
  if (Fax <> _Fax) then
  Begin
    _Fax := Fax;
    Notify('Fax');
  End;
End;
{$EndRegion}

Function TEmpresa.GetEnderecoCompleto():String;
var
  complementoAux : string;
Begin
  complementoAux := ifThen(Trim(_Complemento) <> '', ', '+_Complemento, '');

  Result := _Endereco
            + ', ' + _Numero
            + complementoAux
            + ', ' + _Bairro
            + ', ' + _Cidade
            + ' - ' + _Uf
            + ' - ' + _Cep;
End;

end.
