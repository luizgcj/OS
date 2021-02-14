unit ConsultaCepRepository;

interface

uses IdBaseComponent, IdComponent, IdTCPConnection, IdTCPClient, IdHTTP, IdSSLOpenSSL , IdSSLOpenSSLHeaders ,  System.Json, StrUtils,
Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, Dialogs, IdIOHandler, IdIOHandlerSocket, IdIOHandlerStack, IdSSL,
ConsultaCep, CidadeRepository, Cidade, Bairro, BairroRepository, Database;

type TConsultaCepRepository = class

  private
    fHttp : TIdHttp;
    fCodigoEmp : Integer;
  public
    constructor Create(CodigoEmp : Integer);
    function ConsultaCep(cep: String; Database : TDatabase) : TConsultaCep;
    destructor Destroy();

end;

implementation

uses FuncoesGerais;


constructor TConsultaCepRepository.Create(CodigoEmp : Integer);
begin
  fHttp := TIdHttp.Create;
  fCodigoEmp := CodigoEmp
end;

function TConsultaCepRepository.ConsultaCep(cep:String; Database : TDatabase) : TConsultaCep;
var
  Response : TStringStream;
  Json : TJsonObject;
  sUf, sCidade, sBairro : String;
  CidadeRepositorio : TCidadeRepository;
  Cidade : TCidade;
  Bairro : TBairro;
  BairroRepositorio : TBairroRepository;
begin
  Response := TStringStream.Create();
  IdOpenSSLSetLibPath(ExtractFilePath(Application.ExeName));
  fHttp.IOHandler := nil;
  fHttp.ReadTimeout := 10000;
  fHttp.Request.ContentType := 'application/json';

  try
    fHttp.Get('http://viacep.com.br/ws/' + cep + '/json/unicode/', Response);
  except
    on e:Exception do
    begin
      raise Exception.Create('Erro ao consultar cep ' + e.Message);
    end;
  end;

  Json := TJSONObject.ParseJSONValue(TEncoding.UTF8.GetBytes(Response.DataString), 0)  as TJSONObject;

  if (Json.Values['erro'] <> nil) then
  begin
    raise Exception.Create('CEP consultado não consta na base de dados pesquisada!');
    exit;
  end;


  Result := TConsultaCep.Create;
  Result.Endereco := Ifthen(Json.Values['logradouro'] <> nil, Json.Values['logradouro'].Value, '');


  Cidade := TCidade.Create;
  Cidade.Nome := UpperCase(Ifthen(Json.Values['localidade'] <> nil, TFuncoesGerais.AnsiToAscii(Json.Values['localidade'].Value), ''));
  Cidade.SiglaEstado := UpperCase(Ifthen(Json.Values['uf'] <> nil, Json.Values['uf'].Value, ''));
  Cidade.Ibge := StrToInt(Ifthen(Json.Values['ibge'] <> nil, Json.Values['ibge'].Value, ''));


  if Trim(Cidade.Nome) <> '' then
  begin
    CidadeRepositorio := TCidadeRepository.Create();
    Cidade := CidadeRepositorio.GetOrCreateCidade(Cidade, Database);

    Result.CodigoCidade := Cidade.Id;
    Result.NomeCidade := Cidade.Nome;
    Result.Sigla := Cidade.SiglaEstado;

    CidadeRepositorio.Free;
  end
  else
  begin
    Result.CodigoCidade := 0;
    Result.NomeCidade := '';
    Result.Sigla := Ifthen(Json.Values['uf'] <> nil, Json.Values['uf'].Value, '');
  end;


  Bairro := TBairro.Create;
  Bairro.Nome := UpperCase(Ifthen(Json.Values['bairro'] <> nil, TFuncoesGerais.AnsiToAscii(Json.Values['bairro'].Value), ''));
  Bairro.CodigoEmp := Database.CodigoEmpresa;

  if Trim(Bairro.Nome) <> '' then
  begin
    BairroRepositorio := TBairroRepository.Create();
    Bairro := BairroRepositorio.GetOrCreateBairro(Bairro, Database);

    Result.Bairro := Bairro.Nome;
    Result.CodigoBairro := Bairro.Id;
  end
  else
  begin
    Result.Bairro := '';
    Result.CodigoBairro := 0;
  end;


end;

destructor TConsultaCepRepository.Destroy();
begin
  fHttp.Free;
end;

end.
