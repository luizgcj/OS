unit OrdemServicoService;

interface

Uses
  Winapi.Windows,
  System.SysUtils,
  Data.Db,
  Math,
  DataBase,
  OrdemServicoEntity,
  CtReceber,
  FormaPagamento,
  PlanoPagamento,
  Produto,
  Pessoa,
  Usuario;

Type TOrdemServicoService = Class

  Private
    _DataBase : TDataBase;
    _OrdemServico : TOrdemServicoEntity;
    _CtReceber : TCtReceber;
    _FormaPagamento : TFormaPagamento;
    _PlanoPagamento : TPlanoPagamento;
    _Usuario : TUsuario;

    Function GetEstoque(Produto : TProduto):Double;

  Public
    Procedure AddItem(Produto : TProduto; Cliente : TPessoa; Quantidade, PercDesconto, VrDesconto : Double);
    Procedure DeleteItem(Indice : Integer);
    Procedure GetItem(Produto : TProduto; Indice : Integer; Out Quantidade : Double);
    Function ValidaEstoque(Produto : TProduto; Quantidade : Double) : Boolean;
    Function ConsultaSetorUltimaOS():Integer;
    Function BuscaNumEnvelopeStudio(DataBase : TDataBase):Integer;
    Procedure GravaNumEnvelopeStudio(OrdemServico : TOrdemServicoEntity; DataBase : TDataBase);

    Function ConsultaOrdemServico():Boolean;
    Procedure AutoIncremento();
    Function Gravar(Cliente : TPessoa):Boolean;
    Function Cancelar():Boolean;

    Function ConfirmaEstoqueGeral():Boolean;
    Function ReciboPagamento(iNumOS : Integer; DataBase : TDataBase):TDataSet;
    Function EnvelopeLaranja(iNumOS : Integer; DataBase : TDataBase):TDataSet;
    Function EnvelopeAzul(iNumOS : Integer; DataBase : TDataBase):TDataSet;
    Procedure LiberarAcessoOS();

    Constructor Create(OrdemServico : TOrdemServicoEntity; CtReceber : TCtReceber; FormaPagamento : TFormaPagamento; PlanoPagamento : TPlanoPagamento; Usuario : TUsuario; DataBase : TDataBase);

End;

implementation

Uses
  CustomMessage,
  CustomExcept,
  Parametros,
  OrdemServicoRepository,
  ProdutoRepository,
  EstoqueRepository,
  UsuarioService,
  AutorizacaoEstoque;

{$Region 'OrdemServico'}

Constructor TOrdemServicoService.Create(OrdemServico : TOrdemServicoEntity; CtReceber : TCtReceber; FormaPagamento : TFormaPagamento; PlanoPagamento : TPlanoPagamento; Usuario : TUsuario; DataBase : TDataBase);
Begin
  Inherited Create();
  _OrdemServico := OrdemServico;
  _CtReceber := CtReceber;
  _FormaPagamento := FormaPagamento;
  _PlanoPagamento := PlanoPagamento;
  _Usuario := Usuario;
  _DataBase := DataBase;
End;

Function TOrdemServicoService.ConsultaOrdemServico():Boolean;
Begin
  Result := TOrdemServicoRepository.ConsultaOrdemServico(_OrdemServico, _CtReceber, _Usuario.Nome, _DataBase);
End;

Function TOrdemServicoService.ConsultaSetorUltimaOS():Integer;
Begin
  Result := TOrdemServicoRepository.ConsultaSetorUltimaOS(_Usuario,_DataBase);
End;

Procedure TOrdemServicoService.AutoIncremento();
Begin
  _OrdemServico.Id := TOrdemServicoRepository.AutoIncremento(_DataBase);
End;

Function TOrdemServicoService.Gravar(Cliente : TPessoa):Boolean;
Begin
  Result := TOrdemServicoRepository.Gravar(_OrdemServico, _CtReceber, _FormaPagamento, _PlanoPagamento, Cliente, _Usuario, _DataBase);
End;

Function TOrdemServicoService.ReciboPagamento(iNumOS : Integer; DataBase : TDataBase):TDataSet;
begin
  result := TOrdemServicoRepository.ReciboPagamento(iNumOS, DataBase);

end;

Function TOrdemServicoService.EnvelopeLaranja(iNumOS : Integer; DataBase : TDataBase):TDataSet;
begin
  result := TOrdemServicoRepository.EnvelopeLaranja(iNumOS, DataBase);

end;

Function TOrdemServicoService.BuscaNumEnvelopeStudio(DataBase : TDataBase):Integer;
begin
  result := TOrdemServicoRepository.BuscaNumEnvelopeStudio(DataBase);
end;

Procedure TOrdemServicoService.GravaNumEnvelopeStudio(OrdemServico : TOrdemServicoEntity; DataBase : TDataBase);
begin
  TOrdemServicoRepository.GravaNumEnvelopeStudio(OrdemServico, DataBase); 
end;

