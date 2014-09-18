unit uProperties;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Grids, Vcl.ValEdit, Vcl.StdCtrls;

type
  TfrmProperties = class(TForm)
    btnOK: TButton;
    btnCancel: TButton;
    vleProp: TValueListEditor;
    Label1: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure btnOKClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmProperties: TfrmProperties;

implementation

{$R *.dfm}
uses uMain;
//������� ��������
procedure TfrmProperties.btnCancelClick(Sender: TObject);
begin
	//frmProperties.Close;
	ModalResult:=mrCancel;
end;
//��������� � ������� ��������
procedure TfrmProperties.btnOKClick(Sender: TObject);
var i: Integer;
begin
	log('�������� �������� ��������');
	//���������� �� ���������� �����

    {......................}

	With xmlMain.DocumentElement.ChildNodes['Header'] do begin
    	for i := 0 to ChildNodes.Count - 1 do begin
//        	log(ChildNodes[i].NodeName);log(ChildNodes[i].Text); log(vleProp.Values[ChildNodes[i].NodeName]);
    		ChildNodes[i].Text:=vleProp.Values[ChildNodes[i].NodeName];
        end;
    end;
    //frmProperties.Close;
    ModalResult:=mrOK;
end;
//��������� ��������
//��������� � ������ �� ������� �� ��������� �����
//���������� ������ �������� � �������� Header
procedure TfrmProperties.FormCreate(Sender: TObject);
var i: Integer;
begin
    vleProp.InsertRow('���������*', xmlMain.DocumentElement.AttributeNodes['signature'].Text, True);
    vleProp.InsertRow('������ ��*', xmlMain.DocumentElement.AttributeNodes['version'].Text, True);
    vleProp.InsertRow('���� �����*', xmlMain.FileName, True);
    vleProp.InsertRow('������ �����*', '42kB', True);
    With xmlMain.DocumentElement.ChildNodes['Header'] do begin
        for i := 0 to ChildNodes.Count - 1 do
            vleProp.InsertRow(ChildNodes[i].NodeName, ChildNodes[i].Text, True);
    //	������ ������
    //		vleProp.InsertRow('���������', ChildNodes['Title'].Text, True);
    //  	vleProp.InsertRow('�����', ChildNodes['Author'].Text, True);
    //  	vleProp.InsertRow('��������', ChildNodes['Owner'].Text, True);
    //  	vleProp.InsertRow('����', ChildNodes['Date'].Text, True);
    //    	vleProp.InsertRow('������', ChildNodes['Password'].Text, True);
    end;
end;


end.
