function mac = fMacierzPrawdZmianyStanu(prawd_testu) 
% indeksy
ind_h = 1;
ind_r = 2;
ind_s = 3;
ind_i_q = 4;
ind_i_a_s = 5;
ind_i = 6;
ind_i_h = 7;
ind_d = 8;

mac = zeros(8);

mac(ind_h, ind_h) = 100-(6+1+0.5+50+5);
mac(ind_h, ind_s) = 5; % zadzia³a tylko po kontakcie z chorym
mac(ind_h,ind_i_q) = 1;
mac(ind_h, ind_i) = 20; % zadzia³a tylko po kontakcie z chorym
mac(ind_h,ind_i_a_s) = 2; % zadzia³a tylko po kontakcie z chorym

%po kwarantanie
mac(ind_i_q, ind_h) = 100-(38+0.5+0.5+0.5+0.5+0.5); %osoby, które by³y zdrowe na kwarantannie
mac(ind_i_q, ind_r) = 38; %osoby po kwarantanie z powodu koronawirusa
mac(ind_i_q, ind_s) = 5;
mac(ind_h, ind_i) = 25; % zadzia³a tylko po kontakcie z chorym
mac(ind_i_q, ind_i_a_s) = 5; % zadzia³a tylko po kontakcie z chorym
mac(ind_i_q, ind_i_h) = 0.5;
mac(ind_i_q, ind_d) = 0.5;

%po infekcji koronawirusem
mac(ind_i, ind_r) = 40;
mac(ind_i, ind_i_q) = 10*prawd_testu;
mac(ind_i, ind_i_a_s) = 10;
mac(ind_i, ind_i) = 40;

%po wylosowanym czasie choroby
mac(ind_s, ind_h) = 100-(1+2+0.5);
mac(ind_s, ind_i_a_s) = 1;
mac(ind_s, ind_i_h) = 2;
mac(ind_s,ind_d) = 0.5;

%po zachorowaniu z objawami
mac(ind_i_a_s, ind_r) = 100-(70+5+1);
mac(ind_i_a_s, ind_i_q) = 5;
mac(ind_i_a_s, ind_i_h) = 80;
mac(ind_i_a_s, ind_d) = 1;

%po wylosowanym czasie w szpitalu
mac(ind_i_h, ind_r) = 90;
mac(ind_i_h, ind_d) = 10;

%ponowne zachorowanie
mac(ind_r, ind_s) = 1;
mac(ind_r, ind_i_a_s) = 5;
mac(ind_r, ind_i) = 0.1;



