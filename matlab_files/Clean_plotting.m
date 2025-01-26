figure('NumberTitle', 1, 'Name', 'input : u1 and phi')

x= out.tr_tt.Data(1,:);
y= out.tr_tt.Data(2,:);
the= out.tr_tt.Data(3,:);
x_tr= out.tr_tt1.Data(1,:);
y_tr= out.tr_tt1.Data(2,:);
the_tr= out.tr_tt1.Data(3,:);

x_car_ori = out.tr_tt2.Data(1,:);
y_car_ori = out.tr_tt2.Data(2,:);
the_car_ori = out.tr_tt2.Data(3,:);
x_tr_ori = out.x_ori_trailer.Data(1,:);
y_tr_ori = out.y_ori_trailer.Data(1,:);
the_tr_ori = out.tr_tt2.Data(:,3);

subplot(2,1,1) 
plot(x,y,x_tr,y_tr)
legend('car position','trailer position')
title('Results of trying to follow') 
xlabel 'x position'; 
ylabel 'y position'; 

subplot(2,1,2) 
plot(x_car_ori,y_car_ori,x_tr_ori,y_tr_ori);
legend('car original or input position','trailer original or input position')
title('path followed') 
xlabel 'x position'; 
ylabel 'y position'; 



figure('NumberTitle', 2, 'Name', 'input : u1 and u2')

x2= out.tr_tt4.Data(1,:);
y2= out.tr_tt4.Data(2,:);
the2= out.tr_tt4.Data(3,:);
x_tr2= out.tr_tt5.Data(1,:);
y_tr2= out.tr_tt5.Data(2,:);
the_tr2= out.tr_tt5.Data(3,:);

x_car_ori2 = out.tr_tt3.Data(1,:);
y_car_ori2 = out.tr_tt3.Data(2,:);
the_car_ori2 = out.tr_tt9.Data;
x_tr_ori2 = out.x_ori_trailer.Data(1,:);
y_tr_ori2 = out.y_ori_trailer.Data(1,:);
the_tr_ori2 = out.tr_tt3.Data(:,3);

subplot(2,1,1) 
plot(x2,y2,x_tr2,y_tr2)
legend('car position','trailer position')
title('Results of trying to follow') 
xlabel 'x position'; 
ylabel 'y position'; 
legend('car position','trailer position')

subplot(2,1,2) 
plot(x_car_ori2,y_car_ori2,x_tr_ori2,y_tr_ori2);
legend('car original or input position','trailer original or input position')
title('path followed') 
xlabel 'x position'; 
ylabel 'y position'; 


% A=[x_car_ori y_car_ori the_car_ori x_tr_ori y_tr_ori the_tr_ori];
% T = array2table(A);
% T.Properties.VariableNames(1:6) = {'tractor_x','tractor_y','tractor_theta', 'trailer_x', 'trailer_y', 'trailer_theta'};
% writetable(T,'file1.csv')

% t=linspace(-10,10)
% plot(t,atan2(t,1))