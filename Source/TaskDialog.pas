unit TaskDialog;

interface

uses
  Windows,
  Messages,
  SysUtils,
  Variants,
  Classes,
  Graphics,
  Controls,
  Forms,
  Dialogs,
  StdCtrls,
  ExtCtrls,
  RzPanel,
  ImgList,
  Generics.Collections,
  Buttons;

  
type
  TTaskDialogComponent = class
    Component: TObject;
    ModalResult: TModalResult;
    Caption: string;
    Detail: string;
    Index: Integer;
    ImageList: TCustomImageList;
    ImageIndex: Integer;
  end;

  TfrmTaskDialog = class(TForm)
    lblMainText: TLabel;
    btnLinkButton: TRzPanel;
    lblDetail: TLabel;
    pnlBottom: TRzPanel;
    btnCancel: TButton;
    chkDoItForNexConflict: TCheckBox;
    ilDefault: TImageList;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    { Private declarations }
    FComponents: TObjectList<TTaskDialogComponent>;
    FLinkButtonIndex: Integer;
    FDefaultButtonHeight: Integer;
    procedure DoMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure DoMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure DoMouseEnter(Sender: TObject);
    procedure DoMouseLeave(Sender: TObject);
    procedure DoPaint(Sender: TObject);
    procedure DoClick(Sender: TObject);
    function GetTDC(Obj: TObject): TTaskDialogComponent;
    procedure LoadControlParam(LB: TRzPanel);
    procedure DrawButtonImage(ACanvas: TCanvas; AImageList: TCustomImageList;
      AImageIndex: Integer; AEnabled: Boolean);
    procedure DrawButtonText(ACanvas: TCanvas; ARect: TRect; Text: string;
      AEnabled: Boolean);
    procedure SetDialogWidth(const Value: Integer);
    function GetChecked: Boolean;
    procedure BeginUpdate;
    procedure EndUpdate;
    procedure SetDefaultButtonHeight(const Value: Integer);
  public
    { Public declarations }
    procedure SetTitle(const Value: string);
    procedure SetMainText(const Value: string);
    procedure SetDetail(const Value: string);
    procedure SetCheckBoxText(const Value: string);
    property DefaultButtonHeight: Integer write SetDefaultButtonHeight;
    procedure AddLinkButton(const AText, ADetail: string;
      AModalResult: TModalResult; AButtonIndex: Integer; AImageList: TCustomImageList;
      AImageIndex: Integer; AEnabled: Boolean); overload;
    procedure AddLinkButton(const AText: string; AModalResult: TModalResult); overload;
    procedure AddCancelButton;
    property DialogWidth: Integer write SetDialogWidth;
    property LinkButtonIndex: Integer read FLinkButtonIndex;
    property DoItForNextConflict: Boolean read GetChecked;
  end;

const
  cDefaultLinkButtonHeight = 50;


implementation

{$R *.dfm}

uses
  RzCommon,

  Misc;
  

const
  cCaptionColor = $00993300;
  cCaptionColorDark = $00551C15;
  cGradientColorStop = $00FFF8F3;//$00FFF8EA;
  cBorderColor = { $00FCF2DA } $00FCD7B9;// $00F8DFA5;
  cInnerBorderColor = $00FCD7B9;//$00FFFAF0;

  cGradientColorStartDown = $00FDEBDD;//$00FEF7E9;
  cGradientColorStopDown = $00FDDCC2; //$00FBE9C5;
  cBorderColorDown = $00CEA27D;


type
  TRzHackPanel = class(TRzPanel);


{ TfrmTaskDialog }

procedure TfrmTaskDialog.FormCreate(Sender: TObject);
begin
  FComponents := TObjectList<TTaskDialogComponent>.Create;
  lblDetail.Visible := False;
  pnlBottom.Visible := False;
  chkDoItForNexConflict.Visible := False;
  DoubleBuffered := True;
  FDefaultButtonHeight := cDefaultLinkButtonHeight;
  Self.KeyPreview := True;
end;

procedure TfrmTaskDialog.FormDestroy(Sender: TObject);
begin
  FComponents.Free;
end;

procedure TfrmTaskDialog.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  //т.к. не во всех случаях видна кнопка Отмена,
  //решим проблему так
  if Key = VK_ESCAPE then
    Self.Close;
end;

procedure TfrmTaskDialog.SetTitle(const Value: string);
begin
  Caption := Value;
end;

procedure TfrmTaskDialog.SetDialogWidth(const Value: Integer);
begin
  AutoSize := False;
  Width := Value;
  AutoSize := True;
