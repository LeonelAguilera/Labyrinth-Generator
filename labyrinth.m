function laby = labyrinth(X,Y,show)
%Código escrito por Leonel Aguilera 6/6/2020
%Code written by Leonel Aguilera 6/6/2020
%Arguments labyrinth(X,Y,show)
%X: Horizontal labyrinth size in pixels
%Y: Vertical labyrinth size in pixels
%show: true/false Shows step by step how the function builds the labyrinth

if mod(X,2)==0
    X=X+1;
end
if mod(Y,2)==0
    Y=Y+1;
end
if show == true
    screenSize = get(0,'screensize');
    if Y > X
        YscreenSize = screenSize(4);
        XscreenSize = round(YscreenSize*(X/Y));
    else
        XscreenSize = screenSize(3);
        YscreenSize = round(XscreenSize*(Y/X));
    end
end
lab=ones(Y,X,3);
lab(1,:,:)=zeros(1,X,3);
lab(Y,:,:)=zeros(1,X,3);

lab(:,1,:)=zeros(Y,1,3);
lab(:,X,:)=zeros(Y,1,3);

for y=3:2:Y-2
    for x=3:2:X-2
        lab(y,x,:)=[0,0,0];
    end
end
for y=2:Y-1
    for x=2:X-1
        if mod(x+y,2)==1
            lab(y,x,1)=0;
            lab(y,x,3)=0;
        end
    end
end
go(1)=mod(round(X*rand(1)),X-2)+1;
go(2)=mod(round(Y*rand(1)),Y-2)+1;
while lab(go(2),go(1),1)*lab(go(2),go(1),3) == 0
    go(1)=mod(round(X*rand(1)),X-2)+1;
    go(2)=mod(round(Y*rand(1)),Y-2)+1;
end
lab(go(2),go(1),2)=0;
lab(go(2),go(1),3)=0;

flag=1;
i=1;
while flag==1
    seed=round(4*rand);
    if seed==0
        seed=4;
    end
    path(i)=seed;
    switch seed
        case 1
            if go(2)<Y-1
                if (lab(go(2)+2,go(1),2)+lab(go(2)+2,go(1),3) ~= 0)
                    lab(go(2)+1,go(1),:)=[1,0,0];
                    lab(go(2)+2,go(1),:)=[1,0,0];
                    go(2)=go(2)+2;
                    i=i+1;
                elseif (lab(go(2)+1,go(1),1)+lab(go(2)+2,go(1),3) == 0)
                    lab(go(2)+1,go(1),:)=[0,0,0];
                end
            end
        case 2
            if go(2)>2
                if ((lab(go(2)-2,go(1),2)+lab(go(2)-2,go(1),3)) ~= 0)
                    lab(go(2)-1,go(1),:)=[1,0,0];
                    lab(go(2)-2,go(1),:)=[1,0,0];
                    go(2)=go(2)-2;
                    i=i+1;
                elseif (lab(go(2)-1,go(1),1)+lab(go(2)-2,go(1),3) == 0)
                    lab(go(2)-1,go(1),:)=[0,0,0];
                end
            end
        case 3
            if go(1)<X-1
                if (lab(go(2),go(1)+2,2)+lab(go(2),go(1)+2,3)) ~= 0
                    lab(go(2),go(1)+1,:)=[1,0,0];
                    lab(go(2),go(1)+2,:)=[1,0,0];
                    go(1)=go(1)+2;
                    i=i+1;
                elseif (lab(go(2),go(1)+1,1)+lab(go(2),go(1)+2,3) == 0)
                    lab(go(2),go(1)+1,:)=[0,0,0];
                end
            end
        case 4
            if go(1)>2
                if ((lab(go(2),go(1)-2,2)+lab(go(2),go(1)-2,3)) ~= 0)
                    lab(go(2),go(1)-1,:)=[1,0,0];
                    lab(go(2),go(1)-2,:)=[1,0,0];
                    go(1)=go(1)-2;
                    i=i+1;
                elseif((lab(go(2),go(1)-1,1)+lab(go(2),go(1)-2,3) == 0))
                    lab(go(2),go(1)-1,:)=[0,0,0];
                end
            end
    end
    verdes =((lab(go(2),go(1)-1,2))+(lab(go(2),go(1)+1,2))+(lab(go(2)-1,go(1),2))+(lab(go(2)-1,go(1)-1,2)));
    if verdes ==0
        i=i-1;
        switch path(i)
            case 1
                go(2)=go(2)-2;
            case 2
                go(2)=go(2)+2;
            case 3
                go(1)=go(1)-2;
            case 4
                go(1)=go(1)+2;
        end
    end
    flag=0;
    for yb=1:Y
        for xb=1:X
            if sum(lab(yb,xb,:))==3
                flag=1;
                break
            end
        end
    end
    if show == true
        imshow(imresize(lab,[YscreenSize,XscreenSize],'nearest'));
        pause(0.01);
    end
end
laby=lab(:,:,1);
entrada=round(Y*rand(1))+1;
salida=round(Y*rand(1))+1;
while laby(entrada,2)==0
    entrada=round(Y*rand(1));
end
while laby(salida,X-1)==0
    salida=round(Y*rand(1));
end
laby(entrada,1)=1;
laby(salida,X)=1;
imshow(imresize(laby,[YscreenSize,XscreenSize],'nearest'));
end