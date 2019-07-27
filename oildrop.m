% clear all;
% close all;
% clc;
function [ori,output]= oildrop(img)
ori=img;
%img=imread('D:\oil drop\input Images\images_test\312.tif');
[a,b,c,im1]=Image_boxing(img);
%figure,imshow(im1);
im=~im1;%invert
im_org=im;
[row,col]=size(im1);
my_im=~zeros(row,col);
[row,col]=size(im);
h=row;
w=col;
%s=java.util.Stack();
true=1;
false=0;
path=stack(); % creating a stack to store co-ordinates of the path

index1=1;
index2=1;
sz=[row,col];
	
	flag=0;

	%drop oil from each pixel from the left side of the page in search of a path
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%for left to right oil passing%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
	for j=1:1:row
        im=im_org;
		%get the present position of oil drop
		posx=1;
		posy=j;
%         temp=0;
        store=0;
		%check if the starting position is not blocked
        if im(posy,posx)~=1 
%             break;
		%initialize the path stack
		path.top = 1;
		path.y(path.top) = posy;
		path.x(path.top) = posx;
		%find a path from the starting position
		while(true)
			if isValidPos(h, w, posy,posx+1)==true && im(posy,posx+1) ==false %the right pixel becomes valid
				nexty = posy;
				nextx = posx+1;
				bFound = true;
                temp=0;
                 %fprintf('1\n');
%             else
%                  %figure,imshow(im1);
%                 for pss=1:1:c
%                     if  posx>=b(pss,1)-1 && posy>=b(pss,2) && posx<=b(pss,3) && posy<=b(pss,8)
%                         avg=(b(pss,8)-b(pss,2))/2;
%                         if(posy<avg+b(pss,2) && posy>=b(pss,2))
%                            temp=1;
%                            store=1;
%                            break;
%                         elseif (posy>b(pss,8)-avg && posy<=b(pss,8)) 
%                            temp=2;
%                            store=2;
%                            break;
%                         end
%                     end
%                 end
            elseif isValidPos(h, w, posy-1,posx+1)==true && isValidPos(h, w, posy-1,posx)==true && im(posy-1,posx+1)== false && im(posy-1,posx) == false %one step up and right pixel
                          nexty = posy - 1;
                          nextx = posx + 1;
                          bFound = true;	
                          flag=0;
                  %fprintf('2\n');
            elseif isValidPos(h, w, posy-1,posx)==true && im(posy-1,posx) == false %one step up and right pixel
% 				for pss=1:1:c
%                     if posy<=b(pss,8) && posy>=b(pss,2) && posx<=b(pss,3) && posx>=b(pss,1)-1
%                         avg=(b(pss,8)-b(pss,2))/4;
%                         if(posy<=avg+b(pss,2))
                           nexty = posy - 1;
                           nextx = posx ;
                           bFound = true;
                           flag=3;
%                            break;
%                         end
%                      else
%                         bFound=false;
%                     end
%                 end
                 %fprintf('3\n');
            elseif isValidPos(h, w, posy+1,posx+1)==true && isValidPos(h, w, posy+1,posx)==true && im(posy+1,posx+1) == false && im(posy+1,posx) == false %one step down and right
                          nexty = posy + 1;
                            nextx = posx + 1;
                            bFound = true;
                            flag=0;
               % fprintf('4\n');
            elseif isValidPos(h, w, posy+1,posx)==true && im(posy+1,posx) == false %one step down and right
%                 for pss=1:1:c
%                     if posy<=b(pss,8) && posy>=b(pss,2) && posx<=b(pss,3) && posx>=b(pss,1)-1
%                         avg=(b(pss,8)-b(pss,2))/4;
%                         if(posy>=b(pss,8)-avg)
                          nexty = posy + 1;
                          nextx = posx ;
                          bFound = true;
                          flag=5;
