function [sys,x0]=carlikeanim(t,x,u,flag);

%   Jerome Jouffroy, November 2007
%   modified by Qiuyang zhou, July 2013
%   modified by Jerome Jouffroy, September 2014
% out.simout.Data(:,8)
global CarLikeAnim

% car
    Ycar = 0.1*[ 6 ; 6 ; 3; -3 ; -6 ; -6 ];
    Xcar = 0.1*[ -3 ; 15 ; 16 ; 16 ; 15;  -3 ]; 

% wheel model
    Yw = 0.1*[ 0.5 ; 0.5 ; -0.5 ; -0.5 ];
    Xw = 0.1*[ -2 ; 2 ; 2 ; -2 ];
    
% left rear wheel
    Ywlr = Yw - 0.5;
    Xwlr = Xw;
    
% right rear wheel    
    Ywrr = Yw + 0.5;
    Xwrr = Xw;

% left front wheel
    Ywlf = Yw;
    Xwlf = Xw;
    
% right front wheel
    Ywrf = Yw;
    Xwrf = Xw;
    
% axles
    Yraxle = 0.1*[ -5 ; 5 ]; % rear axle
    Xraxle = 0.1*[ 0 ; 0 ];
    Ylaxle = 0.1*[ 0 ; 0 ]; % longitudinal axle
    Xlaxle = 0.1*[ 0 ; 12 ];
    Yfaxle = 0.1*[ -5 ; 5 ]; % front axle
    Xfaxle = 0.1*[ 12 ; 12 ];

% body trailer
    Ytrailer = 0.1*[ 6 ; 6 ; 3; -3 ; -6 ; -6 ];
    %% Xtrailer = [ -3.3 ; -2.1 ; -2 ; -2 ; -2.1;  -3.3 ]; 
    %% Xtrailer = 0.1*[ -3 ; 9 ; 10 ; 10 ; 9;  -3 ] - [ 3 ; 3 ; 3 ; 3 ; 3;  3 ]; 
    Xtrailer = 0.1*[ -3 ; 9 ; 10 ; 10 ; 9;  -3 ]; 

% axles trailer
    Ymaxle2 = 0.1*[ -5 ; 5 ]; % middle axle
    Xmaxle2 = 0.1*[ 3 ; 3 ];
    Ylaxle2 = 0.1*[ 0 ; 0 ]; % longitudinal axle
    Xlaxle2 = 0.1*[ -3 ; 9 ];
    
% wheel model trailer
    %% Yw2 = [ -2.95; -2.95 ; -3.05 ; -3.05 ];
    %% Xw2 = [ -3.2 ; -2.8 ; -2.8 ; -3.2 ];

    %% Yw2 = 0.1*[ 0.5 ; 0.5 ; -0.5 ; -0.5 ] - [ 3 ; 3 ; 3 ; 3];
    %% Xw2 = 0.1*[ -2 ; 2 ; 2 ; -2 ] - [ 3 ; 3 ; 3 ; 3];

    Yw2 = 0.1*[ 0.5 ; 0.5 ; -0.5 ; -0.5 ] ;
    Xw2 = 0.1*[ -2 ; 2 ; 2 ; -2 ] +0.3;
    
% left wheel
    Ywl2 = Yw2 + 0.5;
    Xwl2 = Xw2;
    
% right wheel    
    Ywr2 = Yw2 - 0.5;
    Xwr2 = Xw2;

% Connector    
    Linkx = [ 0 ; 1 ];
    Linky = [ 0 ; 0 ];
    Linkx2 = [ 0 ; 1 ];
    Linky2 = [ 0 ; 0 ];
    
    pathx = 0;
    pathy = 0;

    errorx = [ 0 ; 0 ];
    errory = [ 0 ; 0 ];


    %% Other cars for obstacles
 %% car 2
    Xpos_car2 = 12;
    Ypos_car2 = 0;
    rot_car2 = 0;
    Ycar_car2 = 0.1*[ 6 ; 6 ; 3; -3 ; -6 ; -6 ];
    Xcar_car2 = 0.1*[ -3 ; 15 ; 16 ; 16 ; 15;  -3 ]; 
    
    [Xcar_car2,Ycar_car2] = rot(Xcar_car2,Ycar_car2,rot_car2);

    Xcar_car2=Xcar_car2+Xpos_car2;
    Ycar_car2=Ycar_car2+Ypos_car2;

% wheel model
    Yw_car2 = 0.1*[ 0.5 ; 0.5 ; -0.5 ; -0.5 ];
    Xw_car2 = 0.1*[ -2 ; 2 ; 2 ; -2 ];
    
% left rear wheel
    Ywlr_car2 = Yw_car2 - 0.5;
    Xwlr_car2 = Xw_car2;
    [Xwlr_car2,Ywlr_car2] = rot(Xwlr_car2,Ywlr_car2,rot_car2);
    Xwlr_car2 = Xwlr_car2+Xpos_car2;
    Ywlr_car2 = Ywlr_car2+Ypos_car2;
    
% right rear wheel    
    Ywrr_car2 = Yw_car2 + 0.5;
    Xwrr_car2 = Xw_car2;
    [Xwrr_car2,Ywrr_car2] = rot(Xwrr_car2,Ywrr_car2,rot_car2);
    Xwrr_car2 = Xwrr_car2+Xpos_car2;
    Ywrr_car2 = Ywrr_car2+Ypos_car2;

