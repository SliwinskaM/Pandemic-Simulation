% Skrypt realizuje symulacjê rozprzestrzenienia koronawirusa w Australii
% Dostêpne stany:
% Q1:
%     1 - healthy
%     2 - recovered
%     3 - sick
%     4 - in_quarantine
%     5 - infected_and_sick
%     6 - infected
%     7 - in_hospital
%     8 - dead
% Q2:
%     no_security_measures
%     infecting
%     self-protecting
%     protecting_others
%     organizing_protection

% Funkcje przejœcia opisane w sprawozdaniu.
%%
data = readmatrix("Australia\corona_data.xlsx");
%% Inicjalizacja
close all;
clear all;

% indeksy q1
ind_h = 1;
ind_r = 2;
ind_s = 3;
ind_i_q = 4;
ind_i_a_s = 5;
ind_in = 6;
ind_i_h = 7;
ind_d = 8;

% indeksy q2
ind_n_s_m = 1;
ind_ig = 2;
ind_s_p = 3;
ind_p_o = 4;
ind_o_p = 5;

rozmiar = 200; % rozmiar planszy

kraj = ones(rozmiar,rozmiar);	   % biezaca plansza
liczbaCykli = 1000;                  % ile iteracji zrobic




% argumenty (procentowa szansa na dany stan): (kraj, i_q, in, s, i_a_s, i_h, r, d);
kraj = fWczytajKraj(kraj, 1, 1, 1, 0, 0, 0, 0);
imagesc(kraj, [1 8]); colorbar; title('cykl 0');

% prawdopodobieñstwo testu
test_prawd = 6; %0-10 (robione nikomu - robione wszystkim)
informacje = 8; %0-10
ograniczenia = 6; %0-10

%Prawdopodobieñstwo przejœæ miêdzy stanami
prawdop = fMacierzPrawdZmianyStanu(test_prawd);
licznik = zeros(rozmiar,rozmiar, 4); 

% stan q2 komórki
macierz_q2 = zeros(rozmiar,rozmiar);
for w1=1:rozmiar
        for k1=1:rozmiar
            macierz_q2(w1,k1) = fWyliczQ2(kraj(w1,k1), informacje, ograniczenia);
        end
end


%%
for n=1:liczbaCykli   
    krajNext= ones(rozmiar,rozmiar); % tworzymy plansze do odtwarzania stanu "za chwile"
    for w=1:rozmiar
        for k=1:rozmiar
            sasiedzi_q1 = proba/fPoliczSasiadow(kraj,w,k, 8);
            sasiedzi_q2 = proba/fPoliczSasiadow(macierz_q2,w,k, 5);
            
            % nastêpny stan wyliczamy ze wzglêdu na s¹siadów, prawdopodobieñstwo przejœæ miêdzy stanami, stan w Q2,
            % d³ugoœæ trwania choroby/kwarantanny
            krajNext(w,k) = fStanNastepny(kraj(w,k), sasiedzi_q1, sasiedzi_q2, prawdop(kraj(w,k),:), macierz_q2(w,k), licznik(w,k,:));
            
            % jeœli stan siê zmieni, to losujemy now¹ (dopuszczaln¹) wartoœæ q2 
            if (krajNext(w,k) ~= kraj(w,k))
                macierz_q2(w,k, :) = fWyliczQ2(kraj(w,k), informacje, ograniczenia);
            end
            kraj(w,k) = krajNext(w,k);
            % zapis dni na kwarantannie / w szpitalu / w chorobie:
            if kraj(w,k) == ind_s
                licznik(w,k, 1) = licznik(w,k, 1) + 1;
            elseif kraj(w,k) == ind_i_q
                licznik(w,k, 2) = licznik(w,k, 2) + 1;
            elseif kraj(w,k) == ind_in
                licznik(w,k, 3) = licznik(w,k, 3) + 1;
            elseif kraj(w,k) == ind_i_h
                licznik(w,k, 4) = licznik(w,k, 4) + 1;
            end
        end
    end
    imagesc(kraj, [1 8]); colorbar; title(['cykl ' num2str(n)]);
    pause(0.05);
end


