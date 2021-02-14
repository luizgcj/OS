unit CadOrdemServico;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, dxBarBuiltInMenu, cxContainer, cxEdit, cxLabel,
  Vcl.ExtCtrls, cxPC, cxTextEdit, cxCurrencyEdit, Vcl.ComCtrls, dxCore,
  cxDateUtils, cxMaskEdit, cxDropDownEdit, cxCalendar, cxStyles, cxCustomData,
  cxFilter, cxData, cxDataStorage, cxNavigator,
  cxDataControllerConditionalFormattingRulesManagerDialog, Data.DB, cxDBData,
  cxGridLevel, cxClasses, cxGridCustomView, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxGrid, DataBase, Vcl.Buttons,
  Vcl.StdCtrls,
  OrdemServicoEntity, Pessoa, PessoaService, EnumPessoaTipo, Setor, SetorService, System.Bindings.Helper,
  Produto, ProdutoService, CustomMessage, Mascara, EnumSituacaoOrdemServico,
  Usuario, UsuarioService, OrdemServicoService, PlanoPagamento, PlanoPagamentoService, FormaPagamento, FormaPagamentoService,
  CtReceber, CtReceberService, InformacoesCartao,
  Vcl.Menus, dxSkinsCore, dxSkinBlack, dxSkinBlue, dxSkinBlueprint,
  dxSkinCaramel, dxSkinCoffee, dxSkinDarkRoom, dxSkinDarkSide,
  dxSkinDevExpressDarkStyle, dxSkinDevExpressStyle, dxSkinFoggy,
  dxSkinGlassOceans, dxSkinHighContrast, dxSkiniMaginary, dxSkinLilian,
  dxSkinLiquidSky, dxSkinLondonLiquidSky, dxSkinMcSkin, dxSkinMetropolis,
  dxSkinMetropolisDark, dxSkinMoneyTwins, dxSkinOffice2007Black,
  dxSkinOffice2007Blue, dxSkinOffice2007Green, dxSkinOffice2007Pink,
  dxSkinOffice2007Silver, dxSkinOffice2010Black, dxSkinOffice2010Blue,
  dxSkinOffice2010Silver, dxSkinOffice2013DarkGray, dxSkinOffice2013LightGray,
  dxSkinOffice2013White, dxSkinOffice2016Colorful, dxSkinOffice2016Dark,
  dxSkinPumpkin, dxSkinSeven, dxSkinSevenClassic, dxSkinSharp, dxSkinSharpPlus,
  dxSkinSilver, dxSkinSpringTime, dxSkinStardust, dxSkinSummer2008,
  dxSkinTheAsphaltWorld, dxSkinsDefaultPainters, dxSkinValentine,
  dxSkinVisualStudio2013Blue, dxSkinVisualStudio2013Dark,
  dxSkinVisualStudio2013Light, dxSkinVS2010, dxSkinWhiteprint,
  dxSkinXmas2008Blue, cxSpinEdit, cxTimeEdit, Datasnap.DBClient, Math, Vcl.Mask,
  GetNum, cxCheckBox, ppParameter, ppCtrls, ppDesignLayer, ppReport, ppStrtch,
  ppSubRpt, ppBands, ppVar, ppPrnabl, ppClass, ppCache, ppProd, ppComm,
  ppRelatv, ppDB, ppDBPipe, ppMemo, Bairro, BairroService, dxDateRanges;

