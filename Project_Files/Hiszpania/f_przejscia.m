%% Autor: Karolina Œwierczek
% funkcje przejscia

plansza_pom = 0.1*ones(rozmiar,rozmiar,liczba_cykli+1);
plansza_pom(:,:,1) = plansza;

% prawdopodobienstwa:
elem = 1; % potrzebne do funkcji binornd
pq_i = str2double(param_struct.pq_i.Value);
pq_is = str2double(param_struct.pq_is.Value);
pi_is = str2double(param_struct.pi_is.Value);
pi_r = str2double(param_struct.pi_r.Value);
ps_ih = str2double(param_struct.ps_ih.Value);
pis_ih = str2double(param_struct.pis_ih.Value);
pis_r = str2double(param_struct.pis_r.Value);
pih_r = str2double(param_struct.pih_r.Value);
pih_d = str2double(param_struct.pih_d.Value);
pih_h = str2double(param_struct.pih_h.Value);
ogr_sum = str2double(param_struct.ogr_sum.Value);

for n = 1:liczba_cykli
    for w = 1:rozmiar
        for k = 1:rozmiar
            [s01,s03,s15,s21,s22,s24,s31,s33,s34,s41,s42,s44,s55,s61,s63,s75] = f_policz_sasiadow(plansza_pom(:,:,n),w,k);
            % healthy:
            if (plansza_pom(w,k,n)==0.1)
                if (s31>=1)
                    plansza_pom(w,k,n+1) = randsample(sick_w,1);
                elseif (s21>=ogr_sum || s22>=2*ogr_sum || s41>=ogr_sum || s42>=2*ogr_sum)
                    plansza_pom(w,k,n+1) = randsample(quar_w,1);
                else
                    plansza_pom(w,k,n+1) = randsample(healthy_w,1);
                end
            end
            if (plansza_pom(w,k,n)==0.3)
                plansza_pom(w,k,n+1) = randsample(healthy_w,1);
            end
            % in_quarantine:
            if (plansza_pom(w,k,n)==1.5)
                if (binornd(elem,pq_i)==1)
                	plansza_pom(w,k,n+1)=randsample(inf_w,1);
                elseif (binornd(elem,pq_is)==1)
                	plansza_pom(w,k,n+1)=randsample(inf_sick_w,1);
                else
                    if (n>=14)
                        tyg2 = zeros(1,13);
                        for par = 1:13
                            tyg2(par) = plansza_pom(w,k,n-par);
                        end
                        tyg2 = tyg2-1.5;
                        if (sum(tyg2)==0)
                            plansza_pom(w,k,n+1)=randsample(healthy_w,1);
                        elseif (sum(tyg2)>0)
                            plansza_pom(w,k,n+1)=randsample(quar_w,1);
                        end
                    else
                        plansza_pom(w,k,n+1)=randsample(quar_w,1);
                    end
                end
            end
            % infected:
            if (plansza_pom(w,k,n)==2.1 || plansza_pom(w,k,n)==2.2 || plansza_pom(w,k,n)==2.4)
                if (binornd(elem,pi_is)==1)
                	plansza_pom(w,k,n+1)=randsample(inf_sick_w,1);
                elseif (binornd(elem,pi_r)==1)
                	plansza_pom(w,k,n+1)=randsample(wyleczeni_w,1);
                else
                    plansza_pom(w,k,n+1)=randsample(inf_w,1);
                end                
            end
            % sick:
            if (plansza_pom(w,k,n)==3.1)
                if (s21>=ogr_sum || s22>=ogr_sum || s41>=ogr_sum || s42>=ogr_sum)
                    plansza_pom(w,k,n+1) = randsample(quar_w,1);
                else
                    if (binornd(elem,ps_ih)==1)
                        plansza_pom(w,k,n+1)=randsample(hosp_w,1);
                    else
                        plansza_pom(w,k,n+1) = randsample(sick_w,1);
                    end                    
                end
            end
            if (plansza_pom(w,k,n)==3.3)
                if (binornd(elem,ps_ih)==1)
                	plansza_pom(w,k,n+1)=randsample(hosp_w,1);
                else
                    if (n>=3)
                        dni = zeros(1,4);
                        for par2 = 1:2
                            dni(par2) = plansza_pom(w,k,n-par2);
                        end
                        dni = dni-3.3;
                        if (sum(dni)==0)
                            plansza_pom(w,k,n+1)=randsample(healthy_w,1);
                        elseif (sum(dni)>0)
                            plansza_pom(w,k,n+1)=randsample(sick_w,1);
                        end
                    else
                        plansza_pom(w,k,n+1)=randsample(sick_w,1);
                    end
                end
            end
            if (plansza_pom(w,k,n)==3.4)
                if (s21>=ogr_sum || s22>=ogr_sum || s41>=ogr_sum || s42>=ogr_sum)
                    plansza_pom(w,k,n+1) = randsample(quar_w,1);
                else
                    if (binornd(elem,ps_ih)==1)
                        plansza_pom(w,k,n+1)=randsample(hosp_w,1);
                    else
                        plansza_pom(w,k,n+1) = randsample(sick_w,1);
                    end                    
                end
            end
            % infected_and_sick:
            if (plansza_pom(w,k,n)==4.1 || plansza_pom(w,k,n)==4.2 || plansza_pom(w,k,n)==4.4)
                if (binornd(elem,pis_ih)==1)
                	plansza_pom(w,k,n+1)=randsample(hosp_w,1);
                elseif (binornd(elem,pis_r)==1)
                	plansza_pom(w,k,n+1)=randsample(wyleczeni_w,1);
                else
                    plansza_pom(w,k,n+1)=randsample(inf_sick_w,1);
                end
            end
            % in_hospital:
            if (plansza_pom(w,k,n)==5.5)
                if (binornd(elem,pih_d)==1)
                	plansza_pom(w,k,n+1)=randsample(ofiary_w,1);
                elseif (binornd(elem,pih_h)==1)   % TESTY
                    plansza_pom(w,k,n+1)=randsample(healthy_w,1);
                elseif (binornd(elem,pih_r)==1)
                	plansza_pom(w,k,n+1)=randsample(wyleczeni_w,1);
                else
                    plansza_pom(w,k,n+1)=randsample(hosp_w,1);
                end
            end
            % recovered:
            if (plansza_pom(w,k,n)==6.1)
                if (s31>=5)
                    plansza_pom(w,k,n+1) = randsample(sick_w,1);
                elseif (s21>=4*ogr_sum || s22>=4*ogr_sum || s41>=4*ogr_sum || s42>=4*ogr_sum)
                    plansza_pom(w,k,n+1) = randsample(quar_w,1);
                else
                    plansza_pom(w,k,n+1) = randsample(wyleczeni_w,1);
                end
            end
            if (plansza_pom(w,k,n)==6.3)
                plansza_pom(w,k,n+1) = randsample(wyleczeni_w,1);
            end
            % dead:
            if (plansza_pom(w,k,n)==7.5)
                plansza_pom(w,k,n+1) = randsample(ofiary_w,1);
            end
        end
    end
end
