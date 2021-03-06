unit CtReceberRepository;

interface

Uses
  System.Variants,
  Data.Db,
  System.SysUtils,
  DataBase,
  CtReceber,
  PlanoPagamento,
  PlanoPagamentoService,
  FormaPagamento,
  Usuario,
  OrdemServicoEntity,
  ConexaoBanco,
  EnumConexao,
  CustomExcept,
  Parametros,
  Pessoa,
  Math;

Type TCtReceberRepository = Class Abstract
  Private


    Class Procedure SetNull(ConexaoBanco:TConexaoBanco; DataType : TFieldType; NomeCampo : String);
    Class Procedure SqlExcluirItens(ConexaoBanco : TConexaoBanco);
  Public
    Class Function AutoIncrementoCaixa(DataBase : TDataBase):Integer;
    Class Function AutoIncrementoCtReceber(DataBase : TDataBase):Integer;
    Class Function ConsultaCtReceber(OrdemServico : TOrdemServicoEntity; CtReceber : TCtReceber; DataBase : TDataBase):Boolean;
    Class Function GravarCaixa(OrdemServico : TOrdemServicoEntity; CtReceber : TCtReceber; Usuario : TUsuario; DataBase : TDataBase):Boolean;
    Class Function PesquisarPessoaNomeFantasia(iCodigo : Integer; DataBase : TDataBase):String;
    Class Function PesquisarPessoaRazaoSocial(iCodigo : Integer; DataBase : TDataBase):String;
    Class Function PesquisarTipoDocumento(iCodigo : Integer;DataBase : TDataBase):String;
    Class Function RecuperarExtensaoDaFatura(sDataEmissao : String; iParcela, iTotParcelas :Integer; DataBase : TDataBase):String;
    Class Function RetornarContagemDeLetras(iParcela:Integer):String;
    Class Procedure EstornarMaisCaixa(bCancelouOS : Boolean; OrdemServico : TOrdemServicoEntity; DataBase : TDataBase);
    Class Function VerificarFinanceiroQuitado(OrdemServico : TOrdemServicoEntity; DataBase : TDataBase; out sMessage : String):Boolean;
    Class Function GravarCtReceber(OrdemServico : TOrdemServicoEntity; CtReceber : TCtReceber; FormasPagamento : TFormaPagamento; Cliente : TPessoa; DataBase : TDataBase):Boolean;
    Class Function CalculaTaxaCartao(CtReceber : TCtReceber; OrdemServico : TOrdemServicoEntity) : Boolean;
    Class Function VerificaPlanoPagtoCartao(out CtReceber : TCtReceber; PlanoPagamento : TPlanoPagamento; OrdemServico : TOrdemServicoEntity; DataBase : TDataBase; out sMessage : String):Boolean;
    Class Procedure GravarCtPagarCartao(OrdemServico : TOrdemServicoEntity; CtReceber : TCtReceber; PlanoPagamento : TPlanoPagamento; FormaPagamento : TFormaPagamento; Cliente : TPessoa; DataBase : TDataBase);
    Class Function AutoIncrementoCtPagar(DataBase : TDataBase):Integer;
    Class Function EstornarContasaReceber(bCancelarOS : Boolean; OrdemServico : TOrdemServicoEntity; DataBase : TDataBase):Boolean;
    Class Procedure EstornarTaxaCartao(bCancelarOS : Boolean; OrdemServico : TOrdemServicoEntity; CtReceber : TCtReceber; DataBase : TDataBase);
    Class Function Cancelar(OrdemServico : TOrdemServicoEntity; CtReceber : TCtReceber; DataBase: TDataBase):Boolean;
    Class Procedure GravarContas(Database : TDatabase; OrdemServico : TOrdemServicoEntity; Cliente : TPessoa; CtReceber : TCtReceber;  Index, NumeroLancamento : Integer);
    Class Procedure GravarPlanoContas(Database : TDatabase; NumeroLancamento, Index, Sequencial : Integer; CtReceber : TCtReceber);
    Class Procedure GravarFormasPagamentoContasReceber(Database : TDatabase; CtReceber : TCtReceber; Index : Integer; OrdemServico : TOrdemServicoEntity);
    Class Function AutoIncrementoContas(Database : TDatabase): integer;
End;

implementation




Class Function TCtReceberRepository.AutoIncrementoCaixa(DataBase : TDataBase):Integer;
Var
  ConexaoBanco : TConexaoBanco;
Begin
  Result := 0;
  ConexaoBanco := TConexaoBanco.Create(DataBase);
  try
    ConexaoBanco.SQL.Add('SELECT                                     ');
    ConexaoBanco.SQL.Add('COALESCE(MAX(CODMOVIM),0) + 1 AS ID        ');
    ConexaoBanco.SQL.Add('FROM CAIXAMOVIM                            ');

    Result := ConexaoBanco.DataSetFactory.GetDataSet(TConexao.BaseDados, ConexaoBanco.Sql.Text, ConexaoBanco.Param).FieldByName('Id').AsInteger;
  Except
    On E : Exception do
    Begin
      TCustomExcept.Show(e, 'Erro ao tentar executar AutoIncremento');
    End;
  End;
End;

Class Function TCtReceberRepository.AutoIncrementoCtReceber(DataBase : TDataBase):Integer;
Var
  ConexaoBanco : TConexaoBanco;
Begin
  Result := 0;
  ConexaoBanco := TConexaoBanco.Create(DataBase);
  try
    ConexaoBanco.SQL.Add('SELECT                                     ');
    ConexaoBanco.SQL.Add('COALESCE(MAX(CODIGORECEBER),0) + 1 AS ID   ');
    ConexaoBanco.SQL.Add('FROM DGLOB210                              ');

    Result := ConexaoBanco.DataSetFactory.GetDataSet(TConexao.Empresa, ConexaoBanco.Sql.Text, ConexaoBanco.Param).FieldByName('Id').AsInteger;
  Except
    On E : Exception do
    Begin
      TCustomExcept.Show(e, 'Erro ao tentar executar AutoIncremento');
    End;
  End;
End;

Class Function TCtReceberRepository.AutoIncrementoCtPagar(DataBase : TDataBase):Integer;
Var
  ConexaoBanco : TConexaoBanco;
Begin
  Result := 0;
  ConexaoBanco := TConexaoBanco.Create(DataBase);
  try
    ConexaoBanco.SQL.Add('SELECT                                     ');
    ConexaoBanco.SQL.Add('COALESCE(MAX(CODIGOPAGAR),0) + 1 AS ID     ');
    ConexaoBanco.SQL.Add('FROM DGLOB220                              ');

    Result := ConexaoBanco.DataSetFactory.GetDataSet(TConexao.Empresa, ConexaoBanco.Sql.Text, ConexaoBanco.Param).FieldByName('Id').AsInteger;
  Except
    On E : Exception do
    Begin
      TCustomExcept.Show(e, 'Erro ao tentar executar AutoIncremento');
    End;
  End;
End;

Class Function TCtReceberRepository.AutoIncrementoContas(DataBase : TDataBase):Integer;
Var
  ConexaoBanco : TConexaoBanco;
Begin
  Result := 0;
  ConexaoBanco := TConexaoBanco.Create(DataBase);
  try
    ConexaoBanco.SQL.Add('SELECT COALESCE(MAX(NUMEROLANCAMENTO),0) + 1 AS ID FROM CONTAS');

    Result := ConexaoBanco.DataSetFactory.GetDataSet(TConexao.Empresa, ConexaoBanco.Sql.Text).FieldByName('Id').AsInteger;
  Except
    On E : Exception do
    Begin
      TCustomExcept.Show(e, 'Erro ao tentar executar AutoIncremento');
    End;
  End;
End;

Class Function TCtReceberRepository.PesquisarPessoaNomeFantasia(iCodigo : Integer; DataBase : TDataBase):String;
Var
  ConexaoBanco : TConexaoBanco;
Begin
  Result := '';
  ConexaoBanco := TConexaoBanco.Create(DataBase);
  try
    ConexaoBanco.SQL.Add('SELECT                                     ');
    ConexaoBanco.SQL.Add('PESSOANOMEFANTASIA                         ');
    ConexaoBanco.SQL.Add('FROM PESSOA                                ');
    ConexaoBanco.SQL.Add('WHERE PESSOACODIGO = :CODIGO               ');

    ConexaoBanco.Param.ParamByName('CODIGO').AsInteger := iCodigo;

    Result := ConexaoBanco.DataSetFactory.GetDataSet(TConexao.Empresa, ConexaoBanco.Sql.Text, ConexaoBanco.Param).FieldByName('PESSOANOMEFANTASIA').AsString;
  Except
    On E : Exception do
    Begin
      TCustomExcept.Show(e, 'Erro ao tentar executar AutoIncremento');
    End;
  End;
End;

Class Function TCtReceberRepository.PesquisarPessoaRazaoSocial(iCodigo : Integer; DataBase : TDataBase):String;
Var
  ConexaoBanco : TConexaoBanco;
Begin
  Result := '';
  ConexaoBanco := TConexaoBanco.Create(DataBase);
  try
    ConexaoBanco.SQL.Add('SELECT                                     ');
    ConexaoBanco.SQL.Add('PESSOANOME                                 ');
    ConexaoBanco.SQL.Add('FROM PESSOA                                ');
    ConexaoBanco.SQL.Add('WHERE PESSOACODIGO = :CODIGO               ');

    ConexaoBanco.Param.ParamByName('CODIGO').AsInteger := iCodigo;

    Result := ConexaoBanco.DataSetFactory.GetDataSet(TConexao.Empresa, ConexaoBanco.Sql.Text, ConexaoBanco.Param).FieldByName('PESSOANOME').AsString;
  Except
    On E : Exception do
    Begin
      TCustomExcept.Show(e, 'Erro ao tentar executar AutoIncremento');
    End;
  End;
End;

Class Function TCtReceberRepository.PesquisarTipoDocumento(iCodigo : Integer; DataBase : TDataBase):String;
Var
  ConexaoBanco : TConexaoBanco;
Begin
  Result := '';
  ConexaoBanco := TConexaoBanco.Create(DataBase);
  try
    ConexaoBanco.SQL.Add('SELECT                                     ');
    ConexaoBanco.SQL.Add('DESCRICTIPO                                ');
    ConexaoBanco.SQL.Add('FROM DGLOB040                              ');
    ConexaoBanco.SQL.Add('WHERE CODIGOTIPO = :CODIGOTIPO             ');

    ConexaoBanco.Param.ParamByName('CODIGOTIPO').AsInteger := iCodigo;
    Result := ConexaoBanco.DataSetFactory.GetDataSet(TConexao.Empresa, ConexaoBanco.Sql.Text, ConexaoBanco.Param).FieldByName('DESCRICTIPO').AsString;
  Except
    On E : Exception do
    Begin
      TCustomExcept.Show(e, 'Erro ao tentar executar AutoIncremento');
    End;
  End;
End;



Class Function TCtReceberRepository.ConsultaCtReceber(OrdemServico : TOrdemServicoEntity; CtReceber : TCtReceber; DataBase : TDataBase):Boolean;
Var
  ConexaoBanco : TConexaoBanco;
  DataSet : TDataSet;
  iItem : Integer;
Begin
  Result := False;
  Try
    ConexaoBanco := TConexaoBanco.Create(DataBase);
    ConexaoBanco.SQL.Add('SELECT                                                                                            ');
    ConexaoBanco.SQL.Add('CODIGORECEBER,                                                                                    ');
    ConexaoBanco.SQL.Add('VENCIMENRECEBER - EMISSAORECEBER AS DIASPARCELA,                                                  ');
    ConexaoBanco.SQL.Add('VENCIMENRECEBER,                                                                                  ');
    ConexaoBanco.SQL.Add('NUMERORECEBER,                                                                                    ');
    ConexaoBanco.SQL.Add('VALORRECEBER, SINALOS                                                                             ');
    ConexaoBanco.SQL.Add('FROM DGLOB210                                                                                     ');
    ConexaoBanco.SQL.Add('WHERE                                                                                             ');
    ConexaoBanco.SQL.Add('NUMOS = :ID                                                                                       ');
    ConexaoBanco.SQL.Add('AND CODIGOEMP = :CODIGOEMP                                                                        ');

    ConexaoBanco.Param.ParamByName('Id').AsInteger := OrdemServico.Id;
    ConexaoBanco.Param.ParamByName('CodigoEmp').AsInteger := DataBase.CodigoEmpresa;

    DataSet := ConexaoBanco.DataSetFactory.GetDataSet(TConexao.Empresa, ConexaoBanco.sql.Text, ConexaoBanco.Param);

    DataSet.First();
    if (Not DataSet.Eof) then
    Begin
      iItem := 1;
      while (Not DataSet.Eof) do
      Begin
        CtReceber.cdsCtRec.Append();
        CtReceber.cdsCtRec.FieldByName('Item').AsInteger            := iItem;
        CtReceber.cdsCtRec.FieldByName('NumDocumento').AsString     := DataSet.FieldByName('NUMERORECEBER').AsString;
        CtReceber.cdsCtRec.FieldByName('DiasParcela').AsInteger     := DataSet.FieldByName('DIASPARCELA').AsInteger;
        CtReceber.cdsCtRec.FieldByName('DataVencimento').AsDateTime := DataSet.FieldByName('VENCIMENRECEBER').AsDateTime;
        CtReceber.cdsCtRec.FieldByName('ValorDocumento').AsFloat    := DataSet.FieldByName('VALORRECEBER').AsFloat;
        CtReceber.cdsCtRec.FieldByName('Sinal').AsString            := DataSet.FieldByName('SINALOS').AsString;
        CtReceber.cdsCtRec.Post();
        DataSet.Next();
        Inc(iItem);
      End;
      Result := True;
    End;
  Except
    On e : Exception do
    Begin
      TCustomExcept.Show(e, 'Erro ao consultar Ordem de Servi�o');
    End;
  End;
