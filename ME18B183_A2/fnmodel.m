% This scipt helps in plotting v(t) and w(t) of FitzHugh Nagumo model
% For plotting phase plots we have used pplane8

% number of iterations
niter=1000; 

% Initializing the parameters involved in modeling the neuron
I_ext=0;
a=0.5;
b=0.02;
r=1.0;

% defining v as a 1x1000 double
v=zeros(1,niter);
% initiating v(1)=0.2
v(1)=1.2; 

% defining w as a 1x1000 double
w=zeros(1,niter); 
% We haven't initialized w(1) to a non-zero number as it isn't asked in the
% problem statement

% initializing delta_t as dt with a value of 0.1 for using Euler
% Integration method
dt=0.1;
% defining t as a 1x1000 double
t= (0:niter-1)*dt;

% for loop for calculating v(t) and w(t) using the Euler Integration method  
for i = 1:niter-1
    v(i+1) = v(i) + dt*(f(v(i),a) - w(i) + I_ext);               
    w(i+1) = w(i) + dt*((b*v(i)) - (r*w(i)));
end

% v(t) vs t plot
figure(1)
plot(t,v);
ylabel('v(t)');
xlabel('t');

% w(t) vs t plot
figure(2)
plot(t,w);
ylabel('w(t)');
xlabel('t');

% the following function computes & returns f(v), where f(v)=v*(a-v)*(v-1)
function vol=f(voltage,a)
    vol=voltage*(a-voltage)*(voltage-1);
end