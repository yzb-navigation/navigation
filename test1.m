glvs
clear err dtheta
a = 1*glv.deg; %半锥角
w = 2*pi*5; %锥运动频率
h = 0.01; %采样时间
n = 3; %子样数
len = fix(1*60/h); %仿真时间长度
t = 0; %初始姿态四元数
q = [cos(a/2); sin(a/2)*cos(w*t); sin(a/2)*sin(w*t); 0]; 
q1 = q;
for k=n:n:len
% 姿态真值
t = k*h;
q = [cos(a/2); sin(a/2)*cos(w*t); sin(a/2)*sin(w*t); 0];
% 锥运动解算值
for m=1:n
    t = (k-n+m-1)*h;
    dtheta(:,m) = [-2*sin(a)*sin(w*h/2)*sin(w*(t+h/2));
                    2*sin(a)*sin(w*h/2)*cos(w*(t+h/2));
                    -2*w*h*(sin(a/2))^2 ]; %角增量
    end
    phi = cnscl(dtheta); %圆锥误差补偿
    q1 = qmul(q1,rv2q(phi)); %姿态更新
    err(k/n,:) = -q2rv(qmul(q1,qconj(q)))'; %求姿态误差
end
figure
subplot(3,1,1), plot(err(:,1)/glv.sec), ylabel('\it\phi_x\rm / arcsec');
subplot(3,1,2), plot(err(:,2)/glv.sec), ylabel('\it\phi_y\rm / arcsec');
subplot(3,1,3), plot(err(:,3)/glv.sec), ylabel('\it\phi_z\rm / arcsec');
str = sprintf('\\itt\\rm / \\times%.0fms', n*h*1000); xlabel(str);
% 理论圆锥误差
k2 = 1;
for k=1:n+1
    k2 = k2*(2*k-1);
end
epsilon = a^2*(w*h)^(2*n+1) * n*factorial(n) / (2^(n+1)*k2);
hold on, plot([0,length(err)],[0,epsilon]*length(err)/glv.sec,'r--')