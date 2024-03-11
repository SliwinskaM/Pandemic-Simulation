function result = get_no_security_m(num, raw_num)

public_disobey = num(raw_num,16);
information = num(raw_num,15);
movement_rest = num(raw_num,14);

if public_disobey >= 7 
    if information <= 5
        if movement_rest <=5
            result=1;
        else
            result=0.8;
        end
    elseif information > 5 && information < 8
        if movement_rest <=5
            result=0.8;
        else
            result=0.6;
        end
    else
        if movement_rest <=5
            result=0.7;
        else
            result=0.5;
        end
    end
elseif public_disobey > 3 && public_disobey <7
    if information <= 5
        if movement_rest <=5
            result=0.8;
        else
            result=0.5;
        end
    elseif information > 5 && information < 8
        if movement_rest <=5
            result=0.5;
        else
            result=0.3;
        end
    else
        if movement_rest <=5
            result=0.4;
        else
            result=0.3;
        end
    end
else
    if information <= 5
        if movement_rest <=5
            result=0.6;
        else
            result=0.5;
        end
    elseif information > 5 && information < 8
        if movement_rest <=5
            result=0.5;
        else
            result=0.4;
        end
    else
        if movement_rest <=5
            result=0.3;
        else
            result=0.2;
        end
    end   
end

end