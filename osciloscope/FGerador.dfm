object frmGerador: TfrmGerador
  Left = 173
  Top = 149
  Width = 750
  Height = 512
  Caption = 'Gerador de Ondas'
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  WindowState = wsMaximized
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 16
  object wavePlotter: TWaveShape
    Left = 193
    Top = 49
    Width = 549
    Height = 436
    Cursor = crCross
    interval = 1.000000000000000000
    volts = 2.000000000000000000
    Align = alClient
    ParentColor = False
    OnMouseMove = wavePlotterMouseMove
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 742
    Height = 49
    Align = alTop
    TabOrder = 0
    object Label11: TLabel
      Left = 280
      Top = 16
      Width = 65
      Height = 21
      AutoSize = False
      Caption = 'Amplitude:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      Layout = tlCenter
    end
    object Label3: TLabel
      Left = 16
      Top = 16
      Width = 113
      Height = 21
      AutoSize = False
      Caption = 'Intervalo de Tempo:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      Layout = tlCenter
    end
    object Bevel1: TBevel
      Left = 264
      Top = 8
      Width = 9
      Height = 33
      Shape = bsLeftLine
    end
    object cbVolts: TComboBox
      Left = 344
      Top = 16
      Width = 97
      Height = 24
      Style = csDropDownList
      ItemHeight = 16
      ItemIndex = 3
      TabOrder = 0
      Text = '2.00 V'
      OnChange = cbVoltsChange
      Items.Strings = (
        '200.00 mV'
        '400.00 mV'
        '800.00 mV'
        '2.00 V'
        '4.00 V'
        '8.00 V'
        '20.00 V'
        '40.00 V'
        '80.00 V')
    end
    object cbInterval: TComboBox
      Left = 137
      Top = 16
      Width = 104
      Height = 24
      Style = csDropDownList
      ItemHeight = 16
      ItemIndex = 6
      TabOrder = 1
      Text = '1.00 s'
      OnChange = cbIntervalChange
      Items.Strings = (
        '1.00 ms'
        '5.00 ms'
        '10.00 ms'
        '50.00 ms'
        '0.10 s'
        '0.50 s'
        '1.00 s'
        '5.00 s'
        '10.00 s')
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 49
    Width = 193
    Height = 436
    Align = alLeft
    TabOrder = 1
    object pgOsciloscopio: TPageControl
      Left = 1
      Top = 1
      Width = 193
      Height = 434
      ActivePage = tsGerador
      Align = alLeft
      TabOrder = 0
      object tsGerador: TTabSheet
        Caption = 'Gerador'
        object GroupBox1: TGroupBox
          Left = 8
          Top = 8
          Width = 169
          Height = 81
          Caption = 'Forma de Onda'
          TabOrder = 0
          object SBQuadrada: TSpeedButton
            Left = 64
            Top = 24
            Width = 41
            Height = 41
            GroupIndex = 1
            Glyph.Data = {
              76020000424D7602000000000000760000002800000020000000200000000100
              0400000000000002000000000000000000001000000000000000000000000000
              80000080000000808000800000008000800080800000C0C0C000808080000000
              FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00777777777777
              7777777777777777777777777777777777700000000000000007777777777777
              7770777777777777770777777777777777707777777777777707777777777777
              7770777777777777770777777777777777707777777777777707777777777777
              7770777777777777770777777777777777707777777777777707777777777777
              7770777777777777770777777777777777707777777777777707777777777777
              7770777777777777770777777777777777707777777777777707777777777777
              7770777777777777770777777777777777707777777777777707777777777777
              7770777777777777770770888888888888808888888888888807707777777777
              7770777777777777777770777777777777707777777777777777707777777777
              7770777777777777777770777777777777707777777777777777707777777777
              7770777777777777777770777777777777707777777777777777707777777777
              7770777777777777777770777777777777707777777777777777707777777777
              7770777777777777777770777777777777707777777777777777707777777777
              7770777777777777777770777777777777707777777777777777707777777777
              7770777777777777777770777777777777707777777777777777700000000000
              0000777777777777777777777777777777777777777777777777}
            OnClick = SBSenoideClick
          end
          object SBSenoide: TSpeedButton
            Tag = 2
            Left = 16
            Top = 24
            Width = 41
            Height = 41
            GroupIndex = 1
            Down = True
            Glyph.Data = {
              76020000424D7602000000000000760000002800000020000000200000000100
              0400000000000002000000000000000000001000000000000000000000000000
              80000080000000808000800000008000800080800000C0C0C000808080000000
              FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00777777777777
              7777777777777777777777777777777777777777777777777777777777777777
              7777777777077777777777777777777777777777707007777777777777777777
              7777777707777077777777777777777777777770777777077777777777777777
              7777770777777770777777777777777777777707777777707777777777777777
              7777707777777777077777777777777777777077777777770777777777777777
              7777707777777777707777777777777777770777777777777077777777777777
              7777077777777777770777777777777777770777777777777707777777777777
              7770777777777777777008888888888888808888888888888888077777777777
              7770777777777777777770777777777777707777777777777777707777777777
              7707777777777777777770777777777777077777777777777777770777777777
              7077777777777777777777077777777770777777777777777777770777777777
              7077777777777777777777707777777707777777777777777777777077777777
              0777777777777777777777770777777077777777777777777777777707777770
              7777777777777777777777777077770777777777777777777777777777077077
              7777777777777777777777777770077777777777777777777777777777777777
              7777777777777777777777777777777777777777777777777777}
            OnClick = SBSenoideClick
          end
          object SBTriangular: TSpeedButton
            Tag = 1
            Left = 112
            Top = 24
            Width = 41
            Height = 41
            GroupIndex = 1
            Glyph.Data = {
              76020000424D7602000000000000760000002800000020000000200000000100
              0400000000000002000000000000000000001000000000000000000000000000
              80000080000000808000800000008000800080800000C0C0C000808080000000
              FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00777777777777
              7777777777777777777777777777777777777777777707777777777777777777
              7777777777707077777777777777777777777777777070777777777777777777
              7777777777077707777777777777777777777777770777077777777777777777
              7777777770777770777777777777777777777777707777707777777777777777
              7777777707777770777777777777777777777777077777770777777777777777
              7777777077777777077777777777777777777707777777770777777777777777
              7777770777777777707777777777777777777077777777777077777777777777
              7777707777777777770770888888888888880888888888888807707777777777
              7777077777777777777777077777777777707777777777777777770777777777
              7770777777777777777777707777777777077777777777777777777077777777
              7707777777777777777777770777777770777777777777777777777707777777
              0777777777777777777777777077777707777777777777777777777770777770
              7777777777777777777777777707777077777777777777777777777777077707
              7777777777777777777777777770770777777777777777777777777777707077
              7777777777777777777777777777007777777777777777777777777777770777
              7777777777777777777777777777777777777777777777777777}
            OnClick = SBSenoideClick
          end
        end
        object GroupBox4: TGroupBox
          Left = 96
          Top = 96
          Width = 81
          Height = 105
          Caption = 'Amplitude'
          TabOrder = 1
          object Label7: TLabel
            Left = 24
            Top = 82
            Width = 15
            Height = 16
            Caption = '0V'
          end
          object Label6: TLabel
            Left = 24
            Top = 24
            Width = 15
            Height = 16
            Caption = '8V'
          end
          object eAmplitude: TEdit
            Left = 8
            Top = 48
            Width = 33
            Height = 24
            BevelKind = bkTile
            BorderStyle = bsNone
            ReadOnly = True
            TabOrder = 0
            Text = '1'
          end
          object spbAmp: TSpinButton
            Left = 48
            Top = 24
            Width = 20
            Height = 73
            DownGlyph.Data = {
              0E010000424D0E01000000000000360000002800000009000000060000000100
              200000000000D800000000000000000000000000000000000000008080000080
              8000008080000080800000808000008080000080800000808000008080000080
              8000008080000080800000808000000000000080800000808000008080000080
              8000008080000080800000808000000000000000000000000000008080000080
              8000008080000080800000808000000000000000000000000000000000000000
              0000008080000080800000808000000000000000000000000000000000000000
              0000000000000000000000808000008080000080800000808000008080000080
              800000808000008080000080800000808000}
            FocusControl = eAmplitude
            TabOrder = 1
            UpGlyph.Data = {
              0E010000424D0E01000000000000360000002800000009000000060000000100
              200000000000D800000000000000000000000000000000000000008080000080
              8000008080000080800000808000008080000080800000808000008080000080
              8000000000000000000000000000000000000000000000000000000000000080
              8000008080000080800000000000000000000000000000000000000000000080
              8000008080000080800000808000008080000000000000000000000000000080
              8000008080000080800000808000008080000080800000808000000000000080
              8000008080000080800000808000008080000080800000808000008080000080
              800000808000008080000080800000808000}
            OnDownClick = spbAmpDownClick
            OnUpClick = spbAmpUpClick
          end
        end
        object GroupBox3: TGroupBox
          Left = 8
          Top = 96
          Width = 81
          Height = 105
          Caption = 'Offset'
          TabOrder = 2
          object Label9: TLabel
            Left = 16
            Top = 82
            Width = 24
            Height = 16
            Caption = '- 8V'
          end
          object Label8: TLabel
            Left = 16
            Top = 24
            Width = 27
            Height = 16
            Caption = '+ 8V'
          end
          object spbOffset: TSpinButton
            Left = 48
            Top = 24
            Width = 20
            Height = 73
            DownGlyph.Data = {
              0E010000424D0E01000000000000360000002800000009000000060000000100
              200000000000D800000000000000000000000000000000000000008080000080
              8000008080000080800000808000008080000080800000808000008080000080
              8000008080000080800000808000000000000080800000808000008080000080
              8000008080000080800000808000000000000000000000000000008080000080
              8000008080000080800000808000000000000000000000000000000000000000
              0000008080000080800000808000000000000000000000000000000000000000
              0000000000000000000000808000008080000080800000808000008080000080
              800000808000008080000080800000808000}
            FocusControl = eOffSet
            TabOrder = 0
            UpGlyph.Data = {
              0E010000424D0E01000000000000360000002800000009000000060000000100
              200000000000D800000000000000000000000000000000000000008080000080
              8000008080000080800000808000008080000080800000808000008080000080
              8000000000000000000000000000000000000000000000000000000000000080
              8000008080000080800000000000000000000000000000000000000000000080
              8000008080000080800000808000008080000000000000000000000000000080
              8000008080000080800000808000008080000080800000808000000000000080
              8000008080000080800000808000008080000080800000808000008080000080
              800000808000008080000080800000808000}
            OnDownClick = spbOffsetDownClick
            OnUpClick = spbOffsetUpClick
          end
          object eOffSet: TEdit
            Left = 8
            Top = 48
            Width = 33
            Height = 24
            BevelKind = bkTile
            BorderStyle = bsNone
            ReadOnly = True
            TabOrder = 1
            Text = '0'
          end
        end
        object GroupBox2: TGroupBox
          Left = 8
          Top = 202
          Width = 169
          Height = 191
          Caption = 'Frequ'#234'ncia'
          TabOrder = 3
          object Label2: TLabel
            Left = 24
            Top = 69
            Width = 18
            Height = 16
            Caption = '1.0'
          end
          object sb1: TSpeedButton
            Left = 88
            Top = 72
            Width = 65
            Height = 17
            GroupIndex = 2
            Down = True
            Caption = '1'
            OnClick = sb1Click
          end
          object sb10: TSpeedButton
            Left = 88
            Top = 88
            Width = 65
            Height = 17
            GroupIndex = 2
            Caption = '10'
            OnClick = sb1Click
          end
          object sb100: TSpeedButton
            Left = 88
            Top = 104
            Width = 65
            Height = 17
            GroupIndex = 2
            Caption = '100'
            OnClick = sb1Click
          end
          object sbHz: TSpeedButton
            Left = 88
            Top = 128
            Width = 65
            Height = 17
            GroupIndex = 3
            Down = True
            Caption = 'Hz'
            OnClick = sb1Click
          end
          object sbKhz: TSpeedButton
            Left = 88
            Top = 144
            Width = 65
            Height = 17
            GroupIndex = 3
            Caption = 'Khz'
            OnClick = sb1Click
          end
          object sbMhz: TSpeedButton
            Left = 88
            Top = 160
            Width = 65
            Height = 17
            GroupIndex = 3
            Caption = 'Mhz'
            OnClick = sb1Click
          end
          object shape: TShape
            Left = 16
            Top = 24
            Width = 137
            Height = 33
            Brush.Color = 15658734
            Pen.Color = clGray
          end
          object lblFrequencia: TLabel
            Left = 16
            Top = 24
            Width = 137
            Height = 33
            Alignment = taRightJustify
            AutoSize = False
            Caption = '0.00 Hz'
            Color = clBtnFace
            Font.Charset = OEM_CHARSET
            Font.Color = 5592405
            Font.Height = -19
            Font.Name = 'Terminal'
            Font.Style = [fsBold]
            ParentColor = False
            ParentFont = False
            Transparent = True
            Layout = tlCenter
          end
          object Label1: TLabel
            Left = 24
            Top = 165
            Width = 18
            Height = 16
            Caption = '0.0'
          end
          object eFator: TEdit
            Left = 16
            Top = 112
            Width = 33
            Height = 24
            BevelKind = bkTile
            BorderStyle = bsNone
            ReadOnly = True
            TabOrder = 0
            Text = '1'
          end
          object tbFator: TTrackBar
            Left = 48
            Top = 64
            Width = 33
            Height = 121
            Max = 100
            Orientation = trVertical
            PageSize = 10
            Position = 50
            TabOrder = 1
            TickMarks = tmTopLeft
            TickStyle = tsManual
            OnChange = tbFatorChange
          end
        end
      end
      object tsEquacao: TTabSheet
        Caption = 'Equa'#231#227'o de Ganho'
        ImageIndex = 1
        object lblGanho: TLabel
          Left = 8
          Top = 368
          Width = 91
          Height = 16
          Caption = 'Ganho de 100%'
        end
        object GroupBox5: TGroupBox
          Left = 8
          Top = 120
          Width = 169
          Height = 233
          Caption = 'Vari'#225'veis'
          TabOrder = 0
          object Panel4: TPanel
            Left = 8
            Top = 24
            Width = 153
            Height = 201
            BevelInner = bvRaised
            BevelOuter = bvLowered
            TabOrder = 0
            object vlVariaveis: TValueListEditor
              Left = 2
              Top = 2
              Width = 149
              Height = 197
              Align = alClient
              BorderStyle = bsNone
              Ctl3D = False
              DefaultColWidth = 50
              FixedCols = 1
              ParentCtl3D = False
              Strings.Strings = (
                '=')
              TabOrder = 0
              TitleCaptions.Strings = (
                'Vari'#225'vel'
                'Valor')
              OnValidate = vlVariaveisValidate
              ColWidths = (
                59
                88)
              RowHeights = (
                18
                18)
            end
          end
        end
        object GroupBox6: TGroupBox
          Left = 8
          Top = 8
          Width = 169
          Height = 105
          Caption = 'Equa'#231#227'o de ganho'
          TabOrder = 1
          object eExpression: TMemo
            Left = 8
            Top = 24
            Width = 153
            Height = 73
            BevelKind = bkTile
            BorderStyle = bsNone
            Lines.Strings = (
              '1')
            TabOrder = 0
            OnChange = eExpressionChange
          end
        end
      end
    end
  end
  object XPManifest1: TXPManifest
    Left = 464
    Top = 16
  end
end
