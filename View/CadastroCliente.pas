unit CadastroCliente;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxContainer, cxEdit, dxSkinsCore, dxSkinBlack,
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
  dxSkinXmas2008Blue, cxCheckBox, GetNum, Vcl.StdCtrls, Vcl.Buttons,
  Vcl.ExtCtrls, Vcl.Mask, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, Data.DB,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, Pessoa, Database, Usuario,
  BairroService, Bairro, Cidade, CidadeService, EnumPessoaTipo, ConsultaCepRepository, ConsultaCep, PessoaService;

type
  TFrCadastroCliente = class(TForm)
    lblNome: TLabel;
    lblDataNascimento: TLabel;
    lbSexo: TLabel;
    lblTelefone: TLabel;
    lbl2: TLabel;
    lbl3: TLabel;
    lbl4: TLabel;
    lbl5: TLabel;
    btnConsBairroCli: TSpeedButton;
    btnConsCidadeCli: TSpeedButton;
    lbl6: TLabel;
    lbl7: TLabel;
    lbl8: TLabel;
    lblCpfCnpj: TLabel;
    lbl12: TLabel;
    lbl13: TLabel;
    btnConsVend: TSpeedButton;
    lblLblEmail: TLabel;
    Label1: TLabel;
    lbl1: TLabel;
    edtNomeCliente: TEdit;
    edtDataNascimento: TMaskEdit;
    pnlBotoes: TPanel;
    BtnGravar: TBitBtn;
    BtnDesistir: TBitBtn;
    cbSexo: TComboBox;
    mktTelCliente: TMaskEdit;
    edtEnderecoCliente: TEdit;
    gnCodigoBairro: TGetNumber;
    edtBairroCliente: TEdit;
    mktCEPCliente: TMaskEdit;
    edtCidadeCliente: TEdit;
    gnCodigoCidade: TGetNumber;
    cbPessoaCliente: TComboBox;
    mktCgcCliente: TMaskEdit;
    edtInsDocCliente: TEdit;
    gnCodVendedor: TGetNumber;
    edtNomeVendedor: TEdit;
    edtEmail: TEdit;
    edtEstadoCliente: TEdit;
    btnBuscarCep: TBitBtn;
    cbxTipoInsc: TComboBox;
    gnCodigo: TGetNumber;
    mktCelular: TMaskEdit;
    edtNumero: TEdit;
    chkConsumidorFinal: TcxCheckBox;
    procedure BtnDesistirClick(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure btnConsBairroCliClick(Sender: TObject);
    procedure btnConsCidadeCliClick(Sender: TObject);
    procedure btnConsVendClick(Sender: TObject);
    procedure btnBuscarCepClick(Sender: TObject);
    procedure mktTelClienteExit(Sender: TObject);
    procedure mktCelularExit(Sender: TObject);
    procedure BtnGravarClick(Sender: TObject);
    procedure cbPessoaClienteClick(Sender: TObject);
  private
    { Private declarations }
    _Cliente : TPessoa;
    _PessoaService : TPessoaService;
    _Bairro : TBairro;
    _Cidade : TCidade;
    _Usuario : TUsuario;
    _Database : TDatabase;
    _Vendedor : TPessoa;
  public
    { Public declarations }
    Constructor Create(AOwner : TComponent; DataBase : TDataBase; Usuario : TUsuario);
    procedure ConsultaBairro();
    procedure ConsultaTodosBairros();
    procedure ConsultaCidade();
    procedure ConsultaTodasCidades();
    procedure ConsultaVendedor();
    procedure ConsultaTodosVendedores();
    function ValidarCampos() : Boolean;
    procedure Gravar();
    procedure AtribuiDados();
    function GetCliente(): TPessoa;

  end;

var
  FrCadastroCliente: TFrCadastroCliente;

implementation

uses FuncoesGerais;

{$R *.dfm}

procedure TFrCadastroCliente.btnBuscarCepClick(Sender: TObject);
var
  cepController : TConsultaCepRepository;
  consultaCep : TConsultaCep;
begin
  if Trim(mktCEPCliente.Text) <> ''  then
  begin
    cepController := TConsultaCepRepository.Create(_Database.CodigoEmpresa);
    try
      consultaCep := cepController.ConsultaCep(TFuncoesGerais.AnsiToAscii(mktCEPCliente.text), _Database);
      edtEnderecoCliente.Text := consultaCep.Endereco;
      gnCodigoCidade.Value := consultaCep.CodigoCidade;
      edtCidadeCliente.Text := consultaCep.NomeCidade;
      edtEstadoCliente.Text := consultaCep.Sigla;
      gnCodigoBairro.Value := consultaCep.CodigoBairro;
      edtBairroCliente.Text := consultaCep.Bairro;
      edtNumero.SetFocus();

      if _Bairro.Id = 0 then
      begin
        _Bairro.Id := ConsultaCep.CodigoBairro;
        _Bairro.Nome := ConsultaCep.Bairro;
        _Bairro.CodigoEmp := _Database.CodigoEmpresa;
      end;

      if _Cidade.Id = 0 then
      begin
        _Cidade.Id := ConsultaCep.CodigoCidade;
        _Cidade.Nome := consultaCep.NomeCidade;
        _Cidade.SiglaEstado := ConsultaCep.Sigla;
      end;

    except
      on e:exception do
      begin
//        TMsg.Msg('Ocorreu um erro', e.message, TTipo.Atencao);
        Application.Messagebox('Erro ao buscar o cep', 'Atenção!', MB_ICONEXCLAMATION);
      end;

    end;

  end;
end;

procedure TFrCadastroCliente.btnConsBairroCliClick(Sender: TObject);
begin
  ConsultaTodosBairros();
end;

procedure TFrCadastroCliente.btnConsCidadeCliClick(Sender: TObject);
begin
  ConsultaTodasCidades();
end;

procedure TFrCadastroCliente.btnConsVendClick(Sender: TObject);
begin
  ConsultaTodosVendedores();
end;

procedure TFrCadastroCliente.BtnDesistirClick(Sender: TObject);
begin
  Close();
end;

procedure TFrCadastroCliente.BtnGravarClick(Sender: TObject);
begin
  if ValidarCampos() then
  begin
    AtribuiDados();
    Gravar();
  end;
end;

procedure TFrCadastroCliente.cbPessoaClienteClick(Sender: TObject);
begin
  if cbPessoaCliente.ItemIndex = 0 then
  begin
    cbPessoaCliente.ItemIndex := 0;
    cbxTipoInsc.ItemIndex := 2;
    mktCgcCliente.EditMask := '!###\.###\.###\-##;0;_';    //'!##\.###\.###\/####\-##;0;_'; '!###\.###\.###\-##;0;_'
    mktCgcCliente.Text := '';
    cbSexo.ItemIndex := 1;
  end
  else
  begin
    cbPessoaCliente.ItemIndex := 1;
    cbxTipoInsc.ItemIndex := 0;
    mktCgcCliente.EditMask := '!##\.###\.###\/####\-##;0;_';
    mktCgcCliente.Text := '';
    cbSexo.ItemIndex := 0;
  end;

end;

Constructor TFrCadastroCliente.Create(AOwner : TComponent; Database : TDatabase; Usuario : TUsuario);
begin
  Inherited Create(AOWner);
  _Database := Database;
  _Usuario := Usuario;
  _PessoaService := TPessoaService.Create(_Usuario, _Database);
  _Cliente := TPessoa.Create();
  _Cliente.Id := TPessoaService.AutoIncremento();
  _Vendedor := TPessoa.Create();
  _Bairro := TBairro.Create();
  _Cidade := TCidade.Create();
  gnCodigo.Value := _Cliente.Id;
  Self.ShowModal();
end;


procedure TFrCadastroCliente.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if key = #13 then
  begin
    if ActiveControl = gnCodigoBairro then
    begin
      if gnCodigoBairro.Value <> 0 then
        ConsultaBairro()
      else
        ConsultaTodosBairros();
    end
    else if ActiveControl = gnCodigoCidade then
    begin
      if gnCodigoCidade.Value <> 0 then
        ConsultaCidade()
      else
        ConsultaTodasCidades();
    end
    else if ActiveControl = gnCodVendedor then
    begin
      if gnCodVendedor.Value <> 0 then
        ConsultaVendedor()
      else
        ConsultaTodosVendedores();
    end;

    Key := #0;
    Perform(WM_NEXTDLGCTL, 0, 0);
  end;
end;

procedure TFrCadastroCliente.mktCelularExit(Sender: TObject);
begin
  mktCelular.Text := TFuncoesGerais.AplicaMascaraTelefone(mktCelular.Text);
end;

procedure TFrCadastroCliente.mktTelClienteExit(Sender: TObject);
begin
  mktTelCliente.Text := TFuncoesGerais.AplicaMascaraTelefone(mktTelCliente.Text);
end;

procedure TFrCadastroCliente.ConsultaBairro();
begin
  _Bairro.Id := Trunc(gnCodigoBairro.Value);
  TBairroService.ConsultaBairro(_Database, _Bairro);
  if _Bairro.Id <> 0 then
  begin
    gnCodigoBairro.Value := _Bairro.Id;
    edtBairroCliente.Text := _Bairro.Nome;
  end;
end;

procedure TFrCadastroCliente.ConsultaTodosBairros();
begin
  TBairroService.TelaConsultaBairro(_Database, _Bairro);
  if _Bairro.Id <> 0 then
  begin
    gnCodigoBairro.Value := _Bairro.Id;
    edtBairroCliente.Text := _Bairro.Nome;
  end
  else
    gnCodigoBairro.SetFocus();
end;

procedure TFrCadastroCliente.ConsultaCidade();
begin
  _Cidade.Id := Trunc(gnCodigoCidade.Value);
  TCidadeService.ConsultaCidade(_Database, _Cidade);
  if _Cidade.Id <> 0 then
  begin
    gnCodigoCidade.Value := _Cidade.Id;
    edtCidadeCliente.Text := _Cidade.Nome;
  end;
end;

procedure TFrCadastroCliente.ConsultaTodasCidades();
begin
  TCidadeService.TelaConsultaCidade(_Database, _Cidade);
  if _Cidade.Id <> 0 then
  begin
    gnCodigoCidade.Value := _Cidade.Id;
    edtCidadeCliente.Text := _Cidade.Nome;
    edtEstadoCliente.Text := _Cidade.SiglaEstado;
  end
  else
    gnCodigoCidade.SetFocus();
end;

procedure TFrCadastroCliente.ConsultaVendedor();
begin
  _Vendedor.Id := Trunc(gnCodVendedor.Value);
  TPessoaService.ConsultaPessoa(_DataBase ,_Vendedor, (False), TEnumPessoaTipo.Vendedor);
  if _Vendedor.Id <> 0 then
  begin
    gnCodVendedor.Value := _Vendedor.Id;
    edtNomeVendedor.Text := _Vendedor.Nome;
  end;
end;

procedure TFrCadastroCliente.ConsultaTodosVendedores();
begin
  TPessoaService.TelaConsultaPessoa(_DataBase, _Vendedor, TEnumPessoaTipo.Vendedor);
  if _Vendedor.Id <> 0 then
  begin
    gnCodVendedor.Value := _Vendedor.Id;
    edtNomeVendedor.Text := _Vendedor.Nome;
  end
  else
    gnCodVendedor.SetFocus();
end;

function TFrCadastroCliente.ValidarCampos():Boolean;
var Data : TDatetime;
begin
  Result := True;
  if edtNomeCliente.Text = '' then
  begin
    Application.Messagebox('Nome do cliente não pode ser vazio!', 'Atenção!', MB_ICONEXCLAMATION);
    edtNomeCliente.SetFocus();
    Result := False;
  end
  else if mktCgcCliente.Text = '' then
  begin
    Application.Messagebox('CGC do cliente não pode ser vazio!', 'Atenção!', MB_ICONEXCLAMATION);
    mktCgcCliente.SetFocus();
    Result := False;
  end;
end;

procedure TFrCadastroCliente.Gravar();
begin
  TPessoaService.Gravar(_Cliente, _Database);
  TPessoaService.GravarLog(_Cliente, _Database, _Usuario, _Cidade);
  Application.MessageBox('Cliente gravado com sucesso!', 'Atenção!', MB_ICONEXCLAMATION);
  Close();
end;

procedure TFrCadastroCliente.AtribuiDados();
var Data : TDatetime;
begin

  _Cliente.Id := Trunc(gnCodigo.Value);
  _Cliente.Nome := edtNomeCliente.Text;
  _Cliente.ConsumidorFinal := chkConsumidorFinal.Checked;
  _Cliente.CpfCnpj := TFuncoesGerais.RetiraCaracteresEspeciais(mktCgcCliente.Text);

  if cbSexo.ItemIndex = 1 then
    _Cliente.Sexo := 'M'
  else if cbSexo.ItemIndex = 2 then
    _Cliente.Sexo := 'F'
  else
    _Cliente.Sexo := '';

  if cbPessoaCliente.ItemIndex = 0 then
    _Cliente.RG := edtInsDocCliente.Text
  else
    _Cliente.IE := edtInsDocCliente.Text;

  _Cliente.Telefone := TFuncoesGerais.RetiraCaracteresEspeciais(mktTelCliente.Text);
  _Cliente.Celular := TFuncoesGerais.RetiraCaracteresEspeciais(mktCelular.Text);
  _Cliente.Cep := mktCepCliente.Text;
  _Cliente.Endereco := edtEnderecoCliente.Text;
  _Cliente.Numero := edtNumero.Text;
  _Cliente.BairroId := _Bairro.Id;
  _Cliente.Bairro := _Bairro.Nome;
  _Cliente.CidadeId := _Cidade.Id;
  _Cliente.Cidade := _Cidade.Nome;
  _Cliente.EstadoId := _Cidade.EstadoId;
  _Cliente.Estado := _Cidade.Estado;
  _Cliente.EstadoAbreviatura := _Cidade.SiglaEstado;
  _Cliente.VendedorId := _Vendedor.Id;
  _Cliente.Email := edtEmail.Text;
  if TryStrToDatetime(edtDataNascimento.Text, Data) then
    _Cliente.DataNasc := Data;

end;

function TFrCadastroCliente.GetCliente():TPessoa;
begin
  Result := _Cliente;
end;


end.
