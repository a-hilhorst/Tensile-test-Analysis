

curve1 =  [linspace(0,5,10);sin(linspace(0,5,10))];
curve2 =  [linspace(1,6,12);cos(linspace(1,6,12))]';
curve3 =  1.2*[linspace(1.5,4.6,5);cos(linspace(1.5,4.6,5))]';

figure
hold on
plot(curve1(1,:),curve1(2,:),'-x','linewidth',2)
plot(curve2(:,1),curve2(:,2),'-s','linewidth',2)
plot(curve3(:,1),curve3(:,2),'-o','linewidth',2)

curves = {curve1, curve2, curve3};

n=22;
avg = mean_curve(curves,n);
plot(avg{1}(1,:),avg{1}(2,:),'-v','linewidth',2)
