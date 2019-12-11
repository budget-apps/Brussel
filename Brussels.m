# Enter the number of brussels
printf("****       ******        **        **      **********   **********      ************     **            **********\n******     **    **      **        **      **********   **********      ************     **            **********\n**  ***    **      **    **        **      **           **              **               **            **\n**   ***   **      **    **        **      **           **              **               **            **\n**   **    **     **     **        **      **           **              **               **            **\n** **      **    **      **        **      **           **              **               **            **\n***        **   **       **        **      **********   **********      **********       **            **********\n** **      *****         **        **              **           **      **               **                    **\n**  ***    *****         **        **              **           **      **               **                    **\n**   ***   **  **        **        **              **           **      **               **                    **\n**  ***    **   **        **      **               **           **      **               **                    **\n******     **    **        **    **        **********   **********      ************     ************  **********\n****       **     **        ******         **********   **********      ************     ************  **********\n"  
)

playorleave = input("Do you want to play game press Y/N (Yes/NO) ? ","s");

if(playorleave == 'Y')
  disp("\n<<<<<<<<<<<<Welcome to the Sprouts Game>>>>>>>>>>>>\n")
else
  disp("\nGood Bye\n")
  exit;
endif


x = input("Enter the number of Initial Points?")
initialMatrix = zeros(x)
i=1;


#function check whether there are any ways to play
function ability = hasLegalMove(matrix)
  #get ablility variable as false
  ability=false;
  #get number of Rows in Metrix
  numberofRows=rows(matrix);
  possibleCount=0;
  for i = 1:rows(matrix)
    x=sum(matrix(i,:));
    if(x<2)
      possibleCount=2;
    elseif(x<3)
      possibleCount=possibleCount+1;
    endif
    if(possibleCount>=2)
      ability = true;
      return;
    endif
  endfor
endfunction


function getMoveMatrix = getMove(row1,row2,initialMatrix)
  #1st condition draw edge vetex to itself
if(row1==row2)
      if(sum(initialMatrix(row1,:))<2 && sum(initialMatrix(row2,:))<2)
          #get the rows count
          lengthofMetrix=rows(initialMatrix);
          #Adding new vertex to metrix 
          y=zeros(lengthofMetrix,1);
          initialMatrix = [initialMatrix y];
          getMoveMatrix=initialMatrix;
          x=zeros(1,rows(initialMatrix)+1);
          getMoveMatrix=[getMoveMatrix;x];
          #change the values in matrix
          getMoveMatrix(row1,lengthofMetrix+1)=2;
          getMoveMatrix(lengthofMetrix+1,row1)=2;
     
      endif
else
      #2nd condition draw edge vetex to onother vertex
     
      if(sum(initialMatrix(row1,:))<3 && sum(initialMatrix(row2,:))<3)
      
          #get the rows count
          lengthofMetrix=rows(initialMatrix);
          y=zeros(lengthofMetrix,1);
          initialMatrix = [initialMatrix y];
          getMoveMatrix=initialMatrix;
          x=zeros(1,rows(initialMatrix)+1);
          getMoveMatrix=[getMoveMatrix;x];
          getMoveMatrix(row1,lengthofMetrix+1)=1;
          getMoveMatrix(lengthofMetrix+1,row1)=1;
          getMoveMatrix(row2,lengthofMetrix+1)=1;
          getMoveMatrix(lengthofMetrix+1,row2)=1;
       endif
endif  
endfunction

#display matrix function
function displayGame(initialMatrix)
  printf("--------printing matrix ----------\n\n")
  for i = 1:rows(initialMatrix)
    fprintf('%d  ', initialMatrix(i,:));
    fprintf("--------->");
    disp(char(64+i));
  endfor
  printf("-----------------------------------\n\n")
endfunction


#function for check has cross edges

function hasCross=hasCrossEdges(matrix)
  #get the number of Edges
  numberofEdges=sum(sum(matrix))/2;
  #get the number of Vertex
  numberofVetex=rows(matrix);
  if((3*numberofVetex-6) <numberofEdges)
      hasCross=true;
  else
       hasCross=false;
  endif
endfunction
  
function nextcomputerMove=nextMove(Matrix)
  numberofRows=rows(Matrix);
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
    endif
    if(possibleCount>=2)
      return;
    endif
  endfor
endfunction

function desicion(desition,initialMatrix)
  
    if(hasLegalMove(initialMatrix)==false)
      printf("<<<<<<<no more moves left you are the %s >>>>>>>",desition)
    endif
    
endfunction

function valid = validmove(row1,row2,initialMatrix)
  valid=false;
 if(row1==row2)
      if(sum(initialMatrix(row1,:))<2 && sum(initialMatrix(row2,:))<2)
      valid=true;
      endif
 else
      if(sum(initialMatrix(row1,:))<3 && sum(initialMatrix(row2,:))<3)
      valid=true
      endif
 endif
endfunction

  

result=input("Do you wan't to play First (Y/N)","s")
if(result =='Y') 
    global initialMatrix;
    while(hasLegalMove(initialMatrix))
      if(hasCrossEdges(initialMatrix)==false)
        disp("-----------")
        fprintf("move number %d\n",i)
        move=input("Enter the Your Move := ","s");
        Upper = toupper(move);
        a=toascii(Upper(1)-64);
        b=toascii(Upper(2)-64);
          if validmove(a,b,initialMatrix)
            initialMatrix =getMove(a,b,initialMatrix);
            displayGame(initialMatrix);
            desicion("Winner",initialMatrix)
            i=i+1;
            if(hasLegalMove(initialMatrix) && hasCrossEdges(initialMatrix)==false )
              computerMove=nextMove(initialMatrix);
              initialMatrix =getMove(computerMove(1),computerMove(2),initialMatrix);
              disp("-------Computer Move--------")
              displayGame(initialMatrix);
              desicion("Loose",initialMatrix)
              i=i+1;
            endif
           else
            disp("OOps Wrong Move");
           endif
      endif
    endwhile
else
    valid=true;
    global initialMatrix;
    while(hasLegalMove(initialMatrix))
      global valid;
      if(hasCrossEdges(initialMatrix)==false)
        if(valid)
        computerMove=nextMove(initialMatrix);
        initialMatrix =getMove(computerMove(1),computerMove(2),initialMatrix);
        disp("-------Computer Move--------")
        displayGame(initialMatrix);
        desicion("Loose",initialMatrix)
        i=i+1;
        endif        
          if(hasLegalMove(initialMatrix) && hasCrossEdges(initialMatrix)==false )
            disp("-----------")
            fprintf("move number %d\n",i)
            move=input("Enter the Your Move := ","s");
            Upper = toupper(move);
            a=toascii(Upper(1)-64);
            b=toascii(Upper(2)-64);
            if validmove(a,b,initialMatrix)
              initialMatrix =getMove(a,b,initialMatrix);
              displayGame(initialMatrix);
              desicion("Win",initialMatrix)
              valid=true
              i=i+1;
            else
            disp("OOps Wrong Move");
            valid=false
            endif
          endif
      endif
    endwhile
endif


  
  




