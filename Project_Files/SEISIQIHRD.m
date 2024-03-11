function [S,E,I,SI,Q,IH,R,D] = SEISIQIHRD(u,a,b,c,d,e,f,g,h,i,j,k,l,m,n,Npop,E0,I0,SI0,Q0,IH0,R0,D0,t)
%
% Input
%
%   a: scalar [1x1]: healthy -> exposed rate
%   b: scalar [1x1]: exposed -> infected = infection rate
%   c: scalar [1x1]: infected -> sick 
%   d: scalar [1x1]: infected -> in_quarantine fitted  rate at which people enter in quarantine
%   e: scalar [1x1]: infected -> recovered = recovery rate (asymptomatic)
%   f: scalar [1x1]: sick -> recovered
%   g: scalar [1x1]: sick -> in hospital
%   h: scalar [1x1]: sick -> in quarantine
%   i: scalar [1x1]: sick -> dead
%   j: scalar [1x1]: in quarantine -> recovered
%   k: scalar [1x1]: in quarantine -> in hospital
%   l: scalar [1x1]: in quarantine -> dead
%   m: scalar [1x1]: in hospital -> recovered
%   n: scalar [1x1]: in hospital -> dead
%   Npop: scalar: Total population of the sample
%   E0: scalar [1x1]: Initial number of exposed cases
%   I0: scalar [1x1]: Initial number of infectious cases
%   SI0: scalar [1x1]: Initial number of sick cases
%   Q0: scalar [1x1]: Initial number of quarantined cases
%   IH0: scalar [1x1]: Initial number of hospitalized cases
%   R0: scalar [1x1]: Initial number of recovered cases
%   D0: scalar [1x1]: Initial number of dead cases
%   t: vector [1xN] of time (double; it cannot be a datetime)
% 
% 
% Output
%   S: vector [1xN] of the target time-histories of the susceptible cases
%   E: vector [1xN] of the target time-histories of the exposed cases
%   I: vector [1xN] of the target time-histories of the infectious cases
%   SI: vector [1xN] of the target time-histories of the sick cases
%   Q: vector [1xN] of the target time-histories of the quarantined cases
%   IH: vector [1xN] of the target time-histories of the hospitalized cases
%   R: vector [1xN] of the target time-histories of the recovered cases
%   D: vector [1xN] of the target time-histories of the dead cases

%% Initial conditions
N = numel(t);
% Y=[healthy,exposed,infected,sick,in_q,i_hospital,recovered,dead]
Y = zeros(8,N);
Y(1,1) = Npop-E0-I0-SI0-Q0-IH0-R0-D0;
Y(2,1) = E0;
Y(3,1) = I0;
Y(4,1) = SI0;
Y(5,1) = Q0;
Y(6,1) = IH0;
Y(7,1) = R0;
Y(8,1) = D0;

if round(sum(Y(:,1))-Npop)~=0
    error(['the sum must be zero because the total population',...
        ' (including the deads) is assumed constant']);
end
%% Computes the seven states
modelFun = @(Y,A,F) A*Y + F;
dt = median(diff(t));

% ODE resolution

for ii=1:N-1
    for iter=0:25       
        if(ii==floor(50+iter*5))
            if (iter < 10) b = 0.92*b;
        else
            d = d*1.2;
            a = a*0.85;
            e = 0.9*e;
            end
        end
    end
    du = d + u;  %Testy zwiêkszaj¹ prawdopodobieñstwo przejœcia niewykrytego zaka¿enia w kwarantannê
    A = getA(u,a,b,c,du,e,f,g,h,i,j,k,l,m,n);
    I_SI_IQ_IH_sum = Y(3,ii) + Y(4,ii) + Y(5,ii) + Y(6,ii);
    H_times_sum = Y(1,ii) * I_SI_IQ_IH_sum;
    F = zeros(8,1); 
    F(1:2,1) = [-a/Npop;a/Npop].*H_times_sum;
    Y(:,ii+1) = RK4(modelFun,Y(:,ii),A,F,dt);
end
%% Write the outputs
S = Y(1,1:N);
E = Y(2,1:N);
I = Y(3,1:N);
SI = Y(4,1:N);
Q = Y(5,1:N);
IH = Y(6,1:N);
R = Y(7,1:N);
D = Y(8,1:N);


%% Nested functions
    function [A] = getA(u,a,b,c,du,e,f,g,h,i,j,k,l,m,n)
        %  computes the matrix A
        %  that is found in: dY/dt = A*Y + F
        %
        %   a: scalar [1x1]: healthy -> exposed rate
        %   b: scalar [1x1]: exposed -> infected = infection rate
        %   c: scalar [1x1]: infected -> sick 
        %   d: scalar [1x1]: infected -> in_quarantine fitted rate at which people enter in quarantine
        %   e: scalar [1x1]: infected -> recovered = recovery rate (asymptomatic)
        %   f: scalar [1x1]: sick -> recovered
        %   g: scalar [1x1]: sick -> in hospital
        %   h: scalar [1x1]: sick -> in quarantine
        %   i: scalar [1x1]: sick -> dead
        %   j: scalar [1x1]: in quarantine -> recovered
        %   k: scalar [1x1]: in quarantine -> in hospital
        %   l: scalar [1x1]: in quarantine -> dead
        %   m: scalar [1x1]: in hospital -> recovered
        %   n: scalar [1x1]: in hospital -> dead
        %   Output:
        %   A: matrix: [8x8]
        
        A = zeros(8);
        % H
        A(1,3:6) = 0;
        % E
        A(2,3:6) = 0;
        A(2,2) = -b;
        % I
        A(3,2) = b;
        A(3,3) = -c-du-e;
        % S
        A(4,3) = c;
        A(4,4) = -f-g-h-i;
        % Q
        A(5,3) = du;
        A(5,4) = h;
        A(5,5) = -j-k-l;
        % IH
        A(6,4) = g;
        A(6,5) = k;
        A(6,6) = -m-n;        
        % R
        A(7,3) = e;
        A(7,4) = f;
        A(7,5) = j;
        A(7,6) = m;
        % D
        A(8,4) = i;
        A(8,5) = l;
        A(8,6) = n;        
    end
    function [Y] = RK4(Fun,Y,A,F,dt)
        % Runge-Kutta of order 4
        k_1 = Fun(Y,A,F);
        k_2 = Fun(Y+0.5*dt*k_1,A,F);
        k_3 = Fun(Y+0.5*dt*k_2,A,F);
        k_4 = Fun(Y+k_3*dt,A,F);
        % Output
        Y = Y + (1/6)*(k_1+2*k_2+2*k_3+k_4)*dt;
    end
end


