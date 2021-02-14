unit PlanoPagamentoService;

interface

Uses
  Vcl.Forms,
  Winapi.Windows,
  System.SysUtils,
  DataBase,
  PlanoPagamento,
  PlanoPagamentoRepository,
  CustomExcept;

Type TPlanoPagamentoService = Class Abstract
  Private
  Public
    Class Function ConsultaPlanoPagamento(DataBase : TDataBase; PlanoPagamento : TPlanoPagamento; ExibirMensagem : Boolean = True):Boolean;
    Class Function TelaConsulta(DataBase : TDataBase; PlanoPagamento : TPlanoPagamento):Boolean;
    Class Procedure ConsultaPlanoVista(DataBase : TDataBase; PlanoPagamento : TPlanoPagamento);
End;

implementation

Uses
  Consulta_PlanoPagamento;

Class Function TPlanoPagamentoService.ConsultaPlanoPagamento(DataBase : TDataBase; PlanoPagamento : TPlanoPagamento; ExibirMensagem : Boolean = True):Boolean;
Begin
  Result := False;
  Try
    if (Not TPlanoPagamentoRepository.Get(DataBase ,PlanoPagamento) ) then
    Begin
      if ExibirMensagem then
        Application.MessageBox('Plano de Pagamento inválido.','Atenção!',Mb_IconExclamation);
      PlanoPagamento := TPlanoPagamento.Create();
    End
    else
      Result := True;
  Except
    On e : Exception do
    Begin
      TCustomExcept.Show(e, 'Erro ao Consultar PlanoPagamento');
    End;
  End;
End;

Class Procedure TPlanoPagamentoService.ConsultaPlanoVista(DataBase : TDataBase; PlanoPagamento : TPlanoPagamento);
Begin
  TPlanoPagamentoRepository.ConsultaPlanoVista(DataBase, PlanoPagamento);
End;

Class Function TPlanoPagamentoService.TelaConsulta(DataBase : TDataBase; PlanoPagamento : TPlanoPagamento):Boolean;
Begin
  Result := False;
  Try
    TFrConsulta_PlanoPagamento.Create(nil, DataBase, PlanoPagamento).Release();
    if PlanoPagamento.Id <> 0 then
      Result := True;
  Except
    On e: Exception do
    Begin
      TCustomExcept.Show(e, 'Erro ao visualizar consultar de plano de pagamento');
    End;
  End;
End;

end.
