unit UsuarioService;

interface

Uses
  System.SysUtils,
  DataBase,
  Usuario,
  UsuarioRepository,
  PermissaoUsuario,
  CustomMessage,
  CustomExcept;

Type TUsuarioService = Class abstract
  Private

  Public
    Class Function VerificaPermissao(DataBase : TDataBase; Usuario : TUsuario; Permissao : String; TipoPermissao : TPermissaoUsuario = Generica):Boolean;
    Class Function VerificaUsuario(DataBase : TDataBase; Usuario : TUsuario):Boolean;

End;

implementation

Class Function TUsuarioService.VerificaPermissao(DataBase : TDataBase; Usuario : TUsuario; Permissao : String; TipoPermissao : TPermissaoUsuario = Generica):Boolean;
Begin
  Result := False;
  Try
    FrPermissaoUsuario := TFrPermissaoUsuario.Create(Nil, DataBase, Usuario, Permissao, TipoPermissao);
    if (not FrPermissaoUsuario.Autorizado) then
      FrPermissaoUsuario.ShowModal();
    Result := FrPermissaoUsuario.Autorizado;
    FrPermissaoUsuario.Release();
  Except
    On e : Exception do
    Begin
      TCustomExcept.Show(e, 'Erro ao Verificar Permissão.');
    End;
  End;
End;

Class Function TUsuarioService.VerificaUsuario(DataBase : TDataBase; Usuario : TUsuario):Boolean;
Begin
  Result := False;
  Try
  Result := TUsuarioRepository.VerificaUsuario(Usuario, DataBase);
    if (Not Result) then
      TCustomMessage.Show('Usuario ou senha inválida!','Atenção', TTypeMessage.Exclamation, TButtons.Ok);
  Except
    On e : Exception do
    Begin
      TCustomExcept.Show(e, 'Erro ao verificar usuario.');
    End;
  End;
End;

end.
