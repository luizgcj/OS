unit Produto;

interface

Uses
  BoundObject;

Type TProduto = Class(TBoundObject)
  Private
    _Id : Integer;
    _Nome : String;
    _Tipo : String;
    _ValorUnitario : Double;
    _ValorUnitarioAmador : Double;
    _ValorUnitarioProfissional : Double;
    _Estoque : Double;
    _QuantidadeEmbalagem : Double;
    _UnidadeId : Integer;
    _Unidade : String;
    _Decimais : Integer;

    {$Region 'Set'}
    Procedure SetId(Id : Integer);
    Procedure SetNome(Nome : String);
    Procedure SetTipo(Tipo : String);
    Procedure SetValorUnitario(ValorUnitario : Double);
    Procedure SetValorUnitarioAmador(ValorUnitarioAmador : Double);
    Procedure SetValorUnitarioProfissional(ValorUnitarioProfissional : Double);
    Procedure SetEstoque(Estoque : Double);
    Procedure SetQuantidadeEmbalagem(QuantidadeEmbalagem : Double);
    Procedure SetUnidadeId(UnidadeId : Integer);
    Procedure SetUnidade(Unidade : String);
    Procedure SetDecimais(Decimais : Integer);
    {$EndRegion}

    Procedure LimpaObjeto();
  Public

    Property Id : Integer Read _Id Write SetId;
    Property Nome : string Read _Nome Write SetNome;
    Property Tipo : string Read _Tipo Write SetTipo;
    Property ValorUnitario : Double Read _ValorUnitario Write SetValorUnitario;
    Property ValorUnitarioAmador : Double Read _ValorUnitarioAmador Write SetValorUnitarioAmador;
    Property ValorUnitarioProfissional : Double Read _ValorUnitarioProfissional Write SetValorUnitarioProfissional;
    Property Estoque : Double Read _Estoque Write SetEstoque;
    Property QuantidadeEmbalagem : Double  Read _QuantidadeEmbalagem Write SetQuantidadeEmbalagem;
    Property UnidadeId : Integer Read _UnidadeId Write SetUnidadeId;
    Property Unidade : string Read _Unidade Write SetUnidade;
    Property Decimais : Integer Read _Decimais Write SetDecimais;

End;

implementation

{$Region 'Set'}
Procedure TProduto.SetId(Id : Integer);
Begin
  if (_Id <> Id) then
  Begin
    _Id := Id;
    Notify('Id');
    if (_Id = 0) then
      LimpaObjeto();
  End;
End;

Procedure TProduto.SetNome(Nome : String);
Begin
  if (_Nome <> Nome) then
  Begin
    _Nome := Nome;
    Notify('Nome');
  End;
End;

Procedure TProduto.SetTipo(Tipo : String);
Begin
  if (_Tipo <> Tipo) then
  Begin
    _Tipo := Tipo;
    Notify('Tipo');
  End;
End;

Procedure TProduto.SetValorUnitario(ValorUnitario : Double);
Begin
  if (_ValorUnitario <> ValorUnitario) then
  Begin
    _ValorUnitario := ValorUnitario;
    Notify('ValorUnitario');
  End;
End;

Procedure TProduto.SetValorUnitarioAmador(ValorUnitarioAmador : Double);
Begin
  if (_ValorUnitarioAmador <> ValorUnitarioAmador) then
  Begin
    _ValorUnitarioAmador := ValorUnitarioAmador;
    Notify('ValorUnitarioAmador');
  End;
End;

Procedure TProduto.SetValorUnitarioProfissional(ValorUnitarioProfissional : Double);
Begin
  if (_ValorUnitarioProfissional <> ValorUnitarioProfissional) then
  Begin
    _ValorUnitarioProfissional := ValorUnitarioProfissional;
    Notify('ValorUnitarioProfissional');
  End;
End;

Procedure TProduto.SetEstoque(Estoque : Double);
Begin
  if (_Estoque <> Estoque) then
  Begin
    _Estoque := Estoque;
    Notify('Estoque');
  End;
End;

Procedure TProduto.SetQuantidadeEmbalagem(QuantidadeEmbalagem : Double);
Begin
  if (_QuantidadeEmbalagem <> QuantidadeEmbalagem) then
  Begin
    _QuantidadeEmbalagem := QuantidadeEmbalagem;
    Notify('QuantidadeEmbalagem');
  End;
End;

Procedure TProduto.SetUnidadeId(UnidadeId : Integer);
Begin
  if (_UnidadeId <> UnidadeId) then
  Begin
    _UnidadeId := UnidadeId;
    Notify('UnidadeId');
  End;
End;

Procedure TProduto.SetUnidade(Unidade : String);
Begin
  if (_Unidade <> Unidade) then
  Begin
    _Unidade := Unidade;
    Notify('Unidade');
  End;
End;

Procedure TProduto.SetDecimais(Decimais : Integer);
Begin
  if (_Decimais <> Decimais) then
  Begin
    _Decimais := Decimais;
    Notify('Decimais');
  End;
End;

{$EndRegion}

Procedure TProduto.LimpaObjeto();
Begin
  SetNome('');
  SetTipo('');
  SetValorUnitario(0);
  SetValorUnitarioAmador(0);
  SetValorUnitarioProfissional(0);
  SetQuantidadeEmbalagem(0);
  SetUnidadeId(0);
  SetUnidade('');
  SetDecimais(0);
End;

end.
