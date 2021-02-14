unit ConsultaCep;

interface
uses BoundObject;

type TConsultaCep = class(TBoundObject)
  private
    _CodigoCidade : integer;
    _NomeCidade : string;
    _Sigla : string;
    _CodigoBairro : integer;
    _Bairro : string;
    _Endereco : string;

    procedure SetCodigoCidade(CodigoCidade : Integer);
    procedure SetNomeCidade(NomeCidade : String);
    procedure SetSigla(Sigla : String);
    procedure SetCodigoBairro(CodigoBairro : Integer);
    procedure SetBairro(Bairro : String);
    procedure SetEndereco(Endereco : String);

    procedure LimpaObjeto();
  public
    property CodigoCidade : integer read _CodigoCidade write SetCodigoCidade;
    property NomeCidade : string read _NomeCidade write SetNomeCidade;
    property Sigla : string read _Sigla write SetSigla;
    property CodigoBairro : integer read _CodigoBairro write SetCodigoBairro;
    property Bairro : string read _Bairro write SetBairro;
    property Endereco : string read _Endereco write SetEndereco;
end;

implementation

procedure TConsultaCep.LimpaObjeto;
begin
  SetCodigoCidade(0);
  SetNomeCidade('');
  SetSigla('');
  SetCodigoBairro(0);
  SetBairro('');
  SetEndereco('');
end;

procedure TConsultaCep.SetCodigoCidade(CodigoCidade : Integer);
begin
  if _CodigoCidade <> CodigoCidade then
    _CodigoCidade := CodigoCidade;
end;

procedure TConsultaCep.SetNomeCidade(NomeCidade : String);
begin
  if _NomeCidade <> NomeCidade then
    _NomeCidade := NomeCidade;
end;

procedure TConsultaCep.SetSigla(Sigla : String);
begin
  if _Sigla <> Sigla then
    _Sigla := Sigla;
end;

procedure TConsultaCep.SetCodigoBairro(CodigoBairro : Integer);
begin
  if _CodigoBairro <> CodigoBairro then
    _CodigoBairro := CodigoBairro;
end;

procedure TConsultaCep.SetBairro(Bairro : String);
begin
  if _Bairro <> Bairro then
    _Bairro := Bairro;
end;

procedure TConsultaCep.SetEndereco(Endereco : String);
begin
  if _Endereco <> Endereco then
    _Endereco := Endereco;
end;

end.
