function q = a2quat(att)
    % 先求姿态矩阵
    si = sin(att(1)); ci = cos(att(1)); sj = sin(att(2)); cj = cos(att(2));
    sk = sin(att(3)); ck = cos(att(3));
    M = [ cj*ck+si*sj*sk, ci*sk, sj*ck-si*cj*sk;
            -cj*sk+si*sj*ck, ci*ck, -sj*sk-si*cj*ck;
            -ci*sj, si, ci*cj ];
    % 再求四元数
    q = [ sqrt(abs(1.0 + M(1,1) + M(2,2) + M(3,3)))/2.0;
    sign(M(3,2)-M(2,3)) * sqrt(abs(1.0 + M(1,1) - M(2,2) - M(3,3)))/2.0;
    sign(M(1,3)-M(3,1)) * sqrt(abs(1.0 - M(1,1) + M(2,2) - M(3,3)))/2.0;
    sign(M(2,1)-M(1,2)) * sqrt(abs(1.0 - M(1,1) - M(2,2) + M(3,3)))/2.0 ];