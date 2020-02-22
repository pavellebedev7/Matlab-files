function [ X1, Y1 ] = D7( X0, Y0, xDcal, yDcal)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
    yD = 0;
    L = 0;
    D = 0;
    D1 = 0;
    
    X00 = X0(1);
    Y00 = Y0(1);
    
    X = X0 - X00;
    Y = Y0 - Y00;
    
    A = (Y(length(Y)) - Y(1))/(X(length(X)) - X(1));  
    alpha = atan(A);

    lDcal = (xDcal - X00)*cos(alpha) + (yDcal - Y00)*sin(alpha);
    dDcal = (yDcal - Y00)*cos(alpha) - (xDcal - X00)*sin(alpha);
    
    for j = 1:length(X)
        L(j) = X(j)*cos(alpha) + Y(j)*sin(alpha);
        D(j) = Y(j)*cos(alpha) - X(j)*sin(alpha);
    end
    
    for k = 1:length(X)-1
        k1 = k;
        k2 = k + 1;
        if  lDcal >= L(k1) && lDcal <= L(k2) 
            yD = D(k1) + (lDcal - L(k1)) * ((D(k2) - D(k1))/(L(k2) - L(k1))); 
        break
        end
    end

    for i = 1:length(Y)
        D1(i) = D(i) * dDcal / yD;
    end
    
    for n = 1:length(Y)
        X1(n) = L(n)*cos(-alpha) + D1(n)*sin(-alpha);
        Y1(n) = D1(n)*cos(-alpha) - L(n)*sin(-alpha);
    end
    
    X1 = X1 + X00;
    Y1 = Y1 + Y00;
    
    XX = [X(1), X(length(X))];
    YY = [Y(1), Y(length(Y))];
    
    XX = XX + X00;
    YY = YY + Y00;
    
    subplot(1,2,1);
    plot(X0,Y0, X1,Y1,xDcal,yDcal, 'ko', XX, YY);
    %axis([X(1),X(length(X)),Y(1),Y(length(Y))]);
    grid on;
    axis equal;
    title('Y = f(X)'); 
    xlabel('X'); 
    ylabel('Y'); 
    
    subplot(1,2,2);
    plot(L,D,L,D1,lDcal,dDcal, 'ko');
    grid on;
    axis equal;
    title('D = f(L)'); 
    xlabel('L'); 
    ylabel('D'); 
end

