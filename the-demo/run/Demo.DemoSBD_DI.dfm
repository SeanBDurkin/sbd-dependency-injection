object mfmDemoSBD_DI: TmfmDemoSBD_DI
  Left = 0
  Top = 0
  Caption = 'Demo of SBD Dependency Injection Framework'
  ClientHeight = 292
  ClientWidth = 430
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  ShowHint = True
  WindowState = wsMaximized
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  DesignSize = (
    430
    292)
  PixelsPerInch = 96
  TextHeight = 13
  object rgFeatures: TRadioGroup
    Left = 8
    Top = 8
    Width = 414
    Height = 123
    Hint = 'This is a hint'
    Anchors = [akLeft, akTop, akRight]
    Caption = 'Feature to demonstrate '
    Columns = 3
    ItemIndex = 0
    Items.Strings = (
      'Feature One'
      'Feature Two'
      '(etc.)')
    ParentShowHint = False
    ShowHint = True
    TabOrder = 2
    OnClick = rgFeaturesClick
  end
  object memoLog: TMemo
    Left = 8
    Top = 135
    Width = 414
    Height = 149
    Anchors = [akLeft, akTop, akRight, akBottom]
    Color = clInfoBk
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Courier New'
    Font.Style = []
    Lines.Strings = (
      'Welcome to the Demonstration program for SBD '
      'Dependency Framework.'
      ''
      'Instructions'
      '============'
      '1. Select a feature of the framework that you '
      'are intested in learning about.'
      '2. Press the "Run" button and inspect the '
      'output, as appended to this text box.'
      '(You may need to scroll).'
      '3. Inspect the source code of the associated '
      'unit. This unit will be mentioned'
      'in the feature output. The code you read '
      'produced the Run output.'
      '4. For further information, mouse-hover over the '
      'method name of the '
      'IServiceProvider'
      'method, within the IDE. The IDE'#39's help insight '
      'feature should give you a '
      'decription'
      'of the function.'
      ''
      'Faithfully,'
      'Sean B. Durkin'
      '24-Jan-2014'
      ''
      ''
      '------------------------------------------------'
      '----------------'
      ''
      '')
    ParentFont = False
    ReadOnly = True
    ScrollBars = ssVertical
    TabOrder = 0
  end
  object btnRun: TButton
    Left = 340
    Top = 97
    Width = 75
    Height = 25
    Anchors = [akTop, akRight]
    Caption = 'Run'
    TabOrder = 1
    OnClick = btnRunClick
  end
end
