unit DocumentEvents;

interface

uses
  cBaseEvents,
  ks2DCOM_TLB,
  ks3DCOM_TLB,
  ActiveX,
  LtDefine;

type
////////////////////////////////////////////////////////////////////////////////
// DocumentEvent  - ���������� ������� �� ���������
//
DocumentEvent = class ( cBaseEvent, IDocumentFileNotify )
public
  constructor Create( docRef : Reference ); overload;
  destructor  Destroy(); override;
  function    Advise(): boolean; override;

protected
  // ������� ������ ���������� true ���� ����� notifyType �������������� �����������
  function IsNotifyProcess(notifyType: SYSINT): WORDBOOL; virtual; stdcall;
  //kdBeginCloseDocument - ������ �������� ���������.
  function BeginCloseDocument() : WORDBOOL; virtual; stdcall;
  //kdCloseDocument - �������� ������.
  function CloseDocument() : WORDBOOL; virtual; stdcall;
  //kdBeginSaveDocument - ������ ���������� ���������.
  function BeginSaveDocument( fileName : PAnsiChar ) : WORDBOOL; virtual; stdcall;
  //kdSaveDocument - �������� ��������.
  function SaveDocument() : WORDBOOL; virtual; stdcall;
  //kdActiveDocument - �������� �������������.
  function Activate() : WORDBOOL; virtual; stdcall;
  //kdDeactiveDocument - �������� ���������������.
  function Deactivate() : WORDBOOL; virtual; stdcall;
  //kdBeginSaveAsDocument - ������� ���������� �����.
  function BeginSaveAsDocument() : WORDBOOL; virtual; stdcall;
  //kdDocumentFrameOpen - �������� ���� ���������.
  function DocumentFrameOpen(const v: IUnknown): WORDBOOL; virtual; stdcall;
  //kdProcessActivate - ����������� ��������
  function ProcessActivate(Id: Integer): WORDBOOL; virtual; stdcall;
  //kdProcessActivate - ������������� ��������
  function ProcessDeactivate(Id: Integer): WORDBOOL; virtual; stdcall;

  function  BeginProcess(Id: Integer): WORDBOOL; virtual; stdcall;
  function  EndProcess(Id: Integer; Success: WORDBOOL): WORDBOOL; virtual; stdcall;
end;

function NewDocumentEvent( doc : reference ) : DocumentEvent;



implementation

uses
  LTool3D,
  Libtool,
  ksConstTLB,

  DiskValidate,
  MainCommands;


constructor DocumentEvent.Create( docRef : Reference );
begin
  inherited Create( ntDocumentFileNotify, docRef, docRef, 0 );
end;

destructor DocumentEvent.Destroy();
begin
  inherited Destroy;
end;

//------------------------------------------------------------------------------
// Advise
//---
function DocumentEvent.Advise() : boolean;
begin
  if not m_advise and ( m_params.ifType <> 0 ) then
    m_advise := boolean( ksConnectionAdvise( @m_params, LtDefine.PIUnknown(IDocumentFileNotify(self)) ) );
	Result := m_advise;
end;

function DocumentEvent.IsNotifyProcess( notifyType: SYSINT ) : WORDBOOL;
begin
  Result := ( notifyType >= kdBeginCloseDocument ) And ( notifyType <= kdBeginSaveAsDocument )
end;

//kdCloseDocument - ������ �������� ���������.
function DocumentEvent.BeginCloseDocument() : WORDBOOL;
begin
   Result := true;
//  Result := YesNo( '����������� ��������.'#13#10'����������?' ) = 1;
end;

//kdCloseDocument - �������� ������.
function DocumentEvent.CloseDocument() : WORDBOOL;
begin
  //ksMessage( '�������� ������.' );
  TerminateEventsByParam( 0, refDoc, -1, nil );
  Result := true;
end;

  //kdBeginSaveDocument - ������ ���������� ���������.
function DocumentEvent.BeginSaveDocument( fileName : PAnsiChar ) : WORDBOOL;
begin
   Result := true;
  //Result := YesNo( '��������� ��������?' ) = 1;
end;

//kdSaveDocument - �������� ��������.
function DocumentEvent.SaveDocument() : WORDBOOL;
var
  doc3D: IDocument3D;
  FileName: string;
  NewFileName: string;
begin
  Result := true;

  doc3D := IDocument3D( ksGetActive3dDocument() );
  if ( doc3D <> nil ) then
  begin
    doc3D._Release;
    FileName := doc3D.GetFileName;
    if not IsStorage(FileName) then
    begin
      case ShowTaskDialog(FileName) of
        1:
        begin
          NewFileName := GetFileByDialog(FileName);
          doc3D.SaveAs(PChar(NewFileName));
        end;

        2:
        begin
          Exit;
        end;
      end;
    end;
  end;
end;

//kdActiveDocument - �������� �������������.
function DocumentEvent.Activate() : WORDBOOL;
begin
  Result := true;
end;

  //kdDeactiveDocument - �������� ���������������.
function DocumentEvent.Deactivate() : WORDBOOL;
begin
  Result := true;
end;

  //kdBeginSaveAsDocument - ������ ���������� ���������.
function DocumentEvent.BeginSaveAsDocument() : WORDBOOL;
begin
  Result := true;
  //Result := YesNo( '������������ ����������� ������ ���������� �����?' ) = 1;
end;

//kdProcessActivate - �������� �������������.
function DocumentEvent.ProcessActivate( Id: Integer ) : WORDBOOL;
begin
  Result := true;
end;

//kdProcessActivate - �������� ���������������.
function DocumentEvent.ProcessDeactivate( Id: Integer ) : WORDBOOL;
begin
  Result := true;
end;

//kdDocumentFrameOpen - ������ ���������� ���������.
function DocumentEvent.DocumentFrameOpen( const v: IUnknown ) : WORDBOOL;
begin
  Result := true;
end;

function DocumentEvent.BeginProcess(Id: Integer): WORDBOOL;
begin
  Result := true;
end;

function DocumentEvent.EndProcess(Id: Integer; Success: WORDBOOL): WORDBOOL;
begin
  Result := true;
end;

function NewDocumentEvent(doc: reference): DocumentEvent;
begin
  Result := nil;
  if doc <> 0 then
  begin
		if cBaseEvent.FindEvents( ntDocumentFileNotify, doc, 0, nil ) = nil then
    begin
			Result := DocumentEvent.Create( doc );
			if not Result.Advise() then
      begin
        Result.Free;
				Result := nil;
			end
		end
	end
end;


end.
