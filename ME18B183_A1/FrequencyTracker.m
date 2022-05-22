%for keeping track of frequency for all current inputs 0.001 microamp. to 1
%microamp.
Frequency=(1:1000);

%input current values 0.001 microamp. to 1 microamp. 
Iext=(1:1000)*10^(-3);

%tracker for counting Action Potentials for given current input
tracker=0;

%loop for iterating over all 1000 input current values
for i=1:1000
    count=0; %to keep a count of observed Action Potentials
    Voltage=HodHuxAP(Iext(i)); %calling HodHuxAP function to get 10000 Voltage values for current Iext(i)
    
    %loop that iterates over all 10000 Voltage values for checking APs
    for niter=1:10000
        if Voltage(niter)>=5 && tracker==0 %Voltage threshold for classifying a ping as AP is 5mV
            count=count+1; %increase count by 1 every time an AP is observed
            tracker=1; %keeping tracker as 1 so that it doesnt count a single AP multiple times in count variable
        elseif Voltage(niter)<5
            tracker=0;
        end
    end
    
    Frequency(i)=count/100; %count is divided by 100 to get frequency because all our currents are applied for 100 seconds
    
end 

%Plotting Frequency v/s Iext and finding I1, I2 and I3.
figure(1)
plot(Iext,Frequency,'r-','Linewidth',1);
title('Firing Rate (frequency) v/s I_{ext}');
xlim([0 0.8]);
ylim([0 0.14]);
xlabel('I_{ext} in microampere');
ylabel('No. of Action Potentials per second');