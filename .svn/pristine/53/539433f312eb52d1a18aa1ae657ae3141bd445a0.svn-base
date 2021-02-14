unit OrdemServicoEntity;

interface

Uses
  Vcl.Forms,
  Winapi.Windows,
  System.Math,
  System.SysUtils,
  BoundObject,
  Data.Db,
  DataSnap.DbClient,
  CustomMessage,
  DataBase,
  Produto,
  EnumSituacaoOrdemServico,
  CustomExcept;

Type TOrdemServicoEntity = Class(TBoundObject)
  Private
    _Id : Integer;
    _DataCriacao : TDateTime;
    _HoraCriacao : TDateTime;
    _DataEmissao : TDateTime;
    _HoraEmissao : TDateTime;
    _DataPrevisao : TDateTime;
    _HoraPrevisao : TDateTime;
    _DataFechamento : TDateTime;
    _HoraFechamento : TDateTime;
    _DataEntrega : TDateTime;
    _HoraEntrega : TDateTime;
    _ClienteId : Integer;
    _VendedorId : Integer;
    _VendedorLibId : Integer;
    _FuncionarioLaboratorioId : Integer;
    _ValorTotalItens : Double;
    _ValorBrutoItens : Double;
    _PercDesconto : Double;
    _Desconto : Double;
    _TotalDescontoItens : Double;
    _ValorTotal : Double;
    _SubTotal : Double;
    _Cancelado : String;
    _DataCancelamento : TDateTime;
    _Faturado : String;
    _DataFaturamento : TDateTime;
    _Situacao : String;
    _DataSituacao : TDateTime;
    _Envelope : Integer;
    _ValorSinal : Double;
    _Setor : Integer;
    _FormaPagtoId : Integer;
    _FormaPagtoIdAnterior : Integer;
    _PlanoPagtoId : Integer;
    _ParcelasCartao : Integer;
    _ValorSinalAnterior : Double;
    _SituacaoAnterior : String;
    _Observacao : String;
    _ObservacaoRecibo : String;
    _ObservacaoRecibo2 : String;
    _Orcamento : Boolean;
    _OrcamentoAnterior : Boolean;
    _PedidoRapido : Boolean;
    _Modelo : String;
    _FotografoId : Integer;

    _Alteracao : Boolean;

    _cdsItens : TClientDataSet;

    {$Region 'Set Binding'}
    Procedure SetId(Id : Integer);
    Procedure SetDataCriacao(DataCriacao : TDateTime);
    Procedure SetHoraCriacao(HoraCriacao : TDateTime);
    Procedure SetDataEmissao(DataEmissao : TDateTime);
    Procedure SetHoraEmissao(HoraEmissao : TDateTime);
    Procedure SetDataPrevisao(DataPrevisao : TDateTime);
    Procedure SetHoraPrevisao(HoraPrevisao : TDateTime);
    Procedure SetDataFechamento(DataFechamento : TDateTime);
    Procedure SetHoraFechamento(HoraFechamento : TDateTime);
    Procedure SetDataEntrega(DataEntrega : TDateTime);
    Procedure SetHoraEntrega(HoraEntrega  : TDateTime);
    Procedure SetClienteId(ClienteId : Integer);
    Procedure SetVendedorId(VendedorId : Integer);
    Procedure SetVendedorLibId(VendedorLibId : Integer);
    Procedure SetFuncionarioLaboratorioId(FuncionarioLaboratorioId : Integer);
    Procedure SetFotografoId(FotografoId : Integer);
    Procedure SetModelo(Modelo : String);
    Procedure SetValorTotalItens( ValorTotalItens : Double);
    Procedure SetValorBrutoItens( ValorBrutoItens : Double);
    Procedure SetPercDesconto( PercDesconto : Double);
    Procedure SetPercDescontoInterno( PercDesconto : Double);
    Procedure SetDesconto( Desconto : Double);
    Procedure SetTotalDescontoItens(TotalDescontoItens : Double = 0);
    Procedure SetDescontoInterno( Desconto : Double);
    Procedure SetValorTotal(ValorTotal : Double);
    Procedure SetSubTotal(SubTotal : Double);
    Procedure SetCancelado(Cancelado : String);
    Procedure SetDataCancelamento(DataCancelamento : TDateTime);
    Procedure SetFaturado(Faturado : String);
    Procedure SetDataFaturamento(DataFaturamento : TDateTime);
    Procedure SetSituacao(Situacao : String);
    Procedure SetDataSituacao(DataSituacao : TDateTime);
    Procedure SetEnvelope(Envelope : Integer);
    Procedure SetValorSinal(ValorSinal : Double);
    Procedure SetSetor(Setor : Integer);
    Procedure SetFormaPagtoId(FormaPagtoId : Integer);
    Procedure SetFormaPagtoIdAnterior(FormaPagtoIdAnterior : Integer);
    Procedure SetPlanoPagtoId(PlanoPagtoId : Integer);
    Procedure SetParcelasCartao(ParcelasCartao : Integer);
    Procedure SetValorSinalAnterior(ValorSinalAnterior : Double);
    Procedure SetSituacaoAnterior(SituacaoAnterior : String);
    Procedure SetObservacao(Observacao : String);
    Procedure SetObservacaoRecibo(ObservacaoRecibo : String);
    Procedure SetObservacaoRecibo2(ObservacaoRecibo2 : String);
    Procedure SetOrcamento(Orcamento : Boolean);
    Procedure SetOrcamentoAnterior(OrcamentoAnterior : Boolean);
    Procedure SetPedidoRapido(PedidoRapido : Boolean);
    {$EndRegion}

    Procedure CalculaDescontoPercentual();
    Procedure CalculaDescontoValor();
    Procedure CalculaTotalOrdemServico();
    Procedure LimpaObjeto();
  Public

    Property Id : Integer Read _Id Write SetId;
    Property DataCriacao : TDateTime Read _DataCriacao Write setDataCriacao;
    Property HoraCriacao : TDateTime Read _HoraCriacao Write setHoraCriacao;
    Property DataEmissao : TDateTime Read _DataEmissao Write SetDataEmissao;
    Property HoraEmissao : TDateTime Read _HoraEmissao Write SetHoraEmissao;
    Property DataPrevisao : TDateTime Read _DataPrevisao Write SetDataPrevisao;
    Property HoraPrevisao : TDateTime Read _HoraPrevisao Write SetHoraPrevisao;
    Property DataFechamento : TDateTime Read _DataFechamento Write SetDataFechamento;
    Property HoraFechamento : TDateTime Read _HoraFechamento Write SetHoraFechamento;
    Property DataEntrega : TDateTime Read _DataEntrega Write SetDataEntrega;
    Property HoraEntrega : TDateTime Read _HoraEntrega Write SetHoraEntrega;
    Property ClienteId : Integer Read _ClienteId Write SetClienteId;
    Property VendedorId : Integer Read _VendedorId Write SetVendedorId;
    Property VendedorLibId : Integer Read _VendedorLibId Write SetVendedorLibId;
    Property FuncionarioLaboratorioId : Integer Read _FuncionarioLaboratorioId Write SetFuncionarioLaboratorioId;
    Property FotografoId : Integer Read _FotografoId Write SetFotografoId;
    Property Modelo : String Read _Modelo Write SetModelo;
    Property ValorTotalItens : Double Read _ValorTotalItens Write SetValorTotalItens;
    Property ValorBrutoItens : Double Read _ValorBrutoItens Write SetValorBrutoItens;
    Property PercDesconto : Double Read _PercDesconto Write SetPercDesconto;
    Property Desconto : Double Read _Desconto Write SetDesconto;
    Property TotalDescontoItens : Double Read _TotalDescontoItens Write SetTotalDescontoItens;
    Property ValorTotal : Double Read _ValorTotal Write SetValorTotal;
    Property SubTotal : Double Read _SubTotal Write SetSubTotal;
    Property Cancelado : String Read _Cancelado Write SetCancelado;
    Property DataCancelamento : TDateTime Read _DataCancelamento Write SetDataCancelamento;
    Property Faturado : String Read _Faturado Write SetFaturado;
    Property DataFaturamento : TDateTime Read _DataFaturamento Write SetDataFaturamento;
    Property Situacao : String Read _Situacao Write SetSituacao;
    Property DataSituacao : TDateTime Read _DataSituacao Write SetDataSituacao;
    Property Envelope : Integer Read _Envelope Write SetEnvelope;
    Property ValorSinal : Double Read _ValorSinal Write SetValorSinal;
    Property Setor : Integer Read _Setor Write SetSetor;
    Property FormaPagtoId : Integer Read _FormaPagtoId Write SetFormaPagtoId;
    Property FormaPagtoIdAnterior : Integer Read _FormaPagtoIdAnterior Write SetFormaPagtoIdAnterior;
    Property PlanoPagtoId : Integer Read _PlanoPagtoId Write SetPlanoPagtoId;
    Property ParcelasCartao : Integer Read _ParcelasCartao Write SetParcelasCartao;
    Property ValorSinalAnterior : Double Read _ValorSinalAnterior Write SetValorSinalAnterior;
    Property SituacaoAnterior : String Read _SituacaoAnterior Write SetSituacaoAnterior;
    Property Observacao : String Read _Observacao Write SetObservacao;
    Property ObservacaoRecibo : String Read _ObservacaoRecibo Write SetObservacaoRecibo;
    Property ObservacaoRecibo2 : String Read _ObservacaoRecibo2 Write SetObservacaoRecibo2;
    Property Orcamento : Boolean Read _Orcamento Write SetOrcamento;
    Property OrcamentoAnterior : Boolean Read _OrcamentoAnterior Write SetOrcamentoAnterior;
    Property PedidoRapido : Boolean Read _PedidoRapido Write SetPedidoRapido;

    Property Alteracao : Boolean Read _Alteracao Write _Alteracao;

    Property cdsItens : TClientDataSet Read _cdsItens Write _cdsItens;

    Function GetTotalItens():Double;

    Constructor Create();

