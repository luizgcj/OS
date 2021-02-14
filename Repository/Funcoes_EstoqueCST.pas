unit Funcoes_EstoqueCST;

interface

uses FireDac.Comp.Client, StdCtrls;

function ApenasNumerosStr(pStr:String): String;
function RetornaCodInternoProd(vCodProd:string;vCodigoEmp : Integer;Database:TFDConnection):Integer;
function GravarEstoqueCST(vCodProd, vCST:string;vQtdeAtual:Double;vCodigoEmp:Integer;DataBase:TFDConnection;GravarCB : Boolean = False):Boolean;
function ControlaEstoqueCB(vCodProd:string;vCodigoEmp : Integer;Database:TFDConnection):Boolean;
function RetornaEstoqueCST(vCodProd, vCST:string;vCodigoEmp : Integer;Database:TFDConnection):Double;
function ApagarEstoqueCST(vCodProd, vCST:string;vCodigoEmp : Integer;Database:TFDConnection;vApagaTudoProd : Boolean):Boolean;
function AtualizarEstoqueCST(vCodProd, vCST:string;vQtdeAtualizar:Double;vCodigoEmp:Integer;DataBase:TFDConnection):Boolean;
function RetornaCSTProduto(vCodProd:String;vCodigoEmp : Integer;Database:TFDConnection):String;
procedure CarregaComboCSTA(ComboCST:TComboBox;DataBase:TFDConnection);
function ValidaCSTA(CST_A:String;ComboCST:TComboBox; txtCSTA:TEdit; Database : TFDConnection):Boolean;
function BaixaEstoqueAutomaticoCST(vCodProd, vTabelaQuebra :string;vQtdeAtualizar:Double;NumDoc,NumItem,vCodigoEmp:Integer;DataBase:TFDConnection):Boolean;
function InsereTabelaQuebra(vCodProd, CodBarras, vCST, vTabelaQuebra : String; vQtdeBaixar : Double; NumDoc,NumItem, vCodigoEmp : Integer; DataBase :TFDConnection) : Boolean;
function EstornaBaixaAutomaticaCST(vCodProd, vTabelaQuebra :string;vQtdeAtualizar:Double;NumDoc,NumItem,vCodigoEmp:Integer;DataBase:TFDConnection;vDevolucao : Boolean = False):Boolean;
function BaixaEstoqueAutomaticoCSTDevolucao(vCodProd, vTabelaQuebra :string;vQtdeAtualizar:Double;NumDoc,NumItem,NumDev,NumItemDev, vCodigoEmp:Integer;DataBase:TFDConnection):Boolean;
function RetornaEstoqueAtual(vCodProd:string;vCodigoEmp : Integer;Database:TFDConnection):Double;
function RetornaEstoqueTotal(vCodProd:string;vCodigoEmp : Integer;Database:TFDConnection):Double;

implementation

uses SysUtils, Classes, Math;

function ApenasNumerosStr(pStr:String): String;
Var
I: Integer;
begin
  Result := '';
  For I := 1 To Length(pStr) do
   If pStr[I] In ['1','2','3','4','5','6','7','8','9','0'] Then
     Result := Result + pStr[I];
End;

function RetornaCodInternoProd(vCodProd:string;vCodigoEmp : Integer;Database:TFDConnection):Integer;
var
  vQuery : TFDQuery;
  vCodInteger : Integer;
begin
  vCodInteger := 0;
  if Length(Trim(vCodProd)) >= 7 then //Codigo de barras
  begin
    vQuery := TFDQuery.Create(nil);
    vQuery.Connection := Database;
    vQuery.Sql.Text   := 'SELECT CODIGOPRODUTO FROM PROXCODBARRAS WHERE CODIGOEMP=:CODIGOEMP AND COD_BARRAS=:COD_BARRAS';
    vQuery.ParamByName('CODIGOEMP').AsInteger    := vCodigoEmp;
    vQuery.ParamByName('COD_BARRAS').AsString    := vCodProd;
    vQuery.Open;

    Result := vQuery.FieldByName('CODIGOPRODUTO').AsInteger;
    vQuery.Close;
    vQuery.Free;
  end
  else
  begin
    if TryStrToInt(vCodProd,vCodInteger) then
      Result := vCodInteger
    else
      Result := 0;
  end;
end;