%                            break;
%                         end
%                     else
%                         bFound=false;
%                     end
%                 end
                
                 %fprintf('5\n');
             else
				%no path is there; backtrack required
				bFound = false;
                % fprintf('6\n');
                 flag=0;
            end
			if bFound==true
                if (flag==3) 
                   im(posy,posx)=1;
                    %fprintf('fuck');
                elseif flag==5  
                   im(posy,posx)=1;
                end
			
				%push into path stack
				path.top = path.top + 1;
               % fprintf('%d path.top\n', path.top);
				path.y(path.top) = nexty;
				path.x(path.top) = nextx;
				%fprintf('\nPath Top %d: Position (%d,%d) added', path.top, nexty, nextx);

				%need to stop if last column is reached
				if nextx >= w
				%fprintf('last column reached');
					break;
                end
			
			else
			
				%block the position to be popped
				im(posy,posx) = 1;
				%fprintf('\nPath Top %d: Position (%d,%d) removed\n', path.top, posy, posx);
				%pop from path stack for backtracking
                path.y(path.top)=0;
                path.x(path.top)=0;
				path.top = path.top - 1;
                %fprintf('%d path.top\n', path.top);
				if path.top <=1 %check if pop is possible
                   % fprintf('no path exist');
					%no possibility of finding any path
					break;
                end
				nexty = path.y(path.top);
				nextx = path.x(path.top);
               % fprintf('%d of ',nextx);
                %fprintf('%d if ',nexty);
			
            end
			%accept the next point as the present point
			posy = nexty;
			posx = nextx;

            end

		%mark the path if found  
        %%eitai hocchena,ei nicher line ta
		if (path.top) >= w
        %%eitai hocchena,aschena eita ,eikhanei vabte hbe
                                 
			%fprintf('\nPath found from row %d', j);
			index1=1;
			for i=1:path.top
				posy = path.y(i);
				posx = path.x(i);
                
                arr(index1,1)=posy;
                
                arr(index1,2)=posx;
                
                index1=index1+1;
                
                im1(posy,posx)=0; 
                my_im(posy,posx)=0;       %black the path-line on the non-inverted image
            end
            arr2{index2}=arr;
            index2=index2+1;
			
		
		else
		%display('no path found');
			%output to print("\nPath not found from col %d", j);
            arr2{index2}=0;
            index2=index2+1;
		
        end
        end
      %  fprintf('\n row no %d  ended',j);
    end
%%%%%%%%%%%%%%%for right to left oil-passing%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
% index2=1;
% index1=1;
% path2=stack();
% for j=1:row 
%         posx=w;
% 		posy=j;
% 
% 		%check if the starting position is not blocked
%         if im(posy,posx)~=1
%            % fprintf('first position not blocked\n');
%             
%         
% 	
% 
% 		%initialize the path stack
% 		path2.top = 1;
% 		path2.y(path2.top) = posy;
% 		path2.x(path2.top) = posx;
% 
% 		%find a path from the starting position
% 		while(true)
% 		
% 			if isValidPos(h, w, posy,posx-1)==true && im(posy,posx-1) ==false %the right pixel becomes valid
% 			
% 				nexty = posy;
% 				nextx = posx-1;
% 				bFound = true;
% 			%fprintf('first if statement,just right\n');
% 			
%             elseif isValidPos(h, w, posy-1,posx-1)==true && isValidPos(h, w, posy-1,posx)==true && im(posy-1,posx-1)== false && im(posy-1,posx) == false %one step up and right pixel
%                  
% 				nexty = posy - 1;
% 				nextx = posx - 1;
% 				bFound = true;
%                 %fprintf('second if statement,upper right\n');
% 			
% 			
%             elseif isValidPos(h, w, posy+1,posx-1)==true && isValidPos(h, w, posy+1,posx)==true && im(posy+1,posx-1) == false && im(posy+1,posx) == false%one step down and right
%                 
% 				nexty = posy + 1;
% 				nextx = posx - 1;
% 				bFound = true;
%                 
% 			%fprintf('third if statement lower right\n');
%             else
% 				%no path is there; backtrack required
%                 %fprintf('no path is there; backtrack required\n');
% 				bFound = false;
%             end
% 			
% 
% 			if bFound==true
% 			
% 				%push into path stack
% 				path2.top = path2.top + 1;
% 				path2.y(path2.top) = nexty;
% 				path2.x(path2.top) = nextx;
% 				%fprintf('\nPath Top %d: Position (%d,%d) added', path.top, nexty, nextx);
% 
% 				%need to stop if last column is reached
% 				if nextx <=1 
% 				%fprintf('first column reached');
% 					break;
%                 end
% 			
% 			else
% 			
% 				%block the position to be popped
% 				im(posy,posx) = true;
% 				%fprintf('\nPath Top %d: Position (%d,%d) removed\n', path.top, posy, posx);
% 
% 				%pop from path stack for backtracking
%                 path2.y(path2.top)=0;
%                 path2.x(path2.top)=0;
% 				path2.top = path2.top - 1;
% 				if path2.top <= 1 %check if pop is possible
%                    % fprintf('no path exist');
% 					%no possibility of finding any path
% 					break;
%                 end
% 				nexty = path2.y(path2.top);
% 				nextx = path2.x(path2.top);
% 			
%             end
% 			%accept the next point as the present point
% 			posy = nexty;
% 			posx = nextx;
% 
%             end
% 
% 		%mark the path if found  
%         %%eitai hocchena,ei nicher line ta
% 		if (path2.top) == w
%         %%eitai hocchena,aschena eita ,eikhanei vabte hbe
%                                  
% 			%fprintf('\nPath found from row %d', j);
% 			index1=1;
% 			for i=1:path2.top
% 				posy = path2.y(i);
% 				posx = path2.x(i);
%                arr(index1,1)=posy;
%                 
%                 arr(index1,2)=posx;
%                 
%                 index1=index1+1;
%                 im1(posy,posx)=0;   %black the path-line on the non-inverted image
%                 my_im(posy,posx)=0;
%             end
%             arr3{index2}=arr;
%             index2=index2+1;
% 			
% 		
% 		else
% 		%display('no path found');
% 	%fprintf('\nPath not found from col %d', j);
%             arr3{index2}=arr;
%             index2=index2+1;
% 		
%         end
%         end
%         %fprintf('\n row no %d  ended',j);
%         
% end  
        %figure,imshow(im1);
          %figure,imshow(my_im);