End;

implementation

Constructor TOrdemServicoEntity.Create();
  {$Region 'Biding'}
  Procedure CriaCampos();
  Begin
    _CdsItens.FieldDefs.Add('ProdutoId', FtInteger);
    _CdsItens.FieldDefs.Add('Produto', FtString, 200);
    _CdsItens.FieldDefs.Add('Quantidade', FtFloat);
    _CdsItens.FieldDefs.Add('QuantidadeEmbalagem', FtFloat);
    _CdsItens.FieldDefs.Add('QuantidadeBaixa', FtFloat);
    _CdsItens.FieldDefs.Add('ValorUnitario', FtFloat);
    _CdsItens.FieldDefs.Add('PercDesconto', FtFloat);
    _CdsItens.FieldDefs.Add('ValorDesconto', FtFloat);
    _CdsItens.FieldDefs.Add('ValorTotal', FtFloat);
    _CdsItens.FieldDefs.Add('Tipo', FtString, 1);
    _CdsItens.FieldDefs.Add('CodUnidade', FtInteger);
    _CdsItens.FieldDefs.Add('TipoPreco', FtString, 1);
    _CdsItens.FieldDefs.Add('PrCompraProd', FtFloat);
    _CdsItens.FieldDefs.Add('PrMargemZero', FtFloat);
    _CdsItens.FieldDefs.Add('PrCustoProd', FtFloat);
    _CdsItens.FieldDefs.Add('PercComBrVend', FtFloat);
    _CdsItens.FieldDefs.Add('PercComLiqVend', FtFloat);
    _CdsItens.FieldDefs.Add('PercComBrRepres', FtFloat);
    _CdsItens.FieldDefs.Add('PercComLiqRepres', FtFloat);
    _CdsItens.FieldDefs.Add('PrCustoMedio', FtFloat);
    _CdsItens.FieldDefs.Add('PrCompraMedio', FtFloat);
    _CdsItens.FieldDefs.Add('DescontoRateado', FtFloat);

  end;
  {$EndRegion}
