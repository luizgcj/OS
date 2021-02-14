unit PlanoPagamento;

interface

Uses
  BoundObject;

Type TPlanoPagamento = Class(TBoundObject)
  Private
    _Id : Integer;
    _Nome : String;
    _Desdobramento : String;
    _Parcelas : Integer;


    {$Region 'Set'}
    Procedure SetId(Id : Integer);
    Procedure SetNome(Nome : String);
    Procedure SetDesdobramento(Desdobramento : String);
    Procedure SetParcelas(Parcelas : Integer);
    {$EndRegion}

    Procedure LimpaObjeto();
  Public

    Property Id : Integer Read _Id Write SetId;
    Property Nome : string Read _Nome Write SetNome;
    Property Desdobramento : String Read _Desdobramento Write SetDesdobramento;
    Property Parcelas : Integer  Read _Parcelas Write SetParcelas;


End;

implementation

{$Region 'Set'}
Procedure TPlanoPagamento.SetId(Id : Integer);
Begin
  if (_Id <> Id) then
  Begin
    _Id := Id;
    Notify('Id');
    if (_Id = 0) then
      LimpaObjeto();
  End;
End;

Procedure TPlanoPagamento.SetNome(Nome : String);
Begin
  if (_Nome <> Nome) then
  Begin
    _Nome := Nome;
    Notify('Nome');
  End;
End;

Procedure TPlanoPagamento.SetDesdobramento(Desdobramento : String);
Begin
  if (_Desdobramento <> Desdobramento) then
  Begin
    _Desdobramento := Desdobramento;
    Notify('Desdobramento');
  End;
End;

Procedure TPlanoPagamento.SetParcelas(Parcelas : Integer);
Begin
  if (_Parcelas <> Parcelas) then
  Begin
    _Parcelas := Parcelas;
    Notify('Parcelas');
  End;
End;
{$EndRegion}

Procedure TPlanoPagamento.LimpaObjeto();
Begin
  SetNome('');
  SetDesdobramento('');
  SetParcelas(0);
End;

end.
