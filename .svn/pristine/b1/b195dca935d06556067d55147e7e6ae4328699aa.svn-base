unit EmpresaService;

interface
Uses
  Data.Db,
  Empresa,
  EmpresaRepository,
  DataBase;

Type TEmpresaService = Class
  Private
    Class Procedure DataToEmpresa(DataSet : TDataSet; Empresa : TEmpresa);
  Public
    Class Procedure GetEmpresa(Empresa : TEmpresa; DataBase : TDataBase);
End;

implementation

Class Procedure TEmpresaService.GetEmpresa(Empresa : TEmpresa; DataBase : TDataBase);
Begin
  TEmpresaService.DataToEmpresa( TEmpresaRepository.GetEmpresa(DataBase), Empresa);
End;

Class Procedure TEmpresaService.DataToEmpresa(DataSet : TDataSet; Empresa : TEmpresa);
Begin
  Empresa.Cnpj := DataSet.FieldByName('Cnpj').AsString;
  Empresa.Nome := DataSet.FieldByName('Nome').AsString;
  Empresa.Endereco := DataSet.FieldByName('Endereco').AsString;
  Empresa.Numero := DataSet.FieldByName('Numero').AsString;
  Empresa.Complemento := DataSet.FieldByName('Complemento').AsString;
  Empresa.Bairro := DataSet.FieldByName('Bairro').AsString;
  Empresa.Cidade := DataSet.FieldByName('Cidade').AsString;
  Empresa.Uf := DataSet.FieldByName('Uf').AsString;
  Empresa.Cep := DataSet.FieldByName('Cep').AsString;
  Empresa.Telefone := DataSet.FieldByName('Telefone').AsString;
  Empresa.Fax := DataSet.FieldByName('Fax').AsString;
End;

end.
