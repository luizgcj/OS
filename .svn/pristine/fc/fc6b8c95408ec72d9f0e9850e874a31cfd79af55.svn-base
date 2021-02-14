unit Usuario;

interface

Uses
  BoundObject;

Type TUsuario = Class(TBoundObject)

  Private
    _Nome : String;
    _Senha : String;
    _Master : Boolean;
    _Interno : Boolean;
    _CodigoEmpresaPadrao : Integer;

    Procedure SetNome(Nome :String);
    Procedure SetSenha(Senha :String);

    Procedure LimparUsuario();
  Public
    Property Nome : String Read _Nome Write SetNome;
    Property Senha : String Read _Senha Write SetSenha;

    Property CodigoEmpresaPadrao : Integer Read _CodigoEmpresaPadrao Write _CodigoEmpresaPadrao;
    Property Master : Boolean Read _Master Write _Master;
    Property Interno : Boolean Read _Interno;

    Constructor Create(Nome : String = ''; Senha :String = '');Overload;
    Constructor Create(Usuario : TUsuario);Overload;

  const
    cNome = 'SUPORTE@MAIS';
    cSenha = 'MSOL@0027';
End;

implementation

Constructor TUsuario.Create(Nome : String = ''; Senha :String = '');
Begin
  Inherited Create();
  SetNome(Nome);
  SetSenha(Senha);
End;

Constructor TUsuario.Create(Usuario : TUsuario);
Begin
  Self.Create(Usuario.Nome, Usuario.Senha);
  Self._Master := Usuario.Master;
  Self._Interno := Usuario.Interno;
  Self._CodigoEmpresaPadrao := Usuario.CodigoEmpresaPadrao;
End;

Procedure TUsuario.SetNome(Nome :String);
Begin
  if (_Nome <> Nome) then
  Begin
    _Nome := Nome;
    Notify('Nome');
    _Interno := (_Nome = cNome);
    if (_Nome = '') then
      LimparUsuario();
  End;
End;

Procedure TUsuario.SetSenha(Senha :String);
Begin
  if (_Senha <> Senha) then
  Begin
    _Senha := Senha;
    Notify('Senha');
  End;
End;

Procedure TUsuario.LimparUsuario();
Begin
  SetSenha('');
  _Interno := false;
  _master := false;
  _CodigoEmpresaPadrao := 0;
End;


end.
