function v = q2rv(q)
    n2 = acos(q(1));
    if n2>1e-20
        k = 2*n2/sin(n2);
    else
        k = 2;
    end
    v = k*q(2:4);