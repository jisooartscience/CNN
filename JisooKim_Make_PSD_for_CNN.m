
clc;
close all;
clear all;

load('F:\CBRAIN\data\ZSCORE.mat');

% ZSCORE.data
% 2 days x 2 exp x 1024 freq x 3700 times x 8 mice x 4 trials x 2 ch
% Zscore


figure_path='F:\Figures\Fig2\Fig2_gh'
load([figure_path '\power_data.mat']);
% power_data
% 2 days x 2 exp x 1024 freq x 3700 times x 8 mice x 4 trials x 2ch


%% Raw trace

load('E:\JEELAB\EEG\EEG_RECORDING\BBCI\190910\all_eeg_stage_days.mat');
% all_eeg_stage_days : 2 days x 2 exp x 2ch x 4 trial x 8 mice x 61441 times x 4 stage

load('E:\JEELAB\EEG\EEG_RECORDING\BBCI\190910\all_eeg_days.mat');
% all_eeg_days : 2 days x 2 exp x 2ch x 4 trial x 8 mice x 370000 time

chan_list={'BLA','PFC'};
figure_path='H:\CBRAIN\EEG_RESULT\190910_shuffle_0528\'
display(['end!'])



%% PSD 그리고 저장하기!
% days=1;
% exp=1;
% m=7;
% 
% days=1; exp=1; m=1; tr=1;
for days=2;
    for exp=2;
        for m=1:8;
       for tr=1:4;
%     display(['tr ' num2str(tr)]);
    
    sr=1024;
    dt=1/sr;
    EEG.times=dt:dt:dt*370000;
    EEG.data=squeeze(all_eeg_days(days,exp,:,tr,m,:));


    % 일단 전체적으로 Spectrogram 살펴보기


    % power_data
    % 2 days x 2 exp x 1024 freq x 3700 times x 8 mice x 4 trials x 2ch

    % ZSCORE.data
    % 2 days x 2 exp x 1024 freq x 3700 times x 8 mice x 4 trials x 2 ch
    % Zscore
    dat_to_plot1=squeeze(power_data(days,exp, :,:,m, tr,1));
    dat_to_plot2=squeeze(power_data(days,exp, :,:,m, tr,2));
    
    size_d= size(dat_to_plot1,2);
    % PSD 데이터 시간 순서 Random으로 섞어주기! !!
    dat_to_plot1_shuffle = dat_to_plot1(:, randperm(size_d, size_d) );
    dat_to_plot2_shuffle = dat_to_plot2(:, randperm(size_d, size_d) );

    
    
    time_list=ZSCORE.time+1.09;
    freq_list=ZSCORE.freq;
    gausn=1.1;  %원래 12

    xlimit2=[0 360];
    ylimit2=[0 50];
    yticks2=[0:5:150];
    xticks2=[0:20:360];
    cnum2=[0 0.0001];


    figure(1);
    set(gcf,'units','normalized','outerposition',[0.1 0.2 0.6 0.8]);  
    set(gcf,'color','white');
    set(gca,'fontsize', 15); hold on;
    imagesc(time_list, freq_list, imgaussfilt(dat_to_plot1_shuffle,gausn)); axis xy; hold on;
    title(['PSD of BLA : day' num2str(days) ' exp' num2str(exp) ' mouse' num2str(m) ' trial' num2str(tr)  ]);
    % plot([120 120],[0 100],'m--','linewidth',3);
    % plot([180 180],[0 100],'m--','linewidth',3);
    xlim(xlimit2);
    ylim(ylimit2);
    yticks(yticks2);
    xticks(xticks2);
    colormap jet
    colorbar; caxis(cnum2);
    grid on;  hold on;
    ch=1;
    figure_path1= [figure_path '\m' num2str(m) '\PSD_day' num2str(days) 'exp' num2str(exp) 't' num2str(tr) '_' chan_list{ch} ];
%     saveas(gcf,figure_path1, 'fig'); hold on;
    saveas(gcf,figure_path1, 'png'); 



    figure(12);
    set(gcf,'units','normalized','outerposition',[0.1 0.2 0.6 0.8]); hold on;
    set(gcf,'color','white');
    set(gca,'fontsize', 15); hold on;
    imagesc(time_list, freq_list, imgaussfilt(dat_to_plot2_shuffle,gausn)); axis xy
    title(['PSD of PFC : day' num2str(days) ' exp' num2str(exp) ' mouse' num2str(m) ' trial' num2str(tr)  ]);
    % plot([120 120],[0 100],'m--','linewidth',3);
    % plot([180 180],[0 100],'m--','linewidth',3);
    xlim(xlimit2);
    ylim(ylimit2);
    yticks(yticks2);
    xticks(xticks2);
    colormap jet
    colorbar;
    caxis(cnum2);
    ch=2;
    figure_path2= [figure_path '\m' num2str(m) '\PSD_day' num2str(days) 'exp' num2str(exp) 't' num2str(tr) '_' chan_list{ch} ];
