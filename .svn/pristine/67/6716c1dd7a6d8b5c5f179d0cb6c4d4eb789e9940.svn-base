unit Parametros;

interface
Uses
  Data.DB, Datasnap.DBClient, System.SysUtils,
  DataBase, EnumConexao, ConexaoBanco;

Type TParametros = Class Abstract
  Class Function VerificaParametros(Identificador: String; Tipo: String; DataBase: TDataBase):String;
  Class Procedure GravarParametros(Identificador, Tipo, Descricao: String; Valor : Variant; DataBase: TDataBase);
End;

implementation

Class Function TParametros.VerificaParametros(Identificador: String; Tipo: String; DataBase: TDataBase):String;
Var
  ConexaoBanco : TConexaoBanco;
  DataSet : TDataSet;
Begin
  If (Tipo = 'V') Then
     Result := ''
  Else If (Tipo = 'I') Then
     Result := IntToStr(0)
  Else If (Tipo = 'D') Then
     Result := IntToStr(0)
  Else If (Tipo = 'B') Then
     Result := ''
  Else If (Tipo = 'T') Then
     Result := DateToStr(Date);


  ConexaoBanco := TConexaoBanco.Create(DataBase);
  ConexaoBanco.Sql.Add('Select                                ');
  ConexaoBanco.Sql.Add('P.V_Integer,                          ');
  ConexaoBanco.Sql.Add('P.V_DoublePrecision,                  ');
  ConexaoBanco.Sql.Add('P.V_Varchar,                          ');
  ConexaoBanco.Sql.Add('P.V_TimesTamp,                        ');
  ConexaoBanco.Sql.Add('P.V_Blob                              ');
  ConexaoBanco.Sql.Add('From Parametros P                     ');
  ConexaoBanco.Sql.Add('Where                                 ');
  ConexaoBanco.Sql.Add('P.Identificador = :Identificador      ');
  ConexaoBanco.Sql.Add('And P.CodigoEmpresa = :CodigoEmp      ');
  ConexaoBanco.Param.ParamByName('Identificador').AsString := Identificador;
  ConexaoBanco.Param.ParamByName('CodigoEmp').AsInteger := DataBase.CodigoEmpresa;
  DataSet := ConexaoBanco.DataSetFactory.GetDataSet(TConexao.BaseDados, ConexaoBanco.sql.Text, ConexaoBanco.Param);
  DataSet.First();

  if (not DataSet.Eof) then
  Begin
    if (Tipo = 'V') then
      Result := DataSet.FieldByName('V_Varchar').AsString
    else if (Tipo = 'I') then
      Result := IntToStr(DataSet.FieldByName('V_Integer').AsInteger)
    else if (Tipo = 'D') then
      Result := FloatToStr(DataSet.FieldByName('V_DoublePrecision').AsFloat)
    Else if (Tipo = 'B') then
      Result := DataSet.FieldByName('V_Blob').AsString
    Else if (Tipo = 'T') then
    Begin
      if (Not DataSet.FieldByName('V_TimesTamp').IsNull) then
        Result := DataSet.FieldByName('V_TimesTamp').AsString;
    End;
  End;

  ConexaoBanco.Free();
end;

Class Procedure TParametros.GravarParametros(Identificador, Tipo, Descricao: String; Valor : Variant; DataBase: TDataBase);
Var
  ConexaoBanco : TConexaoBanco;
  DataSet : TDataSet;
  sTipoParametro : String;
Begin
  If (Tipo = 'V') Then
     sTipoParametro := 'V_VARCHAR'
  Else If (Tipo = 'I') Then
     sTipoParametro := 'V_INTEGER'
  Else If (Tipo = 'D') Then
     sTipoParametro := 'V_DOUBLEPRECISION'
  Else If (Tipo = 'B') Then
     sTipoParametro := 'V_BLOB'
  Else If (Tipo = 'T') Then
     sTipoParametro := 'V_TIMESTAMP';


  ConexaoBanco := TConexaoBanco.Create(DataBase);
  ConexaoBanco.Sql.Add('UPDATE OR INSERT INTO PARAMETROS  (     ');
  ConexaoBanco.Sql.Add('CODIGOEMPRESA, IDENTIFICADOR, CLASSE, DESCRICAO, ' + sTipoParametro);
  ConexaoBanco.Sql.Add(') VALUES (:CODIGOEMPRESA, :IDENTIFICADOR, :CLASSE, :DESCRICAO, :' + sTipoParametro + ')');

  ConexaoBanco.Param.ParamByName('IDENTIFICADOR').AsString := Identificador;
  ConexaoBanco.Param.ParamByName('CODIGOEMPRESA').AsInteger := DataBase.CodigoEmpresa;
  ConexaoBanco.Param.ParamByName('CLASSE').AsString := 'OS';
  ConexaoBanco.Param.ParamByName('DESCRICAO').AsString := Descricao;
  ConexaoBanco.Param.ParamByName(sTipoParametro).Value := Valor;
  ConexaoBanco.DataSetFactory.PostDataSet(TConexao.BaseDados, ConexaoBanco.sql.Text, ConexaoBanco.Param);
  ConexaoBanco.Free();
end;

end.
