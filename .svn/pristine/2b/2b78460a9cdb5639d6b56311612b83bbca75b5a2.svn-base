unit Consulta_Bairro;

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
  cxGrid, Bairro, BairroRepository, Database;

type
  TFrConsulta_Bairro = class(TFrConsulta_Padrao)
    cxGridLvVwId: TcxGridDBColumn;
    cxGridLvVwNome: TcxGridDBColumn;
    cxGridLvVwCodigoEmp: TcxGridDBColumn;
  private
    { Private declarations }
    _Bairro : TBairro;
  protected
    Procedure Atualizar(); OverRide;
  public
    { Public declarations }
    property Bairro : TBairro Read _Bairro;
    Constructor Create(AOwner : TComponent; DataBase : TDataBase; Bairro : TBairro);
  end;

var
  FrConsulta_Bairro: TFrConsulta_Bairro;

implementation

{$R *.dfm}

Constructor TFrConsulta_Bairro.Create(AOwner : TComponent; DataBase : TDataBase; Bairro : TBairro);
Begin
  Inherited Create(AOwner, Database);
  _Bairro := Bairro;
  _DataSet := TDataSet.Create(Self);
  _DataSet := TBairroRepository.GetAll(_DataBase);
  _DataSource := TDataSource.Create(Self);
  _DataSource.DataSet := _DataSet;
  cxGridLvVw.DataController.DataSource := _DataSource;
  Self.ShowModal();
End;

Procedure TFrConsulta_Bairro.Atualizar();
Begin
  TBairroRepository.DataSetToBairro(cxGridLvVw.DataController.DataSource.DataSet, _Bairro);
  Inherited;
End;

end.
