unit FormaPagamentoService;

interface

Uses
  Vcl.Forms,
  Winapi.Windows,
  System.SysUtils,
  DataBase,
  FormaPagamento,
  FormaPagamentoRepository,
  CustomExcept;

Type TFormaPagamentoService = Class Abstract
  Private
  Public
    Class Function ConsultaFormaPagamento(DataBase : TDataBase; FormaPagamento : TFormaPagamento; ExibirMensagem : Boolean = True):Boolean;
    Class Function TelaConsulta(DataBase : TDataBase; FormaPagamento : TFormaPagamento):Boolean;
End;

implementation

Uses
  Consulta_FormaPagamento;

Class Function TFormaPagamentoService.ConsultaFormaPagamento(DataBase : TDataBase; FormaPagamento : TFormaPagamento; ExibirMensagem : Boolean = True):Boolean;
Begin
  Result := False;
  Try
    if (Not TFormaPagamentoRepository.Get(DataBase ,FormaPagamento) ) then
    Begin
      if ExibirMensagem then
        Application.MessageBox('Forma de Pagamento inválida.','Atenção!',Mb_IconExclamation);
      FormaPagamento := TFormaPagamento.Create();
    End
    else
      Result := True;
  Except
    On e : Exception do
    Begin
      TCustomExcept.Show(e, 'Erro ao Consultar FormaPagamento');
    End;
  End;
End;

Class Function TFormaPagamentoService.TelaConsulta(DataBase : TDataBase; FormaPagamento : TFormaPagamento):Boolean;
Begin
  Result := False;
  Try
    TFrConsulta_FormaPagamento.Create(nil, DataBase, FormaPagamento).Release();
    if FormaPagamento.Id <> 0 then
      Result := True;
  Except
    On e: Exception do
    Begin
      TCustomExcept.Show(e, 'Erro ao visualizar consultar de forma de pagamento');
    End;
  End;
End;

end.
