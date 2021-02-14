inherited FrConsulta_Pessoa: TFrConsulta_Pessoa
  Caption = 'Consulta de Pessoas'
  PixelsPerInch = 96
  TextHeight = 13
  inherited cxGrid: TcxGrid
    inherited cxGridLvVw: TcxGridDBTableView
      object cxGridLvVwId: TcxGridDBColumn
        Caption = 'C'#243'digo'
        DataBinding.FieldName = 'Id'
      end
      object cxGridLvVwNome: TcxGridDBColumn
        DataBinding.FieldName = 'Nome'
        Width = 162
      end
      object cxGridLvVwCpfCnpj: TcxGridDBColumn
        Caption = 'Cpf/Cnpj'
        DataBinding.FieldName = 'CpfCnpj'
        Width = 106
      end
      object cxGridLvVwTelefone: TcxGridDBColumn
        DataBinding.FieldName = 'Telefone'
      end
      object cxGridLvVwCelular: TcxGridDBColumn
        DataBinding.FieldName = 'Celular'
      end
      object cxGridLvVwEndereço: TcxGridDBColumn
        Caption = 'Endere'#231'o'
        DataBinding.FieldName = 'Endereco'
        Width = 161
      end
      object cxGridLvVwNumero: TcxGridDBColumn
        Caption = 'N'#250'mero'
        DataBinding.FieldName = 'Numero'
      end
      object cxGridLvVwBairroId: TcxGridDBColumn
        Caption = 'Cod. Bairro'
        DataBinding.FieldName = 'BairroId'
      end
      object cxGridLvVwBairro: TcxGridDBColumn
        DataBinding.FieldName = 'Bairro'
        Width = 102
      end
      object cxGridLvVwCidadeId: TcxGridDBColumn
        Caption = 'Cod. Cidade'
        DataBinding.FieldName = 'CidadeId'
      end
      object cxGridLvVwCidade: TcxGridDBColumn
        DataBinding.FieldName = 'Cidade'
        Width = 95
      end
      object cxGridLvVwEstadoId: TcxGridDBColumn
        Caption = 'Cod. Estado'
        DataBinding.FieldName = 'EstadoId'
      end
      object cxGridLvVwEstadoAbreviatura: TcxGridDBColumn
        Caption = 'UF'
        DataBinding.FieldName = 'EstadoAbreviatura'
      end
      object cxGridLvVwEstado: TcxGridDBColumn
        DataBinding.FieldName = 'Estado'
      end
    end
  end
end
