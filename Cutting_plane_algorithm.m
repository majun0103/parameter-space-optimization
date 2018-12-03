%% Cutting plane algorithm
clc
clear all
close all
warning off


%% Model dynamics
Kf = 62.8;
Gamma = 172.7;
M1 = 16.5;
M2 = 18.4;
f1 = 0.1193;
f2 = 0.1544;


%% Perturbation
per = 20;

M11 = (1+per/100)*M1;
M12 = (1-per/100)*M1;
M21 = (1+per/100)*M2;
M22 = (1-per/100)*M2;


%% For simulation purpose
% Case 1 (nominal model)
A0 = [0 1 0 0;...
      0 -Gamma/M1 0 0;...
      0 0 0 1;...
      0 0 0 -Gamma/M2];

B20 = [0 0 0;...
       Kf/M1 0 1/M1;...
       0 0 0;...
       0 Kf/M2 -1/M2];

B10 = [0; -f1/M1; 0; -f2/M2];

% Case 2 (perturbed model with M1=1.1 M1;M2=1.1M2)
A0_perper = [0 1 0 0;...
             0 -Gamma/M11 0 0;...
             0 0 0 1;...
             0 0 0 -Gamma/M21];

B20_perper = [0 0 0;...
              Kf/M11 0 1/M11;...
              0 0 0;...
              0 Kf/M21 -1/M21];

B10_perper = [0; -f1/M11; 0; -f2/M21];

% Case 3 (perturbed model with M1=0.9 M1;M2=1.1 M2)
A0_perperper = [0 1 0 0;...
                0 -Gamma/M12 0 0;...
                0 0 0 1;...
                0 0 0 -Gamma/M21];

B20_perperper = [0 0 0;...
                 Kf/M12 0 1/M12;...
                 0 0 0;...
                 0 Kf/M21 -1/M21];

B10_perperper = [0; -f1/M12; 0; -f2/M21];

% Case 4 (perturbed model with M1=1.1 M1;M2=0.9 M2)
A0_perperperper = [0 1 0 0;...
                   0 -Gamma/M11 0 0;...
                   0 0 0 1;...
                   0 0 0 -Gamma/M22];

B20_perperperper = [0 0 0;...
                    Kf/M11 0 1/M11;...
                    0 0 0;...
                    0 Kf/M22 -1/M22];

B10_perperperper = [0; -f1/M11; 0; -f2/M22];

%% Original system
A = [0 1 0 0 0 0;...
     0 0 1 0 0 0;...
     0 0 -Gamma/M1 0 0 0;...
     0 0 0 0 1 0;...
     0 0 0 0 0 1;...
     0 0 0 0 0 -Gamma/M2];

B2 = [0 0 0;...
      0 0 0;...
      Kf/M1 0 1/M1;...
      0 0 0;...
      0 0 0;...
      0 Kf/M2 -1/M2];

B1 = [0; 0; -f1/M1; 0; 0; -f2/M2];

rank([B2 A*B2 A^2*B2 A^3*B2 A^4*B2 A^5*B2]); 

%% Original perturbed system
% 1st perturbation
A_per1 = [0 1 0 0 0 0;...
          0 0 1 0 0 0;...
          0 0 -Gamma/M11 0 0 0;...
          0 0 0 0 1 0;...
          0 0 0 0 0 1;...
          0 0 0 0 0 -Gamma/M21];

B2_per1 = [0 0 0;...
           0 0 0;...
           Kf/M11 0 1/M11;...
           0 0 0;...
           0 0 0;...
           0 Kf/M21 -1/M21];

B1_per1 = [0; 0; -f1/M11; 0; 0; -f2/M21];

% 2nd perturbation
A_per2 = [0 1 0 0 0 0;...
          0 0 1 0 0 0;...
          0 0 -Gamma/M11 0 0 0;...
          0 0 0 0 1 0;...
          0 0 0 0 0 1;...
          0 0 0 0 0 -Gamma/M22];

B2_per2 = [0 0 0;...
           0 0 0;...
           Kf/M11 0 1/M11;...
           0 0 0;...
           0 0 0;...
           0 Kf/M22 -1/M22];

