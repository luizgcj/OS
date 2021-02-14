unit ConexaoBanco;

interface

uses Classes, SysUtils, Db, DataSetFactory, DataBase;

Type TConexaoBanco = Class
  public
  DataSetFactory : TDataSetFactory;
  Param : TParams;
  Sql :TStringList;

  Procedure Clear();
  Procedure ClearParam();
  Constructor Create(vDataBase:TDataBase);
  Destructor Destroy();
End;

implementation

Constructor TConexaoBanco.Create(vDataBase:TDataBase);
Begin
	Inherited Create();
	DataSetFactory := TDataSetFactory.Create(vDataBase);
  Param := TParams.Create();
  Sql := TStringList.Create();
  Sql.Clear();
End;

Destructor TConexaoBanco.Destroy();
Begin
	Inherited Destroy();
End;

Procedure TConexaoBanco.Clear();
Begin
  Sql.Clear();
  ClearParam();
End;

Procedure TConexaoBanco.ClearParam();
Begin
  Param := TParams.Create();
End;

end.
