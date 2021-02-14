unit Consulta_Pessoa;

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
  DataBase, PessoaRepository, EnumPessoaTipo, Pessoa, dxSkinsCore, dxSkinBlack,
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
  TFrConsulta_Pessoa = class(TFrConsulta_Padrao)
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
  private
    { Private declarations }
    _Pessoa : TPessoa;
  protected
    Procedure Atualizar(); OverRide;
  public
    { Public declarations }

    Property Pessoa : TPessoa Read _Pessoa;

    Constructor Create(AOwner : TComponent; DataBase : TDataBase; Pessoa : TPessoa; PessoaTipo : TEnumPessoaTipo = TEnumPessoaTipo.Todos);
  end;

var
  FrConsulta_Pessoa: TFrConsulta_Pessoa;

implementation

{$R *.dfm}

Constructor TFrConsulta_Pessoa.Create(AOwner : TComponent; DataBase : TDataBase; Pessoa : TPessoa; PessoaTipo : TEnumPessoaTipo = TEnumPessoaTipo.Todos);
Begin
  Inherited Create(AOwner, DataBase);
  _Pessoa := Pessoa;
  _DataSet := TDataSet.Create(Self);
  _DataSet := TPessoaRepository.GetAll(_DataBase, PessoaTipo);
  _DataSource := TDataSource.Create(Self);
  _DataSource.DataSet := _DataSet;
  cxGridLvVw.DataController.DataSource := _DataSource;
  Self.ShowModal();
End;

Procedure TFrConsulta_Pessoa.Atualizar();
Begin
  TPessoaRepository.DataSetToPessoa(cxGridLvVw.DataController.DataSource.DataSet, _Pessoa);
  Inherited;
End;

end.
