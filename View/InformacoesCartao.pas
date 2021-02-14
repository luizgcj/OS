unit InformacoesCartao;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons,
  DataBase,
  ConexaoBanco,
  EnumConexao,
  Data.Db,
  CtReceber;

type
  TFrInfCartao = class(TForm)
    lblMaquinaDeCartao: TLabel;
    cbxMaquinaDeCartao: TComboBox;
    Label1: TLabel;
    edAut: TEdit;
    Label2: TLabel;
    edTitular: TEdit;
    btnConfirmar: TBitBtn;
    procedure btnConfirmarClick(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);

  private
    { Private declarations }
    _DataBase : TDataBase;
    _CtReceber : TCtReceber;


    procedure BuscarMaquinasCartao();
  public
    { Public declarations }
    Constructor Create(AOwner : TComponent; DataBase : TDataBase; CtReceber : TCtReceber);
  end;

var
  FrInfCartao: TFrInfCartao;

implementation

{$R *.dfm}


Constructor TFrInfCartao.Create(AOwner : TComponent; DataBase : TDataBase; CtReceber : TCtReceber);
{$Region 'Binding'}
  Procedure Binding();
  Begin
    Self._CtReceber.Bind('AutorizacaoOperadora', EdAut, 'Text');
    Self._CtReceber.Bind('TitularCartao', EdTitular, 'Text');
  End;
{$EndRegion}
begin
  Inherited Create(AOwner);
  _DataBase  := DataBase;
  _CtReceber := CtReceber;
  Binding();

  BuscarMaquinasCartao();
  Self.ShowModal();
end;

procedure TFrInfCartao.FormKeyPress(Sender: TObject; var Key: Char);
begin
  {$Region 'Enter'}
  if (Key = #13) then
  Begin
    Key := #0;
    Perform(WM_NEXTDLGCTL, 0, 0);
  End;
  {$EndRegion}
end;

procedure TFrInfCartao.btnConfirmarClick(Sender: TObject);
begin
  _CtReceber.MaquinaCartao        := Integer(cbxMaquinaDeCartao.Items.Objects[cbxMaquinaDeCartao.ItemIndex]);
  _CtReceber.AutorizacaoOperadora := edAut.Text;
  _CtReceber.TitularCartao        := edTitular.Text;
  Close;
end;

procedure TFrInfCartao.BuscarMaquinasCartao();
Var
  ConexaoBanco : TConexaoBanco;
  DataSet : TDataSet;
begin
  ConexaoBanco := TConexaoBanco.Create(_DataBase);
  ConexaoBanco.Sql.Add('SELECT CODIGO, DESCRICAO FROM MAQUINA_DE_CARTAO WHERE SITUACAO = ''A''');
  DataSet := ConexaoBanco.DataSetFactory.GetDataSet(TConexao.Empresa, ConexaoBanco.sql.Text, ConexaoBanco.Param);

  while not DataSet.Eof do
  begin
    cbxMaquinaDeCartao.Items.AddObject(DataSet.FieldByName('DESCRICAO').AsString, TObject(DataSet.FieldByName('CODIGO').AsInteger));
    DataSet.Next;
  end;
  if cbxMaquinaDeCartao.Items.Count > 0 then
    cbxMaquinaDeCartao.ItemIndex := 0;
end;

end.
