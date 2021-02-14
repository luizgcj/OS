unit Funcoes_Alias;

interface

uses Windows, Messages, Classes, FireDAC.Comp.Client, IniFiles, SysUtils,
  FireDAC.Phys.MySQLDef, FireDAC.Phys.MySQL, FireDAC.Phys.IBDef, FireDAC.Phys.IBBase, FireDAC.Phys.IB, Forms, FireDAC.Stan.Intf, MaisVSLib_TLB, ComObj,
  Registry, DataBase;

//Ariel 01/11/2013 - Início - Funções para conexão no banco de dados e criptografia do alias.ini
function AtribuiAlias(pAlias: string; pAdCon: TFDConnection; DataBase : TDataBase): Boolean;
function CryptWeb(pAction, pSrc: string): string; //Ariel 31/10/2013
procedure RegistrarDLL(); //Ariel 31/10/2013
procedure ListaAlias(pLista: TStringList); //Ariel 01/11/2013
//Ariel 01/11/2013 - Fim

implementation

procedure AposAtribuiAlias();
begin
end;

function AtribuiAlias(pAlias: string; pAdCon: TFDConnection; DataBase : TDataBase): Boolean; overload; //Ariel 05/09/2013
var
  iniAlias: TMemIniFile;
  vMySQL: Boolean;
  vHostName: string;
  vAiCript: TStringList;
