unit ImpressaoPrePedidoMod1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, ImpressaoPrePedido, ppDB, ppDBPipe,
  ppParameter, ppDesignLayer, ppComm, ppRelatv, ppProd, ppClass, ppReport,
  ppCtrls, ppPrnabl, ppVar, ppBands, ppCache;

type
  TFrImpressaoPrePedidoMod1 = class(TFrImpressaoPrePedido)
    ppLabel12: TppLabel;
    ppLabel13: TppLabel;
    ppLabel14: TppLabel;
    ppLabel15: TppLabel;
    ppLabel16: TppLabel;
    ppdbValorTotal: TppDBText;
    ppDBProdutoId: TppDBText;
    ppdbProduto: TppDBText;
    ppdbQuantidade: TppDBText;
    ppdbValorUnitario: TppDBText;
    ppLabel17: TppLabel;
    ppLabel18: TppLabel;
    ppLabel19: TppLabel;
    ppTotalMercadoria: TppVariable;
    ppDesconto: TppVariable;
    ppValorTotal: TppVariable;
    procedure ppDetailBand1BeforePrint(Sender: TObject);
    procedure ppSummaryBand1BeforePrint(Sender: TObject);
  private
    { Private declarations }

  protected
    Procedure Imprimir(); OverRide;
  public
    { Public declarations }
  end;

var
  FrImpressaoPrePedidoMod1: TFrImpressaoPrePedidoMod1;

implementation

Uses
  Parametros;

{$R *.dfm}

Procedure TFrImpressaoPrePedidoMod1.Imprimir();
Begin
  if (TParametros.VerificaParametros('TIPOFORMULARIO','V',_DataBase) = 'M')
    and (_PrePedido.cdsItens.RecordCount < 15) then
  Begin
    ppRep.PrinterSetup.PaperName := 'Custom';
    ppRep.PrinterSetup.PaperHeight := 11.6929 / 2;
  End
  else
  Begin
    ppRep.PrinterSetup.PaperName := 'A4';
    ppRep.PrinterSetup.PaperHeight := 11.6929;
  End;


  Inherited;
End;

procedure TFrImpressaoPrePedidoMod1.ppDetailBand1BeforePrint(Sender: TObject);
begin
  inherited;
  ppTotalMercadoria.Value := ppTotalMercadoria.Value + ppDb.Fields[(ppDb.FindField('ValorTotal'))].Value;
end;

procedure TFrImpressaoPrePedidoMod1.ppSummaryBand1BeforePrint(Sender: TObject);
begin
  inherited;
  ppDesconto.Value := _PrePedido.Desconto;
  ppValorTotal.Value := ppTotalMercadoria.Value - ppDesconto.Value;
end;

end.
