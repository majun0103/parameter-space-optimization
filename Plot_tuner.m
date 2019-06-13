clear
close all
clc
addpath('export_fig');
export_figures = true;

load('mat5.mat')
load('mat6.mat')
u_s=pid_duan_good.Y(2).Data;
u_s_dot=pid_duan_good.Y(3).Data;
y_s=pid_duan_good.Y(4).Data;
e_s=pid_duan_good.Y(5).Data-pid_duan_good.Y(4).Data;
t = pid_duan_good.X(2).Data;

f1 = figure(1);
subplot(2,1,1)
plot(t,y_s)
xlim([0,8])
ylim([-0.5*10^-3,10.5*10^-3])
grid on
title('Without Loading (Conventional PID)')
ylabel('Position (m)')
xlabel('Time (s)')
subplot(2,1,2)
plot(t,e_s,'color',[0.85,0.33,0.10])
xlim([0,8])
ylim([-0.00099,0.00099]);
grid on
set(gca,'ytick',-0.0009:0.0003:0.0009);
title('Without Loading (Conventional PID)')
ylabel('Tracking Error (m)')
xlabel('Time (s)')

if export_figures
    export_fig 'conventional_PID_short_position.pdf' -transparent
end

f2 = figure(2);
subplot(2,1,1)
plot(t,u_s)
xlim([0,8])
ylim([-1,1])
grid on
title('Without Loading (Conventional PID)')
ylabel('Control Input (V)')
xlabel('Time (s)')
subplot(2,1,2)
plot(t,u_s_dot,'color',[0.85,0.33,0.10])
xlim([0,8])
ylim([-0.25,0.25]/0.001);
grid on
title('Without Loading (Conventional PID)')
ylabel('Change Rate of Control Input (V/s)')
xlabel('Time (s)')
%%Long
u_l=pid_long_good.Y(2).Data;
u_l_dot=pid_long_good.Y(3).Data;
y_l=pid_long_good.Y(4).Data;
e_l=pid_long_good.Y(5).Data-pid_long_good.Y(4).Data;
t = pid_long_good.X(2).Data;
t = t-t(1);
if export_figures
    export_fig 'conventional_PID_short_input.pdf' -transparent
end


f3 = figure(3);
subplot(2,1,1)
plot(t,y_l)
xlim([0,8])
ylim([-0.5*10^-2,10.5*10^-2])
grid on
title('Without Loading (Conventional PID)')
ylabel('Position (m)')
xlabel('Time (s)')
subplot(2,1,2)
plot(t,e_l,'color',[0.85,0.33,0.10])
xlim([0,8])
ylim([-21*10^-4,21*10^-4])
grid on
set(gca,'ytick',-0.0018:0.0006:0.0018);
title('Without Loading (Conventional PID)')
ylabel('Tracking Error (m)')
xlabel('Time (s)')

if export_figures
    export_fig 'conventional_PID_long_position.pdf' -transparent
end

f4 = figure(4);
subplot(2,1,1)
plot(t,u_l)
xlim([0,8])
ylim([-1.5,1.5])
grid on
title('Without Loading (Conventional PID)')
ylabel('Control Input (V)')
xlabel('Time (s)')
subplot(2,1,2)
plot(t,u_l_dot,'color',[0.85,0.33,0.10])
xlim([0,8])
ylim([-0.25,0.25]/0.001);
grid on
title('Without Loading (Conventional PID)')
ylabel('Change Rate of Control Input (V/s)')
xlabel('Time (s)')

if export_figures
    export_fig 'conventional_PID_long_input.pdf' -transparent
end
