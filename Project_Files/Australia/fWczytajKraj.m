function kraj = fWczytajKraj(plansza, i_q, in, s, i_a_s, i_h, r, d) %wartoœci procentowe
ind_h = 1;
ind_r = 2;
ind_s = 3;
ind_i_q = 4;
ind_i_a_s = 5;
ind_in = 6;
ind_i_h = 7;
ind_d = 8;


[wys,szer] = size(plansza);
kraj = ones(wys, szer);

%Posiadamy dok³adne dane o pierwszych wykrytych zara¿onych - ³¹cznie 4
%osoby w odpowiednich miastach
Melbourne_x = floor(0.8*szer);
Melbourne_y = floor(0.9*wys);
Sydney_x = floor(0.9*szer);
Sydney_y = floor(0.8*wys);

kraj(Melbourne_y, Melbourne_x) = ind_i_h;
kraj(Sydney_y, Sydney_x) = ind_in;
kraj(Sydney_y+1, Sydney_x+1) = ind_in;

% Wyliczenie prawdopodobieñstwa znaleienia siê w którymœ ze stanów
macierz_prawd = ones(1,10000); 
for i=1:10000
    if(i < 1+i_q)
        macierz_prawd(i) = ind_i_q;
    elseif (i < 1+i_q+in)
        macierz_prawd(i) = ind_in;
    elseif(i < 1+i_q+in+s)
        macierz_prawd(i) = ind_s;
    elseif(i < 1+i_q+in+s+i_a_s)
        macierz_prawd(i) = ind_i_a_s;
    elseif(i < 1+i_q+in+s+i_a_s+i_h)
        macierz_prawd(i) = ind_i_h;
    elseif(i < 1+i_q+in+s+i_a_s+i_h+r)
        macierz_prawd(i) = ind_r;
    elseif(i < 1+i_q+in+s+i_a_s+i_h+r+d)
        macierz_prawd(i) = ind_d;
    end
end

    
[I_poz, J_poz] = find(~(kraj-1));
for i=1:length(I_poz)
    idx_matr = randperm(10000);
    idx = idx_matr(1);
    kraj(I_poz(i), J_poz(i)) = macierz_prawd(idx);
end

end

