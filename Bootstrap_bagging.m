clear;
clc;
X=load('hw3_train.txt');
D=load('hw3_test.txt');
%{
for i=1:size(X,2)-1
    train(:,i)=X(:,i);
end
label=X(:,size(X,2));
%}
Y=X(:,size(X,2));
data_size=size(X,1);
out_size=size(D,1)
Y2=D(:,size(D,2));

tree=CART(X);
temp=tree;


err=0;
% bootstrap
Bootstrap_data=[];
forest=[];

tree_num=300;
repeat_times=1;
RF_err=0;
err=0;
g_err=0;
gt_avg=0;
for k=1:repeat_times
    ii=k
    Bootstrap_data=[];
    forest=[];
    for j=1:tree_num
      for i=1:data_size
          Bootstrap_data=[Bootstrap_data; X(randi(data_size),:)];
      end
      temp_tree=CART(Bootstrap_data);
      forest=[forest temp_tree];
      Bootstrap_data=[];
    end
    for i=1:data_size
       score=0;
       for j=1:tree_num
           result=0;
           tree=forest(j);
           while tree.result ==0
               theda=tree.theda;
               dim=tree.dim;
               if sign(X(i,dim)-theda) ==1
                   tree=tree.right;
               else
                   tree=tree.left;
               end
           end
           result=tree.result;
           if sign(result) ~= Y(i)
                g_err=g_err+1;
           end
           score=score+result;
       end
       gt_avg=gt_avg+g_err;
       g_err=0;
       if sign(score) ~= Y(i)
            err=err+1;
       end
    end
    
end
gt_avg=gt_avg/(data_size*tree_num*repeat_times)
err=err/(data_size*repeat_times)
%{

for i=1:data_size
   result=0;
   tree=temp;
   while tree.result ==0
       theda=tree.theda;
       dim=tree.dim;
       if sign(X(i,dim)-theda) ==1
           tree=tree.right;
       else
           tree=tree.left;
       end
   end
   result=tree.result;
   if result ~= Y(i)
      err=err+1;
   end
end
err=err/data_size


err=0;

for i=1:out_size
   result=0;
   tree=temp;
   while tree.result ==0
       theda=tree.theda;
       dim=tree.dim;
       if sign(D(i,dim)-theda) ==1
           tree=tree.right;
       else
           tree=tree.left;
       end
   end
   result=tree.result;
   if result ~= Y2(i)
      err=err+1;
   end
end
err=err/out_size
%}

%{
temp=CRT;
temp.left=1;

root=CRT;
root.left=temp;
%}