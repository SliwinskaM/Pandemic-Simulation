% funkcja zlicza sasiadow komorki (x,y) wg sasiedztwa Moore'a
% czyli maksymalnie osmiu sasiadow

function sasiedzi = fPoliczSasiadowAustralia(plansza,x,y, rozmiar)
    suma = zeros(1,rozmiar);
    [w,k] = size(plansza);
    
    % ograniczenia zapobiegaj¹ pobraniu wartoœci spoza planszy (co
    % spowoduje b³¹d)
    if x>1
        suma(plansza(x-1,y)) = suma(plansza(x-1,y)) + 1;
    end
    if y>1 
        suma(plansza(x,y-1)) = suma(plansza(x,y-1)) + 1;
    end
    if x<w 
        suma(plansza(x+1,y)) = suma(plansza(x+1,y)) + 1;
    end
    if y<k
        suma(plansza(x,y+1)) = suma(plansza(x,y+1)) + 1;
    end
    if x>1 && y>1
        suma(plansza(x-1,y-1)) = suma(plansza(x-1,y-1)) + 1;
    end
    if x>1 && y<k
        suma(plansza(x-1,y+1)) = suma(plansza(x-1,y+1)) + 1;
    end
    if x<w && y>1 
        suma(plansza(x+1,y-1)) = suma(plansza(x+1,y-1)) + 1;
    end
    if x<w && y<k 
        suma(plansza(x+1,y+1)) = suma(plansza(x+1,y+1)) + 1;
    end
    
sasiedzi = suma(1,:);    
   
end
  