object FrAutorizacaoEstoque: TFrAutorizacaoEstoque
  Left = 0
  Top = 0
  Caption = 'Autoriza Estoque'
  ClientHeight = 296
  ClientWidth = 718
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object pnlBotoes: TPanel
    Left = 0
    Top = 261
    Width = 718
    Height = 35
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 0
    DesignSize = (
      718
      35)
    object BtnAutorizar: TBitBtn
      Left = 628
      Top = 4
      Width = 81
      Height = 26
      Anchors = [akRight, akBottom]
      Caption = '&Autorizar'
      Glyph.Data = {
        42080000424D4208000000000000420000002800000020000000100000000100
        20000300000000080000130B0000130B00000000000000000000000000FF0000
        FF0000FF0000FFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFFE5D2FFFFB886FFFF
        8732FFFF700BFFFF700BFFFF8732FFFFB37DFFFFE6D4FFFF00FFFFFF00FFFFFF
        00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFDDDDDDFF9C9C9CFF56
        5656FF373737FF373737FF565656FF969696FFDEDEDEFFFF00FFFFFF00FFFFFF
        00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFFA564FFFF6F09FFFF6E06FFFF
        6E06FFFF6E06FFFF6E06FFFF6E06FFFF6E06FFFF6F09FFFFA564FFFF00FFFFFF
        00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF808080FF343434FF333333FF33
        3333FF333333FF333333FF333333FF333333FF343434FF808080FFFF00FFFFFF
        00FFFFFF00FFFFFF00FFFFFF00FFFFFF8C3BFFFF6A00FFFF6E06FFFF6E06FFFF
        6E06FFFF6E06FFFF6E06FFFF6E06FFFF6E06FFFF6E06FFFF6A00FFFF8C3BFFFF
        00FFFFFF00FFFFFF00FFFFFF00FFFF5F5F5FFF2E2E2EFF333333FF333333FF33
        3333FF333333FF333333FF333333FF333333FF333333FF2E2E2EFF5F5F5FFFFF
        00FFFFFF00FFFFFF00FFFFFFA564FFFF6A00FFFF6E06FFFF6E06FFFF6E06FFFF
        6D04FFFF7410FFFF6D04FFFF6E06FFFF6E06FFFF6E06FFFF6E06FFFF6A00FFFF
        A564FFFF00FFFFFF00FFFF808080FF2E2E2EFF333333FF333333FF333333FF32
        3232FF3B3B3BFF323232FF333333FF333333FF333333FF333333FF2E2E2EFF80
        8080FFFF00FFFFFFE6D4FFFF6F09FFFF6E06FFFF6E06FFFF6E06FFFF6A00FFFF
        9B54FFFF00FFFFFF6D04FFFF6E06FFFF6E06FFFF6E06FFFF6E06FFFF6E06FFFF
        6F09FFFFE5D2FFDEDEDEFF343434FF333333FF333333FF333333FF2E2E2EFF73
        7373FFFF00FFFF313131FF333333FF333333FF333333FF333333FF333333FF34
        3434FFDDDDDDFFFFB37DFFFF6E06FFFF6E06FFFF6E06FFFF6A00FFFF9E59FFFF
        00FFFFFF00FFFFFFD2B2FFFF6D04FFFF6E06FFFF6E06FFFF6E06FFFF6E06FFFF
        6E06FFFFB886FF969696FF333333FF333333FF333333FF2E2E2EFF787878FFFF
        00FFFFFF00FFFFC2C2C2FF323232FF333333FF333333FF333333FF333333FF33
        3333FF9C9C9CFFFF8732FFFF6E06FFFF6E06FFFF6D04FFFF9A52FFFF00FFFFFF
        EBDDFFFFBF92FFFF00FFFFFF9244FFFF6D04FFFF6E06FFFF6E06FFFF6E06FFFF
        6E06FFFF8732FF565656FF333333FF333333FF323232FF717171FFFF00FFFFE6
        E6E6FFA7A7A7FFFF00FFFF666666FF313131FF333333FF333333FF333333FF33
        3333FF565656FFFF700BFFFF6E06FFFF6E06FFFF6D04FFFF8C3BFFFFD2B2FFFF
        700BFFFF6A00FFFFE3CFFFFF00FFFFFF7C1FFFFF6E06FFFF6E06FFFF6E06FFFF
        6E06FFFF700BFF373737FF333333FF333333FF323232FF5E5E5EFFC2C2C2FF36
        3636FF2D2D2DFFD9D9D9FFFF00FFFF464646FF333333FF333333FF333333FF33
        3333FF373737FFFF700BFFFF6E06FFFF6E06FFFF6E06FFFF6E06FFFE6900FFFF
        6E06FFFF6F09FFFF8026FFFF00FFFFFFCFADFFFE6900FFFF6E06FFFF6E06FFFF
        6E06FFFF700BFF373737FF333333FF333333FF333333FF333333FF2B2B2BFF33
        3333FF343434FF4D4D4DFFFF00FFFFBDBDBDFF2B2B2BFF333333FF333333FF33
        3333FF373737FFFF8732FFFF6E06FFFF6E06FFFF6E06FFFF6E06FFFF6E06FFFF
        6E06FFFF6E06FFFF6D04FFFFAD72FFFF00FFFFFFA260FFFF6D04FFFF6E06FFFF
        6E06FFFF8732FF565656FF333333FF333333FF333333FF333333FF333333FF33
        3333FF333333FF303030FF8C8C8CFFFF00FFFF7D7D7DFF313131FF333333FF33
        3333FF565656FFFFB886FFFF6E06FFFF6E06FFFF6E06FFFF6E06FFFF6E06FFFF
        6E06FFFF6E06FFFF6E06FFFE6900FFFFD9BFFFFF00FFFFFF7614FFFF6E06FFFF
        6E06FFFFB37DFF9C9C9CFF333333FF333333FF333333FF333333FF333333FF33
        3333FF333333FF333333FF2C2C2CFFCDCDCDFFFF00FFFF3E3E3EFF333333FF33
        3333FF969696FFFFE5D2FFFF6F09FFFF6E06FFFF6E06FFFF6E06FFFF6E06FFFF
        6E06FFFF6E06FFFF6E06FFFF6E06FFFF842DFFFF974DFFFF6D04FFFF6E06FFFF
        6F09FFFFE6D4FFDDDDDDFF343434FF333333FF333333FF333333FF333333FF33
        3333FF333333FF333333FF333333FF535353FF6E6E6EFF313131FF333333FF34
        3434FFDEDEDEFFFF00FFFFFFA564FFFF6A00FFFF6E06FFFF6E06FFFF6E06FFFF
        6E06FFFF6E06FFFF6E06FFFF6E06FFFF6D04FFFF6D04FFFF6E06FFFF6A00FFFF
        A564FFFF00FFFFFF00FFFF808080FF2E2E2EFF333333FF333333FF333333FF33
        3333FF333333FF333333FF333333FF323232FF323232FF333333FF2E2E2EFF80
        8080FFFF00FFFFFF00FFFFFF00FFFFFF8C3BFFFF6A00FFFF6E06FFFF6E06FFFF
        6E06FFFF6E06FFFF6E06FFFF6E06FFFF6E06FFFF6E06FFFF6A00FFFF8C3BFFFF
        00FFFFFF00FFFFFF00FFFFFF00FFFF5F5F5FFF2E2E2EFF333333FF333333FF33
        3333FF333333FF333333FF333333FF333333FF333333FF2E2E2EFF5F5F5FFFFF
        00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFFA564FFFF6F09FFFF6E06FFFF
        6E06FFFF6E06FFFF6E06FFFF6E06FFFF6E06FFFF6F09FFFFA564FFFF00FFFFFF
        00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF808080FF343434FF333333FF33
        3333FF333333FF333333FF333333FF333333FF343434FF808080FFFF00FFFFFF
        00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFFE6D4FFFFB37DFFFF
        8732FFFF700BFFFF700BFFFF8732FFFFB886FFFFE5D2FFFF00FFFFFF00FFFFFF
        00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFDEDEDEFF969696FF56
        5656FF373737FF373737FF565656FF9C9C9CFFDDDDDDFFFF00FFFFFF00FFFFFF
        00FFFFFF00FF}
      NumGlyphs = 2
      ParentShowHint = False
      ShowHint = True
      TabOrder = 0
      OnClick = BtnAutorizarClick
      ExplicitTop = 5
    end
    object BtnDesistir: TBitBtn
      Left = 543
      Top = 4
      Width = 81
      Height = 26
      Hint = 'Desiste|Clique aqui para desistir da opera'#231#227'o.'
      Anchors = [akRight, akBottom]
      Caption = '&Desistir'
      Glyph.Data = {
        42080000424D4208000000000000420000002800000020000000100000000100
        20000300000000080000130B0000130B00000000000000000000000000FF0000
        FF0000FF0000FFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF
        00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF
        00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF
        00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF
        00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF
        00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF
        00FFFFFFBD8FFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF
        00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF
        00FFFFD8D8D8FFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF
        00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF
        00FFFFFFBC8DFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF
        00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF
        00FFFFA1A1A1FFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF
        00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF
        00FFFFFF9449FFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF
        00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF
        00FFFF696969FFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF
        00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF
        BD8FFFFF842DFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF
        00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFD1
        D1D1FF535353FFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF9346FFFF
        6A00FFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF
        7A1BFFFF8732FFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFC1FFCFF686868FF2E
        2E2EFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF44
        4444FF575757FFFF00FFFFFF00FFFFFF00FFFFFFBC8DFFFF730FFFFF6E06FFFF
        7410FFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF9449FFFF
        6E06FFFF8934FFFF00FFFFFF00FFFFFF00FFFFD7D7D7FF383838FF333333FF3B
        3B3BFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF696969FF33
        3333FF595959FFFF00FFFFFF00FFFFFFBC8DFFFF6E06FFFF6E06FFFF6E06FFFF
        7410FFFF00FFFFFF00FFFFFFC399FFFFBD8FFFFF974DFFFF7410FFFF6D04FFFF
        6E06FFFFBD8FFFFF00FFFFFF00FFFFA1A1A1FF333333FF333333FF333333FF3B
        3B3BFFFF00FFFFFF00FFFFD7D7D7FFABABABFF6E6E6EFF3C3C3CFF303030FF33
        3333FFA4A4A4FFFF00FFFFFFA05DFFFC6900FFFF6E06FFFF6E06FFFF6E06FFFF
        6D04FFF46500FFF76700FFF76700FFFF6A00FFFF6D04FFFF6E06FFFF6E06FFFF
        6F09FFFFBD8FFFFF00FFFF7B7B7BFF2A2A2AFF333333FF333333FF333333FF32
        3232FF232323FF272727FF282828FF2D2D2DFF323232FF333333FF333333FF34
        3434FFD7D7D7FFFF842DFFFF6E06FFFF6E06FFFF6E06FFFF6E06FFFF6E06FFFF
        6E06FFFF6E06FFFF6E06FFFF6E06FFFF6E06FFFF6E06FFFF6E06FFFF6A00FFFF
        BD8FFFFF00FFFF535353FF333333FF333333FF333333FF333333FF333333FF33
        3333FF333333FF333333FF333333FF333333FF333333FF333333FF2D2D2DFFD7
        D7D7FFFF00FFFFFFB47FFFFF6A00FFFF6E06FFFF6E06FFFF6E06FFFF6E06FFFF
        6E06FFFF6E06FFFF6D04FFFF6D04FFFE6900FFF96800FFFF964BFFFFBD8FFFFF
        00FFFFFF00FFFF979797FF2D2D2DFF333333FF333333FF333333FF333333FF33
        3333FF333333FF323232FF303030FF2B2B2BFF292929FF6B6B6BFFD7D7D7FFFF
        00FFFFFF00FFFFFF00FFFFFFC8A0FFFF700BFFFF6E06FFFF6E06FFFF6E06FFFF
        6F09FFFF832BFFFF8934FFFFA260FFFFC8A0FFFF00FFFFFF00FFFFFF00FFFFFF
        00FFFFFF00FFFFFF00FFFFB3B3B3FF363636FF333333FF333333FF333333FF34
        3434FF505050FF595959FF7D7D7DFFB4B4B4FFFF00FFFFFF00FFFFFF00FFFFFF
        00FFFFFF00FFFFFF00FFFFFF00FFFFFFC8A0FFFF7614FFFF6D04FFFF6E06FFFF
        7410FFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF
        00FFFFFF00FFFFFF00FFFFFF00FFFFD7D7D7FF3E3E3EFF323232FF333333FF3B
        3B3BFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF
        00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF9B54FFFC6900FFFF
        7410FFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF
        00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF737373FF2A2A2AFF3B
        3B3BFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF
        00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFFB886FFFF
        7716FFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF
        00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF9C9C9CFF40
        4040FFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF
        00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF
        00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF
        00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF
        00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF
        00FFFFFF00FF}
      NumGlyphs = 2
      ParentShowHint = False
      ShowHint = True
      TabOrder = 1
      OnClick = BtnDesistirClick
      ExplicitTop = 5
    end
  end
  object cxGrid: TcxGrid
    Left = 0
    Top = 0
    Width = 718
    Height = 261
    Align = alClient
    TabOrder = 1
    ExplicitLeft = 232
    ExplicitTop = 4
    ExplicitWidth = 250
    ExplicitHeight = 200
    object cxGridLvVw: TcxGridDBTableView
      Navigator.Buttons.CustomButtons = <>
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      OptionsData.CancelOnExit = False
      OptionsData.Deleting = False
      OptionsData.DeletingConfirmation = False
      OptionsData.Editing = False
      OptionsData.Inserting = False
      OptionsView.GroupByBox = False
      object cxGridLvVwProdutoId: TcxGridDBColumn
        Caption = 'C'#243'digo'
        DataBinding.FieldName = 'ProdutoId'
      end
      object cxGridLvVwProduto: TcxGridDBColumn
        DataBinding.FieldName = 'Produto'
        Width = 400
      end
      object cxGridLvVwEstoque: TcxGridDBColumn
        DataBinding.FieldName = 'Estoque'
        Width = 115
      end
      object cxGridLvVwQuantidade: TcxGridDBColumn
        Caption = 'Quantidade Vendida'
        DataBinding.FieldName = 'Quantidade'
        Width = 124
      end
    end
    object cxGridLv: TcxGridLevel
      GridView = cxGridLvVw
    end
  end
end