% left front wheel
    Ywlf_car2 = Yw_car2 + 0.5;
    Xwlf_car2 = Xw_car2 + 1.2;
    [Xwlf_car2,Ywlf_car2] = rot(Xwlf_car2,Ywlf_car2,rot_car2);
    Xwlf_car2 = Xwlf_car2+Xpos_car2;
    Ywlf_car2 = Ywlf_car2+Ypos_car2;
    
% right front wheel
    Ywrf_car2 = Yw_car2 - 0.5;
    Xwrf_car2 = Xw_car2 + 1.2;
    [Xwrf_car2,Ywrf_car2] = rot(Xwrf_car2,Ywrf_car2,rot_car2);

    Xwrf_car2 = Xwrf_car2+Xpos_car2;
    Ywrf_car2 = Ywrf_car2+Ypos_car2;
    
% axles
    Yraxle_car2 = 0.1*[ -5 ; 5 ]; % rear axle
    Xraxle_car2 = 0.1*[ 0 ; 0 ];
    Ylaxle_car2 = 0.1*[ 0 ; 0 ]; % longitudinal axle
    Xlaxle_car2 = 0.1*[ 0 ; 12 ];
    Yfaxle_car2 = 0.1*[ -5 ; 5 ]; % front axle
    Xfaxle_car2 = 0.1*[ 12 ; 12 ];

    [Xraxle_car2,Yraxle_car2] = rot(Xraxle_car2,Yraxle_car2,rot_car2);
    [Xlaxle_car2,Ylaxle_car2] = rot(Xlaxle_car2,Ylaxle_car2,rot_car2);
    [Xfaxle_car2,Yfaxle_car2] = rot(Xfaxle_car2,Yfaxle_car2,rot_car2);

    Xraxle_car2 = Xraxle_car2+Xpos_car2;
    Xlaxle_car2 = Xlaxle_car2+Xpos_car2;
    Xfaxle_car2 = Xfaxle_car2+Xpos_car2;
    Yraxle_car2 = Yraxle_car2+Ypos_car2;
    Ylaxle_car2 = Ylaxle_car2+Ypos_car2;
    Yfaxle_car2 = Yfaxle_car2+Ypos_car2;

     %% car 3
    Xpos_car3 = 18;
    Ypos_car3 = 2;
    rot_car3 = 0;
    Ycar_car3 = 0.1*[ 6 ; 6 ; 3; -3 ; -6 ; -6 ];
    Xcar_car3 = 0.1*[ -3 ; 15 ; 16 ; 16 ; 15;  -3 ]; 
    
    [Xcar_car3,Ycar_car3] = rot(Xcar_car3,Ycar_car3,rot_car3);

    Xcar_car3=Xcar_car3+Xpos_car3;
    Ycar_car3=Ycar_car3+Ypos_car3;

% wheel model
    Yw_car3 = 0.1*[ 0.5 ; 0.5 ; -0.5 ; -0.5 ];
    Xw_car3 = 0.1*[ -2 ; 2 ; 2 ; -2 ];
    
% left rear wheel
    Ywlr_car3 = Yw_car3 - 0.5;
    Xwlr_car3 = Xw_car3;
    [Xwlr_car3,Ywlr_car3] = rot(Xwlr_car3,Ywlr_car3,rot_car3);
    Xwlr_car3 = Xwlr_car3+Xpos_car3;
    Ywlr_car3 = Ywlr_car3+Ypos_car3;
    
% right rear wheel    
    Ywrr_car3 = Yw_car3 + 0.5;
    Xwrr_car3 = Xw_car3;
    [Xwrr_car3,Ywrr_car3] = rot(Xwrr_car3,Ywrr_car3,rot_car3);
    Xwrr_car3 = Xwrr_car3+Xpos_car3;
    Ywrr_car3 = Ywrr_car3+Ypos_car3;

% left front wheel
    Ywlf_car3 = Yw_car3 + 0.5;
    Xwlf_car3 = Xw_car3 + 1.2;
    [Xwlf_car3,Ywlf_car3] = rot(Xwlf_car3,Ywlf_car3,rot_car3);
    Xwlf_car3 = Xwlf_car3+Xpos_car3;
    Ywlf_car3 = Ywlf_car3+Ypos_car3;
    
% right front wheel
    Ywrf_car3 = Yw_car3 - 0.5;
    Xwrf_car3 = Xw_car3 + 1.2;
    [Xwrf_car3,Ywrf_car3] = rot(Xwrf_car3,Ywrf_car3,rot_car3);

    Xwrf_car3 = Xwrf_car3+Xpos_car3;
    Ywrf_car3 = Ywrf_car3+Ypos_car3;
    
