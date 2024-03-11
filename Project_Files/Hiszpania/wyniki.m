%% Autor: Karolina Œwierczek
% dane posrednie:

h_len_fin = zeros(1,liczba_cykli+1);
q_len_fin = zeros(1,liczba_cykli+1);
z_len_fin = zeros(1,liczba_cykli+1);
s_len_fin = zeros(1,liczba_cykli+1);
hosp_len_fin = zeros(1,liczba_cykli+1);
w_len_fin = zeros(1,liczba_cykli+1);
o_len_fin = zeros(1,liczba_cykli+1);
suma = zeros(1,liczba_cykli+1);
roznica = zeros(1,liczba_cykli+1);

wektor = linspace(1,liczba_cykli+1,liczba_cykli+1);
for j = wektor
    % healthy:
    plansza_h1_fin = plansza_pom(:,:,j)-healthy_w(1);
    plansza_h2_fin = plansza_pom(:,:,j)-healthy_w(2);
    h1_elem_fin = find(~plansza_h1_fin);
    h2_elem_fin = find(~plansza_h2_fin);
    h_len_fin(j) = length(h1_elem_fin)+length(h2_elem_fin);
    % in_quarantine:
    plansza_q_fin = plansza_pom(:,:,j)-quar_w(1);
    q_elem_fin = find(~plansza_q_fin);
    q_len_fin(j) = length(q_elem_fin);
    % zakazeni:
    plansza_z1_fin = plansza_pom(:,:,j)-zakazenia_w(1);
    plansza_z2_fin = plansza_pom(:,:,j)-zakazenia_w(2);
    plansza_z3_fin = plansza_pom(:,:,j)-zakazenia_w(3);
    plansza_z4_fin = plansza_pom(:,:,j)-zakazenia_w(4);
    plansza_z5_fin = plansza_pom(:,:,j)-zakazenia_w(5);
    plansza_z6_fin = plansza_pom(:,:,j)-zakazenia_w(6);
    z1_elem_fin = find(~plansza_z1_fin);
    z2_elem_fin = find(~plansza_z2_fin);
    z3_elem_fin = find(~plansza_z3_fin);
    z4_elem_fin = find(~plansza_z4_fin);
    z5_elem_fin = find(~plansza_z5_fin);
    z6_elem_fin = find(~plansza_z6_fin);
    z_len_fin(j) = length(z1_elem_fin)+length(z2_elem_fin)+length(z3_elem_fin)+length(z4_elem_fin)+length(z5_elem_fin)+length(z6_elem_fin);
    % sick:
    plansza_s1_fin = plansza_pom(:,:,j)-sick_w(1);
    plansza_s2_fin = plansza_pom(:,:,j)-sick_w(2);
    plansza_s3_fin = plansza_pom(:,:,j)-sick_w(3);
    s1_elem_fin = find(~plansza_s1_fin);
    s2_elem_fin = find(~plansza_s2_fin);
    s3_elem_fin = find(~plansza_s3_fin);
    s_len_fin(j) = length(s1_elem_fin)+length(s2_elem_fin)+length(s3_elem_fin);
    % in_hospital:
    plansza_hosp_fin = plansza_pom(:,:,j)-hosp_w(1);
    hosp_elem_fin = find(~plansza_hosp_fin);
    hosp_len_fin(j) = length(hosp_elem_fin);
    % recovered:
    plansza_w1_fin = plansza_pom(:,:,j)-wyleczeni_w(1);
    plansza_w2_fin = plansza_pom(:,:,j)-wyleczeni_w(2);
    w1_elem_fin = find(~plansza_w1_fin);
    w2_elem_fin = find(~plansza_w2_fin);   
    w_len_fin(j) = length(w1_elem_fin)+length(w2_elem_fin);    
    % dead:
    plansza_o_fin = plansza_pom(:,:,j)-ofiary_w(1);
    o_elem_fin = find(~plansza_o_fin);
    o_len_fin(j) = length(o_elem_fin);    
    % SUMA:
    suma(j) = (z_len_fin(j)+o_len_fin(j)+w_len_fin(j)+hosp_len_fin(j)+s_len_fin(j)+h_len_fin(j)+q_len_fin(j))*skala;
    roznica(j) = l_ludn - suma(j);
