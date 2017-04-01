unit cBaseEvents;

interface
uses
  Windows,
  LtDefine,
  LibTool,
  contnrs,
  ComObj,
  classes;

type

PcBaseEvent = ^cBaseEvent;
cBaseEvent = class ( TInterfacedObject )
  protected
    m_advise  : boolean;               // true - сделан Advise
    m_params  : NotifyConnectionParam; // параметры подписки
    refDoc    : reference;
public
  constructor Create( ifType : Integer; p : Reference; doc : Reference; objType : LongInt ); overload;
  destructor  Destroy(); override;

  // TInterfacedObject
  function QueryInterface(const IID: TGUID; out Obj): HResult; virtual; stdcall;
  function _AddRef: Integer; virtual; stdcall;
  function _Release: Integer; virtual; stdcall;
  // Соединение
  function  Advise() : boolean; virtual;
  procedure Unadvise();

  class procedure TerminateEvents();
  constructor     CreateByObj( ifType : Integer; var iObj : IUnknown  ); virtual;
  class procedure TerminateEventsByParam( eventType :LongInt; doc : Reference; objType : LongInt; const iObj : IUnknown );
  class function  FindEvents( eventType :LongInt; doc : Reference; objType : LongInt; const iObj : IUnknown ) : PcBaseEvent;
end;

////////////////////////////////////////////////////////////////////////////////
// Список подписчиков COM-сообщений
//---
cEventList = class ( TObjectList )
public
  constructor Create; overload;
  procedure Notify(Ptr: Pointer; Action: TListNotification); override;
end;

implementation
var
  m_BaseEventList : cEventList; // static BaseEvent

procedure cEventList.Notify(Ptr: Pointer; Action: TListNotification);
begin
  if OwnsObjects then
    if Action = lnDeleted then begin
      cBaseEvent(Ptr).UnAdvise;
      exit;
    end;
  inherited Notify(Ptr, Action);
end;

constructor cEventList.Create();
begin
  inherited Create;
end;

function cBaseEvent.QueryInterface(const IID: TGUID; out Obj): HResult; stdcall;
begin
  if GetInterface(IID, Obj) then
    Result := S_OK
  else
    Result := E_NOINTERFACE;
end;

function cBaseEvent._AddRef: Integer; stdcall;
begin
  Result := inherited _AddRef;
end;

function cBaseEvent._Release: Integer; stdcall;
begin
  Result := inherited _Release;
end;

//------------------------------------------------------------------------------
// Конструктор
//---
constructor cBaseEvent.Create( ifType : Integer; p : Reference; doc : Reference; objType : LongInt );
begin
  inherited Create;
  m_advise            := false;               // true - сделан Advise
  m_params.ifType     := ifType;
  m_params.pContainer := p;
  m_params.objType    := objType;
  m_params.iContainer := nil;
  refDoc              := doc;
  if  m_BaseEventList = nil then
    m_BaseEventList := cEventList.Create;
  m_BaseEventList.Add( Self );
end;

//------------------------------------------------------------------------------
// Конструктор
//---
constructor cBaseEvent.CreateByObj( ifType : Integer; var iObj : IUnknown );
begin
  inherited Create;
  m_advise            := false;               // true - сделан Advise
  m_params.ifType     := ifType;
  m_params.pContainer := 0;
  m_params.objType    := 0;
  m_params.iContainer := iObj;
  refDoc              := 0;
  if m_params.iContainer <> nil then
    m_params.iContainer._AddRef;
  if  m_BaseEventList = nil then
    m_BaseEventList := cEventList.Create;
  m_BaseEventList.Add( Self );
end;

//------------------------------------------------------------------------------
// Конструктор
//---
destructor cBaseEvent.Destroy();
begin
  Unadvise();                        // отпишемся от получения событий
  if ( m_BaseEventList <> nil ) then
  begin
    m_BaseEventList.Remove( Self );
    m_params.ifType     := 0;
    m_params.pContainer := 0;
    if ( m_params.iContainer <> nil ) then
      m_params.iContainer := nil;
  end
end;

//------------------------------------------------------------------------------
// Advise
//---
function cBaseEvent.Advise() : boolean;
begin
  if not m_advise and ( m_params.ifType <> 0 ) then
    m_advise := boolean( ksConnectionAdvise( @m_params, PIUnknown(self) ) );
	Result := m_advise;
end;

//------------------------------------------------------------------------------
// UnAdvise
//---
procedure cBaseEvent.Unadvise();
begin
  if m_advise then begin
    ksConnectionUnAdvise( @m_params );
    m_advise := false;
  end;
end;

//------------------------------------------------------------------------------
// TerminateEvents
//---
class procedure cBaseEvent.TerminateEvents();
begin
  if  m_BaseEventList <> nil then begin
    m_BaseEventList.Free;
    m_BaseEventList := nil;
  end
end;

//------------------------------------------------------------------------------
// Advise
//---
class procedure cBaseEvent.TerminateEventsByParam( eventType :LongInt; doc : Reference; objType : LongInt; const iObj : IUnknown );
var
  i     : Integer;
  p     : Pointer;
begin
  if ( eventType = 0 ) And  ( doc = 0 ) then
		TerminateEvents()
	else begin
    if ( m_BaseEventList <> nil ) then begin
      for i := m_BaseEventList.Count - 1 downto 0 do
        begin
          p := m_BaseEventList.Items[i];
          if ( p <> nil ) And ( ( eventType =  0   ) Or ( eventType = cBaseEvent(p).m_params.ifType  ) )
                          And ( ( doc       =  0   ) Or ( doc       = cBaseEvent(p).refDoc           ) )
                          And ( ( objType   = -1   ) Or ( objType   = cBaseEvent(p).m_params.objType ) )
                          And ( ( iObj      =  nil ) Or ( iObj      = cBaseEvent(p).m_params.iObj    ) )
          then begin
             m_BaseEventList.Remove( p );			// в деструкторе будет удален из списка RemoveAt(pos)
          end
        end
    end
  end
end;

class function cBaseEvent.FindEvents( eventType :LongInt; doc : Reference; objType : LongInt; const iObj : IUnknown ) : PcBaseEvent;
var
  i     : Integer;
  p     : Pointer;
begin
  Result := nil;
  if ( m_BaseEventList <> nil ) then begin
    for i := m_BaseEventList.Count - 1 downto 0 do
      begin
        p := m_BaseEventList.Items[i];
        if ( p <> nil ) And ( (   eventType =  0   ) Or ( eventType = cBaseEvent(p).m_params.ifType  ) )
                        And ( (   doc       =  0   ) Or ( doc       = cBaseEvent(p).refDoc           ) )
                        And ( ( objType   = -1     ) And ( cBaseEvent(p).m_params.objType = 0   ) Or ( objType = cBaseEvent(p).m_params.objType ) )
                        And ( ( iObj      =  nil ) And ( cBaseEvent(p).m_params.iObj    = nil ) Or ( iObj    = cBaseEvent(p).m_params.iObj    ) ) 
        then begin
            Pointer(Result) := p;
        end
      end
  end

end;

end.




