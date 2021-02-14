unit Login;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  DataBase, Usuario,
  System.Bindings.Helper,
  Vcl.ExtCtrls, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxContainer, cxEdit, cxLabel, cxTextEdit, Vcl.StdCtrls,
  Vcl.Buttons, cxCheckBox, dxSkinsCore, dxSkinBlack, dxSkinBlue,
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
  dxSkinXmas2008Blue;

type
  TFrLogin = class(TForm)
    imgSair2: TImage;
    Logo: TImage;
    lblUsuario: TcxLabel;
    lblSenha: TcxLabel;
    lblNomeModulo: TcxLabel;
    lblDescVersao: TcxLabel;
    lblVersao: TcxLabel;
    edtUsuario: TcxTextEdit;
    edtSenha: TcxTextEdit;
    OkBtn: TBitBtn;
    ChkLembrarMe: TcxCheckBox;
    lblData: TcxLabel;
    procedure imgSair2Click(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure OkBtnClick(Sender: TObject);
    Procedure BindingChanged(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    _Authorized : Boolean;
    _CodigoEmpresa : Integer;
    _DataBase : TDataBase;
    _Usuario : TUsuario;


    Procedure CarregarLembrarMe();
    Procedure GravarLembrarMe();
  public
    { Public declarations }
    Property Authorized : Boolean Read _Authorized;
    Property CodigoEmpresa : Integer Read _CodigoEmpresa;

    Constructor Create(AOwner : TComponent;Usuario : TUsuario; Versao : String; DataBase : TDataBase);
  end;

var
  FrLogin: TFrLogin;

implementation

Uses
  ConexaoBanco, EnumConexao, UsuarioService, System.IniFiles;

{$R *.dfm}

Constructor TFrLogin.Create(AOwner : TComponent; Usuario : TUsuario; Versao : String; DataBase : TDataBase);
{$Region 'Binding'}
  Procedure Binding();
  Begin

    Self._Usuario.Bind('Nome', edtUsuario, 'Text');
    Self._Usuario.Bind('Senha', edtSenha, 'Text');
  End;
{$EndRegion}
Begin
  Inherited Create(AOwner);
  Self._DataBase := DataBase;
  Self._Authorized := False;
  Self._Usuario := Usuario;
  Self.lblVersao.Caption := Versao;
  Self.lblData.Caption := FormatDateTime('DD/MM/YYYY', Now);
  Binding();
End;

Procedure TFrLogin.BindingChanged(Sender: TObject);
Var
  TypeBinding: String;
Begin
  if (Sender is TcxTextEdit) then
    TypeBinding := 'Text';
  TBindings.Notify(Sender, TypeBinding);
End;

procedure TFrLogin.FormKeyPress(Sender: TObject; var Key: Char);
begin
  {$Region 'Enter'}
  if (key = #13) then
  Begin
    key := #0;
    Perform(Wm_NextDlgCtl, 0, 0);
  End;
  {$EndRegion}
end;

procedure TFrLogin.FormShow(Sender: TObject);
begin
  CarregarLembrarMe();
end;

procedure TFrLogin.imgSair2Click(Sender: TObject);
begin
  Close();
end;

procedure TFrLogin.OkBtnClick(Sender: TObject);
begin
  if ( Not TUsuarioService.VerificaUsuario(_DataBase, _Usuario) ) then
  begin
    edtUsuario.SetFocus();
    Exit;
  End;

  _Authorized := True;
  _CodigoEmpresa := _Usuario.CodigoEmpresaPadrao;

  GravarLembrarMe();

  Self.Close();
end;

Procedure TFrLogin.CarregarLembrarMe();
Var
  iniAlias: TIniFile;
Begin
  try
    iniAlias:= TIniFile.Create(ExtractFileDrive(Application.ExeName) + '\Sge32\login.ini');
    _Usuario.Nome :=iniAlias.ReadString('login', 'ORDEMSERVICO', '');
    if _Usuario.Nome <> '' then
    begin
      edtSenha.SetFocus();
      if (_Usuario.Nome = 'MASTER') and (DebugHook <>0) then
        _Usuario.Senha := 'MAISSOL';
      ChkLembrarMe.Checked:=true;
    end
    else
      ChkLembrarMe.Checked:=false;
    iniAlias.Free;
  except
  end;
End;

Procedure TFrLogin.GravarLembrarMe();
Var
  iniAlias: TIniFile;
begin
  try
    iniAlias:= TIniFile.Create(ExtractFileDrive(Application.ExeName) + '\Sge32\login.ini');
    if ChkLembrarMe.Checked
    then
      iniAlias.WriteString('login', 'ORDEMSERVICO', _Usuario.Nome)
    else
      iniAlias.WriteString('login', 'ORDEMSERVICO', '');
    iniAlias.Free;
  except
  end;
end;


end.
