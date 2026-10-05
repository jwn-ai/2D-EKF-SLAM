clear;close all;

%notation
% xhat = filtered estimate
% muhat = predicted estimate
% ztilde = innovations sequent
% u = control sequence
% Pn = filtered covariance
% Cn = predicted covariance
% Snk = kth innovations covariance
% Kn = Kalman gain
% R = measurement noise covariance
% Q = process noise
% sn = gating distance

T = 1;
pwa = (pi/180*.001)^2;
pva = .001^2;
pr = 5^2;
ph = (pi/180*1)^2;
R = diag([pr ph]); %[m^2,deg^2]
Q0 = diag([pwa pva]);
I = eye(5);

%define target motion
[x,u,uhat] = TargetMotion(T,Q0);
N = size(x,2);

%landmarks
L = 100;
%m = L*rand(2,K);
% for i=1:length(x,2)
%     d = sqrt()
%save('landmarks',"m");
Ns = 100;

K1 = 1;K2 = 50;
MSEns = zeros(K2,Ns);
MSE = zeros(1,K2);
for K2=9:9
    load('landmarks');

m = m(:,1:K2);
K = size(m,2);

for ns = 1:Ns


%compute measurements
 nr =  sqrt(R(1,1))*randn(K,N);
 nh = sqrt(R(2,2))*randn(K,N);
 %save('sensor_noise_m25_noise_test.mat','nr','nh');
%load('sensor_noise_Rh=2.mat');
 %load('sensor_noise_m25_noise_test.mat','nr','nh');

[z_rho,z_psi,z0_psi,psi,rho]= GenerateMeasurements(m,x,nr,nh);

%initialize
[xhatn,Pn] = InitFilter(u,z_psi,R,Q0,m);
xhat = zeros(5,N);
xhat(:,1) = xhatn;
ze = zeros(2,N);
c = zeros(K,K,N);
% process K measurements over time
for n = 2:N
 un = u(:,n);
    %prediction
    muhatn = PropagateState(xhatn,un,T);
    Fn = LinearizeStatePropagation(xhatn,un,T);
    Q = fQ(xhatn,un,Q0,T);
    Cn = Fn*Pn*Fn' + Q;
    %loop over (known) landmark measurements
    for k=1:K
        mk = m(:,k);
        Hk = LinearizeMeasurement(muhatn,mk);
        zhatn = fh(muhatn,mk);
        Snk = Hk*Cn*Hk' + R;
        Kn = Cn*Hk'/Snk;

        %data association loop
       
        dn = zeros(1,K);
        for l=1:K %loop over features, match with innovations

            zk = [z_rho(l,n); z_psi(l,n)];

            %innovations
          
            ztilde = zk - zhatn;
            %discontinuity check
            if ztilde(2)>pi
                ztilde(2) = ztilde(2)-2*pi;
            elseif ztilde(2)<-pi
                ztilde(2) = ztilde(2)+2*pi;
            end


            dn(l) = ztilde'*inv(Snk)*ztilde;

        end
        [~,lhat] = min(dn);
         c(k,lhat,n) = 1;
        
    %for landmark to measurement association select lhat innovation for kth landmark
        
    %correction
       xr = muhatn;
        for i=1:3 %relinearization loop
            Hk = LinearizeMeasurement(xr,mk);
            zhatn = fh(xr,mk);
            Snk = Hk*Cn*Hk' + R;
            Kn = Cn*Hk'/Snk;
            ztilde = zk - zhatn;
            %discontinuity check
            if ztilde(2)>pi
                ztilde(2) = ztilde(2)-2*pi;
            elseif ztilde(2)<-pi
                ztilde(2) = ztilde(2)+2*pi;
            end
            xr = muhatn + Kn*(ztilde);% - Hk*(muhatn-xr));
                    Pn = (I-Kn*Hk)*Cn;

        end
        xhatn = xr;
        
       
   
    end

    xhat(:,n) = xhatn;
    %muhat(:,n) = muhatn;
    ze(:,n) = ztilde;
end
  MSEns(K2,ns) = 1/K2*sum((sqrt((x(1,:)-xhat(1,:)).^2 + (x(2,:)-xhat(2,:)).^2)));
end
  MSE(K2) = mean(MSEns(K2,:))
  K2
end
%figure,plot(MSE)


figure
plot(x(1,:),x(2,:));axis equal;hold on; grid on;
plot(xhat(1,:),xhat(2,:),'or','MarkerSize',4);
plot(m(1,:),m(2,:),'xk');
legend('Truth','Estimate','Landmarks')


figure,plot(180/pi*xhat(4,:));hold on;
plot(180/pi*x(4,:));
title('bearing')


cmap = jet(K);
figure; 
for k=1:K
plot(z_rho(k,:),'Color',cmap(k,:),'LineWidth',.5); hold on;
plot(rho(k,:),'Color',cmap(k,:),'LineWidth',2);
end
title('Range Measurements')

figure; 
for k=1:K
plot(180/pi*z_psi(k,:),'Color',cmap(k,:),'LineWidth',.5); hold on;
plot(180/pi*psi(k,:),'Color',cmap(k,:),'LineWidth',2);
end
title('Bearing Measurements');

figure,plot(ze(2,:))
title('innovation - should be white')