%         [row1,col1]=size(my_im);
% for i=1:1:row1
%     for j=1:1:col1
%         if my_im(i,j)==1
%             if img(i,j)==0
%                 my_im(i,j)=img(i,j);
%             end
%         end
%     end
% end
[row,col]=size(im1);
% [row2,col2]=size(arr2);
% for i=1:1:col2
%     arr4(i)=arr2{1,1}(row2,i);
% end
[row1,col1]=size(arr2);
output=255*zeros(size(im1));
arr5=zeros(col);
count=1;
for i=1:1:col1
    yes=arr2{1,i};
    [row2,col2]=size(yes);
    temp1=1;
    for j=1:1:row2
        if (arr5(j)==yes(j,1))||(arr5(j)+1==yes(j,1))
            arr5(j)=yes(j,1);
        else
            temp=yes(j,1)-arr5(j);
            for k=arr5(j)+1:1:yes(j,1)-1
                if img(k,yes(j,2))==0 &&temp1==1
                    count=count+1;
                    output(k,yes(j,2))=count;
                    temp1=0;
                elseif img(k,yes(j,2))==0
                    output(k,yes(j,2))=count;
                end
            end
            arr5(j)=yes(j,1);
        end
    end
end
%figure,imshow(output),title('output');
%imwrite(output,'227_outbw.tif');
temp_store=count;
 %[storerow]=avg_height(im,count);           
                    
color=[[255,0,0];[0,255,0];[0,0,255];[255,255,0];[0,255,255];[255,0,255]];
[row,col]=size(output);
finaloutput=255*ones(row,col,3);

for i=1:row
    for j=1:col
        if output(i,j)==0
            finaloutput(i,j,1)=255;
            finaloutput(i,j,2)=255;
            finaloutput(i,j,3)=255;
        else
            finaloutput(i,j,1)=color(mod(output(i,j),6)+1,1);
            finaloutput(i,j,2)=color(mod(output(i,j),6)+1,2);
            finaloutput(i,j,3)=color(mod(output(i,j),6)+1,3);
         
        end
    end
end
%figure,imshow(finaloutput),title('colored output');
info=ones(temp_store,10);
while(1)
 temp007=0;
 for i=2:1:temp_store
     if info(i,8)~=0
         temp007=1;
         break;
     end
 end
while(temp007==1)  
    temp007=2;
[row,col]=size(output);
info=zeros(temp_store,10);
min1=10000;
max1=0;
for i=2:1:temp_store
    temp=1;
    max=0;
    min=10000;
    for j=1:1:row
        for k=1:1:col
            if output(j,k)==i && temp==1
                temp=0;
                info(i,1)=j;
                info(i,2)=k;
            elseif output(j,k)==i
                    info(i,3)=j;
                    info(i,4)=k;
                    if min>k
                        min=k;
                    end
                    if max<k
                        max=k;
                    end
            end
        end
    end
    info(i,5)=min;
    info(i,6)=max;
    if info(i,3)==0 && info(i,4)==0
        info(i,3)=info(i,1);
        info(i,4)=info(i,2);
        info(i,5)=info(i,2);
        info(i,6)=info(i,2);
    end
    if(min1>min)
        min1=min;
    end
    if max1<max
        max1=max;
    end
    info(i,9)=(info(i,3)-info(i,1))/2;
