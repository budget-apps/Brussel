function varargout = untitled(varargin)
% UNTITLED MATLAB code for untitled.fig
%      UNTITLED, by itself, creates a new UNTITLED or raises the existing
%      singleton*.
%
%      H = UNTITLED returns the handle to a new UNTITLED or the handle to
%      the existing singleton*.
%
%      UNTITLED('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in UNTITLED.M with the given input arguments.
%
%      UNTITLED('Property','Value',...) creates a new UNTITLED or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before untitled_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to untitled_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help untitled

% Last Modified by GUIDE v2.5 15-Dec-2019 22:25:24

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @untitled_OpeningFcn, ...
                   'gui_OutputFcn',  @untitled_OutputFcn, ...
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
end

% --- Executes just before untitled is made visible.
function untitled_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to untitled (see VARARGIN)

% Choose default command line output for untitled
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes untitled wait for user response (see UIRESUME)
% uiwait(handles.figure1);

end
% --- Outputs from this function are returned to the command line.
function varargout = untitled_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;
set(handles.pushbutton1,'Visible','Off')
set(handles.pushbutton3,'Visible','Off')
set(handles.pushbutton4,'Visible','Off')
set(handles.edit1,'Visible','Off')
set(handles.text3,'Visible','Off')
set(handles.edit2,'Visible','Off')
set(handles.text4,'Visible','Off')
set(handles.text5,'Visible','Off')
set(handles.uitable1, 'Visible', 'Off');
end
% --- Executes on button press in pushbutton1.

function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global order;
global x;
global rownames;
global initialMatrix;
global finish;
finish =false;
if(hasCrossEdges(initialMatrix)==false && hasLegalMove(initialMatrix))
    move = get(handles.edit1,'String');
    L = strlength(move)
    if(L~=2)
        f = msgbox('Invalid Move', 'Error','error');
        set(handles.edit1, 'String', "");
    end
    if(L==2)
        uppercase = upper(move);
        Upper= char(uppercase);
        a=double(Upper(1)-64);
        b=double(Upper(2)-64);
        if validmove(a,b,initialMatrix)
            initialMatrix =getMove(a,b,initialMatrix);
            finish =true;
            rownames={}
            for r = 1:size(initialMatrix)
            rownames(r)={char(64+r)}
            end  
            set(handles.uitable1, 'Data', initialMatrix,'RowName',rownames);
        else
            f = msgbox('Invalid Move', 'Error','error');
            set(handles.edit1, 'String', "");    
        end
        if(hasLegalMove(initialMatrix)==false)
            f = msgbox('You are the winner','Winner');
        end
    end
end

if(hasLegalMove(initialMatrix) && hasCrossEdges(initialMatrix)==false && finish ==true)
              computerMove=nextMove(initialMatrix);
              initialMatrix =getMove(computerMove(1),computerMove(2),initialMatrix);
                rownames={}
                for a = 1:size(initialMatrix)
                rownames(a)={char(64+a)}
                set(handles.uitable1, 'Data', initialMatrix,'RowName',rownames);
                end
                set(handles.edit2, 'String',strcat(char(computerMove(1)+64),char(computerMove(2)+64)));
                set(handles.text3,'Visible','On')
                set(handles.edit2,'Visible','On')
                if(hasLegalMove(initialMatrix)==false)
                f = msgbox('Game Over;You Lost','Oops');
                end
                
end


end




function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double
end

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
end

% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)

% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% answer = questdlg('Would you like a dessert?', ...
% 	'Dessert Menu', ...
% 	'Ice cream','Cake','No thank you','No thank you');
% % Handle response
% switch answer
%     case 'Ice cream'
%         disp([answer ' coming right up.'])
%         dessert = 1;% answer = questdlg('Would you like a dessert?', ...
% 	'Dessert Menu', ...
% 	'Ice cream','Cake','No thank you','No thank you');
% % Handle response
% switch answer
%     case 'Ice cream'
%         disp([answer ' coming right up.'])
%         dessert = 1;
%     case 'Cake'
%         disp([answer ' coming right up.']set(handles.pushbutton1,'Visible','Off')

%         dessert = 2;
%     case 'No thank you'
%         disp('I''ll bring you your check.')
%         dessert = 0;
% end

%     case 'Cake'
%         disp([answer ' coming right up.'])
%         dessert = 2;
%     case 'No thank you'
%         disp('I''ll bring you your check.')
%         dessert = 0;
% end


global x;
x = inputdlg({'Enter the number of Initial Points?',},...
              'number of Initial Points', [1 50]);
h = questdlg('Do you want to play first','Success');
global initialMatrix;
global rownames;
initialMatrix = zeros(str2double(x));

if strcmp(h,'Yes')
    set(handles.pushbutton1,'Background','y')
    set(handles.pushbutton1,'Visible','On')
    set(handles.edit1,'Visible','On')
    set(handles.text4,'Visible','On')
    set(handles.text5,'Visible','On')
    set(handles.pushbutton2,'Visible','Off')
set(handles.pushbutton3,'Visible','On')
set(handles.pushbutton4,'Visible','On')
    rownames={}
    for r = 1:str2double(x)
        rownames(r)={char(64+r)}
    end
    
    set(handles.uitable1, 'Data', initialMatrix,'RowName',rownames);
    set(handles.uitable1, 'Visible', 'On');
elseif(strcmp(h,'No'))
    if(hasLegalMove(initialMatrix) && hasCrossEdges(initialMatrix)==false)
              computerMove=nextMove(initialMatrix);
              initialMatrix =getMove(computerMove(1),computerMove(2),initialMatrix);
                rownames={}
                for a = 1:size(initialMatrix)
                rownames(a)={char(64+a)}
                set(handles.uitable1, 'Data', initialMatrix,'RowName',rownames);
                end
                set(handles.edit2, 'String',strcat(char(computerMove(1)+64),char(computerMove(2)+64)));
                set(handles.text3,'Visible','On')
                set(handles.edit2,'Visible','On')
                
    end
    set(handles.pushbutton1,'Background','y')
    set(handles.pushbutton1,'Visible','On')
    set(handles.edit1,'Visible','On')
    set(handles.text4,'Visible','On')
    set(handles.text5,'Visible','On')
     set(handles.pushbutton2,'Visible','Off')
set(handles.pushbutton3,'Visible','On')
set(handles.pushbutton4,'Visible','On')
    rownames={}
    for r = 1:size(initialMatrix)
    rownames(r)={char(64+r)}
    end 
    
    set(handles.uitable1, 'Data', initialMatrix,'RowName',rownames);
    set(handles.uitable1, 'Visible', 'On');
    

end

end

function edit2_Callback(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit2 as text
%        str2double(get(hObject,'String')) returns contents of edit2 as a double
end

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
end


function edit3_Callback(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit3 as text
%        str2double(get(hObject,'String')) returns contents of edit3 as a double
end

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
end


function valid = validmove(row1,row2,initialMatrix)
  valid=false;
 if(row1<=size(initialMatrix,1) && row2<=size(initialMatrix,1))
   if(row1==row2)
        if(sum(initialMatrix(row1,:))<2 && sum(initialMatrix(row2,:))<2)
        valid=true;
        end
   else
        if(sum(initialMatrix(row1,:))<3 && sum(initialMatrix(row2,:))<3)
        valid=true;
        end
   end
 end
end


% function check whether there are any ways to play
function ability = hasLegalMove(matrix)
%   get ablility variable as false
  ability=false;
%   get number of Rows in Metrix
  numberofRows=size(matrix,1);
  possibleCount=0;
  for i = 1:size(matrix,1)
    x=sum(matrix(i,:));
    if(x<2)
      possibleCount=2;
    elseif(x<3)
      possibleCount=possibleCount+1;
    end
    if(possibleCount>=2)
      ability = true;
      return;
    end
  end
end
 

function getMoveMatrix = getMove(row1,row2,initialMatrix)
%   1st condition draw edge vetex to itself
if(row1==row2)
      if(sum(initialMatrix(row1,:))<2 && sum(initialMatrix(row2,:))<2)
%           get the rows count
          lengthofMetrix=size(initialMatrix,1);
%           Adding new vertex to metrix 
          y=zeros(lengthofMetrix,1);
          initialMatrix = [initialMatrix y];
          getMoveMatrix=initialMatrix;
          x=zeros(1,size(initialMatrix,1)+1);
          getMoveMatrix=[getMoveMatrix;x];
%           change the values in matrix
          getMoveMatrix(row1,lengthofMetrix+1)=2;
          getMoveMatrix(lengthofMetrix+1,row1)=2;
          
      end
else
%       2nd condition draw edge vetex to onother vertex
     
      if(sum(initialMatrix(row1,:))<3 && sum(initialMatrix(row2,:))<3)
      
%           get the rows count
          lengthofMetrix=size(initialMatrix,1);
          y=zeros(lengthofMetrix,1);
          initialMatrix = [initialMatrix y];
          getMoveMatrix=initialMatrix;
          x=zeros(1,size(initialMatrix,1)+1);
          getMoveMatrix=[getMoveMatrix;x];
          getMoveMatrix(row1,lengthofMetrix+1)=1;
          getMoveMatrix(lengthofMetrix+1,row1)=1;
          getMoveMatrix(row2,lengthofMetrix+1)=1;
          getMoveMatrix(lengthofMetrix+1,row2)=1;
          
      end
end
end


function hasCross=hasCrossEdges(matrix)
  %get the number of Edges
  numberofEdges=sum(sum(matrix))/2;
  %get the number of Vertex
  numberofVetex=size(matrix,1);
  if((3*numberofVetex-6) <numberofEdges)
      hasCross=true;
  else
       hasCross=false;
  end
end

function nextcomputerMove=nextMove(Matrix)
  numberofRows=size(Matrix,1);
  nextcomputerMove=[];
  possibleCount=0;
  
  for i = 1:numberofRows
    x=sum(Matrix(i,:));
    if(x<2)
      possibleCount=2;
      nextcomputerMove(1)=i;
      nextcomputerMove(2)=i;
    elseif(x<3)
      possibleCount=possibleCount+1;
      nextcomputerMove(possibleCount)=i;
    end
    if(possibleCount>=2)
      return;
    end
   end
end

function desicion(desition,initialMatrix)
    if(hasLegalMove(initialMatrix)==false)
      fprintf("<<<<<<<no more moves left you are the %s >>>>>>>",desition);
    end
end  


% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
exit;
end

% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
global initialMatrix;
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
answer = questdlg('Are you sure you want to reset the game?', ...
	'Rest game', ...
	'Yes' , 'No','No');

if strcmp(answer,'Yes')
    set(handles.pushbutton3,'Visible','Off')
    set(handles.uitable1, 'Data', [],'RowName',{});
    initialMatrix=[];
     set(handles.edit2, 'String', "");
      set(handles.edit1, 'String', "");
    set(handles.pushbutton2,'Visible','On')

end
end