Begin
  Inherited Create();
  _cdsItens := TClientDataSet.Create(nil);
  CriaCampos();
  _CdsItens.CreateDataSet;
  _DataCriacao := Date;
  _HoraCriacao := Time;
  _DataEmissao := Date;
  _HoraEmissao := Time;
  _DataPrevisao := Date;
  _HoraPrevisao := Time + StrToTime('01:00:00');

  SetCancelado('N');
  SetFaturado('N');
  SetSituacao(TEnumSituacaoOrdemServico.Aberta);
End;

Procedure TOrdemServicoEntity.LimpaObjeto();
Begin
  SetId(0);
  SetDataCriacao(Date);
  SetHoraCriacao(Time);
  SetDataEmissao(Date);
  SetHoraEmissao(Time);
  SetDataPrevisao(Date);
  SetHoraPrevisao(Time);
  SetDataFechamento(0);
  SetHoraFechamento(0);
  SetDataEntrega(0);
  SetHoraEntrega(0);
  SetClienteId(0);
  SetVendedorId(0);
  SetVendedorLibId(0);
  SetFuncionarioLaboratorioId(0);
  SetFotografoId(0);
  SetModelo('');
  SetValorTotalItens(0);
  SetValorTotal(0);
  SetCancelado('N');
  SetDataCancelamento(Date);
  SetFaturado('N');
  SetDataFaturamento(Date);
  SetSituacao(TEnumSituacaoOrdemServico.Aberta);
  SetDataSituacao(Date);
  SetEnvelope(0);
  SetValorSinal(0);
  SetSetor(0);
  SetFormaPagtoId(0);
  SetPlanoPagtoId(0);
  SetParcelasCartao(0);
  SetValorSinalAnterior(0);
  SetSituacaoAnterior('');
  SetObservacao('');
  SetObservacaoRecibo('');
  SetObservacaoRecibo2('');
  SetOrcamento(False);
  SetOrcamentoAnterior(False);
  SetPedidoRapido(False);
  _cdsItens.Close();
  _cdsItens.CreateDataSet;
