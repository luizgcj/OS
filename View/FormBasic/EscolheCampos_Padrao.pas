unit EscolheCampos_Padrao;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter,
  cxData, cxDataStorage, cxEdit, cxNavigator,
  cxDataControllerConditionalFormattingRulesManagerDialog, Data.DB, cxDBData,
  cxGridLevel, cxClasses, cxGridCustomView, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxGrid;

type
  TFrEscolheCampos_Padrao = class(TForm)
    MarcaDesmarca: TCheckBox;
    CheckBox1: TCheckBox;
    procedure FormShow(Sender: TObject);
    procedure CheckBoxClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure MarcaDesmarcaClick(Sender: TObject);
  private
    { Private declarations }
    _Grid : TcxGriddbTableView;
    _Tabela : string;
    _CampoVisivel : Integer;
  public
    { Public declarations }

    Constructor Create(AOwner :TComponent; Tabela : string; Grid : TcxGriddbTableView; CampoVisivel : Integer);
  end;

var
  FrEscolheCampos_Padrao: TFrEscolheCampos_Padrao;

implementation

{$R *.dfm}

Uses
  WindowsRecord,
  FuncoesGerais;

Constructor TFrEscolheCampos_Padrao.Create(AOwner :TComponent; Tabela : string; Grid : TcxGriddbTableView; CampoVisivel : Integer);
Begin
  Inherited Create(AOwner);
  _Grid := Grid;
  _Tabela := Tabela;
  _CampoVisivel := CampoVisivel;
  TWindowsRecord.ReadRegEscCampos(_Tabela, _Grid, _CampoVisivel);
  ShowModal();
End;

procedure TFrEscolheCampos_Padrao.FormClose(Sender: TObject;
  var Action: TCloseAction);
var
  I : Integer;
  Valor : String;
begin
  Valor := '';
  for I := 0 to _Grid.ColumnCount - 1 do
    Valor := Valor + TFuncoesGerais.BooleanToStr(_Grid.Columns[I].Visible);
  TWindowsRecord.Write('ESCCAMPOS\'+ _Tabela + '\', 'Campos', Valor);
end;

procedure TFrEscolheCampos_Padrao.FormShow(Sender: TObject);
Var
  I : Integer;
  componente : TComponent;
  bMarcar : Boolean;
begin
  MarcaDesmarca.Checked := True;
  for I := 0 to Self.ControlCount - 1 do
  Begin
    Componente := Self.Controls[I];
    if componente is TCheckBox then
    Begin
      if (TCheckBox(componente).Name <> 'MarcaDesmarca') then
      begin
        TCheckBox(componente).Width := 206;
        TCheckBox(Componente).Visible := False;
        TCheckBox(Componente).OnClick := CheckBoxClick;
      end
      else
        TCheckBox(Componente).OnClick := MarcaDesmarcaClick;
    End;
  End;

  for I := 0 to _Grid.ColumnCount - 1 do
  Begin
    Componente := FindComponent('CheckBox'+IntToStr(I+1));
    if componente <> nil then
    Begin
      TCheckBox(componente).Caption := _Grid.Columns[I].Caption;
      TCheckBox(componente).Visible := True;
      if I = _CampoVisivel then
        bMarcar  := True
      else
        bMarcar  := _Grid.Columns[I].Visible;

      TCheckBox(componente).Checked := bMarcar;

      if (Not bMarcar) then
        MarcaDesmarca.Checked := False;
    End;
  End;

end;

procedure TFrEscolheCampos_Padrao.MarcaDesmarcaClick(Sender: TObject);
Var
  I : Integer;
  componente : TComponent;
  bMarcar : Boolean;
begin
  for I := 0 to _Grid.ColumnCount - 1 do
  Begin
    Componente := FindComponent('CheckBox'+IntToStr(I+1));
    if componente <> nil then
    Begin
      if I = _CampoVisivel then
        bMarcar  := True
      else
        bMarcar  := MarcaDesmarca.Checked;

      TCheckBox(componente).Checked := bMarcar;
    End;
  End;
end;

procedure TFrEscolheCampos_Padrao.CheckBoxClick(Sender: TObject);
Var
  indice : Integer;
Begin
  indice := StrToInt(copy(TCheckBox(Sender).Name ,9,length(TCheckBox(Sender).Name )-8));

  _grid.Columns[indice - 1].Visible := TCheckBox(Sender).Checked;
end;

end.
