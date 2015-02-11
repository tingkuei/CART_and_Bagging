function tree = CART(data)        
root=CRT;
for i=1:size(data,2)-1
    train(:,i)=data(:,i);
end
record=[];
Y=data(:,size(data,2));
Sort_total=sort(train);
data_size=size(train,1);
for i=1:size(train,2)
   Sort_data=Sort_total(:,i);
   Stump_data=[Sort_data(1)-1;Sort_data;Sort_data(data_size)+1];
   for j=1:data_size+1
       theda=(Stump_data(j)+Stump_data(j+1))/2;
       S=1;
       left_size=0;
       right_size=0;
       pl=0;
       nl=0;
       pr=0;
       nr=0;
       for k=1:data_size
           if sign(train(k,i)-theda) ==-1                
             left_size=left_size+1;
             if Y(k)==1
               pl=pl+1;
             else
               nl=nl+1;
             end
           else 
             right_size=right_size+1;
             if Y(k)==1
               pr=pr+1;
             else
               nr=nr+1;
             end
           end
       end  
       pl=pl/left_size;
       nl=nl/left_size;
       pr=pr/right_size;
       nr=nr/right_size;
       ip_left=(1-pl^2-nl^2);
       ip_right=(1-pr^2-nr^2);
       % gini index
       gini=left_size*ip_left+right_size*ip_right;
       record=[record; theda i gini pl pr;];
   end
end
   [minum,index]=min(record(:,3));
   theda=record(index,1);
   dim=record(index,2);
   pl=record(index,4);
   pr=record(index,5);
   right_data=[];
   left_data=[];
   temp_left=CRT;
   temp_right=CRT;
   root.theda=theda;
   root.dim=dim;
   temp=CRT;
% terminal conditoin  
   for k=1:data_size 
       if sign(train(k,dim)-theda) ==-1
           left_data=[left_data; data(k,:)];
       else
           right_data=[right_data; data(k,:)];
       end    
   end
   % get left tree
   if pl==1
       temp.result=1;
       root.left=temp;
   elseif pl ==0
       temp.result=-1;
       root.left=temp;
   else
       left_child= CART(left_data);
       root.left=left_child; 
   end
   % get right tree
   if pr==1
       temp.result=1;
       root.right=temp;
   elseif pr == 0
       temp.result=-1;
       root.right=temp;
   else
       right_child= CART(right_data);
       root.right=right_child; 
   end
   tree=root;
   return
end    
    
    

