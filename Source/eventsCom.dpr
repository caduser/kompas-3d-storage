////////////////////////////////////////////////////////////////////////////////
// Библиотека примеров: 'Самая простая библиотека'
////////////////////////////////////////////////////////////////////////////////
library eventsCom;

{$E rtw}


{$R 'events.res' 'events.rc'}

uses
  events in 'events.pas',
  ApplicationEvents in 'ApplicationEvents.pas',
  DocumentEvents in 'DocumentEvents.pas',
  cBaseEvents in 'cBaseEvents.pas',
  DiskValidate in 'DiskValidate.pas',
  MainCommands in 'MainCommands.pas',
  ActiveDocument_API7 in 'ActiveDocument_API7.pas',
  ActiveDocument_API5 in 'ActiveDocument_API5.pas',
  Misc in 'Misc.pas',
  TaskDialog in 'TaskDialog.pas' {frmTaskDialog};

exports
  LIBRARYENTRY,
  LIBRARYID,
  LibToolBarId;

begin
  DLLProc := @MyDLLProc;
end.
