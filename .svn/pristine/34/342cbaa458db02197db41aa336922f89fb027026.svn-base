unit WindowsRecord;

interface

Uses
  System.Win.Registry,
  System.SysUtils,
  Winapi.Windows,cxGridCustomView, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxGrid,
  FuncoesGerais;

Type TWindowsRecord = Class abstract
  Class Procedure Write(NameRegister:String; KeyName : String; Value : String);
  Class Function Read(NameRegister:String; KeyName : String):String;
  Class procedure ReadRegEscCampos(Tabela : String; Grid : TcxGriddbTableView; CampoVisivel : Integer);
End;

Const
  FullPath = '\Software\Mais Solucoes\ORDEMSERVICO\';

implementation

Class Procedure TWindowsRecord.Write(NameRegister:String; KeyName : String; Value : String);
Var
  Reg   : TRegistry;
Begin
  Reg := TRegistry.Create;
  Try
    Reg.RootKey := HKEY_CURRENT_USER;
    Reg.OpenKey(FullPath + NameRegister + '\', True);
    Reg.WriteString(KeyName, Value);
  finally
    Reg.Free;
  end;
End;

Class Function TWindowsRecord.Read(NameRegister:String; KeyName : String):String;
Var
  Reg   : TRegistry;
  sPathAux : String;
Begin
  Result := '';
  Reg := TRegistry.Create;
  Try
    Reg.RootKey := HKEY_CURRENT_USER;
    sPathAux := FullPath + NameRegister + '\';
    if Reg.KeyExists(sPathAux) then
    Begin
      Reg.OpenKey(sPathAux, False);

      if Reg.ValueExists(KeyName) then
        Result := Reg.ReadString(KeyName);
    End;
  finally
    Reg.Free;
  end;
End;

Class procedure TWindowsRecord.ReadRegEscCampos(Tabela : String; Grid : TcxGriddbTableView; CampoVisivel : Integer);
var
    I     : Integer;
    Valor : String;
    Registro : String;
    Chave : String;
begin
  Registro := 'ESCCAMPOS\'+ Tabela + '\';
  Chave := 'Campos';
  Valor := TWindowsRecord.Read(Registro , Chave);

  if Trim(Valor) = '' then
  Begin
    for I := 0 to Grid.ColumnCount -1 do
      Valor := Valor + 'T';
    TWindowsRecord.Write(Registro, Chave, Valor);
  End;

  for I := 1 to Grid.ColumnCount do
    Grid.Columns[I - 1].Visible := TFuncoesGerais.StrToBoolean(Valor[I]);

  Grid.Columns[CampoVisivel].Visible := True;
end;

end.