End;

Class Function TCtReceberRepository.GravarCtReceber(OrdemServico : TOrdemServicoEntity; CtReceber : TCtReceber; FormasPagamento : TFormaPagamento; Cliente : TPessoa; DataBase : TDataBase):Boolean;
Var
  ConexaoBanco : TConexaoBanco;
  Gravou : Boolean;
  iTentativas, NumeroLancamento, Sequencial : Integer;
begin
  Result := False;
  Gravou := False;
  iTentativas := 1;
  Sequencial := 1;

  ConexaoBanco := TConexaoBanco.Create(DataBase);
  while (Not Gravou)and(iTentativas <= 10) do
  begin
    Try
      if (OrdemServico.Alteracao) and (not OrdemServico.OrcamentoAnterior) then
      begin
        if (((OrdemServico.Situacao = 'A') and (OrdemServico.ValorSinal <> OrdemServico.ValorSinalAnterior) or
                                               (OrdemServico.FormaPagtoId <> OrdemServico.FormaPagtoIdAnterior )) or
           ((OrdemServico.Situacao = 'E') and (OrdemServico.Situacao = OrdemServico.SituacaoAnterior)))
           or (OrdemServico.PedidoRapido) then
        begin
          EstornarTaxaCartao(False, OrdemServico, CtReceber, DataBase);
          EstornarContasaReceber(False, OrdemServico, DataBase);
        end;
      end;

      if not OrdemServico.PedidoRapido then
      begin
        if (OrdemServico.Alteracao) and (not OrdemServico.OrcamentoAnterior) then
        begin
          if ((OrdemServico.Situacao = 'A') and (OrdemServico.ValorSinal = OrdemServico.ValorSinalAnterior) and
                                                (OrdemServico.FormaPagtoId = OrdemServico.FormaPagtoIdAnterior )) then
          begin
            result := True;
            Exit;
          end;
        end;
      end;
      ConexaoBanco.Clear;
      ConexaoBanco.ClearParam;
      ConexaoBanco.SQL.Text := 'INSERT INTO DGLOB210(CODIGORECEBER,LANCAMENRECEBER,'
      + 'NUMERORECEBER,NOTARECEBER,CODIGOCLIENTE,CODIGOVENDEDOR,CODIGOPLANODECONTAS,'
      + 'EMISSAORECEBER,VALORRECEBER,VENCIMENRECEBER,CODIGOTIPO,CODIGOBANCO,'
      + 'CODIGOSITUACAO,PAGAMENRECEBER,PAGORECEBER,MEMORECEBER,FLUXOCAIXARECEBER,'
      + 'CODIGOFORMAPAG,DEBITOCREDITO,'
      + 'NUMEROLANCAMENTO,DATALANCAMENTO,CODIGOMOEDARECEBER,'
      + 'HISTORICO,'
      + 'NUMOS,NPARCELA,'
      + 'NTOTPARCELA,VRTOTDOCUMENTO,'
      + 'HISTORICOCONTAS,'
      + 'CODIGOEMP,'
      + 'CODMOVCARTAO,TAXAADMCARTAO,DOCGERACONTRIBUICAO,CODPRODUTO,CODCENTROCUSTO,'
      + 'VALORORIGINAL,CODAGENDA,LOTECOBRANCA,LOTECTREC,NUMFATLOC,'
      + 'NUM_AUTORIZACAO_CARTAO,MAQUINA_DE_CARTAO,PARCELA_CARTAO,'
      + 'PENDENCIAFINANCEIRA,SINALOS) '
      + 'VALUES(:CODIGORECEBER,:LANCAMENRECEBER,:NUMERORECEBER,:NOTARECEBER,'
      + ':CODIGOCLIENTE,:CODIGOVENDEDOR,:CODIGOPLANODECONTAS,:EMISSAORECEBER,'
      + ':VALORRECEBER,:VENCIMENRECEBER,:CODIGOTIPO,:CODIGOBANCO,:CODIGOSITUACAO,'
      + ':PAGAMENRECEBER,:PAGORECEBER,:MEMORECEBER,:FLUXOCAIXARECEBER,'
      + ':CODIGOFORMAPAG,:DEBITOCREDITO,:NUMEROLANCAMENTO,:DATALANCAMENTO,:CODIGOMOEDARECEBER,'
      + ':HISTORICO,:NUMOS,:NPARCELA,:NTOTPARCELA,:VRTOTDOCUMENTO,'
      + ':HISTORICOCONTAS,:CODIGOEMP,'
      + ':CODMOVCARTAO,:TAXAADMCARTAO,:DOCGERACONTRIBUICAO,:CODPRODUTO,:CODCENTROCUSTO,'
      + ':VALORORIGINAL,:CODAGENDA,:LOTECOBRANCA,:LOTECTREC,:NUMFATLOC,'
      + ':NUM_AUTORIZACAO_CARTAO,:MAQUINA_DE_CARTAO,:PARCELA_CARTAO,'
      + ':PENDENCIAFINANCEIRA,:SINALOS) ';

      CtReceber.cdsCtRec.Filtered := False;
      if not OrdemServico.PedidoRapido then
      begin
        if OrdemServico.Situacao = 'A' then
          CtReceber.cdsCtRec.Filter := 'Sinal = ''S'' '
        else
          CtReceber.cdsCtRec.Filter := 'Sinal <> ''S'' ';
        CtReceber.cdsCtRec.Filtered := True;
        CtReceber.cdsCtRec.First;
      end;
      while (Not CtReceber.cdsCtRec.Eof) do
      Begin
        ConexaoBanco.ClearParam();

        ConexaoBanco.Param.ParamByName('CODIGORECEBER').AsInteger := AutoIncrementoCtReceber(DataBase);
        CtReceber.cdsCtRec.Edit;
        CtReceber.cdsCtRec.FieldByName('CodigoReceber').AsInteger := ConexaoBanco.Param.ParamByName('CODIGORECEBER').AsInteger;
        CtReceber.cdsCtRec.Post;
        ConexaoBanco.Param.ParamByName('LANCAMENRECEBER').AsDateTime := Date;
        ConexaoBanco.Param.ParamByName('NOTARECEBER').AsString := IntToStr(OrdemServico.Id);
        ConexaoBanco.Param.ParamByName('CODIGOCLIENTE').AsInteger := OrdemServico.ClienteId;
        ConexaoBanco.Param.ParamByName('CODIGOVENDEDOR').AsInteger := OrdemServico.VendedorId;

        ConexaoBanco.Param.ParamByName('EMISSAORECEBER').AsDateTime := OrdemServico.DataEmissao;
        ConexaoBanco.Param.ParamByName('VALORRECEBER').AsFloat := CtReceber.cdsCtRec.FieldByName('VALORDOCUMENTO').AsFloat;

        ConexaoBanco.Param.ParamByName('CODIGOTIPO').AsInteger := StrToInt(TParametros.VerificaParametros('CODTIPODOCOS','I', DataBase));

        if FormasPagamento.Cartao = 'S' then
        begin
          if CtReceber.AutorizacaoOperadora <> '' then
            ConexaoBanco.Param.ParamByName('NUMERORECEBER').AsString := 'O.S. ' + CtReceber.AutorizacaoOperadora
          else
            ConexaoBanco.Param.ParamByName('NUMERORECEBER').AsString := CtReceber.cdsCtRec.FieldByName('NumDocumento').AsString;
          ConexaoBanco.Param.ParamByName('CODIGOFORMAPAG').AsInteger :=  OrdemServico.PlanoPagtoId;
          ConexaoBanco.Param.ParamByName('TAXAADMCARTAO').AsFloat := CtReceber.TxAdmin;
          if CtReceber.MaquinaCartao <> 0 then
            ConexaoBanco.Param.ParamByName('MAQUINA_DE_CARTAO').AsInteger := CtReceber.MaquinaCartao
          else
          begin
            ConexaoBanco.Param.ParamByName('MAQUINA_DE_CARTAO').DataType := ftInteger;
            ConexaoBanco.Param.ParamByName('MAQUINA_DE_CARTAO').Value := null;
          end;
          ConexaoBanco.Param.ParamByName('PARCELA_CARTAO').AsInteger := StrToInt(CtReceber.cdsCtRec.FieldByName('Item').AsString);
          ConexaoBanco.Param.ParamByName('NUM_AUTORIZACAO_CARTAO').AsString := CtReceber.AutorizacaoOperadora;
          ConexaoBanco.Param.ParamByName('MEMORECEBER').AsString := 'TITULAR DO CART�O: ' + CtReceber.TitularCartao;
          ConexaoBanco.Param.ParamByName('VENCIMENRECEBER').AsDateTime := CtReceber.cdsCtRec.FieldByName('DataVencimento').AsDateTime;
          ConexaoBanco.Param.ParamByName('CODIGOBANCO').AsInteger := CtReceber.CodContaAux;
          ConexaoBanco.Param.ParamByName('CODIGOPLANODECONTAS').AsInteger := CtReceber.CodPlanoCtCred;
          ConexaoBanco.Param.ParamByName('HISTORICOCONTAS').AsString := Copy('CTR: ' + ConexaoBanco.Param.ParamByName('CODIGORECEBER').AsString +
                                                                FormatFloat('000000',OrdemServico.ClienteId) + Cliente.Nome + ' -' + CtReceber.PlanoCtCred +
                                                                'O.S. '  + FormatFloat('000000',OrdemServico.Id),1,100);
        end
        else
        begin
          if Copy(CtReceber.cdsCtRec.FieldByName('NumDocumento').AsString,1,4) <> 'O.S.' then
            ConexaoBanco.Param.ParamByName('NUMERORECEBER').AsString := 'O.S. ' + CtReceber.cdsCtRec.FieldByName('NumDocumento').AsString
          else
            ConexaoBanco.Param.ParamByName('NUMERORECEBER').AsString := CtReceber.cdsCtRec.FieldByName('NumDocumento').AsString;
          ConexaoBanco.Param.ParamByName('CODIGOFORMAPAG').AsInteger :=  OrdemServico.PlanoPagtoId;
          ConexaoBanco.Param.ParamByName('TAXAADMCARTAO').AsFloat := 0;
          ConexaoBanco.Param.ParamByName('MAQUINA_DE_CARTAO').DataType := ftInteger;
          ConexaoBanco.Param.ParamByName('MAQUINA_DE_CARTAO').Value := null;
          ConexaoBanco.Param.ParamByName('PARCELA_CARTAO').DataType := ftInteger;
          ConexaoBanco.Param.ParamByName('PARCELA_CARTAO').Value := null;
          ConexaoBanco.Param.ParamByName('NUM_AUTORIZACAO_CARTAO').AsString := '';
          ConexaoBanco.Param.ParamByName('MEMORECEBER').AsString := '';
          ConexaoBanco.Param.ParamByName('VENCIMENRECEBER').AsDateTime := CtReceber.cdsCtRec.FieldByName('DataVencimento').AsDateTime;
          ConexaoBanco.Param.ParamByName('CODIGOBANCO').AsInteger := StrToInt(TParametros.VerificaParametros('CODCONTAOS', 'I', DataBase));
          ConexaoBanco.Param.ParamByName('CODIGOPLANODECONTAS').AsInteger := StrToInt(TParametros.VerificaParametros('CODPLANODECONTASOS','I', DataBase));
          ConexaoBanco.Param.ParamByName('HISTORICOCONTAS').AsString := 'CTR: ' +
                              ConexaoBanco.Param.ParamByName('CODIGORECEBER').AsString +
                              FormatFloat('000000',OrdemServico.ClienteId) +
                              Cliente.Nome +
                              'O.S. ' + IntToStr(OrdemServico.Id);
        end;

        if FormasPagamento.BaixaAutomatica then
        begin
          ConexaoBanco.Param.ParamByName('CODIGOSITUACAO').AsInteger := 2;
          ConexaoBanco.Param.ParamByName('PAGAMENRECEBER').Value := Date;
          ConexaoBanco.Param.ParamByName('PAGORECEBER').Value := CtReceber.cdsCtRec.FieldByName('ValorDocumento').AsFloat;
          NumeroLancamento := AutoIncrementoContas(Database);
          GravarContas(Database, OrdemServico, Cliente, CtReceber, CtReceber.cdsCtRec.RecNo, NumeroLancamento);
          GravarPlanoContas(Database, NumeroLancamento, CtReceber.cdsCtRec.RecNo, Sequencial, CtReceber);
        end
        else
        begin
          ConexaoBanco.Param.ParamByName('CODIGOSITUACAO').AsInteger := 1;
          ConexaoBanco.Param.ParamByName('PAGAMENRECEBER').DataType := ftDateTime;
          ConexaoBanco.Param.ParamByName('PAGAMENRECEBER').Value := null;
          ConexaoBanco.Param.ParamByName('PAGORECEBER').DataType := ftFloat;
          ConexaoBanco.Param.ParamByName('PAGORECEBER').Value := null;
        end;

        ConexaoBanco.Param.ParamByName('FLUXOCAIXARECEBER').AsString := 'S';
        ConexaoBanco.Param.ParamByName('BOLETORECEBER').AsString := '';
        ConexaoBanco.Param.ParamByName('EMISSAOBOLETORECEBER').DataType := ftDateTime;
        ConexaoBanco.Param.ParamByName('EMISSAOBOLETORECEBER').Value := null;
        ConexaoBanco.Param.ParamByName('FATURARECEBER').AsString := '';
        ConexaoBanco.Param.ParamByName('EMISSAOFATURARECEBER').DataType := ftDateTime;
        ConexaoBanco.Param.ParamByName('EMISSAOFATURARECEBER').Value := null;

        ConexaoBanco.Param.ParamByName('DEBITOCREDITO').AsString := 'C';
        ConexaoBanco.Param.ParamByName('NUMEROLANCAMENTO').DataType := ftInteger;
        ConexaoBanco.Param.ParamByName('NUMEROLANCAMENTO').Value := null;
        ConexaoBanco.Param.ParamByName('DATALANCAMENTO').DataType := ftDateTime;
        ConexaoBanco.Param.ParamByName('DATALANCAMENTO').Value := null;
        ConexaoBanco.Param.ParamByName('CODIGOMOEDARECEBER').AsInteger := OrdemServico.FormaPagtoId;
        ConexaoBanco.Param.ParamByName('HISTORICO').AsBlob := '';
        ConexaoBanco.Param.ParamByName('NUMOS').AsInteger := OrdemServico.Id;
        ConexaoBanco.Param.ParamByName('NPARCELA').AsInteger := StrToInt(CtReceber.cdsCtRec.FieldByName('Item').AsString);
        ConexaoBanco.Param.ParamByName('NTOTPARCELA').AsInteger := CtReceber.cdsCtRec.RecordCount;
        ConexaoBanco.Param.ParamByName('VRTOTDOCUMENTO').AsFloat := OrdemServico.ValorTotal;

        ConexaoBanco.Param.ParamByName('CODIGOEMP').AsInteger := DataBase.CodigoEmpresa;
        ConexaoBanco.Param.ParamByName('CODMOVCARTAO').DataType := ftInteger;
        ConexaoBanco.Param.ParamByName('CODMOVCARTAO').Value := null;

        ConexaoBanco.Param.ParamByName('DOCGERACONTRIBUICAO').AsString := 'N';
        ConexaoBanco.Param.ParamByName('CODPRODUTO').AsInteger := 0;
        ConexaoBanco.Param.ParamByName('CODCENTROCUSTO').AsInteger := 0;
        ConexaoBanco.Param.ParamByName('VALORORIGINAL').AsFloat := CtReceber.cdsCtRec.FieldByName('ValorDocumento').AsFloat;
        ConexaoBanco.Param.ParamByName('CODAGENDA').AsInteger := 0;
        ConexaoBanco.Param.ParamByName('LOTECOBRANCA').AsInteger := 0;
        ConexaoBanco.Param.ParamByName('LOTECTREC').AsInteger := 0;
        ConexaoBanco.Param.ParamByName('NUMFATLOC').AsInteger := 0  ;


        ConexaoBanco.Param.ParamByName('PENDENCIAFINANCEIRA').AsInteger := 0;
        if (OrdemServico.Situacao = 'A') and (not OrdemServico.PedidoRapido) then
          ConexaoBanco.Param.ParamByName('SINALOS').AsString := 'S'
        else
          ConexaoBanco.Param.ParamByName('SINALOS').AsString := 'N';
        ConexaoBanco.DataSetFactory.PostDataSet(TConexao.Empresa, ConexaoBanco.sql.Text , ConexaoBanco.Param);
        //if FormasPagamento.BaixaAutomatica then
          GravarFormasPagamentoContasReceber(Database, CtReceber, CtReceber.cdsCtRec.RecNo, OrdemServico);
        CtReceber.cdsCtRec.Next;
        Gravou := True;
      end;
    Except
      On E : Exception do
      Begin
        result := False;
        Gravou := False;
        TCustomExcept.Show(e, 'Erro ao Gravar OrdemServico => Tentativa : '+IntToStr(iTentativas), False);
        inc(iTentativas);
      End;
    End;
  End;
  result := Gravou;
