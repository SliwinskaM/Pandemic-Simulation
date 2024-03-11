%clear all; close all; clc;

%__________________Q2______________________________________________________
% -1 %dead
% 0 %healthy
% 1 %recovered
% 2 %in quarantine
% 3 %infected
% 4 %in hospital
% 5 %sick
%
%__________________Q1______________________________________________________
% 0 %no security measures
% 1 %self protecting
% 2 %protecting others
%
%___________TODO___________________________________________________________
%
% 
% 


%_____czytanie danych______________________________________________________
%____dane z 17 marca
%data1 = readmatrix('episim_data_1.csv');
%data2 = readmatrix('episim_data_2.csv');
%data3 = readmatrix('episim_data_3.csv');
%data4 = readmatrix('episim_data_4.csv');
%data = [data1 data2 data3 data4];
%data = data(:,1:100);
%____dane z  17 marca 1000x1000
data = readmatrix('data_17_03_AUT.csv');

%____dane z 30 kwietnia 1000x1000
%data = readmatrix('data_30_04_AUT.csv');



%____wizualizacja danych wej渃iowych_______________________________________

%figure(1)
%imagesc(data, [-1 6])
%%colormap spring
%%colormap([0 0 0; 1 1 1; 0.5 0.5 0.5; 1 114/255 86/255; 1 94/255 0; 1 145/255 0; 1 0 0])
%colormap([0 0 0; 255/255 255/255 255/255; 158/255 201/255 250/255; 255/255 194/255 26/255; 255/255 152/255 43/255; 255/255 112/255 71/255; 255/255 0 53/255])
%title (sprintf('Iteracja: 0'))
%colorbar
%waitforbuttonpress()



%_____parametry mapy_______________________________________________________

maxiter = 44;
maxiter = 75;
maxiter = str2double(AustriaParameters.maxiter.Value);

%map_size = 1000;
temp_size = size(data);
map_size = temp_size(1);
visualisation_counter=0;



%_____parametry symulacji__________________________________________________

%no_security_measures = 0.9;
%self_protecting = 0.6;
%protecting_others = 0.4;
%neighbours_threshold = 0.3;
%miracle = 0.95;
%death_rate = 0.02;

%self_protecting_threshold = 0.7;
%protecting_others_threshold = 0.9;



no_security_measures = str2double(AustriaParameters.no_security_measures.Value);
self_protecting = str2double(AustriaParameters.self_protecting.Value);
protecting_others = str2double(AustriaParameters.protecting_others.Value);
neighbours_threshold = str2double(AustriaParameters.neighbours_threshold.Value);
miracle = str2double(AustriaParameters.miracle.Value);
death_rate = str2double(AustriaParameters.death_rate.Value);

self_protecting_threshold = str2double(AustriaParameters.self_protecting_threshold.Value);
protecting_others_threshold = str2double(AustriaParameters.protecting_others_threshold.Value);



%____dane testowe__________________________________________________________
map_q1 = zeros(map_size);
%map_q2 = zeros(map_size);



%map_q1 = [0 0 1 0 0 ;
%          1 0 1 2 0 ;
%          2 0 0 0 1 ;
%          1 0 1 1 0 ;
%          0 2 0 1 0 ;];
%map_q2 = [3 0 0 0 0 ;
%          0 3 0 3 3 ;
%          3 3 0 0 0 ;
%          0 0 0 0 3 ;
%          3 2 0 0 5 ;];

map_q2 = data;
%map_q1 = data*2/3;



%____liczniki stan體_______________________________________________________

%____q2
dead_cnt = zeros(1,maxiter);
healthy_cnt = zeros(1,maxiter);
recovered_cnt = zeros(1,maxiter);
in_quarantine_cnt = zeros(1,maxiter);
infected_cnt = zeros(1,maxiter);
in_hospital_cnt = zeros(1,maxiter);
sick_cnt = zeros(1,maxiter);
%____q1
no_sec_cnt = zeros(1,maxiter);
self_prot_snt = zeros(1,maxiter);
prot_oth_cnt = zeros(1,maxiter);
               
%____pojedyncze liczniki
dead = 0;
healthy = 0;
recovered = 0;
in_quarantine = 0;
infected = 0;
in_hospital = 0;
sick = 0;
no_sec = 0;
self_prot = 0;
prot_oth = 0;
               


%____g丑wna p阾la__________________________________________________________

for n=1:maxiter
    
    next_q1=zeros(map_size);
    next_q2=zeros(map_size);
    
    for i=1:map_size
        for j=1:map_size
            [n_sum, n_max] = NeighboursSum(map_q2, map_q1, i,j);
            base_prob = n_sum / (n_max*5);%wsp贸艂czynnik stanu s膮siad贸w
            
       
            
