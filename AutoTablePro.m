function varargout = AutoTablePro(varargin)
% AUTOTABLEPRO MATLAB code for AutoTablePro.fig
%      AUTOTABLEPRO, by itself, creates a new AUTOTABLEPRO or raises the existing
%      singleton*.
%
%      H = AUTOTABLEPRO returns the handle to a new AUTOTABLEPRO or the handle to
%      the existing singleton*.
%
%      AUTOTABLEPRO('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in AUTOTABLEPRO.M with the given input arguments.
%
%      AUTOTABLEPRO('Property','Value',...) creates a new AUTOTABLEPRO or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before AutoTablePro_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to AutoTablePro_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help AutoTablePro

% Last Modified by GUIDE v2.5 03-Dec-2019 12:10:53

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @AutoTablePro_OpeningFcn, ...
                   'gui_OutputFcn',  @AutoTablePro_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before AutoTablePro is made visible.
function AutoTablePro_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to AutoTablePro (see VARARGIN)

% Choose default command line output for AutoTablePro
handles.output = hObject;
global clickNum;%井段数
clickNum=1;
set(handles.edit4,'String',1);
dd=cell(1,6);
dd={'3000','3005','3002','85','114','125'};
set(handles.uitable2,'Data',dd);%初始化一行

set(handles.edit1,'String',num2str(139.7));
set(handles.edit2,'String',num2str(114.3));
set(handles.edit3,'String',num2str(12.7));
% Update handles structure
guidata(hObject, handles);

% UIWAIT makes AutoTablePro wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = AutoTablePro_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- If Enable == 'on', executes on mouse press in 5 pixel border.
% --- Otherwise, executes on mouse press in 5 pixel border or over text2.
function text2_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to text2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes during object creation, after setting all properties.
function uitable1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to uitable1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
data1=get(handles.uitable2,'Data');
row1=get(handles.edit1,'String');
row2=get(handles.edit2,'String');
row3=get(handles.edit3,'String');
allColumnName={'序号','井段(m)','变形长度(m)','最大变形点深度(m)','最小内径(mm)','平均内径(mm)',...
    '最大内径(mm)','最大变形量(mm)','变形程度(%)','变形等级','见附图'};

clickNum=str2num(get(handles.edit4,'String'));%获取井段数

    data2=cell(11);%处理后的数据体
    data3=cell(11);%列标题数据体
    dataInterval={0,0,0,0,0,0,0,0,0,0,0};%井段列初始化
    dataInterpretation={0,0,0,0,0,0,0,0,0,0,0};%评价列初始化
    data4=zeros(11);%处理后的数字数据体
    data2(1:clickNum,1)={1:clickNum};
    for i=1:clickNum
        data2(i,2)={[char(data1(i,1)),'～',char(data1(i,2))]};
    end
    data2(1:clickNum,3)={str2num(char(data1(1:clickNum,2)))-str2num(char(data1(1:clickNum,1)))};
    data2(1:clickNum,4)={str2num(char(data1(1:clickNum,3)))};
    data2(1:clickNum,5)={str2num(char(data1(1:clickNum,4)))};
    data2(1:clickNum,6)={str2num(char(data1(1:clickNum,5)))};
    data2(1:clickNum,7)={str2num(char(data1(1:clickNum,6)))};
    for i=1:clickNum
        data2(i,8)={max(abs(str2num(char(data1(i,4)))-str2num(row2)),abs(str2num(char(data1(i,6)))-str2num(row2)))};
        data2(i,9)={100*max(abs(str2num(char(data1(i,4)))-str2num(row2)),abs(str2num(char(data1(i,6)))-str2num(row2)))/...
        str2num(row2)};%变形程度
    end
    data3(1,:)=allColumnName;
    temp=zeros(1:clickNum);
    temp=cell2mat(data2(1:clickNum,1));
    data4(1:clickNum,1)=temp(1,1:clickNum)';%序号列
    data4(1:clickNum,11)=temp(1,1:clickNum)';%附图列
    dataInterval(1:clickNum)=data2(1:clickNum,2);%井段列
    for i=1:clickNum
        temp=cell2mat(data2(i,3));%变形长度
        data4(i,3)=temp(i,1);
        temp=cell2mat(data2(i,4));
        data4(i,4)=temp(i,1);
        temp=cell2mat(data2(i,5));
        data4(i,5)=temp(i,1);
        temp=cell2mat(data2(i,6));
        data4(i,6)=temp(i,1);
        temp=cell2mat(data2(i,7));
        data4(i,7)=temp(i,1);
        temp=cell2mat(data2(i,8));
        data4(i,8)=temp;
        temp=cell2mat(data2(i,9));%变形程度
        data4(i,9)=temp;
        %条件判断
        if(data4(i,3)>10)
            switch(data4(i,3)>10)
                case(data4(i,9)<=5)
                    dataInterpretation(i)={'一级变形'};
                case(5<data4(i,9))&&(data4(i,9)<=10)
                    dataInterpretation(i)={'二级变形'};
                case(10<data4(i,9))&&(data4(i,9)<=20)
                    dataInterpretation(i)={'三级变形'};
                case(20<data4(i,9))&&(data4(i,9)<=40)
                    dataInterpretation(i)={'四级变形'};
                case(40<data4(i,9))
                    dataInterpretation(i)={'五级变形'};
            end
        elseif(data4(i,3)<=10)
            switch(data4(i,3)<=10)
                case(data4(i,9)<=10)
                    dataInterpretation(i)={'一级变形'};
                case(10<data4(i,9))&&(data4(i,9)<=20)
                    dataInterpretation(i)={'二级变形'};
                case(20<data4(i,9))&&(data4(i,9)<=40)
                    dataInterpretation(i)={'三级变形'};
                case(40<data4(i,9))&&(data4(i,9)<=60)
                    dataInterpretation(i)={'四级变形'};
                case(60<data4(i,9))
                    dataInterpretation(i)={'五级变形'};
            end
        end
    end

        %xlswrite('AutoTable.xls', data3);
        xlswrite('AutoTable.xls',data3,'A1:K1');
        xlswrite('AutoTable.xls',data4,['A' num2str(2) ':' 'K' num2str(clickNum+1)]);
        for i=1:clickNum
            xlswrite('AutoTable.xls',dataInterval(i),['B' num2str(i+1) ':' 'B' num2str(i+1)]);
        end
        for i=1:clickNum
            xlswrite('AutoTable.xls',dataInterpretation(i),['J' num2str(i+1) ':' 'J' num2str(i+1)]);
        end

% --- Executes during object creation, after setting all properties.
function pushbutton1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes when entered data in editable cell(s) in uitable1.
function uitable1_CellEditCallback(hObject, eventdata, handles)
% hObject    handle to uitable1 (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.TABLE)
%	Indices: row and column indices of the cell(s) edited
%	PreviousData: previous data for the cell(s) edited
%	EditData: string(s) entered by the user
%	NewData: EditData or its converted form set on the Data property. Empty if Data was not changed
%	Error: error string when failed to convert EditData to appropriate value for Data
% handles    structure with handles and user data (see GUIDATA)
% data1=cell(1,3);
% data1=get(handles.uitable1,'Data');
% guidata(hObject, handles);


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
prompt={'套管外径(mm)','套管内径(mm)','套管壁厚(mm)'};
title='请输入套管数据';
lines=[1,1,1];
def={'139.7';'114.3';'12.7'};%默认值
tab=inputdlg(prompt,title,lines,def);
row1=tab{1};
row2=str2num(tab{2});
row3=str2num(tab{3});
newArray={row1,row2,row3};
set(handles.edit1,'String',row1);
set(handles.edit2,'String',row2);
set(handles.edit3,'String',row3);

function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double


% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit2_Callback(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit2 as text
%        str2double(get(hObject,'String')) returns contents of edit2 as a double


% --- Executes during object creation, after setting all properties.
function edit2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit3_Callback(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit3 as text
%        str2double(get(hObject,'String')) returns contents of edit3 as a double


% --- Executes during object creation, after setting all properties.
function edit3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes when entered data in editable cell(s) in uitable2.
function uitable2_CellEditCallback(hObject, eventdata, handles)
% hObject    handle to uitable2 (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.TABLE)
%	Indices: row and column indices of the cell(s) edited
%	PreviousData: previous data for the cell(s) edited
%	EditData: string(s) entered by the user
%	NewData: EditData or its converted form set on the Data property. Empty if Data was not changed
%	Error: error string when failed to convert EditData to appropriate value for Data
% handles    structure with handles and user data (see GUIDATA)

% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global clickNum;
if str2num(get(handles.edit4,'String'))==1
    set(handles.edit4,'String',num2str(clickNum));
    clickNum=1;
end
clickNum=clickNum+1;
dd=cell(1,6);
% dd={'3006','3008','3007','101','113','119'};%test
oldData=get(handles.uitable2,'Data');
newData=[oldData;dd];
set(handles.uitable2,'Data',newData);
set(handles.edit4,'String',num2str(clickNum));



function edit4_Callback(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit4 as text
%        str2double(get(hObject,'String')) returns contents of edit4 as a double


% --- Executes during object creation, after setting all properties.
function edit4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

clickNumTwo=str2num(get(handles.edit4,'String'));

if clickNumTwo>1
    temp=clickNumTwo-1;
    clickNumTwo=temp;
    oldData=get(handles.uitable2,'Data');
    newData=oldData(1:end-1,:);
    set(handles.uitable2,'Data',newData);
    set(handles.edit4,'String',num2str(clickNumTwo));
end
