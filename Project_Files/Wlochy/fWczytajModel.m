function plansza = fWczytajModel(plansza, num, raw_num, dzielnik)

inf_sick=0.8;   %stosunek infected do infected&sick (80% - brak objawów, 20% - objawy)

POPULATION = num(1,17);
INFECTED = (num(raw_num,5)-num(raw_num,7)-num(raw_num,9))*inf_sick;
HEALTHY  = POPULATION-num(raw_num,5)-num(raw_num,7)-num(raw_num,9)-num(raw_num,11)-num(raw_num,12)-num(raw_num,13);
IN_QUARANTINE = num(raw_num,13);
SICK = (num(raw_num,10)-INFECTED);
INFECTED_SICK = INFECTED*(1-inf_sick);
IN_HOSPITAL = num(raw_num,11);
RECOVERED = num(raw_num,7);
DEAD = num(raw_num,9);

POPULATION = round(POPULATION/dzielnik);
INFECTED = round(INFECTED/dzielnik);
HEALTHY = round(HEALTHY/dzielnik);
IN_QUARANTINE = round(IN_QUARANTINE/dzielnik);
SICK = round(SICK/dzielnik/2);
INFECTED_SICK = round(INFECTED_SICK/dzielnik);
IN_HOSPITAL = round(IN_HOSPITAL/dzielnik);
RECOVERED = round(RECOVERED/dzielnik);
DEAD = round(DEAD/dzielnik);

%Rozpoczynam wype³nianie planszy kolejnymi stanami. Zastosuje
%reprezentacjê:
% 0 - HEALTHY
% 1 - INFECTED
% 2 - IN_QUARANTINE
% 3 - SICK
% 4 - INFECTED & SICK
% 5 - IN_HOSPITAL
% 6 - RECOVERED
% 7 - DEAD
% 8 - VIRUS

%plansza(randperm(numel(plansza), HEALTHY))=1;     %HEALTHY
%sprawdzenie(plansza,HEALTHY,1);       

%funkcja losujaca z zer i podmieniajaca losowo zadana ilosc elementow na zadana
%wartoœæ (in-plansza, ilosc elem, wartosc reprezentatywna out-plansza
%zmieniona)

VIRUS=round(INFECTED/64/2);

plansza = wypelnij_czesc(plansza,0,INFECTED,1);
%sprawdzenie(plansza,INFECTED,1);
plansza = wypelnij_czesc(plansza,0,IN_QUARANTINE,2);
%sprawdzenie(plansza,IN_QUARANTINE,2); 
plansza = wypelnij_czesc(plansza,0,SICK,3);
%sprawdzenie(plansza,SICK,3);
plansza = wypelnij_czesc(plansza,0,INFECTED_SICK,4);
%sprawdzenie(plansza,INFECTED_SICK,4);
plansza = wypelnij_czesc(plansza,0,IN_HOSPITAL,5);
%sprawdzenie(plansza,IN_HOSPITAL,5);
plansza = wypelnij_czesc(plansza,0,RECOVERED,6);
%sprawdzenie(plansza,RECOVERED,6);
plansza = wypelnij_czesc(plansza,0,DEAD,7);
%sprawdzenie(plansza,DEAD,7);
plansza = wypelnij_czesc(plansza,0,VIRUS,8);

%Wyznaczanie prawdopodobieñstw
no_security = get_no_security_m(num,raw_num);
if no_security <0.6
    infecting=0.2;
elseif no_security >= 0.6 && no_security <= 0.9
    infecting=0.1;
else
    infecting=0;
end

%Wczytywanie atrybutów.

%Healthy - no security measures OR self_protecting
plansza = wypelnij_czesc(plansza,0, round(sum(plansza(:)==0)*no_security), 0.1);
plansza = wypelnij_czesc(plansza,0, sum(plansza(:)==0), 0.3);

%Infected - no security measures OR infecting OR protecting_others
plansza = wypelnij_czesc(plansza,1, round(INFECTED*no_security), 1.1);
plansza = wypelnij_czesc(plansza,1, round(INFECTED*infecting), 1.2);
plansza = wypelnij_czesc(plansza,1, sum(plansza(:)==1), 1.4);

%In_quarantine - organizing protection
plansza = wypelnij_czesc(plansza,2, IN_QUARANTINE, 2.5);

%Sick - no security measures OR self_protecting 
plansza = wypelnij_czesc(plansza,3, round(SICK*no_security), 3.1);
plansza = wypelnij_czesc(plansza,3, sum(plansza(:)==3), 3.3);

%Infected_and_sick - no security measures OR infecting OR protecting_others
plansza = wypelnij_czesc(plansza,4, round(INFECTED_SICK*no_security), 4.1);
plansza = wypelnij_czesc(plansza,4, round(INFECTED_SICK*infecting), 4.2);
plansza = wypelnij_czesc(plansza,4, sum(plansza(:)==4), 4.4);

%In_hospital - organizing protection
plansza = wypelnij_czesc(plansza,5, sum(plansza(:)==5), 5.5);

%Recovered - no security measures OR self_protecting 
plansza = wypelnij_czesc(plansza,6, round(RECOVERED*no_security), 6.1);
plansza = wypelnij_czesc(plansza,6, sum(plansza(:)==6), 6.3);

%Virus - no security measures OR infecting OR self_protecting
plansza = wypelnij_czesc(plansza,8, round(VIRUS*no_security), 8.1);
plansza = wypelnij_czesc(plansza,8, round(VIRUS*infecting), 8.2);
plansza = wypelnij_czesc(plansza,8, sum(plansza(:)==8), 8.3);