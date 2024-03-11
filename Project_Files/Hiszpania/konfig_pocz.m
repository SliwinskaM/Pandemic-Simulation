%% Autor: Karolina Œwierczek
% konfiguracja poczatkowa

% wektory mozliwych do uzyskania stanow:
healthy_w = [0.1 0.3]; % zdrowi
quar_w = [1.5]; % in_quarantine
inf_w = [2.1 2.2 2.4]; % infected
inf_sick_w = [4.1 4.2 4.4]; % infected_and_sick
zakazenia_w = horzcat(inf_w,inf_sick_w); % infected+infected_and_sick=zakazeni
sick_w = [3.1 3.3 3.4]; % sick
hosp_w = [5.5]; % in_hospital
wyleczeni_w = [6.1 6.3]; % recovered
ofiary_w = [7.5]; % dead

% Losowe rozmieszczenie na planszy poczatkowych stanow:
a = 1;
b = rozmiar;
zakazenia_wsp = floor(a+(b-a).*rand(liczba_wykrytych_zakazen_totalSK,2));
ofiary_wsp = floor(a+(b-a).*rand(przypadki_smiertelne_totalSK,2));
wyleczeni_wsp = floor(a+(b-a).*rand(liczba_wyleczen_totalSK,2));
hosp_wsp = floor(a+(b-a).*rand(aktywne_przypadkiSK,2));
sick_wsp = floor(a+(b-a).*rand(sick_przypadki,2));
healthy_wsp = floor(a+(b-a).*rand(healthy_przypadki,2));

plansza = zeros(rozmiar,rozmiar); % biezaca plansza
for i=1:size(zakazenia_wsp,1)
    if (plansza(zakazenia_wsp(i,1),zakazenia_wsp(i,2))==0)
        plansza(zakazenia_wsp(i,1),zakazenia_wsp(i,2)) = randsample(zakazenia_w,1);
    else
        plansza(zakazenia_wsp(i,1)+1,zakazenia_wsp(i,2)+1) = randsample(zakazenia_w,1);
    end
end
for i=1:size(ofiary_wsp,1)
    if (plansza(ofiary_wsp(i,1),ofiary_wsp(i,2))==0)
        plansza(ofiary_wsp(i,1),ofiary_wsp(i,2)) = randsample(ofiary_w,1);
    else
        plansza(ofiary_wsp(i,1)+1,ofiary_wsp(i,2)+1) = randsample(ofiary_w,1);
    end    
end
for i=1:size(wyleczeni_wsp,1)
    if (plansza(wyleczeni_wsp(i,1),wyleczeni_wsp(i,2))==0)
        plansza(wyleczeni_wsp(i,1),wyleczeni_wsp(i,2)) = randsample(wyleczeni_w,1);
    else
        plansza(wyleczeni_wsp(i,1)+1,wyleczeni_wsp(i,2)+1) = randsample(wyleczeni_w,1);
    end    
end
for i=1:size(hosp_wsp,1)
    if (plansza(hosp_wsp(i,1),hosp_wsp(i,2))==0)
        plansza(hosp_wsp(i,1),hosp_wsp(i,2)) = randsample(hosp_w,1);
    else
        plansza(hosp_wsp(i,1)+1,hosp_wsp(i,2)+1) = randsample(hosp_w,1);
    end    
end
for i=1:size(sick_wsp,1)
    if (plansza(sick_wsp(i,1),sick_wsp(i,2))==0)
        plansza(sick_wsp(i,1),sick_wsp(i,2)) = randsample(sick_w,1);
    else
        plansza(sick_wsp(i,1)+1,sick_wsp(i,2)+1) = randsample(sick_w,1);
    end    
end

for w = 1:rozmiar
    for k = 1:rozmiar
        if (plansza(w,k)==0)
            plansza(w,k) = randsample(healthy_w,1);
        end
    end
end

% Sprawdzenie konfiguracji poczatkowej:
lin2 = 'Sprawdzenie konfiguracji poczatkowej (na planszy 0): \n';
fprintf(lin2);
% healthy:
plansza_h1 = plansza-healthy_w(1);
plansza_h2 = plansza-healthy_w(2);
h1_elem = find(~plansza_h1);
h2_elem = find(~plansza_h2);
h_len = length(h1_elem)+length(h2_elem);
if (h_len == healthy_przypadki)
    disp("Na planszy 0 prawidlowa liczba zdrowych.");
end
% zakazeni:
plansza_z1 = plansza-zakazenia_w(1);
plansza_z2 = plansza-zakazenia_w(2);
plansza_z3 = plansza-zakazenia_w(3);
plansza_z4 = plansza-zakazenia_w(4);
plansza_z5 = plansza-zakazenia_w(5);
plansza_z6 = plansza-zakazenia_w(6);
z1_elem = find(~plansza_z1);
z2_elem = find(~plansza_z2);
z3_elem = find(~plansza_z3);
z4_elem = find(~plansza_z4);
z5_elem = find(~plansza_z5);
z6_elem = find(~plansza_z6);
z_len = length(z1_elem)+length(z2_elem)+length(z3_elem)+length(z4_elem)+length(z5_elem)+length(z6_elem);
if (z_len == liczba_wykrytych_zakazen_totalSK)
    disp("Na planszy 0 prawidlowa liczba zakazonych.");
end
% sick:
plansza_s1 = plansza-sick_w(1);
plansza_s2 = plansza-sick_w(2);
plansza_s3 = plansza-sick_w(3);
s1_elem = find(~plansza_s1);
s2_elem = find(~plansza_s2);
s3_elem = find(~plansza_s3);
s_len = length(s1_elem)+length(s2_elem)+length(s3_elem);
if (s_len == sick_przypadki)
    disp("Na planszy 0 prawidlowa liczba chorych.");
end
% in_hospital:
plansza_hosp = plansza-hosp_w(1);
hosp_elem = find(~plansza_hosp);
hosp_len = length(hosp_elem);
if (hosp_len == aktywne_przypadkiSK)
    disp("Na planszy 0 prawidlowa liczba hospitalizowanych.");
end
% recovered:
plansza_w1 = plansza-wyleczeni_w(1);
plansza_w2 = plansza-wyleczeni_w(2);
w1_elem = find(~plansza_w1);
w2_elem = find(~plansza_w2);
w_len = length(w1_elem)+length(w2_elem);
if (w_len == liczba_wyleczen_totalSK)
    disp("Na planszy 0 prawidlowa liczba wyleczonych.");
end
% dead:    
plansza_o = plansza-ofiary_w(1);
o_elem = find(~plansza_o);
o_len = length(o_elem);
if (o_len == przypadki_smiertelne_totalSK)
    disp("Na planszy 0 prawidlowa liczba przypadkow smiertelnych.");
end

fprintf('\n');

