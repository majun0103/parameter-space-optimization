% Plot long
close all
addpath('export_fig');
export_figures = true;

load('reflong.mat')
load('mat1.mat')
load('mat2.mat')

r=[y(1:2001)+0.1;-y(1:2001)]';
r=[r,r,r,r];
r=[r,r,r];
e_n=yeshihaode.Y(4).Data(:,1:20001);
u_n=yeshihaode.Y(5).Data(:,1:20001);
r_n=r(:,1:20001);
x_n=r_n-e_n;
t_n=0:0.001:28;

f1 = figure(1);
subplot(2,1,1);plot(t_n(1:8001),x_n(8000:16000));
grid on
ylim([-0.005,0.105]);
xlabel('Time (s)')
ylabel('Position (m)')
title('Without Loading')

subplot(2,1,2);plot(t_n(1:8001),e_n(8000:16000),'Color',[0.8500,0.3250,0.0980]);
ylim([-0.00099,0.00099]);
xlabel('Time (s)')
ylabel('Tracking Error (m)')
title('Without Loading')

grid on
set(gca,'ytick',-0.0009:0.0003:0.0009);

if export_figures
    export_fig 'position_long.pdf' -transparent
end



f2 = figure(2);
subplot(2,1,1);plot(t_n(1:8001),u_n(8000:16000));
xlabel('Time (s)')
ylabel('Control Input (V)')
title('Without Loading')
ylim([-1,1]);
grid on
subplot(2,1,2);plot(t_n(1:8001),[0,diff(u_n(8000:16000))]/0.001,'Color',[0.8500,0.3250,0.0980]);
ylim([-0.25,0.25]/0.001);
grid on
title('Without Loading')

xlabel('Time (s)')
ylabel('Change Rate of Control Input (V/s)')



if export_figures
    export_fig 'input_long.pdf' -transparent
end





% Light Load
e_l=qingde.Y(4).Data(:,1:28001);
u_l=qingde.Y(5).Data(:,1:28001);
r_l=r(:,1:28001);
x_l=r_l-e_l;

f3 = figure(3);
subplot(2,1,1);plot(t_n(1:8001),x_l(12000:20000));
grid on
ylim([-0.005,0.105]);
xlabel('Time (s)')
ylabel('Position (m)')
title('With Loading')
subplot(2,1,2);plot(t_n(1:8001),e_l(12000:20000),'Color',[0.8500,0.3250,0.0980]);
ylim([-0.00099,0.00099]);
grid on
title('With Loading')
set(gca,'ytick',-0.0009:0.0003:0.0009);
xlabel('Time (s)')
ylabel('Tracking Error (m)')

if export_figures
    export_fig 'position_load_long.pdf' -transparent
end


f4 = figure(4);
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
    export_fig 'input_load_long.pdf' -transparent
end


 