function ControlaEstoqueCB(vCodProd:string;vCodigoEmp : Integer;Database:TFDConnection):Boolean;
var
  vQuery : TFDQuery;
  vCodigoProduto : Integer;
begin
  vCodigoProduto := RetornaCodInternoProd(vCodProd,vCodigoEmp,DataBase);
  vQuery := TFDQuery.Create(nil);
  vQuery.Connection := Database;
  vQuery.Sql.Text   := 'SELECT CONTROLAESTOQUECB FROM PRODUTOS_EMP WHERE CODIGOPRODUTO=:CODIGOPRODUTO AND CODIGOEMP=:CODIGOEMP';
  vQuery.ParamByName('CODIGOPRODUTO').AsInteger   := vCodigoProduto;
  vQuery.ParamByName('CODIGOEMP').AsInteger       := vCodigoEmp;
  vQuery.Open;

  if vQuery.FieldByName('CONTROLAESTOQUECB').AsString = 'S' then
    Result := True
  else
    Result := False;

  vQuery.Close;
  vQuery.Free;
end;

function GravarEstoqueCST(vCodProd, vCST:string;vQtdeAtual:Double;vCodigoEmp:Integer;DataBase:TFDConnection;GravarCB : Boolean = False):Boolean;
var
  vQuery   : TFDQuery;
  vCodigoProduto : Integer;
begin
  try
    vCodigoProduto := RetornaCodInternoProd(vCodProd,vCodigoEmp,DataBase);
    vQuery := TFDQuery.Create(nil);
    vQuery.Connection := DataBase;
    vQuery.Sql.Text := ' INSERT INTO PRODUTOS_ESTOQUE (ICMS_A,CODIGOPRODUTO,CODBARRAS,QTDEATUAL,CODIGOEMP) '
                     + ' VALUES(:ICMS_A,:CODIGOPRODUTO,:CODBARRAS,:QTDEATUAL,:CODIGOEMP)';

    vQuery.ParamByName('ICMS_A').AsString            := vCST;
    vQuery.ParamByName('CODIGOPRODUTO').AsInteger    := vCodigoProduto;
    if ((Length(Trim(vCodProd)) >= 7) and (ControlaEstoqueCB(vCodProd,vCodigoEmp,DataBase))) or (GravarCB) then
      vQuery.ParamByName('CODBARRAS').AsString       := vCodProd
    else
      vQuery.ParamByName('CODBARRAS').AsString       := ' ';
    vQuery.ParamByName('QTDEATUAL').AsFloat          := vQtdeAtual;
    vQuery.ParamByName('CODIGOEMP').AsInteger        := vCodigoEmp;
    vQuery.ExecSQL;


    vQuery.Close;
    vQuery.Free;
    Result := True;
  except
    Result := False;
  end;
end;

function RetornaEstoqueCST(vCodProd, vCST:string;vCodigoEmp : Integer;Database:TFDConnection):Double;
var
  vQuery : TFDQuery;
  vCodigoProduto : Integer;
begin
  vCodigoProduto := RetornaCodInternoProd(vCodProd,vCodigoEmp,DataBase);
  vQuery := TFDQuery.Create(nil);
  vQuery.Connection := DataBase;
  vQuery.Sql.Text := 'SELECT QTDEATUAL FROM PRODUTOS_ESTOQUE WHERE CODIGOEMP =:CODIGOEMP AND ICMS_A=:ICMS_A';
  if (Length(Trim(vCodProd)) >= 7) and (ControlaEstoqueCB(vCodProd,vCodigoEmp,Database)) then
  begin
    vQuery.Sql.Add('AND CODBARRAS =:CODBARRAS');
    vQuery.ParamByName('CODBARRAS').AsString := Trim(vCodProd);
  end
  else
  begin
    vQuery.Sql.Add('AND CODIGOPRODUTO=:CODIGOPRODUTO');
    vQuery.ParamByName('CODIGOPRODUTO').AsInteger := vCodigoProduto;
  end;
  vQuery.ParamByName('CODIGOEMP').AsInteger := vCodigoEmp;
  vQuery.ParamByName('ICMS_A').AsString     := vCST;
  vQuery.Open; vQuery.First;
  Result := roundTo(vQuery.FieldByName('QTDEATUAL').AsFloat,-6);//Heraldo 27/10/2016
  vQuery.Close;
  vQuery.Free;
end;

