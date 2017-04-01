unit ActiveDocument_API5;

interface

uses
  Classes,
  Windows;


function GetActiveDocumentFileName(): string;

implementation

uses
  ks3DCOM_TLB,
  LTool3D;

function GetActiveDocumentFileName(): string;
var
  doc3D: IDocument3D;
//  doc : reference;
begin
  Result := '';

//  doc := ksGetCurrentDocument( 0 );
//  doc3D := IDocument3D(ksGet3dDocumentFromReference(doc));
  doc3D := IDocument3D(ksGetActive3dDocument());
  if ( doc3D <> nil ) then
  begin
    doc3D._Release;
    Result := doc3D.GetFileName;
  end;
end;

end.
