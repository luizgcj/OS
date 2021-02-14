unit Consulta_Setor;

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
  DataBase, SetorRepository, EnumPessoaTipo, Setor, dxSkinsCore, dxSkinBlack,
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
  TFrConsulta_Setor = class(TFrConsulta_Padrao)
    cxGridLvVwId: TcxGridDBColumn;
    cxGridLvVwNome: TcxGridDBColumn;
    procedure cxGridLvVwDblClick(Sender: TObject);
  private
    { Private declarations }
    _Setor : TSetor;

  protected
    Procedure Atualizar(); OverRide;
  public
    { Public declarations }


    Property Setor : TSetor Read _Setor;

    Constructor Create(AOwner : TComponent; DataBase : TDataBase; Setor : TSetor);
  end;

var
  FrConsulta_Setor: TFrConsulta_Setor;

implementation

{$R *.dfm}

Constructor TFrConsulta_Setor.Create(AOwner : TComponent; DataBase : TDataBase; Setor : TSetor);
Begin
  Inherited Create(AOwner, DataBase);
  _Setor   := Setor;
  _DataSet := TDataSet.Create(Self);
  _DataSet := TSetorRepository.GetAll(_DataBase);
  _DataSource := TDataSource.Create(Self);
  _DataSource.DataSet := _DataSet;
  cxGridLvVw.DataController.DataSource := _DataSource;
  Self.ShowModal();
End;

procedure TFrConsulta_Setor.cxGridLvVwDblClick(Sender: TObject);
begin
  inherited;
  Atualizar();
end;

Procedure TFrConsulta_Setor.Atualizar();
Begin
  TSetorRepository.DataSetToSetor(cxGridLvVw.DataController.DataSource.DataSet, _Setor);
  Inherited;
End;



end.