function ApagarEstoqueCST(vCodProd, vCST:string;vCodigoEmp : Integer;Database:TFDConnection;vApagaTudoProd : Boolean):Boolean;
var
  vQuery : TFDQuery;
  vCodigoProduto : Integer;
begin
  try
    vCodigoProduto := RetornaCodInternoProd(vCodProd,vCodigoEmp,DataBase);
    vQuery := TFDQuery.Create(nil);
    vQuery.Connection := Database;

    vQuery.Sql.Text := 'DELETE FROM PRODUTOS_ESTOQUE ';
    if (Length(Trim(vCodProd)) >= 7) and (not vApagaTudoProd) then
    begin
      vQuery.Sql.Add('WHERE CODIGOEMP=:CODIGOEMP');
      vQuery.Sql.Add('AND ICMS_A=:ICMS_A');
      vQuery.Sql.Add('AND CODBARRAS =:CODBARRAS');
      vQuery.ParamByName('CODIGOEMP').AsInteger := vCodigoEmp;
      vQuery.ParamByName('CODBARRAS').AsString  := Trim(vCodProd);
      vQuery.ParamByName('ICMS_A').AsString     := vCST;
    end
    else if not vApagaTudoProd then
    begin
      vQuery.Sql.Add('WHERE CODIGOEMP=:CODIGOEMP');
      vQuery.Sql.Add('AND ICMS_A=:ICMS_A');
      vQuery.Sql.Add('AND CODIGOPRODUTO=:CODIGOPRODUTO');
      vQuery.ParamByName('CODIGOEMP').AsInteger := vCodigoEmp;
      vQuery.ParamByName('CODIGOPRODUTO').AsInteger := vCodigoProduto;
      vQuery.ParamByName('ICMS_A').AsString         := vCST;
    end
    else if vApagaTudoProd then
    begin
      vQuery.Sql.Add('WHERE CODIGOPRODUTO=:CODIGOPRODUTO');
      vQuery.ParamByName('CODIGOPRODUTO').AsInteger := vCodigoProduto;
    end;

    vQuery.ExecSQL;
    Result := True;

    vQuery.Close;
    vQuery.Free;
  except
    Result := False;
  end;
end;

function AtualizarEstoqueCST(vCodProd, vCST:string;vQtdeAtualizar:Double;vCodigoEmp:Integer;DataBase:TFDConnection):Boolean;
var
  vQuery : TFDQuery;
  vCodigoProduto : Integer;
begin
  try
    vCodigoProduto := RetornaCodInternoProd(vCodProd,vCodigoEmp,DataBase);
    vQuery := TFDQuery.Create(nil);
    vQuery.Connection := DataBase;
    vQuery.Sql.Text := 'SELECT * FROM PRODUTOS_ESTOQUE WHERE CODIGOEMP =:CODIGOEMP AND ICMS_A=:ICMS_A';
    if (Length(Trim(vCodProd)) >= 7) and (ControlaEstoqueCB(vCodProd,vCodigoEmp,DataBase)) then
    begin
      vQuery.Sql.Add('AND CODBARRAS =:CODBARRAS');
      vQuery.ParamByName('CODBARRAS').AsString := Trim(vCodProd);
    end
    else
    begin
      vQuery.Sql.Add('AND CODIGOPRODUTO=:CODIGOPRODUTO');
      vQuery.ParamByName('CODIGOPRODUTO').AsInteger := vCodigoProduto;
    end;
    vQuery.ParamByName('CODIGOEMP').AsInteger := vCodigoEmp;
    vQuery.ParamByName('ICMS_A').AsString     := vCST;
    vQuery.Open; vQuery.First;

    if vQuery.eof then //Se ainda não existe estoque por cst pra ser atualizado.
      GravarEstoqueCST(vCodProd,vCST,0,vCodigoEmp,DataBase);

    vQuery.Close;
    vQuery.Sql.Clear;

    vQuery.Sql.Text := 'UPDATE PRODUTOS_ESTOQUE SET QTDEATUAL = QTDEATUAL + :QTDEATUAL WHERE CODIGOEMP=:CODIGOEMP AND ICMS_A=:ICMS_A';
    if (Length(Trim(vCodProd)) >= 7) and (ControlaEstoqueCB(vCodProd,vCodigoEmp,DataBase)) then
    begin
      vQuery.Sql.Add('AND CODBARRAS =:CODBARRAS');
      vQuery.ParamByName('CODBARRAS').AsString := Trim(vCodProd);
    end
    else
    begin
      vQuery.Sql.Add('AND CODIGOPRODUTO=:CODIGOPRODUTO');
      vQuery.ParamByName('CODIGOPRODUTO').AsInteger := vCodigoProduto;
    end;
    vQuery.ParamByName('QTDEATUAL').AsFloat   := vQtdeAtualizar;
    vQuery.ParamByName('CODIGOEMP').AsInteger := vCodigoEmp;
    vQuery.ParamByName('ICMS_A').AsString     := vCST;
    vQuery.ExecSQL;

    Result := True;

    vQuery.Close;
    vQuery.Free;
  except
    Result := False;
  end;
