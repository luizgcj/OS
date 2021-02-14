unit ParametrosOS;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, cxGraphics, cxControls, cxLookAndFeels,
  Parametros, cxLookAndFeelPainters, cxContainer, cxEdit, dxSkinsCore, dxSkinBlack,
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
  dxSkinXmas2008Blue, cxTextEdit, cxCurrencyEdit, Vcl.StdCtrls, Vcl.ExtCtrls,
  DataBase, Vcl.Buttons;

type
  TFrParametrosOS = class(TForm)
    Panel2: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    curPercMinSinalAmador: TcxCurrencyEdit;
    curPercMinSinalProfissional: TcxCurrencyEdit;
    Panel1: TPanel;
    btnSair: TBitBtn;
    procedure curPercMinSinalAmadorPropertiesChange(Sender: TObject);
    procedure curPercMinSinalProfissionalPropertiesChange(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure GenericCurrencyClick(Sender: TObject);
    procedure btnSairClick(Sender: TObject);
  private
    { Private declarations }
    _DataBase : TDataBase;
  public
    { Public declarations }
    Constructor Create(AOwner : TComponent; DataBase : TDataBase);

  end;

var
  FrParametrosOS: TFrParametrosOS;

implementation

{$R *.dfm}

procedure TFrParametrosOS.btnSairClick(Sender: TObject);
begin
  Close;
end;

Constructor TFrParametrosOS.Create(AOwner : TComponent; DataBase : TDataBase);
Begin
  Inherited Create(AOwner);
  _DataBase := DataBase;
  ShowModal();
End;


procedure TFrParametrosOS.curPercMinSinalAmadorPropertiesChange(Sender: TObject);
begin
  TParametros.GravarParametros('PERCMINSINALAMADOROS', 'D', 'PERCENTUAL MINIMO DE SINAL PARA CLIENTE AMADOR', curPercMinSinalAmador.Value, _DataBase);
end;

procedure TFrParametrosOS.curPercMinSinalProfissionalPropertiesChange(
  Sender: TObject);
begin
  TParametros.GravarParametros('PERCMINSINALPROFISSIONALOS', 'D', 'PERCENTUAL MINIMO DE SINAL PARA CLIENTE PROFISSIONAL', curPercMinSinalProfissional.Value, _DataBase);
end;

procedure TFrParametrosOS.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if key = #27 then
    Close;

  if key = #13 then
  begin
    Key := #0;
    Perform(WM_NEXTDLGCTL,0,0);
  end;
end;

procedure TFrParametrosOS.FormShow(Sender: TObject);
begin
  curPercMinSinalAmador.Value := StrToFloat(TParametros.VerificaParametros('PERCMINSINALAMADOROS','D',_DataBase));
  curPercMinSinalProfissional.Value := StrToFloat(TParametros.VerificaParametros('PERCMINSINALPROFISSIONALOS','D',_DataBase));
end;

Procedure TFrParametrosOS.GenericCurrencyClick(Sender: TObject);
Begin
  if (Sender is TcxCurrencyEdit) then
    (Sender as TcxCurrencyEdit).SelectAll();
End;

end.