% axles
    Yraxle_car3 = 0.1*[ -5 ; 5 ]; % rear axle
    Xraxle_car3 = 0.1*[ 0 ; 0 ];
    Ylaxle_car3 = 0.1*[ 0 ; 0 ]; % longitudinal axle
    Xlaxle_car3 = 0.1*[ 0 ; 12 ];
    Yfaxle_car3 = 0.1*[ -5 ; 5 ]; % front axle
    Xfaxle_car3 = 0.1*[ 12 ; 12 ];

    [Xraxle_car3,Yraxle_car3] = rot(Xraxle_car3,Yraxle_car3,rot_car3);
    [Xlaxle_car3,Ylaxle_car3] = rot(Xlaxle_car3,Ylaxle_car3,rot_car3);
    [Xfaxle_car3,Yfaxle_car3] = rot(Xfaxle_car3,Yfaxle_car3,rot_car3);

    Xraxle_car3 = Xraxle_car3+Xpos_car3;
    Xlaxle_car3 = Xlaxle_car3+Xpos_car3;
    Xfaxle_car3 = Xfaxle_car3+Xpos_car3;
    Yraxle_car3 = Yraxle_car3+Ypos_car3;
    Ylaxle_car3 = Ylaxle_car3+Ypos_car3;
    Yfaxle_car3 = Yfaxle_car3+Ypos_car3;

 %% car 4
    Xpos_car4 = 18;
    Ypos_car4 = -2;
    rot_car4 = 0;
    Ycar_car4 = 0.1*[ 6 ; 6 ; 3; -3 ; -6 ; -6 ];
    Xcar_car4 = 0.1*[ -3 ; 15 ; 16 ; 16 ; 15;  -3 ]; 
    
    [Xcar_car4,Ycar_car4] = rot(Xcar_car4,Ycar_car4,rot_car4);

    Xcar_car4=Xcar_car4+Xpos_car4;
    Ycar_car4=Ycar_car4+Ypos_car4;

% wheel model
    Yw_car4 = 0.1*[ 0.5 ; 0.5 ; -0.5 ; -0.5 ];
    Xw_car4 = 0.1*[ -2 ; 2 ; 2 ; -2 ];
    
% left rear wheel
    Ywlr_car4 = Yw_car4 - 0.5;
    Xwlr_car4 = Xw_car4;
    [Xwlr_car4,Ywlr_car4] = rot(Xwlr_car4,Ywlr_car4,rot_car4);
    Xwlr_car4 = Xwlr_car4+Xpos_car4;
    Ywlr_car4 = Ywlr_car4+Ypos_car4;
    
% right rear wheel    
    Ywrr_car4 = Yw_car4 + 0.5;
    Xwrr_car4 = Xw_car4;
    [Xwrr_car4,Ywrr_car4] = rot(Xwrr_car4,Ywrr_car4,rot_car4);
    Xwrr_car4 = Xwrr_car4+Xpos_car4;
    Ywrr_car4 = Ywrr_car4+Ypos_car4;

% left front wheel
    Ywlf_car4 = Yw_car4 + 0.5;
    Xwlf_car4 = Xw_car4 + 1.2;
    [Xwlf_car4,Ywlf_car4] = rot(Xwlf_car4,Ywlf_car4,rot_car4);
    Xwlf_car4 = Xwlf_car4+Xpos_car4;
    Ywlf_car4 = Ywlf_car4+Ypos_car4;
    
% right front wheel
    Ywrf_car4 = Yw_car4 - 0.5;
    Xwrf_car4 = Xw_car4 + 1.2;
    [Xwrf_car4,Ywrf_car4] = rot(Xwrf_car4,Ywrf_car4,rot_car4);

    Xwrf_car4 = Xwrf_car4+Xpos_car4;
    Ywrf_car4 = Ywrf_car4+Ypos_car4;
    
% axles
    Yraxle_car4 = 0.1*[ -5 ; 5 ]; % rear axle
    Xraxle_car4 = 0.1*[ 0 ; 0 ];
    Ylaxle_car4 = 0.1*[ 0 ; 0 ]; % longitudinal axle
    Xlaxle_car4 = 0.1*[ 0 ; 12 ];
    Yfaxle_car4 = 0.1*[ -5 ; 5 ]; % front axle
    Xfaxle_car4 = 0.1*[ 12 ; 12 ];

    [Xraxle_car4,Yraxle_car4] = rot(Xraxle_car4,Yraxle_car4,rot_car4);
    [Xlaxle_car4,Ylaxle_car4] = rot(Xlaxle_car4,Ylaxle_car4,rot_car4);
    [Xfaxle_car4,Yfaxle_car4] = rot(Xfaxle_car4,Yfaxle_car4,rot_car4);

    Xraxle_car4 = Xraxle_car4+Xpos_car4;
    Xlaxle_car4 = Xlaxle_car4+Xpos_car4;
    Xfaxle_car4 = Xfaxle_car4+Xpos_car4;
    Yraxle_car4 = Yraxle_car4+Ypos_car4;
    Ylaxle_car4 = Ylaxle_car4+Ypos_car4;
    Yfaxle_car4 = Yfaxle_car4+Ypos_car4;

     %% car 5
    Xpos_car5 = 8;
    Ypos_car5 = -2.5;
    rot_car5 = pi/2;
    Ycar_car5 = 0.1*[ 6 ; 6 ; 3; -3 ; -6 ; -6 ];
    Xcar_car5 = 0.1*[ -3 ; 15 ; 16 ; 16 ; 15;  -3 ]; 
    
    [Xcar_car5,Ycar_car5] = rot(Xcar_car5,Ycar_car5,rot_car5);

    Xcar_car5=Xcar_car5+Xpos_car5;
    Ycar_car5=Ycar_car5+Ypos_car5;

% wheel model
    Yw_car5 = 0.1*[ 0.5 ; 0.5 ; -0.5 ; -0.5 ];
    Xw_car5 = 0.1*[ -2 ; 2 ; 2 ; -2 ];
    