end;

function RetornaCSTProduto(vCodProd:String;vCodigoEmp : Integer;Database:TFDConnection):String;
var
  vQuery : TFDQuery;
  vCodigoProduto : Integer;
begin
  vCodigoProduto := RetornaCodInternoProd(vCodProd,vCodigoEmp,DataBase);
  vQuery := TFDQuery.Create(nil);
  vQuery.Connection := DataBase;

  if (Length(Trim(vCodProd)) >= 7) and (ControlaEstoqueCB(vCodProd,vCodigoEmp,Database)) then
  begin
    vQuery.Sql.Text := ' SELECT ORIGEMMERCPRODUTO FROM '
                     + ' PROXCODBARRAS WHERE COD_BARRAS =:CODIGO AND CODIGOEMP=:CODIGOEMP';
    vQuery.ParamByName('CODIGO').AsString    := vCodProd;
  end
  else
  begin
    vQuery.Sql.Text := ' SELECT ORIGEMMERCPRODUTO FROM '
                     + ' PRODUTOS_EMP WHERE CODIGOPRODUTO =:CODIGO AND CODIGOEMP=:CODIGOEMP';
    vQuery.ParamByName('CODIGO').AsInteger   := vCodigoProduto;

  end;
  vQuery.ParamByName('CODIGOEMP').AsInteger := vCodigoEmp;
  vQuery.Open; vQuery.First;
  Result := vQuery.FieldByName('ORIGEMMERCPRODUTO').AsString;
  vQuery.Close;
  vQuery.Free;
end;

procedure CarregaComboCSTA(ComboCST:TComboBox;DataBase:TFDConnection);
var
  vQuery : TFDQuery;
begin
  vQuery := TFDQuery.Create(nil);
  vQuery.Connection := DataBase;

  vQuery.Sql.Text   := ' SELECT * FROM CST_TABELA_A ORDER BY CODIGO ';
  vQuery.Open; vQuery.First;

  ComboCST.Items.Clear;

  while not vQuery.eof do
  begin
    ComboCST.Items.Add(vQuery.FieldByName('CODIGO').AsString);
    vQuery.Next;
  end;

  vQuery.Close;
  vQuery.Free;
end;

function ValidaCSTA(CST_A:String;ComboCST:TComboBox; txtCSTA:TEdit;Database:TFDConnection):Boolean;
var
  vQuery : TFDQuery;
begin
  vQuery := TFDQuery.Create(nil);
  vQuery.Connection := DataBase;

  vQuery.Sql.Text   := ' SELECT * FROM CST_TABELA_A WHERE CODIGO=:CODIGO ORDER BY CODIGO ';
  vQuery.ParamByName('CODIGO').AsString := CST_A;
  vQuery.Open; vQuery.First;

  if vQuery.Eof then
  begin
    Result := False;
    if txtCSTA <> nil then
      txtCSTA.Text := '';
    if ComboCST <> nil then
      ComboCST.ItemIndex := -1;
  end
  else
  begin
    Result := True;
    if txtCSTA <> nil then
      txtCSTA.Text := vQuery.FieldByName('DESCRICAO').AsString;
    if ComboCST <> nil then
      ComboCST.ItemIndex := ComboCST.Items.IndexOf(vQuery.FieldByName('CODIGO').AsString);
  end;

  vQuery.Close;
  vQuery.Free;

end;


function InsereTabelaQuebra(vCodProd, CodBarras, vCST, vTabelaQuebra : String;  vQtdeBaixar : Double; NumDoc,NumItem, vCodigoEmp : Integer; DataBase :TFDConnection) : Boolean;
var
  vQuery : TFDQuery;
  vCodigoProduto : Integer;