B1_per2 = [0; 0; -f1/M11; 0; 0; -f2/M22];

% 3rd perturbation
A_per3 = [0 1 0 0 0 0;...
          0 0 1 0 0 0;...
          0 0 -Gamma/M12 0 0 0;...
          0 0 0 0 1 0;...
          0 0 0 0 0 1;...
          0 0 0 0 0 -Gamma/M21];

B2_per3 = [0 0 0;...
           0 0 0;...
           Kf/M12 0 1/M12;...
           0 0 0;...
           0 0 0;...
           0 Kf/M21 -1/M21];

B1_per3 = [0; 0; -f1/M12; 0; 0; -f2/M21];

% 4th perturbation
A_per4 = [0 1 0 0 0 0;...
          0 0 1 0 0 0;...
          0 0 -Gamma/M12 0 0 0;...
          0 0 0 0 1 0;...
          0 0 0 0 0 1;...
          0 0 0 0 0 -Gamma/M22];

B2_per4 = [0 0 0;...
           0 0 0;...
           Kf/M12 0 1/M12;...
           0 0 0;...
           0 0 0;...
           0 Kf/M22 -1/M22];

B1_per4 = [0; 0; -f1/M12; 0; 0; -f2/M22];


%% Extended precise-known system
A_bar = [A zeros(6,2); [0 0 1 0 0 0;0 0 0 0 0 1] zeros(2,2)];

B2_bar = [B2; zeros(2,3)];

B1_bar = [B1; zeros(2,1)];

rank([B2_bar A_bar*B2_bar A_bar^2*B2_bar A_bar^3*B2_bar A_bar^4*B2_bar A_bar^5*B2_bar  A_bar^6*B2_bar  A_bar^7*B2_bar]); 


%% Extended perturbed system
% 1st perturbation
A_bar1 = [A_per1 zeros(6,2); [0 0 1 0 0 0;0 0 0 0 0 1] zeros(2,2)];

B2_bar1 = [B2_per1; zeros(2,3)];

B1_bar1 = [B1_per1; zeros(2,1)];

% 2nd perturbation
A_bar2 = [A_per2 zeros(6,2); [0 0 1 0 0 0;0 0 0 0 0 1] zeros(2,2)];

B2_bar2 = [B2_per2; zeros(2,3)];

B1_bar2 = [B1_per2; zeros(2,1)];

% 3rd perturbation
A_bar3 = [A_per3 zeros(6,2); [0 0 1 0 0 0;0 0 0 0 0 1] zeros(2,2)];

B2_bar3 = [B2_per3; zeros(2,3)];

B1_bar3 = [B1_per3; zeros(2,1)];

% 4th perturbation
A_bar4 = [A_per4 zeros(6,2); [0 0 1 0 0 0;0 0 0 0 0 1] zeros(2,2)];

B2_bar4 = [B2_per4; zeros(2,3)];

B1_bar4 = [B1_per4; zeros(2,1)];


%% Controlled output associated matrices for extended system
C_bar = 1*[1 0 0 0 0 0 0 0; 0 0 0 1 0 0 0 0; zeros(3,8)];  
D_bar = 1*[zeros(2,3); eye(3)];


%% Transformation matrix
H = [eye(6) zeros(6,2); zeros(1,6) [1 -1]];