type
  TFrCadOrdemServico = class(TForm)
    cxPageControl1: TcxPageControl;
    pnlTitle: TPanel;
    lblTitle: TcxLabel;
    Panel1: TPanel;
    cxNumOS: TcxLabel;
    curId: TcxCurrencyEdit;
    lblCliente: TcxLabel;
    curClienteId: TcxCurrencyEdit;
    edtNomeCliente: TcxTextEdit;
    pnlBotoes: TPanel;
    pnlTotais: TPanel;
    pnlProduto: TPanel;
    lblCPFCNPJ: TcxLabel;
    edtCpfCnpjCliente: TcxTextEdit;
    lblEstado: TcxLabel;
    edtEstadoCliente: TcxTextEdit;
    btnConsultaCliente: TSpeedButton;
    btnGravar: TBitBtn;
    btnDesistir: TBitBtn;
    btnImprimir: TBitBtn;
    btnCancelar: TBitBtn;
    mnItens: TPopupMenu;
    mn_Excluir: TMenuItem;
    mn_Alterar: TMenuItem;
    cxLabel1: TcxLabel;
    curSetorId: TcxCurrencyEdit;
    edtNomeSetor: TcxTextEdit;
    btnConsultaSetor: TSpeedButton;
    pnSituacao: TPanel;
    cxLabel2: TcxLabel;
    cxCbSituacao: TcxComboBox;
    cxLabel3: TcxLabel;
    curVrSinal: TcxCurrencyEdit;
    cxLabel4: TcxLabel;
    curFuncLabId: TcxCurrencyEdit;
    edtFuncLab: TcxTextEdit;
    btnConsultaFuncLab: TSpeedButton;
    cxLabel5: TcxLabel;
    curVendLibId: TcxCurrencyEdit;
    edtVendLib: TcxTextEdit;
    btnConsultaVendLib: TSpeedButton;
    pnFinanceiro: TPanel;
    cxLabel7: TcxLabel;
    lbPlanoPagamento: TcxLabel;
    curFormaPagtoId: TcxCurrencyEdit;
    edtFormaPagto: TcxTextEdit;
    btnConsultaFormaPagto: TSpeedButton;
    edtPlanoPagto: TcxTextEdit;
    btnConsultaPlanoPagamento: TSpeedButton;
    curPlanoPagtoId: TcxCurrencyEdit;
    cxGrFinanceiro: TcxGrid;
    cxGridCtReceber: TcxGridDBTableView;
    cxGridLevel1: TcxGridLevel;
    cxSituacao: TcxLabel;
    btnCalcularFinanc: TBitBtn;
    cxGridCtReceberITEM: TcxGridDBColumn;
    cxGridCtReceberNUMDOCUMENTO: TcxGridDBColumn;
    cxGridCtReceberDIASPARCELA: TcxGridDBColumn;
    cxGridCtReceberVALORDOCUMENTO: TcxGridDBColumn;
    cxGridCtReceberDATAVENCIMENTO: TcxGridDBColumn;
    cxLabel10: TcxLabel;
    curValorReceber: TcxCurrencyEdit;
    cxLabel12: TcxLabel;
    curValorParcelas: TcxCurrencyEdit;
    cxLabel13: TcxLabel;
    curValorDiferenca: TcxCurrencyEdit;
    cxLabel11: TcxLabel;
    curVrSinalCtReceber: TcxCurrencyEdit;
    curParcelas: TcxCurrencyEdit;
    chkPedidoRapido: TcxCheckBox;
    chkOrcamento: TcxCheckBox;
    lblDataEmissao: TcxLabel;
    cxDataEmissao: TcxDateEdit;
    lblDataPrevisao: TcxLabel;
    cxDataPrevisao: TcxDateEdit;
    cxLbEnvelope: TcxLabel;
    cxLabel6: TcxLabel;
    cxHoraEmissao: TcxTimeEdit;
    cxHoraPrevisao: TcxTimeEdit;
    cxLabel8: TcxLabel;
    curEnvelope: TcxCurrencyEdit;
    btnConsultaProduto: TSpeedButton;
    lblProduto: TcxLabel;
    curProdutoId: TcxCurrencyEdit;
    edtProduto: TcxTextEdit;
    lblValorUnitario: TcxLabel;
    curValorUnitario: TcxCurrencyEdit;
    lblQuantidade: TcxLabel;
    curQuantidade: TcxCurrencyEdit;
    curValorTotalItem: TcxCurrencyEdit;
    lblValorTotal: TcxLabel;
    btnGravarItem: TBitBtn;
    cxLabel9: TcxLabel;
    curPercDescItem: TcxCurrencyEdit;
    cxLabel14: TcxLabel;
    curVrDescItem: TcxCurrencyEdit;
    grItens: TcxGrid;
    grItensLvVw: TcxGridDBTableView;
    grItensLvVwProdutoId: TcxGridDBColumn;
    grItensLvVwProduto: TcxGridDBColumn;
    grItensLvVwQuantidade: TcxGridDBColumn;
    grItensLvVwQuantidadeMontante: TcxGridDBColumn;
    grItensLvVwValorUnitario: TcxGridDBColumn;
    grItensLvVwPercDesconto: TcxGridDBColumn;
    grItensLvVwValorDesconto: TcxGridDBColumn;
    grItensLvVwValorTotal: TcxGridDBColumn;
    grItensLv: TcxGridLevel;
    btnConsultaVendedor: TSpeedButton;
    lblValorTotalOS: TcxLabel;
    curValorTotalOS: TcxCurrencyEdit;
    edtNomeVendedor: TcxTextEdit;
    curVendedorId: TcxCurrencyEdit;
    lblVendedo: TcxLabel;
    lblPercDesconto: TcxLabel;
    curPercDesconto: TcxCurrencyEdit;
    lblDesconto: TcxLabel;
    curDesconto: TcxCurrencyEdit;
    cxLabel15: TcxLabel;
    curSubTotal: TcxCurrencyEdit;
    cxLabel16: TcxLabel;
    curDescTotalItens: TcxCurrencyEdit;
    Label1: TLabel;
    memObservacao: TMemo;
    Label2: TLabel;
    curObsRecibo: TcxTextEdit;
    ppDBRecibo: TppDBPipeline;
    ppRecibo: TppReport;
    ppParameterList1: TppParameterList;
    ppDBEnvelopeLaranja: TppDBPipeline;
    ppEnvelopeLaranja: TppReport;
    ppDBEnvelopeAzul: TppDBPipeline;
    ppEnvelopeAzul: TppReport;
    ppParameterList2: TppParameterList;
    ppParameterList3: TppParameterList;
    ppDesignLayers4: TppDesignLayers;
    ppDesignLayer4: TppDesignLayer;
    ppDetailBand3: TppDetailBand;
    ppTitleBand3: TppTitleBand;
    ppDBText26: TppDBText;
    ppDBText27: TppDBText;
    ppDBText28: TppDBText;
    ppDBText29: TppDBText;
    ppDBText30: TppDBText;
    ppDBText31: TppDBText;
    ppDBText32: TppDBText;
    ppDBText33: TppDBText;
    ppDBText34: TppDBText;
    ppDBText35: TppDBText;
    ppDBText36: TppDBText;
    ppDBText37: TppDBText;
    ppDBText38: TppDBText;
    ppDBText25: TppDBText;
    popDesdobramento: TPopupMenu;
    Mn_ExcluirDesdobramento: TMenuItem;
    ppDBText40: TppDBText;
    ppLabel31: TppLabel;
    ppLabel32: TppLabel;
    ppLabel33: TppLabel;
    ppLabel34: TppLabel;
    ppDBText41: TppDBText;
    ppDBText42: TppDBText;
    ppDBText43: TppDBText;
    ppDBText44: TppDBText;
    ppDBText45: TppDBText;
    ppDBText46: TppDBText;
    ppDBText47: TppDBText;
    ppDBText48: TppDBText;
    ppDBText49: TppDBText;
    ppLabel35: TppLabel;
    ppLabel36: TppLabel;
    ppLabel37: TppLabel;
    ppLabel38: TppLabel;
    ppLabel39: TppLabel;
    ppHeaderBand3: TppHeaderBand;
    ppDetailBand4: TppDetailBand;
    ppFooterBand1: TppFooterBand;
    ppDBText50: TppDBText;
    ppDBText51: TppDBText;
    ppDBText52: TppDBText;
    ppDBText53: TppDBText;
    ppDBText54: TppDBText;
    ppDBText55: TppDBText;
    ppDBText57: TppDBText;
    ppDBText58: TppDBText;
    ppDBText59: TppDBText;
    ppDBText60: TppDBText;
    ppDBText61: TppDBText;
    ppDBText62: TppDBText;
    ppDBMemo1: TppDBMemo;
    pnlStudio: TPanel;
    edtModelo: TcxTextEdit;
    cxLabel17: TcxLabel;
    cxLabel18: TcxLabel;
    curFotografoId: TcxCurrencyEdit;
    edtFotografo: TcxTextEdit;
    btnConsFotografo: TSpeedButton;
    ppSummaryBand3: TppSummaryBand;
    ppDBMemo2: TppDBMemo;
    ppLabel40: TppLabel;
    ppDBText64: TppDBText;
    ppDBText65: TppDBText;
    cxGridCtReceberSINAL: TcxGridDBColumn;
    ppDBText39: TppDBText;
    ppTitleBand1: TppTitleBand;
    ppLabel1: TppLabel;
    ppDBText1: TppDBText;
    ppLabel2: TppLabel;
    ppLabel3: TppLabel;
    ppSystemVariable1: TppSystemVariable;
    lbOrdemServico: TppLabel;
    ppDBText8: TppDBText;
    ppModelo: TppLabel;
    ppDBModelo: TppDBText;
    ppDataHoraPrevisao: TppLabel;
    ppDBDataHoraPrevisao: TppDBText;
    ppHeaderBand1: TppHeaderBand;
    ppLabel4: TppLabel;
    ppLabel5: TppLabel;
    ppLabel6: TppLabel;
    ppLabel7: TppLabel;
    ppLabel9: TppLabel;
    ppDetailBand1: TppDetailBand;
    ppDBText2: TppDBText;
    ppDBText3: TppDBText;
    ppDBText4: TppDBText;
    ppDBText5: TppDBText;
    ppDBText7: TppDBText;
    ppSummaryBand1: TppSummaryBand;
    ppLabel10: TppLabel;
    ppDBCalc1: TppDBCalc;
    ppDBCalc2: TppDBCalc;
    ppLabel12: TppLabel;
    ppLabel13: TppLabel;
    ppDBText10: TppDBText;
    ppDBText11: TppDBText;
    ppLabel14: TppLabel;
    ppDBText12: TppDBText;
    ppLabel15: TppLabel;
    ppDBText13: TppDBText;
    ppLine1: TppLine;
    ppLabel44: TppLabel;
    ppDBText69: TppDBText;
    ppLbVrSinal1: TppLabel;
    ppDBSinal1: TppDBText;
    ppLbVrFinal1: TppLabel;
    ppDBVrFinal1: TppDBText;
    ppLabel47: TppLabel;
    ppDBText72: TppDBText;
    ppLabel48: TppLabel;
    ppDBText73: TppDBText;
    ppDesignLayers1: TppDesignLayers;
    ppDesignLayer1: TppDesignLayer;
    ppLabel8: TppLabel;
    ppDBText6: TppDBText;
    ppLabel11: TppLabel;
    ppLabel16: TppLabel;
    ppSystemVariable2: TppSystemVariable;
    ppLabel17: TppLabel;
    ppDBText9: TppDBText;
    ppModelo2: TppLabel;
    ppDBModelo2: TppDBText;
    ppDataHoraPrevisao2: TppLabel;
    ppDBDataHoraPrevisao2: TppDBText;
    ppLabel20: TppLabel;
    ppLabel21: TppLabel;
    ppLabel22: TppLabel;
    ppLabel23: TppLabel;
    ppLabel24: TppLabel;
    ppDBText16: TppDBText;
    ppDBText17: TppDBText;
    ppDBText18: TppDBText;
    ppDBText19: TppDBText;
    ppDBText20: TppDBText;
    ppLabel25: TppLabel;
    ppDBCalc3: TppDBCalc;
    ppDBCalc4: TppDBCalc;
    ppLabel26: TppLabel;
    ppLabel27: TppLabel;
    ppDBText21: TppDBText;
    ppDBText22: TppDBText;
    ppLabel28: TppLabel;
    ppDBText23: TppDBText;
    ppLabel29: TppLabel;
    ppDBText24: TppDBText;
    ppLabel30: TppLabel;
    ppDBText56: TppDBText;
    ppLbVrSinal2: TppLabel;
    ppDBSinal2: TppDBText;
    ppLbVrFinal2: TppLabel;
    ppDBVrFinal2: TppDBText;
    ppLabel43: TppLabel;
    ppDBText67: TppDBText;
    ppLabel49: TppLabel;
    ppDBText68: TppDBText;
    curObsRecibo2: TcxTextEdit;
    btnImpEnvelope: TBitBtn;
    ppDBMemo3: TppDBMemo;
    ppDBMemo4: TppDBMemo;
    ppLbCodigos: TppLabel;
    ppLabel18: TppLabel;
    ppLabel19: TppLabel;
    ppLabel41: TppLabel;
    ppLabel42: TppLabel;
    ppDBText14: TppDBText;
    ppDBText15: TppDBText;
    ppDBText63: TppDBText;
    ppDBText66: TppDBText;
    btnCadastroCliente: TSpeedButton;
    procedure btnDesistirClick(Sender: TObject);
    Procedure Binding(Sender: TOBject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure btnConsultaClienteClick(Sender: TObject);
    procedure btnConsultaProdutoClick(Sender: TObject);
    procedure btnGravarItemClick(Sender: TObject);
    procedure btnConsultaVendedorClick(Sender: TObject);

    Procedure GenericCurrencyClick(Sender: TObject);
    Procedure GenericDateEditClick(Sender: TObject);
    procedure mn_ExcluirClick(Sender: TObject);
    procedure grItensLvVwKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure mn_AlterarClick(Sender: TObject);
    procedure grItensLvVwDblClick(Sender: TObject);
    Procedure Gravar(Sender : TObject);
    procedure btnImprimirClick(Sender: TObject);
    procedure btnConsultaSetorClick(Sender: TObject);
    procedure btnConsultaFuncLabClick(Sender: TObject);
    procedure btnConsultaVendLibClick(Sender: TObject);
    procedure btnConsultaFormaPagtoClick(Sender: TObject);
    procedure btnConsultaPlanoPagamentoClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnCalcularFinancClick(Sender: TObject);
    procedure cxCbSituacaoExit(Sender: TObject);
    procedure curVrSinalEnter(Sender: TObject);
    procedure curVrSinalEditing(Sender: TObject; var CanEdit: Boolean);
    procedure curVrSinalExit(Sender: TObject);
    procedure curClienteIdEnter(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure chkOrcamentoClick(Sender: TObject);
    procedure chkPedidoRapidoClick(Sender: TObject);
    procedure curClienteIdPropertiesChange(Sender: TObject);
    procedure ppDBText31GetText(Sender: TObject; var Text: string);
    procedure ppDBText32GetText(Sender: TObject; var Text: string);
    procedure btnCancelarClick(Sender: TObject);
    procedure Mn_ExcluirDesdobramentoClick(Sender: TObject);
    procedure btnConsFotografoClick(Sender: TObject);
    procedure ppDBText68GetText(Sender: TObject; var Text: string);
    procedure ppDBText73GetText(Sender: TObject; var Text: string);
    procedure btnImpEnvelopeClick(Sender: TObject);
    procedure btnCadastroClienteClick(Sender: TObject);
  private
    { Private declarations }
    _Usuario : TUsuario;
    _DataSource : TDataSource;
    _DataBase : TDataBase;
    _Alteracao : Boolean;
    _Cliente : TPessoa;
    _Vendedor : TPessoa;
    _FuncionarioLab : TPessoa;
    _VendedorLib : TPessoa;
    _Fotografo : TPessoa;
    _FormaPagamento : TFormaPagamento;
    _PlanoPagamento : TPlanoPagamento;
    _DataSourceCtRec : TDataSource;
    _OrdemServicoService : TOrdemServicoService;
    _Setor : TSetor;
    _CtReceber : TCtReceber;
    _CtReceberService : TCtReceberService;
    _Bairro : TBairro;

    _Produto : TProduto; //Variavel Auxiliar

    _OrdemServico : TOrdemServicoEntity;

    dDescontoMaximoFunc : Double;
    iCodClienteAnt : Integer;
    bPodeEditar : Boolean;

    Procedure MascaraQuantidade();
    Procedure HabilitaDesabilitaBotoes();

    Function ValidaCliente(Gravacao : Boolean = False):Boolean;
    Function ValidaSetor(Gravacao : Boolean = False):Boolean;
    Function ValidaProduto(Gravacao : Boolean = False) : Boolean;
    Function VerificaQuantidade():Boolean;
    Function ValidaVendedor(Gravacao : Boolean = False) : Boolean;
    Function ValidaVendedorLiberacao(Gravacao : Boolean = False) : Boolean;
    Function ValidaFuncionarioLaboratorio(Gravacao : Boolean = False) : Boolean;
    Function ValidaFormaPagamento(Gravacao : Boolean = False) : Boolean;
    Function ValidaPlanoPagamento(Gravacao : Boolean = False) : Boolean;
    Function ValidaFotografo(Gravacao : Boolean = False) : Boolean;

    Procedure InserirItem();
    Procedure LimparCamposItem();
    Procedure ExcluirItem();
    Procedure AlterarItem();

    Function ValidarOrdemServico(Out sMessage : String):Boolean;

    Procedure CalcularFinanceiro();
    Procedure GerarFinanceiroSinal();
    Procedure HabilitaDesabilitaCamposSituacao();
    Function CalcularTotalParcelas():Double;
    Procedure AtualizarTotaisFinanceiro();
    Procedure HabilitarCartao(bHabilita : Boolean);
    Procedure CalcularDesconto(Sender : TObject);
    Procedure ImprimirReciboPagamento();
    Procedure ImprimirEnvelopeLaranja();
    Procedure ImprimirEnvelopeAzul();
    function AplicMascaraTelefone(iTelefone:String):String;
    function AplicMascaraCep(iCep:String):STring;
    procedure RatearDesconto();
    procedure ItensSituacao(Setor : TSetor);
    procedure BindManual(Cliente : TPessoa);
    procedure AtribuiVendedorPorCliente;
  public
    { Public declarations }

    Constructor Create(AOwner : TComponent; DataBase : TDataBase; Alteracao :Boolean; Usuario : TUsuario; CodigoOrdemServico : Integer = 0);
  end;

var
  FrCadOrdemServico: TFrCadOrdemServico;

implementation

{$R *.dfm}

uses Parametros, OrdemServicoRepository, CtReceberRepository, CadastroCliente;

{$Region 'Tela'}

Constructor TFrCadOrdemServico.Create(AOwner : TComponent; DataBase : TDataBase; Alteracao :Boolean; Usuario : TUsuario; CodigoOrdemServico : Integer = 0);
var
  sSituacao : String;
  {$Region 'Binding'}
  Procedure Binding();
  Begin

    {$Region 'Ordem de Serviço'}
    Self._OrdemServico.Bind('Id', curId, 'Value');
    Self._OrdemServico.Bind('Envelope', curEnvelope, 'Value');
    Self._OrdemServico.Bind('DataEmissao', cxDataEmissao, 'Date');
    Self._OrdemServico.Bind('HoraEmissao', cxHoraEmissao, 'Time');
    Self._OrdemServico.Bind('DataPrevisao', cxDataPrevisao, 'Date');
    Self._OrdemServico.Bind('HoraPrevisao', cxHoraPrevisao, 'Time');
    Self._OrdemServico.Bind('ClienteId', curClienteId, 'Value');
    Self._OrdemServico.Bind('Setor', curSetorId, 'Value');
    Self._OrdemServico.Bind('VendedorId', curVendedorId, 'Value');
    Self._OrdemServico.Bind('VendedorLibId', curVendLibId, 'Value');
    Self._OrdemServico.Bind('FuncionarioLaboratorioId', curFuncLabId, 'Value');
    Self._OrdemServico.Bind('PercDesconto', curPercDesconto, 'EditValue');
    Self._OrdemServico.Bind('Desconto', curDesconto, 'EditValue');
    Self._OrdemServico.Bind('TotalDescontoItens', curDescTotalItens, 'EditValue');
    Self._OrdemServico.Bind('SubTotal', curSubTotal, 'Value');
    Self._OrdemServico.Bind('ValorTotal', curValorTotalOS, 'Value');
    Self._OrdemServico.Bind('ValorSinal', curVrSinal, 'Value');
    Self._OrdemServico.Bind('FormaPagtoId', curFormaPagtoId, 'Value');
    Self._OrdemServico.Bind('PlanoPagtoId', curPlanoPagtoId, 'Value');
    Self._OrdemServico.Bind('ParcelasCartao', curParcelas, 'Value');
    Self._OrdemServico.Bind('Observacao', memObservacao, 'Text');
    Self._OrdemServico.Bind('ObservacaoRecibo', curObsRecibo, 'Text');
    Self._OrdemServico.Bind('ObservacaoRecibo2', curObsRecibo2, 'Text');
    Self._OrdemServico.Bind('Orcamento', chkOrcamento, 'Checked');
    Self._OrdemServico.Bind('PedidoRapido', chkPedidoRapido, 'Checked');
    Self._OrdemServico.Bind('Modelo', edtModelo, 'Text');
    Self._OrdemServico.Bind('FotografoId', curFotografoId, 'Value');

    {$EndRegion}

    {$Region 'Fotografo'}
    Self._Fotografo.Bind('Id', curFotografoId, 'Value');
    Self._Fotografo.Bind('Nome', edtFotografo, 'Text');
    {$EndRegion}

    {$Region 'Cliente'}
    Self._Cliente.Bind('Id', curClienteId, 'Value');
    Self._Cliente.Bind('Nome', edtNomeCliente, 'Text');
    Self._Cliente.Bind('CpfCnpj', edtCpfCnpjCliente, 'Text');
    Self._Cliente.Bind('EstadoAbreviatura', edtEstadoCliente, 'Text');
    {$EndRegion}

    {$Region 'Setor'}
    Self._Setor.Bind('Id', curSetorId, 'Value');
    Self._Setor.Bind('Nome', edtNomeSetor, 'Text');
    {$EndRegion}

    {$Region 'Produto'}
    Self._Produto.Bind('Id', curProdutoId, 'Value');
    Self._Produto.Bind('Nome', edtProduto, 'Text');
    Self._Produto.Bind('ValorUnitario', curValorUnitario, 'Value');
    {$EndRegion}

    {$Region 'Vendedor'}
    Self._Vendedor.Bind('Id', curVendedorId, 'Value');
    Self._Vendedor.Bind('Nome', edtNomeVendedor, 'Text');
    {$EndRegion}

    {$Region 'Funcinoario Laboratorio'}
    Self._FuncionarioLab.Bind('Id', curFuncLabId, 'Value');
    Self._FuncionarioLab.Bind('Nome', edtFuncLab, 'Text');
    {$EndRegion}

    {$Region 'Vendedor Liberacao'}
    Self._VendedorLib.Bind('Id', curVendLibId, 'Value');
    Self._VendedorLib.Bind('Nome', edtVendLib, 'Text');
    {$EndRegion}

    {$Region 'Forma de Pagamento'}
    Self._FormaPagamento.Bind('Id', curFormaPagtoId, 'Value');
    Self._FormaPagamento.Bind('Nome', edtFormaPagto, 'Text');
    {$EndRegion}

    {$Region 'Plano de Pagamento'}
    Self._PlanoPagamento.Bind('Id', curPlanoPagtoId, 'Value');
    Self._PlanoPagamento.Bind('Nome', edtPlanoPagto, 'Text');
    {$EndRegion}

    {$Region 'Cartao'}
    Self._CtReceber.Bind('ParcelasCartao', curParcelas, 'Value');
    {$EndRegion}
  End;
  {$EndRegion}
Begin
  Inherited Create(AOwner);
  _Usuario          := Usuario;
  _DataSource       := TDataSource.Create(Self);
  _DataBase         := DataBase;
  _Alteracao        := Alteracao;
  _Cliente          := TPessoa.Create();
  _Vendedor         := TPessoa.Create();
  _Produto          := TProduto.Create();
  _Setor            := TSetor.Create();
  _VendedorLib      := TPessoa.Create();
  _FuncionarioLab   := TPessoa.Create();
  _Fotografo        := TPessoa.Create();
  _FormaPagamento   := TFormaPagamento.Create();
  _PlanoPagamento   := TPlanoPagamento.Create();
  _CtReceber        := TCtReceber.Create();
  _DataSourceCtRec  := TDataSource.Create(Self);
  _OrdemServico     := TOrdemServicoEntity.Create();
  _CtReceberService := TCtReceberService.Create(_OrdemServico, _CtReceber, _Usuario, _DataBase);
  _OrdemServicoService := TOrdemServicoService.Create(_OrdemServico, _CtReceber, _FormaPagamento, _PlanoPagamento, _Usuario,_DataBase);

  Binding();

  if Alteracao then
  Begin
    _OrdemServico.Id := CodigoOrdemServico;
    chkPedidoRapido.Enabled := False;
    _OrdemServicoService.ConsultaOrdemServico();
    sSituacao := _OrdemServico.Situacao;
    ItensSituacao(_Setor);
    _OrdemServico.Situacao := sSituacao;
    AtualizarTotaisFinanceiro();
    TPessoaService.ConsultaPessoa(_DataBase ,_Cliente, False, TEnumPessoaTipo.Todos); //Cliente
    TSetorService.ConsultaSetor(_DataBase ,_Setor, False);

    if _OrdemServico.PedidoRapido then
      btnImpEnvelope.Enabled := False;

    if _Setor.Studio then
      pnlStudio.Visible := True
    else
      pnlStudio.Visible := False;

    TPessoaService.ConsultaPessoa(_DataBase ,_Vendedor, False, TEnumPessoaTipo.Vendedor); //Vendedor
    dDescontoMaximoFunc := _Vendedor.DescontoMaximo;
    TPessoaService.ConsultaPessoa(_DataBase ,_VendedorLib, False, TEnumPessoaTipo.Vendedor); //Vendedor Liberação
    TPessoaService.ConsultaPessoa(_DataBase ,_FuncionarioLab, False, TEnumPessoaTipo.Funcionario); //Funcionário Laboratório
    TPessoaService.ConsultaPessoa(_DataBase ,_Fotografo, False, TEnumPessoaTipo.Funcionario); //Fotografo
    TFormaPagamentoService.ConsultaFormaPagamento(_DataBase, _FormaPagamento, False );
    TPlanoPagamentoService.ConsultaPlanoPagamento(_DataBase, _PlanoPagamento, False );
  end
  else
  begin
    _OrdemServicoService.AutoIncremento();
    if _OrdemServico.Id <> 1 then
    begin
      _Setor.Id := _OrdemServicoService.ConsultaSetorUltimaOS();
      if _Setor.Id <> 0 then
        TSetorService.ConsultaSetor(_DataBase ,_Setor, False);
      ItensSituacao(_Setor);
      cxCbSituacao.ItemIndex := 0;
    end;
  end;



  HabilitaDesabilitaBotoes();

//  if (_OrdemServico.Situacao = 'E') and (_OrdemServico.Alteracao) then
//    btnGravar.Enabled := False;

  cxCbSituacaoExit(nil);
  _DataSource.DataSet := _OrdemServico.cdsItens;
  _DataSourceCtRec.DataSet := _CtReceber.cdsCtRec;
  grItensLvVw.DataController.DataSource := _DataSource;
  cxGridCtReceber.DataController.DataSource := _DataSourceCtRec;

End;

procedure TFrCadOrdemServico.curClienteIdEnter(Sender: TObject);
begin
  iCodClienteAnt := Trunc(curClienteId.Value);
end;

procedure TFrCadOrdemServico.curClienteIdPropertiesChange(Sender: TObject);
var
  sProfissional : String;
begin
  if (iCodClienteAnt <> 0) and (iCodClienteAnt <> curClienteId.Value) and
     (_OrdemServico.cdsItens.RecordCount > 0) then
  begin
    sProfissional := _Cliente.Profissional;
    Binding(curClienteId);
    TPessoaService.ConsultaPessoa(_DataBase ,_Cliente, False, TEnumPessoaTipo.Todos);
    if _Cliente.Profissional <> sProfissional  then
    begin
      TCustomMessage.Show('Não é Permitido Alterar de Cliente Profissional para Amador com Item(s) inserido(s)!',
                          'Atenção!',TTypeMessage.Exclamation, TButtons.Ok);

      curClienteId.Value := iCodClienteAnt;
      Binding(curClienteId);
      TPessoaService.ConsultaPessoa(_DataBase ,_Cliente, False, TEnumPessoaTipo.Todos);
    end;
  end
  else
    Binding(curClienteId);
end;

procedure TFrCadOrdemServico.curVrSinalEditing(Sender: TObject;
  var CanEdit: Boolean);
begin
  if (_OrdemServico.Alteracao) then
  begin
    if not _Usuario.Master then
    begin
      if not bPodeEditar then
      begin
        if (not TUsuarioService.VerificaPermissao(_DataBase, _Usuario, 'MASTER')) then
        Begin
          TCustomMessage.Show('Usuario não possui Permissão para realizar este comando.','Atenção!',TTypeMessage.Exclamation, TButtons.Ok);
          CanEdit := False;
          Exit;
        End
        else
          bPodeEditar := True;
      end;
    end
  end;
  CanEdit := True;
end;

procedure TFrCadOrdemServico.curVrSinalEnter(Sender: TObject);
begin
  bPodeEditar := False;
end;

procedure TFrCadOrdemServico.curVrSinalExit(Sender: TObject);
begin
  bPodeEditar := False;
  if (RoundTo(_OrdemServico.ValorSinal, -2) > RoundTo(_OrdemServico.ValorTotal,-2)) then
  begin
    TCustomMessage.Show('Valor do Sinal não pode ser maior que o Valor da O.S.','Atenção!',TTypeMessage.Exclamation, TButtons.Ok);
    _OrdemServico.ValorSinal := 0;
    curVrSinal.SetFocus;
    Exit;
  end;

end;

procedure TFrCadOrdemServico.cxCbSituacaoExit(Sender: TObject);
var
  sMessage : String;
begin
  if (cxCbSituacao.ItemIndex = 0) and (_OrdemServico.Situacao = 'F') Then
  begin
    if _CtReceberService.VerificarFinanceiroQuitado(_OrdemServico, _DataBase, sMessage ) then
    begin
      TCustomMessage.Show(sMessage,'Atenção!',TTypeMessage.Exclamation, TButtons.Ok);
      cxCbSituacao.ItemIndex := 1;
      Exit;
    end;
  end
  else if (cxCbSituacao.ItemIndex <> 0) and (not _Alteracao) then
  begin
    _OrdemServico.ValorSinal := 0;
  end;
  _OrdemServico.Situacao := Copy(cxCbSituacao.Text,1,1);
  HabilitaDesabilitaCamposSituacao();
end;

Procedure TFrCadOrdemServico.Binding(Sender: TOBject);
Var
  TypeBinding: String;
Begin
  if (Sender is TcxTextEdit) or (Sender is TMemo) then
    TypeBinding := 'Text';
  if (Sender is TcxDateEdit) then
    TypeBinding := 'Date';
  if (Sender is TcxTimeEdit) then
    TypeBinding := 'Time';
  if (Sender is TcxCheckBox) then
    TypeBinding := 'Checked';
  if (Sender is TcxCurrencyEdit) then
  Begin
    if ((Sender as TcxCurrencyEdit).Name = 'curDesconto')
        or ((Sender as TcxCurrencyEdit).Name = 'curPercDesconto') then
      TypeBinding := 'EditValue'
    Else
      TypeBinding := 'Value';
  End;
  TBindings.Notify(Sender, TypeBinding);
End;

procedure TFrCadOrdemServico.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  _OrdemServicoService.LiberarAcessoOS();
  _Cliente.Free;
  _Vendedor.Free;
  _Produto.Free;
  _Setor.Free;
  _VendedorLib.Free;
  _FuncionarioLab.Free;
  _FormaPagamento.Free;
  _PlanoPagamento.Free;
  _CtReceber.Free;
  _OrdemServico.Free;
  _OrdemServicoService.Free;
end;

procedure TFrCadOrdemServico.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if key = VK_F2 then
  begin
    chkOrcamento.Checked := not chkOrcamento.Checked;
    chkOrcamentoClick(nil);
  end;

  if key = VK_F3 then
  begin
    if curEnvelope.Focused then
      cxDataEmissao.SetFocus;
    chkPedidoRapido.Checked := not chkPedidoRapido.Checked;
    chkPedidoRapidoClick(nil);
  end;
end;

procedure TFrCadOrdemServico.FormKeyPress(Sender: TObject; var Key: Char);
var
  sMessage : String;
begin
  {$Region 'Enter'}
  if (Key = #13) then
  Begin
    {$Region 'Cliente'}
    if (ActiveControl = curClienteId.ActiveControl) then
    Begin
      if (Not ValidaCliente() ) then
        Exit;
      _OrdemServico.VendedorId := _Cliente.VendedorId;
      _Vendedor.Id := _Cliente.VendedorId;
      ValidaVendedor;
    End;
    {$EndRegion}

    {$Region 'Setor'}
    if (ActiveControl = curSetorId.ActiveControl) then
    Begin
      if (Not ValidaSetor() ) then
        Exit;
    End;
    {$EndRegion}

    {$Region 'Fotografo'}
    if (ActiveControl = curFotografoId.ActiveControl) then
    Begin
      if (Not ValidaFotografo() ) then
        Exit;
    End;
    {$EndRegion}

    {$Region 'Produto'}
    if (ActiveControl = curProdutoId.ActiveControl) then
    Begin
      if (not ValidaProduto()) then
        Exit;
    End;
    {$EndRegion}

    {$Region 'Quantidade'}
    if (ActiveControl = curQuantidade.ActiveControl) then
    Begin
      if (Not VerificaQuantidade()) then
        Exit;
    End;
    {$EndRegion}

    {$Region 'Perc.Desconto'}
    if (ActiveControl = curPercDescItem.ActiveControl) then
    Begin
      CalcularDesconto(curPercDescItem);
    End;

    if (ActiveControl = curPercDesconto.ActiveControl) then
      RatearDesconto();
    {$EndRegion}

    {$Region 'Vr.Desconto'}
    if (ActiveControl = curVrDescItem.ActiveControl) then
    Begin
      CalcularDesconto(curVrDescItem);
    End;

    if (ActiveControl = curDesconto.ActiveControl) then
      RatearDesconto();
    {$EndRegion}

    {$Region 'Vendedor'}
    if (ActiveControl = curVendedorId.ActiveControl) then
    Begin
      if (Not ValidaVendedor() ) then
        Exit;
    End;
    {$EndRegion}

    {$Region 'Valor Sinal'}
    if (ActiveControl = curVrSinal.ActiveControl) then
    begin
//      AtualizarTotaisFinanceiro();
//      GerarFinanceiroSinal();
//      AtualizarTotaisFinanceiro();
    end;
    {$EndRegion}

    {$Region 'Funcionário Laboratório'}
    if (ActiveControl = curFuncLabId.ActiveControl) then
    Begin
      if (Not ValidaFuncionarioLaboratorio() ) then
        Exit;
    End;
    {$EndRegion}

    {$Region 'Vendedor Liberação'}
    if (ActiveControl = curVendLibId.ActiveControl) then
    Begin
      if (Not ValidaVendedorLiberacao() ) then
        Exit;
    End;
    {$EndRegion}

    {$Region 'Observacao W'}
    if (ActiveControl = curObsRecibo.ActiveControl) then
    begin
      if (_OrdemServico.Situacao = 'A') and (_OrdemServico.ValorSinal = 0) then
      begin
        btnGravar.SetFocus;
        Exit;
      end
      else if (_OrdemServico.Situacao = 'E') and (_OrdemServico.ValorSinal = _OrdemServico.ValorTotal) then
      begin
        btnGravar.SetFocus;
        Exit;
      end
    end;

    {$Region 'Forma de Pagamento'}
    if (ActiveControl = curFormaPagtoId.ActiveControl) then
    Begin
      if (Not ValidaFormaPagamento() ) then
        Exit;
      if (_FormaPagamento.Cartao = 'S') then
      begin
        TFrInfCartao.Create(Self, _DataBase, _CtReceber);

        if (_CtReceber.AutorizacaoOperadora = '') then
        begin
          curFormaPagtoId.SelectAll();
          Exit;
        end
        else
        begin
          HabilitarCartao(True);
          curParcelas.SetFocus();
          Exit;
        end;
      end
      else
      begin
        _CtReceber.MaquinaCartao := 0;
        _CtReceber.AutorizacaoOperadora := '';
        _CtReceber.TitularCartao := '';
        HabilitarCartao(False);
        curPlanoPagtoId.SetFocus();
        Exit;
      end;

    End;
    {$EndRegion}

    {$Region 'Plano de Pagamento'}
    if (ActiveControl = curPlanoPagtoId.ActiveControl) then
    Begin
      if (Not ValidaPlanoPagamento() ) then
        Exit;
    End;
    {$EndRegion}

    {$Region 'Parcelas'}
    if (ActiveControl = curParcelas.ActiveControl) then
    Begin
      if (curParcelas.Value = 0) then
      begin
        TCustomMessage.Show('Informe a quantidade de Parcelas do Cartão','Atenção!',TTypeMessage.Exclamation, TButtons.Ok);
        Exit;
      end;
      if (_CtReceberService.VerificaPlanoPagtoCartao(_CtReceber, _PlanoPagamento, _OrdemServico, _DataBase, sMessage)) then
      begin
        btnCalcularFinanc.SetFocus;
        Exit;
      end
      else
      begin
        TCustomMessage.Show(sMessage,'Atenção!',TTypeMessage.Exclamation, TButtons.Ok);
        curParcelas.SetFocus;
        Exit;
      end;
    End;
    {$EndRegion}

    Key := #0;
    Perform(WM_NEXTDLGCTL, 0, 0);
  End;
  {$EndRegion}

  {$Region 'ESC'}
  if (key = #27) then
  Begin
    if (ActiveControl = curProdutoId.ActiveControl) then
    begin
      curPercDesconto.SetFocus();
      Exit;
    end;
  End;
  {$EndRegion}
end;

Procedure TFrCadOrdemServico.GenericCurrencyClick(Sender: TObject);
Begin
  if (Sender is TcxCurrencyEdit) then
    (Sender as TcxCurrencyEdit).SelectAll();
End;

Procedure TFrCadOrdemServico.GenericDateEditClick(Sender: TObject);
Begin
  if (Sender is TcxDateEdit) then
    (Sender as TcxDateEdit).SelectAll();
End;

procedure TFrCadOrdemServico.grItensLvVwDblClick(Sender: TObject);
begin
  AlterarItem();
end;

procedure TFrCadOrdemServico.grItensLvVwKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  {$Region 'Delete'}
  if (key = Vk_Delete) then
  Begin
    if (grItensLvVw.DataController.DataSource.DataSet.RecordCount > 0) then
      ExcluirItem();
  End;
  {$EndRegion}

  {$Region 'Enter'}
  if (key = VK_RETURN) then
  Begin
    if (grItensLvVw.DataController.DataSource.DataSet.RecordCount > 0) then
      AlterarItem();
  End;
  {$EndRegion}

end;

procedure TFrCadOrdemServico.btnDesistirClick(Sender: TObject);
begin
  Close();
end;

procedure TFrCadOrdemServico.btnGravarItemClick(Sender: TObject);
begin
  InserirItem();
end;

procedure TFrCadOrdemServico.btnImpEnvelopeClick(Sender: TObject);
begin
  if Application.MessageBox('Deseja imprimir o envelope?','Atenção',MB_ICONQUESTION + MB_YESNO) = IDYES then
  begin
    if _Setor.Studio then
      ImprimirEnvelopeAzul()
    else
      ImprimirEnvelopeLaranja();
  end;
end;

procedure TFrCadOrdemServico.btnImprimirClick(Sender: TObject);
begin
  ImprimirReciboPagamento();
end;

procedure TFrCadOrdemServico.mn_AlterarClick(Sender: TObject);
begin
  AlterarItem();
end;

procedure TFrCadOrdemServico.mn_ExcluirClick(Sender: TObject);
begin
  ExcluirItem();
end;

procedure TFrCadOrdemServico.ppDBText31GetText(Sender: TObject;
  var Text: string);
begin
  Text := AplicMascaraTelefone(Text);
end;

procedure TFrCadOrdemServico.ppDBText32GetText(Sender: TObject;
  var Text: string);
begin
  Text := AplicMascaraCep(Text);
end;

procedure TFrCadOrdemServico.ppDBText68GetText(Sender: TObject;
  var Text: string);
var
  temp : String;
begin
  temp := Copy(Text,Pos('- ',Trim(Text))+2,Length(Text));
  temp := Copy(temp,1,Pos(' ',Trim(temp))-1);
  Text := Copy(Text,1,Pos(' - ',Trim(Text))+2) + temp;

end;

procedure TFrCadOrdemServico.ppDBText73GetText(Sender: TObject;
  var Text: string);
var
  temp : String;
begin
  temp := Copy(Text,Pos('- ',Trim(Text))+2,Length(Text));
  temp := Copy(temp,1,Pos(' ',Trim(temp))-1);
  Text := Copy(Text,1,Pos(' - ',Trim(Text))+2) + temp;

end;

Procedure TFrCadOrdemServico.HabilitaDesabilitaBotoes();
Begin
  btnGravar.Enabled := True;
  cxSituacao.Caption := 'Pendente';

  btnCancelar.Enabled := False;
  btnImprimir.Enabled := False;

  if (_OrdemServico.Alteracao) and (_OrdemServico.DataEmissao <> Date) then
  begin
    curVrSinal.Enabled              := False;
  end;

  if (_OrdemServico.Alteracao) then
  begin
    if (_OrdemServico.Cancelado <> 'S') And (_OrdemServico.Faturado <> 'S') then
    Begin
      btnCancelar.Enabled := True;
      btnImprimir.Enabled := True;
    End;

    if _OrdemServico.Situacao = TEnumSituacaoOrdemServico.Fechada then
    Begin
      cxSituacao.Caption := 'Fechada';
      cxCbSituacao.ItemIndex := cxCbSituacao.Properties.Items.IndexOf('Fechada');
    End
    else if _OrdemServico.Situacao = TEnumSituacaoOrdemServico.Entregue then
    Begin
      cxSituacao.Caption := 'Entregue';
      cxCbSituacao.ItemIndex := cxCbSituacao.Properties.Items.IndexOf('Entregue');
    End
    else
    begin
      cxSituacao.Caption := 'Aberta';
      cxCbSituacao.ItemIndex := cxCbSituacao.Properties.Items.IndexOf('Aberta');
    end;

    if (_OrdemServico.Faturado = 'S') then
    begin
      cxSituacao.Caption := 'Faturado';
      btnGravar.Enabled := False;
    end;

    if (_OrdemServico.Cancelado = 'S') then
    Begin
      cxSituacao.Caption := 'Cancelado';
      btnGravar.Enabled := False;
    End;

  end;
End;

{$EndRegion}

{$Region 'Cliente'}

procedure TFrCadOrdemServico.btnCadastroClienteClick(Sender: TObject);
var ClienteNovo : TPessoa;
begin
  FrCadastroCliente := TFrCadastroCliente.Create(Self, _Database, _Usuario);
  BindManual(FrCadastroCliente.GetCliente());
  FrCadastroCliente.Release();
end;

procedure TFrCadOrdemServico.btnCalcularFinancClick(Sender: TObject);
begin
  if _OrdemServico.Situacao = 'A' then
    _CtReceber.cdsCtRec.EmptyDataSet
  else if _OrdemServico.Situacao = 'E' then
  begin
    _CtReceber.cdsCtRec.First;
    while not _CtReceber.cdsCtRec.Eof do
    begin
      if _CtReceber.cdsCtRec.FieldByName('Sinal').AsString = 'N' then
        _CtReceber.cdsCtRec.Delete
      else
        _CtReceber.cdsCtRec.Next;
    end;
  end;
  CalcularFinanceiro();
  AtualizarTotaisFinanceiro();
  BtnGravar.SetFocus;
end;

procedure TFrCadOrdemServico.btnCancelarClick(Sender: TObject);
var
  Permissao : String;
begin
  case TCustomMessage.Show('Deseja Cancelar a Ordem de Serviço?','Atenção!',TTypeMessage.Exclamation, TButtons.YesNo) of
    IdCancel,
    idNo : Exit;
  end;

  if (Sender as TBitBtn).Name = 'btnCancelar' then
  Begin
    _OrdemServico.Cancelado := 'S';
    _OrdemServico.DataCancelamento := Date;
    Permissao := 'LIBERACANCELAROS';   //Cancelar
  End;

  if (not TUsuarioService.VerificaPermissao(_DataBase, _Usuario, Permissao)) then
  Begin
    TCustomMessage.Show('Usuario não possui Permissão para Alterar/Cancelar Ordem de Serviço.','Atenção!',TTypeMessage.Exclamation, TButtons.Ok);
    Exit;
  End;
  if ( Not _OrdemServicoService.Cancelar() ) then
  Begin
    TCustomMessage.Show('Não foi possivel cancelar a Ordem de Serviço. '+chr(13)+'Entrar em contato com Suporte.','Atenção!',TTypeMessage.Exclamation, TButtons.Ok);
    Exit;
  End
  else
  begin
    if not _CtReceberService.Cancelar() then
    begin
      TCustomMessage.Show('Não foi possivel cancelar a Ordem de Serviço. '+chr(13)+'Entrar em contato com Suporte.','Atenção!',TTypeMessage.Exclamation, TButtons.Ok);
      Exit;
    end;
  end;
  Self.Close;
end;

{$Region 'Fotografo'}
procedure TFrCadOrdemServico.btnConsFotografoClick(Sender: TObject);
begin
  TPessoaService.TelaConsultaPessoa(_DataBase, _Fotografo, TEnumPessoaTipo.Funcionario);
  curFotografoId.SetFocus();
  if (_Fotografo.Id = 0) then
    curFotografoId.SelectAll();
end;

Function TFrCadOrdemServico.ValidaFotografo(Gravacao : Boolean = False) : Boolean;
Begin
  Result := False;
  if (_Fotografo.Id = 0)and(Not Gravacao) then
  begin
    btnConsFotografoClick(nil);
    Exit;
  end;

  if (Not TPessoaService.ConsultaPessoa(_DataBase ,_Fotografo, (Not Gravacao), TEnumPessoaTipo.Funcionario)) then
  Begin
    curFotografoId.SelectAll();
    Exit;
  End;

  Result := True;
End;

{$EndRegion}

procedure TFrCadOrdemServico.btnConsultaClienteClick(Sender: TObject);
begin
  TPessoaService.TelaConsultaPessoa(_DataBase, _Cliente);
  curClienteId.SetFocus();
  if (_Cliente.Id = 0) then
    curClienteId.SelectAll();
end;


Function TFrCadOrdemServico.ValidaCliente(Gravacao : Boolean = False) : Boolean;
Begin
  Result := False;
  if (_Cliente.Id = 0)and(Not Gravacao) then
  begin
    btnConsultaClienteClick(nil);
    Exit;
  end;

  if (Not TPessoaService.ConsultaPessoa(_DataBase ,_Cliente, (Not Gravacao), TEnumPessoaTipo.Todos,'Cliente inválido')) then
  Begin
    curClienteId.SelectAll();
    Exit;
  End;

  if _Produto <> nil then
  begin
    if _Cliente.Profissional = 'S' then
      _Produto.ValorUnitario := _Produto.ValorUnitarioProfissional
    else
      _Produto.ValorUnitario := _Produto.ValorUnitarioAmador;

    if _Cliente.TabelaPreco <> 0 then
      _Produto.ValorUnitario := _Produto.ValorUnitario * ((100 - _Cliente.TabelaPreco) / 100);
  end;

  Result := True;
End;

{$EndRegion}

{$Region 'Setor'}
procedure TFrCadOrdemServico.btnConsultaSetorClick(Sender: TObject);
begin
  TSetorService.TelaConsultaSetor(_DataBase, _Setor);
  curSetorId.SetFocus();
  if (_Setor.Id = 0) then
    curSetorId.SelectAll();
end;

Function TFrCadOrdemServico.ValidaSetor(Gravacao : Boolean = False) : Boolean;
Begin
  Result := False;
  if (_Setor.Id = 0)and(Not Gravacao) then
  begin
    btnConsultaSetorClick(nil);
    Exit;
  end;

  if (Not TSetorService.ConsultaSetor(_DataBase ,_Setor, (Not Gravacao))) then
  Begin
    curSetorId.SelectAll();
    Exit;
  End;

  if _Setor.Studio then
  begin
    pnlStudio.Visible := True;
    _OrdemServico.Envelope := _OrdemServicoService.BuscaNumEnvelopeStudio(_Database);
    curEnvelope.Enabled := False;
  end
  else
  begin
    pnlStudio.Visible := False;
    curEnvelope.Enabled := True;
  end;

  ItensSituacao(_Setor);

  if not _Alteracao then
    cxCbSituacao.ItemIndex := 0;


  Result := True;
End;

{$EndRegion}

{$Region 'Produto'}

procedure TFrCadOrdemServico.btnConsultaProdutoClick(Sender: TObject);
begin
  TProdutoService.TelaConsulta(_DataBase, _Produto);
  MascaraQuantidade();
  curProdutoId.SetFocus();
  if (_Produto.Id = 0) then
    curProdutoId.SelectAll();
end;

Function TFrCadOrdemServico.ValidaProduto(Gravacao : Boolean = False) : Boolean;
Begin
  Result := False;
  if (_Produto.Id = 0) then
  begin
    if (Not Gravacao) then
      btnConsultaProdutoClick(nil);
    Exit;
  end;

  if (Not TProdutoService.ConsultaProduto(_DataBase ,_Produto, True, 'Produto inválido', False, _OrdemServico)) then
  Begin
    curProdutoId.SelectAll();
    Exit;
  End;
  MascaraQuantidade();

  if _Cliente.Profissional = 'S' then
    _Produto.ValorUnitario := _Produto.ValorUnitarioProfissional
  else
    _Produto.ValorUnitario := _Produto.ValorUnitarioAmador;

  if _Cliente.TabelaPreco <> 0 then
    _Produto.ValorUnitario := _Produto.ValorUnitario * ((100 - _Cliente.TabelaPreco) / 100);

  Result := True;
End;

{$EndRegion}

{$Region 'Quantidade'}
Function TFrCadOrdemServico.VerificaQuantidade():Boolean;
Begin
  Result := False;
  if (curQuantidade.Value <= 0) then
  Begin
    Application.MessageBox('Quantidade inválida!', 'Atenção!', Mb_IconExclamation);
    Exit;
  End;

  curValorTotalItem.Value := _Produto.ValorUnitario * curQuantidade.Value;
  Result := True;
End;

Procedure TFrCadOrdemServico.MascaraQuantidade();
Begin
  curQuantidade.Properties.DisplayFormat := TMascara.GetDisplayDecimais(_Produto.Decimais);
  curQuantidade.Properties.EditFormat := curQuantidade.Properties.DisplayFormat;
  curQuantidade.Properties.DecimalPlaces := _Produto.Decimais;
End;
procedure TFrCadOrdemServico.Mn_ExcluirDesdobramentoClick(Sender: TObject);
begin
  _CtReceber.cdsCtRec.EmptyDataSet;
  AtualizarTotaisFinanceiro();
end;

{$EndRegion}

{$Region 'Vendedor'}

procedure TFrCadOrdemServico.btnConsultaVendedorClick(Sender: TObject);
begin
  TPessoaService.TelaConsultaPessoa(_DataBase, _Vendedor, TEnumPessoaTipo.Vendedor);
  curVendedorId.SetFocus();
  if (_Vendedor.Id = 0) then
    curVendedorId.SelectAll();
end;

Function TFrCadOrdemServico.ValidaVendedor(Gravacao : Boolean = False) : Boolean;
Begin
  Result := False;
  if (_Vendedor.Id = 0)and(Not Gravacao) then
  begin
    btnConsultaVendedorClick(nil);
    Exit;
  end;

  if (Not TPessoaService.ConsultaPessoa(_DataBase ,_Vendedor, (Not Gravacao), TEnumPessoaTipo.Vendedor)) then
  Begin
    curVendedorId.SelectAll();
    Exit;
  End;

  if _Vendedor.DescontoMaximo <> 0 then
    dDescontoMaximoFunc := _Vendedor.DescontoMaximo;

  Result := True;
End;

{$EndRegion}

{$Region 'Funcionario Laboratorio'}
procedure TFrCadOrdemServico.btnConsultaFuncLabClick(Sender: TObject);
begin
  TPessoaService.TelaConsultaPessoa(_DataBase, _FuncionarioLab, TEnumPessoaTipo.Funcionario);
  curFuncLabId.SetFocus();
  if (_FuncionarioLab.Id = 0) then
    curFuncLabId.SelectAll();
end;

Function TFrCadOrdemServico.ValidaFuncionarioLaboratorio(Gravacao : Boolean = False) : Boolean;
Begin
  Result := False;
  if (_FuncionarioLab.Id = 0)and(Not Gravacao) then
  begin
    btnConsultaFuncLabClick(nil);
    Exit;
  end;

  if (Not TPessoaService.ConsultaPessoa(_DataBase ,_FuncionarioLab, (Not Gravacao), TEnumPessoaTipo.Funcionario)) then
  Begin
    curFuncLabId.SelectAll();
    Exit;
  End;

  Result := True;
End;
{$EndRegion}

{$Region 'Forma de Pagamento'}
procedure TFrCadOrdemServico.btnConsultaFormaPagtoClick(Sender: TObject);
begin
  TFormaPagamentoService.TelaConsulta(_DataBase, _FormaPagamento);
  curFormaPagtoId.SetFocus();
  if (_FormaPagamento.Id = 0) then
    curFormaPagtoId.SelectAll();
end;

Function TFrCadOrdemServico.ValidaFormaPagamento(Gravacao : Boolean = False) : Boolean;
Begin
  Result := False;
  if (_FormaPagamento.Id = 0)and(Not Gravacao) then
  begin
    btnConsultaFormaPagtoClick(nil);
    Exit;
  end;

  if (Not TFormaPagamentoService.ConsultaFormaPagamento(_DataBase ,_FormaPagamento, (Not Gravacao))) then
  Begin
    curFormaPagtoId.SelectAll();
    Exit;
  End;

  Result := True;
End;
{$EndRegion}

{$Region 'Plano de Pagamento'}
procedure TFrCadOrdemServico.btnConsultaPlanoPagamentoClick(Sender: TObject);
begin
  TPlanoPagamentoService.TelaConsulta(_DataBase, _PlanoPagamento);
  curPlanoPagtoId.SetFocus();
  if (_PlanoPagamento.Id = 0) then
    curPlanoPagtoId.SelectAll();
end;

Function TFrCadOrdemServico.ValidaPlanoPagamento(Gravacao : Boolean = False) : Boolean;
Begin
  Result := False;
  if (_PlanoPagamento.Id = 0)and(Not Gravacao) then
  begin
    btnConsultaPlanoPagamentoClick(nil);
    Exit;
  end;

  if (Not TPlanoPagamentoService.ConsultaPlanoPagamento(_DataBase ,_PlanoPagamento, (Not Gravacao))) then
  Begin
    curPlanoPagtoId.SelectAll();
    Exit;
  End;

  Result := True;
End;
{$EndRegion}

{$Region 'Vendedor Liberação'}
procedure TFrCadOrdemServico.btnConsultaVendLibClick(Sender: TObject);
begin
  TPessoaService.TelaConsultaPessoa(_DataBase, _VendedorLib, TEnumPessoaTipo.Vendedor);
  curVendLibId.SetFocus();
  if (_VendedorLib.Id = 0) then
    curVendLibId.SelectAll();
end;

Function TFrCadOrdemServico.ValidaVendedorLiberacao(Gravacao : Boolean = False) : Boolean;
Begin
  Result := False;
  if (_VendedorLib.Id = 0)and(Not Gravacao) then
  begin
    btnConsultaVendLibClick(nil);
    Exit;
  end;

  if (Not TPessoaService.ConsultaPessoa(_DataBase ,_VendedorLib, (Not Gravacao), TEnumPessoaTipo.Vendedor)) then
  Begin
    curVendLibId.SelectAll();
    Exit;
  End;

  Result := True;
End;
{$EndRegion}

{$Region 'Item'}
Procedure TFrCadOrdemServico.InserirItem();
Begin
  if (Not ValidaProduto(True) ) then
    Exit;
  if (curQuantidade.Value <= 0) then
  Begin
    Application.MessageBox('Quantidade inválida!', 'Atenção!', Mb_IconExclamation);
    Exit;
  End;

  _OrdemServicoService.AddItem(_Produto, _Cliente, curQuantidade.Value, curPercDescItem.Value, curVrDescItem.Value);
  LimparCamposItem();
  curProdutoId.SetFocus();
  curProdutoId.SelectAll();
End;

Procedure TFrCadOrdemServico.LimparCamposItem();
Begin
  _Produto.Id := 0;
  curQuantidade.Value := 0;
  curPercDescItem.Value := 0;
  curVrDescItem.Value := 0;
  curValorTotalItem.Value := 0;
End;

Procedure TFrCadOrdemServico.ExcluirItem();
Begin
  _OrdemServicoService.DeleteItem(grItensLvVw.DataController.DataSource.DataSet.RecNo);
End;

Procedure TFrCadOrdemServico.AlterarItem();
Var
  Quantidade : Double;
Begin
  _OrdemServicoService.GetItem(_Produto, grItensLvVw.DataController.DataSource.DataSet.RecNo, Quantidade);
  curQuantidade.Value := Quantidade;
  MascaraQuantidade();
  curQuantidade.SetFocus();
  curQuantidade.SelectAll();
End;

{$EndRegion}

{$Region 'Gravar'}
Procedure TFrCadOrdemServico.Gravar(Sender : TObject);
Var
  sMessage : String;
  Permissao : String;
  dPercDescConcedido : Double;
Begin
  Permissao := 'LIBERAALTERACAOOS';  //Alterar

  if Not ValidarOrdemServico(sMessage) then
  Begin
    if sMessage <> '' then
      TCustomMessage.Show(sMessage,'Atenção!',TTypeMessage.Exclamation, TButtons.Ok);
    Exit;
  End;

  if _OrdemServico.Alteracao then
  Begin
    if (not TUsuarioService.VerificaPermissao(_DataBase, _Usuario, Permissao)) then
    Begin
      TCustomMessage.Show('Usuario não possui Permissão para realizar este comando.','Atenção!',TTypeMessage.Exclamation, TButtons.Ok);
      Exit;
    End;
  End;

  dPercDescConcedido := RoundTo((_OrdemServico.Desconto + _OrdemServico.TotalDescontoItens) /
                                (_OrdemServico.SubTotal) * 100, -2 );
  if (RoundTo(dPercDescConcedido, -2) > RoundTo(dDescontoMaximoFunc, -2)) then
  begin
    if TCustomMessage.Show(PChar('Desconto acima do máximo permitido.' + chr(13) +
                        'Desconto Máximo Permitido: ' + FormatFloat('0.00',dDescontoMaximoFunc) + '%' + chr(13) +
                        'Desconto Concedido: ' + FormatFloat('0.00',dPercDescConcedido) + '%' + chr(13) +
                        'Confirma Desconto?')
                        ,'Atenção!',TTypeMessage.Question, TButtons.YesNo) = IdYes then
    begin
      Permissao := 'LIBERADESCAC_PED';
      if (not TUsuarioService.VerificaPermissao(_DataBase, _Usuario, Permissao)) then
      Begin
        TCustomMessage.Show('Usuario não possui Permissão para realizar este comando.','Atenção!',TTypeMessage.Exclamation, TButtons.Ok);
        Exit;
      End;
    end
    else
      Exit;
  end;


  if (_OrdemServico.Situacao = 'F') then
  begin
    _OrdemServico.DataFechamento := Date;
    _OrdemServico.HoraFechamento := Time;
  end
  else if (_OrdemServico.Situacao = 'E') then
  begin
    _OrdemServico.DataEntrega := Date;
    _OrdemServico.HoraEntrega := Time;
  end;

  if _OrdemServico.Alteracao then
  begin
    if TOrdemServicoRepository.VerificaFormaEnviaMaisCaixa(_OrdemServico.FormaPagtoIdAnterior, _DataBase) then
    begin
      if (((_OrdemServico.Situacao = 'A') and (_OrdemServico.ValorSinal <> _OrdemServico.ValorSinalAnterior) or (_OrdemServico.FormaPagtoId <> _OrdemServico.FormaPagtoIdAnterior)) or
       ((_OrdemServico.Situacao = 'E') and (_OrdemServico.Situacao = _OrdemServico.SituacaoAnterior))) or (_OrdemServico.PedidoRapido) then
      TCtReceberRepository.EstornarMaisCaixa(False, _OrdemServico, _DataBase);
    end;
  end;

  if ( Not _OrdemServicoService.Gravar(_Cliente) ) then
  Begin
    TCustomMessage.Show('Não foi possivel gravar a Ordem de Serviço. '+chr(13)+'Entrar em contato com Suporte.','Atenção!',TTypeMessage.Exclamation, TButtons.Ok);
    Exit;
  End;

  if _Setor.Studio then
  begin
    _OrdemServicoService.GravaNumEnvelopeStudio(_OrdemServico, _DataBase);
  end;

  if (not _OrdemServico.Orcamento) then
  begin
    if (not _CtReceber.cdsCtRec.IsEmpty) OR ((_OrdemServico.ValorSinal <> 0) and (_OrdemServico.Situacao = 'A')) then
    begin
      if (_FormaPagamento.EnviaMaisCaixa = 'S')  then
      begin
        if not _CtReceberService.GravarMaisCaixa(_OrdemServico, _CtReceber, _Usuario, _DataBase) then
        begin
          TCustomMessage.Show('Não foi possivel gravar Mais Caixa. '+chr(13)+'Entrar em contato com Suporte.','Atenção!',TTypeMessage.Exclamation, TButtons.Ok);
          Exit;
        end;
      end;
    end;
  end;
  ImprimirReciboPagamento();
  if not _OrdemServico.PedidoRapido then
  begin
    if Application.MessageBox('Deseja imprimir o envelope?','Atenção',MB_ICONQUESTION + MB_YESNO) = IDYES then
    begin
      if _Setor.Studio then
        ImprimirEnvelopeAzul()
      else
        ImprimirEnvelopeLaranja();
    end;
  end;

  Close();
End;

Function TFrCadOrdemServico.ValidarOrdemServico(Out sMessage : String):Boolean;
var
  dPercMinimoSinal, dPercDescConcedido : Double;
  Permissao : String;
Begin
  Result := False;

  {$Region 'Número Envelope'}
  if (_OrdemServico.Envelope = 0) and (not _OrdemServico.PedidoRapido) then
  begin
    sMessage := 'Número do envelope inválido!';
    curEnvelope.SetFocus();
    curEnvelope.SelectAll();
    Exit;
  end;
  {$EndRegion}

  {$Region 'Data Emissão'}
  if (_OrdemServico.DataEmissao < StrToDateTime('01/01/2000')) then
  Begin
    sMessage := 'Data de emissão inválida!';
    cxDataEmissao.SetFocus();
    cxDataEmissao.SelectAll();
    Exit;
  End;
  {$EndRegion}

  {$Region 'Data Previsão'}
  if (_OrdemServico.DataPrevisao < StrToDateTime('01/01/2000')) then
  Begin
    sMessage := 'Data de previsão inválida!';
    cxDataPrevisao.SetFocus();
    cxDataPrevisao.SelectAll();
    Exit;
  End
  else if (_OrdemServico.DataPrevisao < _OrdemServico.DataEmissao) then
  Begin
    sMessage := 'Data de previsão não pode ser menor que a data de emissão!';
    cxDataPrevisao.SetFocus();
    cxDataPrevisao.SelectAll();
    Exit;
  End;
  {$EndRegion}

  {$Region 'Cliente'}
  if (not ValidaCliente(True)) then
  Begin
    sMessage := 'Cliente inválido';
    curClienteId.SetFocus();
    curClienteId.SelectAll();
    Exit;
  End;
  {$EndRegion}

  {$Region 'Itens'}
  if (_OrdemServico.cdsItens.RecordCount = 0) then
  Begin
    sMessage := 'Necessário informar no mínimo um Item!';
    curProdutoId.SetFocus();
    curProdutoId.SelectAll();
    Exit;
  End;
  {$EndRegion}


  {$Region 'Vendedores'}
  if (Not ValidaVendedor(True)) then
  Begin
    sMessage := 'Vendedor inválido';
    curVendedorId.SetFocus();
    curVendedorId.SelectAll();
    Exit;
  End;

  if (_OrdemServico.Situacao = 'F') then
  begin
    if (Not ValidaFuncionarioLaboratorio(True)) then
    Begin
      sMessage := 'Funcinário Laboratório inválido';
      curFuncLabId.SetFocus();
      curFuncLabId.SelectAll();
      Exit;
    End;
  end;

  if (_OrdemServico.Situacao = 'E') then
  begin
    if (Not ValidaVendedorLiberacao(True)) then
    Begin
      sMessage := 'Vendedor Liberação inválido';
      curVendLibId.SetFocus();
      curVendLibId.SelectAll();
      Exit;
    End;
  end;
  {$EndRegion}



  {$Region 'Valor Total'}
  if (_OrdemServico.ValorTotal <= 0) then
  Begin
    sMessage := 'Valor da Ordem de Serviço deve ser maior que zero.';
    curProdutoId.SetFocus();
    curProdutoId.SelectAll();
    Exit;
  End;
  {$EndRegion}

  {$Region 'Valor Sinal'}
  if (not _OrdemServico.PedidoRapido) and (not _OrdemServico.Orcamento) and (_OrdemServico.Situacao = 'A') then
  begin
    if RoundTo(_OrdemServico.ValorSinal,-2) <> RoundTo(curVrSinalCtReceber.Value,-2) then
    begin
      sMessage := 'Valor do Sinal diferente do Financeiro, clique no botão Calcular Financeiro.';
      Exit;
    end;
    if (_Cliente.Profissional = 'S') then
    Begin
      dPercMinimoSinal := StrToFloat(TParametros.VerificaParametros('PERCMINSINALPROFISSIONALOS','D',_DataBase));
      if dPercMinimoSinal > 0 then
      begin
        if RoundTo(_OrdemServico.ValorSinal / _OrdemServico.ValorTotal * 100, -2) < dPercMinimoSinal then
        begin
          sMessage := 'Valor do Sinal deve ser igual ou maior que ' + FormatFloat('0.00',dPercMinimoSinal) + '%' +
                      ' do Valor Total da Ordem de Serviço' + chr(13) +
                      'Valor Mínimo Necessário: R$ ' + FormatFloat('0.00',RoundTo(_OrdemServico.ValorTotal * dPercMinimoSinal / 100, -2));
          curVrSinal.SetFocus();
          curVrSinal.SelectAll();
          Exit;
        end;
      end;
    End
    Else
    begin
      dPercMinimoSinal := StrToFloat(TParametros.VerificaParametros('PERCMINSINALAMADOROS','D',_DataBase));
      if dPercMinimoSinal > 0 then
      begin
        if RoundTo(_OrdemServico.ValorSinal / _OrdemServico.ValorTotal * 100, -2) < dPercMinimoSinal then
        begin
          sMessage := 'Valor do Sinal deve ser igual ou maior que ' + FormatFloat('0.00',dPercMinimoSinal) + '%' +
                      ' do Valor Total da Ordem de Serviço' + chr(13) +
                      'Valor Mínimo Necessário: R$ ' + FormatFloat('0.00',RoundTo(_OrdemServico.ValorTotal * dPercMinimoSinal / 100, -2));
          if TCustomMessage.Show(PChar(sMessage + chr(13) + 'Deseja autorizar a Ordem de Serviço sem o Sinal?'),'Atenção!',
                                       TTypeMessage.Question, TButtons.YesNo) = IdYes then
          begin
            if (not TUsuarioService.VerificaPermissao(_DataBase, _Usuario, 'MASTER')) then
            Begin
              TCustomMessage.Show('Usuario não possui Permissão para realizar este comando.','Atenção!',TTypeMessage.Exclamation, TButtons.Ok);
              curVrSinal.SetFocus();
              curVrSinal.SelectAll();
              sMessage := '';
              Exit;
            End;
          end
          else
          begin
            sMessage := '';
            curVrSinal.SetFocus();
            curVrSinal.SelectAll();
            Exit;
          end;
        end;
      end;
    end;
  end;
  {$EndRegion}

  {$Region 'Financeiro'}
  if (_OrdemServico.Situacao = 'E') or (_OrdemServico.PedidoRapido) then
  begin
    if (_CtReceber.cdsCtRec.IsEmpty) and (RoundTo(_OrdemServico.ValorSinal,-2) < RoundTo(_OrdemServico.ValorTotal,-2))  then
    begin
      if (not _OrdemServico.PedidoRapido) then
        sMessage := 'Necessário gerar o Contas a Receber ao Entregar a Ordem de Serviço!'
      else
        sMessage := 'Necessário gerar o Contas a Receber para Finalizar o Pedido Rápido!';
      curFormaPagtoId.SetFocus();
      curFormaPagtoId.SelectAll();
      Exit;
    end;
    if (not _CtReceber.cdsCtRec.IsEmpty) and (RoundTo(_OrdemServico.ValorSinal,-2) < RoundTo(_OrdemServico.ValorTotal,-2)) then
    begin
      _CtReceber.cdsCtRec.Filtered := False;
      _CtReceber.cdsCtRec.Filter := 'SINAL = ''N''';
      _CtReceber.cdsCtRec.Filtered := True;
      if _CtReceber.cdsCtRec.RecordCount = 0 then
      begin
        _CtReceber.cdsCtRec.Filtered := False;
        sMessage := 'Necessário gerar o Contas a Receber ao Entregar a Ordem de Serviço!';
        curFormaPagtoId.SetFocus();
        curFormaPagtoId.SelectAll();
        Exit;
      end;
      _CtReceber.cdsCtRec.Filtered := False;
    end;
  end;
  {$EndRegion}

  if _OrdemServico.Alteracao then
  begin
    if _OrdemServico.Situacao <> 'F' then
    begin
      if _CtReceberService.VerificarFinanceiroQuitado(_OrdemServico, _DataBase, sMessage ) then
        Exit;
    end;
  end;

  Result := True;
End;
{$EndRegion}

Procedure TFrCadOrdemServico.CalcularFinanceiro();
var
  sDesdobramento : String;
  rValorTotal, rValorParcela, rValorDifParcelas : Double;
  iCont : Integer;
Begin
  sDesdobramento    := _PlanoPagamento.Desdobramento;
  if (_OrdemServico.Situacao = 'A') and (not _OrdemServico.PedidoRapido) then
    rValorTotal       := _OrdemServico.ValorSinal
  else
    rValorTotal       := RoundTo(_OrdemServico.ValorTotal,-2) - RoundTo(_OrdemServico.ValorSinal,-2);

  if RoundTo(rValorTotal,-2) = 0 then
  begin
    TCustomMessage.Show('Valor a pagar está zerado.','Atenção!',TTypeMessage.Exclamation, TButtons.Ok);
    Exit;
  end;

  rValorParcela     := RoundTo(rValorTotal / _PlanoPagamento.Parcelas,-2);
  rValorDifParcelas := RoundTo(rValorTotal - (rValorParcela * _PlanoPagamento.Parcelas),-2);
  for iCont := 1 to _PlanoPagamento.Parcelas do
  begin
    _CtReceber.cdsCtRec.Append;
    _CtReceber.cdsCtRec.FieldByName('Item').AsString := Copy('000',1,3 - Length(IntToStr(iCont)))  + IntToStr(iCont);
    _CtReceber.cdsCtRec.FieldByName('NumDocumento').AsString := FormatFloat('000000',_OrdemServico.Id) + _CtReceberService.RecuperarExtensaoDaFatura(DateToStr(_OrdemServico.DataEmissao), iCont, _PlanoPagamento.Parcelas) ;
    _CtReceber.cdsCtRec.FieldByName('DataVencimento').AsDateTime := _OrdemServico.DataEmissao + StrToInt(Copy(sDesdobramento,1,Pos('/',sDesdobramento)-1));
    _CtReceber.cdsCtRec.FieldByName('DiasParcela').AsInteger := Trunc(_CtReceber.cdsCtRec.FieldByName('DataVencimento').AsDateTime - _OrdemServico.DataEmissao);
    _CtReceber.cdsCtRec.FieldByName('ValorDocumento').AsFloat := rValorParcela;
    if iCont = 1 then
      _CtReceber.cdsCtRec.FieldByName('ValorDocumento').AsFloat := RoundTo(_CtReceber.cdsCtRec.FieldByName('ValorDocumento').AsFloat + rValorDifParcelas,-2);
    sDesdobramento := Copy(sDesdobramento,Pos('/',sDesdobramento)+1,Length(sDesdobramento));
    if (_OrdemServico.Situacao = 'A') and (not _OrdemServico.PedidoRapido) then
      _CtReceber.cdsCtRec.FieldByName('Sinal').AsString := 'S'
    else
      _CtReceber.cdsCtRec.FieldByName('Sinal').AsString := 'N';
    _CtReceber.cdsCtRec.Post;
  end;
  _CtReceber.cdsCtRec.First;
  if (_FormaPagamento.Cartao = 'S') then
    _CtReceberService.CalculaTaxaCartao(_CtReceber, _OrdemServico);


End;

Procedure TFrCadOrdemServico.GerarFinanceiroSinal();
var
  _PlanoPagamentoService : TPlanoPagamentoService;
Begin
  _PlanoPagamentoService := TPlanoPagamentoService.Create();
  _PlanoPagamentoService.ConsultaPlanoVista(_DataBase, _PlanoPagamento);

  _CtReceber.cdsCtRec.Append;
  _CtReceber.cdsCtRec.FieldByName('Item').AsString := Copy('000',1,3 - Length(IntToStr(1)))  + IntToStr(1);
  _CtReceber.cdsCtRec.FieldByName('NumDocumento').AsString := FormatFloat('000000',_OrdemServico.Id);
  _CtReceber.cdsCtRec.FieldByName('DataVencimento').AsDateTime := Date;
  _CtReceber.cdsCtRec.FieldByName('DiasParcela').AsInteger := 1;
  _CtReceber.cdsCtRec.FieldByName('ValorDocumento').AsFloat := _OrdemServico.ValorSinal;
  _CtReceber.cdsCtRec.Post;

  _CtReceber.cdsCtRec.First;
  _PlanoPagamentoService.Free;

End;

Procedure TFrCadOrdemServico.HabilitaDesabilitaCamposSituacao();
begin
  curVrSinal.Enabled                := False;
  curFuncLabId.Enabled              := False;
  edtFuncLab.Enabled                := False;
  btnConsultaFuncLab.Enabled        := False;
  curVendLibId.Enabled              := False;
  edtVendLib.Enabled                := False;
  btnConsultaVendLib.Enabled        := False;
  if (not _OrdemServico.PedidoRapido) and (_OrdemServico.Situacao = 'F') then
  begin
    curFormaPagtoId.Enabled           := False;
    edtFormaPagto.Enabled             := False;
    btnConsultaFormaPagto.Enabled     := False;
    curPlanoPagtoId.Enabled           := False;
    edtPlanoPagto.Enabled             := False;
    btnConsultaPlanoPagamento.Enabled := False;
    btnCalcularFinanc.Enabled         := False;
  end;
  if (_OrdemServico.Situacao = 'A') and ((not _OrdemServico.Alteracao) or
   ((_OrdemServico.Alteracao) and (_OrdemServico.DataEmissao = Date))) then
  begin
    curVrSinal.Enabled              := True;
  end
  else if (_OrdemServico.Situacao = 'F') then
  begin
    curFuncLabId.Enabled            := True;
    edtFuncLab.Enabled              := True;
    btnConsultaFuncLab.Enabled      := True;
  end
  else if (_OrdemServico.Situacao = 'E') and (btnGravar.Enabled) then
  begin
    curVendLibId.Enabled              := True;
    edtVendLib.Enabled                := True;
    btnConsultaVendLib.Enabled        := True;
    curFormaPagtoId.Enabled           := True;
    edtFormaPagto.Enabled             := True;
    btnConsultaFormaPagto.Enabled     := True;
    curPlanoPagtoId.Enabled           := True;
    edtPlanoPagto.Enabled             := True;
    btnConsultaPlanoPagamento.Enabled := True;
    btnCalcularFinanc.Enabled         := True;
    AtualizarTotaisFinanceiro();
  end

end;

Function TFrCadOrdemServico.CalcularTotalParcelas():Double;
var
  rTotalParcela : Double;
begin
  rTotalParcela := 0;
  if (not _CtReceber.cdsCtRec.IsEmpty) then
  begin
    _CtReceber.cdsCtRec.DisableControls;
    _CtReceber.cdsCtRec.First;
    while not _CtReceber.cdsCtRec.Eof do
    begin
      rTotalParcela := rTotalParcela + _CtReceber.cdsCtRec.FieldByName('VALORDOCUMENTO').AsFloat;
      _CtReceber.cdsCtRec.Next;
    end;
    _CtReceber.cdsCtRec.First;
    _CtReceber.cdsCtRec.EnableControls;
  end;
  Result := rTotalParcela;
end;


procedure TFrCadOrdemServico.chkOrcamentoClick(Sender: TObject);
begin
  if chkOrcamento.Checked then
  begin
    pnFinanceiro.Enabled := False;
    curVrSinal.Enabled := False;
    cxCbSituacao.ItemIndex := 0;
    cxCbSituacao.Enabled := False;
    _CtReceber.cdsCtRec.EmptyDataSet;
  end
  else
  begin
    pnFinanceiro.Enabled := True;
    curVrSinal.Enabled := True;
    cxCbSituacao.Enabled := True;
  end;
end;

procedure TFrCadOrdemServico.chkPedidoRapidoClick(Sender: TObject);
begin
  if chkPedidoRapido.Checked then
  begin
    pnSituacao.Visible := False;
    curFormaPagtoId.Enabled           := True;
    edtFormaPagto.Enabled             := True;
    btnConsultaFormaPagto.Enabled     := True;
    curPlanoPagtoId.Enabled           := True;
    edtPlanoPagto.Enabled             := True;
    btnConsultaPlanoPagamento.Enabled := True;
    btnCalcularFinanc.Enabled         := True;
    //_OrdemServico.Situacao := 'E';
    _OrdemServico.ValorSinal := 0;
  end
  else
  begin
    pnSituacao.Visible := True;
    pnlTotais.Visible := False;
    pnlTotais.Visible := True;
    HabilitaDesabilitaCamposSituacao();
  end;
end;

Procedure TFrCadOrdemServico.AtualizarTotaisFinanceiro();
begin
  curVrSinalCtReceber.Value := _OrdemServico.ValorSinal;

  if (_OrdemServico.Situacao = 'E') or (_OrdemServico.PedidoRapido) then
    curValorReceber.Value := _OrdemServico.ValorTotal;

  curValorParcelas.Value := CalcularTotalParcelas();
  if ((_OrdemServico.Situacao = 'A') or (_OrdemServico.Situacao = 'F'))
     and (not _OrdemServico.PedidoRapido) then
    curValorDiferenca.Value := 0//RoundTo(_OrdemServico.ValorSinal - curValorParcelas.Value,-2)
  else
  begin
    if curValorParcelas.Value = 0 then
      curValorDiferenca.Value := RoundTo(curValorReceber.Value - curVrSinalCtReceber.Value,-2)
    else
    begin
      curValorDiferenca.Value := RoundTo(curValorReceber.Value - curValorParcelas.Value,-2)
    end;
  end;
end;

Procedure TFrCadOrdemServico.HabilitarCartao(bHabilita : Boolean);
begin
  curParcelas.Visible := bHabilita;
  edtPlanoPagto.Visible := not bHabilita;
  curPlanoPagtoId.Visible := not bHabilita;
  btnConsultaPlanoPagamento.Visible := not bHabilita;
  if bHabilita then
    lbPlanoPagamento.Caption := 'Parcelas:'
  else
    lbPlanoPagamento.Caption := 'Plano de Pagamento:'
end;

Procedure TFrCadOrdemServico.CalcularDesconto(Sender : TObject);
begin
  if Sender = curPercDescItem then
  begin
    if curPercDescItem.Value <> 0 then
      curVrDescItem.Value := RoundTo((curValorUnitario.Value * curQuantidade.Value) *
                                      curPercDescItem.Value / 100,-2);
  end
  else if Sender = curVrDescItem then
  begin
    if curVrDescItem.Value <> 0 then
      curPercDescItem.Value := RoundTo(curVrDescItem.Value /
                                      (curValorUnitario.Value * curQuantidade.Value) * 100,-2);
  end;
  curValorTotalItem.Value := RoundTo((curValorUnitario.Value * curQuantidade.Value) -
                                      curVrDescItem.Value,-2);


end;

Procedure TFrCadOrdemServico.ImprimirReciboPagamento();
Var
  DataSet : TDataSet;
  DataSource : TDataSource;
begin
  DataSet := _OrdemServicoService.ReciboPagamento(_OrdemServico.Id, _DataBase);

  if DataSet.RecordCount = 0 then
  Begin
    TCustomMessage.Show('O.S. inválida.', 'Atenção!', TTypeMessage.Exclamation, TButtons.Ok);
    Exit;
  End;
  if not _Setor.Studio then
  begin
    ppDataHoraPrevisao.Visible := False;
    ppDBDataHoraPrevisao.Visible := False;
    ppModelo.Visible := False;
    ppDBModelo.Visible := False;
    ppDataHoraPrevisao2.Visible := False;
    ppDBDataHoraPrevisao2.Visible := False;
    ppModelo2.Visible := False;
    ppDBModelo2.Visible := False;
  end;
  if _OrdemServico.Situacao = 'A' then
  begin
    ppLbVrSinal1.Caption := 'Valor Recebido:';
    ppLbVrSinal2.Caption := 'Valor Recebido:';
    ppLbVrFinal1.Visible := False;
    ppLbVrFinal2.Visible := False;
    ppDBVrFinal1.Visible := False;
    ppDBVrFinal2.Visible := False;
    if _OrdemServico.PedidoRapido then
    begin
      ppDBSinal1.DataField := 'VRFINAL';
      ppDBSinal2.DataField := 'VRFINAL';
    end;
  end;

  DataSource := TDataSource.Create(Self);
  DataSource.DataSet := DataSet;
  ppDBRecibo.DataSource := DataSource;
  ppRecibo.DeviceType := 'Printer';
  ppRecibo.ShowPrintDialog := True;
  ppRecibo.Print;
end;

Procedure TFrCadOrdemServico.ImprimirEnvelopeLaranja();
Var
  DataSet : TDataSet;
  DataSource : TDataSource;
  sCodigo : String;
  i : Integer;
begin
  DataSet := _OrdemServicoService.EnvelopeLaranja(_OrdemServico.Id, _DataBase);

  if DataSet.RecordCount = 0 then
  Begin
    TCustomMessage.Show('O.S. inválida.', 'Atenção!', TTypeMessage.Exclamation, TButtons.Ok);
    Exit;
  End;

  sCodigo := '';
  DataSet.First;
  for i := 1 to 3 do
  begin
    if not DataSet.Eof then
    begin
      sCodigo := sCodigo + FormatFloat('000000',DataSet.FieldByName('CODPROD').AsInteger) + '/';
      DataSet.Next;
    end;
  end;

  ppLbCodigos.Caption := sCodigo;
  DataSource := TDataSource.Create(Self);
  DataSource.DataSet := DataSet;
  ppDBEnvelopeLaranja.DataSource := DataSource;
  ppEnvelopeLaranja.DeviceType := 'Printer';
  ppEnvelopeLaranja.ShowPrintDialog := True;
  ppEnvelopeLaranja.Print;
end;

Procedure TFrCadOrdemServico.ImprimirEnvelopeAzul();
Var
  DataSet : TDataSet;
  DataSource : TDataSource;
begin
  DataSet := _OrdemServicoService.EnvelopeAzul(_OrdemServico.Id, _DataBase);

  if DataSet.RecordCount = 0 then
  Begin
    TCustomMessage.Show('O.S. inválida.', 'Atenção!', TTypeMessage.Exclamation, TButtons.Ok);
    Exit;
  End;

  DataSource := TDataSource.Create(Self);
  DataSource.DataSet := DataSet;
  ppDBEnvelopeAzul.DataSource := DataSource;
  ppEnvelopeAzul.DeviceType := 'Printer';
  ppEnvelopeAzul.ShowPrintDialog := True;
  ppEnvelopeAzul.Print;
end;

function TFrCadOrdemServico.AplicMascaraTelefone(iTelefone:String):String;
begin
  if (Length(trim(iTelefone)) =10) then  //3732150000
  begin
    result := '(' + copy(iTelefone,1,2) + ')' + ' ' + Copy(iTelefone,3,4) + '-'  + Copy(iTelefone,7,4);
  end
  else if (Length(Trim(iTelefone)) = 12) then
    result := '(' + copy(iTelefone,1,2) + ')' + ' ' + Copy(iTelefone, 3,6) + '-' + Copy(iTelefone, 9,4)
  else if (Length(trim(iTelefone)) >10) then //37 32150000
   result := '(' + copy(iTelefone,1,2) + ')' + ' ' + Copy(iTelefone,3,5) + '-'  + Copy(iTelefone,8,4)
  else if (Length(trim(iTelefone)) =8) then //32150000
   result := '(  )' + ' ' + Copy(iTelefone,1,4) + '-'  + Copy(iTelefone,5,4)
  else if (Length(trim(iTelefone))=9) then //991990000
    result := '(  )' + ' ' + Copy(iTelefone,1,5) + '-'  + Copy(iTelefone,6,4);

end;

function TFrCadOrdemServico.AplicMascaraCep(iCep:String):STring;
begin
  if Trim(iCep)='' then
    result:= ''
  else if Length(iCep)=8 then
    result:= copy(iCep,1,2) + '.' + copy(iCep,3,3) + '-' + copy(iCep,6,3)
  else
    result:= iCep;
end;

procedure TFrCadOrdemServico.RatearDesconto();
var
  dDesconto, dDescTotal : Double;

begin
  _OrdemServico.cdsItens.First;
  while not _OrdemServico.cdsItens.EOF do
  begin
    dDesconto := _OrdemServico.Desconto *
                (_OrdemServico.cdsItens.FieldByName('ValorTotal').AsFloat /
                 _OrdemServico.ValorBrutoItens);
    if _OrdemServico.cdsItens.RecNo = _OrdemServico.cdsItens.RecordCount then
      dDesconto :=  _OrdemServico.Desconto - dDescTotal;
    dDescTotal := dDescTotal + dDesconto;
    _OrdemServico.cdsItens.Edit;
    _OrdemServico.cdsItens.FieldByName('DescontoRateado').AsFloat := dDesconto;
    _OrdemServico.cdsItens.Post;
    _OrdemServico.cdsItens.Next;
  end;

end;

procedure TFrCadOrdemServico.ItensSituacao(Setor : TSetor);
begin
  if Setor.Studio then
  begin
    cxCbSituacao.Properties.Items.Clear;
    cxCbSituacao.Properties.Items.Add('Aberta');
    cxCbSituacao.Properties.Items.Add('Entregue');
  end
  else
  begin
    cxCbSituacao.Properties.Items.Clear;
    cxCbSituacao.Properties.Items.Add('Aberta');
    cxCbSituacao.Properties.Items.Add('Fechada');
    cxCbSituacao.Properties.Items.Add('Entregue');
  end;
end;

procedure TFrCadOrdemServico.BindManual(Cliente : TPessoa);
begin
  _Cliente.Id := Cliente.Id;
  _Cliente.Nome := Cliente.Nome;
  _Cliente.CpfCnpj := Cliente.CpfCnpj;
  _Cliente.IE := Cliente.IE;
  _Cliente.RG := Cliente.RG;
  _Cliente.Telefone := Cliente.Telefone;
  _Cliente.Celular := Cliente.Celular;
  _Cliente.Endereco := Cliente.Endereco;
  _Cliente.Numero := Cliente.Numero;
  _Cliente.BairroId := Cliente.BairroId;
  _Cliente.Bairro := Cliente.Bairro;
  _Cliente.CidadeId := Cliente.CidadeId;
  _Cliente.Cidade := Cliente.Cidade;
  _Cliente.EstadoId := Cliente.EstadoId;
  _Cliente.EstadoAbreviatura := Cliente.EstadoAbreviatura;
  _Cliente.Estado := Cliente.Estado;
  _Cliente.Cep := Cliente.Cep;
  _Cliente.DescontoMaximo := Cliente.DescontoMaximo;
  _Cliente.Profissional := Cliente.Profissional;
  _Cliente.TabelaPreco := Cliente.TabelaPreco;
  _Cliente.PercComissao := Cliente.PercComissao;
  _Cliente.ConsumidorFinal := Cliente.ConsumidorFinal;
  _Cliente.Sexo := Cliente.Sexo;
  _Cliente.DataNasc := Cliente.DataNasc;
  _Cliente.Email := Cliente.Email;
  _Cliente.VendedorId := Cliente.VendedorId;
end;

procedure TFrCadOrdemServico.AtribuiVendedorPorCliente;
begin

end;





end.
