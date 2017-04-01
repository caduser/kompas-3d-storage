unit events;

interface

uses
  Windows;

/////////////////////////////////////////////////////////////////////////////
// ApplicationEvent command target

 procedure  LIBRARYENTRY( comm: WORD  ); Pascal;
 function   LIBRARYID   : Cardinal;      Pascal;
 function   LibToolBarId( barType : Integer; index : Integer ) : Integer; stdcall;
 procedure  MyDLLProc(Reason: Integer);

implementation

uses
  SysUtils,
  Forms,

  LtDefine,
  LibTool,
  cBaseEvents,
  ApplicationEvents,
  DocumentEvents,
  ksConstTLB,

  MainCommands,
  ActiveDocument_API5;



const
  IDR_LIBID    = 2000; // Идентификатор библиотеки

procedure MyDLLProc(Reason: Integer);
begin
  if Reason = DLL_PROCESS_DETACH then begin
    cBaseEvent.TerminateEvents;
  end;
end;


//------------------------------------------------------------------------------
// LibraryId
//---
function LIBRARYID: UINT; pascal;
begin
  Result := IDR_LIBID;
end;

//------------------------------------------------------------------------------
// LibraryEntry
//---
procedure LIBRARYENTRY(comm: WORD); pascal;
var
  FullPath: string;
begin
  Application.Handle := GetHWindow;

  case comm of
    1:
    begin
      FullPath := GetActiveDocumentFileName;
      Subscribe_Stoarge(FullPath);
    end;

    2:
    begin
      FullPath := ExtractFilePath(GetActiveDocumentFileName);
      FullPath := ExcludeTrailingPathDelimiter(FullPath);
      Subscribe_Stoarge(FullPath);
    end;

    3:
    begin
      FullPath := GetActiveDocumentFileName;
      Commit_Stoarge(FullPath);
    end;

    4:
    begin
      FullPath := ExtractFilePath(GetActiveDocumentFileName);
      FullPath := ExcludeTrailingPathDelimiter(FullPath);
      Commit_Stoarge(ExtractFilePath(FullPath));
    end;

    10:
    begin
      if cBaseEvent.FindEvents(ntKompasObjectNotify, 0, -1, nil) = nil then
      begin
        if NewApplicationEvent() = nil then               // подписка на события приложения КОМПАС
          ksMessage('Не подписались');
      end
//      else
//        ksMessage('Уже подписались');
    end;
  end;
end;

//-------------------------------------------------------------------------------
// Получить идентификаторы инструментальных и компактных панелей
// ---
function LibToolBarId( barType : Integer; // Тип запрашиваемой панелей ( 0 - компактная панель, 1 - простая инструментальная панель )
                       index   : Integer ) : Integer; stdcall; // Индекс панели
begin
	if barType = 1 then
    if index = 0 then
      Result := 3001
    else
     Result := -1
	else
		Result := -1;
end;

end.

