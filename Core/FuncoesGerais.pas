unit FuncoesGerais;

interface

Uses
  System.SysUtils,
  System.StrUtils,
  Winapi.Windows, Database, ConexaoBanco, Data.Db, EnumConexao;

Type TFuncoesGerais = Class Abstract
  Private

  Public
    Class Function GetBuildInfo(Prog: String):string;
    Class Function ApenasNumeros(Value : String):String;
    Class Function StrToBoolean(Value : String):Boolean;
    Class Function BooleanToStr(Value : Boolean):String;
    Class function AnsiToAscii(Value : String):String;
    Class function AplicaMascaraTelefone(Telefone : String) : String;
    class function RetiraCaracteresEspeciais(Palavra : String) : String;
    class function VerificaVersaoAplicativo(Database : TDatabase; Aplicativo : String) : Boolean;
End;

implementation

Class Function TFuncoesGerais.GetBuildInfo(Prog: String):string;
var
  VerInfoSize: DWORD;
  VerInfo: Pointer;
  VerValueSize: DWORD;
  VerValue: PVSFixedFileInfo;
  Dummy: DWORD;
  V1, V2, V3, V4: Word;
begin
  VerInfoSize := GetFileVersionInfoSize(PChar(prog), Dummy);

  If VerInfoSize > 0 then
  Begin
    GetMem(VerInfo, VerInfoSize);
    GetFileVersionInfo(PChar(prog), 0, VerInfoSize, VerInfo);
    VerQueryValue(VerInfo, '\', Pointer(VerValue), VerValueSize);

    with VerValue^ do
    begin
      V1 := dwFileVersionMS shr 16;
      V2 := dwFileVersionMS and $FFFF;
      V3 := dwFileVersionLS shr 16;
      V4 := dwFileVersionLS and $FFFF;
    end;
    FreeMem(VerInfo, VerInfoSize);
    result := IntToStr(v1) + '.' + IntToStr(v2) + '.'
      + IntToStr(v3) + '.' + IntToStr(v4);
  End
  Else
    Result := 'Não Informada.';
end;


Class Function TFuncoesGerais.ApenasNumeros(Value : String):String;
Var
  I : Integer;
Begin
  Result := '';
  For I := 1 To Length(Value) do
   If Value[I] In ['1','2','3','4','5','6','7','8','9','0'] Then
     Result := Result + Value[I];
End;


Class Function TFuncoesGerais.StrToBoolean(Value : String):Boolean;
Begin
  Result := Value = 'T';
End;

Class Function TFuncoesGerais.BooleanToStr(Value : Boolean):String;
Begin
  Result := ifThen(Value = True, 'T', 'F');
End;

Class Function TFuncoesGerais.AnsiToAscii(Value:String):String;
var
i: Integer;
begin
  for i := 1 to Length ( value ) do
    case value[i] of
      'á': value[i] := 'a';
      'é': value[i] := 'e';
      'í': value[i] := 'i';
      'ó': value[i] := 'o';
      'ú': value[i] := 'u';
      'à': value[i] := 'a';
      'è': value[i] := 'e';
      'ì': value[i] := 'i';
      'ò': value[i] := 'o';
      'ù': value[i] := 'u';
      'â': value[i] := 'a';
      'ê': value[i] := 'e';
      'î': value[i] := 'i';
      'ô': value[i] := 'o';
      'û': value[i] := 'u';
      'ä': value[i] := 'a';
      'ë': value[i] := 'e';
      'ï': value[i] := 'i';
      'ö': value[i] := 'o';
      'ü': value[i] := 'u';
      'ã': value[i] := 'a';
      'õ': value[i] := 'o';
      'ñ': value[i] := 'n';
      'ç': value[i] := 'c';
      'Á': value[i] := 'A';
      'É': value[i] := 'E';
      'Í': value[i] := 'I';
      'Ó': value[i] := 'O';
      'Ú': value[i] := 'U';
      'À': value[i] := 'A';
      'È': value[i] := 'E';
      'Ì': value[i] := 'I';
      'Ò': value[i] := 'O';
      'Ù': value[i] := 'U';
      'Â': value[i] := 'A';
      'Ê': value[i] := 'E';
      'Î': value[i] := 'I';
      'Ô': value[i] := 'O';
      'Û': value[i] := 'U';
      'Ä': value[i] := 'A';
      'Ë': value[i] := 'E';
      'Ï': value[i] := 'I';
      'Ö': value[i] := 'O';
      'Ü': value[i] := 'U';
      'Ã': value[i] := 'A';
      'Õ': value[i] := 'O';
      'Ñ': value[i] := 'N';
      'Ç': value[i] := 'C';
    end;
  Result := value;
end;

class function TFuncoesGerais.AplicaMascaraTelefone(Telefone : String):String;
begin
    if (Length(trim(Telefone)) =10) then  //3732150000
     result := '(' + copy(Telefone,1,2) + ')' + ' ' + Copy(Telefone,3,4) + '-'  + Copy(Telefone,7,4)
   else if (Length(Trim(Telefone)) = 12) then
      result := '(' + copy(Telefone,1,2) + ')' + ' ' + Copy(Telefone, 3,6) + '-' + Copy(Telefone, 9,4)
   else if (Length(trim(Telefone)) >10) then //37 32150000
     result := '(' + copy(Telefone,1,2) + ')' + ' ' + Copy(Telefone,3,5) + '-'  + Copy(Telefone,8,4)
   else if (Length(trim(Telefone)) =8) then //32150000
     result := '(  )' + ' ' + Copy(Telefone,1,4) + '-'  + Copy(Telefone,5,4)
   else if (Length(trim(Telefone))=9) then //991990000
      result := '(  )' + ' ' + Copy(Telefone,1,5) + '-'  + Copy(Telefone,6,4);
end;

class function TFuncoesGerais.RetiraCaracteresEspeciais(Palavra : String) : String;
Var
I: Integer;
begin
  Result := '';
  For I := 1 To Length(Palavra) do
   If Palavra[I] In ['1','2','3','4','5','6','7','8','9','0'] Then
     Result := Result + Palavra[I];
end;

class function TFuncoesGerais.VerificaVersaoAplicativo(Database : TDatabase; Aplicativo : String) : Boolean;
var ConexaoBanco : TConexaoBanco;
  Dataset : TDataset;
begin
  Result := False;
  ConexaoBanco := TConexaoBanco.Create(Database);
  ConexaoBanco.SQL.Add('SELECT COALESCE(ORDEMSERVICO, 0) AS ORDEMSERVICO FROM VRS WHERE CODIGO = 1');
  Dataset := ConexaoBanco.DataSetFactory.GetDataSet(TConexao.Basedados, ConexaoBanco.SQL.Text);

  if (Dataset.Eof) or (Dataset.FieldByName('ORDEMSERVICO').AsInteger <= StrToInt(Self.ApenasNumeros(Self.GetBuildInfo(Aplicativo)))) then
  begin
    ConexaoBanco.SQL.Clear();
    ConexaoBanco.SQL.Add('UPDATE VRS SET ORDEMSERVICO = :VERSAO WHERE CODIGO = 1');
    ConexaoBanco.Param.ParamByName('VERSAO').AsInteger := StrToInt(Self.ApenasNumeros(Self.GetBuildInfo(Aplicativo)));
    ConexaoBanco.DataSetFactory.PostDataSet(TConexao.BaseDados, ConexaoBanco.SQL.Text, ConexaoBanco.Param);
    Result := True;
  end
  else if Dataset.FieldByName('ORDEMSERVICO').AsInteger <= StrToInt(Self.ApenasNumeros(Self.GetBuildInfo(Aplicativo))) then
    Result := True;
  ConexaoBanco.Free();
end;

end.
