%% Autor: Karolina Œwierczek
% funkcja zlicza sasiadow komorki (x,y) wg sasiedztwa Moore'a

function [sas01,sas03,sas15,sas21,sas22,sas24,sas31,sas33,sas34,sas41,sas42,sas44,sas55,sas61,sas63,sas75] = f_policz_sasiadow(plansza,x,y)
    %sumaQ2Q1 - suma sasiadow o stanach Q2.Q1:
    suma01 = 0;
    suma03 = 0;
    suma15 = 0;
    suma21 = 0;
    suma22 = 0;
    suma24 = 0;
    suma31 = 0;
    suma33 = 0;
    suma34 = 0;
    suma41 = 0;
    suma42 = 0;
    suma44 = 0;
    suma55 = 0;
    suma61 = 0;
    suma63 = 0;
    suma75 = 0;
    
    % chcemy wiedziec, jakie sa ograniczenia planszy, zeby za nia nie "wyjechac"
    [w,k] = size(plansza);
    
    % wektor odl_w odpowiada za promien zliczania sasiedztwa:
    odl_w = [1];
    for odl = odl_w
        if x>odl % w przeciwnym razie nie ma co zliczac, bo nie ma nikogo u gory
            switch plansza(x-odl,y)
                case 0.1
                    suma01 = suma01+1;
                case 0.3
                    suma03 = suma03+1;
                case 1.5
                    suma15 = suma15+1;
                case 2.1
                    suma21 = suma21+1;
                case 2.2
                    suma22 = suma22+1;
                case 2.4
                    suma24 = suma24+1;
                case 3.1
                    suma31 = suma31+1;
                case 3.3
                    suma33 = suma33+1;
                case 3.4
                    suma34 = suma34+1;
                case 4.1
                    suma41 = suma41+1;
                case 4.2
                    suma42 = suma42+1;
                case 4.4
                    suma44 = suma44+1;
                case 5.5
                    suma55 = suma55+1;
                case 6.1
                    suma61 = suma61+1;
                case 6.3
                    suma63 = suma63+1;
                case 7.5
                    suma75 = suma75+1;
            end
        end
        if y>odl % w przeciwnym razie nie ma co zliczac, bo nie ma nikogo po lewej
            switch plansza(x,y-odl)
                case 0.1
                    suma01 = suma01+1;
                case 0.3
                    suma03 = suma03+1;
                case 1.5
                    suma15 = suma15+1;
                case 2.1
                    suma21 = suma21+1;
                case 2.2
                    suma22 = suma22+1;
                case 2.4
                    suma24 = suma24+1;
                case 3.1
                    suma31 = suma31+1;
                case 3.3
                    suma33 = suma33+1;
                case 3.4
                    suma34 = suma34+1;
                case 4.1
                    suma41 = suma41+1;
                case 4.2
                    suma42 = suma42+1;
                case 4.4
                    suma44 = suma44+1;
                case 5.5
                    suma55 = suma55+1;
                case 6.1
                    suma61 = suma61+1;
                case 6.3
                    suma63 = suma63+1;
                case 7.5
                    suma75 = suma75+1;
            end
        end
        if x<(w-(odl-1))  % w przeciwnym razie nie ma co zliczac, bo nie ma nikogo na dole
            switch plansza(x+odl,y)
                case 0.1
                    suma01 = suma01+1;
                case 0.3
                    suma03 = suma03+1;
                case 1.5
                    suma15 = suma15+1;
                case 2.1
                    suma21 = suma21+1;
                case 2.2
                    suma22 = suma22+1;
                case 2.4
                    suma24 = suma24+1;
                case 3.1
                    suma31 = suma31+1;
                case 3.3
                    suma33 = suma33+1;
                case 3.4
                    suma34 = suma34+1;
                case 4.1
                    suma41 = suma41+1;
                case 4.2
                    suma42 = suma42+1;
                case 4.4
                    suma44 = suma44+1;
                case 5.5
                    suma55 = suma55+1;
                case 6.1
                    suma61 = suma61+1;
                case 6.3
                    suma63 = suma63+1;
                case 7.5
                    suma75 = suma75+1;
            end
        end
        if y<(k-(odl-1)) % w przeciwnym razie nie ma co zliczac, bo nie ma nikogo po prawej
            switch plansza(x,y+odl)
                case 0.1
                    suma01 = suma01+1;
                case 0.3
                    suma03 = suma03+1;
                case 1.5
                    suma15 = suma15+1;
                case 2.1
                    suma21 = suma21+1;
                case 2.2
                    suma22 = suma22+1;
                case 2.4
                    suma24 = suma24+1;
                case 3.1
                    suma31 = suma31+1;
                case 3.3
                    suma33 = suma33+1;
                case 3.4
                    suma34 = suma34+1;
                case 4.1
                    suma41 = suma41+1;
                case 4.2
                    suma42 = suma42+1;
                case 4.4
                    suma44 = suma44+1;
                case 5.5
                    suma55 = suma55+1;
                case 6.1
                    suma61 = suma61+1;
                case 6.3
                    suma63 = suma63+1;
                case 7.5
                    suma75 = suma75+1;
            end
        end
        if x>odl && y>odl % w przeciwnym razie nie ma co zliczac, bo nie ma nikogo u gory po lewej
            switch plansza(x-odl,y-odl)
                case 0.1
                    suma01 = suma01+1;
                case 0.3
                    suma03 = suma03+1;
                case 1.5
                    suma15 = suma15+1;
                case 2.1
                    suma21 = suma21+1;
                case 2.2
                    suma22 = suma22+1;
                case 2.4
                    suma24 = suma24+1;
                case 3.1
                    suma31 = suma31+1;
                case 3.3
                    suma33 = suma33+1;
                case 3.4
                    suma34 = suma34+1;
                case 4.1
                    suma41 = suma41+1;
                case 4.2
                    suma42 = suma42+1;
                case 4.4
                    suma44 = suma44+1;
                case 5.5
                    suma55 = suma55+1;
                case 6.1
                    suma61 = suma61+1;
                case 6.3
                    suma63 = suma63+1;
                case 7.5
                    suma75 = suma75+1;
            end
        end
        if x>odl && y<(k-(odl-1)) % w przeciwnym razie nie ma co zliczac, bo nie ma nikogo u gory po prawej
            switch plansza(x-odl,y+odl)
                case 0.1
                    suma01 = suma01+1;
                case 0.3
                    suma03 = suma03+1;
                case 1.5
                    suma15 = suma15+1;
                case 2.1
                    suma21 = suma21+1;
                case 2.2
                    suma22 = suma22+1;
                case 2.4
                    suma24 = suma24+1;
                case 3.1
                    suma31 = suma31+1;
                case 3.3
                    suma33 = suma33+1;
                case 3.4
                    suma34 = suma34+1;
                case 4.1
                    suma41 = suma41+1;
                case 4.2
                    suma42 = suma42+1;
                case 4.4
                    suma44 = suma44+1;
                case 5.5
                    suma55 = suma55+1;
                case 6.1
                    suma61 = suma61+1;
                case 6.3
                    suma63 = suma63+1;
                case 7.5
                    suma75 = suma75+1;
            end
        end
        if x<(w-(odl-1)) && y>odl % w przeciwnym razie nie ma co zliczac, bo nie ma nikogo na dole po lewej
            switch plansza(x+odl,y-odl)
                case 0.1
                    suma01 = suma01+1;
                case 0.3
                    suma03 = suma03+1;
                case 1.5
                    suma15 = suma15+1;
                case 2.1
                    suma21 = suma21+1;
                case 2.2
                    suma22 = suma22+1;
                case 2.4
                    suma24 = suma24+1;
                case 3.1
                    suma31 = suma31+1;
                case 3.3
                    suma33 = suma33+1;
                case 3.4
                    suma34 = suma34+1;
                case 4.1
                    suma41 = suma41+1;
                case 4.2
                    suma42 = suma42+1;
                case 4.4
                    suma44 = suma44+1;
                case 5.5
                    suma55 = suma55+1;
                case 6.1
                    suma61 = suma61+1;
                case 6.3
                    suma63 = suma63+1;
                case 7.5
                    suma75 = suma75+1;
            end
        end
        if x<(w-(odl-1)) && y<(k-(odl-1)) % w przeciwnym razie nie ma co zliczac, bo nie ma nikogo na dole po prawej
            switch plansza(x+odl,y+odl)
                case 0.1
                    suma01 = suma01+1;
                case 0.3
                    suma03 = suma03+1;
                case 1.5
                    suma15 = suma15+1;
                case 2.1
                    suma21 = suma21+1;
                case 2.2
                    suma22 = suma22+1;
                case 2.4
                    suma24 = suma24+1;
                case 3.1
                    suma31 = suma31+1;
                case 3.3
                    suma33 = suma33+1;
                case 3.4
                    suma34 = suma34+1;
                case 4.1
                    suma41 = suma41+1;
                case 4.2
                    suma42 = suma42+1;
                case 4.4
                    suma44 = suma44+1;
                case 5.5
                    suma55 = suma55+1;
                case 6.1
                    suma61 = suma61+1;
                case 6.3
                    suma63 = suma63+1;
                case 7.5
                    suma75 = suma75+1;
            end
        end
    end
sas01 = suma01;
sas03 = suma03;
sas15 = suma15;
sas21 = suma21;
sas22 = suma22;
sas24 = suma24;
sas31 = suma31;
sas33 = suma33;
sas34 = suma34;
sas41 = suma41;
sas42 = suma42;
sas44 = suma44;
sas55 = suma55;
sas61 = suma61;
sas63 = suma63;
sas75 = suma75; 
   
end
  