%     saveas(gcf,figure_path2, 'fig');
    saveas(gcf,figure_path2, 'png');hold on;


  display(['day' num2str(days) 'exp' num2str(exp) 'tr' num2str(tr) 'm' num2str(m) ]);
% close all;
            end
        end
    end
end



%% Raw trace

days=1;
exp=1;
m=3;
tr=2;
EEG.data=squeeze(all_eeg_days(days,exp,:,tr,m,:));
% days1 exp1 m3 tr2
xlimit=[139 142];
xlimit=[146 149];
xlimit=[158 161];
xlimit=[168 171];
xlimit=[144 147];

% days1 exp1 m3 tr1
xlimit=[80 83];

% days1 exp1 m7 tr3
xlimit=[146 149];
xlimit=[139 142];
xlimit=[153 156];
figure(1);
set(gca, 'LooseInset', get(gca, 'TightInset'));
set(gcf,'color','white');
subplot(4,1,1);
set(gcf,'units','normalized','outerposition',[0.1 0.2 0.5 0.8]); hold off;    
ch=1;
plot(EEG.times, EEG.data(ch,:), 'k-');
title([{[' day' num2str(days) ' exp' num2str(exp) ' mouse' num2str(m) ' trial' num2str(tr) ]}, {'BLA'}], 'fontsize', 20);
xlim(xlimit);
ylim([-0.27 0.27]);
set(gca,'fontsize',16); 
hold on;



subplot(4,1,3);
ch=2;
plot(EEG.times, EEG.data(ch,:) ,'k-');
title(['PFC'],  'fontsize', 20);
xlim(xlimit);
set(gca,'fontsize',16); 
ylim([-0.27 0.27]);


% ZSCORE
% ZSCORE.data
% 2 days x 2 exp x 1024 freq x 3700 times x 8 mice x 4 trials x 2 ch

ylimit=[0 40];
time_list=ZSCORE.time+1;
freq_list=ZSCORE.freq;

ch1=1;
dat_to_plot1= squeeze(power_data(days,exp,:,:,m,tr,ch1));

subplot(4,1,2);

set(gca,'fontsize', 15); hold on;
imagesc(time_list, freq_list, imgaussfilt(dat_to_plot1,gausn)); axis xy
colormap jet
colorbar off;
caxis([0 0.00015]);
ylim(ylimit);
xlim(xlimit);

hold on;
ylabel(['Freq (Hz)'],'fontsize', 20);

%

ch2=2;
dat_to_plot2= squeeze( power_data(days,exp,:,:,m,tr,ch2));

subplot(4,1,4);

set(gca,'fontsize', 15); hold on;
imagesc(time_list, freq_list, imgaussfilt(dat_to_plot2,gausn)); axis xy
colormap jet
colorbar off;
csnum=-0.2;
cnum=6
caxis([0 0.0001]);
ylim(ylimit);
xlim(xlimit);
hold on;

plot([120 120],[0 300], ':' ,'color', 'w' , 'linewidth',5)
plot([180 180],[0 300], ':','color', 'w','linewidth',6)
plot([240 240],[0 300], ':','color', 'w','linewidth',5)
xlabel(['Time (s)'],'fontsize', 20);
ylabel(['Freq (Hz)'],'fontsize', 20);






%% Raw trace !!! 여기가 Figure 그리기 좋은 부분임!! 타겟하는 감마영역 PSD랑 같이 그리기!!!!!
days=1;
exp=1;
m=7;
tr=3;
EEG.data=squeeze(all_eeg_days(days,exp,:,tr,m,:));

% days1 exp1 m3 tr2
xlimit=[158 161];
xlimit=[168 171];
xlimit=[144 147];

% days1 exp1 m3 tr1
xlimit=[85 88];



time_list=ZSCORE.time+0.9023;
freq_list=ZSCORE.freq;

