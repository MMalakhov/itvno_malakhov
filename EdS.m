%%
clear % удалим предыдущие переменные
close % закроем все открытые графики
n=99; % число разбиений
global H a b % глобальные переменные видно в теле функций
a=1;
b=1;
H=2;
Q=1;

h=2/(n-1);  %  шаг
% строим сетку:
[x,y]=meshgrid(-1:h:1,-1:h:1); 
% строим график:
h1=figure(1) % номер графика
mesh(-1:h:1,-1:h:1, H-a*x.^2-b*y.^2) % рисуем
title('Surface') % наводим красоту
xlabel('x') 
ylabel('y')
zlabel('z')
% сохраняем
%saveas(h1,strcat('Our_Figure',  'H=', num2str(H), '.png'),'png')



dfx=zeros(n,n); % prelocation 
dfy=zeros(n,n); % резервируем место под массив
dfz=zeros(n,n); % иначе элементы массива будут разбросаны 
ds=zeros(n,n); % в памяти компьютера и будет долго считать

z=H-a*x.^2-b*y.^2;

for ix=1:n
    for iy=1:n
        
       zi=z(ix,iy);
        % func1(x(ix,ix)+h,y(iy,iy),zi)=0 т.к. это фомула фигуры
        dfx(ix,iy)=func1(x(ix,iy)+h,y(ix,iy),zi)/h; % производные
        dfy(ix,iy)=func1(x(ix,iy),y(ix,iy)+h,zi)/h;
        dfz(ix,iy)=func1(x(ix,ix),y(iy,iy),zi+h)/h;
        
        dsx=sqrt(h^2+(h*dfx(ix,iy))^2); 
        dsy=sqrt(h^2+(h*dfy(ix,iy))^2);
        ds(ix,iy)=dsx*dsy; % элемент площади
        
                 
    end
end



r=sqrt(x.^2+y.^2+z.^2); % радиус вектор

%модуль градиента для вычисления единичного вектора нормали:
absNablaf=sqrt(dfx.^2+dfy.^2+dfz.^2); 


% нормальная составляющая напряженности:
En= (dfx.*x+dfy.*y+dfz.*z).*Q./r.^3;
% точка в этом выражении означает поэлементное
% перемножение матриц

h2=figure(2) % номер графика
mesh(-1:h:1,-1:h:1, En) % рисуем
title('En') % наводим красоту
xlabel('x') 
ylabel('y')
zlabel('z')
% сохраняем
%saveas(h1,strcat('En',  'H=', num2str(H), '.png'),'png')