begin
  try
    {padrão da tabela de quebra
    - numero do documento             | NUMDOC          integer
    - numero do item no documento     | NUMITEM         integer
    - codigo interno do produto       | CODPROD         integer
    - codigo de barras (se utlizado)  | CODBARRAS       varchar(20)
    - cst do produto                  | CST             varchar(1)
    - quantidade baixada do produto   | QUANT_BAIXA     double precision
    - codigo da empresa               | CODIGOEMP       integer
    }

    vCodigoProduto := RetornaCodInternoProd(vCodProd,vCodigoEmp,DataBase);

    vQuery := TFDQuery.Create(nil);
    vQuery.Connection := DataBase;

    vQuery.Sql.Text := ' INSERT INTO ' + vTabelaQuebra + ' (NUMDOC, NUMITEM, CODPROD, CODBARRAS, CST, QUANT_BAIXA, CODIGOEMP) '
                     + ' VALUES (:NUMDOC,:NUMITEM,:CODPROD,:CODBARRAS,:CST,:QUANT_BAIXA,:CODIGOEMP)';
    vQuery.ParamByName('NUMDOC').AsInteger          := NumDoc;
    vQuery.ParamByname('NUMITEM').AsInteger         := NumItem;
    vQuery.ParamByName('CODPROD').AsInteger         := vCodigoProduto;
    if Length(Trim(CodBarras)) > 6 then
      vQuery.ParamByName('CODBARRAS').AsString      := Trim(CodBarras)
    else
      vQuery.ParamByName('CODBARRAS').AsString      := '';
    vQuery.ParamByname('CST').AsString              := Trim(vCST);
    vQuery.ParamByName('QUANT_BAIXA').AsFloat       := vQtdeBaixar;
    vQuery.ParamByName('CODIGOEMP').AsInteger       := vCodigoEmp;
    vQuery.ExecSQL;

    Result := True;

    vQuery.Close;
    vQuery.Free;
  except
    Result := False;
  end;

end;

function BaixaEstoqueAutomaticoCST(vCodProd, vTabelaQuebra :string;vQtdeAtualizar:Double;NumDoc,NumItem,vCodigoEmp:Integer;DataBase:TFDConnection):Boolean;
var
  vQuery : TFDQuery;
  vCodigoProduto, i : Integer;
  vCst, vCodBarras  : String;
  vQtdePorCst,vQtdeBaixar, vQtdeBaixada, vQtdeBaixarCST : Double;
  vQuebra : Boolean;
begin
  try
    vQuebra        := False;
    vCodigoProduto := RetornaCodInternoProd(vCodProd,vCodigoEmp,DataBase);
    vCst           := RetornaCSTProduto(vCodProd, vCodigoEmp, DataBase);
    vQtdePorCst    := RetornaEstoqueCST(vCodProd, vCst, vCodigoEmp, DataBase);
    vQtdeBaixada   := 0;
    vQtdeBaixarCST := 0;
    if Length(vCodProd) > 6 then
      vCodBarras := vCodProd
    else
      vCodBarras := '';
    vQtdeBaixar    := vQtdePorCst; //variavel que controla a quantidade a ser baixada do cst padrao do produto
    if vQtdeAtualizar > vQtdePorCst then //Se a quantidade atual do cst for menor que a quantidade vendida, então tem que procurar em outros csts pra fazer as baixas
    begin
      //baixar do cst principal do produto
      vQtdeBaixada := vQtdePorCst;
      for i:=0 to 8 do
      begin
        if i <> StrToInt(vCst) then //o estoque do cst do item já foi levado em consideração, então não há motivos pra baixar dele novamente.
        begin
          vQtdePorCst := RetornaEstoqueCST(vCodProd, IntToStr(i), vCodigoEmp, DataBase);

          if vQtdePorCst > 0 then
          begin
            if vQtdePorCst + vQtdeBaixada < vQtdeAtualizar then
            begin
              vQtdebaixada := vQtdeBaixada + vQtdePorCst;
              //baixar o estoque do cst
              AtualizarEstoqueCST(vCodProd,IntToStr(i),vQtdePorCst *-1,vCodigoEmp, DataBase);
              vQtdeBaixarCST := vQtdePorCst;
              vQuebra := False;
            end
            else
            begin
              vQtdeBaixarCST := (vQtdeAtualizar - vQtdeBaixada);
              vQtdeBaixada := vQtdeBaixada + (vQtdeAtualizar - vQtdeBaixada);
              //baixar somente o necessário do cst do loop
              AtualizarEstoqueCST(vCodProd,IntToStr(i),vQtdeBaixarCST *-1,vCodigoEmp, DataBase);
              vQuebra := True; //deve-se quebrar o loop pois todo o estoque necessario para realizar a venda já foi baixado.
            end;
            //inserir este cst na tabela de quebra
            if not InsereTabelaQuebra(vCodProd,vCodBarras,IntToStr(i),vTabelaQuebra, vQtdeBaixarCST, NumDoc, NumItem, vCodigoEmp, DataBase) then
              Result := False;

            if vQuebra then
              break; //quebrar o loop
          end;
        end;
      end;
      if vQtdeBaixada < vQtdeAtualizar then
        vQtdebaixar := vQtdebaixar + (vQtdeAtualizar - vQtdeBaixada);
      AtualizarEstoqueCST(vCodProd,vCst,vQtdebaixar*-1,vCodigoEmp, DataBase);
    end
    else
    begin
      vQtdeBaixar := vQtdeAtualizar;
      AtualizarEstoqueCST(vCodProd,vCst,vQtdeAtualizar*-1,vCodigoEmp, DataBase);
    end;
    if RoundTo(vQtdeBaixar,-8) > 0 then
    begin
      if not InsereTabelaQuebra(vCodProd,vCodBarras, vCst ,vTabelaQuebra, vQtdeBaixar, NumDoc, NumItem, vCodigoEmp, DataBase) then
        Result := False;
    end;
    Result := True;
  except
    Result := False;
  end;
