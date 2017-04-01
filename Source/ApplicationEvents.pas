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

  // ������� ������ ���������� true ���� ����� notifyType �������������� �����������
  function IsNotifyProcess(notifyType: SYSINT): WORDBOOL; virtual; stdcall;
  // koCreateDocument - ������ �������� ���������
  function CreateDocument( pDoc : Reference; docType : Integer ) : WORDBOOL; virtual; stdcall;
     // koOpenDocumenBegin - ������ �������� ���������
  function BeginOpenDocument( fileName: PAnsiChar ) : WORDBOOL; virtual; stdcall;
  // koOpenDocumen - �������� ������
  function OpenDocument( newDoc : Reference; docType : integer ) : WORDBOOL; virtual; stdcall;
  // koActiveDocument - ������������ �� ������ �������� ��������
  function ChangeActiveDocument( newDoc : Reference; docType : integer ) : WORDBOOL; virtual; stdcall;
  // koApplicatinDestroy - �������� ����������
  function ApplicationDestroy() : WORDBOOL; virtual; stdcall;
  // koBeginCreate - ������� �������� ���������
  function BeginCreate( docType: Integer ) : WORDBOOL; virtual; stdcall;
  // koBeginOpenFile - ������� �������� ���������
  function BeginOpenFile() : WORDBOOL; virtual; stdcall;
  // koBeginCloseAllDocument - ������� ��� �����
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
//  ksMessage( '��� ������ ����� ��������' );

  doc := ksGetCurrentDocument( {pDoc} 0 );
  if doc <> 0 then
  begin
    if  NewDocumentEvent( doc ) = nil  then
      ksMessage( '�� �����������' );

//    if  NewDocumentEvent( doc ) <> nil  then
//      ksMessage( '�����������' )
//    else
//      ksMessage( '�� �����������' );
  end;

  Result := true;
end;

  // koOpenDocumenBegin - ������ �������� ���������
function ApplicationEvent.BeginOpenDocument( fileName: PAnsiChar ) : WORDBOOL;
begin
  Result := True;
  //Result := YesNo( '����������� ��������.'#13#10'����������?' ) = 1;
end;

  // koOpenDocumen - �������� ������
function ApplicationEvent.OpenDocument( newDoc : Reference; docType : integer ) : WORDBOOL;
begin
  //ksMessage( '��� ������ ��������' );
  Result := true;
end;

// koActiveDocument - ������������ �� ������ �������� ��������
function ApplicationEvent.ChangeActiveDocument( newDoc : Reference; docType : integer ) : WORDBOOL;
begin
  //ksMessage( '��� ������������� ��������' );
  Result := true;
end;

// koApplicatinDestroy - �������� ����������
function ApplicationEvent.ApplicationDestroy() : WORDBOOL;
begin
  //ksMessage( 'P���������� ������ � �������' );
  Result := true;
end;

// koBeginCreate - ������� �������� ���������
function ApplicationEvent.BeginCreate( docType: Integer ) : WORDBOOL;
begin
  Result := True;
  //Result := YesNo( '������������ ����������� ���� �������� �����?' ) = 1;
end;

// koBeginOpenFile - ������� �������� ���������
function ApplicationEvent.BeginOpenFile() : WORDBOOL;
begin
  Result := True;
  //Result := YesNo( '������������ ����������� ���� �������� �����?' ) = 1;
end;

// koBeginOpenFile - ������� �������� ���������
function ApplicationEvent.BeginCloseAllDocument() : WORDBOOL;
begin
  Result := True;
  //Result := YesNo( '������� ��� ���������?' ) = 1;
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
