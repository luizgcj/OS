unit DataBase;

interface

Uses
  FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.VCLUI.Wait,
  Data.DB, FireDAC.Comp.Client,FireDAC.Phys.MySQLDef, FireDAC.Phys.MySQL,
  FireDAC.Comp.UI, FireDAC.Phys.IBDef, FireDAC.Phys.IBBase, FireDAC.Phys.IB,
  Vcl.Forms;

Type TDataBase = Class
  BaseDados : TFDConnection;
  Empresa : TFDConnection;
  Recursos : TFDConnection;
  ADDriverMySQL : TFDPhysMySQLDriverLink;
  ADDriverIB: TFDPhysIBDriverLink;
  ADGUIxWaitCursor1: TFDGUIxWaitCursor;

  TrxReadOnly: TFDTransaction;
  TrxWriteOnly: TFDTransaction;

  TrxReadOnlyBase: TFDTransaction;
  TrxWriteOnlyBase: TFDTransaction;

  Private

    _CodigoEmpresa : Integer;
    _AliasEmpresa : String;
    Procedure SetCodigoEmpresa(CodigoEmpresa:Integer);

  Public
    bMySql :Boolean;
    sAliasEmpresa :String;
    Property AliasEmpresa : String Read _AliasEmpresa;
    Property CodigoEmpresa :Integer Read _CodigoEmpresa Write SetCodigoEmpresa;

    Constructor Create();
    Destructor Destroy();
End;

implementation

Constructor TDataBase.Create();
Begin
  Inherited Create();

  ADGUIxWaitCursor1 := TFDGUIxWaitCursor.Create(Application);
  ADGUIxWaitCursor1.Provider := 'Forms';

  ADDriverMySQL := TFDPhysMySQLDriverLink.Create(Application);
  ADDriverIB := TFDPhysIBDriverLink.Create(Application);

  BaseDados := TFDConnection.Create(Application);
  Empresa := TFDConnection.Create(Application);
  Recursos := TFDConnection.Create(Application);

//  TrxReadOnlyBase := TFDTransaction.Create(Application);
//  TrxReadOnlyBase.Connection := BaseDados;
//  TrxReadOnlyBase.Options.AutoCommit := True;
//  TrxReadOnlyBase.Options.AutoStart := True;
//  TrxReadOnlyBase.Options.AutoStop := True;
//
//  TrxWriteOnlyBase := TFDTransaction.Create(Application);
//  TrxWriteOnlyBase.Connection := BaseDados;
//  TrxWriteOnlyBase.Options.ReadOnly := False;
//  TrxWriteOnlyBase.Options.Isolation := xiReadCommitted;
//  TrxWriteOnlyBase.Options.AutoCommit := False;
//  TrxWriteOnlyBase.Options.AutoStart := False;
//  TrxWriteOnlyBase.Options.AutoStop := False;
//
//  TrxReadOnly := TFDTransaction.Create(Application);
//  TrxReadOnly.Connection := Empresa;
//  TrxReadOnly.Options.AutoCommit := True;
//  TrxReadOnly.Options.AutoStart := True;
//  TrxReadOnly.Options.AutoStop := True;
//
//  TrxWriteOnly := TFDTransaction.Create(Application);
//  TrxWriteOnly.Connection := Empresa;
//  TrxWriteOnly.Options.ReadOnly := False;
//  TrxWriteOnly.Options.Isolation := xiReadCommitted;
//  TrxWriteOnly.Options.AutoCommit := False;
//  TrxWriteOnly.Options.AutoStart := False;
//  TrxWriteOnly.Options.AutoStop := False;
End;

Destructor TDataBase.Destroy();
Begin
  BaseDados.Close();
  BaseDados.Free();

  Empresa.Close();
  Empresa.Free();

  Recursos.Close();
  Recursos.Free();

  ADGUIxWaitCursor1.Free();

  ADDriverMySQL.Free();
  ADDriverIB.Free();

  Inherited Destroy();
End;

Procedure TDataBase.SetCodigoEmpresa(CodigoEmpresa:Integer);
Var
  vQuery : TFDQuery;
Begin
  try
    vQuery := TFDQuery.Create(Application);
    vQuery.Connection := BaseDados;
    vQuery.SQL.Clear();
    vQuery.Sql.Add('Select                          ');
    vQuery.Sql.Add('D.CodigoEmpresa,                ');
    vQuery.Sql.Add('D.Alias                         ');
    vQuery.Sql.Add('From Dglob000 D                 ');
    vQuery.Sql.Add('Where                           ');
    vQuery.Sql.Add('D.CodigoEmpresa = :CodigoEmpresa');
    vQuery.ParamByName('CodigoEmpresa').AsInteger := CodigoEmpresa;
    vQuery.Open();
    vQuery.First();
    if Not vQuery.Eof then
      _AliasEmpresa := vQuery.FieldByName('Alias').AsString
    else
      _AliasEmpresa := '';
  finally
    _CodigoEmpresa := CodigoEmpresa;
  end;
End;

end.
