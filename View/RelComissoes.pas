unit RelComissoes;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, cxGraphics,
  cxLookAndFeels, cxLookAndFeelPainters, Vcl.Menus, dxSkinsCore, dxSkinBlack,
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
  dxSkinXmas2008Blue, cxControls, cxContainer, cxEdit, cxLabel, cxTextEdit,
  cxMaskEdit, cxDropDownEdit, Vcl.StdCtrls, cxButtons, Vcl.ComCtrls, dxCore,
  cxDateUtils, cxCalendar, dxWheelPicker, dxNumericWheelPicker,
  dxDateTimeWheelPicker, cxCheckBox, Vcl.Mask, GetNum, PessoaService, Database, Pessoa,
  EnumPessoaTipo, Data.DB, Datasnap.DBClient, ppDB, ppDBPipe, ppComm, ppRelatv,
  ppProd, ppClass, ppReport, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, ppCtrls, ppBands, ppPrnabl, ppCache, ppDesignLayer,
  ppParameter;

type
  TFrRelComissoes = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    btnGerar: TcxButton;
    btnDesistir: TcxButton;
    cbTipoRelatorio: TcxComboBox;
    lblTipoRelatorio: TcxLabel;
    DataInicial: TcxDateEdit;
    lblDataInicial: TcxLabel;
    lblDataFinal: TcxLabel;
    DataFinal: TcxDateEdit;
    dtpDataInicial: TDateTimePicker;
    dtpDataFinal: TDateTimePicker;
    lblVendedor: TcxLabel;
    gnCodVendedor: TGetNumber;
    edtVendedor: TEdit;
    chkTodosVendedores: TcxCheckBox;
    btnConsVendedor: TcxButton;
    RelComissoesAnalitico: TppReport;
    ppDados: TppDBPipeline;
    dsDados: TDataSource;
    cdsDados: TClientDataSet;
    cdsDadosDATAENT: TDateField;
    cdsDadosCODCLI: TIntegerField;
    cdsDadosCLIENTE: TStringField;
    cdsDadosCODVEND: TIntegerField;
    cdsDadosVENDEDOR: TStringField;
    cdsDadosTOTALOS: TFloatField;
    cdsDadosDESCONTO: TFloatField;
    cdsDadosTOTALLIQUIDO: TFloatField;
    ppParameterList1: TppParameterList;
    ppDesignLayers1: TppDesignLayers;
    ppDesignLayer1: TppDesignLayer;
    ppHeaderBand1: TppHeaderBand;
    ppDetailBand1: TppDetailBand;
    ppLabel1: TppLabel;
    ppLabel2: TppLabel;
    ppGroup1: TppGroup;
    ppGroupHeaderBand1: TppGroupHeaderBand;
    ppGroupFooterBand1: TppGroupFooterBand;
    ppLabel3: TppLabel;
    ppDBText1: TppDBText;
    ppDBText2: TppDBText;
    cdsDadosNUMOS: TIntegerField;
    ppLabel4: TppLabel;
    ppDBText3: TppDBText;
    ppLabel5: TppLabel;
    ppDBText4: TppDBText;
    ppDBText5: TppDBText;
    ppLabel6: TppLabel;
    ppDBText6: TppDBText;
    ppLabel7: TppLabel;
    ppDBText7: TppDBText;
    ppDBCalc1: TppDBCalc;
    ppLabel8: TppLabel;
    ppLine1: TppLine;
    RelComissoesSintetico: TppReport;
    ppParameterList2: TppParameterList;
    ppDesignLayers2: TppDesignLayers;
    ppDesignLayer2: TppDesignLayer;
    ppHeaderBand2: TppHeaderBand;
    ppDetailBand2: TppDetailBand;
    ppLabel9: TppLabel;
    ppLabel10: TppLabel;
    ppLabel11: TppLabel;
    ppDBText8: TppDBText;
    ppDBText9: TppDBText;
    ppLabel12: TppLabel;
    ppDBText10: TppDBText;
    ppLabel13: TppLabel;
    ppDBText11: TppDBText;
    ppLabel14: TppLabel;
    ppDBText12: TppDBText;
    cdsDadosEMISSAO: TDateField;
    ppDBText13: TppDBText;
    ppLine2: TppLine;
    ppDBText14: TppDBText;
    ppPageSummaryBand1: TppPageSummaryBand;
    ppLabel15: TppLabel;
    ppDBCalc2: TppDBCalc;
    ppDBCalc3: TppDBCalc;
    ppDBCalc4: TppDBCalc;
    ppLine3: TppLine;
    ppLabel16: TppLabel;
    cdsDadosDTINICIAL: TDateField;
    cdsDadosDTFINAL: TDateField;
    ppDBText15: TppDBText;
    ppLabel17: TppLabel;
    ppDBText16: TppDBText;
    ppLabel18: TppLabel;
    ppDBText17: TppDBText;
    ppLabel19: TppLabel;
    ppDBText18: TppDBText;
    procedure btnDesistirClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure DataInicialPropertiesChange(Sender: TObject);
    procedure DataFinalPropertiesChange(Sender: TObject);
    procedure dtpDataInicialChange(Sender: TObject);
    procedure dtpDataFinalChange(Sender: TObject);
    procedure btnConsVendedorClick(Sender: TObject);
    procedure chkTodosVendedoresClick(Sender: TObject);
    procedure btnGerarClick(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
    _Pessoa : TPessoa;
    _Database : TDatabase;
  public
    { Public declarations }
    procedure InicializaPropriedades(Database : TDatabase);
    procedure GerarRelatorio();
    procedure ValidaCampos();
    procedure QueryRelatorioAnalitico(QrConsulta : TFDQuery);
    procedure QueryRelatorioSintetico(QrConsulta : TFDQuery);
  end;

var
  FrRelComissoes: TFrRelComissoes;

implementation



{$R *.dfm}

procedure TFrRelComissoes.btnConsVendedorClick(Sender: TObject);
begin
  TPessoaService.TelaConsultaPessoa(_Database, _Pessoa, TEnumPessoaTipo.Vendedor);
  gnCodVendedor.Value := _Pessoa.Id;
  edtVendedor.Text := _Pessoa.Nome;
end;

procedure TFrRelComissoes.btnDesistirClick(Sender: TObject);
begin
  Close;
end;

procedure TFrRelComissoes.btnGerarClick(Sender: TObject);
begin
  ValidaCampos();
  GerarRelatorio();
end;

procedure TFrRelComissoes.chkTodosVendedoresClick(Sender: TObject);
begin
  gnCodVendedor.Enabled := (not chkTodosVendedores.Checked);
  btnConsVendedor.Enabled := (not chkTodosVendedores.Checked);

  if chkTodosVendedores.Checked then
  begin
    gnCodVendedor.Value := 0;
    edtVendedor.Text := '';
  end
  else
  begin
    gnCodVendedor.SetFocus;
  end;
end;

procedure TFrRelComissoes.DataFinalPropertiesChange(Sender: TObject);
begin
  dtpDataFinal.Date := DataFinal.Date;
end;

procedure TFrRelComissoes.DataInicialPropertiesChange(Sender: TObject);
begin
  dtpDataInicial.Date := DataInicial.Date;
end;

procedure TFrRelComissoes.dtpDataFinalChange(Sender: TObject);
begin
  DataFinal.Date := dtpDataFinal.Date;
end;

procedure TFrRelComissoes.dtpDataInicialChange(Sender: TObject);
begin
  DataInicial.Date := dtpDataInicial.Date;
end;

procedure TFrRelComissoes.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if key = #13 then
  begin
    if ActiveControl = gnCodVendedor then
    begin
      if (gnCodVendedor.Value <> 0) then
      begin
        _Pessoa.Id := Trunc(gnCodVendedor.Value);
        if TPessoaService.ConsultaPessoa(_Database, _Pessoa, False, TEnumPessoaTipo.Vendedor) then
          edtVendedor.Text := _Pessoa.Nome
        else
        begin
          gnCodVendedor.Value := 0;
          edtVendedor.Text := '';
          Application.Messagebox('C�digo inv�lido!', 'Aten��o!', MB_ICONEXCLAMATION);
          Exit;
        end;

      end
      else
      begin
        gnCodVendedor.Value := 0;
        edtVendedor.Text := '';
        Application.Messagebox('C�digo inv�lido!', 'Aten��o!', MB_ICONEXCLAMATION);
        Exit;
      end;
    end;
    Key := #0;
    Perform(wm_NextDlgCtl,0,0);
  end;
end;

procedure TFrRelComissoes.FormShow(Sender: TObject);
begin
  DataInicial.Date := Date;
  DataFinal.Date := Date;
  dtpDataInicial.Date := Date;
  dtpDataFinal.Date := Date;
end;

procedure TFrRelComissoes.InicializaPropriedades(Database : TDatabase);
begin
  _Database := Database;
  _Pessoa := TPessoa.Create();
end;

procedure TFrRelComissoes.ValidaCampos();
begin
  if DataInicial.Date > DataFinal.Date then
  begin
    Application.Messagebox('Data inicial n�o pode ser maior que a data final!', 'Aten��o!', MB_ICONEXCLAMATION);
    DataInicial.SetFocus;
    Exit;
  end;
end;


procedure TFrRelComissoes.GerarRelatorio();
var QrConsulta : TFDQuery;
begin
  QrConsulta := TFDQuery.Create(nil);
  QrConsulta.Connection := _Database.Empresa;

  QrConsulta.SQL.Clear();


  if cbTipoRelatorio.ItemIndex = 1 then
    QueryRelatorioAnalitico(QrConsulta)
  else
    QueryRelatorioSintetico(QrConsulta);

  QrConsulta.ParamByName('DTINICIAL').AsDatetime := DataInicial.Date;
  QrConsulta.ParamByName('DTFINAL').AsDatetime := DataFinal.Date;
  if not chkTodosVendedores.Checked then
    QrConsulta.ParamByName('CODVEND').AsInteger := Trunc(gnCodVendedor.Value);

  QrConsulta.Open();

  if QrConsulta.Eof then
  begin
    Application.MessageBox('N�o foram encontrados dados para gera��o do relat�rio', 'Aten��o', MB_ICONEXCLAMATION);
    DataInicial.SetFocus;
    Exit;
  end;

  if cdsDados.Active then
    cdsDados.EmptyDataSet()
  else
    cdsDados.CreateDataset();

  while not QrConsulta.Eof do
  begin
    cdsDados.Append();
    cdsDadosNUMOS.AsInteger := QrConsulta.FieldByName('NUMOS').AsInteger;
    cdsDadosDATAENT.AsDatetime := QrConsulta.FieldByName('DATAENT').AsDatetime;
    cdsDadosCODCLI.AsInteger := QrConsulta.FieldByName('CODCLI').AsInteger;
    cdsDadosCLIENTE.AsString := QrConsulta.FieldByName('CLIENTE').AsString;
    cdsDadosCODVEND.AsInteger := QrConsulta.FieldByName('CODVEND').AsInteger;
    cdsDadosVENDEDOR.AsString := QrConsulta.FieldByName('VENDEDOR').AsString;
    cdsDadosTOTALOS.AsFloat := QrConsulta.FieldByName('TOTALOS').AsFloat;
    cdsDadosDESCONTO.AsFloat := QrConsulta.FieldByName('DESCONTO').AsFloat;
    cdsDadosTOTALLIQUIDO.AsFloat := QrConsulta.FieldByName('TOTALLIQUIDO').AsFloat;
    cdsDadosEMISSAO.AsDatetime := Date;
    cdsDadosDTINICIAL.AsDatetime := DataInicial.Date;
    cdsDadosDTFINAL.AsDatetime := DataFinal.Date;
    cdsDados.Post();
    QrConsulta.Next();
  end;

  cdsDados.First();
  if cbTipoRelatorio.ItemIndex = 1 then
    RelComissoesAnalitico.Print()
  else
    RelComissoesSintetico.Print();

end;

procedure TFrRelComissoes.QueryRelatorioAnalitico(QrConsulta : TFDQuery);
begin
  QrConsulta.SQL.Add('SELECT OS.NUMOS, OS.DATAENT, OS.CODCLI, CLI.PESSOANOME AS CLIENTE, OS.TOTALOS, OS.CODVEND, ');
  QrConsulta.SQL.Add('VEND.PESSOANOME AS VENDEDOR, 0 AS DESCONTO, 0 AS TOTALLIQUIDO');
  QrConsulta.SQL.Add('FROM OS JOIN PESSOA CLI ON OS.CODCLI = CLI.PESSOACODIGO');
  QrConsulta.SQL.Add('JOIN PESSOA VEND ON OS.CODVEND = VEND.PESSOACODIGO');
  QrConsulta.SQL.Add('WHERE OS.CANCELADO <> ''S'' AND (((OS.SITUACAOOS = ''E'' OR OS.PEDIDORAPIDO = ''S'') AND (OS.DATAENTREGA BETWEEN :DTINICIAL AND :DTFINAL) AND (ROUND(OS.VRADIANTAMENTO,2) < ROUND(OS.TOTALOS,2)))');
  QrConsulta.SQL.Add('OR ((OS.DATAENT BETWEEN :DTINICIAL AND :DTFINAL) AND (ROUND(OS.VRADIANTAMENTO,2) = ROUND(OS.TOTALOS,2))))');

  if not chkTodosVendedores.Checked then
    QrConsulta.SQL.Add('AND OS.CODVEND = :CODVEND');

  QrConsulta.SQL.Add('ORDER BY OS.CODVEND, OS.NUMOS, OS.DATAENT, OS.CODCLI');
end;

procedure TFrRelComissoes.QueryRelatorioSintetico(QrConsulta : TFDQuery);
begin
  QrConsulta.SQL.Add('SELECT SUM(VRTOTALLIQUIDO) AS TOTALLIQUIDO, SUM(DESCONTO) AS DESCONTO, SUM(VRTOTAL) AS TOTALOS, CODVEND, VENDEDOR,');
  QrConsulta.SQL.Add('0 AS CODCLI, '''' AS CLIENTE, CAST(''NOW'' AS DATE) AS DATAENT, 0 AS NUMOS');
  QrConsulta.SQL.Add('FROM (');
  QrConsulta.SQL.Add('SELECT (SUM(ITOS.VRTOTAL) - OS.VRDESCOS) AS VRTOTALLIQUIDO, (SUM(ITOS.VRDESC) + OS.VRDESCOS) AS DESCONTO,');
  QrConsulta.SQL.Add('(SUM(ITOS.VRTOTAL + ITOS.VRDESC)) AS VRTOTAL, OS.CODVEND, VEND.PESSOANOME AS VENDEDOR');
  QrConsulta.SQL.Add('FROM OS JOIN ITOS ON OS.NUMOS = ITOS.NUMOS AND OS.CODIGOEMP = ITOS.CODIGOEMP');
  QrConsulta.SQL.Add('JOIN PESSOA VEND ON VEND.PESSOACODIGO = OS.CODVEND');
  QrConsulta.SQL.Add('WHERE OS.CANCELADO <> ''S'' AND (((OS.SITUACAOOS = ''E'' OR OS.PEDIDORAPIDO = ''S'') AND (OS.DATAENTREGA BETWEEN :DTINICIAL AND :DTFINAL) AND (ROUND(OS.VRADIANTAMENTO,2) < ROUND(OS.TOTALOS,2)))');
  QrConsulta.SQL.Add('OR ((OS.DATAENT BETWEEN :DTINICIAL AND :DTFINAL) AND (ROUND(OS.VRADIANTAMENTO,2) = ROUND(OS.TOTALOS,2))))');

  if not chkTodosVendedores.Checked then
    QrConsulta.SQL.Add('AND OS.CODVEND = :CODVEND');

  QrConsulta.SQL.Add('GROUP BY OS.VRDESCOS, OS.CODVEND, VEND.PESSOANOME');
  QrConsulta.SQL.Add('ORDER BY OS.CODVEND)');
  QrConsulta.SQL.Add('GROUP BY CODVEND, VENDEDOR');
  QrConsulta.SQL.Add('ORDER BY CODVEND, VENDEDOR');
end;


end.