figure(2);
set(gca, 'LooseInset', get(gca, 'TightInset'));
set(gcf,'color','white');
subplot(6,1,1);
set(gcf,'units','normalized','outerposition',[0.1 0.2 0.5 0.8]); hold off;    
ch=1;
plot(EEG.times, EEG.data(ch,:), 'k-');
title([{[' day' num2str(days) ' exp' num2str(exp) ' mouse' num2str(m) ' trial' num2str(tr) ]}, {'BLA'}], 'fontsize', 20);
xlim(xlimit); ylim([-0.27 0.27]);
set(gca,'fontsize',16); 
hold on;




% ZSCORE
% ZSCORE.data
% 2 days x 2 exp x 1024 freq x 3700 times x 8 mice x 4 trials x 2 ch

ylimit=[0 10];

ch1=1;
dat_to_plot1= squeeze(power_data(days,exp,:,:,m,tr,ch1));
% dat_to_plot1= squeeze( ZSCORE.data(days,exp,:,:,m,tr,ch1));

Af1=3.5;
Af2=4.5;
subplot(6,1,2);
set(gca,'fontsize', 15); hold on;
ch=1;ch1=1;
lfp1=EEG.data(ch,:);
lfp1_filt=eegfilt(lfp1,sr,Af1,Af2);
plot(EEG.times, lfp1_filt, 'k');
title([num2str(Af1) '-' num2str(Af2) ' Hz']);
xlim(xlimit);


subplot(6,1,3);
set(gca,'fontsize', 15); hold on;

imagesc(time_list, freq_list, imgaussfilt(dat_to_plot1,gausn)); axis xy
colormap jet
colorbar off;
caxis([0 0.00015]);
% caxis([csnum cnum]);
ylim(ylimit);
xlim(xlimit);

hold on;
ylabel(['Freq (Hz)'],'fontsize', 20);

%


ch2=2;
dat_to_plot2= squeeze( power_data(days,exp,:,:,m,tr,ch2));
% dat_to_plot2= squeeze( ZSCORE.data(days,exp,:,:,m,tr,ch2));

subplot(6,1,4);
ch=2;
plot(EEG.times, EEG.data(ch,:) ,'k-');
title(['PFC'],  'fontsize', 20);
xlim(xlimit); ylim([-0.27 0.27]);
set(gca,'fontsize',16); 


% Filtering
subplot(6,1,5);
set(gca,'fontsize', 15); hold on;
ch=2;
lfp2=EEG.data(ch,:);
lfp2_filt=eegfilt(lfp2,sr,Af1,Af2);
title([num2str(Af1) '-' num2str(Af2) ' Hz']);
plot(EEG.times, lfp2_filt, 'k');
xlim(xlimit);


subplot(6,1,6);

set(gca,'fontsize', 15); hold on;
imagesc(time_list, freq_list, imgaussfilt(dat_to_plot2,gausn)); axis xy
colormap jet
colorbar off;
csnum=-0.2;
cnum=6
caxis([0 0.0001]);
% caxis([csnum cnum]);
ylim(ylimit);
xlim(xlimit);
hold on;

plot([120 120],[0 300], ':' ,'color', 'w' , 'linewidth',5)
plot([180 180],[0 300], ':','color', 'w','linewidth',6)
plot([240 240],[0 300], ':','color', 'w','linewidth',5)
xlabel(['Time (s)'],'fontsize', 20);
ylabel(['Freq (Hz)'],'fontsize', 20);



%%



xlimit=[167 170];
xlimit=[155 158];
xlimit=[140 143];
xlimit=[167 169];
Af3=30;
Af4=50;
Af5=70;
Af6=120;

Tf1=7;
Tf2=9;

figure(5);
set(gcf,'color','white');
set(gcf,'units','normalized','outerposition',[0.1 0.1 0.5 0.9]); hold off;    
ch=2;
subplot(5,1,1);
plot(EEG.times, EEG.data(ch,:) ,'k-');
title([{[' day' num2str(days) ' exp' num2str(exp) ' mouse' num2str(m) ' trial' num2str(tr) ]}, {'PFC'}],  'fontsize', 20);
xlim(xlimit);
set(gca,'fontsize',16); 


% Filtering - 4Hz
subplot(5,1,2);
set(gca,'fontsize', 15); hold on;
ch=2;
lfp2=EEG.data(ch,:);
lfp2_filt=eegfilt(lfp2,sr,Tf1,Tf2);
plot(EEG.times, lfp2_filt, 'k');
% ylim([-0.08 0.08]);
xlim(xlimit);


