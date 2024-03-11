%% Funkcja wczytuje na plansze czesc elementow. (in-plansza, ilosc elem, wartosc reprezentatywna out-plansza zmieniona)


function plansza = wypelnij_czesc(plansza, elem_do_zastapienia, ilosc_elem, wartosc)

x_rand=sort(randsample(find(plansza==elem_do_zastapienia),ilosc_elem));
cnt=0;
[X, Y]=size(plansza);

for c=1:size(x_rand)
    for i=1:X
        for j=1:Y
            cnt=cnt+1;
            if cnt==x_rand(c)
               plansza(j,i)=wartosc; 
            end
        end
    end
    if cnt==numel(plansza)
       cnt=0; 
    end
end
end

