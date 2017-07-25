glvs
clear errphi errvn errpos
ts=0.1; %采样周期
att0=[0;0;0]*glv.deg; vn0=[0;0;0]; pos0=[0*glv.deg;0;0]; %初始值设置
qnb0 = a2quat(att0);
vn = vn0; pos = pos0;
wnie = glv.wie*[0; cos(pos0(1)); sin(pos0(1))];
g = glv.g0*(1+5.27094e-3*sin(pos0(1))^2+2.32718e-5*sin(pos0(1))^4)-3.086e-6*pos0(3);
wbib = qmulv(qconj(qnb0),wnie);
fb = qmulv(qconj(qnb0),[0;0;g]);
wm=wbib*ts; vm=fb*ts; %静止时角增量和比力增量
qnb = qmul(rv2q(-[0.5;0.5;3]*glv.min),qnb0); %加入姿态误差
kk = 1;
for k=1:3600*10
    [qnb,vn,pos]=sins(qnb,vn,pos,wm,vm,ts);
    if mod(k,10)==0
        errphi(kk,:) = -q2rv(qmul(qnb,qconj(qnb0)))'; %求姿态误差
        errvn(kk,:) = (vn-vn0)';
        errpos(kk,:) = (pos-pos0)';
        kk = kk+1;
    end
end
figure,
subplot(3,1,1),plot(errphi/glv.min), ylabel('\it\phi\rm / arcmin');
subplot(3,1,2),plot(errvn), ylabel('\it\delta V\rm / m/s');
subplot(3,1,3),plot([errpos(:,1:2)*glv.Re,errpos(:,3)]), ylabel('\it\delta P\rm / m');
xlabel('\itt\rm / s');