unit Consulta_FormaPagamento;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Consulta_Padrao, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter,
  cxData, cxDataStorage, cxEdit, cxNavigator,
  cxDataControllerConditionalFormattingRulesManagerDialog, Data.DB, cxDBData,
  Vcl.StdCtrls, Vcl.Buttons, Vcl.ExtCtrls, cxGridLevel, cxClasses,
  cxGridCustomView, cxGridCustomTableView, cxGridTableView, cxGridDBTableView,
  cxGrid,
  DataBase, FormaPagamento, FormaPagamentoRepository, dxSkinsCore, dxSkinBlack,
  dxSkinBlue, dxSkinBlueprint, dxSkinCaramel, dxSkinCoffee, dxSkinDarkRoom,
  dxSkinDarkSide, dxSkinDevExpressDarkStyle, dxSkinDevExpressStyle, dxSkinFoggy,
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
  dxSkinXmas2008Blue;

type
  TFrConsulta_FormaPagamento = class(TFrConsulta_Padrao)
    cxGridLvVwId: TcxGridDBColumn;
    cxGridLvVwNome: TcxGridDBColumn;
    cxGridLvVwCartao: TcxGridDBColumn;
    cxGridLvVwCheque: TcxGridDBColumn;
    cxGridLvVwEnviaMaisCaixa: TcxGridDBColumn;
  private
    { Private declarations }
    _FormaPagamento : TFormaPagamento;
    Procedure Atualizar(); OverRide;
  public
    { Public declarations }
    Constructor Create(AOwner : TComponent; DataBase : TDataBase; FormaPagamento : TFormaPagamento);
  end;

var
  FrConsulta_FormaPagamento: TFrConsulta_FormaPagamento;

implementation

{$R *.dfm}

Constructor TFrConsulta_FormaPagamento.Create(AOwner : TComponent; DataBase : TDataBase; FormaPagamento : TFormaPagamento);
Begin
  Inherited Create(AOwner, DataBase);
  _FormaPagamento := FormaPagamento;
  _DataSet := TDataSet.Create(Nil);
  _DataSet := TFormaPagamentoRepository.GetAll(DataBase);

  _DataSource := TDataSource.Create(Nil);
  _DataSource.DataSet := _DataSet;
  cxGridLvVw.DataController.DataSource := _DataSource;
  Self.ShowModal();
End;

Procedure TFrConsulta_FormaPagamento.Atualizar();
Begin
  TFormaPagamentoRepository.DataSetToFormaPagamento(cxGridLvVw.DataController.DataSource.DataSet, _FormaPagamento);
  Inherited;
End;

end.
