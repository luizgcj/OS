unit PessoaService;

interface

Uses
  Vcl.Forms,
  Winapi.Windows,
  System.SysUtils,
  DataBase,
  Pessoa,
  EnumPessoaTipo,
  PessoaRepository,
  CustomExcept, Usuario, Cidade;

Type TPessoaService = Class
  Private
    class var _Database : TDatabase;
    class var _Usuario : TUsuario;
  Public
    Class Function TelaConsultaPessoa(DataBase : TDataBase; Pessoa : TPessoa; PessoaTipo : TEnumPessoaTipo =  TEnumPessoaTipo.Todos ) : Boolean;
    Class Function ConsultaPessoa(DataBase : TDataBase; Pessoa : TPessoa; ExibirMensagem : Boolean = True; PessoaTipo : TEnumPessoaTipo =  TEnumPessoaTipo.Todos; MensagemPersonalizada : String = '' ) : Boolean;
    class function AutoIncremento():Integer;
    Class procedure Gravar(Cliente : TPessoa; Database : TDatabase);
    class procedure GravarLog(Cliente : TPessoa; Database : TDatabase; Usuario : TUsuario; Cidade : TCidade);

    Constructor Create(Usuario : TUsuario; Database : TDatabase);
End;

implementation

Uses
  Consulta_Pessoa;

Class Function TPessoaService.TelaConsultaPessoa(DataBase : TDataBase; Pessoa : TPessoa; PessoaTipo : TEnumPessoaTipo =  TEnumPessoaTipo.Todos ) : Boolean;
Begin
  Result := False;
  try
    TFrConsulta_Pessoa.Create(Nil, DataBase, Pessoa, PessoaTipo).Release();

    if Pessoa.Id <> 0 then
      Result := True;
  Except
    On e : Exception do
    Begin
      TCustomExcept.Show(e, 'Erro ao Visualizar Consulta de Pessoas');
    End;
  end;
End;

Class Function TPessoaService.ConsultaPessoa(DataBase : TDataBase; Pessoa : TPessoa; ExibirMensagem : Boolean = True; PessoaTipo : TEnumPessoaTipo =  TEnumPessoaTipo.Todos; MensagemPersonalizada : String = '' ) : Boolean;
Var
  Mensagem : String;
Begin
  Result := False;
  Try
    case PessoaTipo of
      Cliente: Mensagem :=  'Cliente inv�lido!';
      Fornecedor: Mensagem := 'Fornecedor inv�lido!';
      Transportadora: Mensagem := 'Transportadora inv�lida!';
      Funcionario: Mensagem := 'Funcionario inv�lido!';
      Vendedor: Mensagem := 'Vendedor inv�lido!';
      Representante: Mensagem := 'Representante inv�lido!';
      Comprador: Mensagem := 'Comprador inv�lido!';
      Todos: Mensagem := 'Pessoa inv�lida!';
    end;

    if MensagemPersonalizada <> '' then
      Mensagem := MensagemPersonalizada;

    if (Not TPessoaRepository.Get(DataBase ,Pessoa, PessoaTipo) ) then
    Begin
      if ExibirMensagem then
        Application.MessageBox(Pchar(Mensagem),'Aten��o!',Mb_IconExclamation);
      Pessoa := TPessoa.Create();
    End
    else
      Result := True;
  Except
    On e : Exception do
    Begin
      TCustomExcept.Show(e, 'Erro ao Consultar Pessoa');
    End;
  End;
End;

class function TPessoaService.AutoIncremento():Integer;
begin
  Result := TPessoaRepository.AutoIncremento(_Database);
end;

class procedure TPessoaService.Gravar(Cliente : TPessoa; Database : TDatabase);
begin
  TPessoaRepository.Gravar(Cliente, Database);
end;

class procedure TPessoaService.GravarLog(Cliente : TPessoa; Database : TDatabase; Usuario : TUsuario; Cidade : TCidade);
begin
  TPessoaRepository.GravarLog(Cliente, Database, Usuario, Cidade);
end;

constructor TPessoaService.Create(Usuario : TUsuario; Database : TDatabase);
begin
  Inherited Create();
  _Usuario := Usuario;
  _Database := Database;
end;

end.
