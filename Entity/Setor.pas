unit Setor;

interface
Uses
  BoundObject,
  Mascara;

Type TSetor = Class(TBoundObject)
  Private
    _Id : Integer;
    _Nome : String;
    _Studio : Boolean;


    {$Region 'SetBinding'}
    Procedure SetId(Id : Integer);
    Procedure SetNome(Nome : String);
    Procedure SetStudio(Studio : Boolean);
    {$EndRegion}

    Procedure LimpaObjeto();

  Public
    Property Id : Integer Read _Id Write SetId;
    Property Nome : String Read _Nome Write SetNome;
    Property Studio : Boolean Read _Studio Write SetStudio;


    Constructor Create();

End;

implementation

Constructor TSetor.Create();
Begin
  Inherited Create();
End;


{$Region 'SetBinding'}
Procedure TSetor.SetId(Id : Integer);
Begin
  if (_Id <> Id) then
  Begin
    _Id := Id;
    Notify('Id');

    if _Id = 0 then
      LimpaObjeto();
  End;
End;

Procedure TSetor.SetNome(Nome : String);
Begin
  if (_Nome <> Nome) then
  Begin
    _Nome := Nome;
    Notify('Nome');
  End;
End;

Procedure TSetor.SetStudio(Studio : Boolean);
Begin
  if (_Studio <> Studio) then
  Begin
    _Studio := Studio;
    Notify('Studio');
  End;
End;
{$EndRegion}

{$Region 'Get'}

{$EndRegion}

Procedure TSetor.LimpaObjeto();
Begin
  SetNome('');
  SetStudio(False);
End;

end.
