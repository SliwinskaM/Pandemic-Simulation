%% Autor: Karolina Œwierczek
% wczytywanie danych z excela

close all;
clc;

load Hiszpania_parametry.mat;

file_name = 'cw2-2[Œwierczek+Karolina].xls';
table = readtable(file_name,'ReadVariableNames',true);
headers = table.Properties.VariableNames;

% wczytywanie danych do zmiennych:
Lp = table.Lp;
data = table.data;
% data na date matlabowy:
data_m = datestr(data);
liczba_wykrytych_zakazen_total = table.liczba_wykrytych_zakazen_total;
przypadki_smiertelne_total = table.przypadki_smiertelne_total;
liczba_wyleczen_total = table.liczba_wyleczen_total;
aktywne_przypadki = table.aktywne_przypadki;

dzien_fin04 = 91; % dzien koncowy symulacji, liczac od pierwszego dnia zbierania danych do konca kwietnia
dzien_fin09 = 244; % dzien koncowy symulacji, liczac od pierwszego dnia zbierania danych do konca wrzesnia
sym_wer = str2double(param_struct.sym_wer.Value); % wersja symulacji: 1 - do konca kwietnia, 2 - do konca wrzesnia
if (sym_wer==1)
    dzien0 = 65; % dzien poczatkowy symulacji
    dzien_fin = dzien_fin04; % dzien koncowy symulacji    
elseif (sym_wer==2)
    dzien0 = dzien_fin04; % dzien poczatkowy symulacji
    dzien_fin = dzien_fin09; % dzien koncowy symulacji
else
    disp('UWAGA: blad przy wyborze wersji symulacji - zmienna sym_wer, dostepne opcje: 1 lub 2.');
end

liczba_cykli = dzien_fin-dzien0; % liczba cykli
rozmiar = str2double(param_struct.rozmiar.Value); % rozmiar planszy
l_ludn = 46477474; % <- l_ludn - liczba ludnosci Hiszpanii (08.04.2020)

% DATA:
daty_sim(:,:) = data_m(dzien0:dzien_fin,:);

% OSTATNI DZIEN - sym_wer==1:
if (sym_wer==1)
    liczba_wykrytych_zakazen_total_fin = floor(liczba_wykrytych_zakazen_total(dzien_fin04));
    przypadki_smiertelne_total_fin = floor(przypadki_smiertelne_total(dzien_fin04));
    liczba_wyleczen_total_fin = floor(liczba_wyleczen_total(dzien_fin04));
    aktywne_przypadki_fin = floor(aktywne_przypadki(dzien_fin04)); % <- stan in_hospital (w przyblizeniu)
    skala_pr = floor(l_ludn/(rozmiar.^2));
    sick_przypadki_fin = 30*skala_pr;
    sim_sum_fin = (rozmiar).^2*skala_pr;
    healthy_przypadki_fin = sim_sum_fin-(liczba_wykrytych_zakazen_total_fin+przypadki_smiertelne_total_fin+liczba_wyleczen_total_fin+aktywne_przypadki_fin+sick_przypadki_fin);
    sum_fin = liczba_wykrytych_zakazen_total_fin+przypadki_smiertelne_total_fin+liczba_wyleczen_total_fin+aktywne_przypadki_fin+sick_przypadki_fin+healthy_przypadki_fin;
    % skala:
    skala = floor(sum_fin/(rozmiar.^2));    
    % Nalezy sprawdzic, czy skala_pr==skala:
    if (skala_pr~=skala)
        disp('Nalezy poprawic zmienna skala_pr.');
    end
    rozn = sum_fin-sim_sum_fin;
    % Nalezy sprawdzic, czy sum_fin==sim_sum_fin:
    if (rozn~=0)
        disp('Nalezy sprawdzic zmienne sum_fin i sim_sum_fin <- liczba ludnosci z symulacji jest inna niz rzeczywista liczba ludnosci.');
    end
else
    fprintf('Brak statystyk dotyczacych ostatniego dnia symulacji. \n \n');
end

% skala:
if (sym_wer==2)
    skala = floor(l_ludn/(rozmiar.^2)); % <- 46477474 - liczba ludnosci Hiszpanii (08.04.2020)
end

% PIERWSZY DZIEN - sym_wer==1 lub sym_wer==2:
liczba_wykrytych_zakazen_totalSK = floor(liczba_wykrytych_zakazen_total(dzien0)/skala);
przypadki_smiertelne_totalSK = floor(przypadki_smiertelne_total(dzien0)/skala);
liczba_wyleczen_totalSK = floor(liczba_wyleczen_total(dzien0)/skala);
aktywne_przypadkiSK = floor(aktywne_przypadki(dzien0)/skala); % <- hospital
sick_przypadki = 40;
healthy_przypadki = rozmiar.^2 - (liczba_wykrytych_zakazen_totalSK+przypadki_smiertelne_totalSK+liczba_wyleczen_totalSK+aktywne_przypadkiSK+sick_przypadki);
