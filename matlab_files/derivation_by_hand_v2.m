clear all; clc;
syms x1(t);
syms y1(t);
syms d1;
syms d0;
dx1 = diff(x1,t);
dy1 = diff(y1,t);
ddx1 = diff(x1,t,t);
ddy1 = diff(y1,t,t);
%ddx1 = diff(dx1,t,2);
%ddy1 = diff(dy1,t,2);
%syms dx1(t);
%syms dy1(t);
% theta_1=atan(diff(y1,t)/diff(x1,t))
theta_1=atan(y1/x1)
y_0=y1+d1*sin(theta_1);
y_0 =simplify(y_0)
x_0 = x1+d1*cos(theta_1);
x_0 = simplify(x_0)

% theta_0 = atan(diff(y_0,t)/diff(x_0,t));
theta_0 = atan(y_0/x_0);
theta_0 = simplify(theta_0)
phi= atan(d0*diff(theta_0,t)*cos(theta_0)/diff(x_0,t));
phi = simplify(phi)
u2 = diff(phi,t);
u2 = simplify(u2);
u1 = diff(x_0,t)/cos(theta_0);
u1 = simplify(u1)
