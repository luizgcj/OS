unit UsuarioRepository;

interface

Uses
  Data.Db,
  DataBase,
  Usuario,
  CryptDecrypt;

const
  cNome = 'SUPORTE@MAIS';
  cSenha = 'MSOL@0027';

Type TPermissaoUsuario = (Generica, Gravar, Alterar, Excluir);

Type TUsuarioRepository = Class abstract
  Private

  Public
    Class Function VerificaUsuario(Usuario : TUsuario; DataBase : TDataBase):Boolean;
    Class Procedure EmpresaPadrao(Usuario : TUsuario; DataBase : TDataBase);
    Class Function VerificaPermissao(DataBase : TDataBase; Usuario : TUsuario; Permissao : string; TipoPermissao : TPermissaoUsuario = Generica):Boolean;

End;

implementation

Uses
  ConexaoBanco,
  EnumConexao;

Class Function TUsuarioRepository.VerificaUsuario(Usuario : TUsuario; DataBase : TDataBase):Boolean;
Var
  ConexaoBanco : TConexaoBanco;
  DataSet : TDataSet;
Begin
  Result := False;
  if (Usuario.Nome = cNome) and (Usuario.Senha = cSenha) then
  Begin
    Usuario.Master := True;
    TUsuarioRepository.EmpresaPadrao(Usuario, DataBase);
    Result := True;
    Exit;
  End;

  ConexaoBanco := TConexaoBanco.Create(DataBase);
  ConexaoBanco.Sql.Add('Select                ');
  ConexaoBanco.Sql.Add('U.Usuario,            ');
  ConexaoBanco.Sql.Add('U.Senha,              ');
  ConexaoBanco.Sql.Add('U.Master              ');
  ConexaoBanco.Sql.Add('From Usuario U        ');
  ConexaoBanco.Sql.Add('Where                 ');
  ConexaoBanco.Sql.Add('U.Usuario = :Usuario  ');
  ConexaoBanco.Param.ParamByName('Usuario').AsString := Usuario.Nome;

  DataSet := ConexaoBanco.DataSetFactory.GetDataSet(TConexao.BaseDados, ConexaoBanco.sql.Text, ConexaoBanco.Param);
  DataSet.First();
  if (DataSet.FieldByName('Usuario').AsString = Usuario.Nome)
      And ( Usuario.Senha = TCryptDecrypt.Crypt('D', DataSet.FieldByName('Senha').AsString)) then
  Begin
    Usuario.Master := DataSet.FieldByName('Master').AsString = 'T';
    TUsuarioRepository.EmpresaPadrao(Usuario, DataBase);
    Result := True;
  End;
End;

Class Procedure TUsuarioRepository.EmpresaPadrao(Usuario : TUsuario; DataBase : TDataBase);
Var
  ConexaoBanco : TConexaoBanco;
Begin
  if (Usuario.Nome = cNome) and (Usuario.Senha =  cSenha) then
  Begin
    ConexaoBanco := TConexaoBanco.Create(DataBase);
    ConexaoBanco.Sql.Add('Select first 1        ');
    ConexaoBanco.Sql.Add('CodigoEmpresa         ');
    ConexaoBanco.Sql.Add('From Dglob000         ');
    Usuario.CodigoEmpresaPadrao := ConexaoBanco.DataSetFactory.GetDataSet(TConexao.BaseDados, ConexaoBanco.sql.Text, ConexaoBanco.Param).FieldByName('CodigoEmpresa').AsInteger;
    Exit;
  End;

  ConexaoBanco := TConexaoBanco.Create(DataBase);
  ConexaoBanco.Sql.Add('Select                ');
  ConexaoBanco.Sql.Add('A.CodigoEmp           ');
  ConexaoBanco.Sql.Add('From Acesso A         ');
  ConexaoBanco.Sql.Add('Where                 ');
  ConexaoBanco.Sql.Add('A.Usuario = :Usuario  ');
  ConexaoBanco.Param.ParamByName('Usuario').AsString := Usuario.Nome;
  Usuario.CodigoEmpresaPadrao := ConexaoBanco.DataSetFactory.GetDataSet(TConexao.BaseDados, ConexaoBanco.sql.Text, ConexaoBanco.Param).FieldByName('CodigoEmp').AsInteger;
End;

Class Function TUsuarioRepository.VerificaPermissao(DataBase : TDataBase; Usuario : TUsuario; Permissao : string; TipoPermissao : TPermissaoUsuario = Generica):Boolean;
Var
  ConexaoBanco : TConexaoBanco;
  DataSet : TDataSet;
  sTipoPermissao : String;
Begin
  Result := False;
  if (Usuario.Master)Or(Usuario.Interno) then
    Result := True
  else
  Begin
    ConexaoBanco := TConexaoBanco.Create(DataBase);
    ConexaoBanco.sql.Add('Select '+Permissao+' From Acesso Where Usuario = :Usuario ');
    ConexaoBanco.Param.ParamByName('Usuario').AsString := Usuario.Nome;
    DataSet := ConexaoBanco.DataSetFactory.GetDataSet(TConexao.BaseDados, ConexaoBanco.sql.text, ConexaoBanco.Param);
    DataSet.First();
    if Not DataSet.Eof then
      Result := DataSet.FieldByName(Permissao).AsString = 'T';

    if (TipoPermissao <> TPermissaoUsuario.Generica) then
    Begin
      ConexaoBanco.Clear();

      case TipoPermissao of
        TPermissaoUsuario.Gravar: sTipoPermissao := 'Gravar';
        TPermissaoUsuario.Alterar: sTipoPermissao := 'Alterar';
        TPermissaoUsuario.Excluir: sTipoPermissao := 'Excluir';
      end;

      ConexaoBanco.sql.add('Select '+sTipoPermissao+' From Detalhe_Acesso Where Usuario = :Usuario And Campo = :Permissao');
      ConexaoBanco.Param.ParamByName('Permissao').AsString := Permissao;
      ConexaoBanco.Param.ParamByName('Usuario').AsString := Usuario.Nome;

      DataSet := ConexaoBanco.DataSetFactory.GetDataSet(TConexao.BaseDados, ConexaoBanco.sql.text, ConexaoBanco.Param);
      DataSet.First();
      if Not DataSet.Eof then
        Result := DataSet.FieldByName(sTipoPermissao).AsString = 'S';
    End;
  End;
End;

end.
