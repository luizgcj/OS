unit FechamentoOS;

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
  dxSkinXmas2008Blue, Vcl.ComCtrls, dxCore, cxDateUtils, Vcl.StdCtrls,
  Vcl.Buttons, cxLabel, Vcl.ExtCtrls, cxMaskEdit, cxDropDownEdit, cxCalendar,
  cxTextEdit, cxCurrencyEdit, FireDac.Comp.Client, ConexaoBanco,
  EnumConexao, DataBase, Data.Db, Pessoa, EnumPessoaTipo;

type
  TFrFechamentoOS = class(TForm)
    Label1: TLabel;
    curNumEnvelope: TcxCurrencyEdit;
    GroupBox1: TGroupBox;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    curNumOS: TcxCurrencyEdit;
    edtCliente: TcxTextEdit;
    curDataEmissao: TcxDateEdit;
    Panel1: TPanel;
    cxLabel1: TcxLabel;
    curFuncLabId: TcxCurrencyEdit;
    edtFuncLab: TcxTextEdit;
    btnConsultaFuncLab: TSpeedButton;
    btnFecharOS: TBitBtn;
    btnSair: TBitBtn;
    btnConsulta: TBitBtn;
    procedure btnSairClick(Sender: TObject);
    procedure btnFecharOSClick(Sender: TObject);
    procedure btnConsultaClick(Sender: TObject);
    procedure btnConsultaFuncLabClick(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
    _DataBase : TDataBase;
    _Funcionario : TPessoa;
    Function ValidaFuncionarioLaboratorio(Gravacao : Boolean = False) : Boolean;
    procedure LimparCampos();
  public
    { Public declarations }
    function VerificaEnvelope(numEnvelope : Integer;out DataSet : TDataSet):Boolean;
    Constructor Create(AOwner : TComponent; DataBase : TDataBase);
  end;

var
  FrFechamentoOS: TFrFechamentoOS;

implementation

{$R *.dfm}

uses PessoaService;

Constructor TFrFechamentoOS.Create(AOwner : TComponent; DataBase : TDataBase);
Begin
  Inherited Create(AOwner);
  _DataBase := DataBase;
  _Funcionario := TPessoa.Create();
  ShowModal();
End;

procedure TFrFechamentoOS.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if key = #13 then
  begin
    if ActiveControl = curFuncLabId.ActiveControl then
    begin
      if curFuncLabId.Value <> 0 then
        _Funcionario.Id := Trunc(curFuncLabId.Value);
      if (Not ValidaFuncionarioLaboratorio() ) then
        Exit
      else
      begin
        btnFecharOS.SetFocus;
        Exit;
      end;

    end;
    Key := #0;
    Perform(WM_NEXTDLGCTL,0,0);
  end;
end;

procedure TFrFechamentoOS.btnConsultaClick(Sender: TObject);
var
  DataSet : TDataSet;
begin
  if curNumEnvelope.Value = 0 then
  begin
    Application.MessageBox('Número do envelope inválido.','Atenção',MB_ICONEXCLAMATION);
    curNumEnvelope.SetFocus;
    Exit;
  end;
  if VerificaEnvelope(Trunc(curNumEnvelope.Value),DataSet) then
  begin
    if DataSet.FieldByName('SITUACAOOS').AsString <> 'A' then
    begin
      Application.MessageBox('Ordem de Serviço já foi fechada.','Atenção',MB_ICONEXCLAMATION);
      curNumEnvelope.SetFocus;
      Exit;
    end;
    curNumOS.Value := DataSet.FieldByName('NUMOS').AsInteger;
    curDataEmissao.Date := DataSet.FieldByName('DATAENT').AsDateTime;
    edtCliente.Text := DataSet.FieldByName('PESSOANOME').AsString;
  end;
  curFuncLabId.SetFocus;
end;

procedure TFrFechamentoOS.btnConsultaFuncLabClick(Sender: TObject);
begin
  TPessoaService.TelaConsultaPessoa(_DataBase, _Funcionario, TEnumPessoaTipo.Funcionario);
  curFuncLabId.SetFocus();
  if (_Funcionario.Id = 0) then
    curFuncLabId.SelectAll()
  else
  begin
    curFuncLabId.Value := _Funcionario.Id;
    edtFuncLab.Text := _Funcionario.Nome;
  end;
end;

procedure TFrFechamentoOS.btnFecharOSClick(Sender: TObject);
Var
  ConexaoBanco : TConexaoBanco;
  DataSet : TDataSet;
begin
  if curNumEnvelope.Value = 0 then
  begin
    Application.MessageBox('Número do envelope inválido.','Atenção',MB_ICONEXCLAMATION);
    curNumEnvelope.SetFocus;
    Exit;
  end
  else
  begin
    if not VerificaEnvelope(Trunc(curNumEnvelope.Value),DataSet) then
    begin
      Application.MessageBox('Número do envelope inválido.','Atenção',MB_ICONEXCLAMATION);
      curNumEnvelope.SetFocus;
      Exit;
    end
    else
    begin
      if DataSet.FieldByName('SITUACAOOS').AsString <> 'A' then
      begin
        Application.MessageBox('Ordem de Serviço já foi fechada.','Atenção',MB_ICONEXCLAMATION);
        curNumEnvelope.SetFocus;
        Exit;
      end
      else
      begin
        curNumOS.Value := DataSet.FieldByName('NUMOS').AsInteger;
        curDataEmissao.Date := DataSet.FieldByName('DATAENT').AsDateTime;
        edtCliente.Text := DataSet.FieldByName('PESSOANOME').AsString;
      end;
    end;
  end;
  if (Not ValidaFuncionarioLaboratorio() ) then
  Begin
    Application.MessageBox('Funcionário inválido.','Atenção',MB_ICONEXCLAMATION);
    curFuncLabId.SetFocus;
    Exit;
  End;

  ConexaoBanco := TConexaoBanco.Create(_DataBase);
  ConexaoBanco.SQL.Add('UPDATE OS SET SITUACAOOS = ''F'', CODFECHA = :CODIGO, DATAFECHA = :DATA, HORAFECHA = :HORA');
  ConexaoBanco.SQL.Add('WHERE NUMOS = :NUMOS AND CODIGOEMP = :CODIGOEMP');
  ConexaoBanco.Param.ParamByName('CODIGO').AsInteger := Trunc(curFuncLabId.Value);
  ConexaoBanco.Param.ParamByName('DATA').AsDateTime := Date;
  ConexaoBanco.Param.ParamByName('HORA').AsDateTime := Time;
  ConexaoBanco.Param.ParamByName('NUMOS').AsInteger := Trunc(curNumOS.Value);
  ConexaoBanco.Param.ParamByName('CODIGOEMP').AsInteger := _DataBase.CodigoEmpresa;
  ConexaoBanco.DataSetFactory.PostDataSet(TConexao.Empresa, ConexaoBanco.sql.Text , ConexaoBanco.Param);
  Application.MessageBox('Ordem de Serviço fechada com sucesso!','Atenção',MB_ICONEXCLAMATION);
  LimparCampos();
end;

procedure TFrFechamentoOS.btnSairClick(Sender: TObject);
begin
  Close;
end;

function TFrFechamentoOS.VerificaEnvelope(numEnvelope : Integer; out DataSet : TDataSet):Boolean;
Var
  ConexaoBanco : TConexaoBanco;
begin
  ConexaoBanco := TConexaoBanco.Create(_DataBase);
  ConexaoBanco.SQL.Add('SELECT SITUACAOOS, NUMOS, DATAENT, CLI.PESSOANOME FROM OS');
  ConexaoBanco.SQL.Add('INNER JOIN PESSOA CLI ON CLI.PESSOACODIGO = OS.CODCLI');
  ConexaoBanco.SQL.Add('WHERE NRENVELOPE = :NUMERO AND OS.CODIGOEMP = :CODIGOEMP');
  ConexaoBanco.Param.ParamByName('NUMERO').AsInteger := Trunc(curNumEnvelope.Value);
  ConexaoBanco.Param.ParamByName('CODIGOEMP').AsInteger := _DataBase.CodigoEmpresa;
  DataSet := ConexaoBanco.DataSetFactory.GetDataSet(TConexao.Empresa, ConexaoBanco.sql.Text, ConexaoBanco.Param);
  if DataSet.Eof then
    result := False
  else
    result := True;
end;

Function TFrFechamentoOS.ValidaFuncionarioLaboratorio(Gravacao : Boolean = False) : Boolean;
Begin
  Result := False;
  if (_Funcionario.Id = 0)and(Not Gravacao) then
  begin
    btnConsultaFuncLabClick(nil);
    Exit;
  end;

  if (Not TPessoaService.ConsultaPessoa(_DataBase ,_Funcionario, (Not Gravacao), TEnumPessoaTipo.Funcionario)) then
  Begin
    curFuncLabId.SelectAll();
    Exit;
  End
  else
  begin
    curFuncLabId.Value := _Funcionario.Id;
    edtFuncLab.Text := _Funcionario.Nome;
  end;

  Result := True;
End;

procedure TFrFechamentoOS.LimparCampos();
begin
  curNumEnvelope.Value := 0;
  curNumOS.Value := 0;
  edtCliente.Text := '';
  curDataEmissao.Text := '';
  curFuncLabId.Value := 0;
  edtFuncLab.Text := '';
end;



end.
