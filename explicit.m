function T=explicit(del_t)

% Homework 4 Problem 2 AOE/ME Adv. Intro. to CFD


% This function would compute 1D temperature filed using 
% explicit method for unsteady heat transfer in one space coordinate

%T_0 is B.C at x=0; and T_L is B.C at x=L;
%L is total length; T is total time

L=1;T=10;T_0=0;T_L=0;del_x=0.1;

% Properties
c=100;
alpha=0.01;
r=alpha*del_t/((del_x)^2);

% definining necessary vectors
x=[0:del_x:L];
t=[0:del_t:T];
T=zeros(length(t),length(x));
size(T)
T(:,1)=T_0;
T(:,length(x))=T_L;

% Initial B.C
T(1,1:length(x))=c.*sin((pi.*x)./L);
% 
% computing

for i=[1:length(t)-1]
    for j=[1: length(x)-2]
        T(i+1,j+1)=r*T(i,j)+(1-2*r)*T(i,j+1)+r*T(i,j+2);
    end
end

% size(x)
% size(t)
% size(T)

%Postprocessing

surf(x,t,T)
xlabel('length (m)')
ylabel('Time (h)')
zlabel('Temperature in Degree C')
title('Explicit method')
grid off

figure();
contourf(T,'ShowText','on')
title('Explicit method')

figure();
for q=1:20:length(T)
    txt = ['t = ',num2str(t(q))];
    plot([0:del_x:L],T(q,:),'DisplayName',txt);
    title('Explicit method')
    hold on
end
legend show

xlswrite('T_explicit_10h',T(101,:))
end