% Filtering - Low gamma
subplot(5,1,3);
set(gca,'fontsize', 15); hold on;
lfp3_filt=eegfilt(lfp1,sr,Af3,Af4);
plot(EEG.times, lfp2_filt*4, 'r'); hold on;
plot(EEG.times, lfp3_filt, 'k'); hold on;
xlim(xlimit);



% Filtering - High gamma
subplot(5,1,4);
set(gca,'fontsize', 15); hold on;
ch=2;
lfp4_filt=eegfilt(lfp2,sr,Af5,Af6);
plot(EEG.times, lfp2_filt, 'r'); hold on;
plot(EEG.times, lfp4_filt, 'k'); hold on;
xlim(xlimit);



subplot(5,1,5);

set(gca,'fontsize', 15); hold on;
imagesc(time_list+1, freq_list, imgaussfilt(dat_to_plot2,gausn)); axis xy
colormap jet
colorbar off;
csnum=-0.2;
cnum=6
caxis([csnum cnum]);
ylim(ylimit);
xlim(xlimit);
hold on;

plot([120 120],[0 300], ':' ,'color', 'w' , 'linewidth',5)
plot([180 180],[0 300], ':','color', 'w','linewidth',6)
plot([240 240],[0 300], ':','color', 'w','linewidth',5)
xlabel(['Time (s)'],'fontsize', 20);
ylabel(['Freq (Hz)'],'fontsize', 20);



%%



%%

xlimit=[167 170];
xlimit=[155 158];
xlimit=[140 143];
xlimit=[168 171];
Af3=30;
Af4=50;
Af5=70;
Af6=120;

Tf1=7;
Tf2=9;

figure(6);
set(gcf,'color','white');
set(gcf,'units','normalized','outerposition',[0.1 0.1 0.5 0.9]); hold on;    

subplot(7,2,1:2);
plot(EEG.times, lfp1 ,'k-');
title([{[' day' num2str(days) ' exp' num2str(exp) ' mouse' num2str(m) ' trial' num2str(tr) ]}, {'BLA'}],  'fontsize', 20);
xlim(xlimit);
set(gca,'fontsize',16); 

subplot(7,2,3:4);
plot(EEG.times, lfp2 ,'k-');
title(['PFC'],  'fontsize', 20);
xlim(xlimit);
set(gca,'fontsize',16); 

ch=1;
subplot(7,2,5);
plot(EEG.times, EEG.data(ch,:) ,'k-');
title([{[' day' num2str(days) ' exp' num2str(exp) ' mouse' num2str(m) ' trial' num2str(tr) ]}, {'BLA'}],  'fontsize', 20);
xlim(xlimit);
set(gca,'fontsize',16); 


% Filtering - 4Hz
subplot(7,2,7);
set(gca,'fontsize', 15); hold on;
ch=1;
lfp1=EEG.data(ch,:);
lfp1_filt1=eegfilt(lfp1,sr,Tf1,Tf2); % 4Hz filtering
plot(EEG.times, lfp1_filt1, 'k'); % plot 4hz-filtered signal
% ylim([-0.08 0.08]);
xlim(xlimit);


% Filtering - Low gamma
subplot(7,2,9);
set(gca,'fontsize', 15); hold on;
lfp1_filt2=eegfilt(lfp1,sr,Af3,Af4); % Low gamma filtering
plot(EEG.times, lfp1_filt1*4, 'r'); hold on; % 4Hz plot
plot(EEG.times, lfp1_filt2, 'k'); hold on; % Low gamma plot
xlim(xlimit);



% Filtering - High gamma
subplot(7,2,11);
set(gca,'fontsize', 15); hold on;
lfp1_filt3=eegfilt(lfp1,sr,Af5,Af6); % High gamma filtering
plot(EEG.times, lfp2_filt, 'r'); hold on; % 4Hz plot
plot(EEG.times, lfp4_filt, 'k'); hold on; % High gamma plot
xlim(xlimit);



subplot(7,2,13);

set(gca,'fontsize', 15); hold on;
imagesc(time_list+1, freq_list, imgaussfilt(dat_to_plot1,gausn)); axis xy
colormap jet
colorbar off;
csnum=-0.2;
cnum=6
caxis([csnum cnum]);
ylim(ylimit);
xlim(xlimit);
hold on;