end;

Class Function TCtReceberRepository.GravarCaixa(OrdemServico : TOrdemServicoEntity; CtReceber : TCtReceber; Usuario : TUsuario; DataBase : TDataBase):Boolean;
Var
  ConexaoBanco : TConexaoBanco;
  Gravou : Boolean;
  iTentativas : Integer;
Begin
  Result := False;
  Gravou := False;
  iTentativas := 1;

  ConexaoBanco := TConexaoBanco.Create(DataBase);
  while (Not Gravou)and(iTentativas <= 10) do
  Begin
    Try
      ConexaoBanco.DataSetFactory.StartTransaction(TConexao.BaseDados);


      if (OrdemServico.Alteracao) and (not OrdemServico.OrcamentoAnterior) then
      begin

        if (((OrdemServico.Situacao = 'A') and (OrdemServico.ValorSinal <> OrdemServico.ValorSinalAnterior) or
                                               (OrdemServico.FormaPagtoId <> OrdemServico.FormaPagtoIdAnterior)) or
           ((OrdemServico.Situacao = 'E') and (OrdemServico.Situacao = OrdemServico.SituacaoAnterior)))
           or (OrdemServico.PedidoRapido) then
          EstornarMaisCaixa(False, OrdemServico, DataBase)
        else if (OrdemServico.Situacao <> 'E') then
        begin
          ConexaoBanco.DataSetFactory.RollBack(TConexao.BaseDados);
          Gravou := True;
          result := True;
          Exit;
        end;
        {$EndRegion}
      end;


      {$Region 'Insert'}
      ConexaoBanco.SQL.Add('INSERT INTO CAIXAMOVIM (                       ');
      ConexaoBanco.SQL.Add('CODMOVIM,                                      ');
      ConexaoBanco.SQL.Add('CODEMPRESA,                                    ');
      ConexaoBanco.SQL.Add('NDOC,                                          ');
      ConexaoBanco.SQL.Add('DTEMISSAO,                                     ');
      ConexaoBanco.SQL.Add('HORAEMISSAO,                                   ');
      ConexaoBanco.SQL.Add('CODCLI,                                        ');
      ConexaoBanco.SQL.Add('NOMECLI,                                       ');
      ConexaoBanco.SQL.Add('VRDOC,                                         ');
      ConexaoBanco.SQL.Add('CODVENDEDOR,                                   ');
      ConexaoBanco.SQL.Add('APELIDOVENDEDOR,                               ');
      ConexaoBanco.SQL.Add('OBS,                                           ');
      ConexaoBanco.SQL.Add('SITUACAO,                                      ');
      ConexaoBanco.SQL.Add('TIPO,                                          ');
      ConexaoBanco.SQL.Add('EXTDOC,                                        ');
      ConexaoBanco.SQL.Add('CODPLANOPAGAMENTO,                             ');
      ConexaoBanco.SQL.Add('DTVENCIMENTO,                                  ');
      ConexaoBanco.SQL.Add('DIASPARCELA,                                   ');
      ConexaoBanco.SQL.Add('TIPODOC,                                       ');
      ConexaoBanco.SQL.Add('CODCONTA,                                      ');
      ConexaoBanco.SQL.Add('CODPLANOCONTAS,                                ');
      ConexaoBanco.SQL.Add('DESCRICTIPO,                                   ');
      ConexaoBanco.SQL.Add('PARCELA,                                       ');
      ConexaoBanco.SQL.Add('TOTALPARCELAS,                                 ');
      ConexaoBanco.SQL.Add('VALORTOTAL,                                    ');
      ConexaoBanco.SQL.Add('CODFORMAPAGPADRAO,                             ');
      ConexaoBanco.SQL.Add('TITULARCARTAO,                                 ');
      ConexaoBanco.SQL.Add('VALORTAXA,                                     ');
      ConexaoBanco.SQL.Add('AUTOPERADORA,                                  ');
      ConexaoBanco.SQL.Add('NUMLOTEOS,                                     ');
      ConexaoBanco.SQL.Add('VRTOTALFORMA,                                  ');
      ConexaoBanco.SQL.Add('CHEQUE,                                        ');
      ConexaoBanco.SQL.Add('MAQUINA_DE_CARTAO,                             ');
      ConexaoBanco.SQL.Add('PARCELA_CARTAO,                                ');
      ConexaoBanco.SQL.Add('SINALOS                                        ');
      ConexaoBanco.SQL.Add(') VALUES (                                      ');
      ConexaoBanco.SQL.Add(':CODMOVIM,                                      ');
      ConexaoBanco.SQL.Add(':CODEMPRESA,                                    ');
      ConexaoBanco.SQL.Add(':NDOC,                                          ');
      ConexaoBanco.SQL.Add(':DTEMISSAO,                                     ');
      ConexaoBanco.SQL.Add(':HORAEMISSAO,                                   ');
      ConexaoBanco.SQL.Add(':CODCLI,                                        ');
      ConexaoBanco.SQL.Add(':NOMECLI,                                       ');
      ConexaoBanco.SQL.Add(':VRDOC,                                         ');
      ConexaoBanco.SQL.Add(':CODVENDEDOR,                                   ');
      ConexaoBanco.SQL.Add(':APELIDOVENDEDOR,                               ');
      ConexaoBanco.SQL.Add(':OBS,                                           ');
      ConexaoBanco.SQL.Add(':SITUACAO,                                      ');
      ConexaoBanco.SQL.Add(':TIPO,                                          ');
      ConexaoBanco.SQL.Add(':EXTDOC,                                        ');
      ConexaoBanco.SQL.Add(':CODPLANOPAGAMENTO,                             ');
      ConexaoBanco.SQL.Add(':DTVENCIMENTO,                                  ');
      ConexaoBanco.SQL.Add(':DIASPARCELA,                                   ');
      ConexaoBanco.SQL.Add(':TIPODOC,                                       ');
      ConexaoBanco.SQL.Add(':CODCONTA,                                      ');
      ConexaoBanco.SQL.Add(':CODPLANOCONTAS,                                ');
      ConexaoBanco.SQL.Add(':DESCRICTIPO,                                   ');
      ConexaoBanco.SQL.Add(':PARCELA,                                       ');
      ConexaoBanco.SQL.Add(':TOTALPARCELAS,                                 ');
      ConexaoBanco.SQL.Add(':VALORTOTAL,                                    ');
      ConexaoBanco.SQL.Add(':CODFORMAPAGPADRAO,                             ');
      ConexaoBanco.SQL.Add(':TITULARCARTAO,                                 ');
      ConexaoBanco.SQL.Add(':VALORTAXA,                                     ');
      ConexaoBanco.SQL.Add(':AUTOPERADORA,                                  ');
      ConexaoBanco.SQL.Add(':NUMLOTEOS,                                     ');
      ConexaoBanco.SQL.Add(':VRTOTALFORMA,                                  ');
      ConexaoBanco.SQL.Add(':CHEQUE,                                        ');
      ConexaoBanco.SQL.Add(':MAQUINA_DE_CARTAO,                             ');
      ConexaoBanco.SQL.Add(':PARCELA_CARTAO,                                ');
      ConexaoBanco.SQL.Add(':SINALOS                                        ');
      ConexaoBanco.SQL.Add(')                                               ');
      {$EndRegion}


      {$Region 'ParamByName CAIXAMOVIM'}
      if (OrdemServico.Situacao = 'A') and (not OrdemServico.PedidoRapido) then
      begin
        ConexaoBanco.ClearParam();
        ConexaoBanco.Param.ParamByName('CODMOVIM').AsInteger := AutoIncrementoCaixa(DataBase);
        ConexaoBanco.Param.ParamByName('CODEMPRESA').AsInteger := DataBase.CodigoEmpresa;
        ConexaoBanco.Param.ParamByName('NDOC').AsInteger := OrdemServico.Id;
        ConexaoBanco.Param.ParamByName('DTEMISSAO').AsDateTime := OrdemServico.DataEmissao;
        ConexaoBanco.Param.ParamByName('HORAEMISSAO').AsDateTime := OrdemServico.HoraEmissao;
        ConexaoBanco.Param.ParamByName('CODCLI').AsInteger := OrdemServico.ClienteId;
        ConexaoBanco.Param.ParamByName('NOMECLI').AsString := PesquisarPessoaRazaoSocial(OrdemServico.ClienteId, DataBase);
        ConexaoBanco.Param.ParamByName('VRDOC').AsFloat := OrdemServico.ValorSinal;
        ConexaoBanco.Param.ParamByName('CODVENDEDOR').AsInteger := OrdemServico.VendedorId;
        ConexaoBanco.Param.ParamByName('APELIDOVENDEDOR').AsString := PesquisarPessoaNomeFantasia(OrdemServico.VendedorId, DataBase);
        ConexaoBanco.Param.ParamByName('SITUACAO').AsInteger := 1; //Aberto
        ConexaoBanco.Param.ParamByName('TIPO').AsString := 'OS';
        ConexaoBanco.Param.ParamByName('EXTDOC').AsString := FormatFloat('000000', OrdemServico.Id);
        ConexaoBanco.Param.ParamByName('CODPLANOPAGAMENTO').AsInteger := OrdemServico.PlanoPagtoId;
        ConexaoBanco.Param.ParamByName('DTVENCIMENTO').AsDateTime := Date;
        ConexaoBanco.Param.ParamByName('DIASPARCELA').AsInteger := 0;
        ConexaoBanco.Param.ParamByName('TIPODOC').AsInteger := StrToInt(TParametros.VerificaParametros('CODTIPODOCOS','I', DataBase));
        ConexaoBanco.Param.ParamByName('CODCONTA').AsInteger := StrToInt(TParametros.VerificaParametros('CODCONTAOS', 'I', DataBase));
        ConexaoBanco.Param.ParamByName('CODPLANOCONTAS').AsInteger := StrToInt(TParametros.VerificaParametros('CODPLANODECONTASOS','I', DataBase));
        ConexaoBanco.Param.ParamByName('DESCRICTIPO').AsString := PesquisarTipoDocumento(ConexaoBanco.Param.ParamByName('TIPODOC').AsInteger, DataBase);
        ConexaoBanco.Param.ParamByName('PARCELA').AsInteger := 1;
        ConexaoBanco.Param.ParamByName('TOTALPARCELAS').AsInteger := 1;
        ConexaoBanco.Param.ParamByName('VALORTOTAL').AsFloat := OrdemServico.ValorTotal;
        ConexaoBanco.Param.ParamByName('CODFORMAPAGPADRAO').AsInteger := 0;
        ConexaoBanco.Param.ParamByName('TITULARCARTAO').AsString := '';
        ConexaoBanco.Param.ParamByName('VALORTAXA').AsFloat := 0;
        ConexaoBanco.Param.ParamByName('AUTOPERADORA').AsString := '';
        ConexaoBanco.Param.ParamByName('NUMLOTEOS').AsInteger := 0;
        ConexaoBanco.Param.ParamByName('SINALOS').AsString := 'S';
        {$EndRegion}

        ConexaoBanco.DataSetFactory.PostDataSet(TConexao.BaseDados, ConexaoBanco.sql.Text , ConexaoBanco.Param);
      end
      else if (OrdemServico.Situacao = 'E') or (OrdemServico.PedidoRapido) then
      begin
        if not OrdemServico.PedidoRapido then
        begin
          CtReceber.cdsCtRec.Filtered := False;
          if OrdemServico.Situacao = 'A' then
            CtReceber.cdsCtRec.Filter := 'Sinal = ''S'' '
          else
            CtReceber.cdsCtRec.Filter := 'Sinal <> ''S'' ';
          CtReceber.cdsCtRec.Filtered := True;
          CtReceber.cdsCtRec.First;
        end;
        while (Not CtReceber.cdsCtRec.Eof) do
        Begin
          ConexaoBanco.ClearParam();

          ConexaoBanco.Param.ParamByName('CODMOVIM').AsInteger := AutoIncrementoCaixa(DataBase);
          ConexaoBanco.Param.ParamByName('CODEMPRESA').AsInteger := DataBase.CodigoEmpresa;
          ConexaoBanco.Param.ParamByName('NDOC').AsInteger := OrdemServico.Id;
          ConexaoBanco.Param.ParamByName('DTEMISSAO').AsDateTime := OrdemServico.DataEmissao;
          ConexaoBanco.Param.ParamByName('HORAEMISSAO').AsDateTime := OrdemServico.HoraEmissao;
          ConexaoBanco.Param.ParamByName('CODCLI').AsInteger := OrdemServico.ClienteId;
          ConexaoBanco.Param.ParamByName('NOMECLI').AsString := PesquisarPessoaRazaoSocial(OrdemServico.ClienteId, DataBase);
          ConexaoBanco.Param.ParamByName('VRDOC').AsFloat := CtReceber.cdsCtRec.FieldByName('VALORDOCUMENTO').AsFloat;
          ConexaoBanco.Param.ParamByName('CODVENDEDOR').AsInteger := OrdemServico.VendedorId;
          ConexaoBanco.Param.ParamByName('APELIDOVENDEDOR').AsString := PesquisarPessoaNomeFantasia(OrdemServico.VendedorId, DataBase);
          ConexaoBanco.Param.ParamByName('SITUACAO').AsInteger := 1; //Aberto
          ConexaoBanco.Param.ParamByName('TIPO').AsString := 'OS';
          ConexaoBanco.Param.ParamByName('EXTDOC').AsString := Trim(StringReplace(CtReceber.cdsCtRec.FieldByName('NUMDOCUMENTO').AsString,'O.S.','',[rfReplaceAll]));
          ConexaoBanco.Param.ParamByName('CODPLANOPAGAMENTO').AsInteger := OrdemServico.PlanoPagtoId;
          ConexaoBanco.Param.ParamByName('DTVENCIMENTO').AsDateTime := CtReceber.cdsCtRec.FieldByName('DATAVENCIMENTO').AsDateTime;
          ConexaoBanco.Param.ParamByName('DIASPARCELA').AsInteger := CtReceber.cdsCtRec.FieldByName('DIASPARCELA').AsInteger;
          ConexaoBanco.Param.ParamByName('TIPODOC').AsInteger := StrToInt(TParametros.VerificaParametros('CODTIPODOCOS','I', DataBase));
          ConexaoBanco.Param.ParamByName('CODCONTA').AsInteger := StrToInt(TParametros.VerificaParametros('CODCONTAOS', 'I', DataBase));
          ConexaoBanco.Param.ParamByName('CODPLANOCONTAS').AsInteger := StrToInt(TParametros.VerificaParametros('CODPLANODECONTASOS','I', DataBase));
          ConexaoBanco.Param.ParamByName('DESCRICTIPO').AsString := PesquisarTipoDocumento(ConexaoBanco.Param.ParamByName('TIPODOC').AsInteger, DataBase);
          ConexaoBanco.Param.ParamByName('PARCELA').AsInteger := CtReceber.cdsCtRec.RecNo;// CtReceber.cdsCtRec.FieldByName('Item').AsInteger;
          ConexaoBanco.Param.ParamByName('TOTALPARCELAS').AsInteger := CtReceber.cdsCtRec.RecordCount;
          ConexaoBanco.Param.ParamByName('VALORTOTAL').AsFloat := OrdemServico.ValorTotal;
          ConexaoBanco.Param.ParamByName('CODFORMAPAGPADRAO').AsInteger := OrdemServico.FormaPagtoId;
          ConexaoBanco.Param.ParamByName('TITULARCARTAO').AsString := '';
          ConexaoBanco.Param.ParamByName('VALORTAXA').AsFloat := 0;
          ConexaoBanco.Param.ParamByName('AUTOPERADORA').AsString := '';
          ConexaoBanco.Param.ParamByName('NUMLOTEOS').AsInteger := 0;
          ConexaoBanco.Param.ParamByName('SINALOS').AsString := 'N';
          {$EndRegion}

          ConexaoBanco.DataSetFactory.PostDataSet(TConexao.BaseDados, ConexaoBanco.sql.Text , ConexaoBanco.Param);
          CtReceber.cdsCtRec.Next();
        End;
      end;
      {$EndRegion}

      ConexaoBanco.DataSetFactory.Commit(TConexao.BaseDados);
      Gravou := True;
    Except
      On E : Exception do
      Begin
        ConexaoBanco.DataSetFactory.RollBack(TConexao.Empresa);
        TCustomExcept.Show(e, 'Erro ao Gravar OrdemServico => Tentativa : '+IntToStr(iTentativas), False);
        inc(iTentativas);
      End;
    End;
  End;
  result := Gravou;
