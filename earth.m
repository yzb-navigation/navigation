function [wnie, wnen, RMh, RNh, gn] = earth(pos, vn)
    global glv
        sl=sin(pos(1)); cl=cos(pos(1)); tl=sl/cl; sl2=sl*sl; sl4=sl2*sl2;
        wnie = glv.wie*[0; cl; sl];                 %地球自转角速度在n系导航系中投影
        sq = 1-glv.e2*sl2; sq2 = sqrt(sq);
        RMh = glv.Re*(1-glv.e2)/sq/sq2+pos(3);      %(3.1-23) 子午圈主曲率半径 加入了高度
        RNh = glv.Re/sq2+pos(3);                    %(3.1-24) 卯酉圈主曲率半径 加入了高度
        wnen = [-vn(2)/RMh; vn(1)/RNh; vn(1)/RNh*tl];   %(3.1-34) 载体运动速度引起导航系旋转角速度的计算公式
        g = glv.g0*(1+5.27094e-3*sl2+2.32718e-5*sl4)-3.086e-6*pos(3); % grs80
        gn = [0;0;-g];