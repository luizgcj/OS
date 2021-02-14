unit CtReceberService;

interface

Uses
  Winapi.Windows,
  System.SysUtils,
  DataBase,
  CtReceber,
  PlanoPagamento,
  FormaPagamento,
  OrdemServicoEntity,
  Produto,
  Usuario,
  Pessoa;

Type TCtReceberService = Class

  Private
    _DataBase : TDataBase;
    _CtReceber : TCtReceber;
    _OrdemServico : TOrdemServicoEntity;
    _Usuario : TUsuario;



  Public
    Function ConsultaOrdemServico():Boolean;
    Function RecuperarExtensaoDaFatura(sDataEmissao : String; iParcela, iTotParcelas :Integer):String;
    Function GravarCtReceber(OrdemServico : TOrdemServicoEntity; CtReceber : TCtReceber; FormasPagamento: TFormaPagamento; Cliente : TPessoa; DataBase: TDataBase):Boolean;
    Function GravarMaisCaixa(OrdemServico : TOrdemServicoEntity; CtReceber : TCtReceber; Usuario : TUsuario; DataBase: TDataBase):Boolean;
    Function VerificarFinanceiroQuitado(OrdemServico : TOrdemServicoEntity; DataBase : TDataBase; out sMessage : String):Boolean;
    Function CalculaTaxaCartao(CtReceber : TCtReceber; OrdemServico : TOrdemServicoEntity) : Boolean;
    Function VerificaPlanoPagtoCartao(out CtReceber : TCtReceber; out PlanoPagamento : TPlanoPagamento; OrdemServico : TOrdemServicoEntity; DataBase : TDataBase; out sMessage : String):Boolean;
    Procedure GravarCtPagarCartao(OrdemServico : TOrdemServicoEntity; CtReceber : TCtReceber; PlanoPagamento : TPlanoPagamento; FormaPagamento : TFormaPagamento; Cliente : TPessoa; DataBase : TDataBase);
    Function Cancelar():Boolean;
var
    Constructor Create(OrdemServico : TOrdemServicoEntity; CtReceber : TCtReceber; Usuario : TUsuario; DataBase : TDataBase);

End;

implementation

Uses
  CustomMessage,
  CustomExcept,
  Parametros,
  OrdemServicoRepository,
  CtReceberRepository,
  UsuarioService,
  AutorizacaoEstoque;

{$Region 'CtReceber'}

Constructor TCtReceberService.Create(OrdemServico : TOrdemServicoEntity; CtReceber : TCtReceber; Usuario : TUsuario; DataBase : TDataBase);
Begin
  Inherited Create();
  _CtReceber := CtReceber;
  _OrdemServico := OrdemServico;
  _Usuario := Usuario;
  _DataBase := DataBase;
End;

Function TCtReceberService.ConsultaOrdemServico():Boolean;
Begin
  Result := TCtReceberRepository.ConsultaCtReceber(_OrdemServico, _CtReceber, _DataBase);
End;


Function TCtReceberService.RecuperarExtensaoDaFatura(sDataEmissao : String; iParcela, iTotParcelas :Integer):String;
begin
  Result := TCtReceberRepository.RecuperarExtensaoDaFatura(sDataEmissao, iParcela, iTotParcelas, _DataBase);
end;

Function TCtReceberService.GravarMaisCaixa(OrdemServico : TOrdemServicoEntity; CtReceber : TCtReceber; Usuario : TUsuario; DataBase: TDataBase):Boolean;
begin
  Result := TCtReceberRepository.GravarCaixa(OrdemServico, CtReceber, Usuario, DataBase);
end;

Function TCtReceberService.GravarCtReceber(OrdemServico : TOrdemServicoEntity; CtReceber : TCtReceber; FormasPagamento : TFormaPagamento; Cliente : TPessoa; DataBase: TDataBase):Boolean;
begin
  Result := TCtReceberRepository.GravarCtReceber(OrdemServico, CtReceber, FormasPagamento, Cliente, DataBase);
end;
Function TCtReceberService.VerificarFinanceiroQuitado(OrdemServico : TOrdemServicoEntity; DataBase : TDataBase; out sMessage : String):Boolean;
begin
  Result := TCtReceberRepository.VerificarFinanceiroQuitado(OrdemServico, DataBase, sMessage);
end;

Function TCtReceberService.CalculaTaxaCartao(CtReceber : TCtReceber; OrdemServico : TOrdemServicoEntity) : Boolean;
begin
  Result := TCtReceberRepository.CalculaTaxaCartao(CtReceber, OrdemServico);
end;

Function TCtReceberService.VerificaPlanoPagtoCartao(out CtReceber : TCtReceber; out PlanoPagamento : TPlanoPagamento; OrdemServico : TOrdemServicoEntity; DataBase : TDataBase; out sMessage : String):Boolean;
begin
  Result := TCtReceberRepository.VerificaPlanoPagtoCartao(CtReceber, PlanoPagamento, OrdemServico, DataBase, sMessage);
end;

Procedure TCtReceberService.GravarCtPagarCartao(OrdemServico : TOrdemServicoEntity; CtReceber : TCtReceber; PlanoPagamento : TPlanoPagamento; FormaPagamento : TFormaPagamento; Cliente : TPessoa; DataBase : TDataBase);
begin
  TCtReceberRepository.GravarCtPagarCartao(OrdemServico, CtReceber, PlanoPagamento, FormaPagamento, Cliente, DataBase);
end;

Function TCtReceberService.Cancelar():Boolean;
begin
 TCtReceberRepository.Cancelar(_OrdemServico, _CtReceber, _DataBase);
end;

{$EndRegion}



end.
