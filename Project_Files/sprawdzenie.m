function sprawdzenie(plansza, ilosc_elem, reprezentacja)

suma=sum(plansza(:) == reprezentacja);
if suma==ilosc_elem
    disp('Wype³nienie OK (iloœæ elementów jest zgodna z danymi)');
else
    disp('B³êdne wype³nienie');
end