unit PermissaoUsuario;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  DataBase, Usuario, UsuarioRepository,
  System.Bindings.Helper, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxContainer, cxEdit, cxTextEdit, cxLabel, Vcl.ExtCtrls,
  Vcl.StdCtrls, Vcl.Buttons, Vcl.ComCtrls, dxCore, cxDateUtils, cxMaskEdit,
  cxDropDownEdit, cxCalendar, cxCurrencyEdit, dxSkinsCore, dxSkinBlack,
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
  TFrPermissaoUsuario = class(TForm)
    pnlFundo: TPanel;
    cxLabel1: TcxLabel;
    edtNome: TcxTextEdit;
    cxLabel2: TcxLabel;
    edtSenha: TcxTextEdit;
    OkBtn: TBitBtn;
    procedure OkBtnClick(Sender: TObject);
    Procedure Binding(Sender : TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
    _DataBase : TDataBase;
    _UsuarioLogado : TUsuario;
    _UsuarioPermissao : TUsuario;
    _Permissao : String;
    _TipoPermissao : TPermissaoUsuario;
    _Autorizado : Boolean;

    Procedure Confirmar();
  public
    { Public declarations }
    Property Autorizado : Boolean Read _Autorizado;


    Constructor Create(AOwner : TComponent; DataBase : TDataBase; Usuario : TUsuario; Permissao : String; TipoPermissao : TPermissaoUsuario = Generica);
  end;

var
  FrPermissaoUsuario: TFrPermissaoUsuario;

implementation

{$R *.dfm}

Uses
  CustomMessage;

Constructor TFrPermissaoUsuario.Create(AOwner : TComponent; DataBase : TDataBase; Usuario : TUsuario; Permissao : String; TipoPermissao : TPermissaoUsuario = Generica);
  {$Region 'BindingField'}
  Procedure BindingField();
  Begin
    _UsuarioPermissao.Bind('Nome', edtNome, 'Text');
    _UsuarioPermissao.Bind('Senha', edtSenha, 'Text');

    edtNome.Properties.OnChange := Binding;
    edtSenha.Properties.OnChange := Binding;
  End;
  {$EndRegion}
Begin
  Inherited Create(Aowner);
  _Autorizado := False;
  _DataBase := DataBase;
  _UsuarioLogado := Usuario;
  _UsuarioPermissao := TUsuario.Create(Usuario);
  _Permissao := Permissao;
  _TipoPermissao := TipoPermissao;

  _Autorizado := TUsuarioRepository.VerificaPermissao(_DataBase, _UsuarioPermissao, _Permissao, _TipoPermissao);
  _UsuarioPermissao.Nome := '';
  BindingField();
End;

procedure TFrPermissaoUsuario.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  _UsuarioPermissao.Nome := '';
end;

procedure TFrPermissaoUsuario.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if (key = #13) then
  Begin

    Key := #0;
    Perform(WM_NEXTDLGCTL,0,0);
  End;
end;

{$Region 'Binding'}
Procedure TFrPermissaoUsuario.Binding(Sender : TObject);
Var
  TypeBinding: String;
Begin
  if (Sender is TcxTextEdit) then
    TypeBinding := 'Text';
  if (Sender is TcxDateEdit) then
    TypeBinding := 'Date';
  if (Sender is TcxCurrencyEdit) then
      TypeBinding := 'Value';
  TBindings.Notify(Sender, TypeBinding);
End;
{$EndRegion}

procedure TFrPermissaoUsuario.OkBtnClick(Sender: TObject);
begin
  Confirmar();
end;

Procedure TFrPermissaoUsuario.Confirmar();
Begin
  TUsuarioRepository.VerificaUsuario(_UsuarioPermissao, _DataBase);
  if TUsuarioRepository.VerificaUsuario(_UsuarioPermissao, _DataBase) then
  begin
    _Autorizado := TUsuarioRepository.VerificaPermissao(_DataBase, _UsuarioPermissao, _Permissao, _TipoPermissao);
    if _Autorizado then
      Close()
    else
    Begin
      TCustomMessage.Show('Usuario não autorizado.','Atenção', TTypeMessage.Exclamation, TButtons.Ok);
      edtNome.SetFocus();
    End;
  end
  else
  begin
    TCustomMessage.Show('Usuario ou senha incorreto.','Atenção', TTypeMessage.Exclamation, TButtons.Ok);
    edtNome.SetFocus();
  end;
End;

end.