Function TOrdemServicoService.EnvelopeAzul(iNumOS : Integer; DataBase : TDataBase):TDataSet;
begin
  result := TOrdemServicoRepository.EnvelopeAzul(iNumOS, DataBase);

end;

Function TOrdemServicoService.Cancelar():Boolean;
Begin
  Result := TOrdemServicoRepository.Cancelar(_OrdemServico, _CtReceber, _DataBase);
End;

{$EndRegion}

{$Region 'Item'}

Procedure TOrdemServicoService.AddItem(Produto : TProduto; Cliente : TPessoa; Quantidade, PercDesconto, VrDesconto : Double);
Var
  DescriptionButtons : TDescriptionButtons;
  ValorTotalItensAux : Double;
  recNo : Integer;
Begin
  Try
    if _OrdemServico.cdsItens.Locate('ProdutoId', Produto.Id, []) then
    Begin
      DescriptionButtons := TDescriptionButtons.Create();
      DescriptionButtons.Yes := 'Substituir';
      DescriptionButtons.No := 'Somar';
      DescriptionButtons.Ok := 'Não Inserir';
      case TCustomMessage.Show('Produto ja inserido deseja:', 'Atenção!', TTypeMessage.Question, TButtons.YesNoOk, DescriptionButtons) of
        IdYes :
          Begin
            if (Not ValidaEstoque(Produto, Quantidade)) then
              Exit;
            _OrdemServico.cdsItens.Edit();
            _OrdemServico.cdsItens.FieldByName('Quantidade').AsFloat := Quantidade;
          End;
        IdNo :
          Begin
            if (Not ValidaEstoque(Produto, _OrdemServico.cdsItens.FieldByName('Quantidade').AsFloat + Quantidade)) then
              Exit;
            _OrdemServico.cdsItens.Edit();
            _OrdemServico.cdsItens.FieldByName('Quantidade').AsFloat := _OrdemServico.cdsItens.FieldByName('Quantidade').AsFloat + Quantidade;
          End;
        IdOk,
        IdCancel:
          Exit;
      end;
    End
    else
    Begin
      if (Not ValidaEstoque(Produto, Quantidade)) then
        Exit;
      _OrdemServico.cdsItens.Append();
      _OrdemServico.cdsItens.FieldByName('Quantidade').AsFloat := Quantidade;
    End;

    _OrdemServico.cdsItens.FieldByName('ProdutoId').AsInteger := Produto.Id;
    _OrdemServico.cdsItens.FieldByName('Produto').AsString := Produto.Nome;
    _OrdemServico.cdsItens.FieldByName('Tipo').AsString := Produto.Tipo;
    _OrdemServico.cdsItens.FieldByName('QuantidadeEmbalagem').AsFloat := Produto.QuantidadeEmbalagem;
    _OrdemServico.cdsItens.FieldByName('QuantidadeBaixa').AsFloat := _OrdemServico.cdsItens.FieldByName('Quantidade').AsFloat * _OrdemServico.cdsItens.FieldByName('QuantidadeEmbalagem').AsFloat;
    if Cliente.Profissional = 'S' then
      _OrdemServico.cdsItens.FieldByName('ValorUnitario').AsFloat := Produto.ValorUnitarioProfissional
    else
      _OrdemServico.cdsItens.FieldByName('ValorUnitario').AsFloat := Produto.ValorUnitarioAmador;

    if Cliente.TabelaPreco <> 0 then
    _OrdemServico.cdsItens.FieldByName('ValorUnitario').AsFloat := _OrdemServico.cdsItens.FieldByName('ValorUnitario').AsFloat
                                                                   * ((100 - Cliente.TabelaPreco) / 100);

    _OrdemServico.cdsItens.FieldByName('PercDesconto').AsFloat := PercDesconto;
    _OrdemServico.cdsItens.FieldByName('ValorDesconto').AsFloat := VrDesconto;
    ValorTotalItensAux := RoundTo(_OrdemServico.cdsItens.FieldByName('ValorUnitario').AsFloat * _OrdemServico.cdsItens.FieldByName('Quantidade').AsFloat - VrDesconto,-2);
    _OrdemServico.cdsItens.FieldByName('ValorTotal').AsFloat := ValorTotalItensAux;
    _OrdemServico.cdsItens.Post();

    _OrdemServico.ValorTotalItens := 0;
    _OrdemServico.ValorBrutoItens := 0;
    _OrdemServico.cdsItens.First;
    while not _OrdemServico.cdsItens.Eof do
    begin
      recNo := _OrdemServico.cdsItens.RecNo;
      _OrdemServico.ValorTotalItens := _OrdemServico.ValorTotalItens + _OrdemServico.cdsItens.FieldByName('ValorTotal').AsFloat;
      _OrdemServico.cdsItens.RecNo := recNo;
      _OrdemServico.ValorBrutoItens := _OrdemServico.ValorBrutoItens + RoundTo(_OrdemServico.cdsItens.FieldByName('Quantidade').AsFloat * _OrdemServico.cdsItens.FieldByName('ValorUnitario').AsFloat,-2) ;
      _OrdemServico.cdsItens.RecNo := recNo;
      _OrdemServico.cdsItens.Next;
    end;
  Except
    On e : Exception do
    Begin
      TCustomExcept.Show(e, 'Erro ao adicionar um item.');
    End;
  End;
