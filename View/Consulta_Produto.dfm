inherited FrConsulta_Produto: TFrConsulta_Produto
  Caption = 'Consulta Produtos'
  PixelsPerInch = 96
  TextHeight = 13
  inherited cxGrid: TcxGrid
    inherited cxGridLvVw: TcxGridDBTableView
      object cxGridLvVwId: TcxGridDBColumn
        Caption = 'C'#243'digo'
        DataBinding.FieldName = 'Id'
        Width = 78
      end
      object cxGridLvVwNome: TcxGridDBColumn
        Caption = 'Produto'
        DataBinding.FieldName = 'Nome'
        Width = 246
      end
      object cxGridLvVwPrecoAmador: TcxGridDBColumn
        Caption = 'Pr.Amador'
        DataBinding.FieldName = 'PrAmador'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Width = 102
      end
      object cxGridLvVwPrecoProfissional: TcxGridDBColumn
        Caption = 'Pr.Profissional'
        DataBinding.FieldName = 'PrProfissional'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Width = 86
      end
      object cxGridLvVwQtdeAtualProduto: TcxGridDBColumn
        Caption = 'Estoque'
        DataBinding.FieldName = 'QtdeAtualProduto'
        Width = 75
      end
      object cxGridLvVwQuantidadeEmbalagem: TcxGridDBColumn
        Caption = 'Quantidade Embalagem'
        DataBinding.FieldName = 'QuantidadeEmbalagem'
        Visible = False
      end
      object cxGridLvVwUnidadeId: TcxGridDBColumn
        Caption = 'C'#243'd. Unidade'
        DataBinding.FieldName = 'UnidadeId'
        Width = 86
      end
      object cxGridLvVwUnidade: TcxGridDBColumn
        DataBinding.FieldName = 'Unidade'
        Width = 101
      end
      object cxGridLvVwDecimais: TcxGridDBColumn
        DataBinding.FieldName = 'Decimais'
        Visible = False
      end
    end
  end
end
