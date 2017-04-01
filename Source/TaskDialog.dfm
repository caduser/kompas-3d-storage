object frmTaskDialog: TfrmTaskDialog
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'frmTaskDialog'
  ClientHeight = 191
  ClientWidth = 375
  Color = clWindow
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  Padding.Bottom = 10
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnKeyDown = FormKeyDown
  PixelsPerInch = 96
  TextHeight = 13
  object lblMainText: TLabel
    AlignWithMargins = True
    Left = 16
    Top = 14
    Width = 343
    Height = 36
    Margins.Left = 16
    Margins.Top = 14
    Margins.Right = 16
    Margins.Bottom = 8
    Align = alTop
    Caption = #1059' '#1042#1072#1089' '#1086#1090#1089#1091#1090#1089#1074#1091#1102#1090' '#1087#1088#1072#1074#1072' '#1085#1072' '#1074#1099#1087#1086#1083#1085#1077#1085#1080#1077' '#1101#1090#1086#1081' '#1086#1087#1077#1088#1072#1094#1080#1080
    Font.Charset = DEFAULT_CHARSET
    Font.Color = 10040064
    Font.Height = -15
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    WordWrap = True
    ExplicitWidth = 318
  end
  object lblDetail: TLabel
    AlignWithMargins = True
    Left = 16
    Top = 58
    Width = 343
    Height = 13
    Margins.Left = 16
    Margins.Top = 0
    Margins.Right = 16
    Margins.Bottom = 8
    Align = alTop
    Caption = #1059' '#1042#1072#1089' '#1086#1090#1089#1091#1090#1089#1074#1091#1102#1090' '#1087#1088#1072#1074#1072' '#1085#1072' '#1074#1099#1087#1086#1083#1085#1077#1085#1080#1077' '#1101#1090#1086#1081' '#1086#1087#1077#1088#1072#1094#1080#1080
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    WordWrap = True
    ExplicitWidth = 281
  end
  object btnLinkButton: TRzPanel
    AlignWithMargins = True
    Left = 16
    Top = 82
    Width = 343
    Height = 54
    Margins.Left = 16
    Margins.Right = 16
    Margins.Bottom = 4
    Align = alTop
    Alignment = taLeftJustify
    AlignmentVertical = avTop
    BorderOuter = fsFlatRounded
    Color = 16570297
    FlatColor = 16570297
    FlatColorAdjustment = 0
    Font.Charset = DEFAULT_CHARSET
    Font.Color = 5577749
    Font.Height = -15
    Font.Name = 'Tahoma'
    Font.Style = []
    GradientColorStyle = gcsCustom
    GradientColorStop = 16775411
    ParentFont = False
    TabOrder = 0
    Visible = False
    VisualStyle = vsGradient
  end
  object pnlBottom: TRzPanel
    AlignWithMargins = True
    Left = 0
    Top = 150
    Width = 375
    Height = 41
    Margins.Left = 0
    Margins.Top = 10
    Margins.Right = 0
    Margins.Bottom = 0
    Align = alTop
    BorderOuter = fsNone
    BorderSides = [sdTop]
    BorderColor = 14671839
    BorderWidth = 1
    Color = 15790320
    TabOrder = 1
    DesignSize = (
      375
      41)
    object btnCancel: TButton
      Left = 290
      Top = 9
      Width = 75
      Height = 25
      Anchors = [akTop, akRight]
      Caption = #1054#1090#1084#1077#1085#1072
      ModalResult = 2
      TabOrder = 0
    end
    object chkDoItForNexConflict: TCheckBox
      Left = 16
      Top = 11
      Width = 268
      Height = 17
      Caption = 'chkDoItForNexConflict'
      TabOrder = 1
    end
  end
  object ilDefault: TImageList
    ColorDepth = cd32Bit
    Height = 17
    Width = 17
    Left = 312
    Top = 40
    Bitmap = {
      494C010101000800140011001100FFFFFFFF2110FFFFFFFFFFFFFFFF424D3600
      0000000000003600000028000000440000001100000001002000000000001012
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000502090366020D047400000014000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000009290BBF175B1DEB1C6922F30B330FD80000
      0014000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000010C3B
      0EE82AA83DFF2AA83DFF279735FC0B3610D80000001400000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000B360FCC209634FB27AB3FFF27AB3FFF249A
      37FC0B3A10D80000001400000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00140B3F10D8219F39FC23AF41FF23AF41FF219F39FC0B3F10D8000000140000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000000004013A0004
      013A0004013A0004013A0004013A0004013A0004013A0B4310D81DA33BFC1FB3
      43FF1FB343FF1DA33BFC0B4310D8000000140000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000140B4814D80E541ADE0E541ADE0E541ADE0E541ADE0E541ADE0E54
      1ADE0E541ADE0E541ADE107025EB1BB646FF1BB646FF1BB646FF1AA83EFC0B48
      14D8000000140000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000415057413822FF317BA49FF17BA
      49FF17BA49FF17BA49FF17BA49FF17BA49FF17BA49FF17BA49FF17BA49FF17BA
      49FF17BA49FF17BA49FF17BA49FF13822FF30415057400000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000004160574108A30F313BF4BFF13BF4BFF13BF4BFF13BF4BFF13BF4BFF13BF
      4BFF13BF4BFF13BF4BFF13BF4BFF13BF4BFF13BF4BFF13BF4BFF13BF4BFF108A
      30F3041605740000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000140E5617D80E641EDE0E64
      1EDE0E641EDE0E641EDE0E641EDE0E641EDE0E641EDE0E641EDE0F7E2CEB0EC2
      4EFF0EC24EFF0EC24EFF0FB544FC0E5617D80000001400000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000106013A0106013A0106013A0106013A0106013A0106
      013A0106013A0F5B18D80CB946FC0BC650FF0BC650FF0CB946FC0F5B18D80000
      0014000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000140F5F19D809BD49FC07CA53FF07CA
      53FF09BD49FC0F5F19D800000014000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000E59
      17CC07BB4AFB04CD55FF04CD55FF06C04BFC106319D800000014000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000113721CE801CF56FF01CF56FF03C24CFC1066
      19D8000000140000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000B53
      14BF0B9230EB09A237F3106919D8000000140000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000503170566041E0774000000140000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000424D3E000000000000003E00000028000000440000001100000001000100
      00000000CC0000000000000000000000000000000000000000000000FFFFFF00
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000}
  end
end