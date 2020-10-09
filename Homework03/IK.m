function q = IK(px,py,pz)

d1 = 175;
a2 = 250;

q11 = atan2(py,px);
q12 = atan2(-py,-px);

q21 = atan2(pz-d1,sqrt(px^2 + py^2));
q22 = atan2(pz-d1,-sqrt(px^2 + py^2));
q23 = atan2(-pz+d1,-sqrt(px^2 + py^2));
q24 = atan2(-pz+d1,sqrt(px^2 + py^2));

d31 = sqrt(px^2 + py^2 + (pz-d1)^2) - a2;
d32 = -sqrt(px^2 + py^2 + (pz-d1)^2) - a2;

q = [q11 q21 d31;
     q12 q22 d31;
     q11 q23 d32;
     q12 q24 d32];
 
 q(:,1:2) = rad2deg(q(:,1:2));