unit Cidade;

interface

uses
  BoundObject;

type TCidade = Class(TBoundObject)
  Private
    _Id : Integer;
    _Nome : String;
    _EstadoId : Integer;
    _Estado : String;
    _IBGE : Integer;
    _SiglaEstado : String;

    procedure SetId(Id : Integer);
    procedure SetNome(Nome : String);
    procedure SetEstadoId(EstadoId : Integer);
    procedure SetEstado(Estado : String);
    procedure SetIBGE(Ibge : Integer);
    procedure SetSiglaEstado(SiglaEstado : String);

    procedure LimpaObjeto();

  public
    property Id : Integer Read _Id Write SetId;
    property Nome : String read _Nome Write SetNome;
    property EstadoId : Integer Read _EstadoId Write SetEstadoId;
    property Estado : String Read _Estado Write SetEstado;
    property Ibge : Integer Read _IBGE Write SetIbge;
    property SiglaEstado : String Read _SiglaEstado Write SetSiglaEstado;

    Constructor Create();

End;

implementation

Constructor TCidade.Create();
begin
  Inherited Create();
end;

procedure TCidade.LimpaObjeto();
begin
  SetId(0);
  SetNome('');
  SetEstadoId(0);
  SetEstado('');
  SetIbge(0);
  SetSiglaEstado('');
end;

procedure TCidade.SetId(Id: Integer);
begin
  if (_Id <> Id) then
  begin
    _Id := Id;

    if _Id = 0 then
      LimpaObjeto();
  end;
end;

procedure TCidade.SetNome(Nome : String);
begin
  if (_Nome <> Nome) then
    _Nome := Nome;
end;

procedure TCidade.SetEstadoId(EstadoId : Integer);
begin
  if _EstadoId <> EstadoId then
    _EstadoId := EstadoId;
end;

procedure TCidade.SetEstado(Estado : String);
begin
  if _Estado <> Estado then
    _Estado := Estado;
end;

procedure TCidade.SetIbge(Ibge : Integer);
begin
  if _Ibge <> Ibge then
    _Ibge := Ibge;
end;

procedure TCidade.SetSiglaEstado(SiglaEstado : String);
begin
  if _SiglaEstado <> SiglaEstado then
    _SiglaEstado := SiglaEstado;
end;


end.