End;

{$Region 'Set Binding'}
Procedure TOrdemServicoEntity.SetId(Id : Integer);
Begin
  if (_Id <> Id) then
  Begin
    _Id := Id;
    Notify('Id');
    if _Id = 0 then
      LimpaObjeto();    
  End;
End;

Procedure TOrdemServicoEntity.SetDataCriacao(DataCriacao : TDateTime);
Begin
  if (_DataCriacao <> DataCriacao) then
  Begin
    _DataCriacao := DataCriacao;
    Notify('DataCriacao');
  End;
End;

Procedure TOrdemServicoEntity.SetHoraCriacao(HoraCriacao : TDateTime);
Begin
  if (_HoraCriacao <> HoraCriacao) then
  Begin
    _HoraCriacao := HoraCriacao;
    Notify('HoraCriacao');
  End;
End;

Procedure TOrdemServicoEntity.SetDataEmissao(DataEmissao : TDateTime);
Begin
  if (_DataEmissao <> DataEmissao) then
  Begin
    _DataEmissao := DataEmissao;
    Notify('DataEmissao');
  End;
End;

Procedure TOrdemServicoEntity.SetHoraEmissao(HoraEmissao : TDateTime);
Begin
  if (_HoraEmissao <> HoraEmissao) then
  Begin
    _HoraEmissao := HoraEmissao;
    Notify('HoraEmissao');
  End;
End;

Procedure TOrdemServicoEntity.SetDataPrevisao(DataPrevisao : TDateTime);
Begin
  if (_DataPrevisao <> DataPrevisao) then
  Begin
    _DataPrevisao := DataPrevisao;
    Notify('DataPrevisao');
  End;
End;

Procedure TOrdemServicoEntity.SetHoraPrevisao(HoraPrevisao : TDateTime);
Begin
  if (_HoraPrevisao <> HoraPrevisao) then
  Begin
    _HoraPrevisao := HoraPrevisao;
    Notify('HoraPrevisao');
  End;
End;

Procedure TOrdemServicoEntity.SetDataFechamento(DataFechamento : TDateTime);
Begin
  if (_DataFechamento <> DataFechamento) then
  Begin
    _DataFechamento := DataFechamento;
    Notify('DataFechamento');
  End;
End;

