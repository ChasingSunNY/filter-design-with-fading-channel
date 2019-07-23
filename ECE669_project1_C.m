h = 1;
syms s
Es= s^2;
l=100;
a=rand(1,l);
r(a>0.5)=sqrt(Es/l);
r(a<=0.5)=-sqrt(Es/l);
eq(sum(r.^2), Es)