end;

procedure TfrmTaskDialog.SetMainText(const Value: string);
begin
  lblMainText.Caption := Value;
end;

procedure TfrmTaskDialog.SetCheckBoxText(const Value: string);
begin
  chkDoItForNexConflict.Visible := not IsNull(Value);
  chkDoItForNexConflict.Caption := Value;
end;

procedure TfrmTaskDialog.SetDefaultButtonHeight(const Value: Integer);
begin
  FDefaultButtonHeight := Value;
end;

procedure TfrmTaskDialog.SetDetail(const Value: string);
begin
  lblDetail.Visible := not IsNull(Value);
  lblDetail.Caption := Value;
end;

procedure TfrmTaskDialog.AddLinkButton(const AText, ADetail: string;
  AModalResult: TModalResult; AButtonIndex: Integer; AImageList: TCustomImageList;
  AImageIndex: Integer; AEnabled: Boolean);
var
  Panel: TRzPanel;
  Component: TTaskDialogComponent;
  ButtonHeight: Integer;
begin
  BeginUpdate;
  Panel := TRzPanel.Create(Self);
  with Panel do
  begin
    Parent := Self;
    Top := Self.Height - 1;
    LoadControlParam(Panel);
    // устанавливаем состояние "курсор вне кнопки"
    DoMouseLeave(Panel);

    OnMouseDown := DoMouseDown;
    OnMouseUp := DoMouseUp;
    OnMouseEnter := DoMouseEnter;
    OnMouseLeave := DoMouseLeave;
    OnPaint := DoPaint;
    OnClick := DoClick;
    Enabled := AEnabled;
  end;
  EndUpdate;

  //Расчет высоты кнопки относительно количества #$A в ADetail
  //Остальные цифры выявлены экспериментальным путем
  ButtonHeight := 35 + (Misc.CountPos(#$A, ADetail) + 1) * 14;
  if ButtonHeight > FDefaultButtonHeight then
    Panel.Height :=  ButtonHeight;

  Component := TTaskDialogComponent.Create;
  Component.Component := Panel;
  Component.ModalResult := AModalResult;
  Component.Caption := AText;
  Component.Detail := ADetail;
  Component.Index := AButtonIndex;
  Component.ImageList := AImageList;
  Component.ImageIndex := AImageIndex;
  FComponents.Add(Component);
end;

procedure TfrmTaskDialog.AddLinkButton(const AText: string;
  AModalResult: TModalResult);
begin
  AddLinkButton(AText, '', AModalResult, 0, nil, 0, True);
end;

procedure TfrmTaskDialog.AddCancelButton;
begin
  pnlBottom.Top := Height;
  pnlBottom.Visible := True;
  Self.Padding.Bottom := 0;
end;

procedure TfrmTaskDialog.DoMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  TRzPanel(Sender).GradientColorStart := cGradientColorStartDown;
  TRzPanel(Sender).GradientColorStop :=  cGradientColorStopDown;

  TRzPanel(Sender).FlatColor := cBorderColorDown;
end;

procedure TfrmTaskDialog.DoMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  TRzPanel(Sender).GradientColorStart := clWhite;
  TRzPanel(Sender).GradientColorStop := cGradientColorStop;

  TRzPanel(Sender).FlatColor := cBorderColor;
end;

procedure TfrmTaskDialog.DoMouseEnter(Sender: TObject);
begin
  TRzPanel(Sender).FlatColor := cBorderColor;
  TRzPanel(Sender).Color := $00FCD7B9;

  TRzPanel(Sender).GradientColorStart := clWhite;
  TRzPanel(Sender).GradientColorStop := $00FFF8F3;
end;

procedure TfrmTaskDialog.DoMouseLeave(Sender: TObject);
begin
  TRzPanel(Sender).FlatColor := clWindow;
  TRzPanel(Sender).Color := clWindow;

  TRzPanel(Sender).GradientColorStart := clWindow;
  TRzPanel(Sender).GradientColorStop := clWindow;
end;

procedure TfrmTaskDialog.DoPaint(Sender: TObject);

  function CalculateCaptionRect(pnl: TRzPanel): TRect;
  const
    TextMarginH = 32;
    TextMarginV = 6;
  begin
    Result := TRzHackPanel(pnl).GetControlRect;
    Result.Top := TextMarginV;
    Result.Left := TextMarginH;
  end;

  function CalculateDetailRect(pnl: TRzPanel): TRect;
  const
    TextMarginH = 32;
    TextMarginV = 28;
  begin
    Result := TRzHackPanel(pnl).GetControlRect;
    Result.Top := TextMarginV;
    Result.Left := TextMarginH;
  end;

var
  TDC: TTaskDialogComponent;
  pnl: TRzPanel;
begin
  TDC := GetTDC(Sender);
  pnl := TRzPanel(Sender);
  DrawButtonImage(pnl.Canvas,
                  TDC.ImageList,
                  TDC.ImageIndex,
                  TRzPanel(Sender).Enabled);

  pnl.Canvas.Font.Color := cCaptionColorDark;
  if TDC.Caption <> '' then
  begin
    pnl.Canvas.Font.Size := 11;
    pnl.Canvas.Font.Style := pnl.Canvas.Font.Style - [fsBold];
    DrawButtonText(pnl.Canvas,
                   CalculateCaptionRect(pnl),
                   TDC.Caption,
                   TRzPanel(Sender).Enabled);
  end;
  if TDC.Detail <> '' then
  begin
    pnl.Canvas.Font.Size := 8;
    pnl.Canvas.Font.Style := pnl.Canvas.Font.Style - [fsBold];
    DrawButtonText(pnl.Canvas,
                   CalculateDetailRect(pnl),
                   TDC.Detail,
                   TRzPanel(Sender).Enabled);
  end;
end;

procedure TfrmTaskDialog.DrawButtonImage(ACanvas: TCanvas; AImageList: TCustomImageList;
  AImageIndex: Integer; AEnabled: Boolean);
begin
  if Assigned(AImageList) then
    DrawImageListItem(AImageList, AImageIndex, 6, 8, ACanvas, not AEnabled)
  else
    DrawImageListItem(ilDefault, 0, 6, 8, ACanvas, not AEnabled);
end;

procedure TfrmTaskDialog.DrawButtonText(ACanvas: TCanvas; ARect: TRect;
  Text: string; AEnabled: Boolean);
var
  TextRct: TRect;
  H: Integer;
begin
  TextRct := ARect;
  H := DrawString(ACanvas, Text, TextRct,
                  dt_CalcRect or dt_ExpandTabs or dt_VCenter or
                  DrawTextWordWrap[True] or DrawTextAlignments[taLeftJustify]);

  // Alignment Vertical of Top
  if ARect.Top + H < ARect.Bottom then
    ARect.Bottom := ARect.Top + H;

  ACanvas.Brush.Style := bsClear;
  if not AEnabled then
    ACanvas.Font.Color := clGrayText;

  DrawString(ACanvas, Text, ARect, dt_ExpandTabs or dt_VCenter or
             DrawTextWordWrap[True] or DrawTextAlignments[taLeftJustify]);
end;

function TfrmTaskDialog.GetChecked: Boolean;
begin
  Result := chkDoItForNexConflict.Checked;
end;

function TfrmTaskDialog.GetTDC(Obj: TObject): TTaskDialogComponent;
var
  Item: TTaskDialogComponent;
begin
  Result := nil;
  for Item in FComponents do
    if Item.Component = Obj then
      Exit(Item);
end;

procedure TfrmTaskDialog.LoadControlParam(LB: TRzPanel);
begin
  LB.Visible := True;
  LB.Height := FDefaultButtonHeight;

  LB.Align := btnLinkButton.Align;
  LB.AlignWithMargins := btnLinkButton.AlignWithMargins;
  LB.BorderOuter := btnLinkButton.BorderOuter;
  LB.Color := btnLinkButton.Color;
  LB.FlatColor := btnLinkButton.FlatColor;
  LB.FlatColorAdjustment := btnLinkButton.FlatColorAdjustment;
  LB.GradientColorStop := btnLinkButton.GradientColorStop;
  LB.GradientColorStyle := btnLinkButton.GradientColorStyle;
  LB.Margins := btnLinkButton.Margins;
  LB.VisualStyle := btnLinkButton.VisualStyle;

//  LB.FullRepaint := False;
  LB.TabStop := True;
end;

procedure TfrmTaskDialog.DoClick(Sender: TObject);
var
  TDC: TTaskDialogComponent;
begin
  TDC := GetTDC(Sender);
  FLinkButtonIndex := TDC.Index;
  ModalResult := TDC.ModalResult;
end;

procedure TfrmTaskDialog.BeginUpdate;
begin
  AutoSize := False;
  pnlBottom.Align := alNone;
end;

procedure TfrmTaskDialog.EndUpdate;
begin
  pnlBottom.Align := alTop;
  AutoSize := True;
end;

end.
