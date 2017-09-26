function [ f ] = func1( x,y,z )
global H a b
f=z+a*x.^2+b*y.^2-H;

end
