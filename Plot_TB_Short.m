%Plot Timing Belt
%Normal
close all
addpath('export_fig');
export_figures = true;


load('mat3.mat')
load('mat4.mat')
load('refshort.mat')

r=[y(1:2001);-y(1:2001)+0.01]';
r=[r,r,r,r];
r=[r,r,r];
e_n=duanmeiload.Y(4).Data(:,4001:28001);
u_n=duanmeiload.Y(5).Data(:,4001:28001);
r_n=r(:,4001:28001);
x_n=r_n-e_n;
t_n=0:0.001:28;

f6 = figure(6);
% set(f1, 'Position', [100, 100, 800, 300]);

subplot(2,1,1);plot(t_n(1:8001),x_n(16000:24000));
grid on
ylim([-0.005,0.105]/10);
xlabel('Time (s)')
ylabel('Position (m)')
set(gca,'ytick',[0,0.005,0.01]);
title('Without Loading')

subplot(2,1,2);plot(t_n(1:8001),e_n(16000:24000),'Color',[0.8500,0.3250,0.0980]);
ylim([-0.0005,0.0005]);
xlabel('Time (s)')
ylabel('Tracking Error (m)')
title('Without Loading')

grid on
set(gca,'ytick',-0.0009:0.0003:0.0009);

if export_figures
    export_fig 'position_short.pdf' -transparent
end



f7 = figure(7);
subplot(2,1,1);plot(t_n(1:8001),u_n(16000:24000));
xlabel('Time (s)')
ylabel('Control Input (V)')
title('Without Loading')
ylim([-1,1]);
grid on
subplot(2,1,2);plot(t_n(1:8001),[0,diff(u_n(16000:24000))]/0.001,'Color',[0.8500,0.3250,0.0980]);
ylim([-0.25,0.25]/0.001);
grid on
title('Without Loading')

xlabel('Time (s)')
ylabel('Change Rate of Control Input (V/s)')



if export_figures
    export_fig 'input_short.pdf' -transparent
end






%Light Load
e_l=duanyouload.Y(4).Data(:,1:28001);
u_l=duanyouload.Y(5).Data(:,1:28001);
r_l=r(:,1:28001);
x_l=r_l-e_l;

f8 = figure(8);
subplot(2,1,1);plot(t_n(1:8001),x_l(12000:20000));
grid on
ylim([-0.005,0.105]/10);
xlabel('Time (s)')
ylabel('Position (m)')
title('With Loading')
subplot(2,1,2);plot(t_n(1:8001),e_l(12000:20000),'Color',[0.8500,0.3250,0.0980]);
ylim([-0.0005,0.0005]);
grid on
title('With Loading')
set(gca,'ytick',-0.0009:0.0003:0.0009);
xlabel('Time (s)')
ylabel('Tracking Error (m)')

if export_figures
    export_fig 'position_load_short.pdf' -transparent
end


f9 = figure(9);
subplot(2,1,1);plot(t_n(1:8001),u_l(12000:20000));
ylim([-1,1]);
grid on
xlabel('Time (s)')
ylabel('Control Input (V)')
title('With Loading')
subplot(2,1,2);plot(t_n(1:8001),[0,diff(u_l(12000:20000))]/0.001,'Color',[0.8500,0.3250,0.0980]);
ylim([-0.25,0.25]/0.001);
grid on
xlabel('Time (s)')
ylabel('Change Rate of Control Input (V/s)')
title('With Loading')

if export_figures
    export_fig 'input_load_short.pdf' -transparent
end

 