end
sum2=0;
for i=2:1:temp_store
    sum2=sum2+info(i,9);
end
mea=sum2/temp_store;
sum=0;
for l=2:temp_store
    sum=sum+(((info(l,9))-mea)*((info(l,9))-mea));
end
stand=sqrt(sum/(temp_store));
 mid=abs(max1-min1)/2;
 avg_sum=0;
 avg_count=0;
 for i=2:1:temp_store
     mid2=abs(info(i,5)-info(i,6))/2;
      if(abs(mid-mid2)>30)
         info(i,7)=info(i,1)+((info(i,3)-info(i,1))/2);
         avg_sum=avg_sum+(info(i,3)-info(i,1));
         avg_count=avg_count+1;
      end
 end
 avg_hei=avg_sum/avg_count;
 for i=2:1:temp_store
     temp=1;
     if info(i,7)~=0
        j=i+1;
        while ( j<temp_store && info(j,7)~=0 )
            if abs(info(j-1,7)-info(j,7))<avg_hei
                info(j-1,8)=i;
                info(j,8)=i;
               % fprintf('1');
            else
                break;
            end
            j=j+1;
            temp=0;
        end
     end
     if temp==0
         i=j-1;
     end
 end
 i=2;
 store=0;
 while i<=temp_store
     for j=i+1:1:temp_store
         if(info(j,8)~=0 && info(j,8)==i)
             for k=info(j,1):1:info(j,3)
                for l=1:1:col
                    if output(k,l)==j
                        output(k,l)=i;
                    end
                end
             end
         else
             store=j;
             break;
         end
     end
     if store==i
         i=i+1;
     else
         i=store;
     end
 end
color=[[255,0,0];[0,255,0];[0,0,255];[255,255,0];[0,255,255];[255,0,255]];
[row,col]=size(output);
finaloutput=255*ones(row,col,3);

for i=1:row
    for j=1:col
        if output(i,j)==0
            finaloutput(i,j,1)=255;
            finaloutput(i,j,2)=255;
            finaloutput(i,j,3)=255;
        else
            finaloutput(i,j,1)=color(mod(output(i,j),6)+1,1);
            finaloutput(i,j,2)=color(mod(output(i,j),6)+1,2);
            finaloutput(i,j,3)=color(mod(output(i,j),6)+1,3);
         
        end
    end
end
%figure,imshow(finaloutput),title('new colored output');  
end
if (temp007==0)
    break;
end
end
info1=zeros(temp_store,10);
k=1;
for i=2:1:temp_store
    if (info(i,1)~=0)
        for j=1:1:10
            info1(k,j)=info(i,j);
        end
        k=k+1;
    end
end
for i=2:1:temp_store
    if abs(((info1(i,6)-info1(i,5))/2)-mid)>300
        temp1=info1(i-1,1)+(info1(i-1,3)-info1(i-1,1))/2;
        temp2=info1(i+1,1)+(info1(i+1,3)-info1(i+1,1))/2;
        temp3=info1(i,1)+(info1(i,3)-info1(i,1))/2;
        temp5=info1(i,1);
        if(temp5==0)
            break;
        end
        temp4=output(info1(i,1),info1(i,2));
        if(abs(temp1-temp3)<abs(temp2-temp3))
             for k=info1(i,1):1:info1(i,3)
                for l=1:1:col
                    if output(k,l)==temp4
                        output(k,l)=i-1;
                    end
                end
             end
        else
            for k=info1(i,1):1:info1(i,3)
                for l=1:1:col
                    if output(k,l)==temp4
                        output(k,l)=i+1;
                    end
                end
            end
        end
    end
end
color=[[255,0,0];[0,255,0];[0,0,255];[255,255,0];[0,255,255];[255,0,255]];
[row,col]=size(output);
finaloutput=255*ones(row,col,3);

for i=1:row
    for j=1:col
        if output(i,j)==0
            finaloutput(i,j,1)=255;
            finaloutput(i,j,2)=255;
            finaloutput(i,j,3)=255;
        else
            finaloutput(i,j,1)=color(mod(output(i,j),6)+1,1);
            finaloutput(i,j,2)=color(mod(output(i,j),6)+1,2);
            finaloutput(i,j,3)=color(mod(output(i,j),6)+1,3);
         
        end
    end
end
%figure,imshow(finaloutput),title('new colored output');     
    
     output=output;   
end        
        
    