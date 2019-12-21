function varargout = untitled(varargin)
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
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes untitled wait for user response (see UIRESUME)
% uiwait(handles.figure1);

end
% --- Outputs from this function are returned to the command line.
function varargout = untitled_OutputFcn(hObject, eventdata, handles) 
varargout{1} = handles.output;
set(handles.pushbutton3,'Visible','Off')
set(handles.pushbutton4,'Visible','Off')
set(handles.uitable1, 'Data',[]);
set(handles.edit2,'enable','Off')

end
% --- Executes on button press in pushbutton1.

function pushbutton1_Callback(hObject, eventdata, handles)
global order;
global x;
global rownames;
global initialMatrix;
global displayMatrix;
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
        if(isnan(str2double(Upper(1))) && isnan(str2double(Upper(2))))
            a=double(Upper(1)-64);
            b=double(Upper(2)-64);
            if validmove(a,b,initialMatrix)
                initialMatrix =getMove(a,b,initialMatrix);
                finish =true;
                rownames={}

                displayMatrix = reshape(strtrim(cellstr(num2str(initialMatrix(:)))), size(initialMatrix));

                  for r = 1:size(initialMatrix)
                      disp("---------")
                      disp(sum(initialMatrix(r,:)))
                       if(sum(initialMatrix(r,:))==3)
                         displayMatrix(r,:) = cellfun(@(x) ['<html><table border=0 width=400 bgcolor=#FF0000><TR><TD>' x '</TD></TR> </table></html>'],displayMatrix(r,:), 'UniformOutput', false)           
                       end 
                     rownames(r)={char(64+r)}
                  end
                set(handles.uitable1, 'Data', displayMatrix,'RowName',rownames,'ColumnName',rownames);
                set(handles.edit2,'String','')

            else
                f = msgbox('Invalid Move', 'Error','error');
                set(handles.edit1, 'String', "");    
            end
            if(hasLegalMove(initialMatrix)==false)
                myicon = imread('winner.jpg');
                f = msgbox('You are the winner','Winner','custom',myicon);
            end
        else
            f = msgbox('Invalid Move', 'Error','error');
            set(handles.edit1, 'String', "");
        end
    end
end

if(hasLegalMove(initialMatrix) && hasCrossEdges(initialMatrix)==false && finish ==true)
              computerMove=nextMove(initialMatrix);
              initialMatrix =getMove(computerMove(1),computerMove(2),initialMatrix);
                rownames={}
            displayMatrix = reshape(strtrim(cellstr(num2str(initialMatrix(:)))), size(initialMatrix));

              for r = 1:size(initialMatrix)
                  disp("---------")
                  disp(sum(initialMatrix(r,:)))
                   if(sum(initialMatrix(r,:))==3)
                     displayMatrix(r,:) = cellfun(@(x) ['<html><table border=0 width=400 bgcolor=#FF0000><TR><TD>' x '</TD></TR> </table></html>'],displayMatrix(r,:), 'UniformOutput', false)           
                   end 
                 rownames(r)={char(64+r)}
              end
              set(handles.uitable1, 'Data', displayMatrix,'RowName',rownames,'ColumnName',rownames);

                set(handles.edit2, 'String',strcat(char(computerMove(1)+64),char(computerMove(2)+64)));
                set(handles.text3,'Visible','On')
                set(handles.edit2,'Visible','On')
                if(hasLegalMove(initialMatrix)==false)
                 myicon1 = imread('lose.jpg');
                f = msgbox('Game Over;You Lost','Oops','custom',myicon1);
                end
                
end
    set(handles.edit1,'String','')

end




function edit1_Callback(hObject, eventdata, handles)
end

% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
end

% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
    global x;
    Y = get(handles.edit4,'String');
    x = Y;
    if(strlength(Y)~=0 && ~ isnan(str2double(x)))
        if(str2double(x)>1)
        h = questdlg('Do you want to play first','Success');
        set(handles.edit4, 'enable', 'off')
        global initialMatrix;
        global rownames;
        initialMatrix = zeros(str2double(x));

        if strcmp(h,'Yes')
            set(handles.pushbutton1,'Visible','On')
            set(handles.edit1,'Visible','On')
            set(handles.text4,'Visible','On')
            set(handles.pushbutton2,'enable','Off')
            set(handles.pushbutton3,'Visible','On')
            set(handles.pushbutton4,'Visible','On')
            rownames={}
            for r = 1:str2double(x)
                rownames(r)={char(64+r)}
                if(sum(initialMatrix(:,r))>=3)
                    initialMatrix(:,r) = cellfun(@(x) ['<html><table border=0 width=400 bgcolor=#FF0000><TR><TD>' x '</TD></TR> </table></html>'],initialMatrix(:,r), 'UniformOutput', false);            
                end 
            end

            set(handles.uitable1, 'Data', initialMatrix,'RowName',rownames,'ColumnName',rownames);
            set(handles.uitable1, 'Visible', 'On');
        elseif(strcmp(h,'No'))
            if(hasLegalMove(initialMatrix) && hasCrossEdges(initialMatrix)==false)
                      computerMove=nextMove(initialMatrix);
                      initialMatrix =getMove(computerMove(1),computerMove(2),initialMatrix);
                        rownames={}
                        for a = 1:size(initialMatrix)
                        rownames(a)={char(64+a)}
                        set(handles.uitable1, 'Data', initialMatrix,'RowName',rownames,'ColumnName',rownames);
                        end
                        set(handles.edit2, 'String',strcat(char(computerMove(1)+64),char(computerMove(2)+64)));
                        set(handles.text3,'Visible','On')
                        set(handles.edit2,'Visible','On')

            end
            set(handles.pushbutton1,'Visible','On')
            set(handles.edit1,'Visible','On')
            set(handles.text4,'Visible','On')
            set(handles.pushbutton2,'enable','Off')
            set(handles.pushbutton3,'Visible','On')
            set(handles.pushbutton4,'Visible','On')
            rownames={}
            for r = 1:size(initialMatrix)
                rownames(r)={char(64+r)}
                if(sum(initialMatrix(:,r))>=3)
                    initialMatrix(:,r) = cellfun(@(x) ['<html><table border=0 width=400 bgcolor=#FF0000><TR><TD>' x '</TD></TR> </table></html>'],initialMatrix(:,r), 'UniformOutput', false);            
                end 
            end

            set(handles.uitable1, 'Data', initialMatrix,'RowName',rownames,'ColumnName',rownames);
            set(handles.uitable1, 'Visible', 'On');


        end
    elseif(isnan(str2double(x)) && strlength(x)~=0)
        g = msgbox('Please Enter Numerical Value', 'Error','error');
    else
     f = msgbox('Please Enter a number greater than one', 'Error','error');
    end
    else
      f = msgbox('Please Enter the number of initial points', 'Error','error');
    end
end

function edit2_Callback(hObject, eventdata, handles)

end

% --- Executes during object creation, after setting all properties.
function edit2_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
end


function edit3_Callback(hObject, eventdata, handles)

end

% --- Executes during object creation, after setting all properties.
function edit3_CreateFcn(hObject, eventdata, handles)

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
exit;
end

% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
global initialMatrix;
answer = questdlg('Are you sure you want to reset the game?', ...
	'Rest game', ...
	'Yes' , 'No','No');

if strcmp(answer,'Yes')
    set(handles.pushbutton3,'Visible','Off')
    set(handles.pushbutton2,'Visible','On')
    set(handles.uitable1,'Data', [],'RowName',{},'ColumnName',{});
    initialMatrix=[];
     set(handles.edit2, 'String', "");
      set(handles.edit1, 'String', "");
    set(handles.pushbutton2,'enable','On')
set(handles.edit4,'enable','On')
set(handles.edit4,'String','')
end
end



function edit4_Callback(hObject, eventdata, handles)

end

% --- Executes during object creation, after setting all properties.
function edit4_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
end


% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, eventdata, handles)

end
