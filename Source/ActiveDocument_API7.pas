unit ActiveDocument_API7;

interface

uses
  Sysutils, LDefin2D, ksAuto, Libtool, Windows;

function GetActiveDocumentFileName(): string;


implementation

uses
  Dialogs,

  LtDefine,
  ksApi7,
  ksConstTLB,
  forms;

var
  newKompasAPI : IApplication;                                // Компас Application 7

procedure GetNewKompasAPI;
var
  disp : IDispatch;
begin
	if newKompasAPI = nil then
  begin
    disp := IDispatch(CreateKompasApplication);
    newKompasAPI := disp As IApplication;

    ShowMessage('GetNewKompasAPI');
  end;
end;

//-------------------------------------------------------------------------------
// Получить текущий документ
// ---
//function GetCurrentDocument : IKompasDocument3D;
//
//var
//  kDoc : IKompasDocument;
//begin
//  Result := nil;
//
//  if ( newKompasAPI <> nil ) then
//     // Получить активный документ
//     kDoc := newKompasAPI.ActiveDocument;
//  Result := kDoc As IKompasDocument3D;
//
//end;


function GetActiveDocumentFileName(): string;
var
  doc           : IKompasDocument;
begin
  GetNewKompasAPI;

  doc := newKompasAPI.ActiveDocument;
  if doc <> nil then
  begin
    ShowMessage(doc.Name + doc.Path);

    Result := doc.PathName;
    ShowMessage(Result);
  end;



  newKompasAPI := nil;
end;

end.