End;

Procedure TOrdemServicoService.DeleteItem(Indice : Integer);
Begin
  if _OrdemServico.cdsItens.RecordCount = 0 then
    Exit;
  try
    _OrdemServico.cdsItens.RecNo := Indice;
    _OrdemServico.ValorTotalItens := _OrdemServico.ValorTotalItens - _OrdemServico.cdsItens.FieldByName('ValorTotal').AsFloat;
    _OrdemServico.cdsItens.Delete;
  Except
    On e : Exception do
    Begin
      TCustomExcept.Show(e, 'Erro ao excluir um item.');
    End;
  End;
End;

Procedure TOrdemServicoService.GetItem(Produto : TProduto; Indice : Integer; Out Quantidade : Double);
Begin
  if _OrdemServico.cdsItens.RecordCount = 0 then
    Exit;
  try
    _OrdemServico.cdsItens.RecNo := Indice;
    Produto.Id := _OrdemServico.cdsItens.FieldByName('ProdutoId').AsInteger;

    TProdutoRepository.Get(_DataBase,Produto);

    Produto.QuantidadeEmbalagem := _OrdemServico.cdsItens.FieldByName('QuantidadeEmbalagem').AsFloat;
    Produto.ValorUnitario := _OrdemServico.cdsItens.FieldByName('ValorUnitario').AsFloat;
    Quantidade := _OrdemServico.cdsItens.FieldByName('Quantidade').AsFloat;
  Except
    On e : Exception do
    Begin
      TCustomExcept.Show(e, 'Erro ao alterar um item.');
    End;
  End;
End;

Function TOrdemServicoService.GetEstoque(Produto : TProduto):Double;
Var
  custo : TCusto;
Begin
  Result := 0;
  if (TParametros.VerificaParametros('PRECOINVENTARIO','V',_DataBase) = 'CUSTOMEDIO') then
    custo := TCusto.CustoAtual
  else
    custo := TCusto.CustoMedio;

  Result := TEstoqueRepository.GetEstoque(Produto.Id, custo, _DataBase,_OrdemServico.Id);
End;

Function TOrdemServicoService.ValidaEstoque(Produto : TProduto; Quantidade : Double) : Boolean;
Var
  Estoque : Double;
Begin
  Result := False;

  Estoque := GetEstoque(Produto);

  if _OrdemServico.Alteracao then
  begin
    Estoque := Estoque + TOrdemServicoRepository.ConsultaQtdeItemOS(_OrdemServico.Id, Produto.Id, _DataBase);
  end;

  if TParametros.VerificaParametros('CONFIRMAESTOQUE','V', _DataBase) = 'S' then
  Begin
    if Quantidade > Estoque then
    Begin
      case TCustomMessage.Show('Quantidade de estoque não disponivel, confirma?'
              +chr(13)+' Estoque atual: '+ FloatToStr(Estoque)+' Quantidade: '+FloatToStr(Quantidade) ,
              'Atenção!', TTypeMessage.Question, TButtons.YesNo) of
        IdNo,
        IdCancel:
            Exit;
      end;

      if (not TUsuarioService.VerificaPermissao(_DataBase, _Usuario, 'LIBERACONFESTOQUE')) then
        Exit;

    End;
  End;
  Result := True;
End;

Function TOrdemServicoService.ConfirmaEstoqueGeral():Boolean;
var
  Produto : TProduto;
  estoque : Double;
Begin
  Result := False;
  FrAutorizacaoEstoque := TFrAutorizacaoEstoque.Create(Nil, _DataBase, _Usuario);
  _OrdemServico.cdsItens.First();
  while (Not _OrdemServico.cdsItens.Eof) do
  begin
    Produto := TProduto.Create();
    Produto.Id := _OrdemServico.cdsItens.FieldByName('ProdutoId').AsInteger;
    TProdutoRepository.Get(_DataBase, Produto, True);
    estoque := GetEstoque(Produto);
    if (_OrdemServico.cdsItens.FieldByName('Quantidade').AsFloat > Estoque) then
      FrAutorizacaoEstoque.AddItem(Produto, Estoque, _OrdemServico.cdsItens.FieldByName('Quantidade').AsFloat);
    _OrdemServico.cdsItens.Next();
  end;
  Result := FrAutorizacaoEstoque.Verify();
  FrAutorizacaoEstoque.Release();
End;
{$EndRegion}

Procedure TOrdemServicoService.LiberarAcessoOS();
begin
  TOrdemServicoRepository.LiberarAcessoOS(_OrdemServico, _DataBase);
end;



end.
