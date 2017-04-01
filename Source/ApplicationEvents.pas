unit ApplicationEvents;

interface
uses
  Windows,
  Libtool,
  cBaseEvents,
  ks2DCOM_TLB,
  ksConstTLB,
  ActiveX,
  LtDefine;

type

PApplicationEvent = ^ApplicationEvent;
ApplicationEvent = class (cBaseEvent, IKompasObjectNotify )
public
  constructor Create(); overload;
  destructor  Destroy(); override;
  function Advise() : boolean; override;

  // Функция должна возвращать true если метод notifyType обрабатывается интерфейсом
  function IsNotifyProcess(notifyType: SYSINT): WORDBOOL; virtual; stdcall;
  // koCreateDocument - Начало создания документа
  function CreateDocument( pDoc : Reference; docType : Integer ) : WORDBOOL; virtual; stdcall;
     // koOpenDocumenBegin - Начало открытия документа
  function BeginOpenDocument( fileName: PAnsiChar ) : WORDBOOL; virtual; stdcall;
  // koOpenDocumen - Документ открыт
  function OpenDocument( newDoc : Reference; docType : integer ) : WORDBOOL; virtual; stdcall;
  // koActiveDocument - Переключение на другой активный документ
  function ChangeActiveDocument( newDoc : Reference; docType : integer ) : WORDBOOL; virtual; stdcall;
  // koApplicatinDestroy - Закрытие приложения
  function ApplicationDestroy() : WORDBOOL; virtual; stdcall;
  // koBeginCreate - процесс создания документа
  function BeginCreate( docType: Integer ) : WORDBOOL; virtual; stdcall;
  // koBeginOpenFile - процесс открытия документа
  function BeginOpenFile() : WORDBOOL; virtual; stdcall;
  // koBeginCloseAllDocument - Закрыть все файлы
  function BeginCloseAllDocument() : WORDBOOL; virtual; stdcall;
  // koKeyDown
  function  KeyDown(var key: Integer; flags: Integer; sysKey: WordBool): WordBool; virtual; stdcall;
  // koKeyUp
  function  KeyUp(var key: Integer; flags: Integer; sysKey: WordBool): WordBool; virtual; stdcall;
  // koKeyPress
  function  KeyPress(var key: Integer; sysKey: WordBool): WordBool; virtual; stdcall;
  // koBeginRequestFiles
  function  BeginRequestFiles(requestID: Integer; var files: OleVariant): WordBool; virtual; stdcall;
  // koBeginChoiceMaterial
  function BeginChoiceMaterial(MaterialPropertyId: Integer): WordBool; virtual; stdcall;
  // koBeginChoiceMaterial
  function ChoiceMaterial(MaterialPropertyId: Integer; material: PAnsiChar; density: Double): WordBool; virtual; stdcall;

end;

function NewApplicationEvent() : ApplicationEvent;

implementation

uses
  DocumentEvents;

function ApplicationEvent.IsNotifyProcess( notifyType: SYSINT ) : WORDBOOL;
begin
  Result := ( notifyType >= koCreateDocument ) And ( notifyType <= koBeginCloseAllDocument )
end;

function ApplicationEvent.CreateDocument( pDoc: Integer; docType: SYSINT ) : WORDBOOL;
var
  doc : reference;
begin
//  ksMessage( 'Был создан новый документ' );

  doc := ksGetCurrentDocument( {pDoc} 0 );
  if doc <> 0 then
  begin
    if  NewDocumentEvent( doc ) = nil  then
      ksMessage( 'Не подписались' );

//    if  NewDocumentEvent( doc ) <> nil  then
//      ksMessage( 'Подписались' )
//    else
//      ksMessage( 'Не подписались' );
  end;

  Result := true;
end;

  // koOpenDocumenBegin - Начало открытия документа
function ApplicationEvent.BeginOpenDocument( fileName: PAnsiChar ) : WORDBOOL;
begin
  Result := True;
  //Result := YesNo( 'Открывается документ.'#13#10'Продолжить?' ) = 1;
end;

  // koOpenDocumen - Документ открыт
function ApplicationEvent.OpenDocument( newDoc : Reference; docType : integer ) : WORDBOOL;
begin
  //ksMessage( 'Был открыт документ' );
  Result := true;
end;

// koActiveDocument - Переключение на другой активный документ
function ApplicationEvent.ChangeActiveDocument( newDoc : Reference; docType : integer ) : WORDBOOL;
begin
  //ksMessage( 'Был активизирован документ' );
  Result := true;
end;

// koApplicatinDestroy - Закрытие приложения
function ApplicationEvent.ApplicationDestroy() : WORDBOOL;
begin
  //ksMessage( 'Pавершается работа в Компасе' );
  Result := true;
end;

// koBeginCreate - процесс создания документа
function ApplicationEvent.BeginCreate( docType: Integer ) : WORDBOOL;
begin
  Result := True;
  //Result := YesNo( 'Использовать стандартное окно создания файла?' ) = 1;
end;

// koBeginOpenFile - процесс открытия документа
function ApplicationEvent.BeginOpenFile() : WORDBOOL;
begin
  Result := True;
  //Result := YesNo( 'Использовать стандартное окно открытия файла?' ) = 1;
end;

// koBeginOpenFile - процесс открытия документа
function ApplicationEvent.BeginCloseAllDocument() : WORDBOOL;
begin
  Result := True;
  //Result := YesNo( 'Закрыть все документы?' ) = 1;
end;

// koKeyDown
function  ApplicationEvent.KeyDown(var key: Integer; flags: Integer; sysKey: WordBool): WordBool;
begin
  Result := TRUE;
end;

// koKeyUp
function ApplicationEvent.KeyUp(var key: Integer; flags: Integer; sysKey: WordBool): WordBool;
begin
  Result := TRUE;
end;

// koKeyPress
function ApplicationEvent.KeyPress(var key: Integer; sysKey: WordBool): WordBool;
begin
  Result := TRUE;
end;

// koBeginRequestFiles
function  ApplicationEvent.BeginRequestFiles(requestID: Integer; var files: OleVariant): WordBool;
begin
  Result := TRUE;
end;

// koBeginChoiceMaterial
function ApplicationEvent.BeginChoiceMaterial(MaterialPropertyId: Integer): WordBool;
begin
  Result := TRUE;
end;

// koBeginChoiceMaterial
function ApplicationEvent.ChoiceMaterial(MaterialPropertyId: Integer; material: PAnsiChar; density: Double): WordBool;
begin
  Result := TRUE;
end;

destructor ApplicationEvent.Destroy();
begin
  inherited Destroy;
end;

constructor ApplicationEvent.Create();
begin
  inherited Create( ntKompasObjectNotify, 0, 0, 0 );
end;

//------------------------------------------------------------------------------
// Advise
//---
function ApplicationEvent.Advise() : boolean;
begin
  if not m_advise and ( m_params.ifType <> 0 ) then
    m_advise := boolean( ksConnectionAdvise( @m_params, PIUnknown(IKompasObjectNotify(self)) ) );
	Result := m_advise;
end;

function NewApplicationEvent() : ApplicationEvent;
begin
  Result := nil;
	if cBaseEvent.FindEvents( ntKompasObjectNotify, 0, 0, nil ) = nil then
  begin
	  Result := ApplicationEvent.Create();
		if not Result.Advise() then
    begin
      Result.Free;
			Result := nil;
		end
	end
end;

end.
