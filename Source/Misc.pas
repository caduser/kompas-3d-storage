unit Misc;

interface

uses
  Classes,
  SysUtils,
  Graphics,
  ImgList,
  CommCtrl,

  Winapi.Windows,
  ActiveX,
  ShellApi,
  SHDocVw;


function IsNull(const Str: String): Boolean;
function CountPos(const SubText: string; Text: string): Integer;
procedure DrawImageListItem(AImgList: TCustomImageList; AIndex, ALeft,
  ATop: Integer; ACanvas: TCanvas; boPale: Boolean);

procedure WinExec2(const ACmdLine: String; const ACmdShow: UINT = SW_SHOWNORMAL);
function GetCurrentPathDll: string;


implementation


function IsNull(const Str: String): Boolean; overload;
// ѕроверка на пустую строку
begin
  Result := Length(Trim(Str)) = 0;
end;


function CountPos(const SubText: string; Text: string): Integer;
//¬озвращает количество вхождений подстроки в строку
 begin
   if (Length(SubText) = 0) or (Length(Text) = 0) or (Pos(SubText, Text) = 0) then
     Result := 0
   else
     Result := (Length(Text) - Length(StringReplace(Text, SubText, '', [rfReplaceAll]))) div
       Length(SubText);
 end;

type
  THackImageList = class(TCustomImageList); // дл€ вкрыти€ метода DoDraw

procedure DrawImageListItem(AImgList: TCustomImageList; AIndex, ALeft,
  ATop: Integer; ACanvas: TCanvas; boPale: Boolean);
const
  Style: array[TImageType] of Cardinal = (0, ILD_MASK);
var
  ExtraStyle: Cardinal;
begin
  if boPale then // дл€ "бледного" состо€ни€
    ExtraStyle := ILD_TRANSPARENT or ILD_BLEND50
  else
    ExtraStyle := ILD_TRANSPARENT;
  THackImageList(AImgList).DoDraw(AIndex, ACanvas,
    ALeft, ATop, Style[AImgList.ImageType] or ExtraStyle, not boPale
  );
end;

procedure WinExec2(const ACmdLine: String; const ACmdShow: UINT = SW_SHOWNORMAL);
var
  SI: TStartupInfo;
  PI: TProcessInformation;
  CmdLine: String;
begin
  Assert(ACmdLine <> '');

  CmdLine := ACmdLine;
  UniqueString(CmdLine);

  FillChar(SI, SizeOf(SI), 0);
  FillChar(PI, SizeOf(PI), 0);
  SI.cb := SizeOf(SI);
  SI.dwFlags := STARTF_USESHOWWINDOW;
  SI.wShowWindow := ACmdShow;

  SetLastError(ERROR_INVALID_PARAMETER);
  {$WARN SYMBOL_PLATFORM OFF}
  Win32Check(CreateProcess(nil, PChar(CmdLine), nil, nil, False, CREATE_DEFAULT_ERROR_MODE {$IFDEF UNICODE}or CREATE_UNICODE_ENVIRONMENT{$ENDIF}, nil, nil, SI, PI));
  {$WARN SYMBOL_PLATFORM ON}
  CloseHandle(PI.hThread);
  CloseHandle(PI.hProcess);
end;

function GetCurrentPathDll: string;
begin
  Result := '';
  SetLength(Result, MAX_PATH + 1);
  SetLength(Result, GetModuleFileName(HInstance, PChar(Result), Length(Result)));
  Result := ExtractFilePath(Result);
  Result := IncludeTrailingPathDelimiter(Result);
end;

end.
