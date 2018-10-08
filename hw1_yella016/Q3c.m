pc1 = [0.2 0.6 0.8];
pc2 = 1-pc1;

p11=0.6; p12=0.1; p21=0.6; p22=0.9;

for i=1:size(pc1, 2)
    
    % x=(0,0)
    pC1x = (p11 * p12 * pc1(i))/(p11 * p12 * pc1(i) + p21 * p22 * pc2(i));
    pC2x = (p21 * p22 * pc2(i))/(p11 * p12 * pc1(i) + p21 * p22 * pc2(i));
    fprintf('P(C1|x) = %f, P(C2|x) =%f for P(C1) = %f and x = (0,0)\n', pC1x, pC2x, pc1(i));
    
    % x=(0,1)
    pC1x = (p11 * (1-p12) * pc1(i))/(p11 * (1-p12) * pc1(i) + p21 * (1-p22) * pc2(i));
    pC2x = (p21 * (1-p22) * pc2(i))/(p11 * (1-p12) * pc1(i) + p21 * (1-p22) * pc2(i));
    fprintf('P(C1|x) = %f, P(C2|x) =%f for P(C1) = %f and x = (0,1)\n', pC1x, pC2x, pc1(i));
    
    % x=(1,0)
    pC1x = ((1-p11) * p12 * pc1(i))/((1-p11) * p12 * pc1(i) + (1-p21) * p22 * pc2(i));
    pC2x = ((1-p21) * p22 * pc2(i))/((1-p11) * p12 * pc1(i) + (1-p21) * p22 * pc2(i));
    fprintf('P(C1|x) = %f, P(C2|x) =%f for P(C1) = %f and x = (1,0)\n', pC1x, pC2x, pc1(i));
    
    % x=(1,1)
    pC1x = ((1-p11) * (1-p12) * pc1(i))/((1-p11) * (1-p12) * pc1(i) + (1-p21) * (1-p22) * pc2(i));
    pC2x = ((1-p21) * (1-p22) * pc2(i))/((1-p11) * (1-p12) * pc1(i) + (1-p21) * (1-p22) * pc2(i));
    fprintf('P(C1|x) = %f, P(C2|x) =%f for P(C1) = %f and x = (1,1)\n\n', pC1x, pC2x, pc1(i));
    
    
end