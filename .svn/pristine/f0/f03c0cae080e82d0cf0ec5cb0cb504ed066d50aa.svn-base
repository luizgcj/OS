unit CidadeService;

interface

uses
  Winapi.Windows,
  System.SysUtils,
  DataBase,
  Cidade,
  CidadeRepository,
  CustomExcept;

Type TCidadeService = Class
  Private

  Public
    Class function TelaConsultaCidade(Database : TDatabase; Cidade : TCidade) : Boolean;
    Class Function ConsultaCidade(Database : TDatabase; Cidade : TCidade) : Boolean;
End;

implementation

uses Consulta_Cidade;

Class Function TCidadeService.TelaConsultaCidade(DataBase : TDataBase; Cidade : TCidade) : Boolean;
Begin
  Result := False;
  try
    TFrConsulta_Cidade.Create(Nil, DataBase, Cidade).Release();

    if Cidade.Id <> 0 then
      Result := True;
  Except
    On e : Exception do
    Begin
      TCustomExcept.Show(e, Pchar('Erro ao Visualizar Consulta de Cidade ' + E.message));
    End;
  end;
End;

Class Function TCidadeService.ConsultaCidade(DataBase : TDataBase; Cidade : TCidade) : Boolean;
Var
  Mensagem : String;
Begin
  Result := False;
  Try
    if (Not TCidadeRepository.Get(DataBase ,Cidade) ) then
    Begin
      Cidade := TCidade.Create();
    End
    else
      Result := True;
  Except
    On e : Exception do
    Begin
      TCustomExcept.Show(e, 'Erro ao Consultar Cidade');
    End;
  End;
End;


end.
