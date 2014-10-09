unit VersionUtils;
interface
uses
    SysUtils, Xml.xmldom, Xml.XMLIntf, Xml.Win.msxmldom, Xml.XMLDoc;

const ACTUALVERSION: String = '1.0';

function UpgradeVersion(i: IXMLDocument): Boolean;
function CheckVersion(i: IXMLDocument): Boolean;
function GetVersion(i: IXMLDocument): String;

implementation
uses Logic;

function CheckVersion(i: IXMLDocument): Boolean;
begin
    if GetVersion(i) <> ACTUALVERSION then begin
        log('������ ��������. ���������.');
		if not UpgradeVersion(i) then begin
            log('���������� ����������� �������. �� �������.');
            exit;
        end else log('���������� �������');
    end;
    Log('������ ���� ���������');
    result:=True;
{$REGION '#Old'} //������ ���������������� ����������
    //    if GetVersion(i) = CURRENTVERSION then
    //    	result:= True
    //    else
    //    	result:= UpgradeVersion(i);
{$ENDREGION}
end;

function UpgradeVersion(i: IXMLDocument): Boolean;
begin
	result:=False;
	if GetVersion(i) = '1.0' then begin
    	//���������� �� 0.9
        //Exit             //�������
    end;
    if GetVersion(i) = '0.9' then begin
    	//���������� �� ���� � � � �� ���������...
    end;
    if GetVersion(i) = ACTUALVERSION then result:=True;
end;

function GetVersion(i: IXMLDocument): String;
begin
    result:=i.DocumentElement.Attributes['version'];
end;

end.
