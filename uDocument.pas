unit uDocument;
interface

uses SysUtils, Classes, XMLIntf, XMLDoc, uStrings, XMLUtils;

type tOmgDocType = (dtXML, dtCrypted);

type TCryptedFileHeader = record
    theMagic:String[4];
    fVersion:Byte;
    CryData: array[0..127] of Byte;
end;

type cOmgDocument = class
    FilePath: String;
    DocumentType: tOmgDocType;
    XML: iXMLDocument;
    Pages: IXMLNodeList;
    Password: String;
    CurrentPage: Integer;                   //������� ���������
    CurrentRecord: Integer;                 //...� ������
private
    xmlStream: TStream;
    cryStream: TStream;
    procedure LoadPosition;
    function OpenXMLfromStream(xmlMainStream: TStream): Boolean;
    function OpenXML(xmlPath: String): Boolean;
    function OpenCrypted(cryPath: String; Password: String): Boolean;
public
    constructor Create;
    destructor Destroy; override;
    function Open(Path: String; Pass: String): Boolean;
    function Save: Boolean;
    function Close: Boolean;
    function GetProperty(PropertyName: String; DefValue: Variant): Variant;
    function SetProperty(PropertyName: String; Value: Variant): Boolean;
end;

implementation
uses Logic;

constructor cOmgDocument.Create;
begin
    inherited Create;
end;

destructor cOmgDocument.Destroy;
begin
    XML._Release;
    xmlStream.Free;
    cryStream.Free;
    inherited Destroy;
end;

function cOmgDocument.OpenXMLfromStream(xmlMainStream: TStream): Boolean;
begin
try
    XML:=TXMLDocument.Create(nil);
    XML.LoadFromStream(xmlMainStream);
    XML.Options :=[doAttrNull, doAutoSave];
    XML.ParseOptions:=[poValidateOnParse];
    Pages:= NodeByPath(XML, 'Root|Data').ChildNodes;
    LoadPosition;
    Result:=True;
    except
        on e: Exception do begin
        ErrorMsg(e, 'DocumentOpen');
        Result:=False;
    end;
end;
end;

function cOmgDocument.OpenXML(xmlPath: String): Boolean;
begin
    xmlStream := TFileStream.Create(xmlPath, fmOpenReadWrite);
    Self.OpenXMLfromStream(xmlStream);
end;

function cOmgDocument.OpenCrypted(cryPath: String; Password: String): Boolean;
begin
    //Empty for a while
end;

function cOmgDocument.Open(Path: String; Pass: String): Boolean;
begin
    Self.FilePath:=Path;
    if ExtractFileExt(Path) = strDefaultExt then begin
        Self.OpenXML(Path);
        DocumentType:=dtXML;
    end else begin
        Self.OpenCrypted(Path, Pass);
        DocumentType:=dtCrypted;
    end;
end;

function cOmgDocument.Save: Boolean;
begin
    //
end;

function cOmgDocument.Close: Boolean;
begin
    FreeAndNil(xmlStream);
    FreeAndNil(cryStream);
end;

procedure cOmgDocument.LoadPosition;
begin
    Self.CurrentPage:= Self.GetProperty('SelectedPage', 0);
    Self.CurrentRecord:=Self.GetProperty('Selected', 0);
end;

{$REGION '#DocProperty'}
function cOmgDocument.GetProperty(PropertyName: String; DefValue: Variant): Variant;
//��������� � ������ ������� ���������
//��� �������� �������� � ntHeader
//������� �������� ���.. �����
begin
if (xml.ChildNodes[strRootNode].ChildNodes.FindNode(strHeaderNode) = nil)
or (xml.ChildNodes[strRootNode].ChildNodes[strHeaderNode].ChildNodes.FindNode(PropertyName) = nil)
        then Result:=DefValue
    else Result:=xml.ChildNodes[strRootNode].ChildNodes[strHeaderNode].ChildValues[PropertyName];;
end;
function cOmgDocument.SetProperty(PropertyName: String; Value: Variant): Boolean;
var hNode: IXMLNode;
begin
    hNode:= xml.ChildNodes[strRootNode].ChildNodes.FindNode(strHeaderNode);
    if hNode = nil then
        hNode:=xml.ChildNodes[strRootNode].AddChild(strHeaderNode);
    if hNode.ChildNodes.FindNode(PropertyName) = nil then
        hNode.AddChild(PropertyName);
    hNode.ChildValues[PropertyName]:=Value;
end;
{$ENDREGION}

end.
