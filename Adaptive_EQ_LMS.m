clear;
%variable definitions
h=[0.74 -0.514 0.37 0.216 0.062];%given channel statistics
N=1000;%block length
T=10;%tap count
frame_cnt=5000;%frame count
fer_lim=50000;%frame error limit
Ks=[5 10 20];%pilot count
%frame_cnt=40000;%frame count
%fer_lim=250000;%frame error limit
SNR_dB=0:2:20;%snr values in db
SNR=1./(2*(10.^(SNR_dB./10)));%snr values in bit energy
w=zeros([T 1]);%equalizer weights to be estimated
AE_BER_LMS=zeros(1,length(SNR_dB));%ber vector
mu=0.5;
%iterations---
for i=1:length(Ks)%pilot count loop
    K=Ks(i);
    for s=1:length(SNR_dB)%snr loop
        %definitions for recursion---
        w=zeros([T 1]);%equalizer weights to be estimated
        u=zeros(T,1);%observation vector
        var=SNR(s);
        fr=1;fer=0;
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
                e=x_p(:,n)-w'*u;%compute error
                ss=mu/(u'*u);%compute step size for the current time instant
                w=w+ss*e*u;%update eq coeffs
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
        AE_BER_LMS(i,s)=fer/(fr*N);%calculate ber
        [SNR_dB(s) fr fer]%print the current parameters
    end%end snr loop
    w_LMS(i,:)=w';
end%end pilot count loop
save('AE_LMS','AE_BER_LMS','w_LMS');%save results