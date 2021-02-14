unit Bairro;

interface

uses
  BoundObject;

type TBairro = Class(TBoundObject)
  Private
    _Id : Integer;
    _Nome : String;
    _CodigoEmp : Integer;

    procedure SetId(Id : Integer);
    procedure SetNome(Nome : String);
    procedure SetCodigoEmp(Codigoemp : Integer);

    procedure LimpaObjeto();

  public
    property Id : Integer Read _Id Write SetId;
    property Nome : String read _Nome Write SetNome;
    property CodigoEmp : Integer read _CodigoEmp Write SetCodigoEmp;

    Constructor Create();

End;

implementation

Constructor TBairro.Create();
begin
  Inherited Create();
end;

procedure TBairro.LimpaObjeto();
begin
  SetId(0);
  SetNome('');
  SetCodigoEmp(0);
end;

procedure TBairro.SetId(Id: Integer);
begin
  if (_Id <> Id) then
  begin
    _Id := Id;

    if _Id = 0 then
      LimpaObjeto();
  end;
end;

procedure TBairro.SetNome(Nome : String);
begin
  if (_Nome <> Nome) then
    _Nome := Nome;
end;

procedure TBairro.SetCodigoEmp(CodigoEmp : Integer);
begin
  if _CodigoEmp <> CodigoEmp then
    _CodigoEmp := CodigoEmp;
end;

end.
