% Plot reference

close all
addpath('export_fig');
export_figures = true;

load('reflong.mat')
load('mat1.mat')
 

r=[y(1:2001)+0.1;-y(1:2001)]';
r=[r,r,r,r];
r=[r,r,r];
e_n=yeshihaode.Y(4).Data(:,1:20001);
u_n=yeshihaode.Y(5).Data(:,1:20001);
r_n=r(:,1:20001);
x_n=r_n-e_n;
t_n=0:0.001:28;


f11 = figure (11)
set(f11, 'Position', [360   198   575   420]);
subplot(2,2,1)
plot(t_n(1:8001),r_n(1:8001))
xlabel('Time (s)')
ylabel('Position (m)')
grid on
title('Reference Profile')
set(gca,'ytick',[0,0.05,0.1],'yticklabel',{'0','0.5L','L'})

subplot(2,2,2)
plot(t_n(1:8001),[0,diff(r_n(1:8001))]/0.001)
xlabel('Time (s)')
ylabel('Velocity (m/s)')
grid on
title('Reference Profile')
set(gca,'ytick',[-0.4,-0.2,0,0.2,0.4],'yticklabel',{'-4L','-2L','0','2L','4L'})

subplot(2,2,3)
plot(t_n(1:8001), [0,0,diff(r_n(1:8001),2)]/(0.001^2));
xlabel('Time (s)')
ylabel('Acceleration (m/s^2)')
grid on
title('Reference Profile')
set(gca,'ytick',[-4,-2,0,2,4],'yticklabel',{'-40L','-20L','0','20L','40L'})

subplot(2,2,4)
plot(t_n(1:8001), [0,0,0,diff(r_n(1:8001),3)]/(0.001^3));
xlabel('Time (s)')
ylabel('Jerk (m/s^3)')
grid on
title('Reference Profile')
set(gca,'ytick',[-200,-100,0,100,200],'yticklabel',{'-2000L','-1000L','0','1000L','2000L'})

if export_figures
    export_fig 'ref_shortlong.pdf' -transparent
end

