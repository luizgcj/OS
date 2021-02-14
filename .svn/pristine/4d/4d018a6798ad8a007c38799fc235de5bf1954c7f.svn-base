unit CtReceber;

interface

Uses
  Vcl.Forms,
  Winapi.Windows,
  System.Math,
  System.SysUtils,
  BoundObject,
  Data.Db,
  DataSnap.DbClient,
  CustomMessage,
  DataBase,
  CustomExcept;

Type TCtReceber = Class(TBoundObject)
  Private
    _cdsCtRec  : TClientDataSet;
    _Alteracao : Boolean;
    _MaquinaCartao : Integer;
    _AutorizacaoOperadora : String;
    _TitularCartao : String;
    _ParcelasCartao : Integer;
    _CodPlanoCartao : Integer;
    _CodContaAux : Integer;
    _CodPlanoCtCred : Integer;
    _CodPlanoCtDeb  : Integer;
    _PlanoCtCred : String;
    _PlanoCtDeb : String;
    _CodContaCred : Integer;
    _CodFornec : Integer;
    _DiasAdic : Integer;
    _TxAdmin : Double;


    {$Region 'Set Binding'}
    Procedure SetMaquinaCartao(MaquinaCartao : Integer);
    Procedure SetAutorizacaoOperadora(AutorizacaoOperadora : String);
    Procedure SetTitularCartao(TitularCartao : String);
    Procedure SetParcelasCartao(ParcelasCartao : Integer);
    Procedure SetCodPlanoCartao(CodPlanoCartao : Integer);
    Procedure SetCodContaAux(CodContaAux : Integer);
    Procedure SetCodPlanoCtCred(CodPlanoCtCred : Integer);
    Procedure SetCodPlanoCtDeb(CodPlanoCtDeb : Integer);
    Procedure SetPlanoCtCred(PlanoCtCred : String);
    Procedure SetPlanoCtDeb(PlanoCtDeb: String);
    Procedure SetCodContaCred(CodContaCred : Integer);
    Procedure SetCodFornec(CodFornec : Integer);
    Procedure SetDiasAdic(DiasAdic : Integer);
    Procedure SetTxAdmin(TxAdmin : Double);
    {$EndRegion}


    Procedure LimpaObjeto();
  Public

    Property Alteracao : Boolean Read _Alteracao Write _Alteracao;
    Property MaquinaCartao : Integer Read _MaquinaCartao Write SetMaquinaCartao;
    Property AutorizacaoOperadora : String Read _AutorizacaoOperadora Write SetAutorizacaoOperadora;
    Property TitularCartao : String Read _TitularCartao Write SetTitularCartao;
    Property ParcelasCartao : Integer Read _ParcelasCartao Write SetParcelasCartao;
    Property CodPlanoCartao : Integer Read _CodPlanoCartao Write SetCodPlanoCartao;
    Property CodContaAux : Integer Read _CodContaAux Write SetCodContaAux;
    Property CodPlanoCtCred : Integer Read _CodPlanoCtCred Write SetCodPlanoCtCred;
    Property CodPlanoCtDeb : Integer Read _CodPlanoCtDeb Write SetCodPlanoCtDeb;
    Property PlanoCtCred : String Read _PlanoCtCred Write SetPlanoCtCred;
    Property PlanoCtDeb : String Read _PlanoCtDeb Write SetPlanoCtDeb;
    Property CodContaCred : Integer Read _CodContaCred Write SetCodContaCred;
    Property CodFornec : Integer Read _CodFornec Write SetCodFornec;
    Property DiasAdic : Integer Read _DiasAdic Write SetDiasAdic;
    Property TxAdmin : Double Read _TxAdmin Write SetTxAdmin;


    Property cdsCtRec : TClientDataSet Read _cdsCtRec Write _cdsCtRec;

    Constructor Create();

End;

implementation

Constructor TCtReceber.Create();
{$Region 'Biding'}
  Procedure CriaCampos();
  Begin
    _CdsCtRec.FieldDefs.Add('Item', FtString, 3);
    _CdsCtRec.FieldDefs.Add('NumDocumento', FtString, 200);
    _CdsCtRec.FieldDefs.Add('DiasParcela', FtInteger);
    _CdsCtRec.FieldDefs.Add('DataVencimento', FtDateTime);
    _CdsCtRec.FieldDefs.Add('ValorDocumento', FtFloat);
    _CdsCtRec.FieldDefs.Add('TaxaCartao', FtFloat);
    _CdsCtRec.FieldDefs.Add('CodigoReceber', FtInteger);
    _CdsCtRec.FieldDefs.Add('Sinal', FtString, 1);

  end;
  {$EndRegion}
