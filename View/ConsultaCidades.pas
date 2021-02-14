unit ConsultaCidades;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxStyles, dxSkinsCore, dxSkinBlack, dxSkinBlue,
  dxSkinBlueprint, dxSkinCaramel, dxSkinCoffee, dxSkinDarkRoom, dxSkinDarkSide,
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
  dxSkinXmas2008Blue, cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit,
  cxNavigator, cxDataControllerConditionalFormattingRulesManagerDialog, Data.DB,
  cxDBData, Vcl.StdCtrls, Vcl.Buttons, Vcl.ExtCtrls, cxGridLevel,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxClasses,
  cxGridCustomView, cxGrid, Consulta_Padrao;

type
  TFrConsultaCidades = class(TFrConsulta_Padrao)
    cxGrid: TcxGrid;
    cxGridLvVw: TcxGridDBTableView;
    cxGridLvVwId: TcxGridDBColumn;
    cxGridLvVwNome: TcxGridDBColumn;
    cxGridLvVwCpfCnpj: TcxGridDBColumn;
    cxGridLvVwTelefone: TcxGridDBColumn;
    cxGridLvVwCelular: TcxGridDBColumn;
    cxGridLvVwEndereço: TcxGridDBColumn;
    cxGridLvVwNumero: TcxGridDBColumn;
    cxGridLvVwBairroId: TcxGridDBColumn;
    cxGridLvVwBairro: TcxGridDBColumn;
    cxGridLvVwCidadeId: TcxGridDBColumn;
    cxGridLvVwCidade: TcxGridDBColumn;
    cxGridLvVwEstadoId: TcxGridDBColumn;
    cxGridLvVwEstadoAbreviatura: TcxGridDBColumn;
    cxGridLvVwEstado: TcxGridDBColumn;
    cxGridLv: TcxGridLevel;
    pnlBotoes: TPanel;
    BtnDesistir: TBitBtn;
    btnAtualizar: TBitBtn;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrConsultaCidades: TFrConsultaCidades;

implementation

{$R *.dfm}

end.
