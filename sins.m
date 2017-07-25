function [qnb, vn, pos] = sins(qnb_1, vn_1, pos_1, wm, vm, ts)
    tss = ts*size(wm,2);
    [phim,dvbm] = cnscl(wm,vm);
    [wnie,wnen,rmh,rnh,gn] = earth(pos_1,vn_1);
    wnin = wnie+wnen;
    vn = vn_1 + qmulv(rv2q(-wnin*(1.0/2*tss)),qmulv(qnb_1,dvbm)) + (gn-cross(wnie+wnin,vn_1))*tss;
    pos = pos_1 + tss*[vn_1(2)/rmh;vn_1(1)/(rnh*cos(pos_1(1)));vn_1(3)];
    qnb = qmul(qnb_1, rv2q(phim - qmulv(qconj(qnb_1),wnin*tss)));