End;

Class Procedure TCtReceberRepository.SqlExcluirItens(ConexaoBanco : TConexaoBanco);
Begin
  ConexaoBanco.sql.Add('DELETE FROM ITOS WHERE ');
  ConexaoBanco.sql.Add('NUMOS = :NUMOS    ');
  ConexaoBanco.sql.Add('AND CODIGOEMP = :CODIGOEMP    ');
End;

Class Procedure TCtReceberRepository.EstornarMaisCaixa(bCancelouOS : Boolean; OrdemServico : TOrdemServicoEntity; DataBase : TDataBase);
var
  DataSet, DataSet2 : TDataSet;
  ConexaoBanco : TConexaoBanco;
  iCodMovim : Integer;
  bPulouSinal : Boolean;
Begin
  ConexaoBanco := TConexaoBanco.Create(DataBase);
  ConexaoBanco.SQL.Add('SELECT                                        ');
  ConexaoBanco.SQL.Add('CODMOVIM,                                      ');
  ConexaoBanco.SQL.Add('CODCAIXA,                                      ');
  ConexaoBanco.SQL.Add('CODEMPRESA,                                    ');
  ConexaoBanco.SQL.Add('NDOC,                                          ');
  ConexaoBanco.SQL.Add('DTEMISSAO,                                     ');
  ConexaoBanco.SQL.Add('HORAEMISSAO,                                   ');
  ConexaoBanco.SQL.Add('CODCLI,                                        ');
  ConexaoBanco.SQL.Add('NOMECLI,                                       ');
  ConexaoBanco.SQL.Add('VRDOC,                                         ');
  ConexaoBanco.SQL.Add('CODVENDEDOR,                                   ');
  ConexaoBanco.SQL.Add('APELIDOVENDEDOR,                               ');
  ConexaoBanco.SQL.Add('OBS,                                           ');
  ConexaoBanco.SQL.Add('SITUACAO,                                      ');
  ConexaoBanco.SQL.Add('TIPO                                           ');
  ConexaoBanco.sql.Add('FROM CAIXAMOVIM                                ');
  ConexaoBanco.sql.Add('WHERE NDOC = :NUMDOC AND TIPO = ''OS'' AND (ESTORNADO = ''N'' OR ESTORNADO IS NULL) AND CODEMPRESA = :CODEMPRESA');

  if (not bCancelouOS) and (not OrdemServico.PedidoRapido) then
  begin
    if (OrdemServico.Situacao = 'A') And (not OrdemServico.PedidoRapido) then
      ConexaoBanco.SQL.Add('AND SINALOS = ''S''')
    else
      ConexaoBanco.SQL.Add('AND SINALOS <> ''S''')
  end;

  ConexaoBanco.Param.ParamByName('NUMDOC').AsInteger := OrdemServico.Id;
  ConexaoBanco.Param.ParamByName('CODEMPRESA').AsInteger := DataBase.CodigoEmpresa;

  DataSet := ConexaoBanco.DataSetFactory.GetDataSet(TConexao.BaseDados, ConexaoBanco.sql.Text, ConexaoBanco.Param);

  while not DataSet.Eof do
  begin
    if DataSet.FieldByName('SITUACAO').AsInteger = 1 then //Se o documento estiver em aberto ainda, so dever� exclui-lo
    begin
      ConexaoBanco.Clear;
      ConexaoBanco.ClearParam;
      ConexaoBanco.SQL.Add('DELETE FROM CAIXAMOVIM WHERE CODMOVIM = :CODMOVIM');
      ConexaoBanco.Param.ParamByName('CODMOVIM').AsInteger := DataSet.FieldByName('CODMOVIM').AsInteger;
      ConexaoBanco.DataSetFactory.PostDataSet(TConexao.BaseDados, ConexaoBanco.sql.Text, ConexaoBanco.Param);
    end
    else if (not bCancelouOS) and (DataSet.FieldByName('VRDOC').AsFloat = OrdemServico.ValorSinal) and
            (not bPulouSinal) then
    begin
      bPulouSinal := True;
    end
    else
    begin
      if EstornarContasaReceber(bCancelouOS, OrdemServico, DataBase) then
      begin
        ConexaoBanco.Clear;
        ConexaoBanco.ClearParam;
        ConexaoBanco.SQL.Add('INSERT INTO CAIXAMOVIM (                       ');
        ConexaoBanco.SQL.Add('CODMOVIM,                                      ');
        ConexaoBanco.SQL.Add('CODCAIXA,                                      ');
        ConexaoBanco.SQL.Add('CODEMPRESA,                                    ');
        ConexaoBanco.SQL.Add('NDOC,                                          ');
        ConexaoBanco.SQL.Add('DTEMISSAO,                                     ');
        ConexaoBanco.SQL.Add('HORAEMISSAO,                                   ');
        ConexaoBanco.SQL.Add('CODCLI,                                        ');
        ConexaoBanco.SQL.Add('NOMECLI,                                       ');
        ConexaoBanco.SQL.Add('VRDOC,                                         ');
        ConexaoBanco.SQL.Add('CODVENDEDOR,                                   ');
        ConexaoBanco.SQL.Add('APELIDOVENDEDOR,                               ');
        ConexaoBanco.SQL.Add('OBS,                                           ');
        ConexaoBanco.SQL.Add('SITUACAO,                                      ');
        ConexaoBanco.SQL.Add('DTPAGAMENTO,                                   ');
        ConexaoBanco.SQL.Add('HORAPAGAMENTO,                                 ');
        ConexaoBanco.SQL.Add('TIPO )                                         ');
        ConexaoBanco.SQL.Add('VALUES (                                       ');
        ConexaoBanco.SQL.Add(':CODMOVIM,                                     ');
        ConexaoBanco.SQL.Add(':CODCAIXA,                                     ');
        ConexaoBanco.SQL.Add(':CODEMPRESA,                                   ');
        ConexaoBanco.SQL.Add(':NDOC,                                         ');
        ConexaoBanco.SQL.Add(':DTEMISSAO,                                    ');
        ConexaoBanco.SQL.Add(':HORAEMISSAO,                                  ');
        ConexaoBanco.SQL.Add(':CODCLI,                                       ');
        ConexaoBanco.SQL.Add(':NOMECLI,                                      ');
        ConexaoBanco.SQL.Add(':VRDOC,                                        ');
        ConexaoBanco.SQL.Add(':CODVENDEDOR,                                  ');
        ConexaoBanco.SQL.Add(':APELIDOVENDEDOR,                              ');
        ConexaoBanco.SQL.Add(':OBS,                                          ');
        ConexaoBanco.SQL.Add(':SITUACAO,                                     ');
        ConexaoBanco.SQL.Add(':DTPAGAMENTO,                                  ');
        ConexaoBanco.SQL.Add(':HORAPAGAMENTO,                                ');
        ConexaoBanco.SQL.Add(':TIPO)                                         ');
        iCodMovim := AutoIncrementoCaixa(DataBase);
        ConexaoBanco.Param.ParamByName('CODMOVIM').AsInteger := iCodMovim;
        ConexaoBanco.Param.ParamByName('CODCAIXA').AsInteger := DataSet.FieldByName('CODCAIXA').AsInteger;
        ConexaoBanco.Param.ParamByName('CODEMPRESA').AsInteger := DataBase.CodigoEmpresa;
        ConexaoBanco.Param.ParamByName('NDOC').AsInteger := DataSet.FieldByName('NDOC').AsInteger;
        ConexaoBanco.Param.ParamByName('DTEMISSAO').AsDateTime := OrdemServico.DataEmissao;
        ConexaoBanco.Param.ParamByName('HORAEMISSAO').AsDateTime := OrdemServico.HoraEmissao;
        ConexaoBanco.Param.ParamByName('CODCLI').AsInteger := OrdemServico.ClienteId;
        ConexaoBanco.Param.ParamByName('NOMECLI').AsString := PesquisarPessoaRazaoSocial(OrdemServico.ClienteId, DataBase);
        ConexaoBanco.Param.ParamByName('VRDOC').AsFloat := DataSet.FieldByName('VRDOC').AsFloat * (-1);
        ConexaoBanco.Param.ParamByName('CODVENDEDOR').AsInteger := DataSet.FieldByName('CODVENDEDOR').AsInteger;
        ConexaoBanco.Param.ParamByName('APELIDOVENDEDOR').AsString := DataSet.FieldByName('APELIDOVENDEDOR').AsString;
        ConexaoBanco.Param.ParamByName('SITUACAO').AsInteger := 2; //Fechado
        ConexaoBanco.Param.ParamByName('DTPAGAMENTO').AsDateTime := Date;
        ConexaoBanco.Param.ParamByName('HORAPAGAMENTO').AsDateTime := Time;
        ConexaoBanco.Param.ParamByName('TIPO').AsString := 'SA';
        ConexaoBanco.DataSetFactory.PostDataSet(TConexao.BaseDados, ConexaoBanco.sql.Text, ConexaoBanco.Param);

        ConexaoBanco.Clear;
        ConexaoBanco.ClearParam;
        ConexaoBanco.sql.Add('UPDATE CAIXAMOVIM ');
        ConexaoBanco.sql.Add('SET ESTORNADO = ''S''');
        ConexaoBanco.sql.Add('WHERE CODMOVIM = :CODMOVIM');
        ConexaoBanco.Param.ParamByName('CODMOVIM').AsInteger := DataSet.FieldByName('CODMOVIM').AsInteger;
        ConexaoBanco.DataSetFactory.PostDataSet(TConexao.BaseDados, ConexaoBanco.sql.Text, ConexaoBanco.Param);

        ConexaoBanco.Clear;
        ConexaoBanco.ClearParam;
        ConexaoBanco.SQL.Add('SELECT * FROM CAIXAFECHAFORMAS WHERE CODMOVIM = :CODMOVIM');
        ConexaoBanco.Param.ParamByName('CODMOVIM').AsInteger := DataSet.FieldByName('CODMOVIM').AsInteger;
        DataSet2 := ConexaoBanco.DataSetFactory.GetDataSet(TConexao.BaseDados, ConexaoBanco.sql.Text, ConexaoBanco.Param);

        while not DataSet2.Eof do
        begin
          ConexaoBanco.Clear;
          ConexaoBanco.ClearParam;
          ConexaoBanco.SQL.Add('INSERT INTO CAIXAFECHAFORMAS (                 ');
          ConexaoBanco.SQL.Add('CODMOVIM,                                      ');
          ConexaoBanco.SQL.Add('CODFORMA,                                      ');
          ConexaoBanco.SQL.Add('DESCFORMA,                                     ');
          ConexaoBanco.SQL.Add('VRFORMA )                                      ');
          ConexaoBanco.SQL.Add('VALUES (                                       ');
          ConexaoBanco.SQL.Add(':CODMOVIM,                                     ');
          ConexaoBanco.SQL.Add(':CODFORMA,                                     ');
          ConexaoBanco.SQL.Add(':DESCFORMA,                                    ');
          ConexaoBanco.SQL.Add(':VRFORMA)                                      ');

          ConexaoBanco.Param.ParamByName('CODMOVIM').AsInteger := iCodMovim;
          ConexaoBanco.Param.ParamByName('CODFORMA').AsInteger := DataSet2.FieldByName('CODFORMA').AsInteger;
          ConexaoBanco.Param.ParamByName('DESCFORMA').AsString := DataSet2.FieldByName('DESCFORMA').AsString;
          ConexaoBanco.Param.ParamByName('VRFORMA').AsFloat    := DataSet2.FieldByName('VRFORMA').AsFloat *(-1);
          ConexaoBanco.DataSetFactory.PostDataSet(TConexao.BaseDados, ConexaoBanco.sql.Text, ConexaoBanco.Param);
          DataSet2.Next;
        end;
      end;
    end;
    DataSet.Next;
  end;
