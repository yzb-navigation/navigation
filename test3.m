glvs
clear err dtheta
a = 1*glv.deg; 
w = 2*pi*5;
h = 0.001;  %�������
n = 3;      %������
len = fix(1*60/h); %������ٴ�
t = 0;
%������ϵ��bϵ������ڲο�����ϵ��i��ϵ�ı任��Ԫ��
q = [cos(a/2);sin(a/2)*cos(w*t);sin(a/2)*sin(w*t);0];
q1 = q;

for k=n:n:len
    t = k*h;
    q = [cos(a/2);sin(a/2)*cos(w*t);sin(a/2)*sin(w*t);0];
    for m=1:n
        t = (k-n+m-1)*h;
        dtheta(:,m) = [-2*sin(a)*sin(w*h/2)*sin(w*(t+h/2));
                        2*sin(a)*sin(w*h/2)*cos(w*(t+h/2));
                        -2*w*h*(sin(a/2))^2 ]; %������
    end
    %�������Բ׶��������תʸ��
    phi = cnscl(dtheta);
    %��̬����
    q1 = qmul(q1,rv2q(phi));
    err(k/n,:) = -q2rv(qmul(q1,qconj(q)))';
end