clear;close all;
load 'RLS_Results';
load 'LMS_Results';
%--------------------------------------------------------------------------
figure;%all in one
%plot RLS results
semilogy(SNR_dB,BER_RLS(1,:),'go-');hold on;
semilogy(SNR_dB,BER_RLS(2,:),'ro-');hold on;
semilogy(SNR_dB,BER_RLS(3,:),'bo-');hold on;
%plot LMS results
semilogy(SNR_dB,BER_LMS(1,:),'g*-');hold on;
semilogy(SNR_dB,BER_LMS(2,:),'r*-');hold on;
semilogy(SNR_dB,BER_LMS(3,:),'b*-');hold on;
%grid, title, labels and size
legend('N_{pilot}=5','N_{pilot}=10','N_{pilot}=20',...
'N_{pilot}=5','N_{pilot}=10','N_{pilot}=20','Location','WestOutside');
grid on;title('RLS vs. MLS Equalizer(10 Taps)');
xlabel('SNR(dB)');ylabel('BER');ylim([10^-4 10]);
set(gca,'FontSize',14);axis square;
%--------------------------------------------------------------------------
figure;%grouped by algorithm
%plot RLS results
subplot(121);
semilogy(SNR_dB,BER_RLS(1,:),'go-');hold on;
semilogy(SNR_dB,BER_RLS(2,:),'ro-');hold on;
semilogy(SNR_dB,BER_RLS(3,:),'bo-');hold on;
legend('N_{pilot}=5','N_{pilot}=10','N_{pilot}=20','Location','SouthWest');
xlabel('SNR(dB)');ylabel('BER');grid on;ylim([10^-4 10]);
title('RLS Equalizer');set(gca,'FontSize',14);axis square;
%plot LMS results
subplot(122);
semilogy(SNR_dB,BER_LMS(1,:),'g*-');hold on;
semilogy(SNR_dB,BER_LMS(2,:),'r*-');hold on;
semilogy(SNR_dB,BER_LMS(3,:),'b*-');hold on;
xlabel('SNR(dB)');ylabel('BER');grid on;ylim([10^-4 10]);
legend('N_{pilot}=5','N_{pilot}=10','N_{pilot}=20','Location','SouthWest');
title('LMS Equalizer');set(gca,'FontSize',14);axis square;
%set figure title and size
sgtitle('Grouped by Algorithm');
set(gcf,'Position',[400 300 800 500]);
%--------------------------------------------------------------------------
figure;%group by pilot symbol count
%pilot count is 5
subplot(131);
semilogy(SNR_dB,BER_RLS(1,:),'go-');hold on;
semilogy(SNR_dB,BER_LMS(1,:),'g*-');hold on;
xlabel('SNR(dB)');ylabel('BER');grid on;ylim([10^-4 10]);
legend('RLS','LMS');
title('Pilot Count=5');set(gca,'FontSize',14);axis square;
%pilot count is 10
subplot(132);
semilogy(SNR_dB,BER_RLS(2,:),'ro-');hold on;
semilogy(SNR_dB,BER_LMS(2,:),'r*-');hold on;
xlabel('SNR(dB)');ylabel('BER');grid on;ylim([10^-4 10]);
legend('RLS','LMS');title('Pilot Count=10');
set(gca,'FontSize',14);axis square;
%pilot count is 20
subplot(133);
semilogy(SNR_dB,BER_RLS(3,:),'bo-');hold on;
semilogy(SNR_dB,BER_LMS(3,:),'b*-');hold on;
xlabel('SNR(dB)');ylabel('BER');grid on;ylim([10^-4 10]);
legend('RLS','LMS');title('Pilot Count=20');
set(gca,'FontSize',14);axis square;
%set figure title and size
sgtitle('Grouped by Pilot Symbol Count');
set(gcf,'Position',[250 300 1200 350]);
%--------------------------------------------------------------------------