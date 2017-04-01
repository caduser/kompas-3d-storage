unit MainCommands;

interface

uses
  Classes,
  System.SysUtils,
  Vcl.Controls;

procedure Subscribe_Stoarge(const Path: string);
procedure Commit_Stoarge(const Path: string);
function ShowTaskDialog(const FileName: string): Integer;


implementation

uses
  //Dialogs, //!!!


  Forms,

  TaskDialog,
  Misc;


procedure Subscribe_Stoarge(const Path: string);
begin
  if Path = '' then
    Exit;

  WinExec2(Format(GetCurrentPathDll + 'StorageConsole\StorageConsole.exe subscribe "%s"', [Path]));
end;

procedure Commit_Stoarge(const Path: string);
begin
  if Path = '' then
    Exit;

  WinExec2(Format(GetCurrentPathDll + 'StorageConsole\StorageConsole.exe commit "%s"', [Path]));
end;

function ShowTaskDialog(const FileName: string): Integer;
// ��������� ������������� �� ����
// ������� ������ � ����������� ������� ��������
const
  scTitle = '���������� �����';
  scQuery =
    '���������� �� ����� ���������, ��������� ���� "%s" ������ ���� ������� �� ���� 3D-Storage';
  scDetail = '��� ���������� ���������� �������� ���� �� ��������� ��������';
var
  dlg: TfrmTaskDialog;
begin
  Result := Vcl.Controls.mrCancel;

  dlg := TfrmTaskDialog.Create(Application);
  try
    dlg.SetTitle(scTitle);
    dlg.SetMainText(Format(scQuery, [ExtractFileName(FileName)]));
    dlg.SetDetail(scDetail);
    dlg.AddLinkButton('��������� �� ����� 3D-Stoarege', Vcl.Controls.mrOk);
    dlg.AddLinkButton('������� ������� ����� �������� �����', Vcl.Controls.mrCancel);
    //dlg.AddLinkButton('������', mrCancel);
    Result := dlg.ShowModal;
  finally
    dlg.Free;
  end;
end;

end.