%% Extended matrices
F = [A_bar -B2_bar; zeros(3,11)];
G = [zeros(8,3); eye(3)];
Q = [B1_bar*B1_bar' zeros(8,3); zeros(3,8) zeros(3,3)];
R = [C_bar'*C_bar zeros(8,3); zeros(3,8) D_bar'*D_bar];


%% Perturbed extended matrices
F1 = [A_bar1 -B2_bar1; zeros(3,11)];
F2 = [A_bar2 -B2_bar2; zeros(3,11)];
F3 = [A_bar3 -B2_bar3; zeros(3,11)];
F4 = [A_bar4 -B2_bar4; zeros(3,11)];

Q1 = [B1_bar1*B1_bar1' zeros(8,3); zeros(3,8) zeros(3,3)];
Q2 = [B1_bar2*B1_bar2' zeros(8,3); zeros(3,8) zeros(3,3)];
Q3 = [B1_bar3*B1_bar3' zeros(8,3); zeros(3,8) zeros(3,3)];
Q4 = [B1_bar4*B1_bar4' zeros(8,3); zeros(3,8) zeros(3,3)];

%% Structure of W
syms w1 w2 w3 w4 w5 w6 w7 w8 w9 w10 w11
syms w12 w13 w14 w15 w16 w17 w18 w19 w20 w21 w22
syms w23 w24 w25 w26 w27 w28 w29 w30 w31 w32 w33
syms w34 w35 w36 w37 w38 w39 w40 w41 w42 w43 w44
syms w45 w46 w47 w48 w49 w50 w51 w52 w53 w54 w55
syms w56 w57 w58 w59 w60 w61 w62 w63 w64 w65 w66
syms w67 w68 w69 w70 w71 w72 w73 w74 w75 w76 w77
syms w78 w79 w80 w81 w82 w83 w84 w85 w86 w87 w88
syms w89 w90 w91 w92 w93 w94 w95 w96 w97 w98 w99
syms w100 w101 w102 w103 w104 w105 w106 w107 w108 w109 w110
syms w111 w112 w113 w114 w115 w116 w117 w118 w119 w120 w121

W = [w1 w2 w3 w4 w5 w6 w7 w8 w9 w10 w11;...
     w12 w13 w14 w15 w16 w17 w18 w19 w20 w21 w22;...
     w23 w24 w25 w26 w27 w28 w29 w30 w31 w32 w33;...
     w34 w35 w36 w37 w38 w39 w40 w41 w42 w43 w44;...
     w45 w46 w47 w48 w49 w50 w51 w52 w53 w54 w55;...
     w56 w57 w58 w59 w60 w61 w62 w63 w64 w65 w66;...
     w67 w68 w69 w70 w71 w72 w73 w74 w75 w76 w77;...
     w78 w79 w80 w81 w82 w83 w84 w85 w86 w87 w88;...
     w89 w90 w91 w92 w93 w94 w95 w96 w97 w98 w99;...
     w100 w101 w102 w103 w104 w105 w106 w107 w108 w109 w110;...
     w111 w112 w113 w114 w115 w116 w117 w118 w119 w120 w121];


%% Step 1: 
% zero elements (84)
A1 = [zeros(1,3),1,zeros(1,117)];
A2 = [zeros(1,4),1,zeros(1,116)];
A3 = [zeros(1,5),1,zeros(1,115)];
A4 = [zeros(1,6),1,zeros(1,114)];
A5 = [zeros(1,7),1,zeros(1,113)];
A6 = [zeros(1,9),1,zeros(1,111)];
A7 = [zeros(1,10),1,zeros(1,110)];
A8 = [zeros(1,14),1,zeros(1,106)];
A9 = [zeros(1,15),1,zeros(1,105)];
A10 = [zeros(1,16),1,zeros(1,104)];
A11 = [zeros(1,17),1,zeros(1,103)];
A12 = [zeros(1,18),1,zeros(1,102)];
A13 = [zeros(1,20),1,zeros(1,100)];
A14 = [zeros(1,21),1,zeros(1,99)];
A15 = [zeros(1,25),1,zeros(1,95)];
A16 = [zeros(1,26),1,zeros(1,94)];
A17 = [zeros(1,27),1,zeros(1,93)];
A18 = [zeros(1,28),1,zeros(1,92)];
A19 = [zeros(1,29),1,zeros(1,91)];
A20 = [zeros(1,31),1,zeros(1,89)];
A21 = [zeros(1,32),1,zeros(1,88)];

A22 = [zeros(1,33),1,zeros(1,87)];
A23 = [zeros(1,34),1,zeros(1,86)];
A24 = [zeros(1,35),1,zeros(1,85)];
A25 = [zeros(1,39),1,zeros(1,81)];
A26 = [zeros(1,40),1,zeros(1,80)];
A27 = [zeros(1,41),1,zeros(1,79)];
A28 = [zeros(1,43),1,zeros(1,77)];
A29 = [zeros(1,44),1,zeros(1,76)];
A30 = [zeros(1,45),1,zeros(1,75)];
A31 = [zeros(1,46),1,zeros(1,74)];
A32 = [zeros(1,50),1,zeros(1,70)];
A33 = [zeros(1,51),1,zeros(1,69)];
A34 = [zeros(1,52),1,zeros(1,68)];
A35 = [zeros(1,54),1,zeros(1,66)];
A36 = [zeros(1,55),1,zeros(1,65)];
A37 = [zeros(1,56),1,zeros(1,64)];
A38 = [zeros(1,57),1,zeros(1,63)];
A39 = [zeros(1,61),1,zeros(1,59)];
A40 = [zeros(1,62),1,zeros(1,58)];
A41 = [zeros(1,63),1,zeros(1,57)];
A42 = [zeros(1,65),1,zeros(1,55)];

A43 = [zeros(1,66),1,zeros(1,54)];
A44 = [zeros(1,67),1,zeros(1,53)];
A45 = [zeros(1,68),1,zeros(1,52)];
A46 = [zeros(1,69),1,zeros(1,51)];
A47 = [zeros(1,70),1,zeros(1,50)];
A48 = [zeros(1,71),1,zeros(1,49)];
A49 = [zeros(1,74),1,zeros(1,46)];
A50 = [zeros(1,75),1,zeros(1,45)];
A51 = [zeros(1,77),1,zeros(1,43)];
A52 = [zeros(1,78),1,zeros(1,42)];
A53 = [zeros(1,79),1,zeros(1,41)];
A54 = [zeros(1,80),1,zeros(1,40)];
A55 = [zeros(1,81),1,zeros(1,39)];
A56 = [zeros(1,82),1,zeros(1,38)];
A57 = [zeros(1,85),1,zeros(1,35)];
A58 = [zeros(1,86),1,zeros(1,34)];

A59 = [zeros(1,91),1,zeros(1,29)];
A60 = [zeros(1,92),1,zeros(1,28)];
A61 = [zeros(1,93),1,zeros(1,27)];
A62 = [zeros(1,94),1,zeros(1,26)];
A63 = [zeros(1,95),1,zeros(1,25)];
A64 = [zeros(1,99),1,zeros(1,21)];
A65 = [zeros(1,100),1,zeros(1,20)];
A66 = [zeros(1,101),1,zeros(1,19)];
A67 = [zeros(1,105),1,zeros(1,15)];
A68 = [zeros(1,106),1,zeros(1,14)];
A69 = [zeros(1,110),1,zeros(1,10)];
A70 = [zeros(1,111),1,zeros(1,9)];
A71 = [zeros(1,112),1,zeros(1,8)];
A72 = [zeros(1,113),1,zeros(1,7)];
A73 = [zeros(1,114),1,zeros(1,6)];
A74 = [zeros(1,115),1,zeros(1,5)];

% Symmetric
A75 = [zeros(1,1) 1 zeros(1,9) -1 zeros(1,109)];
A76 = [zeros(1,2) 1 zeros(1,19) -1 zeros(1,98)];
A77 = [zeros(1,13) 1 zeros(1,9) -1 zeros(1,97)];
A78 = [zeros(1,37) 1 zeros(1,9) -1 zeros(1,73)];
A79 = [zeros(1,38) 1 zeros(1,19) -1 zeros(1,62)];
A80 = [zeros(1,49) 1 zeros(1,9) -1 zeros(1,61)];
A81 = [zeros(1,73) 1 zeros(1,9) -1 zeros(1,37)];

A82 = [zeros(1,8) 1 zeros(1,79) -1 zeros(1,32)];
A83 = [zeros(1,19) 1 zeros(1,69) -1 zeros(1,31)];
A84 = [zeros(1,30) 1 zeros(1,59) -1 zeros(1,30)];
A85 = [zeros(1,42) 1 zeros(1,59) -1 zeros(1,18)];
A86 = [zeros(1,53) 1 zeros(1,49) -1 zeros(1,17)];
A87 = [zeros(1,64) 1 zeros(1,39) -1 zeros(1,16)];
A88 = [zeros(1,76) 1 zeros(1,39) -1 zeros(1,4)];
A89 = [zeros(1,87) 1 zeros(1,29) -1 zeros(1,3)];

A90 = [zeros(1,97) 1 zeros(1,9) -1 zeros(1,13)];
A91 = [zeros(1,98) 1 zeros(1,19) -1 zeros(1,2)];
A92 = [zeros(1,109) 1 zeros(1,9) -1 zeros(1,1)];

% Equality constraint
Aeq = [A1;A2;A3;A4;A5;A6;A7;A8;A9;A10;...
       A11;A12;A13;A14;A15;A16;A17;A18;A19;A20;...
       A21;A22;A23;A24;A25;A26;A27;A28;A29;A30;...
       A31;A32;A33;A34;A35;A36;A37;A38;A39;A40;...
       A41;A42;A43;A44;A45;A46;A47;A48;A49;A50;...
       A51;A52;A53;A54;A55;A56;A57;A58;A59;A60;...
       A61;A62;A63;A64;A65;A66;A67;A68;A69;A70;...
       A71;A72;A73;A74;A75;A76;A77;A78;A79;A80;...
       A81;A82;A83;A84;A85;A86;A87;A88;A89;A90;...
       A91;A92];

beq = zeros(1,92);

indicator = zeros(92,1);   % -1 means <, 0 means =

% Lower bound and upper bound (W_ii>=0)
lb = [0,-inf(1,11),0,-inf(1,11),0,-inf(1,11),0,-inf(1,11),0,-inf(1,11),0,-inf(1,11),0,-inf(1,11),0,-inf(1,11),0,-inf(1,11),0,-inf(1,11),0];
ub = [inf(1,121)];

% Objective function  trace(R*W)
f = -[1 zeros(1,35) 1 zeros(1,59) 1 zeros(1,11) 1 zeros(1,11) 1];

sum_W = w1+w2+w3+w4+w5+w6+w7+w8+w9+w10+w11+w12+w13+w14+w15+w16+w17+w18+w19+w20+w21+w22+w23+w24+w25+w26+w27+w28+w29+w30+w31+w32+w33+w34+w35+w36+w37+w38+w39+w40+w41+w42+w43+w44+w45+w46+w47+w48+w49+w50+w51+w52+w53+w54+w55+w56+w57+w58+w59+w60+w61+w62+w63+w64+w65+w66+w67+w68+w69+w70+w71+w72+w73+w74+w75+w76+w77+w78+w79+w80+w81+w82+w83+w84+w85+w86+w87+w88+w89+w90+w91+w92+w93+w94+w95+w96+w97+w98+w99+w100+w101+w102+w103+w104+w105+w106+w107+w108+w109+w110+w111+w112+w113+w114+w115+w116+w117+w118+w119+w120+w121;
delta = eps*sum_W*10;
bound_vector = 0;


%% Start iteration
for i=1:400
    i
    
%% Linear programming 
lp = lp_maker(f, Aeq, beq, indicator, lb, ub);  % -1 means <, 0 means =
solvestat = mxlpsolve('solve', lp);
obj = mxlpsolve('get_objective', lp);
x = mxlpsolve('get_variables', lp);
mxlpsolve('delete_lp', lp);

% Recover the Wl from optimization results
Wl = [ x(1) x(2) x(3) x(4) x(5) x(6) x(7) x(8) x(9) x(10) x(11) ;...
       x(12) x(13) x(14) x(15) x(16) x(17) x(18) x(19) x(20) x(21) x(22) ;...
       x(23) x(24) x(25) x(26) x(27) x(28) x(29) x(30) x(31) x(32) x(33) ;...
       x(34) x(35) x(36) x(37) x(38) x(39) x(40) x(41) x(42) x(43) x(44) ;...
       x(45) x(46) x(47) x(48) x(49) x(50) x(51) x(52) x(53) x(54) x(55) ;...
       x(56) x(57) x(58) x(59) x(60) x(61) x(62) x(63) x(64) x(65) x(66) ;...
       x(67) x(68) x(69) x(70) x(71) x(72) x(73) x(74) x(75) x(76) x(77) ;...
       x(78) x(79) x(80) x(81) x(82) x(83) x(84) x(85) x(86) x(87) x(88) ;...
       x(89) x(90) x(91) x(92) x(93) x(94) x(95) x(96) x(97) x(98) x(99) ;...
       x(100) x(101) x(102) x(103) x(104) x(105) x(106) x(107) x(108) x(109) x(110) ;...
       x(111) x(112) x(113) x(114) x(115) x(116) x(117) x(118) x(119) x(120) x(121)];

% Temp upper bound
bound_update = trace(R*Wl);

% Split Wl 
Wl1 = Wl(1:8,1:8);
Wl2 = Wl(1:8,9:11);
Wl3 = Wl(9:11,9:11);

% Unperturbed Theta2 
Theta2 = F*Wl+Wl*F';
Theta2_1_W1_un = Theta2(1:8,1:8);

% Perturbed Theta2 
Theta2_1 = F1*Wl+Wl*F1'+Q1;
Theta2_2 = F2*Wl+Wl*F2'+Q2;
Theta2_3 = F3*Wl+Wl*F3'+Q3;
Theta2_4 = F4*Wl+Wl*F4'+Q4;

% Perturbed Theta2_W1 
Theta2_1_W1 = Theta2_1(1:8,1:8);
Theta2_2_W1 = Theta2_2(1:8,1:8);
Theta2_3_W1 = Theta2_3(1:8,1:8);
Theta2_4_W1 = Theta2_4(1:8,1:8);

% f_Wl
f_Wl = trace(Wl2'*inv(Wl1)*Wl2-Wl2'*H'*inv(H*Wl1*H')*H*Wl2);


%% Check constraint violation
if det(Wl1)==0
    f_Wl = 0;
end

% Constraint 1 violated the most
if -eigs(Wl,1,'SR') > max([eigs(Theta2_1_W1,1,'LR'),eigs(Theta2_2_W1,1,'LR'),eigs(Theta2_3_W1,1,'LR'),eigs(Theta2_4_W1,1,'LR'),f_Wl])  
    [V_SA,D_SA] = eigs(Wl,1,'SR'); % Calculate the unit-norm eigenvector corresponding to the minimum eigenvalue of Wl
    x0 = V_SA;
    sl = -trace((x0*x0')'*W);  % Add negative sign to change from ">=0" to "<0"
    sl = sl+delta;
    % Write the cutting plane as inequality constraint
    Aeq_update = fliplr(double(coeffs(sl)));
    beq_update = 0;
else
    
% Constraint 2.1 violated the most
    if eigs(Theta2_1_W1,1,'LR') > max([-eigs(Wl,1,'SR'), eigs(Theta2_2_W1,1,'LR'),eigs(Theta2_3_W1,1,'LR'),eigs(Theta2_4_W1,1,'LR'), f_Wl])   
        [V_LA,D_LA] = eigs(Theta2_1_W1,1,'LR'); % Calculate the unit-norm eigenvector corresponding to the maximum eigenvalue of Theta2
        x00 = V_LA;
        v0 = [x00; 0; 0; 0];
        sl = trace((v0*v0'*F1+F1'*v0*v0')'*W); %(<=-v0'*Q*v0)
        sl = sl+delta;
        % Write the cutting plane as inequality constraint
        Aeq_update = fliplr(double(coeffs(sl)));
        beq_update = -v0'*Q1*v0;
    else  
        
% Constraint 2.2 violated the most
        if  eigs(Theta2_2_W1,1,'LR') > max([-eigs(Wl,1,'SR'), eigs(Theta2_1_W1,1,'LR'),eigs(Theta2_3_W1,1,'LR'),eigs(Theta2_4_W1,1,'LR'), f_Wl])   
        [V_LA,D_LA] = eigs(Theta2_2_W1,1,'LR'); % Calculate the unit-norm eigenvector corresponding to the maximum eigenvalue of Theta2
        x00 = V_LA;
        v0 = [x00; 0; 0; 0];
        sl = trace((v0*v0'*F2+F2'*v0*v0')'*W); %(<=-v0'*Q*v0)
        sl = sl+delta;
        % Write the cutting plane as inequality constraint
        Aeq_update = fliplr(double(coeffs(sl)));
        beq_update = -v0'*Q2*v0;
        else
            
% Constraint 2.3 violated the most
            if eigs(Theta2_3_W1,1,'LR') > max([-eigs(Wl,1,'SR'), eigs(Theta2_1_W1,1,'LR'),eigs(Theta2_2_W1,1,'LR'),eigs(Theta2_4_W1,1,'LR'), f_Wl])   
            [V_LA,D_LA] = eigs(Theta2_3_W1,1,'LR'); % Calculate the unit-norm eigenvector corresponding to the maximum eigenvalue of Theta2
             x00 = V_LA;
             v0 = [x00; 0; 0; 0];
             sl = trace((v0*v0'*F3+F3'*v0*v0')'*W); %(<=-v0'*Q*v0)
             sl = sl+delta;
             % Write the cutting plane as inequality constraint
             Aeq_update = fliplr(double(coeffs(sl)));
             beq_update = -v0'*Q3*v0;
             else
                        
% Constraint 2.4 violated the most
                  if eigs(Theta2_4_W1,1,'LR') > max([-eigs(Wl,1,'SR'), eigs(Theta2_1_W1,1,'LR'),eigs(Theta2_2_W1,1,'LR'),eigs(Theta2_3_W1,1,'LR'), f_Wl])   
                  [V_LA,D_LA] = eigs(Theta2_4_W1,1,'LR'); % Calculate the unit-norm eigenvector corresponding to the maximum eigenvalue of Theta2
                  x00 = V_LA;
                  v0 = [x00; 0; 0; 0];
                  sl = trace((v0*v0'*F4+F4'*v0*v0')'*W); %(<=-v0'*Q*v0)
                  sl = sl+delta;
                  % Write the cutting plane as inequality constraint
                  Aeq_update = fliplr(double(coeffs(sl)));
                  beq_update = -v0'*Q4*v0;
                  else
                      
% Constraint 3 violated the most
                    KD = Wl2'*inv(Wl1);
                    Ku = Wl2'*H'*inv(H*Wl1*H');
                    grad = [H'*Ku'*Ku*H-KD'*KD KD'-H'*Ku';KD-Ku*H zeros(3,3)];
                    sl = trace(grad'*W); %(<=0)
                    sl = sl+delta;
                    % Write the cutting plane as inequality constraint
                    Aeq_update = fliplr(double(coeffs(sl)));
                    beq_update = 0;
                  end
            end
        end
    end
end

%% Update the polytope
% Combine and update the inequality constraints
Aeq = [Aeq; Aeq_update];
beq = [beq beq_update];
indicator = [indicator; -1];

% Output  
con1 = eigs(Wl,1,'SR')   
con2 = eigs(Theta2_1_W1,1,'LR')  
con3 = eigs(Theta2_2_W1,1,'LR')  
con4 = eigs(Theta2_3_W1,1,'LR')  
con5 = eigs(Theta2_4_W1,1,'LR')  
con6 = f_Wl

% Ku & KD
Ku = Wl2'*H'*inv(H*Wl1*H');
KD = Ku*H;

% PID & Flexure
ki1 = KD(1,1);
kp1 = KD(1,2);
kd1 = KD(1,3);
ki2 = KD(2,4);
kp2 = KD(2,5);
kd2 = KD(2,6);
kv = KD(3,7);

% Restore to K
K = [ki1 kp1 kd1 0 0 0;...
     0 0 0 ki2 kp2 kd2;...
     0 kv 0 0 -kv 0];
       
% Build a vector of upper bound
bound_vector = [bound_vector bound_update];

% Upper bound
upper_bound = trace(R*Wl);

% Stoping criterion
limit = 1e-6;
if abs(con1)<limit && abs(con2)<limit && abs(con3)<limit && abs(con4)<limit && abs(con5)<limit && abs(con6)<limit 
    
% pole of final system
    pole_final = eig(A-B2*K)
    
    return
end

end