plot([120 120],[0 300], ':' ,'color', 'w' , 'linewidth',5)
plot([180 180],[0 300], ':','color', 'w','linewidth',6)
plot([240 240],[0 300], ':','color', 'w','linewidth',5)
xlabel(['Time (s)'],'fontsize', 20);
ylabel(['Freq (Hz)'],'fontsize', 20);



%%%%%%% 여기부터는 PFC

ch=2;
subplot(7,2,6);
plot(EEG.times, EEG.data(ch,:) ,'k-');
title([{[' day' num2str(days) ' exp' num2str(exp) ' mouse' num2str(m) ' trial' num2str(tr) ]}, {'PFC'}],  'fontsize', 20);
xlim(xlimit);
set(gca,'fontsize',16); 


% Filtering - 4Hz
subplot(7,2,8);
set(gca,'fontsize', 15); hold on;
lfp2=EEG.data(ch,:);
lfp2_filt1=eegfilt(lfp2,sr,Tf1,Tf2); % 4Hz filtering 
plot(EEG.times, lfp2_filt1, 'k'); % plot 4Hz
% ylim([-0.08 0.08]);
xlim(xlimit);


% Filtering - Low gamma
subplot(7,2,10);
set(gca,'fontsize', 15); hold on;
lfp2_filt2=eegfilt(lfp2,sr,Af3,Af4); % Low gamma filtering
plot(EEG.times, lfp2_filt1*4, 'r'); hold on; % plot 4Hz
plot(EEG.times, lfp2_filt2, 'k'); hold on; % plot Low gamma
xlim(xlimit);



% Filtering - High gamma
subplot(7,2,12);
set(gca,'fontsize', 15); hold on;
lfp2_filt3=eegfilt(lfp2,sr,Af5,Af6); % High gamma filtering
plot(EEG.times, lfp2_filt1, 'r'); hold on; % plot 4Hz
plot(EEG.times, lfp2_filt3, 'k'); hold on; % plot High gamma
xlim(xlimit);



subplot(7,2,14);

set(gca,'fontsize', 15); hold on;
imagesc(time_list+1, freq_list, imgaussfilt(dat_to_plot2,gausn)); axis xy
colormap jet
colorbar off;
csnum=-0.2;
cnum=6
caxis([csnum cnum]);
ylim(ylimit);
xlim(xlimit);
hold on;

plot([120 120],[0 300], ':' ,'color', 'w' , 'linewidth',5)
plot([180 180],[0 300], ':','color', 'w','linewidth',6)
plot([240 240],[0 300], ':','color', 'w','linewidth',5)
xlabel(['Time (s)'],'fontsize', 20);
ylabel(['Freq (Hz)'],'fontsize', 20);



%% 여기도 FIGURE 그리는 부분 !!! PFC랑 BLA 같이 Plot해서 그리는 부분임!!!!!!
days=1;
exp=1;
m=7;
tr=3;
EEG.data=squeeze(all_eeg_days(days,exp,:,tr,m,:));
ch1=1; ch2=2;
dat_to_plot1= squeeze(power_data(days,exp,:,:,m,tr,ch1));
dat_to_plot2= squeeze(power_data(days,exp,:,:,m,tr,ch2));
% days1 exp1 m3 t2
% xlimit=[167 170];
% xlimit=[155 158];
% xlimit=[140 143];
% xlimit=[167 169];

% for st=100:360;
    st=169.5;
    st=144.5
    st=148.2
    st=150.4;
    st=144.5

% days1 exp1 m3 trial1
    st=91
    
% days1 exp1 m7 trial3
st=148;
st=141;
st=154;
st=164.8;
st=171;
st=141.3; st=154.1; st=176.9; st=192.6; st=198.2; st=128.4; st=134.2;
st=150;
xlimit=[st-1 st+1];
    
Af3=25;
Af4=60;
Af5=70;
Af6=120;

ylimit=[0 7];

Tf1=6;
Tf2=8;
time_list=ZSCORE.time+1.09;
freq_list=ZSCORE.freq;

figure(6);
set(gcf,'color','white');
set(gcf,'units','normalized','outerposition',[0 0.1 1 0.9]); hold on;    

ch=1;
subplot(5,2,1);
plot(EEG.times, EEG.data(ch,:) ,'k-'); hold on;
title([{[' day' num2str(days) ' exp' num2str(exp) ' mouse' num2str(m) ' trial' num2str(tr) ]}, {'BLA'}],  'fontsize', 20); hold on;
% plot(EEG.times, lfp1_filt2, 'r'); % plot 4hz-filtered signal 
hold on;
plot(EEG.times, lfp1_filt1*4, 'r'); % plot 4hz-filtered signal
% plot(EEG.times, lfp2_filt1*2, 'b'); % plot 4hz-filtered signal
hold on;
xlim(xlimit);ylim([-0.22 0.22]);
set(gca,'fontsize',16); 


