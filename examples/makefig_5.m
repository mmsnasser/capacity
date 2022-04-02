% 
% 
error05 = [
   0.037892578418514
   0.001797422070901
   0.000114529939746
   0.000008328107134
   0.000000518532790
   0.000000037453275
   0.000000002331532
   0.000000000160044
   0.000000000011728
   0.000000000000741
   0.000000000000052
   0.000000000000004
   ];
error2 = [
   0.139434128072720
   0.026635262187364
   0.006599529351905
   0.001711624940163
   0.000437900155435
   0.000118181896944
   0.000030893307916
   0.000008215683712
   0.000002183778514
   0.000000579001418
   0.000000155001078
   0.000000041135136
   0.000000010958874
   0.000000002914937
   0.000000000774117
   0.000000000205744
   0.000000000054609
   0.000000000014499
   0.000000000003849
   0.000000000001021
   0.000000000000271
   0.000000000000072
   0.000000000000019
   0.000000000000006
   ];
error5 =[
   0.282433547378953
   0.126805769485198
   0.068780425764233
   0.040283042536785
   0.023886125085547
   0.014335641720883
   0.008513490122721
   0.005095015099496
   0.003049951367513
   0.001831218183746
   0.001100942849250
   0.000661501964211
   0.000397308095726
   0.000238543116542
   0.000143075425388
   0.000085763359004
   0.000051384068916
   0.000030778478627
   0.000018431895484
   0.000011036773832
   0.000006608213601
   0.000003956568050
   0.000002368962606
   0.000001418451798
   0.000000849366043
   0.000000508633919
   0.000000304613969
   0.000000182444846
   0.000000109283043
   0.000000065465873
   0.000000039221049
   0.000000023499912
   0.000000014081746
   0.000000008438986
   0.000000005057869
   0.000000003031716
   0.000000001817409
   0.000000001089582
   0.000000000653297
   0.000000000391745
   0.000000000234931
   0.000000000140903
   0.000000000084516
   0.000000000050699
   0.000000000030416
   0.000000000018249
   0.000000000010950
   0.000000000006571
   0.000000000003943
   0.000000000002367
   0.000000000001421
   0.000000000000854
   0.000000000000513
   0.000000000000308
   0.000000000000185
   0.000000000000112
   0.000000000000067
   0.000000000000039
   0.000000000000024
   0.000000000000014
   0.000000000000008
   ];
%
gmres05(1:12,1) = 66;
gmres2 = [37;37]; gmres2(3:24,1)=36;
gmres5 = [26]; gmres5(2:61,1)=25;
% 
tim = [68.9 70.15 127.72];
%%
N1 = length(error05);
p1 = polyfit(1:N1,log(error05'),1);
a1 = p1(1,1)
b1 = p1(1,2);
c1 = exp(b1);
q1 = exp(a1);
%
N2 = length(error2);
p2 = polyfit(1:N2,log(error2'),1);
a2 = p2(1,1)
b2 = p2(1,2);
c2 = exp(b2);
q2 = exp(a2);
%
N3 = length(error5);
p3 = polyfit(1:N3,log(error5'),1);
a3 = p3(1,1)
b3 = p3(1,2);
c3 = exp(b3);
q3 = exp(a3);
%
figure;
set(groot,'defaultAxesTickLabelInterpreter','latex');  
set(groot,'defaulttextinterpreter','latex');
set(groot,'defaultLegendInterpreter','latex');
semilogy(1:N1,error05,'ob','LineWidth',1.5)
hold on
semilogy(0:N1+1,c1*(0.067).^(0:N1+1),'-b','LineWidth',1.5)
%
semilogy(1:N2,error2,'pr','LineWidth',1.5)
hold on
semilogy(0:N2+1,c2*(0.264).^(0:N2+1),'-r','LineWidth',1.5)
%
semilogy(1:N3,error5,'dk','LineWidth',1.5)
hold on
semilogy(0:N3+2,c3*(0.599).^(0:N3+2),'-k','LineWidth',1.5)
%
xlabel('The number of iteration: $k$')
legend({'$E_k$ ($r=0.05$)','$O(0.067^k)$','$E_k$ ($r=0.2$)','$O(0.264^k)$',...
         '$E_k$ ($r=0.5$)','$O(0.599^k)$'},'Location','northeast','Interpreter','latex')
xticks([0:10:60])
yticks([1e-14 1e-10 1e-5 1e0 5 10])
set(gca,'FontSize',18)
grid on; grid('minor')
set(gca, 'XMinorTick','on'); set(gca, 'YMinorTick','on')
ax=gca; ax.GridAlpha=0.5; ax.MinorGridAlpha=0.5;
set(gca,'LooseInset',get(gca,'TightInset'))
axis([0  61  3e-15  1e0])
print -depsc map_error
%%
figure;
set(groot,'defaultAxesTickLabelInterpreter','latex');  
set(groot,'defaulttextinterpreter','latex');
set(groot,'defaultLegendInterpreter','latex');
plot(1:N1,gmres05,'db','LineWidth',1.5)
hold on
plot(1:N2,gmres2,'pr','LineWidth',1.5)
plot(1:N3,gmres5,'ok','LineWidth',1.5)
%
xlabel('The number of iteration: $k$')
ylabel('Number of GMRES iterations')
legend({'$r=0.05$','$r=0.2$','$r=0.5$'},'Location','northeast','Interpreter','latex')
set(gca,'FontSize',18)
grid on; grid('minor')
set(gca, 'XMinorTick','on'); set(gca, 'YMinorTick','on')
ax=gca; ax.GridAlpha=0.5; ax.MinorGridAlpha=0.5;
set(gca,'LooseInset',get(gca,'TightInset'))
axis([0  61  0  80])
print -depsc map_gmres
%%
    