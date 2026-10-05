function [z_rho,z_psi,z0_psi,psiS,rhoS] = GenerateMeasurements(m,xt,nr,nh)


% rnk = nth time, kth sensor [range_noise_nk; bearing_noise_nk], r ~ 2N x K
K = size(m,2);
N = size(xt,2);
psi = zeros(1,N);
rho = zeros(1,N);
%z = zeros(2*N,K);
z_rho = zeros(K,N);
z_psi = zeros(K,N);
z0_psi = zeros(K,N);


% for i=1:N
%     r(1+(i-1)*2:2*i,:) = [sqrt(R(1,1))*randn(1,K);pi/180*sqrt(R(2,2))*randn(1,K)];
% end

i = 0;
for k=1:K
    u = m(1,k);
    v = m(2,k);
    i = i + 1;
    for n=1:N
        x = xt(1,n);
        y = xt(2,n);
        h = xt(4,n);
        dx = u- x;
        dy = v - y;
        rho(n) = sqrt( (u-x)^2 + (v-y)^2 );
        %atan2 [-pi, pi]
        psi0(n) = atan2_0_2PI( (v-y),(u-x) ); 
        %[0,2pi]
        
       psi(n) = AngleRange(psi0(n) - h);
      
    end

    z_rho(k,:) = max(rho + nr(k,:),0);
    z_psi(k,:) = AngleRange(psi  + nh(k,:));
    z0_psi(k,:) = psi0;
    psiS(k,:) = psi;
    rhoS(k,:) = rho;

end





    