Procedure TOrdemServicoEntity.SetHoraFechamento(HoraFechamento : TDateTime);
Begin
  if (_HoraFechamento <> HoraFechamento) then
  Begin
    _HoraFechamento := HoraFechamento;
    Notify('HoraFechamento');
  End;
End;

Procedure TOrdemServicoEntity.SetDataEntrega(DataEntrega : TDateTime);
Begin
  if (_DataEntrega <> DataEntrega) then
  Begin
    _DataEntrega := DataEntrega;
    Notify('DataEntrega');
  End;
End;

Procedure TOrdemServicoEntity.SetHoraEntrega(HoraEntrega : TDateTime);
Begin
  if (_HoraEntrega <> HoraEntrega) then
  Begin
    _HoraEntrega := HoraEntrega;
    Notify('HoraEntrega');
  End;
End;

Procedure TOrdemServicoEntity.SetClienteId(ClienteId : Integer);
Begin
  if (_ClienteId <> ClienteId) then
  Begin
    _ClienteId := ClienteId;
    Notify('ClienteId');
  End;
End;

Procedure TOrdemServicoEntity.SetVendedorId(VendedorId : Integer);
Begin
  if (_VendedorId <> VendedorId) then
  Begin
    _VendedorId := VendedorId;
    Notify('VendedorId');
  End;
End;

Procedure TOrdemServicoEntity.SetFotografoId(FotografoId : Integer);
Begin
  if (_FotografoId <> FotografoId) then
  Begin
    _FotografoId:= FotografoId;
    Notify('FotografoId');
  End;
End;


Procedure TOrdemServicoEntity.SetModelo(Modelo : String);
Begin
  if (_Modelo <> Modelo) then
  Begin
    _Modelo := Modelo;
    Notify('Modelo');
  End;
End;


Procedure TOrdemServicoEntity.SetVendedorLibId(VendedorLibId : Integer);
Begin
  if (_VendedorLibId <> VendedorLibId) then
  Begin
    _VendedorLibId := VendedorLibId;
    Notify('VendedorLibId');
  End;
End;

Procedure TOrdemServicoEntity.SetFuncionarioLaboratorioId(FuncionarioLaboratorioId : Integer);
Begin
  if (_FuncionarioLaboratorioId <> FuncionarioLaboratorioId) then
  Begin
    _FuncionarioLaboratorioId := FuncionarioLaboratorioId;
    Notify('FuncionarioLaboratorioId');
  End;
End;

Procedure TOrdemServicoEntity.SetValorTotalItens( ValorTotalItens : Double);
Begin
  if (_ValorTotalItens <> ValorTotalItens) then
  Begin
    _ValorTotalItens := ValorTotalItens;
    Notify('ValorTotalItens');
    CalculaTotalOrdemServico();
  End;
End;

Procedure TOrdemServicoEntity.SetValorBrutoItens( ValorBrutoItens : Double);
begin
  if (_ValorBrutoItens <> ValorBrutoItens) then
  Begin
    _ValorBrutoItens := ValorBrutoItens;
    Notify('ValorBrutoItens');
    CalculaTotalOrdemServico();
  End;
end;

Procedure TOrdemServicoEntity.SetTotalDescontoItens(TotalDescontoItens : Double = 0);
begin
  cdsItens.First;
  TotalDescontoItens := 0;
  while not cdsItens.Eof do
  begin
    TotalDescontoItens := TotalDescontoItens + cdsItens.FieldByName('ValorDesconto').AsFloat;
    cdsItens.Next;
  end;
  _TotalDescontoItens := TotalDescontoItens;
  Notify('TotalDescontoItens');
end;

Procedure TOrdemServicoEntity.SetValorTotal(ValorTotal : Double);
Begin
  if (_ValorTotal <> ValorTotal) then
  Begin
    _ValorTotal := ValorTotal;
    Notify('ValorTotal');
  End;
End;

Procedure TOrdemServicoEntity.SetSubTotal(SubTotal : Double);
Begin
  if (_SubTotal <> SubTotal) then
  Begin
    _SubTotal := SubTotal;
    Notify('SubTotal');
  End;
end;

Procedure TOrdemServicoEntity.SetPercDesconto( PercDesconto : Double);
Begin
  SetPercDescontoInterno(PercDesconto);
  CalculaDescontoPercentual();
