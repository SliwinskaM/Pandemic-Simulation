function sprawdzenie(plansza, ilosc_elem, reprezentacja)

suma=sum(plansza(:) == reprezentacja);
if suma==ilosc_elem
    disp('Wype�nienie OK (ilo�� element�w jest zgodna z danymi)');
else
    disp('B��dne wype�nienie');
end