unit Consulta_Cidade;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Consulta_Padrao, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, cxStyles, dxSkinsCore, dxSkinBlack,
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
  dxSkinXmas2008Blue, cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit,
  cxNavigator, cxDataControllerConditionalFormattingRulesManagerDialog, Data.DB,
  cxDBData, Vcl.StdCtrls, Vcl.Buttons, Vcl.ExtCtrls, cxGridLevel, cxClasses,
  cxGridCustomView, cxGridCustomTableView, cxGridTableView, cxGridDBTableView,
  cxGrid, Cidade, CidadeRepository, Database;

type
  TFrConsulta_Cidade = class(TFrConsulta_Padrao)
    cxGridLvVwCodigo: TcxGridDBColumn;
    cxGridLvVwDescricao: TcxGridDBColumn;
    cxGridLvVwEstado: TcxGridDBColumn;
    cxGridLvVwIBGE: TcxGridDBColumn;
  private
    { Private declarations }
    _Cidade : TCidade;
  protected
    Procedure Atualizar(); OverRide;
  public
    { Public declarations }
    property Cidade : TCidade Read _Cidade;
    Constructor Create(AOwner : TComponent; DataBase : TDataBase; Cidade : TCidade);
  end;

var
  FrConsulta_Cidade: TFrConsulta_Cidade;

implementation

{$R *.dfm}

Constructor TFrConsulta_Cidade.Create(AOwner : TComponent; DataBase : TDataBase; Cidade : TCidade);
Begin
  Inherited Create(AOwner, Database);
  _Cidade := Cidade;
  _DataSet := TDataSet.Create(Self);
  _DataSet := TCidadeRepository.GetAll(_DataBase);
  _DataSource := TDataSource.Create(Self);
  _DataSource.DataSet := _DataSet;
  cxGridLvVw.DataController.DataSource := _DataSource;
  Self.ShowModal();
End;

Procedure TFrConsulta_Cidade.Atualizar();
Begin
  TCidadeRepository.DataSetToCidade(cxGridLvVw.DataController.DataSource.DataSet, _Cidade);
  Inherited;
End;

end.
