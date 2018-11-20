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
%%
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
%%
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


%==============================================================================================================
%TEMPERATURE TIME-SERIES

%%
% Loading the Monthly Temperature Data

% Quttinirpaaq/Eureka Data
QTempData = xlsread('Eureka.csv');
QTempmonth = QTempData(:,2);
Qmintemp = QTempData(:,5);
Qmaxtemp = QTempData(:,3);
Qmeantemp = QTempData(:,7);

% Auyuttuq/Cape Hooper Data
ATempdata = xlsread('CAPEHOOPER.csv');
Atempmonth = ATempdata(:,2);
Amintemp = ATempdata(:,5);
Amaxtemp = ATempdata(:,3);
Ameantemp = ATempdata(:,7);

%% 
% Quttinirpaaq Plot
for month = 1:12
    meanmintemp(month) = nanmean(Qmintemp(QTempmonth == month));
    meanmaxtemp(month)= nanmean(Qmaxtemp(QTempmonth == month));
    meantemp(month)= nanmean(Qmeantemp(QTempmonth == month));
end

months = (1:12);
figure
hold on
plot(months,meanmintemp,'.');plot(months,meanmaxtemp,'+');plot(months,meantemp,'--');
legend('Minimum Temperature','Maximum Temperature','Average Temperature','Location','se');
title('Mean Monthly Temperature from 1947-2016 at Eureka(Quttinirpaaq)');xlabel('Month');ylabel('Temperature (degrees Celcius)');

% table
t_month = transpose(months);
t_max = transpose(meanmaxtemp);
t_min = transpose(meanmintemp);
t_temp = transpose(meantemp);
T = table(t_month, t_min, t_temp, t_max);

%%
% Auyuttuq Plot
for month = 1:12
    meanmintemp(month) = nanmean(Amintemp(Atempmonth == month));
    meanmaxtemp(month)= nanmean(Amaxtemp(Atempmonth == month));
    meantemp(month)= nanmean(Ameantemp(Atempmonth == month));
end

months = (1:12);
figure
hold on
plot(months,meanmintemp,'.');
plot(months,meanmaxtemp,'+');
plot(months,meantemp,'--');
legend('Minimum Temperature','Maximum Temperature','Average Temperature','Location','se');
title('Mean Monthly Temperature from 1957-2007 at Cape Hooper(Auyuittuq)');
xlabel('Month');
ylabel('Temperature (degrees Celcius)');

% table
t_month = transpose(months);
t_max = transpose(meanmaxtemp);
t_min = transpose(meanmintemp);
t_temp = transpose(meantemp);
T = table(t_month, t_min, t_temp, t_max);


%==============================================================================================================
%%
%RATE OF CHANGE IN THICKNESS DATA

%%rate of change = slope = (y2-y1)/(x2-x1)
Ayearly_rate_change=[];
Arow = 2;
for year = 2010:2017
        Acondition = Ayears_data == year;
        A_slope= Ayearly_avg(Arow)-Ayearly_avg(Arow-1);
        Ayearly_rate_change(Arow-1)= A_slope;
        Arow = Arow+1;
end
Ayears=[2009:2016];

Qyearly_rate_change=[];
Qrow = 2;
for year = 2010:2017
        Qcondition = Qyears_data == year;
        Q_slope= Qyearly_avg(Qrow)-Qyearly_avg(Qrow-1);
        Qyearly_rate_change(Qrow-1)= Q_slope;
        Qrow = Qrow+1;
end
Qyears=[2009:2016];

figure
hold on
plot(Ayears,Ayearly_rate_change,'k-');
plot(Qyears,Qyearly_rate_change,'r-');
axis([2008,2017,-12,12]);
legend('Auyuittuq thickness rate of change','Quttinirpaaq thickness rate of change');
title('Rate of change in permafrost thickness agaisnt time');
xlabel('Year');
ylabel('Rate of change in thickness (cm per year)');
grid on
grid minor

%==============================================================================================================
%%
%TEMP VS THICKNESS

row = 1;
Asummer_avg = [];
Asummer_mean_total=0;
for year = 2009:2017
    for month = 6:8
        Asummer_mean_total = Asummer_mean_total + nanmean(Ameantemp(Atempmonth == month));
    end
    Asummer_avg(row) = Asummer_mean_total/3;
    row = row + 1;
end


row = 1;
Qsummer_avg = [];
Qsummer_mean_total=0;
for year = 2009:2017
    for month = 6:8
        Qsummer_mean_total = Qsummer_mean_total + nanmean(Qmeantemp(QTempmonth == month));
    end
    Qsummer_avg(row) = Qsummer_mean_total/3;
    row = row + 1;
end



Qyearly_avg=[];
Qrow = 1;
for year = 2009:2017
        Qcondition = Qyears_data == year;
        Qyavg= nanmean(Qaverage_thickness(Qcondition));
        Qyearly_avg(Qrow)= Qyavg;
        Qrow = Qrow+1;
end



qmask= ~(isnan(Qyearly_avg)|isnan(Qsummer_avg));
amask=~(isnan(Ayearly_avg)|isnan(Asummer_avg));

figure
hold on
plot(Asummer_avg(amask),Ayearly_avg(amask), 'r.', 'Markersize', 24);
plot(Qsummer_avg(qmask),Qyearly_avg(qmask),'b.', 'Markersize', 24);
hold off