function multiplot_corr( tpicas, tpicat, cpds, cpdt, btds, btdt, autocors,autocort )

%%% Input- 
% tpicas=space autocorrelation of tpica 
% tpicat=time autocorrelation of tpica 
% cpds=space autocorrelation of cpd 
% cpdt=time autocorrelation of cpd 
% btds=space autocorrelation of btd 
% btdt=time autocorrelation of btd
%autocors=autocorrelation space
%autocort=autocorrelation time

autcorr_tpica=zeros(size(tpicas,1),size(tpicas,2));
autcorr_cpd=zeros(size(tpicas,1),size(tpicas,2));
autcorr_btd=zeros(size(tpicas,1),size(tpicas,2));
for k=1:size(tpicas,3)
    for i=1:size(tpicas,2)
        for j=1:size(tpicas,1)
            if i==j
                corr_tpica(i,k)=(abs(tpicas(i,j,k)-autocors(i,j))+abs(tpicat(i,j,k)-autocort(i,j)))/2;
                corr_cpd(i,k)=(abs(cpds(i,j,k)-autocors(i,j))+abs(cpdt(i,j,k)-autocort(i,j)))/2;
                corr_btd(i,k)=(abs(btds(i,j,k)-autocors(i,j))+abs(btdt(i,j,k)-autocort(i,j)))/2;
            else
                autcorr_tpica(i,k)=autcorr_tpica(i,k)+(abs(tpicas(i,j,k)-autocors(i,j))/2+abs(tpicat(i,j,k)-autocort(i,j))/2)/2;
                autcorr_cpd(i,k)=autcorr_cpd(i,k)+(abs(cpds(i,j,k)-autocors(i,j))/2+abs(cpdt(i,j,k)-autocort(i,j))/2)/2;
                autcorr_btd(i,k)=autcorr_btd(i,k)+(abs(btds(i,j,k)-autocors(i,j))/2+abs(btdt(i,j,k)-autocort(i,j))/2)/2;
            end
            
        end
    end
end

figure
xxline=[1,2,3,5,6,7,9,10,11];
bar(xxline-0.2,1-(corr_btd(:)),0.10,'FaceColor',[0.345, 0.549, 0.450]);
hold on
scatter(xxline-0.2,1-autcorr_btd(:),150,[0.345, 0.549, 0.450],'d','filled','MarkerEdgeColor','k');
bar(xxline,1-(corr_cpd(:)),0.10,'FaceColor',[0.949, 0.890, 0.580]);
scatter(xxline,1-autcorr_cpd(:),150,[0.949, 0.890, 0.580],'d','filled','MarkerEdgeColor','k');
bar(xxline+0.25,1-(corr_tpica(:)),0.10,'FaceColor',[0.549, 0.274, 0.274]);
scatter(xxline+0.25,1-autcorr_tpica(:),150,[0.549, 0.274, 0.274],'d','filled','MarkerEdgeColor','k');
h=legend({'BTD;Principal','BTD;Crosstalk','CPD;Principal CCD','CPD;Crosstalk','TPICA;Principal', 'TPICA;Crosstalk '});
set(h,'FontSize',16)
legendmarkeradjust(20)
set(gca,'Xtick',[1:11])
set(gca,'Xticklabel',{'Source 1','Source 2','Source 3','','Source 1','Source 2','Source 3','','Source 1','Source 2','Source 3',''})
set(gca,'FontSize',16,'FontWeight','Bold')

figure
xx=[1 , 1.1, 1.2, 1.4 ,1.5, 1.6, 1.8, 1.9, 2.0];
scatter(xx,corr_tpica(:),200,[0 0 1],'filled')
hold on
scatter(xx,corr_cpd(:),200,[1 0 0 ],'filled')
scatter(xx,corr_btd(:),200,[0.4 0.8 0.4],'filled')
scatter(xx,autcorr_tpica(:),200,[0 0 1],'d','filled')
scatter(xx,autcorr_cpd(:),200,[1 0 0 ],'d','filled')
scatter(xx,autcorr_btd(:),200,[0.4 0.8 0.4],'d','filled')
h=legend({'TPICA;Principal CCD', 'CPD;Principal CCD', 'BTD;Principal CCD', 'TPICA;Mean crosstalk CCD', 'CPD;Mean crosstalk CCD','BTD;Mean crosstalk CCD'});
set(h,'FontSize',16)
legendmarkeradjust(20)
set(gca,'Xtick',[0.9, 1 , 1.1, 1.2, 1.3, 1.4 ,1.5, 1.6, 1.7 ,1.8, 1.9, 2.0, 2.1])
set(gca,'Xticklabel',{'','Source 1','Source 2','Source 3','','Source 1','Source 2','Source 3','','Source 1','Source 2','Source 3',''})
set(gca,'FontSize',16,'FontWeight','Bold')
end