end;

function EstornaBaixaAutomaticaCST(vCodProd, vTabelaQuebra :string;vQtdeAtualizar:Double;NumDoc,NumItem,vCodigoEmp:Integer;DataBase:TFDConnection; vDevolucao : Boolean = False):Boolean;
var
  vQuery : TFDQuery;
  vCodigoProduto : Integer;
  pCodProd : String;
  vCst     : String;
  vQtdeBaixar : Double;
begin
  try
    {padrão da tabela de quebra
    - numero do documento             | NUMDOC          integer
    - numero do item no documento     | NUMITEM         integer
    - codigo interno do produto       | CODPROD         integer
    - codigo de barras (se utlizado)  | CODBARRAS       varchar(20)
    - cst do produto                  | CST             varchar(1)
    - quantidade baixada do produto   | QUANT_BAIXA     double precision
    - codigo da empresa               | CODIGOEMP       integer
    }

    vCodigoProduto := RetornaCodInternoProd(vCodProd,vCodigoEmp,DataBase);
    vQuery := TFDQuery.Create(nil);
    vQuery.Connection := DataBase;

    vQuery.Sql.Text := ' SELECT * FROM ' + vTabelaQuebra + ' WHERE NUMDOC=:NUMDOC '
                     + ' AND CODIGOEMP =:CODIGOEMP '
                     + ' AND CODPROD =:CODPROD '
                     + ' AND NUMITEM =:NUMITEM ';
    if Length(vCodProd) > 6 then
      vQuery.Sql.Add('AND CODBARRAS =:CODBARRAS');
    vQuery.ParamByName('NUMDOC').AsInteger       := NumDoc;
    vQuery.ParamByName('CODIGOEMP').AsInteger    := vCodigoEmp;
    vQuery.ParamByName('CODPROD').AsInteger      := vCodigoProduto;
    vQuery.ParamByName('NUMITEM').AsInteger      := NumItem;
    if Length(vCodProd) > 6 then
      vQuery.ParamByName('CODBARRAS').AsString   := vCodProd;
    vQuery.Open;
    vQuery.First;
    if not vQuery.eof then
    begin
      while not vQuery.eof do
      begin
        if vQuery.FieldByName('CODBARRAS').AsString <> '' then
          pCodProd := vQuery.FieldByName('CODBARRAS').AsString
        else
          pCodProd := vQuery.FieldByName('CODPROD').AsString;

        vQtdeBaixar :=  vQuery.FieldByName('QUANT_BAIXA').AsFloat;
        if vDevolucao then
          vQtdeBaixar := vQtdeBaixar * -1;

        AtualizarEstoqueCST(pCodProd, vQuery.FieldByName('CST').AsString,vQtdeBaixar, vCodigoEmp, DataBase);
        vQuery.Next;
      end;
    end
    else //se não utilizou baixa automática, então é um documento anterior a criação da tabela de quebra, devendo estornar o estoque de acordo com o CST informado no cadastro do produto
    begin
      vCST := RetornaCSTProduto(vCodProd,vCodigoEmp,DataBase);
      AtualizarEstoqueCST(vCodProd, vCST, vQtdeAtualizar, vCodigoEmp, DataBase);
    end;

    vQuery.Close;
    vQuery.Sql.Text := ' DELETE FROM ' + vTabelaQuebra + ' WHERE NUMDOC=:NUMDOC '
                     + ' AND CODIGOEMP=:CODIGOEMP '
                     + ' AND CODPROD =:CODPROD '
                     + ' AND NUMITEM =:NUMITEM ';
    if Length(vCodProd) > 6 then
      vQuery.Sql.Add('AND CODBARRAS =:CODBARRAS');
    vQuery.ParamByName('NUMDOC').AsInteger       := NumDoc;
    vQuery.ParamByName('CODIGOEMP').AsInteger    := vCodigoEmp;
    vQuery.ParamByName('CODPROD').AsInteger      := vCodigoProduto;
    if Length(vCodProd) > 6 then
      vQuery.ParamByName('CODBARRAS').AsString   := vCodProd;
    vQuery.ExecSQL;

    Result := True;

    vQuery.Close;
    vQuery.Free;
  except
    Result := False;
  end;
