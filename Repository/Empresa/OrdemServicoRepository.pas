unit OrdemServicoRepository;

interface

Uses
  System.Variants,
  Data.Db,
  System.SysUtils,
  DataBase,
  OrdemServicoEntity,
  CtReceber,
  FormaPagamento,
  PlanoPagamento,
  Pessoa,
  Usuario,
  ConexaoBanco,
  EnumConexao,
  EnumSituacaoOrdemServico,
  CtReceberRepository,
  CustomExcept,
  Parametros,
  Funcoes_EstoqueCST,
  CustomMessage,
  Winapi.Windows,
  Math;

Type TOrdemServicoRepository = Class Abstract
  Private

    Class Procedure SetNull(ConexaoBanco:TConexaoBanco; DataType : TFieldType; NomeCampo : String);
    Class Procedure SqlExcluirItens(ConexaoBanco : TConexaoBanco);
  Public
    Class Function VerifyNewOS(Out OSId : Integer; Out Modify : Boolean; DataBase : TDataBase) : Boolean;
    Class Function AutoIncremento(DataBase : TDataBase):Integer;
    Class Function GetEnvelope(DataBase : TDataBase):Integer;
    Class Function ConsultaOrdemServico(OrdemServico : TOrdemServicoEntity; CtReceber : TCtReceber; sUsuario : String; DataBase : TDataBase):Boolean;
    Class Function ConsultaSetorUltimaOS(Usuario : TUsuario; DataBase : TDataBase):Integer;
    Class Function Gravar(OrdemServico : TOrdemServicoEntity; CtReceber : TCtReceber;  FormaPagamento : TFormaPagamento; PlanoPagamento : TPlanoPagamento; Cliente : TPessoa; Usuario : TUsuario; DataBase : TDataBase):Boolean;
    Class Function BaixarEstoque(OrdemServico : TOrdemServicoEntity; DataBase : TDataBase):Boolean;
    Class Function EstornarEstoque(OrdemServico : TOrdemServicoEntity; DataBase : TDataBase):Boolean;
    Class Function ConsultaQtdeItemOS(iNumOS, iCodigoProduto : Integer; DataBase : TDataBase):Double;
    Class Procedure ExcluirFinanceiro(OrdemServico : TOrdemServicoEntity; DataBase : TDataBase);
    Class Function SomarTotalProdutos(OrdemServico : TOrdemServicoEntity): Double;
    Class Function SomarTotalServicos(OrdemServico : TOrdemServicoEntity): Double;
    Class Procedure LiberarAcessoOS(OrdemServico : TOrdemServicoEntity; DataBase : TDataBase);
    Class Function ReciboPagamento(iNumOS : Integer; DataBase : TDataBase):TDataSet;
    Class Procedure GerarComissao(bSinal : Boolean; OrdemServico : TOrdemServicoEntity; CtReceber : TCtReceber; DataBase : TDataBase);
    Class Function AutoIncrementoComissoes(DataBase : TDataBase):Integer;
    Class Procedure EstornarComissao(bCancelouOS : Boolean; OrdemServico : TOrdemServicoEntity; DataBase : TDataBase);
    Class Function EnvelopeLaranja(iNumOS : Integer; DataBase : TDataBase):TDataSet;
    Class Function EnvelopeAzul(iNumOS : Integer; DataBase : TDataBase):TDataSet;
    Class Function Cancelar(OrdemServico : TOrdemServicoEntity; CtReceber : TCtReceber; DataBase : TDataBase):Boolean;
    Class Function BuscaNumEnvelopeStudio(DataBase : TDataBase):Integer;
    Class Procedure GravaNumEnvelopeStudio(OrdemServico : TOrdemServicoEntity; DataBase : TDataBase);
    Class Function ConsultaComissaoFunc(iCodigo : Integer; DataBase : TDataBase):Double;
    Class Function VerificaFormaEnviaMaisCaixa(iCodigo : Integer; DataBase : TDataBase):Boolean;
End;

implementation

uses Log;



Class Function TOrdemServicoRepository.VerifyNewOS(Out OSId : Integer; Out Modify : Boolean; DataBase : TDataBase) : Boolean;
Var
  ConexaoBanco : TConexaoBanco;
  DataSet : TDataSet;
Begin

  if OSId = 0 then
  Begin
    OSId := 0;
    Modify := False;
    Exit;
  End;

  ConexaoBanco := TConexaoBanco.Create(DataBase);
  try
    ConexaoBanco.SQL.Add('SELECT                        ');
    ConexaoBanco.SQL.Add('OS.NUMOS,                     ');
    ConexaoBanco.SQL.Add('OS.CODIGOEMP,                 ');
    ConexaoBanco.SQL.Add('OS.USUARIOBLOQ                ');
    ConexaoBanco.SQL.Add('FROM OS                       ');
    ConexaoBanco.SQL.Add('WHERE                         ');
    ConexaoBanco.SQL.Add('OS.NUMOS = :ID                ');
    ConexaoBanco.SQL.Add('And OS.CODIGOEMP = :CODIGOEMP ');
    ConexaoBanco.Param.ParamByName('ID').AsInteger := OSId;
    ConexaoBanco.Param.ParamByName('CODIGOEMP').AsInteger := DataBase.CodigoEmpresa;

    DataSet := ConexaoBanco.DataSetFactory.GetDataSet(TConexao.Empresa,ConexaoBanco.sql.Text, ConexaoBanco.Param);
    DataSet.First();

    if (Not DataSet.Eof) then
    Begin
      OSId := DataSet.FieldByName('NUMOS').AsInteger;
      if DataSet.FieldByName('USUARIOBLOQ').AsString <> '' then
      begin
        IF TCustomMessage.Show(PChar('Este registro já está sendo acessado pelo usuário: ' + DataSet.FieldByName('USUARIOBLOQ').AsString + chr(13) +
                                  'Deseja liberar o acesso deste usuário?'),'Atenção',TTypeMessage.Question, TButtons.YesNo) = IdNo then
        Begin
          Result := False;
          Exit;
        End;
      end;
      Modify := True;
    End
    else
    Begin
      OSId := 0;
      Modify := False;
    End;
    Result := True;
  Except
    On e : Exception do
    Begin
      OSId := 0;
      Modify := False;
      TCustomExcept.Show(e, 'Erro ao Verificar uma O.S.');
    End;
  end;
End;

Class Function TOrdemServicoRepository.AutoIncremento(DataBase : TDataBase):Integer;
Var
  ConexaoBanco : TConexaoBanco;
Begin
  Result := 0;
  ConexaoBanco := TConexaoBanco.Create(DataBase);
  try
    ConexaoBanco.SQL.Add('SELECT                                ');
    ConexaoBanco.SQL.Add('COALESCE(MAX(OS.NUMOS),0) + 1 AS ID   ');
    ConexaoBanco.SQL.Add('FROM OS                               ');
    ConexaoBanco.SQL.Add('WHERE                                 ');
    ConexaoBanco.SQL.Add('OS.CODIGOEMP = :CODIGOEMP             ');
    ConexaoBanco.Param.ParamByName('CODIGOEMP').AsInteger := DataBase.CodigoEmpresa;
    Result := ConexaoBanco.DataSetFactory.GetDataSet(TConexao.Empresa, ConexaoBanco.Sql.Text, ConexaoBanco.Param).FieldByName('Id').AsInteger;
  Except
    On E : Exception do
    Begin
      TCustomExcept.Show(e, 'Erro ao tentar executar AutoIncremento');
    End;
  End;
End;

Class Function TOrdemServicoRepository.GetEnvelope(DataBase : TDataBase):Integer;
Var
  ConexaoBanco : TConexaoBanco;
  DataSet : TDataSet;
Begin
  Result := 0;
  ConexaoBanco := TConexaoBanco.Create(DataBase);
  try
    ConexaoBanco.SQL.Add('SELECT                                ');
    ConexaoBanco.SQL.Add('COALESCE(MAX(OS.NRENVELOPE),0) + 1 AS ID   ');
    ConexaoBanco.SQL.Add('FROM OS                               ');
    ConexaoBanco.SQL.Add('WHERE                                 ');
    ConexaoBanco.SQL.Add('OS.CODIGOEMP = :CODIGOEMP             ');
    ConexaoBanco.Param.ParamByName('CODIGOEMP').AsInteger := DataBase.CodigoEmpresa;
    DataSet := ConexaoBanco.DataSetFactory.GetDataSet(TConexao.Empresa, ConexaoBanco.Sql.Text, ConexaoBanco.Param);

    if (Not DataSet.Eof) then
    begin
      if DataSet.FieldByName('ID').AsInteger = 1 then
      begin
        if TParametros.VerificaParametros('NRENVELOPEINICIAL','I',DataBase) <> '' then
        begin
          Result := StrToInt(TParametros.VerificaParametros('NRENVELOPEINICIAL','I',DataBase)) + 1;
          Exit;
        end;
      end;
      Result := DataSet.FieldByName('ID').AsInteger;
    end
    else
      Result := 1;

  Except
    On E : Exception do
    Begin
      TCustomExcept.Show(e, 'Erro ao tentar executar AutoIncremento');
    End;
  End;
End;

Class Function TOrdemServicoRepository.ConsultaOrdemServico(OrdemServico : TOrdemServicoEntity; CtReceber : TCtReceber; sUsuario : String; DataBase : TDataBase):Boolean;
Var
  ConexaoBanco : TConexaoBanco;
  DataSet : TDataSet;
  dPercDescOS, dVrDescOS : Double;
