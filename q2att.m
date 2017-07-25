function att = q2att(qnb)
    % 先求姿态矩阵
    q11 = qnb(1)*qnb(1); q12 = qnb(1)*qnb(2); q13 = qnb(1)*qnb(3); q14 = qnb(1)*qnb(4);
    q22 = qnb(2)*qnb(2); q23 = qnb(2)*qnb(3); q24 = qnb(2)*qnb(4);
    q33 = qnb(3)*qnb(3); q34 = qnb(3)*qnb(4);
    q44 = qnb(4)*qnb(4);
    M = [ q11+q22-q33-q44, 2*(q23-q14), 2*(q24+q13);
            2*(q23+q14), q11-q22+q33-q44, 2*(q34-q12);
            2*(q24-q13), 2*(q34+q12), q11-q22-q33+q44 ];
    % 再求姿态
    att = [asin(M(3,2)); atan(-M(3,1)/M(3,3)); atan(M(1,2)/M(2,2))];
    if M(3,3) < 0
        if(att(2) < 0) att(2) = att(2)+pi;
        else att(2) = att(2)-pi;
        end
    end
    if( M(2,2) > 0)
        if(att(3) < 0) att(3) = att(3)+pi*2;
        end
    else att(3) = att(3)+pi;
    end