end;

function BaixaEstoqueAutomaticoCSTDevolucao(vCodProd, vTabelaQuebra :string;vQtdeAtualizar:Double;NumDoc,NumItem,NumDev,NumItemDev, vCodigoEmp:Integer;DataBase:TFDConnection):Boolean;
var
  vQuery : TFDQuery;
  vCodigoProduto : Integer;
  vCst, vCodBarras  : String;
  vQtdeBaixar, vQtdeBaixada : Double;
  vQuebra : Boolean;
  vQtdeTotal : Double;
begin
  try
    vQuebra        := False;
    vCodigoProduto := RetornaCodInternoProd(vCodProd,vCodigoEmp,DataBase);
    if Length(vCodProd) > 6 then
      vCodBarras := vCodProd
    else
      vCodBarras := '';

    vQuery := TFDQuery.Create(nil);
    vQuery.Connection := DataBase;

    vQuery.Close;
    vQuery.Sql.Text := ' SELECT * FROM ' + vTabelaQuebra
                     + ' WHERE NUMDOC =:NUMDOC AND NUMITEM=:NUMITEM AND CODIGOEMP=:CODIGOEMP'
                     + ' ORDER BY CST ' ;
    vQuery.ParamByName('NUMDOC').AsInteger     := NumDoc;
    vQuery.ParamByName('NUMITEM').AsInteger    := NumItem;
    vQuery.ParamByName('CODIGOEMP').AsInteger  := vCodigoEmp;
    vQuery.Open;
    vQuery.First;

    if vQuery.eof then //se o pedido não foi gerado a partir de uma baixa automatica, então deve-se voltar o estoque atraves do cst cadastrado no item
    begin
      vCst         := RetornaCSTProduto(vCodProd, vCodigoEmp, DataBase);
      AtualizarEstoqueCST(vCodProd,vCst,vQtdeAtualizar ,vCodigoEmp, DataBase);
      if not InsereTabelaQuebra(vCodProd,vCodBarras,vCst,'ITPEDIDODEV_CST', vQtdeAtualizar, NumDev, NumItemDev, vCodigoEmp, DataBase) then
        Result := False;
    end
    else
    begin
      vQuery.First;
      vQtdeBaixada := 0; vQtdeBaixar := 0;
      while not vQuery.Eof do
      begin
        if vQtdeAtualizar <= vQuery.FieldByName('QUANT_BAIXA').AsFloat then
        begin
          AtualizarEstoqueCST(vCodProd, vQuery.FieldByName('CST').AsString, vQtdeAtualizar, vCodigoEmp, DataBase);
          if not InsereTabelaQuebra(vCodProd,vCodBarras,vQuery.FieldByName('CST').AsString,'ITPEDIDODEV_CST', vQtdeAtualizar, NumDev, NumItemDev, vCodigoEmp, DataBase) then
            Result := False;
          break;
        end
        else
        begin
          if vQuery.FieldByName('QUANT_BAIXA').AsFloat + vQtdeBaixada < vQtdeAtualizar then
          begin
            vQtdeBaixar := vQuery.FieldByName('QUANT_BAIXA').AsFloat;
            vQuebra     := False;
          end
          else
          begin
            vQtdeBaixar :=  vQtdeAtualizar - vQtdeBaixada ; //(vQtdeBaixada + vQuery.FieldByName('QUANT_BAIXA').AsFloat) - vQtdeAtualizar;
            vQuebra     := True;
          end;
          vQtdeBaixada := vQtdeBaixada + vQtdeBaixar; // vQuery.FieldByName('QUANT_BAIXA').AsFloat;

          AtualizarEstoqueCST(vCodProd, vQuery.FieldByName('CST').AsString, vQtdeBaixar, vCodigoEmp, DataBase);
          if not InsereTabelaQuebra(vCodProd,vCodBarras,vQuery.FieldByName('CST').AsString,'ITPEDIDODEV_CST', vQtdeBaixar, NumDev, NumItemDev, vCodigoEmp, DataBase) then
            Result := False;

          if vQuebra then
            break;
        end;
        vQuery.Next;
      end;
    end;

    Result := True;
    vQuery.Close;
    vQuery.Free;
  except
    Result := False;
  end;