%________next_q2___________________________________________________________
            
            switch map_q2(i,j)%stwierdzanie next_q2
                
                
                case -1 %dead
                    next_q2(i,j)=-1;%dead
                    
                    
                case 0 %healthy
                    if map_q1(i,j) == 0%no security measures
                        if base_prob*no_security_measures<neighbours_threshold%stwierdzenie wp艂ywu poziomu s膮siad贸w
                            if rand()> no_security_measures*base_prob %losowanie infekcji
                                next_q2(i,j)=0;%healthy
                            else
                                next_q2(i,j)=3;%infected
                            end
                        else
                            next_q2(i,j)=3;%infected
                        end
                    elseif map_q1(i,j) == 1%self protecting
                        if base_prob*self_protecting<neighbours_threshold%poziom wp艂ywu s膮siad贸w przy self protecting
                            if rand()>self_protecting*base_prob %losowanie infekcji
                                next_q2(i,j)=0;%healthy
                            else
                                next_q2(i,j)=3;%infected
                            end
                        else
                            next_q2(i,j)=3;%infected
                        end                      
                    end
                    
                    
                case 1 %recovered
                    if map_q1(i,j) == 0%no security measures
                        if base_prob*no_security_measures<neighbours_threshold
                            next_q2(i,j)=1;%recovered - model nie zak艂ada ponownego zachorowania
                        else
                            next_q2(i,j)=1;%recovered - model nie zak艂ada ponownego zachorowania
                        end
                    elseif map_q1(i,j) == 2%protecting others
                        if base_prob*protecting_others<neighbours_threshold
                            next_q2(i,j)=1;%recovered - model nie zak艂ada ponownego zachorowania
                        else
                            next_q2(i,j)=1;%recovered - model nie zak艂ada ponownego zachorowania
                        end
                    end
                    
                    
                case 2 %in quarantine
                   %mo偶e by膰 dead, in hospital, recovered
                   
                   if base_prob*protecting_others<neighbours_threshold
                       if rand()>protecting_others*base_prob %losowanie infekcji
                            next_q2(i,j)=2;%in quarantine
                       else
                            next_q2(i,j)=4;%in hospital
                       end
                   end
                   fate = rand();
                   if fate>miracle %losowanie cudu
                       next_q2(i,j)=1;%recovered
                   end
                   if fate<death_rate %losowanie 艣mierci
                       next_q2(i,j)=-1;%dead
                   end
                     
                   
                case 3 %infected
                    %mo偶e by膰 sick, in quarantine, recovered
                    
                    if map_q1(i,j) == 0%no security measures
                        if base_prob*no_security_measures<neighbours_threshold
                            if rand()>no_security_measures*base_prob %losowanie infekcji
                                next_q2(i,j)=3;%infected
                            else
                                next_q2(i,j)=5;%sick
                            end
                        else
                            next_q2(i,j)=5;%sick
                        end
                    elseif map_q1(i,j) == 2%protecting others
                        if base_prob*protecting_others<neighbours_threshold
                            if rand()>protecting_others*base_prob %losowanie infekcji
                                next_q2(i,j)=3;%infected
                            else
                                next_q2(i,j)=2;%in quarantine
                            end
                        else
                            next_q2(i,j)=5;%sick
                        end
                    end
                    if rand()>miracle %losowanie cudu
                       next_q2(i,j)=1;%recovered
                    end
                    
                    
                case 4 %in hospital
                    %mo偶e by膰 dead albo recovered
                    
                    next_q2(i,j)=4;%in hospital

                    fate = rand();
                    if fate>miracle %losowanie cudu
                        next_q2(i,j)=1;%recovered
                    end
                    if fate<death_rate %losowanie 艣mierci
                        next_q2(i,j)=-1;%dead
                    end
                    
                case 5 %sick
                    %mo偶e by膰 dead, recovered, in quarantine, in hospital
                    
                    if map_q1(i,j) == 0%no security measures
                        if base_prob*no_security_measures<neighbours_threshold
                            if rand()>no_security_measures*base_prob %losowanie infekcji
                                next_q2(i,j)=2;%in quarantine
                            else
                                next_q2(i,j)=4;%in hospital
                            end
                        else
                            next_q2(i,j)=5;%sick
                        end
                        
                    elseif map_q1(i,j) == 2%protecting others
                        if base_prob*protecting_others<neighbours_threshold
                            if rand()>protecting_others*base_prob %losowanie infekcji
                                next_q2(i,j)=2;%in quarantine
                            else
                                next_q2(i,j)=4;%in hospital
                            end
                        else
                            next_q2(i,j)=5;%sick
                        end
                    end  
                    
                    fate = rand();
                    if fate>miracle %losowanie cudu
                        next_q2(i,j)=1;%recovered
                    end
                    if fate<death_rate %losowanie 艣mierci
                        next_q2(i,j)=-1;%dead
                    end
            end
            
            
            