End;

Class Procedure TCtReceberRepository.SetNull(ConexaoBanco:TConexaoBanco; DataType : TFieldType; NomeCampo : String);
Begin
  ConexaoBanco.Param.ParamByName(NomeCampo).DataType := DataType;
  ConexaoBanco.Param.ParamByName(NomeCampo).Value := Null;
End;

Class Function TCtReceberRepository.RecuperarExtensaoDaFatura(sDataEmissao : String; iParcela, iTotParcelas :Integer; DataBase : TDataBase):String;
{Retorna a extensao da fatura}
var
  nExtensao, nAno :String;
  bMostraExtensaoParcUnica : Boolean;
begin
  Try
    if TParametros.VerificaParametros('MOSTRAEXTPARCUNICA','V', DataBase) = 'S' then
      bMostraExtensaoParcUnica := True
    else
      bMostraExtensaoParcUnica := False;

    if (iTotParcelas = 1) and (not bMostraExtensaoParcUnica) then
    begin
      Result := '';
      Exit;
    end;
    if TParametros.VerificaParametros('EXTENSAOFATURA','V', DataBase) = 'L' then
      nExtensao := '/' + RetornarContagemDeLetras(iParcela)
    else
      nExtensao := '/' + copy('000',1,3-length(IntToStr(iParcela))) + IntToStr(iParcela);

    if TParametros.VerificaParametros('ANOFATURA','V', DataBase) = 'S' then
    begin
      nAno := '-' + FormatDateTime('yy',StrToDate(sDataEmissao));
    end
    else
      nAno := '';
    RecuperarExtensaoDaFatura := nExtensao + nAno;
  except
    On E : Exception do
    Begin
      TCustomExcept.Show(e, 'Erro ao buscar extens�o fatura', False);
      RecuperarExtensaoDaFatura:='';
    End;
  end;
end;

Class Function TCtReceberRepository.RetornarContagemDeLetras(iParcela:Integer):String;
{Retorna uma contagem de letras}
{Usado em Faturas por exemplo  }
{Exemplo A..Z,AA..AZ,BA..BZ}
var
Alfabeto,nLetra1,nLetra2: String;
nPosicao1,nPosicao2:Integer;
nDivisao:Real;
begin
  Alfabeto := 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
  if iParcela > 26 then
  begin
    nDivisao := iParcela /26;
    if Frac(nDivisao) > 0 then
      nPosicao1 := Trunc(nDivisao)
    else
      nPosicao1 := Trunc(nDivisao) - 1;

    nPosicao2 :=  iParcela - (26 * nPosicao1);

    nLetra1 := Copy(Alfabeto,nPosicao1,1);
    nLetra2 := Copy(Alfabeto,nPosicao2,1);
  end
  else
  begin
    nLetra2 := '';
    nLetra1 := Copy(Alfabeto,iParcela,1);
  end;
  RetornarContagemDeLetras := nLetra1 + nLetra2;
end;

Class Function TCtReceberRepository.VerificarFinanceiroQuitado(OrdemServico : TOrdemServicoEntity; DataBase : TDataBase; out sMessage : String):Boolean;
var
  DataSet : TDataSet;
  ConexaoBanco : TConexaoBanco;
  rTotal : Double;
begin
  Result := False;
  ConexaoBanco := TConexaoBanco.Create(DataBase);
  ConexaoBanco.Sql.Add('SELECT CODIGOSITUACAO, SUM(VALORRECEBER) AS TOTAL');
  ConexaoBanco.Sql.Add('FROM DGLOB210 WHERE NUMOS = :NUMOS AND CODIGOEMP = :CODIGOEMP AND CODIGOSITUACAO = 2');
  ConexaoBanco.Sql.Add('GROUP BY CODIGOSITUACAO');
  ConexaoBanco.Param.ParamByName('NUMOS').AsInteger     := OrdemServico.Id;
  ConexaoBanco.Param.ParamByName('CODIGOEMP').AsInteger := DataBase.CodigoEmpresa;
  DataSet := ConexaoBanco.DataSetFactory.GetDataSet(TConexao.Empresa, ConexaoBanco.Sql.Text, ConexaoBanco.Param);
  if not DataSet.Eof then
  Begin
    if (OrdemServico.Situacao = 'A') and (not OrdemServico.PedidoRapido)  then
    begin
      if OrdemServico.ValorSinal <> DataSet.FieldByName('TOTAL').AsFloat then
      begin
        sMessage := 'N�o � poss�vel alterar o Sinal pois o Financeiro j� est� quitado.';
        Result := True;
      end
      else
        Result := False;
    end
    else if OrdemServico.Situacao = 'F' then
    begin
      sMessage := 'N�o � poss�vel alterar para aberta pois o sinal j� est� quitado.';
      Result := True;
    end
    else
    Begin
      if (DataSet.FieldByName('TOTAL').AsFloat > OrdemServico.ValorSinal) or
         (OrdemServico.PedidoRapido)  then
      begin
        sMessage := 'N�o � poss�vel alterar a O.S. pois j� possui Financeiro quitado.';
        Result := True;
      end;
    End;
  End;
end;