% left rear wheel
    Ywlr_car5 = Yw_car5 - 0.5;
    Xwlr_car5 = Xw_car5;
    [Xwlr_car5,Ywlr_car5] = rot(Xwlr_car5,Ywlr_car5,rot_car5);
    Xwlr_car5 = Xwlr_car5+Xpos_car5;
    Ywlr_car5 = Ywlr_car5+Ypos_car5;
    
% right rear wheel    
    Ywrr_car5 = Yw_car5 + 0.5;
    Xwrr_car5 = Xw_car5;
    [Xwrr_car5,Ywrr_car5] = rot(Xwrr_car5,Ywrr_car5,rot_car5);
    Xwrr_car5 = Xwrr_car5+Xpos_car5;
    Ywrr_car5 = Ywrr_car5+Ypos_car5;

% left front wheel
    Ywlf_car5 = Yw_car5 + 0.5;
    Xwlf_car5 = Xw_car5 + 1.2;
    [Xwlf_car5,Ywlf_car5] = rot(Xwlf_car5,Ywlf_car5,rot_car5);
    Xwlf_car5 = Xwlf_car5+Xpos_car5;
    Ywlf_car5 = Ywlf_car5+Ypos_car5;
    
% right front wheel
    Ywrf_car5 = Yw_car5 - 0.5;
    Xwrf_car5 = Xw_car5 + 1.2;
    [Xwrf_car5,Ywrf_car5] = rot(Xwrf_car5,Ywrf_car5,rot_car5);

    Xwrf_car5 = Xwrf_car5+Xpos_car5;
    Ywrf_car5 = Ywrf_car5+Ypos_car5;
    
% axles
    Yraxle_car5 = 0.1*[ -5 ; 5 ]; % rear axle
    Xraxle_car5 = 0.1*[ 0 ; 0 ];
    Ylaxle_car5 = 0.1*[ 0 ; 0 ]; % longitudinal axle
    Xlaxle_car5 = 0.1*[ 0 ; 12 ];
    Yfaxle_car5 = 0.1*[ -5 ; 5 ]; % front axle
    Xfaxle_car5 = 0.1*[ 12 ; 12 ];

    [Xraxle_car5,Yraxle_car5] = rot(Xraxle_car5,Yraxle_car5,rot_car5);
    [Xlaxle_car5,Ylaxle_car5] = rot(Xlaxle_car5,Ylaxle_car5,rot_car5);
    [Xfaxle_car5,Yfaxle_car5] = rot(Xfaxle_car5,Yfaxle_car5,rot_car5);

    Xraxle_car5 = Xraxle_car5+Xpos_car5;
    Xlaxle_car5 = Xlaxle_car5+Xpos_car5;
    Xfaxle_car5 = Xfaxle_car5+Xpos_car5;
    Yraxle_car5 = Yraxle_car5+Ypos_car5;
    Ylaxle_car5 = Ylaxle_car5+Ypos_car5;
    Yfaxle_car5 = Yfaxle_car5+Ypos_car5;

    %% car 6
    Xpos_car6 = 6;
    Ypos_car6 = 1.5;
    rot_car6 = pi/2;
    Ycar_car6 = 0.1*[ 6 ; 6 ; 3; -3 ; -6 ; -6 ];
    Xcar_car6 = 0.1*[ -3 ; 15 ; 16 ; 16 ; 15;  -3 ]; 
    
    [Xcar_car6,Ycar_car6] = rot(Xcar_car6,Ycar_car6,rot_car6);

    Xcar_car6=Xcar_car6+Xpos_car6;
    Ycar_car6=Ycar_car6+Ypos_car6;

% wheel model
    Yw_car6 = 0.1*[ 0.5 ; 0.5 ; -0.5 ; -0.5 ];
    Xw_car6 = 0.1*[ -2 ; 2 ; 2 ; -2 ];
    
% left rear wheel
    Ywlr_car6 = Yw_car6 - 0.5;
    Xwlr_car6 = Xw_car6;
    [Xwlr_car6,Ywlr_car6] = rot(Xwlr_car6,Ywlr_car6,rot_car6);
    Xwlr_car6 = Xwlr_car6+Xpos_car6;
    Ywlr_car6 = Ywlr_car6+Ypos_car6;
    
% right rear wheel    
    Ywrr_car6 = Yw_car6 + 0.5;
    Xwrr_car6 = Xw_car6;
    [Xwrr_car6,Ywrr_car6] = rot(Xwrr_car6,Ywrr_car6,rot_car6);
    Xwrr_car6 = Xwrr_car6+Xpos_car6;
    Ywrr_car6 = Ywrr_car6+Ypos_car6;

% left front wheel
    Ywlf_car6 = Yw_car6 + 0.5;
    Xwlf_car6 = Xw_car6 + 1.2;
    [Xwlf_car6,Ywlf_car6] = rot(Xwlf_car6,Ywlf_car6,rot_car6);
    Xwlf_car6 = Xwlf_car6+Xpos_car6;
    Ywlf_car6 = Ywlf_car6+Ypos_car6;
    
% right front wheel
    Ywrf_car6 = Yw_car6 - 0.5;
    Xwrf_car6 = Xw_car6 + 1.2;
    [Xwrf_car6,Ywrf_car6] = rot(Xwrf_car6,Ywrf_car6,rot_car6);

    Xwrf_car6 = Xwrf_car6+Xpos_car6;
    Ywrf_car6 = Ywrf_car6+Ypos_car6;
    