Begin
  Result := False;
  Try
    ConexaoBanco := TConexaoBanco.Create(DataBase);
    ConexaoBanco.SQL.Add('SELECT                                                                                            ');
    ConexaoBanco.SQL.Add('OS.NUMOS,                                                                                         ');
    ConexaoBanco.SQL.Add('OS.ORCAMENTO,                                                                                     ');
    ConexaoBanco.SQL.Add('OS.PEDIDORAPIDO,                                                                                  ');
    ConexaoBanco.SQL.Add('OS.NRENVELOPE,                                                                                    ');
    ConexaoBanco.SQL.Add('OS.DATADIGITA,                                                                                    ');
    ConexaoBanco.SQL.Add('OS.HORADIGITA,                                                                                    ');
    ConexaoBanco.SQL.Add('OS.DATAPREVISAO,                                                                                  ');
    ConexaoBanco.SQL.Add('OS.HORAPREVISAO,                                                                                  ');
    ConexaoBanco.SQL.Add('OS.CODCLI,                                                                                        ');
    ConexaoBanco.SQL.Add('CLI.PESSOANOME CLIENTE,                                                                           ');
    ConexaoBanco.SQL.Add('OS.CODVEND,                                                                                       ');
    ConexaoBanco.SQL.Add('VEND.PESSOANOME VENDEDOR,                                                                         ');
    ConexaoBanco.SQL.Add('OS.CODFECHA,                                                                                      ');
    ConexaoBanco.SQL.Add('OS.CODENTREGA,                                                                                    ');
    ConexaoBanco.SQL.Add('IT.CODPROD,                                                                                       ');
    ConexaoBanco.SQL.Add('PR.DESCRICPRODUTO As PRODUTO,                                                                     ');
    ConexaoBanco.SQL.Add('IT.QUANTIDADE,                                                                                    ');
    ConexaoBanco.SQL.Add('IT.QUANT_EMBALAGEM,                                                                               ');
    ConexaoBanco.SQL.Add('IT.QUANT_BAIXA,                                                                                   ');
    ConexaoBanco.SQL.Add('IT.VRUNITARIO,                                                                                    ');
    ConexaoBanco.SQL.Add('IT.PERCDESC,                                                                                      ');
    ConexaoBanco.SQL.Add('IT.VRDESC, IT.DESCOS,                                                                             ');
    ConexaoBanco.SQL.Add('OS.PERCDESCOS,                                                                                    ');
    ConexaoBanco.SQL.Add('OS.VRDESCOS,                                                                                      ');
    ConexaoBanco.SQL.Add('ROUND(IT.QUANTIDADE * IT.VRUNITARIO ,-2) AS VALORTOTALITENS,                                      ');
    ConexaoBanco.SQL.Add('OS.VRADIANTAMENTO,                                                                                ');
    ConexaoBanco.SQL.Add('OS.CANCELADO,                                                                                     ');
    ConexaoBanco.SQL.Add('OS.DTCANCEL,                                                                                      ');
    ConexaoBanco.SQL.Add('OS.FATURADO,                                                                                      ');
    ConexaoBanco.SQL.Add('OS.DATAEMISSAONF,                                                                                 ');
    ConexaoBanco.SQL.Add('OS.SITUACAOOS,                                                                                    ');
    ConexaoBanco.SQL.Add('IT.TIPO,                                                                                          ');
    ConexaoBanco.SQL.Add('OS.CODSETOR,                                                                                      ');
    ConexaoBanco.SQL.Add('OS.OBS,                                                                                           ');
    ConexaoBanco.SQL.Add('OS.OBSRECIBO,                                                                                     ');
    ConexaoBanco.SQL.Add('OS.OBSRECIBO2,                                                                                    ');
    ConexaoBanco.SQL.Add('OS.CODFORMAPAG,                                                                                   ');
    ConexaoBanco.SQL.Add('OS.CODPLANOPAG,                                                                                   ');
    ConexaoBanco.SQL.Add('OS.CODFOTOGRAFO,                                                                                  ');
    ConexaoBanco.SQL.Add('OS.MODELOSTUDIO                                                                                   ');
    ConexaoBanco.SQL.Add('FROM OS                                                                                           ');
    ConexaoBanco.SQL.Add('INNER JOIN ITOS It On                                                                             ');
    ConexaoBanco.SQL.Add('    IT.NUMOS = OS.NUMOS                                                                           ');
    ConexaoBanco.SQL.Add('    And IT.CODIGOEMP = OS.CodigoEmp                                                               ');
    ConexaoBanco.SQL.Add('INNER JOIN PRODUTOS PR On                                                                         ');
    ConexaoBanco.SQL.Add('    PR.CODIGOPRODUTO = It.CODPROD                                                                 ');
    ConexaoBanco.SQL.Add('INNER JOIN PESSOA CLI On                                                                          ');
    ConexaoBanco.SQL.Add('    CLI.PESSOACODIGO = OS.CODCLI                                                                  ');
    ConexaoBanco.SQL.Add('INNER JOIN PESSOA VEND On                                                                         ');
    ConexaoBanco.SQL.Add('    VEND.PESSOACODIGO = OS.CODVEND                                                                ');
    ConexaoBanco.SQL.Add('WHERE                                                                                             ');
    ConexaoBanco.SQL.Add('OS.NUMOS = :ID                                                                                    ');
    ConexaoBanco.SQL.Add('AND OS.CODIGOEMP = :CODIGOEMP                                                                     ');

    ConexaoBanco.Param.ParamByName('Id').AsInteger := OrdemServico.Id;
    ConexaoBanco.Param.ParamByName('CodigoEmp').AsInteger := DataBase.CodigoEmpresa;

    DataSet := ConexaoBanco.DataSetFactory.GetDataSet(TConexao.Empresa, ConexaoBanco.sql.Text, ConexaoBanco.Param);

    DataSet.First();
    if (Not DataSet.Eof) then
    Begin
      OrdemServico.Id := DataSet.FieldByName('NUMOS').AsInteger;
      If DataSet.FieldByName('ORCAMENTO').AsString = 'S' Then
        OrdemServico.Orcamento := True
      Else
        OrdemServico.Orcamento := False;
      OrdemServico.OrcamentoAnterior := OrdemServico.Orcamento;
      If DataSet.FieldByName('PEDIDORAPIDO').AsString = 'S' Then
        OrdemServico.PedidoRapido := True
      Else
        OrdemServico.PedidoRapido := False;

      OrdemServico.Envelope := DataSet.FieldByName('NRENVELOPE').AsInteger;
      OrdemServico.DataEmissao := DataSet.FieldByName('DATADIGITA').AsDateTime;
      OrdemServico.HoraEmissao := DataSet.FieldByName('HORADIGITA').AsDateTime;
      OrdemServico.DataPrevisao := DataSet.FieldByName('DATAPREVISAO').AsDateTime;
      OrdemServico.HoraPrevisao := DataSet.FieldByName('HORAPREVISAO').AsDateTime;
      OrdemServico.ClienteId := DataSet.FieldByName('CODCLI').AsInteger;
      OrdemServico.VendedorId := DataSet.FieldByName('CODVEND').AsInteger;
      OrdemServico.FuncionarioLaboratorioId := DataSet.FieldByName('CODFECHA').AsInteger;
      OrdemServico.VendedorLibId := DataSet.FieldByName('CODENTREGA').AsInteger;
      OrdemServico.FotografoId := DataSet.FieldByName('CODFOTOGRAFO').AsInteger;
      OrdemServico.Modelo := DataSet.FieldByName('MODELOSTUDIO').AsString;
      OrdemServico.Cancelado := DataSet.FieldByName('CANCELADO').AsString;
      OrdemServico.DataCancelamento := DataSet.FieldByName('DTCANCEL').AsDateTime;
      OrdemServico.Faturado := DataSet.FieldByName('FATURADO').AsString;
      OrdemServico.DataFaturamento := DataSet.FieldByName('DATAEMISSAONF').AsDateTime;
      OrdemServico.Situacao := DataSet.FieldByName('SITUACAOOS').AsString;
      OrdemServico.SituacaoAnterior := DataSet.FieldByName('SITUACAOOS').AsString;
      OrdemServico.Setor := DataSet.FieldByName('CODSETOR').AsInteger;
      OrdemServico.ValorSinal := DataSet.FieldByName('VRADIANTAMENTO').AsFloat;
      OrdemServico.ValorSinalAnterior := DataSet.FieldByName('VRADIANTAMENTO').AsFloat;
      dPercDescOS := RoundTo(DataSet.FieldByName('PERCDESCOS').AsFloat,-2);
      dVrDescOS := RoundTo(DataSet.FieldByName('VRDESCOS').AsFloat,-2);

      OrdemServico.Observacao := DataSet.FieldByName('OBS').AsString;
      OrdemServico.ObservacaoRecibo := DataSet.FieldByName('OBSRECIBO').AsString;
      OrdemServico.ObservacaoRecibo2 := DataSet.FieldByName('OBSRECIBO2').AsString;
      OrdemServico.FormaPagtoId := DataSet.FieldByName('CODFORMAPAG').AsInteger;
      OrdemServico.FormaPagtoIdAnterior := DataSet.FieldByName('CODFORMAPAG').AsInteger;
      OrdemServico.PlanoPagtoId := DataSet.FieldByName('CODPLANOPAG').AsInteger;
      OrdemServico.Alteracao := True;

      while (Not DataSet.Eof) do
      Begin
        OrdemServico.cdsItens.Append();
        OrdemServico.cdsItens.FieldByName('ProdutoId').AsInteger := DataSet.FieldByName('CODPROD').AsInteger;
        OrdemServico.cdsItens.FieldByName('Produto').AsString := DataSet.FieldByName('PRODUTO').AsString;
        OrdemServico.cdsItens.FieldByName('Quantidade').AsFloat := DataSet.FieldByName('QUANTIDADE').AsFloat;
        OrdemServico.cdsItens.FieldByName('QuantidadeEmbalagem').AsFloat := DataSet.FieldByName('QUANT_EMBALAGEM').AsFloat;
        OrdemServico.cdsItens.FieldByName('QuantidadeBaixa').AsFloat := DataSet.FieldByName('QUANT_BAIXA').AsFloat;
        OrdemServico.cdsItens.FieldByName('ValorUnitario').AsFloat := DataSet.FieldByName('VRUNITARIO').AsFloat;
        OrdemServico.cdsItens.FieldByName('PercDesconto').AsFloat := DataSet.FieldByName('PERCDESC').AsFloat;
        OrdemServico.cdsItens.FieldByName('ValorDesconto').AsFloat := DataSet.FieldByName('VRDESC').AsFloat;
        OrdemServico.cdsItens.FieldByName('ValorTotal').AsFloat := RoundTo(DataSet.FieldByName('VRUNITARIO').AsFloat * OrdemServico.cdsItens.FieldByName('QUANTIDADE').AsFloat - OrdemServico.cdsItens.FieldByName('ValorDesconto').AsFloat, -2);
        OrdemServico.cdsItens.FieldByName('Tipo').AsString := DataSet.FieldByName('TIPO').AsString;
        OrdemServico.cdsItens.FieldByName('DescontoRateado').AsFloat := DataSet.FieldByName('DESCOS').AsFloat;
        OrdemServico.cdsItens.Post();
        DataSet.Next();
      End;
      OrdemServico.GetTotalItens();

      //Está abaixo porque depende dos objetos totais dos itens estarem preenchidos para calcular o desconto novamente.
      OrdemServico.PercDesconto := dPercDescOS;
      OrdemServico.Desconto := dVrDescOS;

//      if (OrdemServico.Situacao = 'E') or (OrdemServico.PedidoRapido) Then
//      begin
        ConexaoBanco := TConexaoBanco.Create(DataBase);
        ConexaoBanco.SQL.Add('SELECT                                                                                            ');
        ConexaoBanco.SQL.Add('CT.NUMERORECEBER,                                                                                 ');
        ConexaoBanco.SQL.Add('CT.EMISSAORECEBER,                                                                                ');
        ConexaoBanco.SQL.Add('CT.VENCIMENRECEBER,                                                                               ');
        ConexaoBanco.SQL.Add('CT.VALORRECEBER,                                                                                  ');
        ConexaoBanco.SQL.Add('CT.NPARCELA, CT.SINALOS                                                                                       ');
        ConexaoBanco.SQL.Add('FROM DGLOB210 CT                                                                                  ');
        ConexaoBanco.SQL.Add('INNER JOIN OS  On                                                                                 ');
        ConexaoBanco.SQL.Add('    OS.NUMOS = CT.NUMOS                                                                           ');
        ConexaoBanco.SQL.Add('    And OS.CODIGOEMP = CT.CODIGOEMP                                                               ');
        ConexaoBanco.SQL.Add('WHERE                                                                                             ');
        ConexaoBanco.SQL.Add('OS.NUMOS = :ID                                                                                    ');
        ConexaoBanco.SQL.Add('AND OS.CODIGOEMP = :CODIGOEMP                                                                     ');
        ConexaoBanco.Param.ParamByName('Id').AsInteger := OrdemServico.Id;
        ConexaoBanco.Param.ParamByName('CodigoEmp').AsInteger := DataBase.CodigoEmpresa;

        DataSet := ConexaoBanco.DataSetFactory.GetDataSet(TConexao.Empresa, ConexaoBanco.sql.Text, ConexaoBanco.Param);

        DataSet.First();
        if (Not DataSet.Eof) then
        begin
          while (Not DataSet.Eof) do
          Begin
            CtReceber.cdsCtRec.Append();
            CtReceber.cdsCtRec.FieldByName('Item').AsInteger := DataSet.FieldByName('NPARCELA').AsInteger;
            CtReceber.cdsCtRec.FieldByName('NumDocumento').AsString := DataSet.FieldByName('NUMERORECEBER').AsString;
            CtReceber.cdsCtRec.FieldByName('DiasParcela').AsInteger := Trunc(DataSet.FieldByName('VENCIMENRECEBER').AsDateTime - DataSet.FieldByName('EMISSAORECEBER').AsDateTime);
            CtReceber.cdsCtRec.FieldByName('DataVencimento').AsDateTime := DataSet.FieldByName('VENCIMENRECEBER').AsDateTime;
            CtReceber.cdsCtRec.FieldByName('ValorDocumento').AsFloat := DataSet.FieldByName('VALORRECEBER').AsFloat;
            CtReceber.cdsCtRec.FieldByName('Sinal').AsString := DataSet.FieldByName('SINALOS').AsString;
            CtReceber.cdsCtRec.Post();
            DataSet.Next();
          End;
        end;
//      end;

      ConexaoBanco := TConexaoBanco.Create(DataBase);
      ConexaoBanco.SQL.Add('UPDATE OS SET USUARIOBLOQ = :USUARIO WHERE NUMOS = :NUMOS AND CODIGOEMP = :CODIGOEMP');
      ConexaoBanco.Param.ParamByName('NUMOS').AsInteger := OrdemServico.Id;
      ConexaoBanco.Param.ParamByName('USUARIO').AsString := sUsuario;
      ConexaoBanco.Param.ParamByName('CodigoEmp').AsInteger := DataBase.CodigoEmpresa;
      ConexaoBanco.DataSetFactory.PostDataSet(TConexao.Empresa, ConexaoBanco.sql.Text, ConexaoBanco.Param);

      Result := True;
    End;
  Except
    On e : Exception do
    Begin
      TCustomExcept.Show(e, 'Erro ao consultar Ordem de Serviço');
    End;
  End;
End;

Class Function TOrdemServicoRepository.ConsultaSetorUltimaOS(Usuario : TUsuario; DataBase : TDataBase):Integer;
Var
  ConexaoBanco : TConexaoBanco;
  DataSet : TDataSet;
Begin
  Try
    ConexaoBanco := TConexaoBanco.Create(DataBase);
    ConexaoBanco.SQL.Add('SELECT OS.CODSETOR FROM OS WHERE OS.USUARIOCRIACAO = :USUARIO AND OS.CODIGOEMP = :CODIGOEMP ORDER BY NUMOS DESC');

    ConexaoBanco.Param.ParamByName('USUARIO').AsString := Usuario.Nome;
    ConexaoBanco.Param.ParamByName('CodigoEmp').AsInteger := DataBase.CodigoEmpresa;

    DataSet := ConexaoBanco.DataSetFactory.GetDataSet(TConexao.Empresa, ConexaoBanco.sql.Text, ConexaoBanco.Param);

    DataSet.First();
    if (Not DataSet.Eof) then
    Begin
      Result := DataSet.FieldByName('CODSETOR').AsInteger;
    End
    else
      Result := 0;
  Except
    On e : Exception do
    Begin
      TCustomExcept.Show(e, 'Erro ao consultar Ordem de Serviço');
    End;
  End;
End;

Class Function TOrdemServicoRepository.Gravar(OrdemServico : TOrdemServicoEntity; CtReceber : TCtReceber;  FormaPagamento : TFormaPagamento; PlanoPagamento : TPlanoPagamento; Cliente : TPessoa; Usuario : TUsuario; DataBase : TDataBase):Boolean;
Var
  ConexaoBanco : TConexaoBanco;
  Gravou : Boolean;
  iTentativas : Integer;
  Erro : String;