Class Function TCtReceberRepository.VerificaPlanoPagtoCartao(out CtReceber : TCtReceber; PlanoPagamento : TPlanoPagamento; OrdemServico : TOrdemServicoEntity; DataBase : TDataBase; out sMessage : String):Boolean;
var
  DataSet : TDataSet;
  ConexaoBanco : TConexaoBanco;
begin
  ConexaoBanco := TConexaoBanco.Create(DataBase);
  ConexaoBanco.Sql.Add('SELECT P.* FROM FORMAS_PLANOS F');
  ConexaoBanco.Sql.Add('INNER JOIN DGLOB030 P ON F.CODPLANO = P.CODIGOFORMA AND P.DESDOFORMA = :PARCELAS');
  ConexaoBanco.Sql.Add('WHERE F.CODFORMA = :CODFORMA AND F.CODEMP = :CODIGOEMP');
  ConexaoBanco.Param.ParamByName('PARCELAS').AsInteger  := OrdemServico.ParcelasCartao;
  ConexaoBanco.Param.ParamByName('CODFORMA').AsInteger  := OrdemServico.FormaPagtoId;
  ConexaoBanco.Param.ParamByName('CODIGOEMP').AsInteger := DataBase.CodigoEmpresa;
  DataSet := ConexaoBanco.DataSetFactory.GetDataSet(TConexao.Empresa, ConexaoBanco.Sql.Text, ConexaoBanco.Param);

  if (DataSet.Bof) And (DataSet.Eof) Then
  begin
    sMessage := 'N�o existe esse plano de pagamento configurado para esta Forma de Pagamento.';
    Result := False;
    Exit;
  end
  else
  begin
    PlanoPagamento.Id := DataSet.FieldByName('CODIGOFORMA').AsInteger;
    TPlanoPagamentoService.ConsultaPlanoPagamento(DataBase ,PlanoPagamento);

    ConexaoBanco.Clear;
    ConexaoBanco.Param.Clear;

    ConexaoBanco.SQL.Add('SELECT CODPLANO, DESCRITIVO , CODCONTAAUXILIAR, CA.DESCRICONTA AS CONTAAUX, CODPCONTASCREDITO, PCC.DESCRICAO AS PCCREDITO,');
    ConexaoBanco.SQL.Add('CODPCONTASDEBITO,PCD.DESCRICAO AS PCDEBITO, CODPCONTASCREDITOTRANSF, PCTC.DESCRICAO AS PCTCREDITO, CODPCONTASDEBITOTRANSF,');
    ConexaoBanco.SQL.Add('PCTD.DESCRICAO AS PCTDEBITO, CODCONTACREDITO, CC.DESCRICONTA AS CONTACREDITO,CODFORNECEDOR , PESSOANOME, QTDEDIASADICIONAIS,');
    ConexaoBanco.SQL.Add('TXADMINISTRATIVA FROM formas_planos FP, PESSOA, dglob050 CA, dglob050 CC, PLANODECONTAS PCC, PLANODECONTAS PCD, PLANODECONTAS PCTD,');
    ConexaoBanco.SQL.Add('PLANODECONTAS PCTC, DGLOB030 WHERE CODPLANO = CODIGOFORMA AND CODCONTAAUXILIAR = CA.CODIGOCONTA AND CODPCONTASCREDITO = PCC.COD_REDUZIDO');
    ConexaoBanco.SQL.Add('AND CODPCONTASDEBITO = PCD.COD_REDUZIDO AND CODPCONTASCREDITOTRANSF = PCTC.COD_REDUZIDO');
    ConexaoBanco.SQL.Add('AND CODPCONTASDEBITOTRANSF = PCTD.COD_REDUZIDO AND CODCONTACREDITO = CC.CODIGOCONTA AND CODFORNECEDOR = PESSOACODIGO');
    ConexaoBanco.SQL.Add('AND CODPLANO = :PLANO AND FP.CODFORMA = :FORMA AND FP.CODEMP = :EMP ');
    ConexaoBanco.Param.ParamByName('FORMA').AsInteger := OrdemServico.FormaPagtoId;
    ConexaoBanco.Param.ParamByName('EMP').AsInteger   := DataBase.CodigoEmpresa;
    ConexaoBanco.Param.ParamByName('PLANO').AsInteger := DataSet.FieldByName('CODIGOFORMA').AsInteger;
    DataSet := ConexaoBanco.DataSetFactory.GetDataSet(TConexao.Empresa, ConexaoBanco.Sql.Text, ConexaoBanco.Param);

    if (DataSet.Eof) and (DataSet.Bof) then
    begin
      sMessage := 'N�o Existem Par�metros Configurados para esta Forma de Pagamento.';
      Result := False;
      Exit;
    end
    else
    begin
      CtReceber.CodPlanoCartao := DataSet.FieldByName('CODPLANO').AsInteger;
      CtReceber.CodContaAux    := DataSet.FieldByName('CODCONTAAUXILIAR').AsInteger;
      CtReceber.CodPlanoCtCred := DataSet.FieldByName('CODPCONTASCREDITO').AsInteger;
      CtReceber.CodPlanoCtDeb  := DataSet.FieldByName('CODPCONTASDEBITO').AsInteger;
      CtReceber.PlanoCtCred    := DataSet.FieldByName('PCCREDITO').AsString;
      CtReceber.PlanoCtDeb     := DataSet.FieldByName('PCDEBITO').AsString;
      CtReceber.CodContaCred   := DataSet.FieldByName('CODCONTACREDITO').AsInteger;
      CtReceber.CodFornec      := DataSet.FieldByName('CODFORNECEDOR').AsInteger;
      CtReceber.DiasAdic       := DataSet.FieldByName('QTDEDIASADICIONAIS').AsInteger;
      CtReceber.TxAdmin        := DataSet.FieldByName('TXADMINISTRATIVA').AsFloat;
      Result := True;
    end;
  end;
end;


Class Function TCtReceberRepository.CalculaTaxaCartao(CtReceber : TCtReceber; OrdemServico : TOrdemServicoEntity) : Boolean;
var I : Integer;
    dVrTaxaTotal, dValorTaxa, dTotalSomaTaxa, vDiferenca, vValorAtual  : Double;
begin
  dValorTaxa := 0;
  dTotalSomaTaxa := 0;

  if OrdemServico.Situacao = 'A' then
    dVrTaxaTotal :=  RoundTo(OrdemServico.ValorSinal * CtReceber.TxAdmin /100, -2)
  else
    dVrTaxaTotal := RoundTo(((OrdemServico.ValorTotal - OrdemServico.ValorSinal) * CtReceber.TxAdmin /100), -2);
  CtReceber.cdsCtRec.First;

  while not CtReceber.cdsCtRec.Eof do
  begin
    CtReceber.cdsCtRec.Edit;
    dValorTaxa := RoundTo((CtReceber.cdsCtRec.FieldByName('ValorDocumento').AsFloat * CtReceber.TxAdmin) / 100, -2);
    CtReceber.cdsCtRec.FieldByName('TaxaCartao').AsFloat := dValorTaxa;
    CtReceber.cdsCtRec.Post;
    dTotalSomaTaxa := dTotalSomaTaxa + dValorTaxa;
    CtReceber.cdsCtRec.Next;
  end;

  CtReceber.cdsCtRec.First;

  if dVrTaxaTotal <> dTotalSomaTaxa then
  begin
    if dVrTaxaTotal < dTotalSomaTaxa then
    begin
      vDiferenca   := dTotalSomaTaxa -  dVrTaxaTotal;
      vValorAtual  := CtReceber.cdsCtRec.FieldByName('TaxaCartao').AsFloat;
      CtReceber.cdsCtRec.Edit;
      CtReceber.cdsCtRec.FieldByName('TaxaCartao').AsFloat := RoundTo(vValorAtual - vDiferenca,-2);
      CtReceber.cdsCtRec.Post;
    end
    else
    begin
      vDiferenca :=  dVrTaxaTotal -  dTotalSomaTaxa;
      vValorAtual  := CtReceber.cdsCtRec.FieldByName('TaxaCartao').AsFloat;
      CtReceber.cdsCtRec.Edit;
      CtReceber.cdsCtRec.FieldByName('TaxaCartao').AsFloat := RoundTo(vValorAtual + vDiferenca,-2);
      CtReceber.cdsCtRec.Post;
    end;
  end;
end;

Class Procedure TCtReceberRepository.GravarCtPagarCartao(OrdemServico : TOrdemServicoEntity; CtReceber : TCtReceber; PlanoPagamento : TPlanoPagamento; FormaPagamento : TFormaPagamento; Cliente : TPessoa; DataBase : TDataBase);
var
  vCodCtPagar, i : Integer;
  rTaxa, rTaxaRateio, rTaxaRateioTotal : Double;
  DataSet : TDataSet;
  ConexaoBanco : TConexaoBanco;