% axles
    Yraxle_car6 = 0.1*[ -5 ; 5 ]; % rear axle
    Xraxle_car6 = 0.1*[ 0 ; 0 ];
    Ylaxle_car6 = 0.1*[ 0 ; 0 ]; % longitudinal axle
    Xlaxle_car6 = 0.1*[ 0 ; 12 ];
    Yfaxle_car6 = 0.1*[ -5 ; 5 ]; % front axle
    Xfaxle_car6 = 0.1*[ 12 ; 12 ];

    [Xraxle_car6,Yraxle_car6] = rot(Xraxle_car6,Yraxle_car6,rot_car6);
    [Xlaxle_car6,Ylaxle_car6] = rot(Xlaxle_car6,Ylaxle_car6,rot_car6);
    [Xfaxle_car6,Yfaxle_car6] = rot(Xfaxle_car6,Yfaxle_car6,rot_car6);

    Xraxle_car6 = Xraxle_car6+Xpos_car6;
    Xlaxle_car6 = Xlaxle_car6+Xpos_car6;
    Xfaxle_car6 = Xfaxle_car6+Xpos_car6;
    Yraxle_car6 = Yraxle_car6+Ypos_car6;
    Ylaxle_car6 = Ylaxle_car6+Ypos_car6;
    Yfaxle_car6 = Yfaxle_car6+Ypos_car6;

%      %% car 2
%     Xpos_car2 = 12;
%     rot_car2 = pi/2;
%     Ycar_car2 = 0.1*[ 6 ; 6 ; 3; -3 ; -6 ; -6 ];
%     Xcar_car2 = 0.1*[ -3 ; 15 ; 16 ; 16 ; 15;  -3 ]+Xpos_car2; 
%     
%     [Xcar_car2,Ycar_car2] = rot(-Xcar_car2,-Ycar_car2,rot_car2);
% 
% % wheel model
%     Yw_car2 = 0.1*[ 0.5 ; 0.5 ; -0.5 ; -0.5 ];
%     Xw_car2 = 0.1*[ -2 ; 2 ; 2 ; -2 ]+Xpos_car2;
%     
% % left rear wheel
%     Ywlr_car2 = Yw_car2 - 0.5;
%     Xwlr_car2 = Xw_car2;
%     [Xwlr_car2,Ywlr_car2] = rot(-Xwlr_car2,-Ywlr_car2,rot_car2);
%     
% % right rear wheel    
%     Ywrr_car2 = Yw_car2 + 0.5;
%     Xwrr_car2 = Xw_car2;
%     [Xwrr_car2,Ywrr_car2] = rot(-Xwrr_car2,-Ywrr_car2,rot_car2);
% 
% % left front wheel
%     Ywlf_car2 = Yw_car2 + 0.5;
%     Xwlf_car2 = Xw_car2 + 1.2;
%     [Xwlf_car2,Ywlf_car2] = rot(-Xwlf_car2,-Ywlf_car2,rot_car2);
%     
% % right front wheel
%     Ywrf_car2 = Yw_car2 - 0.5;
%     Xwrf_car2 = Xw_car2 + 1.2;
%     [Xwrf_car2,Ywrf_car2] = rot(-Xwrf_car2,-Ywrf_car2,rot_car2);
%     
% % axles
%     Yraxle_car2 = 0.1*[ -5 ; 5 ]; % rear axle
%     Xraxle_car2 = 0.1*[ 0 ; 0 ]+Xpos_car2;
%     Ylaxle_car2 = 0.1*[ 0 ; 0 ]; % longitudinal axle
%     Xlaxle_car2 = 0.1*[ 0 ; 12 ]+Xpos_car2;
%     Yfaxle_car2 = 0.1*[ -5 ; 5 ]; % front axle
%     Xfaxle_car2 = 0.1*[ 12 ; 12 ]+Xpos_car2;
% 
%     [Xraxle_car2,Yraxle_car2] = rot(-Xraxle_car2,-Yraxle_car2,rot_car2);
%     [Xlaxle_car2,Ylaxle_car2] = rot(-Xlaxle_car2,-Ylaxle_car2,rot_car2);
%     [Xfaxle_car2,Yfaxle_car2] = rot(-Xfaxle_car2,-Yfaxle_car2,rot_car2);