begin
  iniAlias := TMemIniFile.Create(ExtractFileDrive(Application.ExeName) + '\Sge32\alias.ini');
  vAiCript := TStringList.Create;
  vAiCript.LoadFromFile(iniAlias.FileName);
  if Pos('[BASEDADOS]',UpperCase(vAiCript.Text)) <= 0 then
  begin
    vAiCript.Text := Cryptweb('D',vAiCript.text);
    iniAlias.SetStrings(vAiCript);
  end;
  vAiCript.Free;

  if iniAlias.SectionExists(pAlias) then
  begin
    vMySQL := Pos('mysql',iniAlias.ReadString(pAlias,'protocolo','firebird-2.1')) > 0;
    with pAdCon do
    begin
      Params.Clear;
      if vMySQL then
      begin
        DriverName := 'MYSQL';
        Params.Add('DriverID=MySQL');
        DataBase.ADDriverMySQL.VendorLib := iniAlias.ReadString(pAlias,'dll','libmysql.dll');
        if iniAlias.ReadString(pAlias,'hostname','') <> '' then
          Params.Add('server='+iniAlias.ReadString(pAlias,'hostname',''))
        else
          Params.Add('server=localhost');
        Params.Add('port=' + IntToStr(IniAlias.ReadInteger(pAlias,'porta',3306)));
      end
      else
      begin
        DriverName := 'IB';
        Params.Add('DriverID=IB');
        DataBase.ADDriverIB.VendorLib := iniAlias.ReadString(pAlias,'dll','fbclient.dll'); //Ariel 10/09/2013 - O help recomenda utilizar apenas a fbclient.dll
        vHostName := iniAlias.ReadString(pAlias,'hostname','');
        if vHostName = '' then
          Params.Add('protocol=local')
        else
          Params.Add('protocol=tcpip');
        Params.Add('server='+vHostName);
        Params.Add('port=' + IntToStr(IniAlias.ReadInteger(pAlias,'porta',3050)));
        Params.Add('PageSize=4096');
      end;
      Params.Add('User_Name=' + iniAlias.ReadString(pAlias,'usuario','SYSDBA'));
      Params.Add('Password='  + iniAlias.ReadString(pAlias,'senha','Msol1000'));
      Params.Add('database='+iniAlias.ReadString(pAlias,'database','C:\Sge32\dados\' + pAlias));
      Params.Add('SQLDialect=3');
      with FormatOptions do
      begin
        OwnMapRules := True;
        MapRules.Clear;
        with MapRules.Add do
        begin
          SourceDataType := dtDateTimeStamp;
          TargetDataType := dtDateTime;
        end;
        with MapRules.Add do
        begin
          SourceDataType := dtFmtBCD;
          TargetDataType := dtDouble;
        end;
        with MapRules.Add do
        begin
          SourceDataType := dtBCD;
          TargetDataType := dtDouble;
        end;
        with MapRules.Add do
        begin
          SourceDataType := dtInt16;
          TargetDataType := dtBoolean;
        end;
      end;
    end;

    if Pos('EMPRESA',UpperCase(pAlias)) > 0 then
    begin
      DataBase.bMySql := vMySQL;
      DataBase.sAliasEmpresa := pAlias;
    end;

    AposAtribuiAlias;
    Result := True;
  end
  else
    Result := False;
  iniAlias.Free;
end;


function CryptWeb(pAction, pSrc: string): string;
var
  intfRef: ICriptInterface;
begin
  try
    intfRef := CreateComObject(CLASS_Cript) as ICriptInterface;
  except
    on E: EOleSysError do
    begin
      RegistrarDLL();
      try
        intfRef := CreateComObject(CLASS_Cript) as ICriptInterface;
      except
        on E: Exception do
        begin
          Application.MessageBox(PChar('Erro ao carregar MaisSVLib.dll: ' + e.message),'Atenção',MB_ICONEXCLAMATION);
          Result := '';
          Exit;
        end;
      end;
    end;

    on E: Exception do
    begin
      Application.MessageBox(PChar('Erro ao carregar MaisSVLib.dll: ' + e.message),'Atenção',MB_ICONEXCLAMATION);
      Result := '';
      Exit;
    end;
  end;
  if UpperCase(pAction) = 'D' then
    Result := intfRef.Descriptografar(pSrc)
  else
    Result := intfRef.Criptografar(pSrc);
end;

procedure RegistrarDLL();
var
  vReg: TRegistry;
begin
  try
    vReg := TRegistry.Create;
    vReg.RootKey := HKEY_CLASSES_ROOT;
    vReg.OpenKey('maisvslib.Cript', True);
    vReg.WriteString('','maisvslib.Cript');
    vReg.OpenKey('CLSID',true);
    vReg.WriteString('','{8995C0D1-8FC1-30FC-8DCF-525C835901FB}');
    vReg.CloseKey;

    vReg.OpenKey('CLSID\{8995C0D1-8FC1-30FC-8DCF-525C835901FB}', True);
    vReg.WriteString('','maisvslib.Cript');
    vReg.OpenKey('InprocServer32',True);
    vReg.WriteString('','mscoree.dll');
    vReg.WriteString('ThreadingModel','Both');
    vReg.WriteString('Class','maisvslib.Cript');
    vReg.WriteString('Assembly','maisvslib, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null');
    vReg.WriteString('RuntimeVersion','v2.0.50727');
    vReg.OpenKey('0.0.0.0',True);
    vReg.WriteString('Class','maisvslib.Cript');
    vReg.WriteString('Assembly','maisvslib, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null');
    vReg.WriteString('RuntimeVersion','v2.0.50727');
    vReg.CloseKey;

    vReg.OpenKey('CLSID\{8995C0D1-8FC1-30FC-8DCF-525C835901FB}\ProgId',True);
    vReg.WriteString('','maisvslib.Cript');
    vReg.CloseKey;

    vReg.OpenKey('CLSID\{8995C0D1-8FC1-30FC-8DCF-525C835901FB}\Implemented Categories\{62C8FE65-4EBB-45E7-B440-6E39B2CDBF29}',True);
    vReg.CloseKey;
    vReg.Free;
  except
    on e: Exception do
    begin
      Application.MessageBox('Rodar o aplicativo 1 vez como administrador para registrar os componentes.','Atenção',MB_ICONINFORMATION);
    end;
  end;
end;

procedure ListaAlias(pLista: TStringList);
var
  iniAlias: TMemIniFile;
  vAiCript: TStringList;
begin
  iniAlias := TMemIniFile.Create(ExtractFileDrive(Application.ExeName) + '\Sge32\alias.ini');

  vAiCript := TStringList.Create;
  vAiCript.LoadFromFile(iniAlias.FileName);
  if Pos('[BASEDADOS]',UpperCase(vAiCript.Text)) <= 0 then
  begin
    vAiCript.Text := Cryptweb('D',vAiCript.text);
    iniAlias.SetStrings(vAiCript);
  end;
  vAiCript.Free;
  iniAlias.ReadSections(pLista);
end;

end.
