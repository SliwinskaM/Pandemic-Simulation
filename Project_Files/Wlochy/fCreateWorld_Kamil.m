function [world, dzielnik] = fCreateWorld_Kamil(num, day_num,rozmiar)

world = zeros(rozmiar,rozmiar);	   % biezaca plansza 

switch rozmiar
    case 100
        dzielnik = 6047.7;
    case 200
        dzielnik = 1511.92395;
    case 500
        dzielnik = 241.907832;
    case 1000
        dzielnik = 60.476958;
end

world = fWczytajModel(world, num, day_num, dzielnik);

end