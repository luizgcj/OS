unit AutorizacaoEstoque;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxEdit, cxNavigator,
  cxDataControllerConditionalFormattingRulesManagerDialog, Data.DB, cxDBData,
  cxGridLevel, cxClasses, cxGridCustomView, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxGrid, Vcl.ExtCtrls, Datasnap.DBClient,
  DataBase, Usuario, Produto, Vcl.StdCtrls, Vcl.Buttons;

type
  TFrAutorizacaoEstoque = class(TForm)
    pnlBotoes: TPanel;
    cxGridLvVw: TcxGridDBTableView;
    cxGridLv: TcxGridLevel;
    cxGrid: TcxGrid;
    cxGridLvVwProdutoId: TcxGridDBColumn;
    cxGridLvVwProduto: TcxGridDBColumn;
    cxGridLvVwEstoque: TcxGridDBColumn;
    cxGridLvVwQuantidade: TcxGridDBColumn;
    BtnAutorizar: TBitBtn;
    BtnDesistir: TBitBtn;
    procedure BtnDesistirClick(Sender: TObject);
    procedure BtnAutorizarClick(Sender: TObject);
  private
    { Private declarations }
    _DsDados : TDataSource;
    _cdsDados : TClientDataSet;

    _DataBase : TDataBase;
    _Usuario : TUsuario;

    _Autorizado : Boolean;

    Procedure InitDataSet();
    Procedure Autorizar();
  public
    { Public declarations }
    Procedure AddItem(Produto : TProduto; Estoque : Double; Quantidade : Double);
    Function Verify():Boolean;
    Constructor Create(AOwner : TComponent; DataBase : TDataBase; Usuario : TUsuario);
  end;

var
  FrAutorizacaoEstoque: TFrAutorizacaoEstoque;

implementation

Uses
  UsuarioService;

{$R *.dfm}

{$Region 'Public'}

Constructor TFrAutorizacaoEstoque.Create(AOwner : TComponent; DataBase : TDataBase; Usuario : TUsuario);
Begin
  Inherited Create(AOwner);
  _DataBase := DataBase;
  _Usuario := Usuario;
  InitDataSet();
End;

Procedure TFrAutorizacaoEstoque.AddItem(Produto : TProduto; Estoque : Double; Quantidade : Double);
Begin
  _cdsDados.Append();
  _cdsDados.FieldByName('ProdutoId').AsInteger := Produto.Id;
  _cdsDados.FieldByName('Produto').AsString := Produto.Nome;
  _cdsDados.FieldByName('Estoque').AsFloat := Estoque;
  _cdsDados.FieldByName('Quantidade').AsFloat := Quantidade;
  _cdsDados.Post();
End;

Function TFrAutorizacaoEstoque.Verify():Boolean;
Begin
  Result := False;
  if _cdsDados.RecordCount = 0 then
  Begin
    Result := True;
    Exit;
  End;

  Self.ShowModal();
  Result := _Autorizado;
End;

{$EndRegion}

{$Region 'Funcoes Tela'}
procedure TFrAutorizacaoEstoque.BtnAutorizarClick(Sender: TObject);
begin
  Autorizar();
end;

procedure TFrAutorizacaoEstoque.BtnDesistirClick(Sender: TObject);
begin
  Self.Close();
end;
{$EndRegion}

{$Region 'Pivate'}

Procedure TFrAutorizacaoEstoque.InitDataSet();
Begin
  _cdsDados := TClientDataSet.Create(Self);
  _cdsDados.FieldDefs.Add('ProdutoId', ftInteger);
  _cdsDados.FieldDefs.Add('Produto', ftString, 200);
  _cdsDados.FieldDefs.Add('Estoque',ftFloat);
  _cdsDados.FieldDefs.Add('Quantidade', ftFloat);
  _cdsDados.CreateDataSet;
  _dsDados := TDataSource.Create(self);
  _dsDados.DataSet := _cdsDados;
  cxGridLvVw.DataController.DataSource := _dsDados;
End;

Procedure TFrAutorizacaoEstoque.Autorizar();
Begin
  if (Not TUsuarioService.VerificaPermissao(_DataBase, _Usuario, 'LIBERACONFESTOQUE')) then
    Exit;

  _Autorizado := True;
  Self.Close();
End;

{$EndRegion}

end.
