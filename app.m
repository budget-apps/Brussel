
prompt = 'Do you want to play game press Y/N (Yes/NO) ?  ';
playorleave = input(prompt,'s');
myGUI
if(playorleave == 'Y')
  disp(newline + "<<<<<<<<<<<<Welcome to the Sprouts Game>>>>>>>>>>>>"+newline)
  
else
  disp("\nGood Bye\n")
  exit;
end
s=[1 2];
t=[2 3];
x = input('Enter the number of Initial Points?');
global initialMatrix;
initialMatrix = zeros(x);

fprintf("--------printing initial matrix ----------\n\n")
displayGame(initialMatrix);
% printGraph("ca")
prompt1='Do you want to play First (Y/N)';
result=input(prompt1,'s');

i=1;
if(result == 'Y') 
    while(hasLegalMove(initialMatrix))
      if(hasCrossEdges(initialMatrix)==false)
        disp("-----------");
        fprintf("move number %d\n",i);
        move=input('Enter the Your Move := ','s');
        uppercase = upper(move);
        Upper= char(uppercase);
        a=double(Upper(1)-64);
        b=double(Upper(2)-64);
          if validmove(a,b,initialMatrix)
            initialMatrix =getMove(a,b,initialMatrix);
            i=i+1;
            disp("########Your Move#########")
            displayGame(initialMatrix);
            desicion("Winner",initialMatrix);
            
            if(hasLegalMove(initialMatrix) && hasCrossEdges(initialMatrix)==false )
              computerMove=nextMove(initialMatrix);
              initialMatrix =getMove(computerMove(1),computerMove(2),initialMatrix);
              disp("########Computer Move#########")
              displayGame(initialMatrix);
              desicion("Loose",initialMatrix)
              i=i+1;
            end
           else
            disp("OOps Wrong Move");
          end
      end
    end
elseif(result ~= 'Y')
          valid=true;
          while(hasLegalMove(initialMatrix))
            if(hasCrossEdges(initialMatrix)==false)
              if(valid)
              computerMove=nextMove(initialMatrix);
              initialMatrix = getMove(computerMove(1),computerMove(2),initialMatrix);
               disp("########Computer Move#########")
              displayGame(initialMatrix);
              desicion("Loose",initialMatrix);
              i=i+1;
              end      
                if(hasLegalMove(initialMatrix) && hasCrossEdges(initialMatrix)==false )
                  disp("-----------")
                  fprintf("move number %d\n",i);
                  move=input('Enter the Your Move := ','s');
                  uppercase = upper(move);
                  Upper= char(uppercase);
                  a=double(Upper(1)-64);
                  b=double(Upper(2)-64);
                    if validmove(a,b,initialMatrix)
                      initialMatrix =getMove(a,b,initialMatrix);
                      disp("########Your Move#########")
                      displayGame(initialMatrix);
                      desicion("Win",initialMatrix);
                      valid=true;
                      i=i+1;
                    else
                      disp("OOps Wrong Move");
                      valid=false;
                    end
                end
            end
          end
end


function printGraph(path)
uppercase = upper(path);
Upper= char(uppercase);
 a=double(Upper(1)-64);
 b=double(Upper(2)-64);
 global s;
 global t;
 disp(length(s));
 s(length(s)+1)=a;
 t(length(t)+1)=b;
 weights = [1];
 names = {'A' 'B'};
 names(3) = {'C'}
 G = graph(s,t,weights,names)
 plot(G,'EdgeLabel',G.Edges.Weight)
end

% display matrix function
function displayGame(initialMatrix)
  fprintf("\n--------printing matrix ----------\n\n")
  for i = 1:size(initialMatrix)
    fprintf('%d  ', initialMatrix(i,:));
    fprintf("--------->");
    disp(char(64+i));
  end
  fprintf("-----------------------------------\n\n");
end



function myGUI
S.f = figure;
S.row = uicontrol('Style','edit', 'Units','normalized', ...
    'Position',[0.4 0.6 0.1 0.1]);
S.column = uicontrol('Style', 'edit', 'Units','normalized', ...
    'Position',[0.6 0.6 0.1 0.1]);
S.btn = uicontrol('Style','push', 'String','Create table', ...
    'Units','normalized', 'Position',[0.5 0.5 0.1 0.1]);
set(S.btn, 'Callback',{@createtable,S});
      function createtable(varargin)
          rowSize = str2num(get(S.row, 'String'));
          colSize = str2num(get(S.column, 'String'));
          initdata = zeros(rowSize,colSize);
          S.table = uitable('Parent',S.f, 'Data', initdata, ...
              'Units','normalized', 'Position',[0.4 0.2 0.4 0.2], ...
              'ColumnEditable',logical(ones(1,colSize)));
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





  
  