if flag==2,
    
    %display all hidden hand objects
    shh = get(0,'ShowHiddenHandles');
    set(0,'ShowHiddenHandles','on');
    
    
  if any(get(0,'Children')==CarLikeAnim),
    if strcmp(get(CarLikeAnim,'Name'),'Car-Like Robot'),
      set(0,'currentfigure',CarLikeAnim);
      hndlList=get(gca,'UserData');

      % draw car chassis
      [PosXcar,PosYcar] = rot(Xcar,Ycar,u(3));
      PosXcar = PosXcar + u(1);
      PosYcar = PosYcar + u(2);
      % draw left rear wheel
      [PosXwlr,PosYwlr] = rot(Xwlr,Ywlr,u(3));
      PosXwlr = PosXwlr + u(1);
      PosYwlr = PosYwlr + u(2);
      % draw right rear wheel
      [PosXwrr,PosYwrr] = rot(Xwrr,Ywrr,u(3));
      PosXwrr = PosXwrr + u(1);
      PosYwrr = PosYwrr + u(2);
       % draw left front wheel
      [PosXwlf,PosYwlf] = rot(Xwlf,Ywlf,u(4));
      PosXwlf = PosXwlf + 1.2;
      PosYwlf = PosYwlf + 0.5;
      [PosXwlf,PosYwlf] = rot(PosXwlf,PosYwlf,u(3));
      PosXwlf = PosXwlf + u(1);
      PosYwlf = PosYwlf + u(2);
      % draw right front wheel
      [PosXwrf,PosYwrf] = rot(Xwrf,Ywrf,u(4));
      PosXwrf = PosXwrf + 1.2;
      PosYwrf = PosYwrf - 0.5;
      [PosXwrf,PosYwrf] = rot(PosXwrf,PosYwrf,u(3));
      PosXwrf = PosXwrf + u(1);
      PosYwrf = PosYwrf + u(2);
      % draw rear axle
      [PosXraxle,PosYraxle] = rot(Xraxle,Yraxle,u(3));
      PosXraxle = PosXraxle + u(1);
      PosYraxle = PosYraxle + u(2);
      % draw longitudinal axle
      [PosXlaxle,PosYlaxle] = rot(Xlaxle,Ylaxle,u(3));
      PosXlaxle = PosXlaxle + u(1);
      PosYlaxle = PosYlaxle + u(2);
      % draw front axle
      [PosXfaxle,PosYfaxle] = rot(Xfaxle,Yfaxle,u(3));
      PosXfaxle = PosXfaxle + u(1);
      PosYfaxle = PosYfaxle + u(2);

%% Trailer drawing
      % draw car chassis
      [PosXtrailer,PosYtrailer] = rot(Xtrailer,Ytrailer,u(7));
      PosXtrailer = PosXtrailer + u(5);
      PosYtrailer = PosYtrailer + u(6);
      % draw left trailer wheel
      [PosXwl2,PosYwl2] = rot(Xwl2,Ywl2,u(7));
      PosXwl2 = PosXwl2 + u(5);
      PosYwl2 = PosYwl2 + u(6);
      % draw right trailer wheel
      [PosXwr2,PosYwr2] = rot(Xwr2,Ywr2,u(7));
      PosXwr2 = PosXwr2 + u(5);
      PosYwr2 = PosYwr2 + u(6);
       
      % draw middle axle
      [PosXmaxle2,PosYmaxle2] = rot(Xmaxle2,Ymaxle2,u(7));
      PosXmaxle2 = PosXmaxle2 + u(5);
      PosYmaxle2 = PosYmaxle2 + u(6);
      % draw longitudinal axle
      [PosXlaxle2,PosYlaxle2] = rot(Xlaxle2,Ylaxle2,u(7));
      PosXlaxle2 = PosXlaxle2 + u(5);
      PosYlaxle2 = PosYlaxle2 + u(6);


%%

%% Link
%       [PosXlink,PosYlink] = rot(Linkx,Linky,u(7));
%       PosXlink = PosXlink + u(5);
%       PosYlink = PosYlink + u(6);

%% 1 link
%       PosXlink = [ PosXlaxle(1) ; PosXlaxle2(2) ];
%       PosYlink = [ PosYlaxle(1) ; PosYlaxle2(2) ];

%% 2 links
      PosXlink = [ PosXlaxle(1) ; PosXtrailer(3) ];
      PosYlink = [ PosYlaxle(1) ; PosYtrailer(3) ];
      PosXlink2 = [ PosXlaxle(1) ; PosXtrailer(4) ];
      PosYlink2 = [ PosYlaxle(1) ; PosYtrailer(4) ];

%%

      set(hndlList(1),'XData',PosXcar,'YData',PosYcar);
      set(hndlList(2),'XData',PosXraxle,'YData',PosYraxle);
      set(hndlList(3),'XData',PosXlaxle,'YData',PosYlaxle);
      set(hndlList(4),'XData',PosXfaxle,'YData',PosYfaxle);
      set(hndlList(5),'XData',PosXwlr,'YData',PosYwlr);
      set(hndlList(6),'XData',PosXwrr,'YData',PosYwrr);
      set(hndlList(7),'XData',PosXwlf,'YData',PosYwlf);
      set(hndlList(8),'XData',PosXwrf,'YData',PosYwrf);
      %% trailer
      set(hndlList(9),'XData',PosXtrailer,'YData',PosYtrailer);
      set(hndlList(10),'XData',PosXmaxle2,'YData',PosYmaxle2);
      set(hndlList(11),'XData',PosXlaxle2,'YData',PosYlaxle2);
      set(hndlList(12),'XData',PosXwl2,'YData',PosYwl2);
      set(hndlList(13),'XData',PosXwr2,'YData',PosYwr2);

      %% link
      set(hndlList(14),'XData',PosXlink,'YData',PosYlink);
      set(hndlList(15),'XData',PosXlink2,'YData',PosYlink2);

      %% Path to follow
      POSpathx=u(8);
      POSpathy=u(9);
      set(hndlList(16),'XData',POSpathx,'YData',POSpathy);

      %% Path error
      PosXerror = [ POSpathx ; u(5) ];
      PosYerror = [ POSpathy ; u(6) ];

      set(hndlList(17),'XData',PosXerror,'YData',PosYerror);

      drawnow;
    end
  end
  sys=[];
  set(0,'ShowHiddenHandles',shh);    %restore the hidden property
