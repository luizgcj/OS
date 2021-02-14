unit FormaPagamento;

interface

Uses
  BoundObject;

Type TFormaPagamento = Class(TBoundObject)
  Private
    _Id : Integer;
    _Nome : String;
    _Cartao : String;
    _Cheque : String;
    _EnviaMaisCaixa : String;
    _BaixaAutomatica : Boolean;


    {$Region 'Set'}
    Procedure SetId(Id : Integer);
    Procedure SetNome(Nome : String);
    Procedure SetCartao(Cartao : String);
    Procedure SetCheque(ECheque : String);
    Procedure SetEnviaMaisCaixa(EnviaMaisCaixa : String);
    Procedure SetBaixaAutomatica(BaixaAutomatica : Boolean);

    {$EndRegion}

    Procedure LimpaObjeto();
  Public

    Property Id : Integer Read _Id Write SetId;
    Property Nome : string Read _Nome Write SetNome;
    Property Cartao : String Read _Cartao Write SetCartao;
    Property Cheque : String  Read _Cheque Write SetCheque;
    Property EnviaMaisCaixa : String Read _EnviaMaisCaixa Write SetEnviaMaisCaixa;
    Property BaixaAutomatica : Boolean Read _BaixaAutomatica Write SetBaixaAutomatica;

End;

implementation

{$Region 'Set'}
Procedure TFormaPagamento.SetId(Id : Integer);
Begin
  if (_Id <> Id) then
  Begin
    _Id := Id;
    Notify('Id');
    if (_Id = 0) then
      LimpaObjeto();
  End;
End;

Procedure TFormaPagamento.SetNome(Nome : String);
Begin
  if (_Nome <> Nome) then
  Begin
    _Nome := Nome;
    Notify('Nome');
  End;
End;

Procedure TFormaPagamento.SetCartao(Cartao : String);
Begin
  if (_Cartao <> Cartao) then
  Begin
    _Cartao := Cartao;
    Notify('Cartao');
  End;
End;

Procedure TFormaPagamento.SetCheque(ECheque : String);
Begin
  if (_Cheque <> Cheque) then
  Begin
    _Cheque := Cheque;
    Notify('Cheque');
  End;
End;

Procedure TFormaPagamento.SetEnviaMaisCaixa(EnviaMaisCaixa : String);
Begin
  if (_EnviaMaisCaixa <> EnviaMaisCaixa) then
  Begin
    _EnviaMaisCaixa := EnviaMaisCaixa;
    Notify('EnviaMaisCaixa');
  End;
End;

Procedure TFormaPagamento.SetBaixaAutomatica(BaixaAutomatica : Boolean);
begin
  if _BaixaAutomatica <> BaixaAutomatica then
    _BaixaAutomatica := BaixaAutomatica;
end;
{$EndRegion}

Procedure TFormaPagamento.LimpaObjeto();
Begin
  SetNome('');
  SetCartao('');
  SetCheque('');
  SetEnviaMaisCaixa('');
  SetBaixaAutomatica(false);
End;

end.

