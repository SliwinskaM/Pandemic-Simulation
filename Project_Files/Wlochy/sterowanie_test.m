function plansza = sterowanie_test(plansza, ilosc_testow)

[X, Y]=size(plansza);

x_rand=sort(randsample(numel(plansza),ilosc_testow));
cnt=0;
for c=1:size(x_rand)
    for i=1:X
        for j=1:Y
            cnt=cnt+1;
            if cnt==x_rand(c)
                switch cnt
                    case 8.1
                        plansza(j,i)=1.1;
                    case 8.2
                        plansza(j,i)=1.2;
                    case 8.3
                        plansza(j,i)=1.3;    
                end
            end
        end
    end
    if cnt==numel(plansza)
       cnt=0; 
    end
end   
end

