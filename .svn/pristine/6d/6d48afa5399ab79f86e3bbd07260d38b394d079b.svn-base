unit Excel;

interface

Uses
  System.Variants,
  Vcl.Forms,
  System.Win.ComObj,
  Winapi.Windows;


Type TExcel = Class
  Private
  _objExcel : Variant;
  _Sheet : Variant;
  _Title : String;
  Public

  Property Sheet : Variant Read _Sheet Write _Sheet;
  Property Title : string Read _Title;

  Function CreateObjectExcel(Title : String; SheetName : String) : Boolean;
  Procedure VisibleExcel();
  Constructor Create();
  Destructor Destroy();
End;

const
{$Region 'Variaveis de Excel'}
  {$Region 'Alinhamento'}
    Direita = 4;
    Esquerda = 2;
    Centro = 3;
  {$EndRegion}
  {$Region 'Espessura da Linha'}
  xlHairline = $00000001;
  xlMedium = $FFFFEFD6;
  xlThick = $00000004;
  xlThin = $00000002;
  {$EndRegion}
  {$Region 'Posição da Celula que se deseja colocar a Borda'}
  xlInsideHorizontal = $0000000C;
  xlInsideVertical = $0000000B;
  xlDiagonalDown = $00000005;
  xlDiagonalUp = $00000006;
  xlEdgeBottom = $00000009;
  xlEdgeLeft = $00000007;
  xlEdgeRight = $0000000A;
  xlEdgeTop = $00000008;
  {$EndRegion}
{$EndRegion}

implementation

Constructor TExcel.Create();
Begin
  Inherited Create();
End;

Destructor TExcel.Destroy();
Begin
  Inherited Destroy();
End;

Function TExcel.CreateObjectExcel(Title : String; SheetName : String) : Boolean;
Begin
  Result := False;
  _Title := Title;
  try
    _objExcel := CreateOleObject('Excel.Application');
    _objExcel.Caption := _Title;
    _objexcel.Workbooks.add(1);
    _objExcel.Workbooks[1].WorkSheets[1].Name := SheetName;
    _Sheet := _objExcel.Workbooks[1].WorkSheets[SheetName];
    Result := True;
  except
    Application.MessageBox('Não foi possível gerar a planilha!','Atenção',MB_ICONEXCLAMATION + MB_OK);
  end;
End;

Procedure TExcel.VisibleExcel();
Begin
  _objExcel.Visible := True;
End;

end.
