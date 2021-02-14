unit SetorService;

interface

Uses
  Vcl.Forms,
  Winapi.Windows,
  System.SysUtils,
  DataBase,
  Setor,
  SetorRepository,
  CustomExcept;

Type TSetorService = Class abstract
  Private

  Public
    Class Function TelaConsultaSetor(DataBase : TDataBase; Setor : TSetor) : Boolean;
    Class Function ConsultaSetor(DataBase : TDataBase; Setor : TSetor; ExibirMensagem : Boolean = True) : Boolean;

End;

implementation

Uses
  Consulta_Setor;

Class Function TSetorService.TelaConsultaSetor(DataBase : TDataBase; Setor : TSetor) : Boolean;
Begin
  Result := False;
  try
    TFrConsulta_Setor.Create(Nil, DataBase, Setor).Release();

    if Setor.Id <> 0 then
      Result := True;
  Except
    On e : Exception do
    Begin
      TCustomExcept.Show(e, 'Erro ao Visualizar Consulta de Pessoas');
    End;
  end;
End;

Class Function TSetorService.ConsultaSetor(DataBase : TDataBase; Setor : TSetor; ExibirMensagem : Boolean = True) : Boolean;
Var
  Mensagem : String;
Begin
  Result := False;
  Try
    Mensagem := 'Setor inválida!';


    if (Not TSetorRepository.Get(DataBase ,Setor) ) then
    Begin
      if ExibirMensagem then
        Application.MessageBox(Pchar(Mensagem),'Atenção!',Mb_IconExclamation);
      Setor := TSetor.Create();
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

end.
