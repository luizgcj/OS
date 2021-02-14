unit Relatorios;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Menus,
  DataBase, Vcl.ExtCtrls;

type
  TFrRelatorios = class(TForm)
    mn_Menu: TMainMenu;
    mn_Relatorios: TMenuItem;
    Image1: TImage;
    Mn_RelatorioComissoes: TMenuItem;
    procedure Mn_RelatorioComissoesClick(Sender: TObject);
  private
    { Private declarations }
    _DataBase : TDataBase;

  public
    { Public declarations }
    Constructor Create(AOwner : TComponent; DataBase : TDataBase);
  end;

var
  FrRelatorios: TFrRelatorios;

implementation

uses RelComissoes;

{$R *.dfm}

Constructor TFrRelatorios.Create(AOwner : TComponent; DataBase : TDataBase);
Begin
  Inherited Create(Aowner);
  _DataBase := DataBase;
  ShowModal();
End;

procedure TFrRelatorios.Mn_RelatorioComissoesClick(Sender: TObject);
begin
  FrRelComissoes := TFrRelComissoes.Create(nil);
  FrRelComissoes.InicializaPropriedades(_Database);
  FrRelComissoes.ShowModal();
  FrRelComissoes.Release();
end;

end.