End;

Procedure TOrdemServicoEntity.SetPercDescontoInterno( PercDesconto : Double);
Begin
  if (_PercDesconto <> PercDesconto) then
  Begin
    _PercDesconto := PercDesconto;
    Notify('PercDesconto');
  End;
End;

Procedure TOrdemServicoEntity.SetDesconto( Desconto : Double);
Begin
  SetDescontoInterno(Desconto);
  CalculaDescontoValor();
End;

Procedure TOrdemServicoEntity.SetDescontoInterno( Desconto : Double);
Begin
  if (_Desconto <> Desconto) then
  Begin
    _Desconto := Desconto;
    Notify('Desconto');
  End;
End;

Procedure TOrdemServicoEntity.CalculaDescontoPercentual();
Begin
  SetDescontoInterno( RoundTo(_ValorTotalItens * _PercDesconto / 100 , -2) );
  CalculaTotalOrdemServico();
End;

Procedure TOrdemServicoEntity.CalculaDescontoValor();
Var
  PercDesc : Double;
Begin
  if _ValorTotalItens > 0 then
    PercDesc := 100 * _Desconto / _ValorTotalItens
  else
    PercDesc := 0;

  SetPercDescontoInterno( RoundTo(PercDesc, -8) );
  CalculaTotalOrdemServico();
End;

Procedure TOrdemServicoEntity.SetCancelado(Cancelado : String);
Begin
  if (_Cancelado <> Cancelado) then
  Begin
    _Cancelado := Cancelado;
    Notify('Cancelado');
  End;
End;

Procedure TOrdemServicoEntity.SetDataCancelamento(DataCancelamento : TDateTime);
Begin
  if (_DataCancelamento <> DataCancelamento) then
  Begin
    _DataCancelamento := DataCancelamento;
    Notify('DataCancelamento');
  End;
End;

Procedure TOrdemServicoEntity.SetFaturado(Faturado : String);
Begin
  if (_Faturado <> Faturado) then
  Begin
    _Faturado := Faturado;
    Notify('Faturado');
  End;
End;

Procedure TOrdemServicoEntity.SetDataFaturamento(DataFaturamento : TDateTime);
Begin
  if (_DataFaturamento <> DataFaturamento) then
  Begin
    _DataFaturamento := DataFaturamento;
    Notify('DataFaturamento');
  End;
End;

Procedure TOrdemServicoEntity.SetSituacao(Situacao : String);
Begin
  if (_Situacao <> Situacao) then
  Begin
    _Situacao := Situacao;
    Notify('Situacao');
  End;
End;

Procedure TOrdemServicoEntity.SetSituacaoAnterior(SituacaoAnterior : String);
Begin
  if (_SituacaoAnterior <> SituacaoAnterior) then
  Begin
    _SituacaoAnterior := SituacaoAnterior;
    Notify('SituacaoAnterior');
  End;
End;

Procedure TOrdemServicoEntity.SetDataSituacao(DataSituacao : TDateTime);
Begin
  if (_DataSituacao <> DataSituacao) then
  Begin
    _DataSituacao := DataSituacao;
    Notify('DataSituacao');
  End;
End;

Procedure TOrdemServicoEntity.SetEnvelope(Envelope : Integer);
Begin
  if (_Envelope <> Envelope) then
  Begin
    _Envelope := Envelope;
    Notify('Envelope');
  End;
End;

Procedure TOrdemServicoEntity.SetValorSinal(ValorSinal : Double);
Begin
  if (_ValorSinal <> ValorSinal) then
  Begin
    _ValorSinal := ValorSinal;
    Notify('ValorSinal');
  End;
End;

Procedure TOrdemServicoEntity.SetValorSinalAnterior(ValorSinalAnterior : Double);
Begin
  if (_ValorSinalAnterior <> ValorSinalAnterior) then
  Begin
    _ValorSinalAnterior := ValorSinalAnterior;
    Notify('ValorSinalAnterior');
  End;
End;

Procedure TOrdemServicoEntity.SetSetor(Setor : Integer);
Begin
  if (_Setor <> Setor) then
  Begin
    _Setor := Setor;
    Notify('Setor');
  End;