% Filtering - 4Hz
subplot(5,2,3);
set(gca,'fontsize', 15); hold on;
ch=1;
lfp1=EEG.data(ch,:);
lfp1_filt1=eegfilt(lfp1,sr,Tf1,Tf2); % 4Hz filtering
plot(EEG.times, lfp1_filt1, 'k'); % plot 4hz-filtered signal
title([num2str(Tf1) '-' num2str(Tf2) ' Hz']);
% ylim([-0.08 0.08]);
xlim(xlimit);


% Filtering - Low gamma
subplot(5,2,5);
set(gca,'fontsize', 15); hold on;
lfp1_filt2=eegfilt(lfp1,sr,Af3,Af4); % Low gamma filtering
plot(EEG.times, lfp1_filt1*2, 'r'); hold on; % 4Hz plot
% figure(22)
plot(EEG.times, lfp1_filt2, 'k'); hold on; % Low gamma plot
title([num2str(Af3) '-' num2str(Af4) ' Hz' ]);
xlim(xlimit);



% Filtering - High gamma
subplot(5,2,7);
set(gca,'fontsize', 15); hold on;
lfp1_filt3=eegfilt(lfp1,sr,Af5,Af6); % High gamma filtering
plot(EEG.times, lfp1_filt1, 'r'); hold on; % 4Hz plot
plot(EEG.times, lfp4_filt*3, 'k'); hold on; % High gamma plot
title([num2str(Af5) '-' num2str(Af6) ' Hz']);
xlim(xlimit);



subplot(5,2,9);
ch1=1;
set(gca,'fontsize', 15); hold on;
% dat_to_plot1= squeeze( ZSCORE.data(days,exp,:,:,m,tr,ch1));
imagesc(time_list, freq_list, imgaussfilt(dat_to_plot1,gausn)); axis xy
colormap jet
colorbar off;
csnum=-0.2;
cnum=6
caxis([0 0.00015]);
% caxis([csnum cnum]);
ylim(ylimit);
xlim(xlimit);
hold on;

plot([120 120],[0 300], ':' ,'color', 'w' , 'linewidth',5)
plot([180 180],[0 300], ':','color', 'w','linewidth',6)
plot([240 240],[0 300], ':','color', 'w','linewidth',5)
xlabel(['Time (s)'],'fontsize', 20);
ylabel(['Freq (Hz)'],'fontsize', 20);



%%%%%%% 여기부터는 PFC

ch=2;
subplot(5,2,2);
plot(EEG.times, EEG.data(ch,:) ,'k-'); hold on;
plot(EEG.times, lfp2_filt1*7,'r'); hold on;
title([{[' day' num2str(days) ' exp' num2str(exp) ' mouse' num2str(m) ' trial' num2str(tr) ]}, {'PFC'}],  'fontsize', 20);
xlim(xlimit);ylim([-0.23 0.23]);
set(gca,'fontsize',16); 


% Filtering - 4Hz
subplot(5,2,4);
set(gca,'fontsize', 15); hold on;
lfp2=EEG.data(ch,:);
lfp2_filt1=eegfilt(lfp2,sr,Tf1,Tf2); % 4Hz filtering 
plot(EEG.times, lfp2_filt1, 'k'); % plot 4Hz
title([num2str(Tf1) '-' num2str(Tf2) ' Hz']);
% ylim([-0.08 0.08]);
xlim(xlimit);


% Filtering - Low gamma
subplot(5,2,6);
set(gca,'fontsize', 15); hold on;
lfp2_filt2=eegfilt(lfp2,sr,Af3,Af4); % Low gamma filtering
plot(EEG.times, lfp2_filt1*2, 'r'); hold on; % plot 4Hz
plot(EEG.times, lfp2_filt2, 'k'); hold on; % plot Low gamma
title([num2str(Af3) '-' num2str(Af4) ' Hz']);
xlim(xlimit);



% Filtering - High gamma
subplot(5,2,8);
set(gca,'fontsize', 15); hold on;
lfp2_filt3=eegfilt(lfp2,sr,Af5,Af6); % High gamma filtering
plot(EEG.times, lfp2_filt1, 'r'); hold on; % plot 4Hz
plot(EEG.times, lfp2_filt3, 'k'); hold on; % plot High gamma
title([num2str(Af5) '-' num2str(Af6) ' Hz']);
xlim(xlimit);



