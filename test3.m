glvs
clear err dtheta
a = 1*glv.deg; 
w = 2*pi*5;
h = 0.001;  %采样间隔
n = 3;      %子样数
len = fix(1*60/h); %计算多少次
t = 0;
%动坐标系（b系）相对于参考坐标系（i）系的变换四元数
q = [cos(a/2);sin(a/2)*cos(w*t);sin(a/2)*sin(w*t);0];
q1 = q;

for k=n:n:len
    t = k*h;
    q = [cos(a/2);sin(a/2)*cos(w*t);sin(a/2)*sin(w*t);0];
    for m=1:n
        t = (k-n+m-1)*h;
        dtheta(:,m) = [-2*sin(a)*sin(w*h/2)*sin(w*(t+h/2));
                        2*sin(a)*sin(w*h/2)*cos(w*(t+h/2));
                        -2*w*h*(sin(a/2))^2 ]; %角增量
    end
    %求出经过圆锥误差补偿的旋转矢量
    phi = cnscl(dtheta);
    %姿态更新
    q1 = qmul(q1,rv2q(phi));
    err(k/n,:) = -q2rv(qmul(q1,qconj(q)))';
end