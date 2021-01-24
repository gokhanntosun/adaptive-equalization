clear;close all;
h=[0.74 -0.514 0.37 0.216 0.062];%given channel statistics
N=1000;%block length
T=10;%tap count
frame_cnt=5000;%frame count
fer_lim=50000;%frame error limit
Ks=[5 10 20];%pilot count
SNR_dB=0:2:20;%snr values in db
SNR=1./(2*(10.^(SNR_dB./10)));%snr values in bit energy
AE_BER_RLS=zeros(1,length(SNR_dB));%ber vs snr vector
%iterations---
for i=1:length(Ks)%pilot count loop
    K=Ks(i);
    for s=1:length(SNR_dB)%snr loop
        %definitions for recursion---
        w=zeros([T 1]);%equalizer weights to be estimated
        ld=1;%exponential forget factor
        ldi=1/ld;%inverse of forget factor, for ease
        u=zeros(T,1);%observation vector
        d=zeros(T,1);%known data vector
        P=(SNR_dB(s)+1)*10*eye(T);%inverse of autocorrelation
        ber=zeros(1,frame_cnt);%ber vector
        var=SNR(s);
        fr=1;fer=0;%initialize
        %begin monte carlo sim---
        while fr<frame_cnt && fer<fer_lim
            %training part---
            x_p=randi([0 1],[1 K]);x_p(x_p==0)=-1;%generate pilot symbols
            noise=normrnd(0,sqrt(var),[1,K+length(h)-1]);%noise samples
            y=conv(x_p,h)+noise;%impose channel conditions
            y=[zeros(1,T-1) y];%add zero padding to the beginning
            %begin recursion
            for n=1:K
                u=fliplr(y(n:n+T-1))';%observation
                pi=ldi*P*u;%compute kalman gain vector
                K_g=pi/(1+u'*pi);
                e=x_p(:,n)-w'*u;%compute a priori error
                w=w+e*K_g;%update coeff vector
                P=ldi*P-ldi*K_g*u'*P;%update inverse of autocorr.
            end%end training
            %receiver part---
            x=randi([0 1],[1 N]);x(x==0)=-1;%generate information symbols
            noise=normrnd(0,sqrt(var),[1,N+length(h)-1]);%noise samples
            y=conv(h,x)+noise;%impose channel conditions
            o=conv(w,y);o=o(1:N);%calculate equalizer output
            o(o<0)=-1;o(o>=0)=1;%map back to symbols
            diff=nnz(x-o);%difference between known and detected symbols
            fer=fer+diff;%update frame error
            fr=fr+1;%increase frame count
        end
        AE_BER_RLS(i,s)=fer/(fr*N);%calculate ber
        [SNR_dB(s) fr fer]%print the current parameters
    end%end snr loop
    w_RLS(i,:)=w';
end%end pilot count loop
save('AE_RLS','AE_BER_RLS','w_RLS');%save results