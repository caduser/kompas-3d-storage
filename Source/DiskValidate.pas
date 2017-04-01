unit DiskValidate;

interface

uses
  Classes;

function IsStorage(const Path: string): Boolean;
function GetFileByDialog(const AFileName: string): string;

implementation

uses
  Winapi.Windows,
  Winapi.Messages,
  System.SysUtils,
  Vcl.Dialogs,
  Vcl.StdCtrls;


function GetHDDInfo(const Path: string; var AVolumeName, AFileSystemName: string): Boolean;
var
  Drive: string;
  SerialNumber, FileSystemFlags, ComponentLength: DWORD;
  VolumeNameBuffer, FileSystemBuffer: array[0..MAX_PATH - 1] of Char;

  _VolumeName, _FileSystemName:array [0..MAX_PATH-1] of Char;
  _VolumeSerialNo,_MaxComponentLength,_FileSystemFlags:LongWord;
begin
  Result := False;

  if DirectoryExists(Path) or FileExists(Path) then
  begin
    Drive := IncludeTrailingPathDelimiter(ExtractFileDrive(Path));

    if GetVolumeInformation(PChar(Drive), @VolumeNameBuffer[0], MAX_PATH, @SerialNumber,
      ComponentLength, FileSystemFlags, @FileSystemBuffer[0], MAX_PATH) then
    begin
      AVolumeName := VolumeNameBuffer;
      AFileSystemName := FileSystemBuffer;

      Result := True;
    end;
  end;
end;

function IsStorage(const Path: string): Boolean;
var
  f1, f2: string;
begin
  if GetHDDInfo(Path, f1, f2) then
    Result := f1 = '3D-Storage'
  else
    Result := False;
end;

function GetFileByDialog(const AFileName: string): string;
var
  FileSaveDialog1: TFileSaveDialog;
  fti: TFileTypeItem;
  FileExt: string;
begin
  Result := '';
  FileSaveDialog1 := TFileSaveDialog.Create(nil);
  try
    FileSaveDialog1.Title := 'Укажите имя файла для сохранения';
    FileSaveDialog1.DefaultFolder := 'Z:\';

    fti := FileSaveDialog1.FileTypes.Add;

    FileExt := ExtractFileExt(AFileName);
    if FileExt = '.a3d' then
    begin
      fti.DisplayName := 'КОМПАС-Сборки';
      fti.FileMask := '*.a3d';
    end
    else
    if FileExt = '.m3d' then
    begin
      fti.DisplayName := 'КОМПАС-Детали';
      fti.FileMask := '*.m3d';
    end;

    FileSaveDialog1.FileName := ExtractFileName(AFileName);

    FileSaveDialog1.Execute;
    Result := FileSaveDialog1.FileName;
  finally
    FreeAndNil(FileSaveDialog1);
  end;
end;


end.