Begin
  Inherited Create();
  _CdsCtRec := TClientDataSet.Create(nil);
  CriaCampos();
  _CdsCtRec.CreateDataSet;

End;

{$Region 'Set Binding'}
Procedure TCtReceber.SetMaquinaCartao(MaquinaCartao : Integer);
begin
  if (_MaquinaCartao <> MaquinaCartao) then
  Begin
    _MaquinaCartao := MaquinaCartao;
    Notify('MaquinaCartao');
  End;
end;

Procedure TCtReceber.SetAutorizacaoOperadora(AutorizacaoOperadora : String);
begin
  if (_AutorizacaoOperadora <> AutorizacaoOperadora) then
  Begin
    _AutorizacaoOperadora := AutorizacaoOperadora;
    Notify('AutorizacaoOperadora');
  End;
end;

Procedure TCtReceber.SetTitularCartao(TitularCartao : String);
begin
  if (_TitularCartao <> TitularCartao) then
  Begin
    _TitularCartao := TitularCartao;
    Notify('TitularCartao');
  End;
end;

Procedure TCtReceber.SetParcelasCartao(ParcelasCartao : Integer);
begin
  if (_ParcelasCartao <> ParcelasCartao) then
  Begin
    _ParcelasCartao := ParcelasCartao;
    Notify('ParcelasCartao');
  End;
end;

Procedure TCtReceber.SetCodPlanoCartao(CodPlanoCartao : Integer);
begin
  if (_CodPlanoCartao <> CodPlanoCartao) then
  Begin
    _CodPlanoCartao := CodPlanoCartao;
    Notify('CodPlanoCartao');
  End;
end;

Procedure TCtReceber.SetCodContaAux(CodContaAux : Integer);
begin
  if (_CodContaAux <> CodContaAux) then
  Begin
    _CodContaAux := CodContaAux;
    Notify('CodContaAux');
  End;
end;

Procedure TCtReceber.SetCodPlanoCtCred(CodPlanoCtCred : Integer);
begin
  if (_CodPlanoCtCred <> CodPlanoCtCred) then
  Begin
    _CodPlanoCtCred := CodPlanoCtCred;
    Notify('CodPlanoCtCred');
  End;
end;

Procedure TCtReceber.SetCodPlanoCtDeb(CodPlanoCtDeb : Integer);
begin
  if (_CodPlanoCtDeb <> CodPlanoCtDeb) then
  Begin
    _CodPlanoCtDeb := CodPlanoCtDeb;
    Notify('CodPlanoCtDeb');
  End;
end;

Procedure TCtReceber.SetPlanoCtCred(PlanoCtCred : String);
begin
  if (_PlanoCtCred <> PlanoCtCred) then
  Begin
    _PlanoCtCred := PlanoCtCred;
    Notify('PlanoCtCred');
  End;
end;

Procedure TCtReceber.SetPlanoCtDeb(PlanoCtDeb : String);
begin
  if (_PlanoCtDeb <> PlanoCtDeb) then
  Begin
    _PlanoCtDeb := PlanoCtDeb;
    Notify('PlanoCtDeb');
  End;
end;

Procedure TCtReceber.SetCodContaCred(CodContaCred : Integer);
begin
  if (_CodContaCred <> CodContaCred) then
  Begin
    _CodContaCred := CodContaCred;
    Notify('CodContaCred');
  End;
end;

Procedure TCtReceber.SetCodFornec(CodFornec : Integer);
begin
  if (_CodFornec <> CodFornec) then
  Begin
    _CodFornec := CodFornec;
    Notify('CodFornec');
  End;
end;

Procedure TCtReceber.SetDiasAdic(DiasAdic : Integer);
begin
  if (_DiasAdic <> DiasAdic) then
  Begin
    _DiasAdic := DiasAdic;
    Notify('DiasAdic');
  End;
end;

Procedure TCtReceber.SetTxAdmin(TxAdmin : Double);
begin
  if (_TxAdmin <> TxAdmin) then
  Begin
    _TxAdmin := TxAdmin;
    Notify('TxAdmin');
  End;
end;

{$EndRegion}


Procedure TCtReceber.LimpaObjeto();
Begin
  _cdsCtRec.Close();
  _cdsCtRec.CreateDataSet;
End;











end.
