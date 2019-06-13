clc
clear all
close all
warning off

%% Model dynamics
Kf=1;
M=0.0133;
ratio=100;
M=ratio*M;
K=0;
C=10.64;
f=0.5;

%% Original state space model
Ao=[0 1 0;...
    0 0 1;...
    0 -K/M -C/M];
B2o=[0;0;Kf/M];
B1o=[0;0;-f/M];

%% Reference profiles
Ap=[0 1 0; 0 0 1; -1728, -432, -36];

%% New model
A=[Ap  zeros(3,3);...
   zeros(3,3) Ao];
B2=[zeros(3,1); B2o];
B1=[zeros(3,1); B1o];
% rank([B2 A*B2 A^2*B2 A^3*B2 A^4*B2 A^5*B2]);  %=3 (stabilizable)

%% Perturbed system
per=20;
M1=(1+per/100)*M;
Ao1=[0 1 0;...
    0 0 1;...
    0 -K/M1 -C/M1];
B2o1=[0;0;Kf/M1];
B1o1=[0;0;-f/M1];
A_per1=[Ap  zeros(3,3);...
   zeros(3,3) Ao1];
B2_per1=[zeros(3,1); B2o1];
B1_per1=[zeros(3,1); B1o1];

%% Controlled output associated matrices
q=1e4;
r=1;
C_bar=q*[1 0 0 -1 0 0;...
         zeros(1,6)]; 
D_bar=r*[0;1];

%% Output feedback associated matrix
C2=[-eye(3) eye(3)];

