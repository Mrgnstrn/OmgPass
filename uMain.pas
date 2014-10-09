unit uMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  StdCtrls, Forms, ImgList, Menus, ComCtrls, ExtCtrls, ToolWin,
  Vcl.DBCtrls, Vcl.Mask, Vcl.Samples.Spin,
  Vcl.ButtonGroup, Vcl.Buttons,
  {XML}
  Xml.xmldom, Xml.XMLIntf, Xml.Win.msxmldom, Xml.XMLDoc,
  {My modules}
  XMLutils, VersionUtils, Logic, uCustomEdit;
type
TfrmMain = class(TForm)
    menuMain: TMainMenu;
    N1: TMenuItem;
    mnuAccounts: TMenuItem;
    mnuPass: TMenuItem;
    N4: TMenuItem;
    mnuInsertItem: TMenuItem;
    mnuDelete: TMenuItem;
    mnuInsertFolder: TMenuItem;
    mnuEditItem: TMenuItem;
    N9: TMenuItem;
    N11: TMenuItem;
    N12: TMenuItem;
    mnuOptions: TMenuItem;
    mnuGenerator: TMenuItem;
    N14: TMenuItem;
    mnuExport: TMenuItem;
    mnuPrint: TMenuItem;
    N17: TMenuItem;
    N18: TMenuItem;
    mnuChowPass: TMenuItem;
    mnuClearClip: TMenuItem;
    N21: TMenuItem;
    mnuTop: TMenuItem;
    N24: TMenuItem;
    ToolBarMain: TToolBar;
    imlToolBar: TImageList;
    tbtnAccounts: TToolButton;
    ToolButton2: TToolButton;
    tbtnInsertItem: TToolButton;
    tbtnInsertFolder: TToolButton;
    tbtnEdit: TToolButton;
    tbtnDelete: TToolButton;
    tbtnOptions: TToolButton;
    tbtnHelp: TToolButton;
    ToolButton9: TToolButton;
    tabMain: TTabControl;
    N29: TMenuItem;
    mnuThemes: TMenuItem;
    tvMain: TTreeView;
    Splitter: TSplitter;
    fpMain: TScrollBox;
    mnuBaseProperties: TMenuItem;
    sbMain: TStatusBar;
    imlField: TImageList;
    imlTree: TImageList;
    imlTab: TImageList;
    menuTreePopup: TPopupMenu;
    mnuPopupInsertItem: TMenuItem;
    mnuPopupInsertFolder: TMenuItem;
    mnuPopupEditItem: TMenuItem;
    mnuPopupDelete: TMenuItem;
    imlPopup: TImageList;
    N23: TMenuItem;
    tmrTreeExpand: TTimer;
    btnAddPage: TSpeedButton;
    btnDeletePage: TSpeedButton;
    tmrRenameTab: TTimer;
    tbtnLog: TToolButton;
    mnuPopupCloneItem: TMenuItem;
    mnuCloneItem: TMenuItem;
    btnTheme: TSpeedButton;
    procedure mnuAccountsClick(Sender: TObject);
    procedure tbtnAccountsClick(Sender: TObject);
    procedure mnuGeneratorClick(Sender: TObject);
    procedure mnuOptionsClick(Sender: TObject);
    procedure tbtnOptionsClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure fpMainMouseWheel(Sender: TObject; Shift: TShiftState;
      WheelDelta: Integer; MousePos: TPoint; var Handled: Boolean);
    procedure mnuBasePropertiesClick(Sender: TObject);
    procedure tabMainChange(Sender: TObject);
    procedure tvMainChange(Sender: TObject; Node: TTreeNode);
    procedure tvMainDblClick(Sender: TObject);
    procedure mnuEditItemClick(Sender: TObject);
    procedure mnuPopupEditItemClick(Sender: TObject);
    procedure menuTreePopupPopup(Sender: TObject);
    procedure tbtnEditClick(Sender: TObject);
    procedure mnuPopupInsertFolderClick(Sender: TObject);
    procedure tbtnInsertFolderClick(Sender: TObject);
    procedure mnuInsertFolderClick(Sender: TObject);
    procedure tbtnHelpClick(Sender: TObject);
    procedure tvMainEdited(Sender: TObject; Node: TTreeNode; var Title: string);
    procedure tvMainEditing(Sender: TObject; Node: TTreeNode;
      var AllowEdit: Boolean);
    procedure tbtnDeleteClick(Sender: TObject);
    procedure mnuDeleteClick(Sender: TObject);
    procedure mnuPopupDeleteClick(Sender: TObject);
    procedure btnAddPageClick(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure btnDeletePageClick(Sender: TObject);
    procedure tbtnInsertItemClick(Sender: TObject);
    procedure tabMainMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure tmrRenameTabTimer(Sender: TObject);
    procedure tabMainMouseLeave(Sender: TObject);
    procedure mnuPopupInsertItemClick(Sender: TObject);
    procedure mnuInsertItemClick(Sender: TObject);
    procedure tvMainCollapsed(Sender: TObject; Node: TTreeNode);
    procedure tvMainExpanded(Sender: TObject; Node: TTreeNode);
    procedure tvMainCollapsing(Sender: TObject; Node: TTreeNode;
      var AllowCollapse: Boolean);
    procedure tbtnLogClick(Sender: TObject);
    procedure OnMove(var Msg: TWMMove); message WM_MOVE;
    procedure tvMainStartDrag(Sender: TObject; var DragObject: TDragObject);
    procedure tvMainDragDrop(Sender, Source: TObject; X, Y: Integer);
    procedure tvMainDragOver(Sender, Source: TObject; X, Y: Integer;
      State: TDragState; var Accept: Boolean);
    procedure tmrTreeExpandTimer(Sender: TObject);
    procedure mnuPopupCloneItemClick(Sender: TObject);
    procedure mnuCloneItemClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ThemeMenuClick(Sender: TObject);
    procedure btnThemeClick(Sender: TObject);

private
    procedure InitGlobal();
	{ Private declarations }
public
	{ Public declarations }
end;

var
    frmMain: TfrmMain;

implementation

{$R *.dfm}

uses uAccounts, uGenerator, uOptions, uProperties, uEditItem, uLog;
{//////////////////////////////////////////////////////////////////////////////}

{$REGION '#����� �����������'}
//�������� ����� �����������.
//��� ����������� �������� � Logic
procedure TfrmMain.tbtnLogClick(Sender: TObject);
begin
	if Assigned(frmLog) and frmLog.Visible then begin
          	FreeAndNil(frmLog);
        	tbtnLog.Down:=False;
        end
    else begin
        frmLog:=  TfrmLog.Create(nil);
        frmLog.Left:=frmMain.Left + frmMain.Width +3;
        frmLog.Top:=frmMain.Top;
        frmLog.Height:=frmMain.Height;
        frmLog.lbLog.Items:=LogList;
        frmLog.lbLog.ItemIndex:=frmLog.lbLog.Items.Count-1;
        frmLog.Show;
        bLogDocked:=True;
        tbtnLog.Down:=True;
        frmLog.tmrLog.OnTimer(nil);
    end;
end;
{$ENDREGION}

{$REGION '#���������� ����� ���� � ���� ��������'}
procedure TfrmMain.OnMove(var Msg: TWMMove);
begin
    if Assigned(frmLog) and bLogDocked then
      frmLog.tmrLog.OnTimer(nil);
end;
{$ENDREGION}

{$REGION '#�������� ��������� ������'}
procedure TfrmMain.tbtnAccountsClick(Sender: TObject);
begin
mnuAccounts.Click;
end;
procedure TfrmMain.mnuAccountsClick(Sender: TObject);
begin
if (not Assigned(frmAccounts)) then frmAccounts:=  TfrmAccounts.Create(Self);
frmAccounts.ShowModal;
FreeAndNil(frmAccounts);
end;
procedure TfrmMain.mnuBasePropertiesClick(Sender: TObject);
begin
if (not Assigned(frmProperties)) then frmProperties:= TfrmProperties.Create(Self);
if frmProperties.ShowModal = mrOK then log('�������� �������� ��');
FreeAndNil(frmProperties);
end;

procedure TfrmMain.mnuGeneratorClick(Sender: TObject);
begin
if (not Assigned(frmGenerator)) then frmGenerator:=  TfrmGenerator.Create(Self);
frmGenerator.formType:= 1;
frmGenerator.ShowModal;
FreeAndNil(frmGenerator);
end;
procedure TfrmMain.tbtnOptionsClick(Sender: TObject);
begin
mnuOptionsClick(nil);
end;
procedure TfrmMain.mnuOptionsClick(Sender: TObject);
begin
if (not Assigned(frmOptions)) then frmOptions:= TfrmOptions.Create(Self);
frmOptions.ShowModal;
FreeAndNil(frmOptions);
end;
{$ENDREGION}

{$REGION '#������ �������������� ������ � �.�. ����� ������� � TreeView'}
procedure TfrmMain.tvMainDblClick(Sender: TObject);
//����� ������
begin
	if not tvMain.Selected.HasChildren then
		EditNode(tvMain.Selected);
end;
procedure TfrmMain.mnuEditItemClick(Sender: TObject);
begin
	EditNode(tvMain.Selected);
end;
procedure TfrmMain.mnuPopupEditItemClick(Sender: TObject);
//� ��� �� ��� �� ������
var selNode: TTreeNode;
begin
	selNode:= tvMain.GetNodeAt(tvMain.ScreenToClient(menuTreePopup.PopupPoint).X,
    						tvMain.ScreenToClient(menuTreePopup.PopupPoint).Y);
    if selNode = nil then selNode:=tvMain.Selected;
    selNode.Selected:=True;
	EditNode(selNode);
end;
procedure TfrmMain.tbtnEditClick(Sender: TObject);
begin
	EditNode(tvMain.Selected);
end;
procedure TfrmMain.tvMainEdited(Sender: TObject; Node: TTreeNode;
  var Title: string);
begin
	Log('TreeView_onEdited');
	if Title ='' then begin
        Beep;
		Log('tvMainEdited: Empty names r not allowed!');
        Title:=Node.Text;
        Exit;
    end;
	EditNodeTitle(IXMLNode(Node.Data), Title);
end;
procedure TfrmMain.tvMainEditing(Sender: TObject; Node: TTreeNode;
  var AllowEdit: Boolean);
begin
	Log('TreeView_onEditing');
end;
{$ENDREGION}

{$REGION '#���������� ����� ��������, ����� ��� ������'}
procedure TfrmMain.mnuPopupInsertFolderClick(Sender: TObject);
var selNode: TTreeNode;
begin
	selNode:= tvMain.GetNodeAt(tvMain.ScreenToClient(menuTreePopup.PopupPoint).X,
    						tvMain.ScreenToClient(menuTreePopup.PopupPoint).Y);
    if selNode = nil then selNode:=tvMain.Selected;
    selNode.Selected:=True;
	InsertFolder(selNode);
end;
procedure TfrmMain.tbtnInsertFolderClick(Sender: TObject);
begin
	InsertFolder(tvMain.Selected);
end;
procedure TfrmMain.mnuInsertFolderClick(Sender: TObject);
begin
	InsertFolder(tvMain.Selected);
end;
procedure TfrmMain.mnuPopupInsertItemClick(Sender: TObject);
var selNode: TTreeNode;
begin
	selNode:= tvMain.GetNodeAt(tvMain.ScreenToClient(menuTreePopup.PopupPoint).X,
    						tvMain.ScreenToClient(menuTreePopup.PopupPoint).Y);
    if selNode = nil then selNode:=tvMain.Selected;
    selNode.Selected:=True;
	InsertItem(selNode);
end;
procedure TfrmMain.mnuInsertItemClick(Sender: TObject);
begin
	InsertItem(tvMain.Selected);
end;
procedure TfrmMain.tbtnInsertItemClick(Sender: TObject);
begin
	InsertItem(tvMain.Selected);
end;
procedure TfrmMain.btnAddPageClick(Sender: TObject);
begin
    AddPage();
end;
{$ENDREGION}

{$REGION '#������������ ����'}
    procedure TfrmMain.menuTreePopupPopup(Sender: TObject);
    //���������� ���� ������������ ������� �� ������. �����.
    var selNode: TTreeNode;
    begin
        selNode:= tvMain.GetNodeAt(tvMain.ScreenToClient(menuTreePopup.PopupPoint).X,
        						tvMain.ScreenToClient(menuTreePopup.PopupPoint).Y);
        if selNode = nil then selNode:=tvMain.Selected;
   	log('menuTreePopup: �������� ����: ' + selNode.Text + ', Sender:' + Sender.UnitName);
        //�� ���� ����� ����� ����������, �� ��������� ����� ��� ��� �������.
    	   	{case GetNodeType(IXMLNode(selNode.Data)) of
            	ntItem: begin
        			mnuPopupInsertItem.Enabled:=False;
                    mnuPopupInsertFolder.Enabled:=False;
                    mnuPopupEditItem.Enabled:=True;
                    mnuPopupDelete.Enabled:=True;
                    end;
                ntFolder: begin
                	mnuPopupInsertItem.Enabled:=True;
                    mnuPopupInsertFolder.Enabled:=True;
                    mnuPopupEditItem.Enabled:=False;
                    mnuPopupDelete.Enabled:=True;
                    end;
                ntPage: begin
                	mnuPopupInsertItem.Enabled:=True;
                    mnuPopupInsertFolder.Enabled:=True;
                    mnuPopupEditItem.Enabled:=True;
                    mnuPopupDelete.Enabled:=True;
           	end;
        end; }
    end;

{$ENDREGION}

{$REGION '#��������'}
procedure TfrmMain.btnDeletePageClick(Sender: TObject);
begin
    DeleteNode(tvMain.Selected, True);
end;
procedure TfrmMain.btnThemeClick(Sender: TObject);
begin
    if intThemeIndex <> mnuThemes.Count - 1 then
        mnuThemes.Items[intThemeIndex + 1].Click
    else
        mnuThemes.Items[0].Click;
end;

procedure TfrmMain.tbtnDeleteClick(Sender: TObject);
begin
	DeleteNode(tvMain.Selected);
end;
procedure TfrmMain.mnuDeleteClick(Sender: TObject);
begin
	DeleteNode(tvMain.Selected);
end;
procedure TfrmMain.mnuPopupDeleteClick(Sender: TObject);
var selNode: TTreeNode;
begin
	selNode:= tvMain.GetNodeAt(tvMain.ScreenToClient(menuTreePopup.PopupPoint).X,
    						tvMain.ScreenToClient(menuTreePopup.PopupPoint).Y);
    if selNode = nil then selNode:=tvMain.Selected;
    selNode.Selected:=True;
	DeleteNode(selNode);
end;
{$ENDREGION}

{$REGION '#������������ ������'}
procedure TfrmMain.mnuPopupCloneItemClick(Sender: TObject);
    var selNode: TTreeNode;
    begin
  	selNode:= tvMain.GetNodeAt(tvMain.ScreenToClient(menuTreePopup.PopupPoint).X,
      						tvMain.ScreenToClient(menuTreePopup.PopupPoint).Y);
    if selNode = nil then selNode:=tvMain.Selected;
    selNode.Selected:=True;
  	CloneNode(selNode);
end;
procedure TfrmMain.mnuCloneItemClick(Sender: TObject);
begin
    CloneNode(tvMain.Selected);
end;
{$ENDREGION}

{$REGION '#�������������� ���� �� ������ � ���������'}
procedure TfrmMain.tabMainMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
//������ ������� ��� ��������������
//���� � ������� ���������� �������, ������ ���� ����� �����
//��. tabMainChange
begin
	if tmrRenameTab.Tag=1 then
        tmrRenameTab.Tag:=0
	else
    	tmrRenameTab.Enabled:=True;
end;
procedure TfrmMain.tabMainMouseLeave(Sender: TObject);
//���� ���� �������, �� �������������� �� �����
begin
	tmrRenameTab.Enabled:=False;
end;
procedure TfrmMain.tmrRenameTabTimer(Sender: TObject);
//������ ����������� ����� �������, ���� �� ������� � ���� ����
//���������� � ������������� ���� �����. ��������.
begin
with tvMain.Items[0] do begin
	Selected:=True;
	EditText;
end;
tmrRenameTab.Enabled:=False;
end;
{$ENDREGION}

{$REGION '#������'}
procedure TfrmMain.tvMainChange(Sender: TObject; Node: TTreeNode);
begin
    if Node.Data = nil then Exit;
    //log(Integer(Node.Data));
    //log(IXMLNode(Node.Data).NodeName);
    //ClearPanel(fpMain);
    GeneratePanel(IXMLNode(Node.Data), fpMain);
end;
procedure TfrmMain.tabMainChange(Sender: TObject);
begin
  		tmrRenameTab.Tag:=1;
    	CleaningPanel(fpMain, True);
    	ParsePageToTree(tabMain.TabIndex, tvMain);
        tvMain.Items[0].Selected:=True;
end;
{$ENDREGION}

{$REGION '#������ ��������� ������'}
procedure TfrmMain.tvMainCollapsed(Sender: TObject; Node: TTreeNode);
begin
if Node.Selected then SetNodeExpanded(Node);
Log('Collapsing ' + Node.Text);
end;
procedure TfrmMain.tvMainExpanded(Sender: TObject; Node: TTreeNode);
begin
if Node.Selected then SetNodeExpanded(Node);
Log('Expanding ' + Node.Text);
end;
procedure TfrmMain.tvMainCollapsing(Sender: TObject; Node: TTreeNode;
  var AllowCollapse: Boolean);
//������ ������������ ������ ������
begin
if Node.IsFirstNode then AllowCollapse:= False;
end;
{$ENDREGION}

{$REGION '#����&���� � ������'}
procedure TfrmMain.tvMainStartDrag(Sender: TObject;
var DragObject: TDragObject);
begin
    Log('Drag!');
end;

procedure TfrmMain.tvMainDragDrop(Sender, Source: TObject; X, Y: Integer);
var
  trgNode, selNode: TTreeNode;
begin
Log('Drop!');
  	trgNode := tvMain.GetNodeAt(X, Y);
  	selNode := tvMain.Selected;
    //if trgNode = DragGhostNode then trgNode:= DragGhostNode.getNextSibling;
    
  	if (trgNode = nil) or (trgNode=selNode) then Exit;
	DragAndDrop(trgNode, selNode,(GetKeyState(VK_CONTROL) AND 128) = 128);
    tmrTreeExpand.Enabled:=False;
    intTickToExpand:= 0;
end;

procedure TfrmMain.tvMainDragOver(Sender, Source: TObject; X, Y: Integer;
State: TDragState; var Accept: Boolean);
const
  crDragCopy: Integer = -23;          //��� �� ��� ��������, ����� ����������
var
  trgNode, selNode, tmpNode: TTreeNode;
begin
    if (GetKeyState(VK_CONTROL) AND 128) = 128 then
        tvMain.DragCursor:= crDragCopy
    else
        tvMain.DragCursor:= crDrag;
  	trgNode := tvMain.GetNodeAt(x, y);
  	selNode := tvMain.Selected;
    nodeToExpand:=trgNode;                             
    tmrTreeExpand.Enabled:=True;
    
    if (trgNode=nil) or
    (trgNode = selNode) or
    //(trgNode = selNode.Parent) or
    (selNode = nil) then begin
        Accept:=False;
        DragAndDropVisual(nil, nil);
        Exit;
    end;
    
    //��������� �������� �� ��������� ���������
    tmpNode:=trgNode;
    while (tmpNode.Parent <> nil) do begin
        tmpNode := tmpNode.Parent;
        if tmpNode = SelNode then begin
            Accept := False;
            DragAndDropVisual(nil, nil);
            Exit;
        end;
    end;
    
    //�����!
    DragAndDropVisual(trgNode, selNode);
end;

procedure TfrmMain.tmrTreeExpandTimer(Sender: TObject);
//���������
begin
    if (oldNode <> nil) and (nodeToExpand <> nil) then
    Log('Expand timer: ' + IntToStr(intTickToExpand) +
        ', OldNode: ' + oldNode.Text + 
        ', ActualNode: ' + nodeToExpand.Text);
        
    if (nodeToExpand = oldNode) then
        if intTickToExpand = 5 then begin
            //nodeToExpand.Expanded:= not nodeToExpand.Expanded;
            if nodeToExpand<>nil then nodeToExpand.Expand(False);
            tmrTreeExpand.Enabled:=False;
            Exit;
        end else 
              inc(intTickToExpand)
    else begin
        intTickToExpand:= 0;
        oldNode:= nodeToExpand;
    end;
end;
{$ENDREGION}

{$REGION '#������ �����'}
procedure TfrmMain.FormResize(Sender: TObject);
begin
	//tvMain.Width:= frmMain.ClientWidth div 5 * 2;
    tvMain.Align:=alLeft;
    Splitter.Left:=tvMain.Width;
    Log(Sender.ToString);
    if Assigned(frmLog) and bLogDocked then
    	frmLog.tmrLog.OnTimer(nil);
end;
procedure TfrmMain.fpMainMouseWheel(Sender: TObject; Shift: TShiftState;
  WheelDelta: Integer; MousePos: TPoint; var Handled: Boolean);
//������������� ������
begin
fpMain.VertScrollBar.Position:= fpMain.VertScrollBar.Position - WheelDelta div 5;
end;

procedure TfrmMain.FormClose(Sender: TObject; var Action: TCloseAction);
begin
    SaveSettings;
end;

procedure TfrmMain.FormCreate(Sender: TObject);
begin
    InitGlobal;
end;

procedure TfrmMain.ThemeMenuClick(Sender: TObject);
begin
    With TMenuItem(Sender) do begin
        SetTheme(Caption);
        Checked:=True;
        intThemeIndex:=MenuIndex;
    end;
end;
{$ENDREGION}

//������������� �����
procedure TfrmMain.InitGlobal();
begin
    LoadThemes;
	LogList:= TStringList.Create;
	Log('�������������...');
	xmlMain:=TXMLDocument.Create(frmMain);
	xmlMain.LoadFromFile('../../omgpass.xml');
	xmlMain.Active:=True;
    xmlMain.Options :=[doNodeAutoIndent, doAttrNull, doAutoSave];

    SetButtonImg(btnAddPage, imlField, 10);
    SetButtonImg(btnDeletePage, imlField, 12);
    SetButtonImg(btnTheme, imlTab, 41);

    Log('�������� ������');
    if not CheckVersion(xmlMain) then Exit;
	frmMain.Caption:= frmMain.Caption +' ['+ GetBaseTitle(xmlMain)+']';

    ParsePagesToTabs(xmlMain, tabMain);
    LoadSettings;

end;

procedure TfrmMain.tbtnHelpClick(Sender: TObject);
begin
frmMain.tvMain.Width:= xmlCfg.GetValue('TreeWidth', 200);//
end;

end.
