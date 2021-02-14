unit BairroService;

interface

uses
  Winapi.Windows,
  System.SysUtils,
  DataBase,
  Bairro,
  BairroRepository,
  CustomExcept;

Type TBairroService = Class
  Private

  Public
    Class function TelaConsultaBairro(Database : TDatabase; Bairro : TBairro) : Boolean;
    Class Function ConsultaBairro(Database : TDatabase; Bairro : TBairro) : Boolean;
End;

implementation

uses Consulta_Bairro;

Class Function TBairroService.TelaConsultaBairro(DataBase : TDataBase; Bairro : TBairro) : Boolean;
Begin
  Result := False;
  try
    TFrConsulta_Bairro.Create(Nil, DataBase, Bairro).Release();

    if Bairro.Id <> 0 then
      Result := True;
  Except
    On e : Exception do
    Begin
      TCustomExcept.Show(e, Pchar('Erro ao Visualizar Consulta de Bairro ' + E.message));
    End;
  end;
End;

Class Function TBairroService.ConsultaBairro(DataBase : TDataBase; Bairro : TBairro) : Boolean;
Var
  Mensagem : String;
Begin
  Result := False;
  Try
    if (Not TBairroRepository.Get(DataBase ,Bairro) ) then
    Begin
      Bairro := TBairro.Create();
    End
    else
      Result := True;
  Except
    On e : Exception do
    Begin
      TCustomExcept.Show(e, 'Erro ao Consultar Bairro');
    End;
  End;
End;

end.