%% Extended matrices
F=[A -B2; zeros(1,7)];
G=[zeros(6,1); 1];
Q=[B1*B1' zeros(6,1);zeros(1,6) 0];
R=[C_bar'*C_bar zeros(6,1);zeros(1,6) D_bar'*D_bar];

%% Perturbed extended matrices
F1=[A_per1 -B2_per1; zeros(1,7)];
Q1=[B1_per1*B1_per1' zeros(6,1);zeros(1,6) 0];

%% Structure of W
syms w1 w2 w3 w4 w5 w6 w7 w8 w9 w10 w11 w12 w13 w14 
syms w15 w16 w17 w18 w19 w20 w21 w22 w23 w24 w25 w26 w27 w28
syms  w29 w30 w31 w32 w33 w34 w35 w36 w37 w38 w39 w40 w41 w42
syms  w43 w44 w45 w46 w47 w48 w49 

W=[w1 w2 w3 w4 w5 w6 w7;...
   w8 w9 w10 w11 w12 w13 w14;...
   w15 w16 w17 w18 w19 w20 w21;...
   w22 w23 w24 w25 w26 w27 w28 ;...
   w29 w30 w31 w32 w33 w34 w35 ;...
   w36 w37 w38 w39 w40 w41 w42;...
   w43 w44 w45 w46 w47 w48 w49 ];

%% Algorithm
A1=[zeros(1,1) 1 zeros(1,5) -1 zeros(1,41)];
A2=[zeros(1,2) 1 zeros(1,11) -1 zeros(1,34)];
A3=[zeros(1,3) 1 zeros(1,17) -1 zeros(1,27)];
A4=[zeros(1,9) 1 zeros(1,5) -1 zeros(1,33)];
A5=[zeros(1,4) 1 zeros(1,23) -1 zeros(1,20)];
A6=[zeros(1,10) 1 zeros(1,11) -1 zeros(1,26)];
A7=[zeros(1,5) 1 zeros(1,29) -1 zeros(1,13)];
A8=[zeros(1,11) 1 zeros(1,17) -1 zeros(1,19)];
A9=[zeros(1,17) 1 zeros(1,5) -1 zeros(1,25)];
A10=[zeros(1,6) 1 zeros(1,35) -1 zeros(1,6)];
A11=[zeros(1,12) 1 zeros(1,23) -1 zeros(1,12)];
A12=[zeros(1,18) 1 zeros(1,11) -1 zeros(1,18)];
A13=[zeros(1,13) 1 zeros(1,29) -1 zeros(1,5)];
A14=[zeros(1,19) 1 zeros(1,17) -1 zeros(1,11)];
A15=[zeros(1,25) 1 zeros(1,5) -1 zeros(1,17)];
A16=[zeros(1,20) 1 zeros(1,23) -1 zeros(1,4)];
A17=[zeros(1,26) 1 zeros(1,11) -1 zeros(1,10)];
A18=[zeros(1,27) 1 zeros(1,17) -1 zeros(1,3)];
A19=[zeros(1,33) 1 zeros(1,5) -1 zeros(1,9)];
A20=[zeros(1,34) 1 zeros(1,11) -1 zeros(1,2)];
A21=[zeros(1,41) 1 zeros(1,5) -1 zeros(1,1)];
sum_W=w1+w2+w3+w4+w5+w6+w7+w8+w9+w10+w11+w12+w13+w14+...
    w15+w16+w17+w18+w19+w20+w21+w22+w23+w24+w25+w26+w27+w28+...
    w29+w30+w31+w32+w33+w34+w35+w36+w37+w38+w39+w40+w41+w42+...
    w43+w44+w45+w46+w47+w48+w49;
delta=eps*sum_W;
bound_vector=0;
cutvalue=100;
Wl_ini_1=[1 1 1 cutvalue 1 1 1;...
          1 1 1 1 1 1 1;...
          1 1 1 1 1 1 1;...
          cutvalue 1 1 1 1 1 1;...
          1 1 1 1 1 1 1;...
          1 1 1 1 1 1 1;...
          1 1 1 1 1 1 1];
[V_SA,D_SA] = eigs(Wl_ini_1,1,'SR'); 
x0=V_SA;
sl=-trace((x0*x0')'*W);
sl=sl+delta;
A22=fliplr(double(coeffs(sl)));
Aeq=[A1;A2;A3;A4;A5;A6;A7;A8;A9;A10;...
    A11;A12;A13;A14;A15;A16;A17;A18;A19;A20;...
    A21;A22];
beq=zeros(1,22);
indicator=[zeros(21,1); -1];   
lb=[0,-inf(1,7),0,-inf(1,7),0,-inf(1,7),0,-inf(1,7),0,-inf(1,7),0,-inf(1,7),0];
ub=[inf(1,49)];
f=-[1 zeros(1,2) -2 zeros(1,20) 1 zeros(1,23) 1]; 

for i=1:500
       i
lp = lp_maker(f, Aeq, beq, indicator, lb, ub);  
solvestat = mxlpsolve('solve', lp);
obj = mxlpsolve('get_objective', lp);
x = mxlpsolve('get_variables', lp);
mxlpsolve('delete_lp', lp);
Wl=[x(1) x(2) x(3) x(4) x(5) x(6) x(7);...
    x(8) x(9) x(10) x(11) x(12) x(13) x(14);...
   x(15) x(16) x(17) x(18) x(19) x(20) x(21);...
   x(22) x(23) x(24) x(25) x(26) x(27) x(28);...
   x(29) x(30) x(31) x(32) x(33) x(34) x(35);...
   x(36) x(37) x(38) x(39) x(40) x(41) x(42);...
   x(43) x(44) x(45) x(46) x(47) x(48) x(49)];
bound_update=trace(R*Wl);
Wl1=Wl(1:6,1:6);
Wl2=Wl(1:6,7);
Wl3=Wl(7,7);
Theta2=F*Wl+Wl*F';
Theta2_1_W1_un=Theta2(1:6,1:6);
Theta2_1=F1*Wl+Wl*F1'+Q1;
Theta2_1_W1=Theta2_1(1:6,1:6);
f_Wl=trace(Wl2'*inv(Wl1)*Wl2-Wl2'*C2'*inv(C2*Wl1*C2')*C2*Wl2);

if det(Wl1)==0
    f_Wl=0;
end


if -eigs(Wl,1,'SR')> max([eigs(Theta2_1_W1,1,'LR'),f_Wl])  
    [V_SA,D_SA] = eigs(Wl,1,'SR'); 
    x0=V_SA;
    sl=-trace((x0*x0')'*W); 
    sl=sl+delta;
    Aeq_update=fliplr(double(coeffs(sl)));
    beq_update=0;
else
     if eigs(Theta2_1_W1,1,'LR')> max([-eigs(Wl,1,'SR'), f_Wl])   
        [V_LA,D_LA]=eigs(Theta2_1_W1,1,'LR'); 
        x00=V_LA;
        v0=[x00;0];
        sl=trace((v0*v0'*F1+F1'*v0*v0')'*W); 
        sl=sl+delta;
        Aeq_update=fliplr(double(coeffs(sl)));
        beq_update=-v0'*Q1*v0;
     else  
           K=Wl2'*inv(Wl1);
           L=Wl2'*C2'*inv(C2*Wl1*C2');
           grad=[C2'*L'*L*C2-K'*K K'-C2'*L';K-L*C2 0];
           sl=trace(grad'*W); 
           sl=sl+delta;
           Aeq_update=fliplr(double(coeffs(sl)));
           beq_update=0;
     end
end
           
Aeq=[Aeq;Aeq_update];
beq=[beq beq_update];
indicator=[indicator; -1];

con1=eigs(Wl,1,'SR');  
con2=eigs(Theta2_1_W1,1,'LR');
con4=f_Wl;
violation= [con1 con2 con4]
L_opt=Wl2'*C2'*inv(C2*Wl1*C2');
L_opt=L_opt*ratio
K_opt=L_opt*C2;
ki=-K_opt(1,1);kp=-K_opt(1,2);kd=-K_opt(1,3);
bound_vector=[bound_vector bound_update];
upper_bound=trace(R*Wl)
end

