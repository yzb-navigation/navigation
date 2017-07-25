function vo = qmulv(q, vi)      %四元数乘以向量(三维向量的坐标变换)
    qi = [0;vi];
    qo = qmul(qmul(q,qi),qconj(q));
    vo = qo(2:4,1);