End;

Procedure TOrdemServicoEntity.SetFormaPagtoId(FormaPagtoId : Integer);
Begin
  if (_FormaPagtoId <> FormaPagtoId) then
  Begin
    _FormaPagtoId := FormaPagtoId;
    Notify('FormaPagtoId');
  End;
End;

Procedure TOrdemServicoEntity.SetFormaPagtoIdAnterior(FormaPagtoIdAnterior : Integer);
Begin
  if (_FormaPagtoIdAnterior <> FormaPagtoIdAnterior) then
  Begin
    _FormaPagtoIdAnterior := FormaPagtoIdAnterior;
    Notify('FormaPagtoIdAnterior');
  End;
End;

Procedure TOrdemServicoEntity.SetPlanoPagtoId(PlanoPagtoId : Integer);
Begin
  if (_PlanoPagtoId <> PlanoPagtoId) then
  Begin
    _PlanoPagtoId := PlanoPagtoId;
    Notify('PlanoPagtoId');
  End;
End;

Procedure TOrdemServicoEntity.SetParcelasCartao(ParcelasCartao : Integer);
Begin
  if (_ParcelasCartao <> ParcelasCartao) then
  Begin
    _ParcelasCartao := ParcelasCartao;
    Notify('ParcelasCartao');
  End;
End;

Procedure TOrdemServicoEntity.SetObservacao(Observacao : String);
Begin
  if (_Observacao <> Observacao) then
  Begin
    _Observacao := Observacao;
    Notify('Observacao');
  End;
End;

Procedure TOrdemServicoEntity.SetObservacaoRecibo(ObservacaoRecibo : String);
Begin
  if (_ObservacaoRecibo <> ObservacaoRecibo) then
  Begin
    _ObservacaoRecibo := ObservacaoRecibo;
    Notify('ObservacaoRecibo');
  End;
End;

Procedure TOrdemServicoEntity.SetObservacaoRecibo2(ObservacaoRecibo2 : String);
Begin
  if (_ObservacaoRecibo2 <> ObservacaoRecibo2) then
  Begin
    _ObservacaoRecibo2 := ObservacaoRecibo2;
    Notify('ObservacaoRecibo2');
  End;
End;


Procedure TOrdemServicoEntity.SetOrcamento(Orcamento : Boolean);
Begin
  if (_Orcamento <> Orcamento) then
  Begin
    _Orcamento := Orcamento;
    Notify('Orcamento');
  End;
End;

Procedure TOrdemServicoEntity.SetOrcamentoAnterior(OrcamentoAnterior : Boolean);
Begin
  if (_OrcamentoAnterior <> OrcamentoAnterior) then
  Begin
    _OrcamentoAnterior := OrcamentoAnterior;
    Notify('OrcamentoAnterior');
  End;
End;

Procedure TOrdemServicoEntity.SetPedidoRapido(PedidoRapido : Boolean);
Begin
  if (_PedidoRapido <> PedidoRapido) then
  Begin
    _PedidoRapido := PedidoRapido;
    Notify('PedidoRapido');
  End;
End;
{$EndRegion}



{$Region 'Totais'}

Procedure TOrdemServicoEntity.CalculaTotalOrdemServico();
Begin
  SetSubTotal(_ValorBrutoItens );
  SetValorTotal(_ValorTotalItens - _Desconto );
  SetTotalDescontoItens();
End;

Function TOrdemServicoEntity.GetTotalItens():Double;
Var
  total, subTotal : Double;
Begin
  _cdsItens.DisableControls();
  _cdsItens.First();
  while (Not _cdsItens.Eof) do
  Begin
    Total := Total + _cdsItens.FieldByName('ValorTotal').AsFloat;
    subTotal := subTotal + RoundTo(cdsItens.FieldByName('Quantidade').AsFloat * cdsItens.FieldByName('ValorUnitario').AsFloat,-2);
    _cdsItens.Next();
  End;
  SetValorTotalItens(Total);
  SetValorBrutoItens(subTotal);
  _cdsItens.EnableControls();
End;

{$Endregion}


end.