Begin
  Result := False;
  Gravou := False;
  iTentativas := 1;

  ConexaoBanco := TConexaoBanco.Create(DataBase);
  while (Not Gravou)and(iTentativas <= 10) do
  Begin
    Try
      ConexaoBanco.DataSetFactory.StartTransaction(TConexao.Empresa);
      TLog.Write('TRANSACAO INICIADA');
      {$Region 'Tabela OrdemServico'}
      if OrdemServico.Alteracao then
      Begin
        if ((OrdemServico.Situacao = 'A') and (OrdemServico.ValorSinal <> OrdemServico.ValorSinalAnterior) or
                                              (OrdemServico.FormaPagtoId <> OrdemServico.FormaPagtoIdAnterior )) or
           ((OrdemServico.Situacao = 'E') and (OrdemServico.Situacao = OrdemServico.SituacaoAnterior)) and
           (not OrdemServico.OrcamentoAnterior) then
          ExcluirFinanceiro(OrdemServico, DataBase);


        {$Region 'Update'}
        ConexaoBanco.SQL.Clear;
        ConexaoBanco.SQL.Add('UPDATE OS SET                                   ');
        ConexaoBanco.SQL.Add('ORCAMENTO = :ORCAMENTO,                         ');
        ConexaoBanco.SQL.Add('CODCLI = :CODCLI,                               ');
        ConexaoBanco.SQL.Add('CODSETOR = :CODSETOR,                           ');
        ConexaoBanco.SQL.Add('CODVEND = :CODVEND,                             ');
        ConexaoBanco.SQL.Add('CODFECHA = :CODFECHA,                           ');
        ConexaoBanco.SQL.Add('CODFOTOGRAFO = :CODFOTOGRAFO,                   ');
        ConexaoBanco.SQL.Add('MODELOSTUDIO = :MODELOSTUDIO,                   ');
        ConexaoBanco.SQL.Add('CODENTREGA = :CODENTREGA,                       ');
        ConexaoBanco.SQL.Add('DATADIGITA = :DATADIGITA,                       ');
        ConexaoBanco.SQL.Add('HORADIGITA = :HORADIGITA,                       ');
        ConexaoBanco.SQL.Add('DATAPREVISAO = :DATAPREVISAO,                   ');
        ConexaoBanco.SQL.Add('HORAPREVISAO = :HORAPREVISAO,                   ');
        if (OrdemServico.Situacao = 'E') or (OrdemServico.PedidoRapido) then
        Begin
          ConexaoBanco.SQL.Add('DATAENTREGA = :DATAENTREGA,                   ');
          ConexaoBanco.SQL.Add('HORAENTREGA = :HORAENTREGA,                   ');
        End;
        if OrdemServico.Situacao = 'F' then
        begin
          ConexaoBanco.SQL.Add('DATAFECHA = :DATAFECHA,                       ');
          ConexaoBanco.SQL.Add('HORAFECHA = :HORAFECHA,                       ');
        end;
        ConexaoBanco.SQL.Add('VRADIANTAMENTO = :VRADIANTAMENTO,               ');
        ConexaoBanco.SQL.Add('NRENVELOPE = :NRENVELOPE,                       ');
        ConexaoBanco.SQL.Add('CANCELADO = :CANCELADO,                         ');
        ConexaoBanco.SQL.Add('DTCANCEL = :DTCANCEL,                           ');
        ConexaoBanco.SQL.Add('SITUACAOOS = :SITUACAOOS,                       ');
        ConexaoBanco.SQL.Add('TOTALOS = :TOTALOS,                             ');
        ConexaoBanco.SQL.Add('TOTALPRODUTOS = :TOTALPRODUTOS,                 ');
        ConexaoBanco.SQL.Add('TOTALSERVICOS = :TOTALSERVICOS,                 ');
        ConexaoBanco.SQL.Add('PERCDESCOS = :PERCDESCOS,                       ');
        ConexaoBanco.SQL.Add('VRDESCOS = :VRDESCOS,                           ');
        ConexaoBanco.SQL.Add('OBS = :OBS,                                     ');
        ConexaoBanco.SQL.Add('OBSRECIBO = :OBSRECIBO,                         ');
        ConexaoBanco.SQL.Add('OBSRECIBO2 = :OBSRECIBO2,                       ');
        ConexaoBanco.SQL.Add('CODFORMAPAG = :CODFORMAPAG,                     ');
        ConexaoBanco.SQL.Add('CODPLANOPAG = :CODPLANOPAG                      ');
        ConexaoBanco.SQL.Add('WHERE                                           ');
        ConexaoBanco.SQL.Add('NUMOS = :NUMOS                                  ');
        ConexaoBanco.SQL.Add('AND CODIGOEMP = :CODIGOEMP                      ');
        {$EndRegion}
      End
      else
      Begin
        {$Region 'Insert'}
        ConexaoBanco.SQL.Clear;
        ConexaoBanco.SQL.Add('INSERT INTO OS (                               ');
        ConexaoBanco.SQL.Add('NUMOS,                                          ');
        ConexaoBanco.SQL.Add('ORCAMENTO,                                      ');
        ConexaoBanco.SQL.Add('PEDIDORAPIDO,                                   ');
        ConexaoBanco.SQL.Add('CODSETOR,                                       ');
        ConexaoBanco.SQL.Add('CODIGOEMP,                                      ');
        ConexaoBanco.SQL.Add('CODCLI,                                         ');
        ConexaoBanco.SQL.Add('CODVEND,                                        ');
        ConexaoBanco.SQL.Add('CODFOTOGRAFO,                                   ');
        ConexaoBanco.SQL.Add('MODELOSTUDIO,                                   ');
        ConexaoBanco.SQL.Add('DATADIGITA,                                     ');
        ConexaoBanco.SQL.Add('HORADIGITA,                                     ');
        ConexaoBanco.SQL.Add('DATAPREVISAO,                                   ');
        ConexaoBanco.SQL.Add('HORAPREVISAO,                                   ');
        if (OrdemServico.Situacao = 'E') or (OrdemServico.PedidoRapido) then
        Begin
          ConexaoBanco.SQL.Add('DATAENTREGA,                                  ');
          ConexaoBanco.SQL.Add('HORAENTREGA,                                  ');
        End;
        if OrdemServico.Situacao = 'F' then
        begin
          ConexaoBanco.SQL.Add('DATAFECHA,                                    ');
          ConexaoBanco.SQL.Add('HORAFECHA,                                    ');
        end;
        ConexaoBanco.SQL.Add('DATAENT,                                        ');
        ConexaoBanco.SQL.Add('HORAENT,                                        ');
        ConexaoBanco.SQL.Add('CANCELADO,                                      ');
        ConexaoBanco.SQL.Add('DTCANCEL,                                       ');
        ConexaoBanco.SQL.Add('FATURADO,                                       ');
        ConexaoBanco.SQL.Add('SITUACAOOS,                                     ');
        ConexaoBanco.SQL.Add('NRENVELOPE,                                     ');
        ConexaoBanco.SQL.Add('VRADIANTAMENTO,                                 ');
        ConexaoBanco.SQL.Add('CODFECHA,                                       ');
        ConexaoBanco.SQL.Add('CODENTREGA,                                     ');
        ConexaoBanco.SQL.Add('MARCA,                                          ');
        ConexaoBanco.SQL.Add('FABRICANTE,                                     ');
        ConexaoBanco.SQL.Add('CODCONTA,                                       ');
        ConexaoBanco.SQL.Add('CODTIPODOC,                                     ');
        ConexaoBanco.SQL.Add('TIPOOS,                                         ');
        ConexaoBanco.SQL.Add('CODRESPTESTE,                                   ');
        ConexaoBanco.SQL.Add('CODRECEB,                                       ');
        ConexaoBanco.SQL.Add('CODPLANOPAG,                                    ');
        ConexaoBanco.SQL.Add('CODFORMAPAG,                                    ');
        ConexaoBanco.SQL.Add('TOTALOS,                                        ');
        ConexaoBanco.SQL.Add('TOTALPRODUTOS,                                  ');
        ConexaoBanco.SQL.Add('TOTALSERVICOS,                                  ');
        ConexaoBanco.SQL.Add('PERCDESCOS,                                     ');
        ConexaoBanco.SQL.Add('VRDESCOS,                                       ');
        ConexaoBanco.SQL.Add('OBS,                                            ');
        ConexaoBanco.SQL.Add('OBSRECIBO,                                      ');
        ConexaoBanco.SQL.Add('OBSRECIBO2,                                     ');
        ConexaoBanco.SQL.Add('USUARIOCRIACAO                                  ');
        ConexaoBanco.SQL.Add(') VALUES (                                      ');
        ConexaoBanco.SQL.Add(':NUMOS,                                         ');
        ConexaoBanco.SQL.Add(':ORCAMENTO,                                     ');
        ConexaoBanco.SQL.Add(':PEDIDORAPIDO,                                  ');
        ConexaoBanco.SQL.Add(':CODSETOR,                                      ');
        ConexaoBanco.SQL.Add(':CODIGOEMP,                                     ');
        ConexaoBanco.SQL.Add(':CODCLI,                                        ');
        ConexaoBanco.SQL.Add(':CODVEND,                                       ');
        ConexaoBanco.SQL.Add(':CODFOTOGRAFO,                                  ');
        ConexaoBanco.SQL.Add(':MODELOSTUDIO,                                  ');
        ConexaoBanco.SQL.Add(':DATADIGITA,                                    ');
        ConexaoBanco.SQL.Add(':HORADIGITA,                                    ');
        ConexaoBanco.SQL.Add(':DATAPREVISAO,                                  ');
        ConexaoBanco.SQL.Add(':HORAPREVISAO,                                  ');
        if (OrdemServico.Situacao = 'E') or (OrdemServico.PedidoRapido) then
        Begin
          ConexaoBanco.SQL.Add(':DATAENTREGA,                                 ');
          ConexaoBanco.SQL.Add(':HORAENTREGA,                                 ');
        End;
        if OrdemServico.Situacao = 'F' then
        Begin
          ConexaoBanco.SQL.Add(':DATAFECHA,                                   ');
          ConexaoBanco.SQL.Add(':HORAFECHA,                                   ');
        End;
        ConexaoBanco.SQL.Add(':DATAENT,                                       ');
        ConexaoBanco.SQL.Add(':HORAENT,                                       ');
        ConexaoBanco.SQL.Add(':CANCELADO,                                     ');
        ConexaoBanco.SQL.Add(':DTCANCEL,                                      ');
        ConexaoBanco.SQL.Add(':FATURADO,                                      ');
        ConexaoBanco.SQL.Add(':SITUACAOOS,                                    ');
        ConexaoBanco.SQL.Add(':NRENVELOPE,                                    ');
        ConexaoBanco.SQL.Add(':VRADIANTAMENTO,                                ');
        ConexaoBanco.SQL.Add(':CODFECHA,                                      ');
        ConexaoBanco.SQL.Add(':CODENTREGA,                                    ');
        ConexaoBanco.SQL.Add(':MARCA,                                         ');
        ConexaoBanco.SQL.Add(':FABRICANTE,                                    ');
        ConexaoBanco.SQL.Add(':CODCONTA,                                      ');
        ConexaoBanco.SQL.Add(':CODTIPODOC,                                    ');
        ConexaoBanco.SQL.Add(':TIPOOS,                                        ');
        ConexaoBanco.SQL.Add(':CODRESPTESTE,                                  ');
        ConexaoBanco.SQL.Add(':CODRECEB,                                      ');
        ConexaoBanco.SQL.Add(':CODPLANOPAG,                                   ');
        ConexaoBanco.SQL.Add(':CODFORMAPAG,                                   ');
        ConexaoBanco.SQL.Add(':TOTALOS,                                       ');
        ConexaoBanco.SQL.Add(':TOTALPRODUTOS,                                 ');
        ConexaoBanco.SQL.Add(':TOTALSERVICOS,                                 ');
        ConexaoBanco.SQL.Add(':PERCDESCOS,                                    ');
        ConexaoBanco.SQL.Add(':VRDESCOS,                                      ');
        ConexaoBanco.SQL.Add(':OBS,                                           ');
        ConexaoBanco.SQL.Add(':OBSRECIBO,                                     ');
        ConexaoBanco.SQL.Add(':OBSRECIBO2,                                    ');
        ConexaoBanco.SQL.Add(':USUARIOCRIACAO                                 ');
        ConexaoBanco.SQL.Add(')                                               ');

        OrdemServico.Id := TOrdemServicoRepository.AutoIncremento(DataBase);
        TLog.Write('NUMERO DA O.S. A SER GRAVADA: ' + IntToStr(OrdemServico.Id));
        {$EndRegion}
      End;

      {$Region 'ParamByName OrdemServico'}
      ConexaoBanco.Param.ParamByName('NUMOS').AsInteger := OrdemServico.Id;
      if (OrdemServico.Orcamento) then
        ConexaoBanco.Param.ParamByName('ORCAMENTO').AsString := 'S'
      Else
        ConexaoBanco.Param.ParamByName('ORCAMENTO').AsString := 'N';

      if (OrdemServico.PedidoRapido) then
        ConexaoBanco.Param.ParamByName('PEDIDORAPIDO').AsString := 'S'
      Else
        ConexaoBanco.Param.ParamByName('PEDIDORAPIDO').AsString := 'N';
      ConexaoBanco.Param.ParamByName('CODSETOR').AsInteger := OrdemServico.Setor;
      ConexaoBanco.Param.ParamByName('CODIGOEMP').AsInteger := DataBase.CodigoEmpresa;
      ConexaoBanco.Param.ParamByName('CODCLI').AsInteger := OrdemServico.ClienteId;
      ConexaoBanco.Param.ParamByName('CODVEND').AsInteger := OrdemServico.VendedorId;
      ConexaoBanco.Param.ParamByName('DATADIGITA').AsDateTime := StrToDateTime(FormatDateTime('dd/mm/yyyy',OrdemServico.DataEmissao));
      ConexaoBanco.Param.ParamByName('HORADIGITA').AsDateTime := StrToDateTime(FormatDateTime('hh:mm',OrdemServico.HoraEmissao));
      ConexaoBanco.Param.ParamByName('DATAPREVISAO').AsDateTime := StrToDateTime(FormatDateTime('dd/mm/yyyy',OrdemServico.DataPrevisao));
      ConexaoBanco.Param.ParamByName('HORAPREVISAO').AsDateTime := StrToDateTime(FormatDateTime('hh:mm',OrdemServico.HoraPrevisao));
      if OrdemServico.Situacao = 'F' then
      begin
        ConexaoBanco.Param.ParamByName('DATAFECHA').AsDateTime := StrToDateTime(FormatDateTime('dd/mm/yyyy',OrdemServico.DataFechamento ));
        ConexaoBanco.Param.ParamByName('HORAFECHA').AsDateTime := StrToDateTime(FormatDateTime('hh:mm',OrdemServico.HoraFechamento));
      end;

      if (OrdemServico.Situacao = 'E') then
      begin
        ConexaoBanco.Param.ParamByName('DATAENTREGA').AsDateTime := StrToDateTime(FormatDateTime('dd/mm/yyyy',OrdemServico.DataEntrega ));
        ConexaoBanco.Param.ParamByName('HORAENTREGA').AsDateTime := StrToDateTime(FormatDateTime('hh:mm',OrdemServico.HoraEntrega));
      end
      else if (OrdemServico.PedidoRapido) then
      begin
        ConexaoBanco.Param.ParamByName('DATAENTREGA').AsDateTime := Date;
        ConexaoBanco.Param.ParamByName('HORAENTREGA').AsDateTime := Now;
      end;

      ConexaoBanco.Param.ParamByName('DATAENT').AsDateTime := StrToDateTime(FormatDateTime('dd/mm/yyyy',OrdemServico.DataEmissao));
      ConexaoBanco.Param.ParamByName('HORAENT').AsDateTime := StrToDateTime(FormatDateTime('hh:mm',OrdemServico.HoraEmissao));
      ConexaoBanco.Param.ParamByName('CANCELADO').AsString := OrdemServico.Cancelado;
      if (OrdemServico.Cancelado = 'S') then
        ConexaoBanco.Param.ParamByName('DTCANCEL').AsDateTime := OrdemServico.DataCancelamento
      else
        TOrdemServicoRepository.SetNull(ConexaoBanco, ftDateTime, 'DTCANCEL');

      ConexaoBanco.Param.ParamByName('FATURADO').AsString := OrdemServico.Faturado;

      if OrdemServico.PedidoRapido then
         ConexaoBanco.Param.ParamByName('SITUACAOOS').AsString := 'E'
      else
        ConexaoBanco.Param.ParamByName('SITUACAOOS').AsString := OrdemServico.Situacao;
      ConexaoBanco.Param.ParamByName('NRENVELOPE').AsInteger := OrdemServico.Envelope;
      ConexaoBanco.Param.ParamByName('VRADIANTAMENTO').AsFloat := OrdemServico.ValorSinal;
      ConexaoBanco.Param.ParamByName('CODFECHA').AsInteger := OrdemServico.FuncionarioLaboratorioId;
      ConexaoBanco.Param.ParamByName('CODENTREGA').AsInteger := OrdemServico.VendedorLibId;
      ConexaoBanco.Param.ParamByName('CODFOTOGRAFO').AsInteger := OrdemServico.FotografoId;
      ConexaoBanco.Param.ParamByName('MODELOSTUDIO').AsString := OrdemServico.Modelo;
      ConexaoBanco.Param.ParamByName('MARCA').AsInteger := 0;
      ConexaoBanco.Param.ParamByName('FABRICANTE').AsInteger := 0;
      ConexaoBanco.Param.ParamByName('CODCONTA').AsInteger := StrToInt(TParametros.VerificaParametros('CODCONTAOS','I',DataBase));
      ConexaoBanco.Param.ParamByName('CODTIPODOC').AsInteger := StrToInt(TParametros.VerificaParametros('CODTIPODOCOS', 'I',DataBase));
      ConexaoBanco.Param.ParamByName('TIPOOS').AsInteger := 1;
      ConexaoBanco.Param.ParamByName('CODRESPTESTE').AsInteger := 0;
      ConexaoBanco.Param.ParamByName('CODPLANOPAG').AsInteger := OrdemServico.PlanoPagtoId;
      ConexaoBanco.Param.ParamByName('CODFORMAPAG').AsInteger := OrdemServico.FormaPagtoId;
      ConexaoBanco.Param.ParamByName('CODRECEB').AsInteger := 0;
      ConexaoBanco.Param.ParamByName('TOTALOS').AsFloat := OrdemServico.ValorTotal;
      ConexaoBanco.Param.ParamByName('TOTALPRODUTOS').AsFloat := SomarTotalProdutos(OrdemServico);
      ConexaoBanco.Param.ParamByName('TOTALSERVICOS').AsFloat := SomarTotalServicos(OrdemServico);
      ConexaoBanco.Param.ParamByName('PERCDESCOS').AsFloat := OrdemServico.PercDesconto;
      ConexaoBanco.Param.ParamByName('VRDESCOS').AsFloat := OrdemServico.Desconto;
      ConexaoBanco.Param.ParamByName('OBS').AsBlob := OrdemServico.Observacao;
      ConexaoBanco.Param.ParamByName('OBSRECIBO').AsString := OrdemServico.ObservacaoRecibo;
      ConexaoBanco.Param.ParamByName('OBSRECIBO2').AsString := OrdemServico.ObservacaoRecibo2;
      ConexaoBanco.Param.ParamByName('USUARIOCRIACAO').AsString := Usuario.Nome;

      {$EndRegion}

      ConexaoBanco.DataSetFactory.PostDataSet(TConexao.Empresa, ConexaoBanco.sql.Text , ConexaoBanco.Param);
      TLog.Write('GRAVACAO O.S. REALIZADA.');
      {$EndRegion}

      {$Region 'Tabela ITOS'}
        {$Region 'Estornar Estoque se for alteração}
        if (OrdemServico.Alteracao) and (not OrdemServico.OrcamentoAnterior) then
        begin
          EstornarEstoque(OrdemServico, DataBase);
        end;
        {$EndRegion}

        {$Region 'Excluir Itens'}
        ConexaoBanco.Clear();
        TOrdemServicoRepository.SqlExcluirItens(ConexaoBanco);
        ConexaoBanco.Param.ParamByName('NUMOS').AsInteger := OrdemServico.Id;
        ConexaoBanco.Param.ParamByName('CODIGOEMP').AsInteger := DataBase.CodigoEmpresa;

        ConexaoBanco.DataSetFactory.PostDataSet(TConexao.Empresa, ConexaoBanco.sql.Text, ConexaoBanco.Param);
        {$EndRegion}

        {$Region 'Inserir Itens'}
        OrdemServico.cdsItens.First();
        ConexaoBanco.Clear();
        ConexaoBanco.SQL.Add('INSERT INTO ITOS (                              ');
        ConexaoBanco.SQL.Add('NUMOS,                                          ');
        ConexaoBanco.SQL.Add('NUMITEM,                                        ');
        ConexaoBanco.SQL.Add('CODPROD,                                        ');
        ConexaoBanco.SQL.Add('CODBARRAS,                                      ');
        ConexaoBanco.SQL.Add('QUANTIDADE,                                     ');
        ConexaoBanco.SQL.Add('VRUNITARIO,                                     ');
        ConexaoBanco.SQL.Add('PERCDESC,                                       ');
        ConexaoBanco.SQL.Add('VRDESC,                                         ');
        ConexaoBanco.SQL.Add('VRACRES,                                        ');
        ConexaoBanco.SQL.Add('PERCACRES,                                      ');
        ConexaoBanco.SQL.Add('VRTOTAL,                                        ');
        ConexaoBanco.SQL.Add('QUANT_BAIXA,                                    ');
        ConexaoBanco.SQL.Add('QUANT_EMBALAGEM,                                ');
        ConexaoBanco.SQL.Add('CODUNIDADE,                                     ');
        ConexaoBanco.SQL.Add('PRCOMPRAPROD,                                   ');
        ConexaoBanco.SQL.Add('PRMARGEMZERO,                                   ');
        ConexaoBanco.SQL.Add('PRVENDA,                                        ');
        ConexaoBanco.SQL.Add('TIPOPRECO,                                      ');
        ConexaoBanco.SQL.Add('CODPROMOCAO,                                    ');
        ConexaoBanco.SQL.Add('PRCUSTOPROD,                                    ');
        ConexaoBanco.SQL.Add('FUNCIONARIO,                                    ');
        ConexaoBanco.SQL.Add('TIPO,                                           ');
        ConexaoBanco.SQL.Add('PERCCOMBRVEND,                                  ');
        ConexaoBanco.SQL.Add('PERCCOMLIQVEND,                                 ');
        ConexaoBanco.SQL.Add('PERCCOMBRREPRES,                                ');
        ConexaoBanco.SQL.Add('PERCCOMLIQREPRES,                               ');
        ConexaoBanco.SQL.Add('PRCUSTOMEDIO,                                   ');
        ConexaoBanco.SQL.Add('PRCOMPRAMEDIO,                                  ');
        ConexaoBanco.SQL.Add('TIPOPRVISTAPRAZO,                               ');
        ConexaoBanco.SQL.Add('CODIGOEMP, DESCOS                               ');
        ConexaoBanco.SQL.Add(') VALUES (                                      ');
        ConexaoBanco.SQL.Add(':NUMOS,                                         ');
        ConexaoBanco.SQL.Add(':NUMITEM,                                       ');
        ConexaoBanco.SQL.Add(':CODPROD,                                       ');
        ConexaoBanco.SQL.Add(':CODBARRAS,                                     ');
        ConexaoBanco.SQL.Add(':QUANTIDADE,                                    ');
        ConexaoBanco.SQL.Add(':VRUNITARIO,                                    ');
        ConexaoBanco.SQL.Add(':PERCDESC,                                      ');
        ConexaoBanco.SQL.Add(':VRDESC,                                        ');
        ConexaoBanco.SQL.Add(':VRACRES,                                        ');
        ConexaoBanco.SQL.Add(':PERCACRES,                                      ');
        ConexaoBanco.SQL.Add(':VRTOTAL,                                       ');
        ConexaoBanco.SQL.Add(':QUANT_BAIXA,                                   ');
        ConexaoBanco.SQL.Add(':QUANT_EMBALAGEM,                               ');
        ConexaoBanco.SQL.Add(':CODUNIDADE,                                    ');
        ConexaoBanco.SQL.Add(':PRCOMPRAPROD,                                  ');
        ConexaoBanco.SQL.Add(':PRMARGEMZERO,                                  ');
        ConexaoBanco.SQL.Add(':PRVENDA,                                       ');
        ConexaoBanco.SQL.Add(':TIPOPRECO,                                     ');
        ConexaoBanco.SQL.Add(':CODPROMOCAO,                                   ');
        ConexaoBanco.SQL.Add(':PRCUSTOPROD,                                   ');
        ConexaoBanco.SQL.Add(':FUNCIONARIO,                                   ');
        ConexaoBanco.SQL.Add(':TIPO,                                          ');
        ConexaoBanco.SQL.Add(':PERCCOMBRVEND,                                 ');
        ConexaoBanco.SQL.Add(':PERCCOMLIQVEND,                                ');
        ConexaoBanco.SQL.Add(':PERCCOMBRREPRES,                               ');
        ConexaoBanco.SQL.Add(':PERCCOMLIQREPRES,                              ');
        ConexaoBanco.SQL.Add(':PRCUSTOMEDIO,                                  ');
        ConexaoBanco.SQL.Add(':PRCOMPRAMEDIO,                                 ');
        ConexaoBanco.SQL.Add(':TIPOPRVISTAPRAZO,                              ');
        ConexaoBanco.SQL.Add(':CODIGOEMP, :DESCOS                             ');
        ConexaoBanco.SQL.Add(')                                               ');
        while (Not OrdemServico.cdsItens.Eof) do
        Begin
          ConexaoBanco.ClearParam();

          ConexaoBanco.Param.ParamByName('NUMOS').AsInteger             := OrdemServico.Id;
          ConexaoBanco.Param.ParamByName('NUMITEM').AsInteger           := OrdemServico.cdsItens.RecNo;
          ConexaoBanco.Param.ParamByName('CODPROD').AsInteger           := OrdemServico.cdsItens.FieldByName('ProdutoId').AsInteger;
          ConexaoBanco.Param.ParamByName('CODBARRAS').AsString          := '';
          ConexaoBanco.Param.ParamByName('QUANTIDADE').AsFloat          := OrdemServico.cdsItens.FieldByName('Quantidade').AsFloat;
          ConexaoBanco.Param.ParamByName('VRUNITARIO').AsFloat          := OrdemServico.cdsItens.FieldByName('ValorUnitario').AsFloat;
          ConexaoBanco.Param.ParamByName('PERCDESC').AsFloat            := OrdemServico.cdsItens.FieldByName('PercDesconto').AsFloat;
          ConexaoBanco.Param.ParamByName('VRDESC').AsFloat              := OrdemServico.cdsItens.FieldByName('ValorDesconto').AsFloat;
          ConexaoBanco.Param.ParamByName('PERCACRES').AsFloat           := 0;
          ConexaoBanco.Param.ParamByName('VRACRES').AsFloat             := 0;
          ConexaoBanco.Param.ParamByName('VRTOTAL').AsFloat             := OrdemServico.cdsItens.FieldByName('ValorTotal').AsFloat;
          ConexaoBanco.Param.ParamByName('QUANT_BAIXA').AsFloat         := OrdemServico.cdsItens.FieldByName('QuantidadeBaixa').AsFloat;
          ConexaoBanco.Param.ParamByName('QUANT_EMBALAGEM').AsFloat     := OrdemServico.cdsItens.FieldByName('QuantidadeEmbalagem').AsFloat;
          ConexaoBanco.Param.ParamByName('CODUNIDADE').AsInteger        := OrdemServico.cdsItens.FieldByName('CodUnidade').AsInteger;
          ConexaoBanco.Param.ParamByName('PRCOMPRAPROD').AsFloat        := OrdemServico.cdsItens.FieldByName('PrCompraProd').AsFloat;
          ConexaoBanco.Param.ParamByName('PRMARGEMZERO').AsFloat        := OrdemServico.cdsItens.FieldByName('PrMargemZero').AsFloat;
          ConexaoBanco.Param.ParamByName('PRVENDA').AsFloat             := OrdemServico.cdsItens.FieldByName('ValorUnitario').AsFloat;
          ConexaoBanco.Param.ParamByName('TIPOPRECO').AsString          := OrdemServico.cdsItens.FieldByName('TipoPreco').AsString;
          ConexaoBanco.Param.ParamByName('CODPROMOCAO').AsInteger       := 0;
          ConexaoBanco.Param.ParamByName('PRCUSTOPROD').AsFloat         := OrdemServico.cdsItens.FieldByName('PrCustoProd').AsFloat;
          ConexaoBanco.Param.ParamByName('FUNCIONARIO').AsInteger       := 0;
          ConexaoBanco.Param.ParamByName('TIPO').AsString               := OrdemServico.cdsItens.FieldByName('Tipo').AsString;
          ConexaoBanco.Param.ParamByName('PERCCOMBRVEND').AsFloat       := OrdemServico.cdsItens.FieldByName('PercComBrVend').AsFloat;
          ConexaoBanco.Param.ParamByName('PERCCOMLIQVEND').AsFloat      := OrdemServico.cdsItens.FieldByName('PercComLiqVend').AsFloat;
          ConexaoBanco.Param.ParamByName('PERCCOMBRREPRES').AsFloat     := OrdemServico.cdsItens.FieldByName('PercComBrRepres').AsFloat;
          ConexaoBanco.Param.ParamByName('PERCCOMLIQREPRES').AsFloat    := OrdemServico.cdsItens.FieldByName('PercComLiqRepres').AsFloat;
          ConexaoBanco.Param.ParamByName('PRCUSTOMEDIO').AsFloat        := OrdemServico.cdsItens.FieldByName('PrCustoMedio').AsFloat;
          ConexaoBanco.Param.ParamByName('PRCOMPRAMEDIO').AsFloat       := OrdemServico.cdsItens.FieldByName('PrCompraMedio').AsFloat;
          ConexaoBanco.Param.ParamByName('TIPOPRVISTAPRAZO').AsString   := 'V';
          ConexaoBanco.Param.ParamByName('CODIGOEMP').AsInteger         := DataBase.CodigoEmpresa;
          ConexaoBanco.Param.ParamByName('DESCOS').AsFloat              := OrdemServico.cdsItens.FieldByName('DescontoRateado').AsFloat;
          ConexaoBanco.DataSetFactory.PostDataSet(TConexao.Empresa, ConexaoBanco.sql.Text, ConexaoBanco.Param);

          OrdemServico.cdsItens.Next();
        End;
        {$EndRegion}
      {$EndRegion}

      {$Region 'Baixar Estoque'}
      if (not OrdemServico.Orcamento) then
      BaixarEstoque(OrdemServico, DataBase);
      {$EndRegion}

      {$Region 'Gerar Comissoes'}
      If (not OrdemServico.Orcamento) and
         ((OrdemServico.Situacao = 'E') or (OrdemServico.PedidoRapido)) then
      begin
        if (OrdemServico.Alteracao) And ((OrdemServico.Situacao = 'E') or (OrdemServico.PedidoRapido)) then
          EstornarComissao(False, OrdemServico, DataBase);
        if OrdemServico.ValorSinal > 0 then
          GerarComissao(True {Sinal}, OrdemServico, CtReceber, DataBase);
        GerarComissao(False {Sinal}, OrdemServico, CtReceber, DataBase);
      end;
      {$EndRegion}

      {$Region 'Contas a Receber'}
      if (not OrdemServico.Orcamento) then
      begin
        if (OrdemServico.Situacao = 'E') then
        begin
          CtReceber.cdsCtRec.Filtered := False;
          CtReceber.cdsCtRec.Filter := 'SINAL = ''N''';
          CtReceber.cdsCtRec.Filtered := True;
        end;
        if (CtReceber.cdsCtRec.RecordCount > 0) OR ((OrdemServico.ValorSinal <> 0) and (OrdemServico.Situacao = 'A')) then
        begin
          CtReceber.cdsCtRec.Filtered := False;
          if (FormaPagamento.EnviaMaisCaixa <> 'S')  then
          begin
            if (not TCtReceberRepository.GravarCtReceber(OrdemServico, CtReceber, FormaPagamento, Cliente, DataBase)) then
            begin
              TCustomMessage.Show('Não foi possivel gravar Contas a Receber. '+chr(13)+'Entrar em contato com Suporte.','Atenção!',TTypeMessage.Exclamation, TButtons.Ok);
              ConexaoBanco.DataSetFactory.RollBack(TConexao.Empresa);
              inc(iTentativas);
            end
            else
            begin
              if (FormaPagamento.Cartao = 'S') then
                TCtReceberRepository.GravarCtPagarCartao(OrdemServico, CtReceber, PlanoPagamento, FormaPagamento, Cliente, DataBase);
            end;
          end
          else if OrdemServico.Alteracao then
          begin
            if not VerificaFormaEnviaMaisCaixa(OrdemServico.FormaPagtoIdAnterior,DataBase) then
            begin
              if (OrdemServico.Alteracao) and (not OrdemServico.OrcamentoAnterior) then
              begin
                if (((OrdemServico.Situacao = 'A') and (OrdemServico.ValorSinal <> OrdemServico.ValorSinalAnterior) or
                                                       (OrdemServico.FormaPagtoId <> OrdemServico.FormaPagtoIdAnterior )) or
                   ((OrdemServico.Situacao = 'E') and (OrdemServico.Situacao = OrdemServico.SituacaoAnterior)))
                   or (OrdemServico.PedidoRapido) then
                begin
                  TCtReceberRepository.EstornarTaxaCartao(False, OrdemServico, CtReceber, DataBase);
                  TCtReceberRepository.EstornarContasaReceber(False, OrdemServico, DataBase);
                end;
              end;
            end;

          end;

        end;
        CtReceber.cdsCtRec.Filtered := False;
      end;
      {$EndRegion}


      TLog.Write('REALIZAR COMMIT');
      ConexaoBanco.DataSetFactory.Commit(TConexao.Empresa);
      TLog.Write('COMMIT REALIZADO');
      Gravou := True;
    Except
      On E : Exception do
      Begin
        ConexaoBanco.DataSetFactory.RollBack(TConexao.Empresa);
        TLog.Write('ROLLBACK REALIZADO PELO ERRO: ' + E.Message);
        TCustomExcept.Show(e, 'Erro ao Gravar OrdemServico => Tentativa : '+IntToStr(iTentativas), False);
        inc(iTentativas);
      End;
    End;
  End;
  result := Gravou;
End;

Class Procedure TOrdemServicoRepository.SqlExcluirItens(ConexaoBanco : TConexaoBanco);
Begin
  ConexaoBanco.sql.Add('DELETE FROM ITOS WHERE ');
  ConexaoBanco.sql.Add('NUMOS = :NUMOS    ');
  ConexaoBanco.sql.Add('AND CODIGOEMP = :CODIGOEMP    ');
End;

Class Procedure TOrdemServicoRepository.SetNull(ConexaoBanco:TConexaoBanco; DataType : TFieldType; NomeCampo : String);
Begin
  ConexaoBanco.Param.ParamByName(NomeCampo).DataType := DataType;
  ConexaoBanco.Param.ParamByName(NomeCampo).Value := Null;
End;

Class Function TOrdemServicoRepository.BaixarEstoque(OrdemServico : TOrdemServicoEntity; DataBase : TDataBase):Boolean;
Var
  ConexaoBanco : TConexaoBanco;
begin
  ConexaoBanco := TConexaoBanco.Create(DataBase);
  try
    ConexaoBanco.SQL.Add('UPDATE PRODUTOS_EMP SET QTDEATUALPRODUTO = QTDEATUALPRODUTO - :QTDE');
    ConexaoBanco.SQL.Add('WHERE CODIGOPRODUTO = :CODIGOPRODUTO AND CODIGOEMP = :CODIGOEMP');

    OrdemServico.cdsItens.First;

    while not OrdemServico.cdsItens.Eof do
    begin
      if (OrdemServico.cdsItens.FieldByName('Tipo').AsString = 'P') then
      begin
        ConexaoBanco.Param.ParamByName('QTDE').AsFloat             := OrdemServico.cdsItens.FieldByName('QuantidadeBaixa').AsFloat;
        ConexaoBanco.Param.ParamByName('CODIGOPRODUTO').AsInteger  := OrdemServico.cdsItens.FieldByName('ProdutoId').AsInteger;
        ConexaoBanco.Param.ParamByName('CODIGOEMP').AsInteger      := DataBase.CodigoEmpresa;

        BaixaEstoqueAutomaticoCST(OrdemServico.cdsItens.FieldByName('ProdutoId').AsString,
                                 'ITOS_CST',
                                 OrdemServico.cdsItens.FieldByName('QuantidadeBaixa').AsFloat,
                                 OrdemServico.Id,
                                 OrdemServico.cdsItens.RecNo,
                                 DataBase.CodigoEmpresa,
                                 DataBase.Empresa);

        ConexaoBanco.DataSetFactory.PostDataSet(TConexao.Empresa, ConexaoBanco.Sql.Text, ConexaoBanco.Param);
      end;
      OrdemServico.cdsItens.Next;
    end;

  Except
    On E : Exception do
    Begin
      TCustomExcept.Show(e, 'Erro ao tentar executar AutoIncremento');
    End;
  End;
end;

Class Function TOrdemServicoRepository.EstornarEstoque(OrdemServico : TOrdemServicoEntity; DataBase : TDataBase):Boolean;
Var
  ConexaoBanco : TConexaoBanco;
  DataSet      : TDataSet;
begin
  ConexaoBanco := TConexaoBanco.Create(DataBase);
  try
    ConexaoBanco.SQL.Add('SELECT NUMOS, NUMITEM, CODPROD, QUANT_BAIXA FROM ITOS');
    ConexaoBanco.SQL.Add('WHERE NUMOS = :NUMOS AND CODIGOEMP = :CODIGOEMP');

    ConexaoBanco.Param.ParamByName('NUMOS').AsInteger          := OrdemServico.Id;
    ConexaoBanco.Param.ParamByName('CODIGOEMP').AsInteger      := DataBase.CodigoEmpresa;

    DataSet := ConexaoBanco.DataSetFactory.GetDataSet(TConexao.Empresa, ConexaoBanco.Sql.Text, ConexaoBanco.Param);

    while not DataSet.Eof do
    begin
      ConexaoBanco.Clear;
      ConexaoBanco.ClearParam;
      ConexaoBanco.SQL.Add('UPDATE PRODUTOS_EMP SET QTDEATUALPRODUTO = QTDEATUALPRODUTO + :QTDE');
      ConexaoBanco.SQL.Add('WHERE CODIGOPRODUTO = :CODIGOPRODUTO AND CODIGOEMP = :CODIGOEMP');
      ConexaoBanco.Param.ParamByName('QTDE').AsFloat             := DataSet.FieldByName('QUANT_BAIXA').AsFloat;
      ConexaoBanco.Param.ParamByName('CODIGOPRODUTO').AsInteger  := DataSet.FieldByName('CODPROD').AsInteger;
      ConexaoBanco.Param.ParamByName('CODIGOEMP').AsInteger      := DataBase.CodigoEmpresa;
      ConexaoBanco.DataSetFactory.PostDataSet(TConexao.Empresa, ConexaoBanco.Sql.Text, ConexaoBanco.Param);

      EstornaBaixaAutomaticaCST(DataSet.FieldByName('CODPROD').AsString,
                                'ITOS_CST',
                                DataSet.FieldByName('QUANT_BAIXA').AsFloat,
                                DataSet.FieldByName('NUMOS').AsInteger,
                                DataSet.FieldByName('NUMITEM').AsInteger,
                                DataBase.CodigoEmpresa,
                                DataBase.Empresa);

      DataSet.Next;
    end;
  Except
    On E : Exception do
    Begin
      TCustomExcept.Show(e, 'Erro ao tentar executar AutoIncremento');
    End;
  End;
end;

Class Function TOrdemServicoRepository.ConsultaQtdeItemOS(iNumOS, iCodigoProduto : Integer; DataBase : TDataBase):Double;
Var
  ConexaoBanco : TConexaoBanco;
Begin
  Result := 0;
  Try
    ConexaoBanco := TConexaoBanco.Create(DataBase);
    ConexaoBanco.SQL.Add('SELECT                                                                                            ');
    ConexaoBanco.SQL.Add('SUM(QUANT_BAIXA) AS TOTAL                                                                         ');
    ConexaoBanco.SQL.Add('FROM ITOS                                                                                         ');
    ConexaoBanco.SQL.Add('WHERE                                                                                             ');
    ConexaoBanco.SQL.Add('NUMOS = :ID                                                                                       ');
    ConexaoBanco.SQL.Add('AND CODIGOEMP = :CODIGOEMP                                                                        ');
    ConexaoBanco.SQL.Add('AND CODPROD = :CODPROD                                                                            ');

    ConexaoBanco.Param.ParamByName('ID').AsInteger := iNumOS;
    ConexaoBanco.Param.ParamByName('CODIGOEMP').AsInteger := DataBase.CodigoEmpresa;
    ConexaoBanco.Param.ParamByName('CODPROD').AsInteger := iCodigoProduto;

    Result := ConexaoBanco.DataSetFactory.GetDataSet(TConexao.Empresa, ConexaoBanco.sql.Text, ConexaoBanco.Param).FieldByName('TOTAL').AsFloat;

  Except
    On e : Exception do
    Begin
      TCustomExcept.Show(e, 'Erro ao consultar Ordem de Serviço');
    End;
  End;
End;

Class Procedure TOrdemServicoRepository.ExcluirFinanceiro(OrdemServico : TOrdemServicoEntity; DataBase : TDataBase);
var
  ConexaoBanco : TConexaoBanco;
  DataSet : TDataSet;
  bPulouSinal : Boolean;
begin
  ConexaoBanco := TConexaoBanco.Create(DataBase);
  ConexaoBanco.Sql.Add('SELECT CODIGORECEBER, VALORRECEBER, NUMEROLANCAMENTO FROM DGLOB210 WHERE CODIGOEMP = :CODIGOEMP AND NUMOS = :NUMOS');
  ConexaoBanco.Param.ParamByName('CODIGOEMP').AsInteger := DataBase.CodigoEmpresa;
  ConexaoBanco.Param.ParamByName('NUMOS').AsInteger := OrdemServico.Id;
  DataSet := ConexaoBanco.DataSetFactory.GetDataSet(TConexao.Empresa, ConexaoBanco.Sql.Text, ConexaoBanco.Param);
  bPulouSinal := False;
  while not DataSet.Eof do
  begin
    if (DataSet.FieldByName('VALORRECEBER').AsFloat = OrdemServico.ValorSinal) and
       (not bPulouSinal) and (OrdemServico.Situacao = 'E') then
    begin
      bPulouSinal := True;
    end
    else
    begin
      If (not DataSet.FieldByName('NUMEROLANCAMENTO').IsNull) then
      begin
        ConexaoBanco.Clear;
        ConexaoBanco.ClearParam;
        ConexaoBanco.Sql.Add('UPDATE CONTAS SET EXCLUIDO = ''S'' WHERE CODIGOEMP = :CODIGOEMP AND NUMEROLANCAMENTO = :NUMEROLANCAMENTO');
        ConexaoBanco.Param.ParamByName('CODIGOEMP').AsInteger := DataBase.CodigoEmpresa;
        ConexaoBanco.Param.ParamByName('NUMEROLANCAMENTO').AsInteger := DataSet.FieldByName('NUMEROLANCAMENTO').AsInteger;
        ConexaoBanco.DataSetFactory.PostDataSet(TConexao.Empresa, ConexaoBanco.Sql.Text, ConexaoBanco.Param);
      end;

      ConexaoBanco.Clear;
      ConexaoBanco.ClearParam;
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
      ConexaoBanco.Param.ParamByName('NUMOS').AsInteger := DataSet.FieldByName('CODIGORECEBER').AsInteger;
      ConexaoBanco.DataSetFactory.PostDataSet(TConexao.Empresa, ConexaoBanco.Sql.Text, ConexaoBanco.Param);
    end;
    DataSet.Next;
  end;
end;

Class Function TOrdemServicoRepository.SomarTotalProdutos(OrdemServico : TOrdemServicoEntity): Double;
begin
  result := 0;
  OrdemServico.cdsItens.First;
  while not OrdemServico.cdsItens.Eof do
  begin
    if OrdemServico.cdsItens.FieldByName('Tipo').AsString = 'P' then
      result := result + OrdemServico.cdsItens.FieldByName('ValorTotal').AsFloat;
    OrdemServico.cdsItens.Next;
  end;

end;

Class Function TOrdemServicoRepository.SomarTotalServicos(OrdemServico : TOrdemServicoEntity): Double;
begin
  result := 0;
  OrdemServico.cdsItens.First;
  while not OrdemServico.cdsItens.Eof do
  begin
    if OrdemServico.cdsItens.FieldByName('Tipo').AsString = 'S' then
      result := result + OrdemServico.cdsItens.FieldByName('ValorTotal').AsFloat;
    OrdemServico.cdsItens.Next;
  end;

end;

Class Procedure TOrdemServicoRepository.LiberarAcessoOS(OrdemServico : TOrdemServicoEntity; DataBase : TDataBase);
Var
  ConexaoBanco : TConexaoBanco;
  DataSet : TDataSet;
Begin
  ConexaoBanco := TConexaoBanco.Create(DataBase);
  ConexaoBanco.SQL.Add('UPDATE OS SET USUARIOBLOQ = '''' WHERE NUMOS = :NUMOS AND CODIGOEMP = :CODIGOEMP');
  ConexaoBanco.Param.ParamByName('NUMOS').AsInteger := OrdemServico.Id;
  ConexaoBanco.Param.ParamByName('CodigoEmp').AsInteger := DataBase.CodigoEmpresa;
  ConexaoBanco.DataSetFactory.PostDataSet(TConexao.Empresa, ConexaoBanco.sql.Text, ConexaoBanco.Param);
End;

Class Function TOrdemServicoRepository.ReciboPagamento(iNumOS : Integer; DataBase : TDataBase):TDataSet;
Var
  ConexaoBanco : TConexaoBanco;
Begin
  ConexaoBanco := TConexaoBanco.Create(DataBase);
//  ConexaoBanco.Sql.Text := 'SELECT OS.NUMOS, CLI.PESSOANOME, ITOS.NUMITEM, ITOS.CODPROD, P.DESCRICPRODUTO, ITOS.QUANTIDADE,';
//  ConexaoBanco.Sql.Add('ITOS.VRUNITARIO, ITOS.VRDESC, ITOS.VRTOTAL, OS.TOTALOS, OS.VRADIANTAMENTO AS SINALOS,');
//  ConexaoBanco.Sql.Add('OS.TOTALOS - OS.VRADIANTAMENTO AS VRFINAL, OS.VRDESCOS, PL.DESCRITIVO, F.DESCRICAO, OS.OBSRECIBO, OS.OBSRECIBO2,');
//  ConexaoBanco.Sql.Add('OS.MODELOSTUDIO, OS.NRENVELOPE, OS.CODVEND || '' - '' || VEND.PESSOANOMEFANTASIA AS VENDEDOR,');
//  ConexaoBanco.Sql.Add('(LPAD(EXTRACT(DAY FROM OS.DATAPREVISAO), 2, ''0'') || ''/'' ||');
//  ConexaoBanco.Sql.Add('LPAD(EXTRACT(MONTH FROM OS.DATAPREVISAO), 2, ''0'') || ''/'' ||');
//  ConexaoBanco.Sql.Add('LPAD(EXTRACT(YEAR FROM OS.DATAPREVISAO), 4, ''0'')) ||');
//  ConexaoBanco.Sql.Add(''' '' || LPAD(EXTRACT(HOUR FROM OS.HORAPREVISAO), 2, ''0'') || '':'' || LPAD(EXTRACT(MINUTE FROM OS.HORAPREVISAO), 2, ''0'')  AS DATAHORAPREVISAO');
//  ConexaoBanco.Sql.Add('FROM OS');
//  ConexaoBanco.Sql.Add('INNER JOIN ITOS ON OS.NUMOS = ITOS.NUMOS AND OS.CODIGOEMP = ITOS.CODIGOEMP');
//  ConexaoBanco.Sql.Add('INNER JOIN PESSOA CLI ON CLI.PESSOACODIGO = OS.CODCLI');
//  ConexaoBanco.Sql.Add('INNER JOIN PESSOA VEND ON VEND.PESSOACODIGO = OS.CODVEND');
//  ConexaoBanco.Sql.Add('INNER JOIN PRODUTOS P ON P.CODIGOPRODUTO = ITOS.CODPROD');
//  ConexaoBanco.Sql.Add('INNER JOIN DGLOB030 PL ON PL.CODIGOFORMA = OS.CODPLANOPAG');
//  ConexaoBanco.Sql.Add('INNER JOIN FORMASPAGAMENTO F ON F.CODIGO = OS.CODFORMAPAG');
//  ConexaoBanco.Sql.Add('WHERE OS.NUMOS = :NUMOS AND OS.CODIGOEMP = :CODIGOEMP');

  ConexaoBanco.Sql.Text := 'SELECT OS.NUMOS, CLI.PESSOANOME, ITOS.NUMITEM, ITOS.CODPROD, P.DESCRICPRODUTO, ITOS.QUANTIDADE,';
  ConexaoBanco.Sql.Add('ITOS.VRUNITARIO, ITOS.VRDESC + OS.VRDESCOS AS VRDESCOS, ITOS.VRDESC, (ITOS.VRUNITARIO * ITOS.QUANTIDADE) AS VRTOTAL, OS.TOTALOS, OS.VRADIANTAMENTO AS SINALOS,');
  ConexaoBanco.Sql.Add('OS.TOTALOS - OS.VRADIANTAMENTO AS VRFINAL, PL.DESCRITIVO, F.DESCRICAO, OS.OBSRECIBO, OS.OBSRECIBO2,');
  ConexaoBanco.Sql.Add('OS.MODELOSTUDIO, OS.NRENVELOPE, OS.CODVEND || '' - '' || VEND.PESSOANOMEFANTASIA AS VENDEDOR,');
  ConexaoBanco.Sql.Add('(LPAD(EXTRACT(DAY FROM OS.DATAPREVISAO), 2, ''0'') || ''/'' ||');
  ConexaoBanco.Sql.Add('LPAD(EXTRACT(MONTH FROM OS.DATAPREVISAO), 2, ''0'') || ''/'' ||');
  ConexaoBanco.Sql.Add('LPAD(EXTRACT(YEAR FROM OS.DATAPREVISAO), 4, ''0'')) ||');
  ConexaoBanco.Sql.Add(''' '' || LPAD(EXTRACT(HOUR FROM OS.HORAPREVISAO), 2, ''0'') || '':'' || LPAD(EXTRACT(MINUTE FROM OS.HORAPREVISAO), 2, ''0'')  AS DATAHORAPREVISAO');
  ConexaoBanco.Sql.Add('FROM OS');
  ConexaoBanco.Sql.Add('INNER JOIN ITOS ON OS.NUMOS = ITOS.NUMOS AND OS.CODIGOEMP = ITOS.CODIGOEMP');
  ConexaoBanco.Sql.Add('INNER JOIN PESSOA CLI ON CLI.PESSOACODIGO = OS.CODCLI');
  ConexaoBanco.Sql.Add('INNER JOIN PESSOA VEND ON VEND.PESSOACODIGO = OS.CODVEND');
  ConexaoBanco.Sql.Add('INNER JOIN PRODUTOS P ON P.CODIGOPRODUTO = ITOS.CODPROD');
  ConexaoBanco.Sql.Add('INNER JOIN DGLOB030 PL ON PL.CODIGOFORMA = OS.CODPLANOPAG');
  ConexaoBanco.Sql.Add('INNER JOIN FORMASPAGAMENTO F ON F.CODIGO = OS.CODFORMAPAG');
  ConexaoBanco.Sql.Add('WHERE OS.NUMOS = :NUMOS AND OS.CODIGOEMP = :CODIGOEMP');

  ConexaoBanco.Param.ParamByName('NUMOS').AsInteger := iNumOS;
  ConexaoBanco.Param.ParamByName('CodigoEmp').AsInteger := DataBase.CodigoEmpresa;

  Result := ConexaoBanco.DataSetFactory.GetDataSet(TConexao.Empresa, ConexaoBanco.Sql.Text, ConexaoBanco.Param);
End;

Class Function TOrdemServicoRepository.EnvelopeLaranja(iNumOS : Integer; DataBase : TDataBase):TDataSet;
Var
  ConexaoBanco : TConexaoBanco;
Begin
  ConexaoBanco := TConexaoBanco.Create(DataBase);
  ConexaoBanco.Sql.Text := 'SELECT CLI.PESSOANOME AS CLIENTE, CLI.PESSOAENDERECO || CLI.PESSOANUMERO AS ENDERECO,';
  ConexaoBanco.Sql.Add('B.DESCRICAO AS BAIRRO, CLI.PESSOATELEFONE, CLI.PESSOACEP, CLI.PESSOAEMAIL,');
  ConexaoBanco.Sql.Add('CAST(OS.DATADIGITA AS DATE) AS DATADIGITA, CAST(OS.HORADIGITA AS TIME) AS HORADIGITA,');
  ConexaoBanco.Sql.Add('CAST(OS.DATAPREVISAO AS DATE) AS DATAPREVISAO, CAST(OS.HORAPREVISAO AS TIME) AS HORAPREVISAO,');
  ConexaoBanco.Sql.Add('OS.VRADIANTAMENTO, VEND.PESSOANOMEFANTASIA AS VENDEDOR, OS.VRADIANTAMENTO,');
  ConexaoBanco.Sql.Add('(OS.TOTALPRODUTOS+OS.TOTALSERVICOS) AS SUBTOTAL, OS.TOTALOS, (OS.TOTALOS - OS.VRADIANTAMENTO) AS VRAPAGAR,');
  ConexaoBanco.Sql.Add('ITOS.CODPROD, P.DESCORCAMENTO, ITOS.QUANTIDADE, (ITOS.VRTOTAL - COALESCE(ITOS.DESCOS,0)) / ITOS.QUANTIDADE AS VRUNITARIO, ITOS.VRTOTAL - COALESCE(ITOS.DESCOS,0) AS VRTOTAL, OS.OBS');
  ConexaoBanco.Sql.Add('FROM OS');
  ConexaoBanco.Sql.Add('INNER JOIN ITOS ON OS.NUMOS = ITOS.NUMOS AND OS.CODIGOEMP = ITOS.CODIGOEMP');
  ConexaoBanco.Sql.Add('INNER JOIN PESSOA CLI ON CLI.PESSOACODIGO = OS.CODCLI');
  ConexaoBanco.Sql.Add('INNER JOIN PESSOA VEND ON VEND.PESSOACODIGO = OS.CODVEND');
  ConexaoBanco.Sql.Add('INNER JOIN BAIRROS B ON B.CODIGO = CLI.PESSOABAIRRO');
  ConexaoBanco.Sql.Add('INNER JOIN PRODUTOS P ON P.CODIGOPRODUTO = ITOS.CODPROD');
  ConexaoBanco.Sql.Add('INNER JOIN DGLOB030 PL ON PL.CODIGOFORMA = OS.CODPLANOPAG');
  ConexaoBanco.Sql.Add('INNER JOIN FORMASPAGAMENTO F ON F.CODIGO = OS.CODFORMAPAG');
  ConexaoBanco.Sql.Add('WHERE OS.NUMOS = :NUMOS AND OS.CODIGOEMP = :CODIGOEMP');

  ConexaoBanco.Param.ParamByName('NUMOS').AsInteger := iNumOS;
  ConexaoBanco.Param.ParamByName('CodigoEmp').AsInteger := DataBase.CodigoEmpresa;

  Result := ConexaoBanco.DataSetFactory.GetDataSet(TConexao.Empresa, ConexaoBanco.Sql.Text, ConexaoBanco.Param);
End;

Class Function TOrdemServicoRepository.EnvelopeAzul(iNumOS : Integer; DataBase : TDataBase):TDataSet;
Var
  ConexaoBanco : TConexaoBanco;
Begin
  ConexaoBanco := TConexaoBanco.Create(DataBase);
  ConexaoBanco.Sql.Text := 'SELECT CLI.PESSOACODIGO AS CODIGOCLIENTE, CLI.PESSOANOME AS CLIENTE, OS.MODELOSTUDIO AS MODELO, ';
  ConexaoBanco.Sql.Add('OS.DATADIGITA,FOT.PESSOANOME AS FOTOGRAFO, OS.OBS, OS.NRENVELOPE,');
  ConexaoBanco.Sql.Add('CAST(DATAPREVISAO AS DATE) AS DATAPREVISAO, OS.VRADIANTAMENTO,');
  ConexaoBanco.Sql.Add('(OS.TOTALPRODUTOS+OS.TOTALSERVICOS) AS SUBTOTAL, OS.TOTALOS, (OS.TOTALOS - OS.VRADIANTAMENTO) AS VRAPAGAR,');
  ConexaoBanco.Sql.Add('ITOS.CODPROD, P.DESCORCAMENTO, ITOS.QUANTIDADE, (ITOS.VRTOTAL - COALESCE(ITOS.DESCOS,0)) / ITOS.QUANTIDADE AS VRUNITARIO, ITOS.VRTOTAL - COALESCE(ITOS.DESCOS,0) AS VRTOTAL');
  ConexaoBanco.Sql.Add('FROM OS');
  ConexaoBanco.Sql.Add('INNER JOIN ITOS ON OS.NUMOS = ITOS.NUMOS AND OS.CODIGOEMP = ITOS.CODIGOEMP');
  ConexaoBanco.Sql.Add('INNER JOIN PESSOA CLI ON CLI.PESSOACODIGO = OS.CODCLI');
  ConexaoBanco.Sql.Add('INNER JOIN PESSOA FOT ON FOT.PESSOACODIGO = OS.CODFOTOGRAFO');
  ConexaoBanco.Sql.Add('INNER JOIN PRODUTOS P ON P.CODIGOPRODUTO = ITOS.CODPROD');
  ConexaoBanco.Sql.Add('INNER JOIN DGLOB030 PL ON PL.CODIGOFORMA = OS.CODPLANOPAG');
  ConexaoBanco.Sql.Add('INNER JOIN FORMASPAGAMENTO F ON F.CODIGO = OS.CODFORMAPAG');
  ConexaoBanco.Sql.Add('WHERE OS.NUMOS = :NUMOS AND OS.CODIGOEMP = :CODIGOEMP');

  ConexaoBanco.Param.ParamByName('NUMOS').AsInteger := iNumOS;
  ConexaoBanco.Param.ParamByName('CodigoEmp').AsInteger := DataBase.CodigoEmpresa;

  Result := ConexaoBanco.DataSetFactory.GetDataSet(TConexao.Empresa, ConexaoBanco.Sql.Text, ConexaoBanco.Param);
End;

Class Procedure TOrdemServicoRepository.GerarComissao(bSinal : Boolean; OrdemServico : TOrdemServicoEntity; CtReceber : TCtReceber; DataBase : TDataBase);
Var
  ConexaoBanco : TConexaoBanco;
  dValorComissao, dValorComissaoI, dSomatorioParc, dValorParcela, dPercComissao : Double;
begin
//  if (OrdemServico.Alteracao) And (OrdemServico.Situacao = 'E') then
//    EstornarComissao(False, OrdemServico, DataBase); COmentei pois coloquei pra estornar antes de chamar esta função, pois agora será chamada duas vezes, uma para o sinal e outra para o restante
  if (bSinal) or (OrdemServico.PedidoRapido) then
    dPercComissao := ConsultaComissaoFunc(OrdemServico.VendedorId, DataBase)
  else
    dPercComissao := ConsultaComissaoFunc(OrdemServico.VendedorLibId, DataBase);

  ConexaoBanco := TConexaoBanco.Create(DataBase);
  ConexaoBanco.SQl.Add('INSERT INTO COMISSOES');
  ConexaoBanco.SQl.Add('(CODSEQ,CODIGOEMP,DTEMISSAO,CODVENDEDOR,TIPO,NUMOS,');
  ConexaoBanco.SQl.Add('DTVENCIMENTO,VRCOMISBRUTO,VRCOMISLIQ,VRDOCORIGINAL,');
  ConexaoBanco.SQl.Add('VRDOCFINAL,SITUACAO,NPARCELA,NTOTPARCELA,VRPARCELA,');
  ConexaoBanco.SQl.Add('CODPLANO,CODFORMA,LOTE,ESTORNO,NUMITOS, SINALOS)');
  ConexaoBanco.SQl.Add('VALUES');
  ConexaoBanco.SQl.Add('(:CODSEQ,:CODIGOEMP,:DTEMISSAO,:CODVENDEDOR,:TIPO,:NUMOS,');
  ConexaoBanco.SQl.Add(':DTVENCIMENTO,:VRCOMISBRUTO,:VRCOMISLIQ,:VRDOCORIGINAL,');
  ConexaoBanco.SQl.Add(':VRDOCFINAL,:SITUACAO,:NPARCELA,:NTOTPARCELA,:VRPARCELA,');
  ConexaoBanco.SQl.Add(':CODPLANO,:CODFORMA,:LOTE,:ESTORNO,:NUMITOS,:SINALOS)');

  if TParametros.VerificaParametros('TIPOCOMISSAO','V',DataBase) = 'P' Then
  begin
    CtReceber.cdsCtRec.First;
    dValorComissaoI := 0;
    dSomatorioParc := 0;
    while not CtReceber.cdsCtRec.Eof do
    begin
//      if (OrdemServico.Situacao = 'E') and (CtReceber.cdsCtRec.FieldByName('Sinal').AsString = 'S') then
//      begin
//        CtReceber.cdsCtRec.Next;
//        Continue;
//      end;

      ConexaoBanco.Param.ParamByName('CODSEQ').AsInteger         := AutoIncrementoComissoes(DataBase);
      ConexaoBanco.Param.ParamByName('CODIGOEMP').AsInteger      := DataBase.CodigoEmpresa;
      ConexaoBanco.Param.ParamByName('DTEMISSAO').AsDateTime     := Date; //OrdemServico.DataEmissao;

      ConexaoBanco.Param.ParamByName('TIPO').AsString            := 'OS';
      ConexaoBanco.Param.ParamByName('NUMOS').AsInteger          := OrdemServico.Id;
      ConexaoBanco.Param.ParamByName('DTVENCIMENTO').AsDateTime  := CtReceber.cdsCtRec.FieldByName('DataVencimento').AsDateTime;

      if (CtReceber.cdsCtRec.FieldByName('Sinal').AsString = 'S') and (not OrdemServico.PedidoRapido) then
      begin
        dValorComissaoI := RoundTo(OrdemServico.ValorSinal * dPercComissao / 100, -2);
      end
      else if (OrdemServico.Situacao = 'E') or (OrdemServico.PedidoRapido) then
      Begin
        dValorComissaoI := RoundTo((OrdemServico.ValorTotal - OrdemServico.ValorSinal)
                                   * dPercComissao / 100, -2);
      End;

      if CtReceber.cdsCtRec.RecNo = CtReceber.cdsCtRec.RecordCount then
        dValorComissao := dValorComissaoI - dSomatorioParc
      else
      begin
        dValorComissao := RoundTo(CtReceber.cdsCtRec.FieldByName('ValorDocumento').AsFloat * dPercComissao / 100, -2);
        dSomatorioParc := dSomatorioParc + dValorComissao;
      end;
      if (CtReceber.cdsCtRec.FieldByName('Sinal').AsString = 'S') and (not OrdemServico.PedidoRapido) then
      begin
        ConexaoBanco.Param.ParamByName('SINALOS').AsString        := 'S';
        ConexaoBanco.Param.ParamByName('CODVENDEDOR').AsInteger    := OrdemServico.VendedorId;
      end
      else if (OrdemServico.Situacao = 'E') or (OrdemServico.PedidoRapido) then
      begin
        ConexaoBanco.Param.ParamByName('SINALOS').AsString        := 'N';
        if OrdemServico.PedidoRapido then
          ConexaoBanco.Param.ParamByName('CODVENDEDOR').AsInteger  := OrdemServico.VendedorId
        else
          ConexaoBanco.Param.ParamByName('CODVENDEDOR').AsInteger  := OrdemServico.VendedorLibId;
      end;

      ConexaoBanco.Param.ParamByName('VRCOMISBRUTO').AsFloat     := dValorComissao;
      ConexaoBanco.Param.ParamByName('VRCOMISLIQ').AsFloat       := dValorComissao;
      ConexaoBanco.Param.ParamByName('VRDOCORIGINAL').AsFloat    := CtReceber.cdsCtRec.FieldByName('ValorDocumento').AsFloat;
      ConexaoBanco.Param.ParamByName('VRDOCFINAL').AsFloat       := CtReceber.cdsCtRec.FieldByName('ValorDocumento').AsFloat;
      ConexaoBanco.Param.ParamByName('SITUACAO').AsString        := 'N'; {Indica se já gerou contas a Pagar}
      ConexaoBanco.Param.ParamByName('NPARCELA').AsInteger       := 1;
      ConexaoBanco.Param.ParamByName('NTOTPARCELA').AsInteger    := 1;
      ConexaoBanco.Param.ParamByName('VRPARCELA').AsFloat        := CtReceber.cdsCtRec.FieldByName('ValorDocumento').AsFloat;
      ConexaoBanco.Param.ParamByName('CODPLANO').AsInteger       := OrdemServico.PlanoPagtoId;
      ConexaoBanco.Param.ParamByName('CODFORMA').AsInteger       := OrdemServico.FormaPagtoId;
      ConexaoBanco.Param.ParamByName('LOTE').AsString            := 'N'; {Indica se já gerou Lote}
      ConexaoBanco.Param.ParamByName('ESTORNO').AsString         := 'N';
      ConexaoBanco.Param.ParamByName('NUMITOS').AsInteger        := 0;

      ConexaoBanco.DataSetFactory.PostDataSet(TConexao.Empresa, ConexaoBanco.sql.Text , ConexaoBanco.Param);
      CtReceber.cdsCtRec.Next;
    end;
  end
  else
  begin
    ConexaoBanco.Param.ParamByName('CODSEQ').AsInteger         := AutoIncrementoComissoes(DataBase);
    ConexaoBanco.Param.ParamByName('CODIGOEMP').AsInteger      := DataBase.CodigoEmpresa;
    ConexaoBanco.Param.ParamByName('DTEMISSAO').AsDateTime     := Date; //OrdemServico.DataEmissao;

    ConexaoBanco.Param.ParamByName('TIPO').AsString            := 'OS';
    ConexaoBanco.Param.ParamByName('NUMOS').AsInteger          := OrdemServico.Id;
    ConexaoBanco.Param.ParamByName('DTVENCIMENTO').AsDateTime  := Date; //CtReceber.cdsCtRec.FieldByName('DataVencimento').AsDateTime; //Wagner do Luis Fotografo disse que por enquanto a comissão é gerada com a data da entrega da O.S.


    if (bSinal) then
    begin
      dValorComissao := RoundTo(OrdemServico.ValorSinal * dPercComissao / 100, -2);
      dValorParcela := OrdemServico.ValorSinal;
      ConexaoBanco.Param.ParamByName('SINALOS').AsString        := 'S';
      ConexaoBanco.Param.ParamByName('CODVENDEDOR').AsInteger    := OrdemServico.VendedorId;
    end
    else
    Begin
      dValorComissao := RoundTo((OrdemServico.ValorTotal - OrdemServico.ValorSinal)
                                 * dPercComissao / 100, -2);
      dValorParcela := OrdemServico.ValorTotal - OrdemServico.ValorSinal;
      ConexaoBanco.Param.ParamByName('SINALOS').AsString        := 'N';
      if OrdemServico.PedidoRapido then
        ConexaoBanco.Param.ParamByName('CODVENDEDOR').AsInteger  := OrdemServico.VendedorId
      else
        ConexaoBanco.Param.ParamByName('CODVENDEDOR').AsInteger  := OrdemServico.VendedorLibId;
    End;
    ConexaoBanco.Param.ParamByName('VRCOMISBRUTO').AsFloat     := dValorComissao;
    ConexaoBanco.Param.ParamByName('VRCOMISLIQ').AsFloat       := dValorComissao;
    ConexaoBanco.Param.ParamByName('VRDOCORIGINAL').AsFloat    := OrdemServico.ValorTotal;
    ConexaoBanco.Param.ParamByName('VRDOCFINAL').AsFloat       := OrdemServico.ValorTotal;
    ConexaoBanco.Param.ParamByName('SITUACAO').AsString        := 'N'; {Indica se já gerou contas a Pagar}
    ConexaoBanco.Param.ParamByName('NPARCELA').AsInteger       := 1;
    ConexaoBanco.Param.ParamByName('NTOTPARCELA').AsInteger    := 1;
    ConexaoBanco.Param.ParamByName('VRPARCELA').AsFloat        := dValorParcela;
    ConexaoBanco.Param.ParamByName('CODPLANO').AsInteger       := OrdemServico.PlanoPagtoId;
    ConexaoBanco.Param.ParamByName('CODFORMA').AsInteger       := OrdemServico.FormaPagtoId;
    ConexaoBanco.Param.ParamByName('LOTE').AsString            := 'N'; {Indica se já gerou Lote}
    ConexaoBanco.Param.ParamByName('ESTORNO').AsString         := 'N';
    ConexaoBanco.Param.ParamByName('NUMITOS').AsInteger        := 0;

    ConexaoBanco.DataSetFactory.PostDataSet(TConexao.Empresa, ConexaoBanco.sql.Text , ConexaoBanco.Param);
  end;
end;

Class Function TOrdemServicoRepository.AutoIncrementoComissoes(DataBase : TDataBase):Integer;
Var
  ConexaoBanco : TConexaoBanco;
Begin
  Result := 0;
  ConexaoBanco := TConexaoBanco.Create(DataBase);
  try
    ConexaoBanco.SQL.Add('SELECT                                     ');
    ConexaoBanco.SQL.Add('COALESCE(MAX(CODSEQ),0) + 1 AS ID          ');
    ConexaoBanco.SQL.Add('FROM COMISSOES                             ');

    Result := ConexaoBanco.DataSetFactory.GetDataSet(TConexao.Empresa, ConexaoBanco.Sql.Text, ConexaoBanco.Param).FieldByName('Id').AsInteger;
  Except
    On E : Exception do
    Begin
      TCustomExcept.Show(e, 'Erro ao tentar executar AutoIncremento');
    End;
  End;
End;

Class Procedure TOrdemServicoRepository.EstornarComissao(bCancelouOS : Boolean; OrdemServico : TOrdemServicoEntity; DataBase : TDataBase);
Var
  ConexaoBanco : TConexaoBanco;
  DataSet : TDataSet;
begin
  ConexaoBanco := TConexaoBanco.Create(DataBase);
  ConexaoBanco.Sql.Add('SELECT * FROM COMISSOES WHERE ');
  ConexaoBanco.Sql.Add('NUMOS = :NUMOS AND ESTORNO<>''S'' AND NUMITOS = 0');
  ConexaoBanco.Sql.Add('AND CODIGOEMP= :CODIGOEMP');
//  if not bCancelouOS then
//  begin
//    if (OrdemServico.Situacao = 'A') and (not OrdemServico.PedidoRapido) then
//      ConexaoBanco.Sql.Add('AND SINALOS = ''S''')
//    else if OrdemServico.Situacao = 'E' then
//      ConexaoBanco.Sql.Add('AND SINALOS <> ''S''');
//  end;
  ConexaoBanco.Param.ParamByName('NUMOS').AsInteger := OrdemServico.ID;
  ConexaoBanco.Param.ParamByName('CODIGOEMP').AsInteger := DataBase.CodigoEmpresa;
  DataSet := ConexaoBanco.DataSetFactory.GetDataSet(TConexao.Empresa, ConexaoBanco.Sql.Text, ConexaoBanco.Param);

  ConexaoBanco.Sql.Clear;
  ConexaoBanco.SQl.Add('INSERT INTO COMISSOES');
  ConexaoBanco.SQl.Add('(CODSEQ,CODIGOEMP,DTEMISSAO,CODVENDEDOR,TIPO,NUMOS,');
  ConexaoBanco.SQl.Add('DTVENCIMENTO,VRCOMISBRUTO,VRCOMISLIQ,VRDOCORIGINAL,');
  ConexaoBanco.SQl.Add('VRDOCFINAL,SITUACAO,NPARCELA,NTOTPARCELA,VRPARCELA,');
  ConexaoBanco.SQl.Add('CODPLANO,CODFORMA,LOTE,ESTORNO,NUMITOS,SINALOS)');
  ConexaoBanco.SQl.Add('VALUES');
  ConexaoBanco.SQl.Add('(:CODSEQ,:CODIGOEMP,:DTEMISSAO,:CODVENDEDOR,:TIPO,:NUMOS,');
  ConexaoBanco.Sql.Add(':DTVENCIMENTO,:VRCOMISBRUTO,:VRCOMISLIQ,:VRDOCORIGINAL,');
  ConexaoBanco.SQl.Add(':VRDOCFINAL,:SITUACAO,:NPARCELA,:NTOTPARCELA,:VRPARCELA,');
  ConexaoBanco.SQl.Add(':CODPLANO,:CODFORMA,:LOTE,:ESTORNO,:NUMITOS,:SINALOS)');


  While not DataSet.Eof do
  begin
    ConexaoBanco.Param.ParamByName('CODSEQ').AsInteger         := AutoIncrementoComissoes(DataBase);
    ConexaoBanco.Param.ParamByName('CODIGOEMP').AsInteger      := DataBase.CodigoEmpresa;
    ConexaoBanco.Param.ParamByName('DTEMISSAO').AsDateTime     := Date;
    ConexaoBanco.Param.ParamByName('CODVENDEDOR').AsInteger    := DataSet.FieldByName('CODVENDEDOR').AsInteger;
    ConexaoBanco.Param.ParamByName('TIPO').AsString            := DataSet.FieldByName('TIPO').AsString;
    ConexaoBanco.Param.ParamByName('NUMOS').AsInteger          := DataSet.FieldByName('NUMOS').AsInteger;
    ConexaoBanco.Param.ParamByName('DTVENCIMENTO').AsDateTime  := DataSet.FieldByName('DTVENCIMENTO').AsDateTime;
    ConexaoBanco.Param.ParamByName('VRCOMISBRUTO').AsFloat     := DataSet.FieldByName('VRCOMISBRUTO').AsFloat * (-1);
    ConexaoBanco.Param.ParamByName('VRCOMISLIQ').AsFloat       := DataSet.FieldByName('VRCOMISLIQ').AsFloat * (-1);
    ConexaoBanco.Param.ParamByName('VRDOCORIGINAL').AsFloat    := DataSet.FieldByName('VRDOCORIGINAL').AsFloat;
    ConexaoBanco.Param.ParamByName('VRDOCFINAL').AsFloat       := DataSet.FieldByName('VRDOCFINAL').AsFloat;
    ConexaoBanco.Param.ParamByName('VRPARCELA').AsFloat        := DataSet.FieldByName('VRPARCELA').AsFloat * (-1);
    ConexaoBanco.Param.ParamByName('SITUACAO').AsString        := 'N'; {Indica se já gerou contas a Pagar}
    ConexaoBanco.Param.ParamByName('NPARCELA').AsInteger       := DataSet.FieldByName('NPARCELA').AsInteger;
    ConexaoBanco.Param.ParamByName('NTOTPARCELA').AsFloat      := DataSet.FieldByName('NTOTPARCELA').AsFloat;
    ConexaoBanco.Param.ParamByName('CODPLANO').AsInteger       := DataSet.FieldByName('CODPLANO').AsInteger;
    ConexaoBanco.Param.ParamByName('CODFORMA').AsInteger       := DataSet.FieldByName('CODFORMA').AsInteger;
    ConexaoBanco.Param.ParamByName('LOTE').AsString            := 'N'; {Indica se já gerou Lote}
    ConexaoBanco.Param.ParamByName('ESTORNO').AsString         := 'S';
    ConexaoBanco.Param.ParamByName('SINALOS').AsString         := DataSet.FieldByName('SINALOS').AsString;
    ConexaoBanco.Param.ParamByName('NUMITOS').AsInteger        := 0;
    ConexaoBanco.DataSetFactory.PostDataSet(TConexao.Empresa, ConexaoBanco.Sql.Text, ConexaoBanco.Param);
    DataSet.Next;
  end;

  ConexaoBanco.Sql.Clear;
  ConexaoBanco.SQl.Add('UPDATE COMISSOES SET ESTORNO = ''S'' WHERE');
  ConexaoBanco.Sql.Add('NUMOS=:NUMOS AND ESTORNO <> ''S'' ');
  ConexaoBanco.Sql.Add('AND ((NUMITOS <= 0) OR (NUMITOS IS NULL))');
  ConexaoBanco.Sql.Add('AND CODIGOEMP=:CODIGOEMP');
//  if not bCancelouOS then
//  begin
//    if OrdemServico.Situacao = 'A' then
//      ConexaoBanco.Sql.Add('AND SINALOS = ''S''')
//    else if OrdemServico.Situacao = 'E' then
//      ConexaoBanco.Sql.Add('AND SINALOS <> ''S''');
//  end;
  ConexaoBanco.Param.ParamByName('NUMOS').AsInteger := OrdemServico.ID;
  ConexaoBanco.Param.ParamByName('CODIGOEMP').AsInteger := DataBase.CodigoEmpresa;
  ConexaoBanco.DataSetFactory.PostDataSet(TConexao.Empresa, ConexaoBanco.Sql.Text, ConexaoBanco.Param);
end;

Class Function TOrdemServicoRepository.Cancelar(OrdemServico : TOrdemServicoEntity; CtReceber : TCtReceber; DataBase : TDataBase):Boolean;
Var
  ConexaoBanco : TConexaoBanco;
begin
  ConexaoBanco := TConexaoBanco.Create(DataBase);
  Try
    ConexaoBanco.DataSetFactory.StartTransaction(TConexao.Empresa);
    EstornarEstoque(OrdemServico, DataBase);
    EstornarComissao(True, OrdemServico, DataBase);
    TCtReceberRepository.EstornarTaxaCartao(True, OrdemServico, CtReceber, DataBase);
    TCtReceberRepository.EstornarContasaReceber(True, OrdemServico, DataBase);
    ConexaoBanco.Sql.Add('UPDATE OS SET DTCANCEL = CURRENT_DATE, CANCELADO = ''S'' WHERE NUMOS = :NUMOS AND CODIGOEMP = :CODIGOEMP');
    ConexaoBanco.Param.ParamByName('NUMOS').AsInteger := OrdemServico.Id;
    ConexaoBanco.Param.ParamByName('CODIGOEMP').AsInteger := DataBase.CodigoEmpresa;
    ConexaoBanco.DataSetFactory.PostDataSet(TConexao.Empresa, ConexaoBanco.Sql.Text, ConexaoBanco.Param);
    ConexaoBanco.DataSetFactory.Commit(TConexao.Empresa);
  Except
    ConexaoBanco.DataSetFactory.RollBack(TConexao.Empresa);
  End;
end;

Class Function TOrdemServicoRepository.BuscaNumEnvelopeStudio(DataBase : TDataBase):Integer;
Var
  ConexaoBanco : TConexaoBanco;
  DataSet : TDataSet;
begin
  ConexaoBanco := TConexaoBanco.Create(DataBase);
  ConexaoBanco.Sql.Add('SELECT V_INTEGER + 1 AS NRENVELOPE FROM PARAMETROS WHERE IDENTIFICADOR = ''NRENVELOPESTUDIO'' AND CODIGOEMPRESA = :CODIGOEMP');
  ConexaoBanco.Param.ParamByName('CODIGOEMP').AsInteger := DataBase.CodigoEmpresa;
  DataSet := ConexaoBanco.DataSetFactory.GetDataSet(TConexao.BaseDados, ConexaoBanco.Sql.Text, ConexaoBanco.Param);
  if not DataSet.Eof then
    result := DataSet.FieldByName('NRENVELOPE').AsInteger
  else
    result := 1;
end;

Class Procedure TOrdemServicoRepository.GravaNumEnvelopeStudio(OrdemServico : TOrdemServicoEntity; DataBase : TDataBase);
Var
  ConexaoBanco : TConexaoBanco;
begin
  ConexaoBanco := TConexaoBanco.Create(DataBase);
  ConexaoBanco.Sql.Add('UPDATE PARAMETROS SET V_INTEGER = :NUMERO WHERE IDENTIFICADOR = ''NRENVELOPESTUDIO'' AND CODIGOEMPRESA = :CODIGOEMP');
  ConexaoBanco.Param.ParamByName('NUMERO').AsInteger := OrdemServico.Envelope;
  ConexaoBanco.Param.ParamByName('CODIGOEMP').AsInteger := DataBase.CodigoEmpresa;
  ConexaoBanco.DataSetFactory.PostDataSet(TConexao.BaseDados, ConexaoBanco.Sql.Text, ConexaoBanco.Param);

end;

Class Function TOrdemServicoRepository.ConsultaComissaoFunc(iCodigo : Integer; DataBase : TDataBase):Double;
Var
  ConexaoBanco : TConexaoBanco;
  DataSet : TDataSet;
begin
  ConexaoBanco := TConexaoBanco.Create(DataBase);
  ConexaoBanco.Sql.Add('SELECT PessoaComissaoFunc FROM PESSOA_EMP WHERE PESSOACODIGO = :PESSOACODIGO AND CODIGOEMP = :CODIGOEMP');
  ConexaoBanco.Param.ParamByName('PESSOACODIGO').AsInteger := iCodigo;
  ConexaoBanco.Param.ParamByName('CODIGOEMP').AsInteger := DataBase.CodigoEmpresa;
  DataSet := ConexaoBanco.DataSetFactory.GetDataSet(TConexao.Empresa, ConexaoBanco.Sql.Text, ConexaoBanco.Param);
  result := DataSet.FieldByName('PessoaComissaoFunc').AsFloat;
end;

Class Function TOrdemServicoRepository.VerificaFormaEnviaMaisCaixa(iCodigo : Integer; DataBase : TDataBase):Boolean;
Var
  ConexaoBanco : TConexaoBanco;
  DataSet : TDataSet;
begin
  ConexaoBanco := TConexaoBanco.Create(DataBase);
  ConexaoBanco.Sql.Add('SELECT MAISCAIXA FROM FORMASPAGAMENTO WHERE CODIGO = :CODIGO');
  ConexaoBanco.Param.ParamByName('CODIGO').AsInteger := iCodigo;
  DataSet := ConexaoBanco.DataSetFactory.GetDataSet(TConexao.Empresa, ConexaoBanco.Sql.Text, ConexaoBanco.Param);
  result := DataSet.FieldByName('MAISCAIXA').AsString = 'S';
end;





end.

