function stanNastepny = fStanNastepny(q1_prev, sasiedzi_q1, sasiedzi_q2, prawdop, q2, licznik, test_prawd)

% indeksy
ind_h = 1;
ind_r = 2;
ind_s = 3;
ind_i_q = 4;
ind_i_a_s = 5;
ind_in = 6;
ind_i_h = 7;
ind_d = 8;    

% osoba zmar³a nie zmienia stanu
if q1_prev == ind_d
    stanNastepny = ind_d;
    return
end

% kwarantanna / szpital / choroba
if licznik(1) < randi(20) && q1_prev == ind_s
    stanNastepny = ind_s;
    return
end
if licznik(2) < 14 && q1_prev == ind_i_q
    stanNastepny = ind_i_q;
    return
end
 
if licznik(4) < randi(30) + 14 && q1_prev == ind_i_h
    stanNastepny = ind_i_h;
    return
end

p_q1 = prawdop;

%zaraziæ siê mo¿na tylko od s¹siadów (im wiêcej, tym wiêksze
%prawdopodobieñstwo)
p_q1(ind_in) = p_q1(ind_in) .* sasiedzi_q1(ind_in);
p_q1(ind_i_a_s) = p_q1(ind_i_a_s) .* sasiedzi_q1(ind_i_a_s);
p_q1(ind_s) = p_q1(ind_s) .* sasiedzi_q1(ind_s);

%mo¿na wyzdrowieæ (po czasie uwzglêdnionym powy¿ej)
if (q1_prev == ind_i_q) p_q1(ind_r) = 80; end
if (q1_prev == ind_in) p_q1(ind_r) = 80; end
if (q1_prev == ind_i_a_s) p_q1(ind_r) = 60; end
if (q1_prev == ind_i_h) p_q1(ind_r) = 50; end

%wp³yw stanu q2 na prawdopodobieñstwo zara¿enia
if (q2 == 1) p_q1(ind_in) = p_q1(ind_in)*2; end
if (q2 == 3) p_q1(ind_in) = p_q1(ind_in)*0.5; end

%wp³yw stanu q2 s¹siadów na prawdopodobieñstwo zara¿enia
if(sasiedzi_q2(1)) p_q1(ind_in) = p_q1(ind_in)*2; end
if(sasiedzi_q2(2)) p_q1(ind_in) = p_q1(ind_in)*3; end
if(sasiedzi_q2(4)) p_q1(ind_in) = p_q1(ind_in)*0.5; end

% losowanie stanu nastêpnego
thr_h = p_q1(ind_h) / sum(p_q1);
thr_r = p_q1(ind_r) / sum(p_q1);
thr_s = p_q1(ind_s) / sum(p_q1);
thr_i_q = p_q1(ind_i_q) / sum(p_q1);
thr_i_a_s = p_q1(ind_i_a_s) / sum(p_q1);
thr_in = p_q1(ind_in) / sum(p_q1);
thr_i_h = p_q1(ind_i_h) / sum(p_q1);
thr_d = p_q1(ind_d) / sum(p_q1);

%default
stanNastepny = 1;

rand_idx = rand();
if rand_idx < thr_h
    stanNastepny = ind_h;
elseif rand_idx < thr_h + thr_r
    stanNastepny = ind_r;
elseif rand_idx < thr_h + thr_r + thr_s
    stanNastepny = ind_s;
elseif rand_idx < thr_h + thr_r + thr_s + thr_i_q
    stanNastepny = ind_i_q;
elseif rand_idx < thr_h + thr_r + thr_s + thr_i_q + thr_i_a_s
    stanNastepny = ind_i_a_s;
elseif rand_idx < thr_h + thr_r + thr_s + thr_i_q + thr_i_a_s + thr_in
    stanNastepny = ind_in;
elseif rand_idx < thr_h + thr_r + thr_s + thr_i_q + thr_i_a_s + thr_in + thr_i_h
    stanNastepny = ind_i_h;
elseif rand_idx < thr_h + thr_r + thr_s + thr_i_q + thr_i_a_s + thr_in + thr_i_h + thr_d
    stanNastepny = ind_d;
end
end