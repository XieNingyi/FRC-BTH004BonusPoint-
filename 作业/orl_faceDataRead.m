global imgrow;
global imgcol;
imgrow=112;
imgcol=92;

npersons=41

orF=ReadFace(41,flag==0)

meanF=mean(orF,1)

[pcaF,eigF]=myPCA(orF,40,meanF)

eigF=pcaF(200,:)*eigF'+meanF

eig_img=reshape(eigF,[imgrow,imgcol]);
imshow(uint8(eig_img))

% A=[1,2
%    3,4
%    5,6]
% 
% mA=mean(A,1)
% 
% K=1
% 
% [pcaA,eigA]=myPCA(A,K,mA)
% 
% reA=pcaA*eigA'+mA

function[f_matrix,realclass]=ReadFace(npersons,flag)
realclass=0;
k=0;
f_matrix=zeros(205,10304);
if(flag==0)
    for i = 1:npersons
        facepath='D:\ORL\s';
        facepath=strcat(facepath,num2str(i));
        facepath=strcat(facepath,'_');
        newpath=facepath;
        for j = 1:5
            facepath=newpath;
            facepath=strcat(facepath,num2str(j));
            facepath=strcat(facepath,'.bmp');
            img = imread(facepath);
            k=k+1;
            f_matrix(k,:)=img(:);
        end
    end
else
    for i = 1:npersons
        facepath='D:\ORL\s';
        facepath=strcat(facepath,num2str(i));
        facepath=strcat(facepath,'_');
        newpath=facepath;
        realclass=realclass+1;
        for j = 6:10
            facepath=newpath;
            facepath=strcat(facepath,num2str(j));
            facepath=strcat(facepath,'.bmp');
            img = imread(facepath);
            k=k+1;
            f_matrix(k,:)=img(:);
        end
    end
end
end

function[pcaA,V]=myPCA(A,K,mA)
%A-样本矩阵
%k-降至k维
%mA-给定A的均值，行向量
C=cov(A);
[V,D]=eigs(C,K)
%V-前k个特征向量
%D-特征值
pcaA=(A-mA)*V
end