elseif flag==0,
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Initialization (flag==0) %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

  % Initialize the figure for use with this simulation
   [CarLikeAnim, Axes] = animinit('Car-Like Robot'); % ANIMINIT Initializes a figure for Simulink animations.

  %[flag,CarLikeAnim] = figflag('Car-Like Robot',1);
	% FIGFLAG True if figure is currently displayed on screen.
   %  [FLAG,FIG] = FIGFLAG(STR,SILENT) checks to see if any figure 
   %  with Name STR is presently on the screen. If such a figure is 
   %  presently on the screen, FLAG=1, else FLAG=0.  If SILENT=0, the
   %  figures are brought to the front.
 
   %  This function is OBSOLETE and may be removed in future versions.
    shh = get(0,'ShowHiddenHandles');
  set(0,'ShowHiddenHandles','on');
   figure(CarLikeAnim);
  
  %% axis for waving up
  axis(Axes,[-15 30 -15 30], 'on');

  %% axis for circling down
%   axis(Axes,[-5 10 -10 5], 'on');

  %% axis for cosinus parking
%   axis(Axes,[-5 25 -5 5], 'on');

  grid on
	% AXIS([XMIN XMAX YMIN YMAX]) sets scaling for the x- and y-axes
   %     on the current plot.

  hold(Axes,'on');
	% HOLD ON holds the current plot and all axis properties so that
   %  subsequent graphing commands add to the existing graph.
   
  %% Draw the parking spot for cosinus
%   plot(Axes,[16 21 21 16 21 21 16 21 21 16],[-1 -1 1 1 1 3 3 3 -3 -3],'black', ...
%        'LineWidth',2); 


  %% Draw the parking spot
%   plot(Axes,[-1 2 2 -1 -1]+2,[-1 -1 1 1 -1]+4.5,'black', ...
%        'LineWidth',2); 



  t=linspace(0,25,1000);

  %% cosinus curve 
%   t1=linspace(0,pi,100*pi);
%   t2=linspace(pi,3*pi,100*(3*pi-pi));
%   t3=linspace(3*pi,10,100*(10-3*pi));
%   y1=0.*t1;
%   x1=2.*t1;
%   y2= cos(t2)-cos(t1(end));
%   x2= 2.*t2;
%   y3=0.*t3;
%   x3=2.*t3;
%   x=cat(2,x1,x2,x3);
%   y=cat(2,y1,y2,y3);
  
  %% circle curve 
%   t1=linspace(0,1,100*1);
%   t2=linspace(1,25,100*(25-1));
%   y1=0.*t1;
%   x1=3.*t1;
%   y2= 3.*cos(t2-t1(end)) - 3;
%   x2= 3.* sin(t2-t1(end)) + x1(end);
%   x=cat(2,x1,x2);
%   y=cat(2,y1,y2);


  %% waving up curve
%   t1=linspace(0,pi,100*pi);
%   t2=linspace(pi,25,100*(25-pi));
%   y1=0.*t1;
%   x1=2*t1;
%   y2=sin(t2) + t2 - pi;
%   x2=-sin(t2)+ t2 + pi;
%   x=cat(2,x1,x2);
%   y=cat(2,y1,y2);
% 
%   plot(Axes,x,y,'black', ...
%        'LineWidth',2); 

%   xx=u(8);
%   yy=u(9);
%   plot(Axes,xx,yy,'black', ...
%        'LineWidth',2); 
	   
  %hndlList(1)= fill(Xcar,Ycar,'b');
  %hndlList(2)= fill(Xwlr,Ywlr,'y');
  %hndlList(3)= fill(Xwrr,Ywrr,'y');  
  %hndlList(4)= fill(Xwlf,Ywlf,'y');
  %hndlList(5)= fill(Xwrf,Ywrf,'y');
  hndlList(1)= fill(Xcar,Ycar,'y','LineWidth',1);
  hndlList(2)= plot(Axes,Xraxle,Yraxle,'k','LineWidth',1.5);
  hndlList(3)= plot(Axes,Xlaxle,Ylaxle,'k','LineWidth',1.5);
  hndlList(4)= plot(Axes,Xfaxle,Yfaxle,'k','LineWidth',1.5);
  hndlList(5)= fill(Xwlf,Ywlf,'r','LineWidth',1);
  hndlList(6)= fill(Xwlr,Ywlr,'r','LineWidth',1);
  hndlList(7)= fill(Xwrr,Ywrr,'r','LineWidth',1);  
  hndlList(8)= fill(Xwrf,Ywrf,'r','LineWidth',1);

  %% trailer
  hndlList(9)= fill(Xcar,Ycar,'y','LineWidth',1);
  hndlList(10)= plot(Axes,Xmaxle2,Ymaxle2,'k','LineWidth',1.5);
  hndlList(11)= plot(Axes,Xlaxle2,Ylaxle2,'k','LineWidth',1.5);
  hndlList(12)= fill(Xwl2,Ywl2,'r','LineWidth',1);
  hndlList(13)= fill(Xwr2,Ywr2,'r','LineWidth',1);  
  %% link
  hndlList(14)= plot(Axes,Linkx,Linky,'k','LineWidth',1.5);
  hndlList(15)= plot(Axes,Linkx2,Linky2,'k','LineWidth',1.5);

  hndlList(16)= plot(Axes,pathx,pathy,'.','MarkerSize',20);

  hndlList(17)= plot(Axes,errorx,errory,'r','LineWidth',1.5);

  %% other cars for obstacles