begin
  CtReceber.cdsCtRec.First;
  while not CtReceber.cdsCtRec.EOF do
  begin
    ConexaoBanco := TConexaoBanco.Create(DataBase);
    ConexaoBanco.Sql.Add('INSERT INTO DGLOB220(CODIGOPAGAR,CODIGOFORNECEDOR,NPARCELA,NTOTPARCELA,LANCAMENPAGAR,');
    ConexaoBanco.Sql.Add('NUMEROPAGAR,NOTAPAGAR,');
    ConexaoBanco.Sql.Add('EMISSAOPAGAR,VALORPAGAR,VRTOTDOCUMENTO,');
    ConexaoBanco.Sql.Add('VENCIMENPAGAR,CODIGOTIPO,CODIGOBANCO,');
    ConexaoBanco.Sql.Add('CODIGOSITUACAO,PAGOPAGAR,');
    ConexaoBanco.Sql.Add('NUMEROLANCAMENTO,');
    ConexaoBanco.Sql.Add('FLUXOCAIXAPAGAR,CODIGOFORMAPAG,VALORCORRIGIDO,');
    ConexaoBanco.Sql.Add('HOUVERESTO,SOURESTO,LANCAMENTOORIGEM,DESCONTOCONCEDIDO,');
    ConexaoBanco.Sql.Add('VALORACRESCIDO,DEBITOCREDITO,CODIGOMOEDAPAGAR,HISTORICO,HISTORICOCONTAS,CODIGOEMP,COMPETENCIA,CODDOCVINCULADO,MEMOPAGAR)');
    ConexaoBanco.Sql.Add('VALUES');
    ConexaoBanco.Sql.Add('(:CODIGOPAGAR,:CODIGOFORNECEDOR,:NPARCELA,:NTOTPARCELA,:LANCAMENPAGAR,');
    ConexaoBanco.Sql.Add(':NUMEROPAGAR,:NOTAPAGAR,');
    ConexaoBanco.Sql.Add(':EMISSAOPAGAR,:VALORPAGAR,:VRTOTDOCUMENTO,');
    ConexaoBanco.Sql.Add(':VENCIMENPAGAR,:CODIGOTIPO,:CODIGOBANCO,');
    ConexaoBanco.Sql.Add(':CODIGOSITUACAO,:PAGOPAGAR,');
    ConexaoBanco.Sql.Add(':NUMEROLANCAMENTO,');
    ConexaoBanco.Sql.Add(':FLUXOCAIXAPAGAR,:CODIGOFORMAPAG,:VALORCORRIGIDO,');
    ConexaoBanco.Sql.Add(':HOUVERESTO,:SOURESTO,:LANCAMENTOORIGEM,:DESCONTOCONCEDIDO,');
    ConexaoBanco.Sql.Add(':VALORACRESCIDO,:DEBITOCREDITO,:CODIGOMOEDAPAGAR,:HISTORICO,:HISTORICOCONTAS,:CODIGOEMP,:COMPETENCIA,:CODDOCVINCULADO,:MEMOPAGAR)');
    vCodCtPagar  := AutoIncrementoCtPagar(DataBase);
    ConexaoBanco.Param.ParamByName('CODIGOPAGAR').AsInteger         := vCodCtPagar;
    ConexaoBanco.Param.ParamByName('CODIGOEMP').AsInteger           := DataBase.CodigoEmpresa;
    ConexaoBanco.Param.ParamByName('NPARCELA').AsInteger            := CtReceber.cdsCtRec.FieldByName('Item').AsInteger;
    ConexaoBanco.Param.ParamByName('CODIGOFORNECEDOR').AsInteger    := CtReceber.CodFornec;
    ConexaoBanco.Param.ParamByName('NTOTPARCELA').AsInteger         := CtReceber.cdsCtRec.RecordCount;
    ConexaoBanco.Param.ParamByName('LANCAMENPAGAR').AsDate          := OrdemServico.DataEmissao;
    ConexaoBanco.Param.ParamByName('NUMEROPAGAR').AsString          := FormatFloat('000000',OrdemServico.Id);
    ConexaoBanco.Param.ParamByName('NOTAPAGAR').AsString            := FormatFloat('000000',OrdemServico.Id);
    ConexaoBanco.Param.ParamByName('EMISSAOPAGAR').AsDate           := OrdemServico.DataEmissao;
    ConexaoBanco.Param.ParamByName('VALORPAGAR').AsFloat            := CtReceber.cdsCtRec.FieldByName('TaxaCartao').AsFloat;
    ConexaoBanco.Param.ParamByName('VRTOTDOCUMENTO').AsFloat        := CtReceber.cdsCtRec.FieldByName('ValorDocumento').AsFloat;
    ConexaoBanco.Param.ParamByName('VENCIMENPAGAR').AsDate          := (CtReceber.cdsCtRec.FieldByName('DataVencimento').AsDateTime + CtReceber.DiasAdic);
    ConexaoBanco.Param.ParamByName('CODIGOTIPO').AsInteger          := StrToInt(TParametros.VerificaParametros('CODTIPODOCOS','I', DataBase));
    ConexaoBanco.Param.ParamByName('CODIGOBANCO').AsInteger         := CtReceber.CodContaAux;
    ConexaoBanco.Param.ParamByName('CODIGOSITUACAO').AsInteger      := 1; {Aberto}
    ConexaoBanco.Param.ParamByName('PAGOPAGAR').AsFloat             := 0;
    ConexaoBanco.Param.ParamByName('NUMEROLANCAMENTO').AsInteger    := 0;
    ConexaoBanco.Param.ParamByName('FLUXOCAIXAPAGAR').AsString      := 'S';
    ConexaoBanco.Param.ParamByName('CODIGOFORMAPAG').AsInteger      := CtReceber.CodPlanoCartao;//se � 30,60 e 90
    ConexaoBanco.Param.ParamByName('VALORCORRIGIDO').AsFloat        := 0;
    ConexaoBanco.Param.ParamByName('HOUVERESTO').AsString           := 'N';
    ConexaoBanco.Param.ParamByName('SOURESTO').AsString             := 'N';
    ConexaoBanco.Param.ParamByName('LANCAMENTOORIGEM').AsInteger    := 0;
    ConexaoBanco.Param.ParamByName('DESCONTOCONCEDIDO').AsFloat     := 0;
    ConexaoBanco.Param.ParamByName('VALORACRESCIDO').AsFloat        := 0;
    ConexaoBanco.Param.ParamByName('DEBITOCREDITO').AsString        := 'D';
    ConexaoBanco.Param.ParamByName('CODIGOMOEDAPAGAR').AsInteger    := OrdemServico.FormaPagtoId;
    ConexaoBanco.Param.ParamByName('HISTORICO').AsBlob              := TParametros.VerificaParametros('TEXTBOLETO','B', DataBase);
    ConexaoBanco.Param.ParamByName('HISTORICOCONTAS').AsString      := Copy('CTP: ' + FormatFloat('000000',vCodCtPagar) + ' - '+ FormatFloat('000000',OrdemServico.ClienteId) + ' - ' + Copy(Cliente.Nome,1,60) +
                                                                       ' - TX CARTAO - ' + 'O.S. ' + ' - ' + FormatFloat('000000',OrdemServico.Id),1,100);
    ConexaoBanco.Param.ParamByName('CODDOCVINCULADO').AsInteger     := CtReceber.cdsCtRec.FieldByName('CodigoReceber').AsInteger;
    ConexaoBanco.Param.ParamByName('COMPETENCIA').AsDate            := Date;
    ConexaoBanco.Param.ParamByName('MEMOPAGAR').AsString            := 'AUTORIZA��O: ' + CtReceber.AutorizacaoOperadora;
    ConexaoBanco.DataSetFactory.PostDataSet(TConexao.Empresa, ConexaoBanco.Sql.Text, ConexaoBanco.Param);


    ConexaoBanco.Clear;
    ConexaoBanco.Param.Clear;

    ConexaoBanco.SQL.Add('INSERT INTO PLANOCONTAS_CTPAG(CODPLANOCONTAS,CODIGOPAGAR,VRPAGAR,');
    ConexaoBanco.SQL.Add('CODIGOEMP,CODIGOSEQ) VALUES(:CODPLANOCONTAS,:CODIGOPAGAR,:VRPAGAR,:CODIGOEMP,:CODIGOSEQ)'); //Fab.: 29/11/09
    ConexaoBanco.Param.ParamByName('CODPLANOCONTAS').AsInteger := CtReceber.CodPlanoCtDeb;
    ConexaoBanco.Param.ParamByName('CODIGOPAGAR').AsInteger    := vCodCtPagar;
    ConexaoBanco.Param.ParamByName('VRPAGAR').AsFloat          := CtReceber.cdsCtRec.FieldByName('TaxaCartao').AsFloat;
    ConexaoBanco.Param.ParamByName('CODIGOEMP').AsInteger      := DataBase.CodigoEmpresa;
    ConexaoBanco.Param.ParamByName('CODIGOSEQ').AsInteger      := 1;
    ConexaoBanco.DataSetFactory.PostDataSet(TConexao.Empresa, ConexaoBanco.Sql.Text, ConexaoBanco.Param);

    CtReceber.cdsCtRec.Next;
  end;
end;

Class Function TCtReceberRepository.EstornarContasaReceber(bCancelarOS : Boolean; OrdemServico : TOrdemServicoEntity; DataBase : TDataBase):Boolean;
var
  ConexaoBanco : TConexaoBanco;
  DataSet : TDataSet;
begin
  ConexaoBanco := TConexaoBanco.Create(DataBase);

  ConexaoBanco := TConexaoBanco.Create(DataBase);
  ConexaoBanco.SQL.Add('SELECT CODIGORECEBER, TAXAADMCARTAO, NUMEROLANCAMENTO FROM DGLOB210 WHERE NUMOS = :NUMOS AND CODIGOEMP = :CODIGOEMP');
  if (not bCancelarOS) and (not OrdemServico.PedidoRapido) then
  begin
    if (OrdemServico.Situacao = 'A') And (not OrdemServico.PedidoRapido) then
      ConexaoBanco.SQL.Add('AND SINALOS = ''S''')
    else
      ConexaoBanco.SQL.Add('AND SINALOS <> ''S''')
  end;
  ConexaoBanco.Param.ParamByName('NUMOS').AsInteger     := OrdemServico.Id;
  ConexaoBanco.Param.ParamByName('CODIGOEMP').AsInteger := DataBase.CodigoEmpresa;
  DataSet := ConexaoBanco.DataSetFactory.GetDataSet(TConexao.Empresa, ConexaoBanco.sql.Text, ConexaoBanco.Param);

  if DataSet.Eof then
  begin
    Result := False;
    Exit;
  end
  else
    Result := True;

  while not DataSet.Eof do
  begin
    If (not DataSet.FieldByName('NUMEROLANCAMENTO').IsNull) then
    begin
      ConexaoBanco := TConexaoBanco.Create(DataBase);
      ConexaoBanco.Sql.Add('UPDATE CONTAS SET EXCLUIDO = ''S'' WHERE CODIGOEMP = :CODIGOEMP AND NUMEROLANCAMENTO = :NUMEROLANCAMENTO');
      ConexaoBanco.Param.ParamByName('CODIGOEMP').AsInteger := DataBase.CodigoEmpresa;
      ConexaoBanco.Param.ParamByName('NUMEROLANCAMENTO').AsInteger := DataSet.FieldByName('NUMEROLANCAMENTO').AsInteger;
      ConexaoBanco.DataSetFactory.PostDataSet(TConexao.Empresa, ConexaoBanco.Sql.Text, ConexaoBanco.Param);
    end;

    ConexaoBanco := TConexaoBanco.Create(DataBase);
    ConexaoBanco.Sql.Add('DELETE FROM CTRECEBER_FORMASPAG WHERE CODIGOEMP = :CODIGOEMP AND CODIGOCTREC = :CODIGORECEBER');
    ConexaoBanco.Param.ParamByName('CODIGOEMP').AsInteger := DataBase.CodigoEmpresa;
    ConexaoBanco.Param.ParamByName('CODIGORECEBER').AsInteger := DataSet.FieldByName('CODIGORECEBER').AsInteger;
    ConexaoBanco.DataSetFactory.PostDataSet(TConexao.Empresa, ConexaoBanco.Sql.Text, ConexaoBanco.Param);

    ConexaoBanco.Clear;
    ConexaoBanco.ClearParam;
    ConexaoBanco.Sql.Add('DELETE FROM PLANOCONTAS_CTREC WHERE CODIGOEMP = :CODIGOEMP AND CODIGORECEBER = :CODIGORECEBER');
    ConexaoBanco.Param.ParamByName('CODIGOEMP').AsInteger := DataBase.CodigoEmpresa;
    ConexaoBanco.Param.ParamByName('CODIGORECEBER').AsInteger := DataSet.FieldByName('CODIGORECEBER').AsInteger;
    ConexaoBanco.DataSetFactory.PostDataSet(TConexao.Empresa, ConexaoBanco.Sql.Text, ConexaoBanco.Param);

    ConexaoBanco.Clear;
    ConexaoBanco.ClearParam;
    ConexaoBanco.Sql.Add('DELETE FROM DGLOB210 WHERE CODIGOEMP = :CODIGOEMP AND CODIGORECEBER = :CODIGORECEBER');
    ConexaoBanco.Param.ParamByName('CODIGOEMP').AsInteger := DataBase.CodigoEmpresa;
    ConexaoBanco.Param.ParamByName('CODIGORECEBER').AsInteger := DataSet.FieldByName('CODIGORECEBER').AsInteger;
    ConexaoBanco.DataSetFactory.PostDataSet(TConexao.Empresa, ConexaoBanco.Sql.Text, ConexaoBanco.Param);
    DataSet.Next;
  end;
end;

Class Procedure TCtReceberRepository.EstornarTaxaCartao(bCancelarOS : Boolean; OrdemServico : TOrdemServicoEntity; CtReceber : TCtReceber; DataBase : TDataBase);
var
  ConexaoBanco : TConexaoBanco;
  DataSet, DataSetCtPag : TDataSet;
begin

  ConexaoBanco := TConexaoBanco.Create(DataBase);
  ConexaoBanco.SQL.Add('SELECT CODIGORECEBER, TAXAADMCARTAO FROM DGLOB210 WHERE NUMOS = :NUMOS AND CODIGOEMP = :CODIGOEMP');
  if not bCancelarOS then
  begin
    if (OrdemServico.Situacao = 'A') And (not OrdemServico.PedidoRapido) then
      ConexaoBanco.SQL.Add('AND SINALOS = ''S''')
    else
      ConexaoBanco.SQL.Add('AND SINALOS = ''N''')
  end;
  ConexaoBanco.Param.ParamByName('NUMOS').AsInteger     := OrdemServico.Id;
  ConexaoBanco.Param.ParamByName('CODIGOEMP').AsInteger := DataBase.CodigoEmpresa;
  DataSet := ConexaoBanco.DataSetFactory.GetDataSet(TConexao.Empresa, ConexaoBanco.sql.Text, ConexaoBanco.Param);

  while not DataSet.Eof do
  begin
    if DataSet.FieldByName('TAXAADMCARTAO').AsFloat <> 0 then
    begin
      ConexaoBanco.Clear;
      ConexaoBanco.ClearParam;
      ConexaoBanco.SQL.Add('SELECT CODIGOPAGAR, NUMEROLANCAMENTO FROM DGLOB220 WHERE CODDOCVINCULADO  = :CODIGORECEBER AND CODIGOEMP = :CODIGOEMP');
      ConexaoBanco.Param.ParamByName('CODIGORECEBER').AsInteger     := DataSet.FieldByName('CodigoReceber').AsInteger;
      ConexaoBanco.Param.ParamByName('CODIGOEMP').AsInteger := DataBase.CodigoEmpresa;
      DataSetCtPag := ConexaoBanco.DataSetFactory.GetDataSet(TConexao.Empresa, ConexaoBanco.sql.Text, ConexaoBanco.Param);

      if not DataSetCtPag.Eof then
      begin
        if DataSetCtPag.FieldByName('NUMEROLANCAMENTO').AsInteger <> 0 then
        begin
          ConexaoBanco.Clear;
          ConexaoBanco.ClearParam;
          ConexaoBanco.SQL.Add('UPDATE CONTAS SET EXCLUIDO = ''S'' WHERE NUMEROLANCAMENTO  = :NUMEROLANCAMENTO AND CODIGOEMP = :CODIGOEMP');
          ConexaoBanco.Param.ParamByName('CODIGORECEBER').AsInteger := DataSetCtPag.FieldByName('NUMEROLANCAMENTO').AsInteger;
          ConexaoBanco.Param.ParamByName('CODIGOEMP').AsInteger := DataBase.CodigoEmpresa;
          ConexaoBanco.DataSetFactory.PostDataSet(TConexao.Empresa, ConexaoBanco.sql.Text, ConexaoBanco.Param);
        end;
        ConexaoBanco.Clear;
        ConexaoBanco.ClearParam;
        ConexaoBanco.SQL.Add('DELETE FROM PLANOCONTAS_CTPAG WHERE CODIGOPAGAR = :CODIGOPAGAR AND CODIGOEMP = :CODIGOEMP');
        ConexaoBanco.Param.ParamByName('CODIGOPAGAR').AsInteger     := DataSetCtPag.FieldByName('CODIGOPAGAR').AsInteger;
        ConexaoBanco.Param.ParamByName('CODIGOEMP').AsInteger := DataBase.CodigoEmpresa;
        ConexaoBanco.DataSetFactory.PostDataSet(TConexao.Empresa, ConexaoBanco.sql.Text, ConexaoBanco.Param);

        ConexaoBanco.Clear;
        ConexaoBanco.ClearParam;
        ConexaoBanco.SQL.Add('DELETE FROM CTPAGAR_FORMASPAG WHERE CODIGOCTPAG = :CODIGOCTPAG AND CODIGOEMP = :CODIGOEMP');
        ConexaoBanco.Param.ParamByName('CODIGOCTPAG').AsInteger     := DataSetCtPag.FieldByName('CODIGOPAGAR').AsInteger;
        ConexaoBanco.Param.ParamByName('CODIGOEMP').AsInteger := DataBase.CodigoEmpresa;
        ConexaoBanco.DataSetFactory.PostDataSet(TConexao.Empresa, ConexaoBanco.sql.Text, ConexaoBanco.Param);

        ConexaoBanco.Clear;
        ConexaoBanco.ClearParam;
        ConexaoBanco.SQL.Add('DELETE FROM DGLOB220 WHERE CODIGOPAGAR = :CODIGOPAGAR AND CODIGOEMP = :CODIGOEMP');
        ConexaoBanco.Param.ParamByName('CODIGOPAGAR').AsInteger     := DataSetCtPag.FieldByName('CODIGOPAGAR').AsInteger;
        ConexaoBanco.Param.ParamByName('CODIGOEMP').AsInteger := DataBase.CodigoEmpresa;
        ConexaoBanco.DataSetFactory.PostDataSet(TConexao.Empresa, ConexaoBanco.sql.Text, ConexaoBanco.Param);
      end;
    end;
    DataSet.Next;
  end;

