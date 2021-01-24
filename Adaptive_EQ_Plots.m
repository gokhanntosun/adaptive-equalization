clear;close all;
load 'AE_RLS';
load 'AE_LMS';
load 'CE_MMSE'
SNR_dB=0:2:20;%define snr values
h=[0.74 -0.514 0.37 0.216 0.062];%given channel statistics
ss=get(0,'ScreenSize');%get screen size
%BER PLOTS---
figure;%group by pilot count---
subplot(131);%p=5
semilogy(SNR_dB,AE_BER_RLS(1,:),'b-*');hold on;
semilogy(SNR_dB,AE_BER_LMS(1,:),'m-*');hold on;
semilogy(SNR_dB,BER_MMSE,'k-s');hold on;
legend('RLS','LMS','MMSE','Location','SouthWest');ylim([10^-4 10^0]);
xlabel('SNR(dB)');ylabel('BER');title('P=5');
grid on;set(gca,'FontSize',14);axis square;
subplot(132);%p=10
semilogy(SNR_dB,AE_BER_RLS(2,:),'b-*');hold on;
semilogy(SNR_dB,AE_BER_LMS(2,:),'m-*');hold on;
semilogy(SNR_dB,BER_MMSE,'k-s');hold on;
legend('RLS','LMS','MMSE','Location','SouthWest');ylim([10^-4 10^0]);
xlabel('SNR(dB)');ylabel('BER');title('P=10');
grid on;set(gca,'FontSize',14);axis square;
subplot(133);%p=20
semilogy(SNR_dB,AE_BER_RLS(3,:),'b-*');hold on;
semilogy(SNR_dB,AE_BER_LMS(3,:),'m-*');hold on;
semilogy(SNR_dB,BER_MMSE,'k-s');hold on;
legend('RLS','LMS','MMSE','Location','SouthWest');ylim([10^-4 10^0]);
xlabel('SNR(dB)');ylabel('BER');title('P=20');
grid on;set(gca,'FontSize',14);axis square;
set(gcf,'Position',[250 200 ss(3)-500 450]);
sgtitle('Adaptive Equalization | BER | Grouped by Pilot Count');
figure;%group by algorithm---
subplot(121);%RLS
semilogy(SNR_dB,AE_BER_RLS(1,:),'r-*');hold on;
semilogy(SNR_dB,AE_BER_RLS(2,:),'g-*');hold on;
semilogy(SNR_dB,AE_BER_RLS(3,:),'b-*');hold on;
semilogy(SNR_dB,BER_MMSE,'k-s');hold on;
legend('P=5','P=10','P=20','MMSE','Location','SouthWest');ylim([10^-4 10^0]);
xlabel('SNR(dB)');ylabel('BER');title('RLS');
grid on;set(gca,'FontSize',14);axis square;
subplot(122);%LMS
semilogy(SNR_dB,AE_BER_LMS(1,:),'r-*');hold on;
semilogy(SNR_dB,AE_BER_LMS(2,:),'g-*');hold on;
semilogy(SNR_dB,AE_BER_LMS(3,:),'b-*');hold on;
semilogy(SNR_dB,BER_MMSE,'k-s');hold on;
legend('P=5','P=10','P=20','MMSE','Location','SouthWest');ylim([10^-4 10^0]);
xlabel('SNR(dB)');ylabel('BER');title('LMS');
grid on;set(gca,'FontSize',14);axis square;
set(gcf,'Position',[250 200 ss(3)-500 450]);
sgtitle('Adaptive Equalization | BER | Grouped by Algorithm');