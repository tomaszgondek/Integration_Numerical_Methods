%BEGIN
clear;
clc;
syms x;

%functions to evaluate (one at the time)

%fun1 = @(x)cos(x); 
%a = pi/6;
%b = pi/2;

fun1 = @(x) 1./(1.+x.^2);
a = 0;
b = 1;

%WARNING: the drawing of rectangles do not work with negative intervals
%fun1 = @(x) 8./x; 
%a = -15;
%b = -3;


%ANALYTICAL SOLUTION

disp('The function: ');
disp(fun1);
intref = integral(fun1, a, b); %our reference integral
disp('Solution: ');
disp(intref);
fplot(fun1, [a b]); %initial plot

hold on;
%user input to determine amount of steps for all approximations
step = input('Enter the amount of steps for approximation (trapezoidal and rectangular): ');

%TRAPEZOIDAL APPROXIMATION
warning("off"); 
%polyshape() throws warnings concerning its accuracy, not important in this
%case as we just want to have approximate view on this method
disp('---TRAPEZOIDAL---');
h = (b-a)/step; %width
sum = 0;        %initializing sum
sum_b = 0;      
for i=1:1:step-1
    sum = sum + fun1(a+i*h);  %algorythm  
end
%the loop below includes the same algorythm as the loop above, but it is
%not the part of approximation. All It does is drawing trapezoids on the
%plot. I could not do this in the main loop as it starts from 1, so the
%first width would be blank. The loop below starts from 0 so it draws nice
%trapezoids but returns incorrect results
for i=0:1:step-1
    sum_b = sum_b + fun1(a+i*h);    
    if (i>=0)
        plot(polyshape([a+i*h,a+i*h,a+(i+1)*h,a+(i+1)*h],[0,fun1(a+i*h),fun1(a+(i+1)*h),0]),'FaceColor','red');
        hold on;
    end
end

trprez = h/2*(fun1(a)+fun1(b)+2*sum); %final result
disp('The trapezoidal approximation result: ');
disp(trprez);
error = intref-trprez; %error checking
disp('error: ')
disp(error);


%RECTANGULAR APPROXIMATION

disp('---RECTANGULAR---');
sum2 = 0; %initializing sum
for i=0:1:step-1 %algorithm
    xn= a + (i * h);
    sum2 = sum2 + fun1(xn)*h;
    %in this case the loop starts from 0 so no problems with 
    %drawing rectangles on the plot
    if(i>=0)
        rectangle('position', [xn 0 h fun1(xn)]);
    end
end
hold off;
Rec = h * sum2; %final result
disp('The rectangular approximation result: ');
disp(Rec);
error2 = intref-Rec; %error checking
disp('error: ');
disp(error2);

%SIMPSON FORMULA
disp('---SIMPSON-FORMULA---')
h2 = ((b-a)/2)/step; %width
sum3=0; %initializing sum
for i=0:step %algorithm, no drawing this time
    sum3 = sum3+(fun1(a+(2*i-2)*h2) + 4*fun1(a+(2*i-1)*h) + fun1(a+(2*i)*h2))*h2/3;
end
simint = sum3; %final result
error3 = intref - simint; %error checking
disp('The Simpson Formula result: ');
disp(simint);
disp('error: ');
disp(error3)
%END