end;


function RetornaEstoqueAtual(vCodProd:string;vCodigoEmp : Integer;Database:TFDConnection):Double;
var
  vQuery : TFDQuery;
  vCodigoProduto : Integer;
begin
  vCodigoProduto := RetornaCodInternoProd(vCodProd,vCodigoEmp,DataBase);
  vQuery := TFDQuery.Create(nil);
  vQuery.Connection := DataBase;
  vQuery.Sql.Text := '';
  if (Length(Trim(vCodProd)) >= 7) and (ControlaEstoqueCB(vCodProd,vCodigoEmp,Database)) then
  begin
    vQuery.Sql.Add('SELECT QTDEATUALPRODUTO FROM PROXCODBARRAS WHERE CODIGOEMP =:CODIGOEMP');
    vQuery.Sql.Add('AND COD_BARRAS =:COD_BARRAS');
    vQuery.ParamByName('COD_BARRAS').AsString := Trim(vCodProd);
  end
  else
  begin
    vQuery.Sql.Add('SELECT QTDEATUALPRODUTO FROM PRODUTOS_EMP WHERE CODIGOEMP =:CODIGOEMP');
    vQuery.Sql.Add('AND CODIGOPRODUTO=:CODIGOPRODUTO');
    vQuery.ParamByName('CODIGOPRODUTO').AsInteger := vCodigoProduto;
  end;
  vQuery.ParamByName('CODIGOEMP').AsInteger := vCodigoEmp;
  vQuery.Open; vQuery.First;
  Result := vQuery.FieldByName('QTDEATUALPRODUTO').AsFloat;
  vQuery.Close;
  vQuery.Free;
end;

function RetornaEstoqueTotal(vCodProd:string;vCodigoEmp : Integer;Database:TFDConnection):Double;
var
  vQuery : TFDQuery;
  vCodigoProduto : Integer;
begin
  vCodigoProduto := RetornaCodInternoProd(vCodProd,vCodigoEmp,DataBase);
  vQuery := TFDQuery.Create(nil);
  vQuery.Connection := DataBase;
  vQuery.Sql.Text := 'SELECT SUM(QTDEATUAL) AS QTDEATUAL FROM PRODUTOS_ESTOQUE WHERE CODIGOEMP =:CODIGOEMP';
  if (Length(Trim(vCodProd)) >= 7) and (ControlaEstoqueCB(vCodProd,vCodigoEmp,Database)) then
  begin
    vQuery.Sql.Add('AND CODBARRAS =:CODBARRAS');
    vQuery.ParamByName('CODBARRAS').AsString := Trim(vCodProd);
  end
  else
  begin
    vQuery.Sql.Add('AND CODIGOPRODUTO=:CODIGOPRODUTO');
    vQuery.ParamByName('CODIGOPRODUTO').AsInteger := vCodigoProduto;
  end;
  vQuery.ParamByName('CODIGOEMP').AsInteger := vCodigoEmp;
  vQuery.Open; vQuery.First;
  Result := vQuery.FieldByName('QTDEATUAL').AsFloat;
  vQuery.Close;
  vQuery.Free;
end;

end.