%   hndlList(18)= fill(Xcar_car2,Ycar_car2,'y','LineWidth',1);
%   hndlList(19)= plot(Axes,Xraxle_car2,Yraxle_car2,'k','LineWidth',1.5);
%   hndlList(20)= plot(Axes,Xlaxle_car2,Ylaxle_car2,'k','LineWidth',1.5);
%   hndlList(21)= plot(Axes,Xfaxle_car2,Yfaxle_car2,'k','LineWidth',1.5);
%   hndlList(22)= fill(Xwlf_car2,Ywlf_car2,'r','LineWidth',1);
%   hndlList(23)= fill(Xwlr_car2,Ywlr_car2,'r','LineWidth',1);
%   hndlList(24)= fill(Xwrr_car2,Ywrr_car2,'r','LineWidth',1);  
%   hndlList(25)= fill(Xwrf_car2,Ywrf_car2,'r','LineWidth',1);
% 
%   hndlList(26)= fill(Xcar_car3,Ycar_car3,'y','LineWidth',1);
%   hndlList(27)= plot(Axes,Xraxle_car3,Yraxle_car3,'k','LineWidth',1.5);
%   hndlList(28)= plot(Axes,Xlaxle_car3,Ylaxle_car3,'k','LineWidth',1.5);
%   hndlList(29)= plot(Axes,Xfaxle_car3,Yfaxle_car3,'k','LineWidth',1.5);
%   hndlList(30)= fill(Xwlf_car3,Ywlf_car3,'r','LineWidth',1);
%   hndlList(31)= fill(Xwlr_car3,Ywlr_car3,'r','LineWidth',1);
%   hndlList(32)= fill(Xwrr_car3,Ywrr_car3,'r','LineWidth',1);  
%   hndlList(33)= fill(Xwrf_car3,Ywrf_car3,'r','LineWidth',1);
% 
%   hndlList(34)= fill(Xcar_car4,Ycar_car4,'y','LineWidth',1);
%   hndlList(35)= plot(Axes,Xraxle_car4,Yraxle_car4,'k','LineWidth',1.5);
%   hndlList(36)= plot(Axes,Xlaxle_car4,Ylaxle_car4,'k','LineWidth',1.5);
%   hndlList(37)= plot(Axes,Xfaxle_car4,Yfaxle_car4,'k','LineWidth',1.5);
%   hndlList(38)= fill(Xwlf_car4,Ywlf_car4,'r','LineWidth',1);
%   hndlList(39)= fill(Xwlr_car4,Ywlr_car4,'r','LineWidth',1);
%   hndlList(40)= fill(Xwrr_car4,Ywrr_car4,'r','LineWidth',1);  
%   hndlList(41)= fill(Xwrf_car4,Ywrf_car4,'r','LineWidth',1);
% 
%   hndlList(42)= fill(Xcar_car5,Ycar_car5,'y','LineWidth',1);
%   hndlList(43)= plot(Axes,Xraxle_car5,Yraxle_car5,'k','LineWidth',1.5);
%   hndlList(44)= plot(Axes,Xlaxle_car5,Ylaxle_car5,'k','LineWidth',1.5);
%   hndlList(45)= plot(Axes,Xfaxle_car5,Yfaxle_car5,'k','LineWidth',1.5);
%   hndlList(46)= fill(Xwlf_car5,Ywlf_car5,'r','LineWidth',1);
%   hndlList(47)= fill(Xwlr_car5,Ywlr_car5,'r','LineWidth',1);
%   hndlList(48)= fill(Xwrr_car5,Ywrr_car5,'r','LineWidth',1);  
%   hndlList(49)= fill(Xwrf_car5,Ywrf_car5,'r','LineWidth',1);
% 
%   hndlList(50)= fill(Xcar_car6,Ycar_car6,'y','LineWidth',1);
%   hndlList(51)= plot(Axes,Xraxle_car6,Yraxle_car6,'k','LineWidth',1.5);
%   hndlList(52)= plot(Axes,Xlaxle_car6,Ylaxle_car6,'k','LineWidth',1.5);
%   hndlList(53)= plot(Axes,Xfaxle_car6,Yfaxle_car6,'k','LineWidth',1.5);
%   hndlList(54)= fill(Xwlf_car6,Ywlf_car6,'r','LineWidth',1);
%   hndlList(55)= fill(Xwlr_car6,Ywlr_car6,'r','LineWidth',1);
%   hndlList(56)= fill(Xwrr_car6,Ywrr_car6,'r','LineWidth',1);  
%   hndlList(57)= fill(Xwrf_car6,Ywrf_car6,'r','LineWidth',1);

  set(Axes,'DataAspectRatio',[ 1  1  1 ]);
  set(Axes,'UserData',hndlList);

  sys = [ 0  0  0  9  0  0 ];
  x0 = [];
 set(0,'ShowHiddenHandles',shh);  %restore the hidden property
end
% End of function robotelbowanim

% function "rot" that rotates a graphical object
function [PosX,PosY] = rot(X,Y,angle)

dim = size(X,1);

Mrot = [ cos(angle) -sin(angle)  ;
         sin(angle)  cos(angle) ]; 

for i=1:dim
    Pos_i = Mrot * [ X(i,1) ; Y(i,1) ];
    PosX(i,1) = Pos_i(1,1);
    PosY(i,1) = Pos_i(2,1);
end