subplot(5,2,10);

set(gca,'fontsize', 15); hold on;
% dat_to_plot2= squeeze( ZSCORE.data(days,exp,:,:,m,tr,ch2));
imagesc(time_list, freq_list, imgaussfilt(dat_to_plot2,gausn)); axis xy
colormap jet
colorbar off;
csnum=-0.2;
cnum=6
caxis([0 0.0001]);
% caxis([csnum cnum]);
ylim(ylimit);
xlim(xlimit);
hold on;

plot([120 120],[0 300], ':' ,'color', 'w' , 'linewidth',5)
plot([180 180],[0 300], ':','color', 'w','linewidth',6)
plot([240 240],[0 300], ':','color', 'w','linewidth',5)
xlabel(['Time (s)'],'fontsize', 20);
ylabel(['Freq (Hz)'],'fontsize', 20);


drawnow;
pause(0.1);


%% PFC랑 BLA랑 겹쳐서 그리기 ! gamma 부분! 비슷하게 나타나는데 겹쳐서 확인해보기!

% xlimit=[153 155];
% xticks3=[153:0.2:155];
figure(33);
set(gcf,'color','white');
set(gcf,'units','normalized','outerposition',[0 0.4 1 0.4]); hold on;    
plot(EEG.times, EEG.data(1,:) ,'k-'); hold on;
plot(EEG.times, lfp1_filt2*3, 'r'); hold on;
% plot(EEG.times,EEG.data(2,:),'r'); hold on;
title([{[' day' num2str(days) ' exp' num2str(exp) ' mouse' num2str(m) ' trial' num2str(tr) ]}, {'BLA & PFC'}],  'fontsize', 20); hold on;
legend('BLA','PFC', 'fontsize',20);
xlim(xlimit);
ylim([-0.3 0.3]);
% xticks(xticks3);
set(gca,'fontsize',16); 

%% PFC랑 BLA랑 겹쳐서 그리기 ! gamma 부분! 비슷하게 나타나는데 겹쳐서 확인해보기!

% xlimit=[153 155];
% xticks3=[153:0.2:155];
figure(33);
set(gcf,'color','white');
set(gcf,'units','normalized','outerposition',[0 0.4 1 0.4]); hold on;    
subplot(2,1,1);
set(gca,'fontsize',16); hold on;
plot(EEG.times, EEG.data(1,:) ,'k-'); hold on;
plot(EEG.times,EEG.data(2,:),'r'); hold on;
xlim(xlimit);
legend('BLA','PFC', 'fontsize',20);

subplot(2,1,2);
plot(EEG.times, lfp1_filt1*3, 'k'); hold on;
plot(EEG.times, lfp2_filt1*5, 'r'); hold on;
title([{[' day' num2str(days) ' exp' num2str(exp) ' mouse' num2str(m) ' trial' num2str(tr) ]}, {'BLA & PFC'}],  'fontsize', 20); hold on;
legend('BLA','PFC', 'fontsize',20);
xlim(xlimit);
ylim([-0.3 0.3]);
% xticks(xticks3);
set(gca,'fontsize',16); 


%%

% xlimit=[167 170];
% xlimit=[155 158];
% xlimit=[140 143];
% xlimit=[167 169];
figure(8);
xlimit=[st-1 st+2];
    
Af3=30;
Af4=50;
Af5=70;
Af6=120;

Tf1=3.5;
Tf2=4.5;

figure(6);
set(gcf,'color','white');
set(gcf,'units','normalized','outerposition',[0.1 0.1 0.5 0.9]); hold on;    

for st=100:360;
xlimit=[st-1 st+2];
    
ch=1;
subplot(5,2,1);
plot(EEG.times, lfp1 ,'k-');
title([{[' day' num2str(days) ' exp' num2str(exp) ' mouse' num2str(m) ' trial' num2str(tr) ]}, {'BLA'}],  'fontsize', 20);
xlim(xlimit);
set(gca,'fontsize',16); 


% Filtering - 4Hz
subplot(5,2,3);
set(gca,'fontsize', 15); hold on;
plot(EEG.times, lfp1_filt1, 'k'); % plot 4hz-filtered signal
% ylim([-0.08 0.08]);
xlim(xlimit);

