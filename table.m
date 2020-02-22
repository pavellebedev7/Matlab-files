function [ X ] = X(ADC, T, Table)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
    X = zeros(size(ADC));

    for n = 1:length(ADC);
        
        X0 = 0;
        T0 = 0;
        dX = 0;
        Table0 = [0,0,0;0,0,0;0,0,0];
        Tp = 0;
        Xp = 0;

        X(n) = ADC(n);

        if T(n) < Table(1,2)
            T0 = Table(1,2);
        else 
            if T(n) > Table(1,6)
                T0 = Table(1,6);
            else
                T0 = T(n);
            end
        end
        
        %T0

        if X(n) > Table(2,1)
            X0 = Table(2,1);
        else 
            if X(n) < Table(6,1)
                X0 = Table(6,1);
            else
                X0 = X(n);
            end
        end
        
       %X0

        for i = 2:5
            if (T0 >= Table(1,i)) && (T0 <= Table(1,i+1))
                Tp = i;
                break;
            end
        end

        for k = 2:5
            if (X0 <= Table(k,1)) && (X0 >= Table(k+1,1))
                Xp = k;
                break;
            end
        end

        Table0(1,2) = Table(1,Tp);
        Table0(1,3) = Table(1,Tp+1);
        Table0(2,1) = Table(Xp,1);
        Table0(3,1) = Table(Xp+1,1);    
        for l = 1:2
            for p = 1:2
                Table0(l+1,p+1) = Table(Xp+l-1, Tp+p-1);
            end
        end
        
        %Table0
        
        dT1 = Table0(3,2) + (X0 - Table0(3,1))*(Table0(2,2) - Table0(3,2))/(Table0(2,1) - Table0(3,1));
        dT2 = Table0(3,3) + (X0 - Table0(3,1))*(Table0(2,3) - Table0(3,3))/(Table0(2,1) - Table0(3,1));

        dX = dT1 + (T0 - Table0(1,2))*(dT2 - dT1)/(Table0(1,3) - Table0(1,2));

        X(n) = X(n) + dX;

        end
    end


