unit Main;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit, cxStyles,
  cxCustomData, cxFilter, cxData, cxDataStorage, cxNavigator,
  cxDataControllerConditionalFormattingRulesManagerDialog, Data.DB, cxDBData,
  cxLocalization, cxGridLevel, cxClasses, cxGridCustomView,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGrid, cxTextEdit,
  cxCurrencyEdit, cxLabel, Vcl.StdCtrls, Vcl.Buttons, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, MidasLib, Winapi.ShellAPI,
  CustomExcept,
  DataBase, Funcoes_Alias, Usuario, Log, dxSkinsCore, dxSkinBlack, dxSkinBlue,
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
  dxSkinXmas2008Blue, cxFindPanel, dxDateRanges;
const
  UM_MYMESSAGE = WM_USER + 1001;

type
  TFrMain = class(TForm)
    pnlTitle: TPanel;
    pnlButton: TPanel;
    pnlKey: TPanel;
    lblTitle: TcxLabel;
    lblKey: TcxLabel;
    curKey: TcxCurrencyEdit;
    grDataLvVw: TcxGridDBTableView;
    grDataLv: TcxGridLevel;
    grData: TcxGrid;
    cxLocalizer1: TcxLocalizer;
    btnClose: TBitBtn;
    btnRestore: TBitBtn;
    btnReport: TBitBtn;
    btnEscolheCampos: TBitBtn;
    QrData: TFDQuery;
    DsData: TDataSource;
    QrDataNUMOS: TIntegerField;
    QrDataCODCLI: TIntegerField;
    QrDataCLIENTE: TStringField;
    QrDataCODVEND: TIntegerField;
    QrDataVENDEDOR: TStringField;
    QrDataCODFECHA: TIntegerField;
    QrDataFUNCLAB: TStringField;
    QrDataVALORTOTALITENS: TFloatField;
    QrDataVALORTOTAL: TFloatField;
    QrDataCANCELADO: TStringField;
    QrDataDTCANCEL: TDateTimeField;
    QrDataFATURADO: TStringField;
    QrDataSITUACAOOS: TStringField;
    grDataLvVwNUMOS: TcxGridDBColumn;
    grDataLvVwDATADIGITA: TcxGridDBColumn;
    grDataLvVwHORAPREVISAO: TcxGridDBColumn;
    grDataLvVwCODCLI: TcxGridDBColumn;
    grDataLvVwCLIENTE: TcxGridDBColumn;
    grDataLvVwCODVEND: TcxGridDBColumn;
    grDataLvVwVENDEDOR: TcxGridDBColumn;
    grDataLvVwCODFECHA: TcxGridDBColumn;
    grDataLvVwFUNCLAB: TcxGridDBColumn;
    grDataLvVwVALORTOTALITENS: TcxGridDBColumn;
    grDataLvVwVALORTOTAL: TcxGridDBColumn;
    grDataLvVwCANCELADO: TcxGridDBColumn;
    grDataLvVwDTCANCEL: TcxGridDBColumn;
    grDataLvVwFATURADO: TcxGridDBColumn;
    grDataLvVwSITUACAOOS: TcxGridDBColumn;
    grDataLvVwDATAPREVISAO: TcxGridDBColumn;
    grDataLvVwHORADIGITA: TcxGridDBColumn;
    QrDataDATADIGITA: TDateField;
    QrDataHORADIGITA: TTimeField;
    QrDataDATAPREVISAO: TDateField;
    QrDataHORAPREVISAO: TTimeField;
    BtnParametros: TBitBtn;
    grDataLvVwDATAFECHAMENTO: TcxGridDBColumn;
    grDataLvVwHORAFECHAMENTO: TcxGridDBColumn;
    grDataLvVwDATAENTREGA: TcxGridDBColumn;
    grDataLvVwHORAENTREGA: TcxGridDBColumn;
    QrDataDATAFECHA: TDateField;
    QrDataHORAFECHA: TTimeField;
    QrDataDATAENTREGA: TDateField;
    QrDataHORAENTREGA: TTimeField;
    grDataLvVwNRENVELOPE: TcxGridDBColumn;
    QrDataNRENVELOPE: TIntegerField;
    grDataLvVwPEDIDORAPIDO: TcxGridDBColumn;
    QrDataPEDIDORAPIDO: TStringField;
    BitBtn1: TBitBtn;
    grDataLvVwSETOR: TcxGridDBColumn;
    QrDataSETOR: TStringField;
    btnRelatorios: TBitBtn;
    procedure FormShow(Sender: TObject);
    procedure btnCloseClick(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure btnRestoreClick(Sender: TObject);
    procedure curKeyEnter(Sender: TObject);
    procedure grDataLvVwDblClick(Sender: TObject);
    procedure btnEscolheCamposClick(Sender: TObject);
    procedure btnReportClick(Sender: TObject);
    procedure grDataLvVwKeyPress(Sender: TObject; var Key: Char);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure grDataLvVwCustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    procedure BtnParametrosClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure BitBtn1Click(Sender: TObject);
    procedure btnRelatoriosClick(Sender: TObject);
  private
    { Private declarations }
    _DataBase : TDataBase;
    _Usuario : TUsuario;

    Procedure LoadSql();
    Procedure ShowOrdemServico(OrdemServicoId : Integer);
    procedure umMyMessage(var Message: TMessage); message UM_MYMESSAGE;
  public
    { Public declarations }
  end;

var
  FrMain: TFrMain;

implementation

Uses
  FuncoesGerais,
  Login,
  CadOrdemServico,
  OrdemServicoRepository,
  WindowsRecord,
  EscolheCampos_OrdemServico,
  cxGridExtentions,
  Parametros,
  Empresa,
  EmpresaService,
  CustomMessage, ParametrosOS, FechamentoOS, Relatorios;

type
  TcxGridTableControllerAccess = class (TcxGridTableController);
  TcxGridFindPanelAccess = class(TcxGridFindPanel);

{$R *.dfm}

procedure TFrMain.BitBtn1Click(Sender: TObject);
begin
  TFrFechamentoOS.Create(Self, _DataBase).Release();
end;

procedure TFrMain.btnCloseClick(Sender: TObject);
begin
  close();
end;

procedure TFrMain.btnEscolheCamposClick(Sender: TObject);
begin
  TFrEscolheCampos_OrdemServico.Create(Self, 'ORDEMSERVICO', grDataLvVw, 0).Release();
end;

procedure TFrMain.BtnParametrosClick(Sender: TObject);
begin
  TFrParametrosOS.Create(Self, _DataBase).Release();
end;

procedure TFrMain.btnRelatoriosClick(Sender: TObject);
begin
  TFrRelatorios.Create(Self, _DataBase).Release();
end;

procedure TFrMain.btnReportClick(Sender: TObject);
Var
  logo : Boolean;
  caminhoLogo : String;
  titulo : String;
  empresa : TEmpresa;
  nomeArquivoRelatorio : String;
begin
  logo := TParametros.VerificaParametros('MostrarLogo','V', _DataBase) = 'S';
  caminhoLogo := TParametros.VerificaParametros('CaminhoImg','V', _DataBase);
  titulo := 'Relatorio de Ordem de Serviço';

  empresa := TEmpresa.Create();
  TEmpresaService.GetEmpresa(Empresa, _DataBase);
  nomeArquivoRelatorio := 'ORDEMSERVICO_'+formatDateTime('DDMMYYYYHHNNSSZZZ', now);
  if TcxGridExtentions.cxGridToHtml(grDataLvVw, logo, caminhoLogo, empresa, titulo, titulo, nomeArquivoRelatorio, 'S', '', true) then
    ShellExecute(Handle, nil,PChar('\SGE32\Relatorios\'+ nomeArquivoRelatorio +'.Htm'), nil, nil, SW_SHOW);
end;

procedure TFrMain.btnRestoreClick(Sender: TObject);
begin
  Grdatalvvw.DataController.Filter.Clear;
  Grdatalvvw.FindPanel.DisplayMode := fpdmNever;
  Grdatalvvw.FindPanel.DisplayMode := fpdmAlways;
  LoadSql();
end;

procedure TFrMain.curKeyEnter(Sender: TObject);
begin
  LoadSql();
  curKey.SetFocus;
  (Sender as TcxCurrencyEdit).EditValue := TOrdemServicoRepository.AutoIncremento(_DataBase);
end;

procedure TFrMain.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  if TCustomMessage.Show('Confirma Sair?','Atenção!',TTypeMessage.Question, TButtons.YesNo) = idYes then
    CanClose := True
  else
    CanClose := False;
end;

procedure TFrMain.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if key = VK_UP then
    curKey.SetFocus;
end;

procedure TFrMain.FormKeyPress(Sender: TObject; var Key: Char);
begin
  {$Region 'Esc'}
  if key = #27 then
    PostMessage(Handle, UM_MYMESSAGE, 0, 0);
  {$EndRegion}

  {$Region 'Enter'}
  if (Key = #13) then
  Begin
    if (ActiveControl = curKey.ActiveControl) then
    Begin
      LoadSql();
      curKey.EditValue := TOrdemServicoRepository.AutoIncremento(_DataBase);
      ShowOrdemServico(Trunc(curKey.Value));
      Exit;
    End;
  End;
  {$EndRegion}
end;

procedure TFrMain.FormShow(Sender: TObject);
begin

  try
    cxLocalizer1.FileName := ExtractFilePath(Application.ExeName) + '\' + 'CXLOCALIZATION.ini';
    cxLocalizer1.Active   := True;
    cxLocalizer1.Locale := 2070;
  except
  end;

  try
    Application.OnException := TCustomExcept.Generic;

    _DataBase := TDataBase.Create();
    _Usuario := TUsuario.Create();

    AtribuiAlias('BASEDADOS',_DataBase.BaseDados, _DataBase);
    AtribuiAlias('RECURSOS',_DataBase.Recursos, _DataBase);

    FrLogin := TFrLogin.Create(Self, _Usuario, TFuncoesGerais.GetBuildInfo(Application.ExeName), _DataBase);
    FrLogin.ShowModal();
    if (not FrLogin.Authorized) then
    Begin
      FrLogin.Release();
      Halt;
    End;
    _DataBase.CodigoEmpresa := FrLogin.CodigoEmpresa;

    AtribuiAlias(_DataBase.AliasEmpresa, _DataBase.Empresa, _DataBase);

    FrLogin.Release();

    TLog.Usuario := _Usuario;
    TLog.CodigoEmpresa := _DataBase.CodigoEmpresa;

    if (not TFuncoesGerais.VerificaVersaoAplicativo(_Database, ExtractFileDrive(Application.ExeName) + '\Sge32\OrdemServico.exe')) and (DebugHook = 0) then
    begin
      TCustomMessage.Show('Existe uma nova Versão do Aplicativo, atualize ou entre contato com o Suporte.', 'Atenção!',TTypeMessage.Exclamation, TButtons.Ok);
      Application.terminate;
      Exit;
    end;

    QrData.Connection := _DataBase.Empresa;
    LoadSql();
    if _Usuario.Master then
      btnRelatorios.Visible := True;

    TWindowsRecord.ReadRegEscCampos('ORDEMSERVICO', grDataLvVw, 0);
    PostMessage(Handle, UM_MYMESSAGE, 0, 0);
  except
    on e:Exception do
    begin
      TCustomMessage.Show('Erro ao inicializar O.S. ' + e.Message,'Atenção!',TTypeMessage.Exclamation, TButtons.Ok);
      FrLogin.Release();
      Halt;
    end;
  end;
end;

procedure TFrMain.grDataLvVwCustomDrawCell(Sender: TcxCustomGridTableView;
  ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
  var ADone: Boolean);
var
  Valor : String;
begin
  {if AViewInfo.GridRecord.Index < 0then
    Exit;
  Valor := VarAsType( grDataLvVw.ViewData.Records[AViewInfo.GridRecord.Index].Values[grDataLvVwCancelado.Index], varString );

  if Valor = 'S' then
    Acanvas.Font.Color := clRed
  else
    Acanvas.Font.Color := clBlack;

  Valor := VarAsType( grDataLvVw.ViewData.Records[AViewInfo.GridRecord.Index].Values[grDataLvVwFaturado.Index], varString );

  if Valor = 'S' then
    Acanvas.Font.Color := clGreen;

  Valor := VarAsType( grDataLvVw.ViewData.Records[AViewInfo.GridRecord.Index].Values[grDataLvVwPEDIDORAPIDO.Index], varString );

  if Valor = 'S' then
    Acanvas.Font.Color := $00404080;  }
end;

procedure TFrMain.grDataLvVwDblClick(Sender: TObject);
begin
  if grDataLvVw.DataController.DataSource.DataSet.RecNo >= 0 then
    ShowOrdemServico(grDataLvVw.DataController.DataSource.DataSet.FieldByName('NUMOS').AsInteger);
end;

procedure TFrMain.grDataLvVwKeyPress(Sender: TObject; var Key: Char);
begin
  if key = #9 then
    PostMessage(Handle, UM_MYMESSAGE, 0, 0);

  if key = #13 then
  Begin
    if grDataLvVw.DataController.DataSource.DataSet.RecNo >= 0 then
      ShowOrdemServico(grDataLvVw.DataController.DataSource.DataSet.FieldByName('NUMOS').AsInteger);
    key := #0;
  End;
end;

Procedure TFrMain.LoadSql();
Begin
  QrData.SQL.Clear;
  QrData.SQL.Add('SELECT                                                                                            ');
  QrData.SQL.Add('OS.NUMOS, OS.NRENVELOPE, COALESCE(OS.PEDIDORAPIDO,''N'') AS PEDIDORAPIDO,                         ');
  QrData.SQL.Add('CAST(OS.DATADIGITA AS DATE) DATADIGITA, CAST(OS.HORADIGITA AS TIME) AS HORADIGITA,                ');
  QrData.SQL.Add('CAST(OS.DATAPREVISAO AS DATE) DATAPREVISAO, CAST(OS.HORAPREVISAO AS TIME) AS HORAPREVISAO,        ');
  QrData.SQL.Add('CAST(OS.DATAFECHA AS DATE) DATAFECHA, CAST(OS.HORAFECHA AS TIME) AS HORAFECHA,                    ');
  QrData.SQL.Add('CAST(OS.DATAENTREGA AS DATE) DATAENTREGA, CAST(OS.HORAENTREGA AS TIME) AS HORAENTREGA,            ');
  QrData.SQL.Add('OS.CODCLI,                                                                                        ');
  QrData.SQL.Add('CLI.PESSOANOME CLIENTE,                                                                           ');
  QrData.SQL.Add('OS.CODVEND,                                                                                       ');
  QrData.SQL.Add('VEND.PESSOANOME VENDEDOR,                                                                         ');
  QrData.SQL.Add('OS.CODFECHA,                                                                                      ');
  QrData.SQL.Add('FUNCLAB.PESSOANOME FUNCLAB,                                                                       ');
  QrData.SQL.Add('OS.TOTALPRODUTOS + OS.TOTALSERVICOS AS VALORTOTALITENS,                                           ');
  QrData.SQL.Add('OS.TOTALOS AS VALORTOTAL,                                                                         ');
  QrData.SQL.Add('OS.CANCELADO,                                                                                     ');
  QrData.SQL.Add('OS.DTCANCEL,                                                                                      ');
  QrData.SQL.Add('OS.FATURADO,                                                                                      ');
  QrData.SQL.Add('OS.DATAEMISSAONF,                                                                                 ');
  QrData.SQL.Add('CASE WHEN OS.CANCELADO = ''S'' THEN ''CANCELADO''                                                 ');
  QrData.SQL.Add('WHEN OS.PEDIDORAPIDO = ''S'' THEN ''ENTREGUE''                                                    ');
  QrData.SQL.Add('WHEN OS.SITUACAOOS = ''A'' THEN ''ABERTO''                                                        ');
  QrData.SQL.Add('WHEN OS.SITUACAOOS = ''F'' THEN ''FECHADO''                                                       ');
  QrData.SQL.Add('WHEN OS.SITUACAOOS = ''E'' THEN ''ENTREGUE'' END SITUACAOOS,                                      ');
  QrData.SQL.Add('S.SETOR                                                                                           ');
  QrData.SQL.Add('FROM OS                                                                                           ');
  QrData.SQL.Add('INNER JOIN ITOS It On                                                                             ');
  QrData.SQL.Add('    IT.NUMOS = OS.NUMOS                                                                           ');
  QrData.SQL.Add('    And IT.CODIGOEMP = OS.CodigoEmp                                                               ');
  QrData.SQL.Add('INNER JOIN PRODUTOS PR On                                                                         ');
  QrData.SQL.Add('    PR.CODIGOPRODUTO = It.CODPROD                                                                 ');
  QrData.SQL.Add('INNER JOIN PESSOA CLI On                                                                          ');
  QrData.SQL.Add('    CLI.PESSOACODIGO = OS.CODCLI                                                                  ');
  QrData.SQL.Add('INNER JOIN PESSOA VEND On                                                                         ');
  QrData.SQL.Add('    VEND.PESSOACODIGO = OS.CODVEND                                                                ');
  QrData.SQL.Add('INNER JOIN SETOR S On                                                                             ');
  QrData.SQL.Add('           S.CODSETOR = OS.CODSETOR                                                               ');
  QrData.SQL.Add('LEFT JOIN PESSOA VENDLIB ON                                                                       ');
  QrData.SQL.Add('    VENDLIB.PESSOACODIGO = OS.CODENTREGA                                                          ');
  QrData.SQL.Add('LEFT JOIN PESSOA FUNCLAB ON                                                                       ');
  QrData.SQL.Add('    FUNCLAB.PESSOACODIGO = OS.CODFECHA                                                            ');
  QrData.SQL.Add('WHERE                                                                                             ');
  QrData.SQL.Add('OS.CODIGOEMP = :CODIGOEMP                                                                         ');
  QrData.SQL.Add('GROUP BY                                                                                          ');
  QrData.SQL.Add('OS.NUMOS, OS.NRENVELOPE, COALESCE(OS.PEDIDORAPIDO,''N''),                                                         ');
  QrData.SQL.Add('OS.DATADIGITA,                                                                                    ');
  QrData.SQL.Add('OS.HORADIGITA,                                                                                    ');
  QrData.SQL.Add('OS.DATAPREVISAO,                                                                                  ');
  QrData.SQL.Add('OS.HORAPREVISAO,                                                                                  ');
  QrData.SQL.Add('OS.DATAFECHA,                                                                                     ');
  QrData.SQL.Add('OS.HORAFECHA,                                                                                     ');
  QrData.SQL.Add('OS.DATAENTREGA,                                                                                   ');
  QrData.SQL.Add('OS.HORAENTREGA,                                                                                   ');
  QrData.SQL.Add('OS.CODCLI,                                                                                        ');
  QrData.SQL.Add('CLI.PESSOANOME,                                                                                   ');
  QrData.SQL.Add('OS.CODVEND,                                                                                       ');
  QrData.SQL.Add('VEND.PESSOANOME,                                                                                  ');
  QrData.SQL.Add('OS.CODFECHA,                                                                                      ');
  QrData.SQL.Add('FUNCLAB.PESSOANOME,                                                                               ');
  QrData.SQL.Add('OS.TOTALPRODUTOS, OS.TOTALSERVICOS,                                                               ');
  QrData.SQL.Add('OS.TOTALOS,                                                                                       ');
  QrData.SQL.Add('OS.CANCELADO,                                                                                     ');
  QrData.SQL.Add('OS.DTCANCEL,                                                                                      ');
  QrData.SQL.Add('OS.FATURADO,                                                                                      ');
  QrData.SQL.Add('OS.DATAEMISSAONF,                                                                                 ');
  QrData.SQL.Add('OS.PEDIDORAPIDO, OS.SITUACAOOS, S.SETOR                                                                                     ');
  QrData.SQL.Add('ORDER BY OS.NUMOS DESC                                                                            ');
  QrData.ParamByName('CodigoEmp').AsInteger := _DataBase.CodigoEmpresa;
  QrData.Open;
End;

Procedure TFrMain.ShowOrdemServico(OrdemServicoId : Integer);
Var
  Modify : Boolean;
Begin
  if TOrdemServicoRepository.VerifyNewOS(OrdemServicoId , Modify, _DataBase) then
  begin
    FrCadOrdemServico := TFrCadOrdemServico.Create(Self, _DataBase, Modify, _Usuario, OrdemServicoId);
    FrCadOrdemServico.ShowModal();
    FrCadOrdemServico.Release();
    LoadSql();
    curKeyEnter(curKey);
  end;
End;

procedure TFrMain.umMyMessage(var Message: TMessage);
begin
  TcxGridFindPanelAccess(TcxGridTableControllerAccess(grDataLvVw.Controller).FindPanel).Edit.SetFocus;
end;

end.