end

% dane koncowe:
if (sym_wer==1)
    % healthy:
    disp(['Na planszy koncowej jest ',num2str(h_len_fin(end)*skala),' zdrowych, podczas gdy wg statystyk jest ich ',num2str(healthy_przypadki_fin),'.']);
    disp(['Roznica: ',num2str(healthy_przypadki_fin-h_len_fin(end)*skala),'.']);
    disp(['Roznica wzgledna: ',num2str((healthy_przypadki_fin-h_len_fin(end)*skala)/healthy_przypadki_fin*100),'%.']);
    % in_quarantine:
    disp(['Na planszy koncowej jest ',num2str(q_len_fin(end)*skala),' w kwarantannie.']);
    % zakazeni:
    disp(['Na planszy koncowej jest ',num2str(z_len_fin(end)*skala),' zakazonych, podczas gdy wg statystyk jest ich ',num2str(liczba_wykrytych_zakazen_total_fin),'.']);
    disp(['Roznica: ',num2str(liczba_wykrytych_zakazen_total_fin-z_len_fin(end)*skala),'.']);
    disp(['Roznica wzgledna: ',num2str((liczba_wykrytych_zakazen_total_fin-z_len_fin(end)*skala)/liczba_wykrytych_zakazen_total_fin*100),'%.']);
    % sick:
    disp(['Na planszy koncowej jest ',num2str(s_len_fin(end)*skala),' chorych.']);
    % in_hospital:
    disp(['Na planszy koncowej jest ',num2str(hosp_len_fin(end)*skala),' hospitalizowanych.']);
    % recovered:
    disp(['Na planszy koncowej jest ',num2str(w_len_fin(end)*skala),' wyleczonych, podczas gdy wg statystyk jest ich ',num2str(liczba_wyleczen_total_fin),'.']);
    disp(['Roznica: ',num2str(liczba_wyleczen_total_fin-w_len_fin(end)*skala),'.']);
    disp(['Roznica wzgledna: ',num2str((liczba_wyleczen_total_fin-w_len_fin(end)*skala)/liczba_wyleczen_total_fin*100),'%.']);
    % dead:
    disp(['Na planszy koncowej jest ',num2str(o_len_fin(end)*skala),' ofiar, podczas gdy wg statystyk jest ich ',num2str(przypadki_smiertelne_total_fin),'.']);
    disp(['Roznica: ',num2str(przypadki_smiertelne_total_fin-o_len_fin(end)*skala),'.']);
    disp(['Roznica wzgledna: ',num2str((przypadki_smiertelne_total_fin-o_len_fin(end)*skala)/przypadki_smiertelne_total_fin*100),'%.']);

elseif (sym_wer==2)
    % healthy:
    disp(['Na planszy koncowej jest ',num2str(h_len_fin(end)*skala),' zdrowych.']);
    % in_quarantine:
    disp(['Na planszy koncowej jest ',num2str(q_len_fin(end)*skala),' w kwarantannie.']);
    % zakazeni:
    disp(['Na planszy koncowej jest ',num2str(z_len_fin(end)*skala),' zakazonych.']);
    % recovered:
    disp(['Na planszy koncowej jest ',num2str(w_len_fin(end)*skala),' wyleczonych.']);
    % dead:
    disp(['Na planszy koncowej jest ',num2str(o_len_fin(end)*skala),' ofiar.']);
    fprintf('\n');
    disp('Wykresy slupkowe niemozliwe do utworzenia (brak danych porownawczych).');
else
    disp('UWAGA: blad przy wyborze wersji symulacji - zmienna sym_wer, dostepne opcje: 1 lub 2.');
end

save('calosc.mat','-regexp','^(?!(app|event)$).');

