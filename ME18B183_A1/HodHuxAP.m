%THIS FUNCTION DEMONSTRATES HODGKIN HUXLEY MODEL IN CURRENT CLAMP EXPERIMENTS AND SHOWS ACTION POTENTIAL PROPAGATION
%Time is in secs, voltage in mvs, conductances in m mho/mm^2, capacitance
%in uF/mm^2, current in microampere

function Voltage=HodHuxAP(current) 
    
    ImpCur=current; %Impulse Current
    gkmax=.36; %maximum conductance value for K+ ions
    vk=-77; %Voltage difference due K+ ion movement  
    gnamax=1.20; %maximum conductance value for Na+ ions 
    vna=50; %Voltage difference due Na+ ion movement   
    gl=0.003; %conductance value of leakage channels
    vl=-54.387; %Voltage difference in the leakage channels
    cm=.01; %C_m (Capacitance of the neural layer) 

    dt=0.01;
    niter=10000;
    iapp=ImpCur*ones(1,niter);

    v=-64.9964;
    m=0.0530;
    h=0.5960;
    n=0.3177;

    vhist=zeros(1,niter);

    %The follwing loop solves the differential equation iteratively and gives us Voltage values as vhist 
    for iter=1:niter
        gna=gnamax*m^3*h; 
        gk=gkmax*n^4; 
        gtot=gna+gk+gl;
        vinf = ((gna*vna+gk*vk+gl*vl)+ iapp(iter))/gtot;
        tauv = cm/gtot;
        v=vinf+(v-vinf)*exp(-dt/tauv);
        alpham = 0.1*(v+40)/(1-exp(-(v+40)/10));
        betam = 4*exp(-0.0556*(v+65));
        alphan = 0.01*(v+55)/(1-exp(-(v+55)/10));
        betan = 0.125*exp(-(v+65)/80);
        alphah = 0.07*exp(-0.05*(v+65));
        betah = 1/(1+exp(-0.1*(v+35)));
        taum = 1/(alpham+betam);
        tauh = 1/(alphah+betah);
        taun = 1/(alphan+betan);
        minf = alpham*taum;
        hinf = alphah*tauh;
        ninf = alphan*taun;
        m=minf+(m-minf)*exp(-dt/taum);
        h=hinf+(h-hinf)*exp(-dt/tauh);
        n=ninf+(n-ninf)*exp(-dt/taun);
        vhist(iter)=v;
    end
    
    Voltage=vhist; %All the values of vhist are stored in Voltage (1x10000 double)
end 