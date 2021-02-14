unit ProdutoService;

interface

Uses
  Vcl.Forms,
  Winapi.Windows,
  System.SysUtils,
  DataBase,
  Produto,
  ProdutoRepository,
  CustomExcept,
  OrdemServicoEntity;

Type TProdutoService = Class Abstract
  Private
  Public
    Class Function ConsultaProduto(DataBase : TDataBase; Produto : TProduto; ExibirMensagem : Boolean = True; MensagemPersonalizada : String = ''; ExibirInativos : Boolean = False; OrdemServico : TOrdemServicoEntity = nil):Boolean;
    Class Function TelaConsulta(DataBase : TDataBase; Produto : TProduto; ExibirInativos : Boolean = False; OrdemServico : TOrdemServicoEntity = nil):Boolean;
End;

implementation

Uses
  Consulta_Produto;

Class Function TProdutoService.ConsultaProduto(DataBase : TDataBase; Produto : TProduto; ExibirMensagem : Boolean = True; MensagemPersonalizada : String = ''; ExibirInativos : Boolean = False; OrdemServico : TOrdemServicoEntity = nil):Boolean;
Var
  Mensagem : String;
Begin
  Result := False;
  Try
    if MensagemPersonalizada <> '' then
      Mensagem := MensagemPersonalizada;

    if (Not TProdutoRepository.Get(DataBase ,Produto, ExibirInativos, OrdemServico) ) then
    Begin
      if ExibirMensagem then
        Application.MessageBox(Pchar(Mensagem),'Atenção!',Mb_IconExclamation);
      Produto := TProduto.Create();
    End
    else
      Result := True;
  Except
    On e : Exception do
    Begin
      TCustomExcept.Show(e, 'Erro ao Consultar Produto');
    End;
  End;
End;

Class Function TProdutoService.TelaConsulta(DataBase : TDataBase; Produto : TProduto; ExibirInativos : Boolean = False; OrdemServico : TOrdemServicoEntity = nil):Boolean;
Begin
  Result := False;
  Try
    TFrConsulta_Produto.Create(nil, DataBase, Produto, ExibirInativos, OrdemServico).Release();
    if Produto.Id <> 0 then
      Result := True;
  Except
    On e: Exception do
    Begin
      TCustomExcept.Show(e, 'Erro ao visualizar consultar de pessoas');
    End;
  End;
End;

end.