% Filtering - Low gamma
subplot(5,2,5);
set(gca,'fontsize', 15); hold on;
plot(EEG.times, lfp1_filt1*4, 'r'); hold on; % 4Hz plot
plot(EEG.times, lfp1_filt2, 'k'); hold on; % Low gamma plot
xlim(xlimit);


% Filtering - High gamma
subplot(5,2,7);
set(gca,'fontsize', 15); hold on;
plot(EEG.times, lfp2_filt, 'r'); hold on; % 4Hz plot
plot(EEG.times, lfp4_filt, 'k'); hold on; % High gamma plot
xlim(xlimit);


subplot(5,2,9);

set(gca,'fontsize', 15); hold on;
imagesc(time_list+1, freq_list, imgaussfilt(dat_to_plot1,gausn)); axis xy
colormap jet
colorbar off;
csnum=-0.2;
cnum=6
caxis([csnum cnum]);
ylim(ylimit);
xlim(xlimit);
hold on;

plot([120 120],[0 300], ':' ,'color', 'w' , 'linewidth',5)
plot([180 180],[0 300], ':','color', 'w','linewidth',6)
plot([240 240],[0 300], ':','color', 'w','linewidth',5)
xlabel(['Time (s)'],'fontsize', 20);
ylabel(['Freq (Hz)'],'fontsize', 20);



%%%%%%% 여기부터는 PFC

ch=2;
subplot(5,2,2);
plot(EEG.times, EEG.data(ch,:) ,'k-');
title([{[' day' num2str(days) ' exp' num2str(exp) ' mouse' num2str(m) ' trial' num2str(tr) ]}, {'PFC'}],  'fontsize', 20);
xlim(xlimit);
set(gca,'fontsize',16); 


% Filtering - 4Hz
subplot(5,2,4);
set(gca,'fontsize', 15); hold on;
lfp2=EEG.data(ch,:);
plot(EEG.times, lfp2_filt1, 'k'); % plot 4Hz
% ylim([-0.08 0.08]);
xlim(xlimit);


% Filtering - Low gamma
subplot(5,2,6);
set(gca,'fontsize', 15); hold on;
plot(EEG.times, lfp2_filt1*4, 'r'); hold on; % plot 4Hz
plot(EEG.times, lfp2_filt2, 'k'); hold on; % plot Low gamma
xlim(xlimit);



% Filtering - High gamma
subplot(5,2,8);
set(gca,'fontsize', 15); hold on;
plot(EEG.times, lfp2_filt1, 'r'); hold on; % plot 4Hz
plot(EEG.times, lfp2_filt3, 'k'); hold on; % plot High gamma
xlim(xlimit);



subplot(5,2,10);

set(gca,'fontsize', 15); hold on;
imagesc(time_list+1, freq_list, imgaussfilt(dat_to_plot2,gausn)); axis xy
colormap jet
colorbar off;
csnum=-0.2;
cnum=6
caxis([csnum cnum]);
ylim(ylimit);
xlim(xlimit);
hold on;

plot([120 120],[0 300], ':' ,'color', 'w' , 'linewidth',5)
plot([180 180],[0 300], ':','color', 'w','linewidth',6)
plot([240 240],[0 300], ':','color', 'w','linewidth',5)
xlabel(['Time (s)'],'fontsize', 20);
ylabel(['Freq (Hz)'],'fontsize', 20);


drawnow;
pause(0.1);
end





%%
lfp1=EEG.data(1,:);
lfp2=EEG.data(2,:);


for st=200:360;
    
    figure(7);
    set(gcf,'color','white');
    set(gcf,'units','normalized','outerposition',[0.1 0.4 0.8 0.5]); hold on;    

    xlimit=[st-1 st+2];
    subplot(2,1,1);
    plot(EEG.times, lfp1 ,'k-'); hold on;
    plot(EEG.times, lfp1_filt1*3, 'r'); % plot 4Hz
    title([{[' day' num2str(days) ' exp' num2str(exp) ' mouse' num2str(m) ' trial' num2str(tr) ]}, {'BLA'}],  'fontsize', 20);
    xlim(xlimit);
    set(gca,'fontsize',16); 

    subplot(2,1,2);
    plot(EEG.times, lfp2 ,'k-'); hold on;
    plot(EEG.times, lfp2_filt1*3, 'r'); % plot 4Hz
    title(['PFC'],  'fontsize', 20);
    xlim(xlimit);
    set(gca,'fontsize',16); 
    
    drawnow;
    pause(0.01);
    
end

% 122초 


