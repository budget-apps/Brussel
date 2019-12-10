# Enter the number of brussels
printf("****       ******        **        **      **********   **********      ************     **            **********\n******     **    **      **        **      **********   **********      ************     **            **********\n**  ***    **      **    **        **      **           **              **               **            **\n**   ***   **      **    **        **      **           **              **               **            **\n**   **    **     **     **        **      **           **              **               **            **\n** **      **    **      **        **      **           **              **               **            **\n***        **   **       **        **      **********   **********      **********       **            **********\n** **      *****         **        **              **           **      **               **                    **\n**  ***    *****         **        **              **           **      **               **                    **\n**   ***   **  **        **        **              **           **      **               **                    **\n**  ***    **   **        **      **               **           **      **               **                    **\n******     **    **        **    **        **********   **********      ************     ************  **********\n****       **     **        ******         **********   **********      ************     ************  **********\n"  
)

playorleave = input("Do you want to play game press Y/N (Yes/NO) ? ","s");

if(playorleave == 'Y')
  disp("\n<<<<<<<<<<<<Welcome to the Brussel Game>>>>>>>>>>>>\n")
else
  disp("\nGood Bye\n")
endif


x = input("Enter the number of Initial brussels Count?")
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
    if(x<4)
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
      else
          disp("oops wrong move");       
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
       else
            disp("OOOps wrong move");
       endif
endif  
endfunction

#display matrix function
function displayGame(initialMatrix)
  printf("--------printing matrix ----------\n\n")
  for i = 1:rows(initialMatrix)
    fprintf('%d  ', initialMatrix(i,:));
    fprintf("--------->");
    disp(i);
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
  

  
  
  
while(hasLegalMove(initialMatrix))
  global initialMatrix;
  if(hasCrossEdges(initialMatrix)==false)
    disp("-----------")
    fprintf("move number %d\n",i)
    a=input("Enter the brusser number to move := ")
    b=input("Enter the brusser number to move := ")
    initialMatrix =getMove(a,b,initialMatrix);
    displayGame(initialMatrix);
    i=i+1;
  endif
endwhile

if(hasLegalMove(initialMatrix)==false)
  disp("no more moves left you loose")
endif
  
  




