unit ImpressaoPrePedido;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, ppDB, ppDBPipe, ppComm, ppRelatv,
  ppProd, ppClass, ppReport, Data.Db,
  DataBase, PrePedidoEntity, PrePedidoRepository, Empresa, EmpresaService,
  CustomMessage, Pessoa, PessoaService, EnumPessoaTipo, Mascara,
  ppDesignLayer, ppParameter, ppBands, ppCtrls, ppPrnabl, ppVar, ppCache;

type
  TFrImpressaoPrePedido = class(TForm)
    ppDb: TppDBPipeline;
    ppRep: TppReport;
    ppHeaderBand1: TppHeaderBand;
    ppNomeEmpresa: TppVariable;
    ppPrePedido: TppVariable;
    ppLabel1: TppLabel;
    ppEnderecoEmpresa: TppVariable;
    ppLabel2: TppLabel;
    ppTelefone: TppVariable;
    ppLabel3: TppLabel;
    ppCnpj: TppVariable;
    ppLabel4: TppLabel;
    ppEmissao: TppVariable;
    ppLabel5: TppLabel;
    ppVendedorNome: TppVariable;
    ppVendedorId: TppVariable;
    ppLabel6: TppLabel;
    ppPrevisao: TppVariable;
    ppDetailBand1: TppDetailBand;
    ppDesignLayers1: TppDesignLayers;
    ppDesignLayer1: TppDesignLayer;
    ppParameterList1: TppParameterList;
    ppLine1: TppLine;
    ppLabel7: TppLabel;
    ppClienteId: TppVariable;
    ppClienteNome: TppVariable;
    ppLabel8: TppLabel;
    ppClienteCpfCnpj: TppVariable;
    ppLabel9: TppLabel;
    ppClienteRgIe: TppVariable;
    ppLabel10: TppLabel;
    ppClienteEndereco: TppVariable;
    ppLabel11: TppLabel;
    ppClienteTelefone: TppVariable;
    ppLine2: TppLine;
    ppSummaryBand1: TppSummaryBand;
    procedure ppHeaderBand1BeforePrint(Sender: TObject);
  private
    { Private declarations }
  protected
    _DataBase : TDataBase;
    _Empresa : TEmpresa;
    _PrePedido : TPrePedidoEntity;
    _Vendedor : TPessoa;
    _Cliente : TPessoa;
    _DataSource : TDataSource;

    Procedure Imprimir(); virtual;
  public
    { Public declarations }

    Constructor Create(Aowner : TComponent; PrePedidoId : Integer; DataBase : TDataBase);
  end;

var
  FrImpressaoPrePedido: TFrImpressaoPrePedido;

implementation

{$R *.dfm}

Constructor TFrImpressaoPrePedido.Create(Aowner : TComponent; PrePedidoId : Integer; DataBase : TDataBase);
begin
  Inherited Create(AOwner);
  _DataBase := DataBase;
  _Empresa := TEmpresa.Create();
  TEmpresaService.GetEmpresa(_Empresa, _DataBase);
  _PrePedido := TPrePedidoEntity.Create();
  _PrePedido.Id := PrePedidoId;
  if Not TPrePedidoRepository.ConsultaPrePedido(_PrePedido,_DataBase) then
  Begin
    TCustomMessage.Show('Pré-Pedido '+IntToStr(PrePedidoId) + ' não encontrado.','Atenção!', TTypeMessage.Exclamation, TButtons.Ok);
    Close();
  End
  else
  Begin
    _Vendedor := TPessoa.Create();
    _Vendedor.Id := _Prepedido.VendedorId;
    TPessoaService.ConsultaPessoa(_DataBase,_Vendedor,false,TEnumPessoaTipo.Vendedor);
    _Cliente := TPessoa.Create();
    _Cliente.Id := _PrePedido.ClienteId;
    TPessoaService.ConsultaPessoa(_DataBase,_Cliente,false,TEnumPessoaTipo.Todos);
    _DataSource := TDataSource.Create(Self);
    _DataSource.DataSet := _PrePedido.cdsItens;
    ppDb.DataSource := _DataSource;
    Imprimir();
  End;
end;

Procedure TFrImpressaoPrePedido.Imprimir();
begin
  ppRep.Print();
  Close();
end;

procedure TFrImpressaoPrePedido.ppHeaderBand1BeforePrint(Sender: TObject);
begin

  {$Region 'Emitente'}
  ppNomeEmpresa.Value := _Empresa.Nome;
  ppEnderecoEmpresa.Value := _Empresa.EnderecoCompleto;
  ppTelefone.Value := TMascara.AplicaTelefone(_Empresa.Telefone);
  ppCnpj.Value := TMascara.AplicaCpfCnpj(_Empresa.Cnpj);
  {$EndRegion}

  {$Region 'PrePedido'}
  ppPrePedido.Value := 'Pré-Pedido Nº '+ IntToStr(_PrePedido.Id);
  ppEmissao.Value := _PrePedido.DataEmissao;
  ppPrevisao.Value := _PrePedido.DataPrevisao;
  ppVendedorId.Value := _PrePedido.VendedorId;
  ppVendedorNome.Value := _Vendedor.Nome;
  {$EndRegion}

  {$Region 'Cliente'}
  ppClienteId.Value := _PrePedido.ClienteId;
  ppClienteNome.Value := _Cliente.Nome;
  ppClienteCpfCnpj.Value := TMascara.AplicaCpfCnpj(_Cliente.GetCpfCnpj());
  if _Cliente.IsPessoaJuridica then
    ppClienteRgIe.Value := _Cliente.IE
  else
    ppClienteRgIe.Value := _Cliente.RG;

  ppClienteEndereco.Value := _Cliente.GetEnderecoCompleto();
  ppClienteTelefone.Value := TMascara.AplicaTelefone(_Cliente.Telefone);
  {$EndRegion}
end;

end.
