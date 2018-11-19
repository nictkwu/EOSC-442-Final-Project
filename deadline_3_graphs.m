clear
close all
clc

%Each of the locations� data will be plot against air surface temperature 
%to investigate if there a relationship or significant correlation between 
%air surface temperature and active layer thickness. Finally the yearly 
%rates of change at the two locations will be compared through a  a one-way
%ANOVA test to check for significant difference. We intend to compare our 
%results with the �Thermal State of Permafrost and Active Layer in Central 
%Asia during the International Polar Year.� study that is described at 
%the end of this document.
%==============================================================================================================
%RAW DATA

quttinirpaaq_data = xlsread('Quttinirpaaq.xlsx');
Qyears_data = quttinirpaaq_data(:,3);
Qgrid_number = quttinirpaaq_data(:,4);
Qfirst_thickness = quttinirpaaq_data(:,5);
Qsecond_thickness = quttinirpaaq_data(:,6);
Qmatrix1=[Qfirst_thickness(:),Qsecond_thickness(:)];
QmatrixT= transpose(Qmatrix1);
QmatrixT(QmatrixT == -99999) = NaN;
Qaverage_thickness = nanmean(QmatrixT);

Qfirst_thickness(Qfirst_thickness == -99999) = NaN;
Qmask1 = ~(isnan(Qfirst_thickness)| isnan(Qyears_data));
Qsecond_thickness(Qsecond_thickness == -99999) = NaN;
Qmask2 = ~(isnan(Qsecond_thickness)| isnan(Qyears_data));


auyuittuq_data = xlsread('Auyuittuq.xlsx');
Ayears_data = auyuittuq_data(:,3);
Agrid_number = auyuittuq_data(:,4);
Afirst_thickness = auyuittuq_data(:,5);
Asecond_thickness = auyuittuq_data(:,6);
Amatrix1=[Afirst_thickness(:),Asecond_thickness(:)];
AmatrixT= transpose(Amatrix1);
AmatrixT(AmatrixT == -99999) = NaN;
Aaverage_thickness = nanmean(AmatrixT);

%Amask = ~(isnan(Afirst_thickness)| isnan(Qyears_data));


%PLOT RAW DATA

figure
subplot(211)
plot(Qyears_data(Qmask1),Qfirst_thickness(Qmask1), '-*k');
title('Active Layer Thickness RAW data (all points) Quttinirpaaq Measurement 1');
ylabel('Thickness (cm)');
xlabel('Year');
grid on
grid minor


subplot(212)
plot(Qyears_data(Qmask2),Qsecond_thickness(Qmask2), '-*k');
title('Active Layer Thickness RAW data (all points) Quttinirpaaq  Measurement 2');
ylabel('Thickness (cm)');
xlabel('Year');
grid on
grid minor


auyuittuq_data = xlsread('Auyuittuq.xlsx');
Ayears_data = auyuittuq_data(:,3);
Agrid_number = auyuittuq_data(:,4);
Afirst_thickness = auyuittuq_data(:,5);
Asecond_thickness = auyuittuq_data(:,6);
Amatrix1=[Afirst_thickness(:),Asecond_thickness(:)];
AmatrixT= transpose(Amatrix1);
AmatrixT(AmatrixT == -99999) = NaN;
Aaverage_thickness = nanmean(AmatrixT);

Afirst_thickness(Afirst_thickness == -99999) = NaN;
Amask1 = ~(isnan(Afirst_thickness)| isnan(Ayears_data));
Asecond_thickness(Asecond_thickness == -99999) = NaN;
Amask2 = ~(isnan(Asecond_thickness)| isnan(Ayears_data));


figure
subplot(211)
plot(Ayears_data(Amask1),Afirst_thickness(Amask1), '-*k');
title('Active Layer Thickness RAW data (all points) Auyuittuq Measurement 1');
ylabel('Thickness (cm)');
xlabel('Year');
grid on
grid minor


subplot(212)
plot(Ayears_data(Amask2),Asecond_thickness(Amask2), '-*k');
title('Active Layer Thickness RAW data (all points) Auyuittuq  Measurement 2');
ylabel('Thickness (cm)');
xlabel('Year');
grid on
grid minor

%==============================================================================================================
%AVG DATA


Qyearly_avg=[];
Qrow = 1;
for year = 1999:2017
        Qcondition = Qyears_data == year;
        Qyavg= nanmean(Qaverage_thickness(Qcondition));
        Qyearly_avg(Qrow)= Qyavg;
        Qmax_per_year(Qrow) = max(Qaverage_thickness(Qcondition));
        Qmin_per_year(Qrow)= min(Qaverage_thickness(Qcondition));
        Qstd_per_year(Qrow)= nanstd(Qaverage_thickness(Qcondition));
        Qrow = Qrow+1;
end

Qyears=[1999:2017];
Qstd_positive = Qyearly_avg + Qstd_per_year;
Qstd_negative =Qyearly_avg - Qstd_per_year;



Ayearly_avg=[];
Arow = 1;
for year = 2009:2017
        Acondition = Ayears_data == year;
        Ayavg= nanmean(Aaverage_thickness(Acondition));
        Ayearly_avg(Arow)= Ayavg;
        Amax_per_year(Arow) = max(Aaverage_thickness(Acondition));
        Amin_per_year(Arow)= min(Aaverage_thickness(Acondition));
        Astd_per_year(Arow)= nanstd(Aaverage_thickness(Acondition));
        Arow = Arow+1;
end

Ayears=[2009:2017];
Astd_positive = Ayearly_avg + Astd_per_year;
Astd_negative =Ayearly_avg - Astd_per_year;


%PLOT AVG DATA
figure
subplot(211)
axis([1998,2018,34,90]);
hold on
plot(Qyears,Qyearly_avg, '-*k','linewidth', 2);
plot(Qyears,Qstd_positive, '--r');
plot(Qyears,Qstd_negative, '--b');
plot(Qyears,Qmax_per_year, '^r', 'Markersize', 4);
plot(Qyears,Qmin_per_year, 'vb', 'Markersize', 4);
title('Active Layer Thickness Yearly Average Quttinirpaaq');
ylabel('Thickness (cm)');
xlabel('Year');
lgnd = {'thickness mean', 'thickness mean + \sigma','thickness mean - \sigma', 'thickness max', 'thickness min'};
legend(lgnd,'location','NorthWest')
grid on
grid minor
hold off

subplot(212)
axis([2008,2018,14,72]);
hold on
plot(Ayears,Ayearly_avg, '-*k','linewidth', 2);
plot(Ayears,Astd_positive, '--r');
plot(Ayears,Astd_negative, '--b');
plot(Ayears,Amax_per_year, '^r', 'Markersize', 4);
plot(Ayears,Amin_per_year, 'vb', 'Markersize', 4);
title('Active Layer Thickness Yearly Average Auyuittuq');
ylabel('Thickness (cm)');
xlabel('Year');
lgnd = {'thickness mean', 'thickness mean + \sigma','thickness mean - \sigma', 'thickness max', 'thickness min'};
legend(lgnd,'location','NorthEast')
grid on
grid minor
hold off