%________next_q1___________________________________________________________
            
            switch next_q2(i,j)%stwierdzanie next_q1
                
                
                case -1 %dead
                    next_q1(i,j)=0;%no security measures
                    
                    
                case 0 %healthy
                    if map_q1(i,j) == 0%no security measures
                        if rand() > self_protecting_threshold%losowanie
                            next_q1(i,j)=0;%no security measures
                        else
                            next_q1(i,j)=1;%self protecting
                        end
                    else
                        next_q1(i,j)=1;%self protecting
                    end

                    
                case 1 %recovered
                    if map_q1(i,j) == 0%no security measures
                        if rand() > protecting_others_threshold%losowanie
                            next_q1(i,j)=0;%no security measures
                        else
                            next_q1(i,j)=2;%protecting others
                        end
                    else
                        next_q1(i,j)=2;%protecting others
                    end

                    
                case 2 %in quarantine
                    next_q1(i,j)=2;%protecting others

                    
                case 3 %infected
                    if map_q1(i,j) == 0%no security measures
                        if rand() > protecting_others_threshold%losowanie
                            next_q1(i,j)=0;%no security measures
                        else
                            next_q1(i,j)=2;%protecting others
                        end
                    else
                        next_q1(i,j)=2;%protecting others
                    end

                    
                case 4 %in hospital
                    next_q1(i,j)=2;%protecting others

                    
                case 5 %sick
                    if map_q1(i,j) == 0%no security measures
                        if rand() > protecting_others_threshold%losowanie
                            next_q1(i,j)=0;%no security measures
                        else
                            next_q1(i,j)=2;%protecting others
                        end
                    else
                        next_q1(i,j)=2;%protecting others
                    end
            end
            
            
            
%______update licznik體____________________________________________________
            switch next_q2(i,j)
                case -1
                    dead = dead+1;
                case 0
                    healthy = healthy+1;

                case 1
                    recovered = recovered+1;

                case 2
                    in_quarantine = in_quarantine+1;

                case 3
                    infected = infected+1;

                case 4
                    in_hospital = in_hospital+1;

                case 5
                    sick = sick+1;
            end
            
            switch next_q1(i,j)
                case 0
                    no_sec = no_sec+1;
                case 1
                    self_prot = self_prot+1;
                case 2
                    prot_oth = prot_oth+1;
            end
            
            
            
            
        end
    end
    
    
    
%____update licznik體______________________________________________________
    
    dead_cnt(n) = dead;
    healthy_cnt(n) = healthy;
    recovered_cnt(n) = recovered;
    in_quarantine_cnt(n) = in_quarantine;
    infected_cnt(n) = infected;
    in_hospital_cnt(n) = in_hospital;
    sick_cnt(n) = sick;
    no_sec_cnt(n) = no_sec;
    self_prot_snt(n) = self_prot;
    prot_oth_cnt(n) = prot_oth;
     
    
    
%______koniec przej艣cia po mapie__________________________________________
    
    map_q1 = next_q1;
    map_q2 = next_q2;
    
    
    
%__________wizualizacje____________________________________________________
    
    %imshow(map_q2+1,[])
    %figure(1)
    imagesc(app.AustriaVis,map_q2, [-1 6])
    colormap([0 0 0; 255/255 255/255 255/255; 158/255 201/255 250/255; 255/255 194/255 26/255; 255/255 152/255 43/255; 255/255 112/255 71/255; 255/255 0 53/255])
    title (sprintf('Iteracja: %d',n))
    colorbar
    
    %pause(0.05);
    if(visualisation_counter == 10)
        visualisation_counter = 0;
        %w = waitforbuttonpress();
    else 
        visualisation_counter = visualisation_counter+1;
    end
    
    
    
    
%____zerowanie licznik體___________________________________________________

%____q2
    dead = 0;
    healthy = 0;
    recovered = 0;
    in_quarantine = 0;
    infected = 0;
    in_hospital = 0;
    sick = 0;
%____q1
    no_sec = 0;
    self_prot = 0;
    prot_oth = 0;
 
    
end



    
