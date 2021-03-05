% OPTIMISER

close
clear
clc

%%                                    |---->                                                                                                                                                                                                                                                                                                                                                                                                     <-----|     Twist_root   kink      tip     L/D      MTOW     W_fuel     

%%      X(1)    X(2)            X(3)           X(4)            X(5)               X(6)               X(7)                X(8)               X(9)               X(10)              X(11)               X(12)       X(13)       X(14)       X(15)       X(16)      X(17)     X(18)     X(19)    X(20)    X(21)    X(22)        X(23)       X(24)       X(25)       X(26)       X(27)        X(28)      X(29)       X(30)       X(31)       X(32)      X(33)       X(34)      X(35)       X(36)       X(37)           X(38)      X(39)       X(40)      X(41)        X(42)     X(43)   X(44)    X(45)    X(46)
      
% X0 =  [ 7.00 ,  8.83886  , 10.27   ,16.95,	  0.171532967973578,0.401179832933232,0.0531848086076108,0.497431745457744,0.100368626946100,0.300641902860719,-0.111985423009203,-0.188888116471069,0.0228509335166110,-0.112488997348303,0.0598958966755855,-0.0827224147205521,0.165304052301377,0.122879445800336,0.185189183026725,0.162592899064516,0.234377843933174,0.171125701924061,-0.0476912070163436,-0.0597546459872032,0.0123870699588853,-0.170646646065291,0.109334630114753,0.0527239039499488,0.168418510137478,0.262029639366784,0.119186995817168,0.330012322261130,0.167373235439637,0.235883802392390,-0.0798383150127733,-0.124321381229136,0.0176190017377482,-0.141567821706797,0.0846152633951693,-0.0149992553853016,    0 ,   0  ,   0 ,     16   ,    89000 ,   24600];
X0 =  [ 7.00 ,  8.83886  ,      10.27   ,      16.95,	       0.171532967973578, 0.401179832933232, 0.0531848086076108, 0.497431745457744, 0.100368626946100, 0.300641902860719, -0.111985423009203, -0.188888116471069, 0.0228509335166110, -0.112488997348303, 0.0598958966755855, -0.0827224147205521, 0.165304052301377, 0.122879445800336, 0.185189183026725, 0.162592899064516, 0.234377843933174, 0.171125701924061, -0.0476912070163436, -0.0597546459872032, 0.0123870699588853,-0.170646646065291, 0.109334630114753, 0.0527239039499488, 0.168418510137478, 0.262029639366784, 0.119186995817168, 0.330012322261130, 0.167373235439637, 0.235883802392390, -0.0798383150127733, -0.124321381229136, 0.0176190017377482,  -0.141567821706797, 0.0846152633951693, -0.0149992553853016,    0 ,       0  ,  0  ,    16   ,    89000 ,       24600];

Ain = [ 0       1              -1               0              0                  0                  0                   0                  0                  0                   0                   0                  0                    0                  0                    0                   0                  0                  0                  0                  0                  0                   0                    0                   0                   0                  0                  0                   0                  0                  0                  0                  0                   0                  0                    0                  0                     0                  0                    0                      0         0     0       0         0             0;       % tip chord > 0
       -1      -1+0.37          1               0              0                  0                  0                   0                  0                  0                   0                   0                  0                    0                  0                    0                   0                  0                  0                  0                  0                  0                   0                    0                   0                   0                  0                  0                   0                  0                  0                  0                  0                   0                  0                    0                  0                     0                  0                    0                      0         0     0       0         0             0;       % Tip < kink
      ];

Bin =[0 0];

% LB=[   5       7      8        15      0.01    0.01        0.01       0.01     0.01    0.01   -0.5     -0.5        -0.5        -0.5    -0.5    -0.5        0.01   -0.1      -0.1      -0.1         0.01   0.01   -0.5     -0.5       -0.5        -0.5    -0.5    -0.5      0.01   0.01       0.01       0.01     0.01   0.01   -0.5     -0.5        -0.5        -0.5    -0.5    -0.5      0     -3      -5     16     0.95*89000      0.8*24600];
% UB=[   8      10     12        19      0.5     0.5         0.5         0.5     0.5     0.5    -0.01    -0.01      0.1       0.01      0.1   0.01       0.5      0.5         0.5         0.5       0.5     0.5   -0.01    -0.01     0.1         0.01     0.2     0.1       0.5     0.5         0.5         0.5        0.5     0.5     -0.01    0            0.1           0.1     0.2     0.1    0     0       0       20     1.01*89000      1.01*24600];

LB=[   0.8*7    0.8*8.83886     0.8*10.27       0.8*16.95      0.01               0.01              0.01                 0.01              0.01                0.01               -0.5                -0.5                -0.3                -0.5               -0.3                 -0.5                 0.01               0.01               0.01               0.01               0.01               0.01               -0.5                 -0.5                -0.5               -0.5                0.01               -0.1                 0.01               0.01               0.01               0.01               0.01                0.01              -0.5                 -0.5                0.01                 -0.5                0.01                 -0.5                   -0.1     -3    -10     0.9*16     0.95*89000    0.80*24600];
UB=[   1.2*7    1.2*8.83886     1.2*10.27       1.2*16.95      0.5                0.8               0.2                  0.8               0.5                 0.6                -0.01               -0.01                0.3                 0.01               0.5                  0.01                0.5                0.5                 0.5                0.5                0.6                0.5                 0.1                  0.1                 0.3                0.01               0.5                 0.5                 0.5                0.5                0.5                0.6                0.5                 0.5                0.01                 0.1                0.5                  0.1                0.5                   0.1                    0.1      1      1     1.3*16     1.01*89000    1.01*24600];

OPTIONS = optimset('display','iter-detailed','DiffMaxChange', 0.03, 'DiffMinChange', 0.01, 'MaxIter', 90,'TolFun',1e-3,'TolCon',5e-3,'PlotFcns', {@optimplotfval, @optimplotconstrviolation, @optimplotx, @optimplotstepsize, @optimplotfirstorderopt, @optimplotfunccount});

scale=[7.00  8.83886  10.27  16.95   0.1   0.1   0.1   0.1   0.1   0.1     0.1   0.1   0.1   0.1   0.1   0.1   0.1   0.1   0.1   0.1   0.1   0.1     0.1   0.1   0.1   0.1   0.1   0.1  0.1   0.1   0.1   0.1   0.1   0.1     0.1   0.1   0.1   0.1   0.1   0.1 10 10 10 16 89000 24600];

X0=X0./scale;
LB=LB./scale;
UB=UB./scale;

tic

fileID = fopen('constraint_violation.txt','w');
fprintf(fileID,'%s \n','Constraint');
fclose(fileID);

fileID = fopen('design.txt','w');
fprintf(fileID,'%s \n','Design vector');
fclose(fileID);

[X,FVAL,EXITFLAG]=fmincon('objective',X0,Ain,Bin,[],[],LB,UB,'nlc', OPTIONS);

toc