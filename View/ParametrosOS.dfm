object FrParametrosOS: TFrParametrosOS
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Parametros O.S.'
  ClientHeight = 135
  ClientWidth = 368
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poMainFormCenter
  OnKeyPress = FormKeyPress
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Panel2: TPanel
    Left = 0
    Top = 0
    Width = 368
    Height = 100
    Align = alClient
    TabOrder = 0
    object Label1: TLabel
      Left = 33
      Top = 24
      Width = 195
      Height = 13
      Caption = 'Percentual M'#237'nimo de Sinal para Amador:'
    end
    object Label2: TLabel
      Left = 16
      Top = 51
      Width = 212
      Height = 13
      Caption = 'Percentual M'#237'nimo de Sinal para Profissional:'
    end
    object curPercMinSinalAmador: TcxCurrencyEdit
      Left = 234
      Top = 20
      Properties.Alignment.Horz = taRightJustify
      Properties.AssignedValues.EditFormat = True
      Properties.DecimalPlaces = 2
      Properties.DisplayFormat = '0.00'
      Properties.OnChange = curPercMinSinalAmadorPropertiesChange
      TabOrder = 0
      OnClick = GenericCurrencyClick
      Width = 87
    end
    object curPercMinSinalProfissional: TcxCurrencyEdit
      Left = 234
      Top = 47
      Properties.Alignment.Horz = taRightJustify
      Properties.AssignedValues.EditFormat = True
      Properties.DecimalPlaces = 2
      Properties.DisplayFormat = '0.00'
      Properties.OnChange = curPercMinSinalProfissionalPropertiesChange
      TabOrder = 1
      OnClick = GenericCurrencyClick
      Width = 87
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 100
    Width = 368
    Height = 35
    Align = alBottom
    TabOrder = 1
    object btnSair: TBitBtn
      Left = 150
      Top = 6
      Width = 58
      Height = 25
      Caption = 'Sair'
      Glyph.Data = {
        42080000424D4208000000000000420000002800000020000000100000000100
        20000300000000080000130B0000130B00000000000000000000000000FF0000
        FF0000FF0000FFFF00FFFFFFBA89FFFF7D20FFFF6D04FFFF6E06FFFF6E06FFFF
        6E06FFFF6E06FFFF6E06FFFF6E06FFFF6E06FFFF6E06FFFF6D04FFFF7D20FFF9
        B88AFFFF00FFFFFF00FFFF606060FFB7B7B7FFCDCDCDFFCCCCCCFFCCCCCCFFCC
        CCCCFFCCCCCCFFCCCCCCFFCCCCCCFFCCCCCCFFCCCCCCFFCDCDCDFFB7B7B7FF60
        6060FFFF00FFFFFAB98AFFFF6E06FFFF6E06FFFF6E06FFFF6E06FFFF6E06FFFF
        6E06FFFF6E06FFFF6E06FFFF6E06FFFF6E06FFFF6E06FFFF6E06FFFF6E06FFFF
        6E06FFFDB989FF606060FFCCCCCCFFCCCCCCFFCCCCCCFFCCCCCCFFCCCCCCFFCC
        CCCCFFCCCCCCFFCCCCCCFFCCCCCCFFCCCCCCFFCCCCCCFFCCCCCCFFCCCCCCFFCC
        CCCCFF606060FFFF7D20FFFF6E06FFFF6E06FFFF6E06FFFF6E06FFFF6E06FFFF
        6E06FFFF6E06FFFF6E06FFFF6E06FFFF6E06FFFF6E06FFFF6E06FFFF6E06FFFF
        6E06FFFF7D20FFB7B7B7FFCCCCCCFFCCCCCCFFCCCCCCFFCCCCCCFFCCCCCCFFCC
        CCCCFFCCCCCCFFCCCCCCFFCCCCCCFFCCCCCCFFCCCCCCFFCCCCCCFFCCCCCCFFCC
        CCCCFFB7B7B7FFFF6D04FFFF6E06FFFF6E06FFFF6E06FFFF6E06FFFF6D04FFFF
        6E06FFFF6E06FFFF6E06FFFF6E06FFFF6D04FFFF6E06FFFF6E06FFFF6E06FFFF
        6E06FFFF6D04FFCDCDCDFFCCCCCCFFCCCCCCFFCCCCCCFFCCCCCCFFCECECEFFCC
        CCCCFFCCCCCCFFCCCCCCFFCCCCCCFFCECECEFFCCCCCCFFCCCCCCFFCCCCCCFFCC
        CCCCFFCDCDCDFFFF6E06FFFF6E06FFFF6E06FFFF6E06FFF76700FFFFC296FFFF
        6C02FFFF6E06FFFF6E06FFFE6C02FFFDC196FFF76700FFFF6E06FFFF6E06FFFF
        6E06FFFF6E06FFCCCCCCFFCCCCCCFFCCCCCCFFCCCCCCFFD7D7D7FF555555FFD0
        D0D0FFCCCCCCFFCCCCCCFFD0D0D0FF555555FFD7D7D7FFCCCCCCFFCCCCCCFFCC
        CCCCFFCCCCCCFFFF6E06FFFF6E06FFFF6E06FFFF6D04FFFFC296FFFF00FFFFFD
        E7D7FFFF7716FFFF7716FFFEE7D6FFFF00FFFFFFC296FFFF6D04FFFF6E06FFFF
        6E06FFFF6E06FFCCCCCCFFCCCCCCFFCCCCCCFFCECECEFF555555FFFF00FFFF15
        2615FFC0C0C0FFC0C0C0FF152615FFFF00FFFF555555FFCECECEFFCCCCCCFFCC
        CCCCFFCCCCCCFFFF6E06FFFF6E06FFFF6E06FFFF6E06FFFF6C02FFF9E6D8FFFF
        00FFFFFEE7D6FFFFE7D6FFFF00FFFFFDE7D7FFFF6C02FFFF6E06FFFF6E06FFFF
        6E06FFFF6E06FFCCCCCCFFCCCCCCFFCCCCCCFFCCCCCCFFD0D0D0FF152615FFFF
        00FFFF1E1E1EFF1E1E1EFFFF00FFFF152615FFD0D0D0FFCCCCCCFFCCCCCCFFCC
        CCCCFFCCCCCCFFFF6E06FFFF6E06FFFF6E06FFFF6E06FFFF6E06FFFE7716FFFD
        E7D7FFFF00FFFFFF00FFFFFBE6D7FFFF7716FFFF6E06FFFF6E06FFFF6E06FFFF
        6E06FFFF6E06FFCCCCCCFFCCCCCCFFCCCCCCFFCCCCCCFFCCCCCCFFC0C0C0FF1E
        1E1EFFFF00FFFFFF00FFFF1E1E1EFFC0C0C0FFCCCCCCFFCCCCCCFFCCCCCCFFCC
        CCCCFFCCCCCCFFFF6E06FFFF6E06FFFF6E06FFFF6E06FFFF6E06FFFF7716FFFE
        E7D6FFFF00FFFFFF00FFFFFFE7D6FFFF7716FFFF6E06FFFF6E06FFFF6E06FFFF
        6E06FFFF6E06FFCCCCCCFFCCCCCCFFCCCCCCFFCCCCCCFFCCCCCCFFC0C0C0FF1E
        1E1EFFFF00FFFFFF00FFFF1E1E1EFFC0C0C0FFCCCCCCFFCCCCCCFFCCCCCCFFCC
        CCCCFFCCCCCCFFFF6E06FFFF6E06FFFF6E06FFFF6E06FFFF6C02FFFBE6D8FFFF
        00FFFFF5E5DAFFFEE7D6FFFF00FFFFFFE7D6FFFF6C02FFFF6E06FFFF6E06FFFF
        6E06FFFF6E06FFCCCCCCFFCCCCCCFFCCCCCCFFCCCCCCFFD0D0D0FF152615FFFF
        00FFFF1E1E1EFF1E1E1EFFFF00FFFF152615FFD0D0D0FFCCCCCCFFCCCCCCFFCC
        CCCCFFCCCCCCFFFF6E06FFFF6E06FFFF6E06FFFF6D04FFFFC296FFFF00FFFFFD
        E7D7FFFF7716FFFF7716FFFFE7D6FFFF00FFFFFFC296FFFF6D04FFFF6E06FFFF
        6E06FFFF6E06FFCCCCCCFFCCCCCCFFCCCCCCFFCECECEFF555555FFFF00FFFF15
        2615FFC0C0C0FFC0C0C0FF152615FFFF00FFFF555555FFCECECEFFCCCCCCFFCC
        CCCCFFCCCCCCFFFF6E06FFFF6E06FFFF6E06FFFF6E06FFF76700FFFCC197FFFF
        6C02FFFF6E06FFFF6E06FFFF6C02FFFBC197FFF76700FFFF6E06FFFF6E06FFFF
        6E06FFFF6E06FFCCCCCCFFCCCCCCFFCCCCCCFFCCCCCCFFD7D7D7FF555555FFD0
        D0D0FFCCCCCCFFCCCCCCFFD0D0D0FF555555FFD7D7D7FFCCCCCCFFCCCCCCFFCC
        CCCCFFCCCCCCFFFF6D04FFFF6E06FFFF6E06FFFF6E06FFFF6E06FFFF6D04FFFF
        6E06FFFF6E06FFFF6E06FFFF6E06FFFF6D04FFFF6E06FFFF6E06FFFF6E06FFFF
        6E06FFFF6D04FFCDCDCDFFCCCCCCFFCCCCCCFFCCCCCCFFCCCCCCFFCECECEFFCC
        CCCCFFCCCCCCFFCCCCCCFFCCCCCCFFCECECEFFCCCCCCFFCCCCCCFFCCCCCCFFCC
        CCCCFFCDCDCDFFFF7D20FFFF6E06FFFF6E06FFFF6E06FFFF6E06FFFF6E06FFFF
        6E06FFFF6E06FFFF6E06FFFF6E06FFFF6E06FFFF6E06FFFF6E06FFFF6E06FFFF
        6E06FFFF7D20FFB7B7B7FFCCCCCCFFCCCCCCFFCCCCCCFFCCCCCCFFCCCCCCFFCC
        CCCCFFCCCCCCFFCCCCCCFFCCCCCCFFCCCCCCFFCCCCCCFFCCCCCCFFCCCCCCFFCC
        CCCCFFB7B7B7FFFFBA89FFFF6E06FFFF6E06FFFF6E06FFFF6E06FFFF6E06FFFF
        6E06FFFF6E06FFFF6E06FFFF6E06FFFF6E06FFFF6E06FFFF6E06FFFF6E06FFFF
        6E06FFFFBA89FF606060FFCCCCCCFFCCCCCCFFCCCCCCFFCCCCCCFFCCCCCCFFCC
        CCCCFFCCCCCCFFCCCCCCFFCCCCCCFFCCCCCCFFCCCCCCFFCCCCCCFFCCCCCCFFCC
        CCCCFF606060FFFF00FFFFFDB989FFFF7D20FFFF6D04FFFF6E06FFFF6E06FFFF
        6E06FFFF6E06FFFF6E06FFFF6E06FFFF6E06FFFF6E06FFFF6D04FFFF7D20FFFF
        BA89FFFF00FFFFFF00FFFF606060FFB7B7B7FFCDCDCDFFCCCCCCFFCCCCCCFFCC
        CCCCFFCCCCCCFFCCCCCCFFCCCCCCFFCCCCCCFFCCCCCCFFCDCDCDFFB7B7B7FF60
        6060FFFF00FF}
      Margin = 3
      NumGlyphs = 2
      TabOrder = 0
      OnClick = btnSairClick
    end
  end
end
