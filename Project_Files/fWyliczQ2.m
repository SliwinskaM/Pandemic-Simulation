function stan_q2 = fWyliczQ2(stan_q1, informacje, ograniczenia)

% indeksy
ind_h = 1;
ind_r = 2;
ind_s = 3;
ind_i_q = 4;
ind_i_a_s = 5;
ind_in = 6;
ind_i_h = 7;
ind_d = 8;


switch(stan_q1)
    case(ind_h)
        mac_q2 = [1, 3, 4, 5];
        ilosc = randi(3);
    case(ind_r)
        mac_q2 = [1, 3, 4, 5];
        ilosc = randi(3);
    case(ind_s)
        mac_q2 = [1, 3, 4];
        ilosc = randi(2);
    case(ind_i_q)
        mac_q2 = [3, 4];
        ilosc = randi(2);
    case(ind_i_a_s)
        mac_q2 = [1, 2, 3, 4];
        ilosc = randi(3);
    case(ind_in)
        mac_q2 = [1, 2, 3, 4, 5];
        ilosc = randi(4);
    case(ind_i_h)
        mac_q2 = [2, 3, 4];
        ilosc = randi(2);
    case(ind_d)
        mac_q2 = [1];
        ilosc = 1;
end

if(informacje>0 || ograniczenia>0)
    for i=1:(informacje+ograniczenia)/2
        mac_q2 = [mac_q2,3,4,5];
    end
end
        

idx_q2 = randi(length(mac_q2));
stan_q2 = mac_q2(idx_q2);

    
end