end;

Class Function TCtReceberRepository.Cancelar(OrdemServico : TOrdemServicoEntity; CtReceber : TCtReceber; DataBase: TDataBase):Boolean;
Var
  ConexaoBanco : TConexaoBanco;
begin
  ConexaoBanco := TConexaoBanco.Create(DataBase);
  Try
    ConexaoBanco.DataSetFactory.StartTransaction(TConexao.BaseDados);
    EstornarMaisCaixa(True, OrdemServico, DataBase);
    ConexaoBanco.DataSetFactory.Commit(TConexao.BaseDados);
  Except
    ConexaoBanco.DataSetFactory.RollBack(TConexao.BaseDados);
  End;
end;

Class Procedure TCtReceberRepository.GravarContas(Database : TDatabase; OrdemServico : TOrdemServicoEntity; Cliente : TPessoa; CtReceber : TCtReceber; Index, NumeroLancamento : Integer);
var ConexaoBanco : TConexaoBanco;
begin
  try
    CtReceber.cdsCtRec.RecNo := Index;
    ConexaoBanco := TConexaoBanco.Create(Database);
    ConexaoBanco.SQL.Add('INSERT INTO CONTAS (NUMEROLANCAMENTO,DATALANCAMENTO,CODIGOCONTA,NUMERODOCUMENTO,VALORLANCAMENTO,CODREDUZIDO,');
    ConexaoBanco.SQL.Add('CODIGOCENTRO,CONTACONTRAPARTIDA,PCONTASCONTRAPARTIDA,DEBITOCREDITO,LANCAMENCONTRAPARTIDA,SALDOATUAL,');
    ConexaoBanco.SQL.Add('SALDOANTERIOR,SERIE,SUBSERIE,CODMODELO,CODFORNECEDOR,DTEMISNF,NUMERONF,DATACONSOLIDACAO,USUARIO,');
    ConexaoBanco.SQL.Add('DTALTERACAO,LANCMANUAL,COMPLEMENTOCONTAS,CODIGOEMP,EXCLUIDO,COMPETENCIA,NOSSONUMERO,DOCUMENTOESTORNO,ESTORNO)');
    ConexaoBanco.SQL.Add('VALUES (:NUMEROLANCAMENTO,:DATALANCAMENTO,:CODIGOCONTA,:NUMERODOCUMENTO,:VALORLANCAMENTO,:CODREDUZIDO,');
    ConexaoBanco.SQL.Add(':CODIGOCENTRO,:CONTACONTRAPARTIDA,:PCONTASCONTRAPARTIDA,:DEBITOCREDITO,:LANCAMENCONTRAPARTIDA,:SALDOATUAL,');
    ConexaoBanco.SQL.Add(':SALDOANTERIOR,:SERIE,:SUBSERIE,:CODMODELO,:CODFORNECEDOR,:DTEMISNF,:NUMERONF,:DATACONSOLIDACAO,:USUARIO,');
    ConexaoBanco.SQL.Add(':DTALTERACAO,:LANCMANUAL,:COMPLEMENTOCONTAS,:CODIGOEMP,:EXCLUIDO,:COMPETENCIA,:NOSSONUMERO,:DOCUMENTOESTORNO,:ESTORNO)');

    ConexaoBanco.Param.ParamByName('NUMEROLANCAMENTO').AsInteger := NumeroLancamento;
    ConexaoBanco.Param.ParamByName('DATALANCAMENTO').AsDatetime := Date;
    ConexaoBanco.Param.ParamByName('CODIGOCONTA').AsInteger := StrToInt(TParametros.VerificaParametros('CODCONTAOS', 'I', DataBase));
    ConexaoBanco.Param.ParamByName('NUMERODOCUMENTO').AsString := Copy('CTR: ' + ConexaoBanco.Param.ParamByName('CODIGORECEBER').AsString +
                                                                  FormatFloat('000000',OrdemServico.ClienteId) + Cliente.Nome + ' -' + CtReceber.PlanoCtCred +
                                                                  'O.S. '  + FormatFloat('000000',OrdemServico.Id),1,100);
    ConexaoBanco.Param.ParamByName('VALORLANCAMENTO').AsFloat := CtReceber.cdsCtRec.FieldByName('VALORDOCUMENTO').AsFloat;
    ConexaoBanco.Param.ParamByName('CODREDUZIDO,').Value := null;
    ConexaoBanco.Param.ParamByName('CODIGOCENTRO').Value := null;
    ConexaoBanco.Param.ParamByName('CONTACONTRAPARTIDA').AsInteger := 999999999;
    ConexaoBanco.Param.ParamByName('PCONTASCONTRAPARTIDA').Value := null;
    ConexaoBanco.Param.ParamByName('DEBITOCREDITO').AsString := 'C';
    ConexaoBanco.Param.ParamByName('LANCAMENCONTRAPARTIDA').Value := null;
    ConexaoBanco.Param.ParamByName('SALDOATUAL,').Value := null;
    ConexaoBanco.Param.ParamByName('SALDOANTERIOR').Value := null;
    ConexaoBanco.Param.ParamByName('SERIE').Value := null;
    ConexaoBanco.Param.ParamByName('SUBSERIE').Value := null;
    ConexaoBanco.Param.ParamByName('CODMODELO').Value := null;
    ConexaoBanco.Param.ParamByName('CODFORNECEDOR').Value := null;
    ConexaoBanco.Param.ParamByName('DTEMISNF').Value := null;
    ConexaoBanco.Param.ParamByName('NUMERONF').Value := null;
    ConexaoBanco.Param.ParamByName('DATACONSOLIDACAO').Value := null;
    ConexaoBanco.Param.ParamByName('USUARIO,').Value := null;
    ConexaoBanco.Param.ParamByName('DTALTERACAO').Value := null;
    ConexaoBanco.Param.ParamByName('LANCMANUAL').AsString := 'N';
    ConexaoBanco.Param.ParamByName('COMPLEMENTOCONTAS').Value := null;
    ConexaoBanco.Param.ParamByName('CODIGOEMP').asInteger := Database.CodigoEmpresa;
    ConexaoBanco.Param.ParamByName('EXCLUIDO').AsString := 'N';
    ConexaoBanco.Param.ParamByName('COMPETENCIA').AsDatetime := Date;
    ConexaoBanco.Param.ParamByName('NOSSONUMERO').Value := null;
    ConexaoBanco.Param.ParamByName('DOCUMENTOESTORNO').Value := null;
    ConexaoBanco.Param.ParamByName('ESTORNO').AsString := 'N';

    ConexaoBanco.DataSetFactory.PostDataSet(TConexao.Empresa, ConexaoBanco.sql.Text, ConexaoBanco.Param);
    ConexaoBanco.Free();
  Except
    On E : Exception do
    Begin
      TCustomExcept.Show(e, 'Erro ao tentar gravar contas!');
    End;

  end;
end;

Class Procedure TCtReceberRepository.GravarPlanoContas(Database : TDatabase; NumeroLancamento, Index, Sequencial: Integer; CtReceber : TCtReceber);
var ConexaoBanco : TConexaoBanco;
begin
  try
    CtReceber.cdsCtRec.RecNo := Index;
    ConexaoBanco := TConexaoBanco.Create(Database);
    ConexaoBanco.SQL.Add('INSERT INTO CONTAS_PLANOCONTAS (NUMEROLANCAMENTO, CODIGOSEQ, VALORLANCAMENTO, CODPLANOCONTAS, DEBITOCREDITO, CODIGOEMP) ');
    ConexaoBanco.SQL.Add('VALUES (:NUMEROLANCAMENTO, :CODIGOSEQ, :VALORLANCAMENTO, :CODPLANOCONTAS, :DEBITOCREDITO, :CODIGOEMP)');

    ConexaoBanco.Param.ParamByName('NUMEROLANCAMENTO').AsInteger := NumeroLancamento;
    ConexaoBanco.Param.ParamByName('CODIGOSEQ').AsInteger := Sequencial;
    ConexaoBanco.Param.ParamByName('VALORLANCAMENTO').AsFloat := CtReceber.cdsCtRec.FieldByName('VALORDOCUMENTO').AsFloat;
    ConexaoBanco.Param.ParamByName('CODPLANOCONTAS').AsInteger := CtReceber.CodPlanoCtCred;
    ConexaoBanco.Param.ParamByName('DEBITOCREDITO').AsString := 'C';
    ConexaoBanco.Param.ParamByName('CODIGOEMP').AsInteger := Database.CodigoEmpresa;

    ConexaoBanco.DataSetFactory.PostDataSet(TConexao.Empresa, ConexaoBanco.sql.Text, ConexaoBanco.Param);
    ConexaoBanco.Free();
  Except
    On E : Exception do
    Begin
      TCustomExcept.Show(e, 'Erro ao tentar gravar planos de contas!');
    End;
  End;

end;

Class Procedure TCtReceberRepository.GravarFormasPagamentoContasReceber(Database : TDatabase; CtReceber : TCtReceber; Index : Integer; OrdemServico : TOrdemServicoEntity);
var ConexaoBanco : TConexaoBanco;
begin
  Try
    CtReceber.cdsCtRec.RecNo := Index;
    ConexaoBanco := TConexaoBanco.Create(Database);
    ConexaoBanco.SQL.Add('INSERT INTO CTRECEBER_FORMASPAG (CODIGOSEQ, CODIGOCTREC, CODIGOFORMAPAG, VALORFORMA, CODIGOEMP, IDFORMA, VRTROCO) ');
    ConexaoBanco.SQL.Add('VALUES (:CODIGOSEQ, :CODIGOCTREC, :CODIGOFORMAPAG, :VALORFORMA, :CODIGOEMP, :IDFORMA, :VRTROCO)');

    ConexaoBanco.Param.ParamByName('CODIGOSEQ').AsInteger := 1;
    ConexaoBanco.Param.ParamByName('CODIGOCTREC').AsInteger := CtReceber.cdsCtRec.FieldByName('CODIGORECEBER').AsInteger;
    ConexaoBanco.Param.ParamByName('VALORFORMA').AsFloat := CtReceber.cdsCtRec.FieldByName('VALORDOCUMENTO').AsFloat;
    ConexaoBanco.Param.ParamByName('CODIGOEMP').AsInteger := Database.CodigoEmpresa;
    ConexaoBanco.Param.ParamByName('IDFORMA').Value := null;
    ConexaoBanco.Param.ParamByName('VRTROCO').Value := null;
    ConexaoBanco.Param.ParamByName('CODIGOFORMAPAG').AsInteger := OrdemServico.FormaPagtoId;

    ConexaoBanco.DataSetFactory.PostDataSet(TConexao.Empresa, ConexaoBanco.sql.Text, ConexaoBanco.Param);
    ConexaoBanco.Free();

  Except
    On E : Exception do
    Begin
      TCustomExcept.Show(e, 'Erro ao tentar gravar formas de pagamento!');
    End;

  End;
end;





end.


