$ontext
Emissions sub-model in KEM. It accounts for CO2, NOx, and SOx.
Now accounts to emissions in GCC region.
$offtext

Scalar MetricToninShortTon /0.907185/
       GallonsinBarrel /41/
       MMBTUinSCF /0.001026/
;
*Emissions factors:

*Units for emissions factors in million metric tons of CO2 per TWh_e produced.
* IEA CO2 Emissions from Fuel Combustion: Highlights (2013, p. 43)
EMfactors('EL','Coal','CO2')=0.860;
EMfactors('EL','Arablight','CO2')=0.635;
EMfactors('EL','methane','CO2')=0.400;
EMfactors('EL','diesel','CO2')=0.715;
EMfactors('EL','HFO','CO2')=0.670;

EMfactors('WA','Arablight','CO2')=(74.54*Fuelencon1('Arablight'))/1000;
EMfactors('WA','methane','CO2')=53.06/1000;
EMfactors('WA','diesel','CO2')=(73.96*Fuelencon1('diesel'))/1000;
EMfactors('WA','HFO','CO2')=(75.10*Fuelencon1('HFO'))/1000;

$ontext
*Source: EPA (2014)
EMfactors('CM','Arabheavy','CO2')=(74.54*Fuelencon1('Arabheavy'))/1000;
EMfactors('CM','methane','CO2')=53.06/1000;
EMfactors('CM','diesel','CO2')=(73.96*Fuelencon1('diesel'))/1000;
EMfactors('CM','HFO','CO2')=(75.10*Fuelencon1('HFO'))/1000;

EMfactors('PC','methane','CO2')=53.06/1000;
$offtext

parameter EMfactors2(ELf) EPA factors for post report - CO2;
EMfactors2('methane')=0.05306;
EMfactors2('arablight')=0.07454;

display EMfactors;
$ontext
*Benchaita (2013, p. 70, IDB report) states that 40% of CO2 produced in ammonia
*is reacted when urea is produced.
EMPCrecovery(EMcp,PCp,PCp)=1;
EMPCrecovery('CO2','p9','p11')=-0.4;
*EMPCrecovery('CO2','p22','p11')=-0.4;
$offtext


EMprice(ksec,EMcp,trun,c)=0;

;
Equations
EMobjective
EMquantbal(ksec,EMcp,trun,c)
EMcostbal(ksec,EMcp,trun,c)
EMallquantbal(EMcp,trun,c)

DEMcost(ksec,EMcp,trun,c)
DEMquant(ksec,EMcp,trun,c)
DEMallquant(EMcp,trun,c)
;
EMallquant.up(EMcp,trun,c)=9e9;
;
EMobjective.. EMtotcost=e=sum((ksec,EMcp,t,c),EMcost(ksec,EMcp,t,c));

*PRIMAL CONSTRAINTS:

EMcostbal(ksec,EMcp,t,c).. EMcost(ksec,EMcp,t,c)
 -EMquant(ksec,EMcp,t,c)*EMprice(ksec,EMcp,t,c)=e=0;

EMallquantbal(EMcp,t,c).. EMallquant(EMcp,t,c)
 -sum(ksec,EMquant(ksec,EMcp,t,c))=g=0;

EMquantbal(ksec,EMcp,t,c).. EMquant(ksec,EMcp,t,c)
*Electricity sector
 -sum((ELpd,ELl,ELs,Elday,ELf,v,r)$(rc(r,c) and ELsect(ksec) and ELfuelburn(ELpd,v,ELf,r,c)>0),EMfactors(ksec,ELf,EMcp)*ELop(ELpd,v,ELl,ELs,ELday,ELf,t,r,c))

 -sum((ELpd,ELl,ELs,Elday,ELf,v,r)$(rc(r,c) and fMPt(ELf,c) and ELsect(ksec) and ELfuelburn(ELpd,v,ELf,r,c)>0),EMfactors(ksec,ELf,EMcp)*ELop_trade(ELpd,v,ELl,ELs,ELday,ELf,t,r,c))

*Water sector
 -sum((WAf,r)$(rc(r,c) and WAsect(ksec)),EMfactors(ksec,WAf,EMcp)*WAfconsump(WAf,t,r,c))
 -sum((WAf,r)$(rc(r,c) and fMPt(WAf,c) and WAsect(ksec)),EMfactors(ksec,WAf,EMcp)*WAfconsump_trade(WAf,t,r,c))


*Cement sector
* -sum((CMf,r,c)$(rc(r,c) and CMsect(ksec)),EMfactors(ksec,CMf,EMcp)*CMfconsump(CMf,t,r,c))
* -sum((CMp,CMci,CMf,r,c)$(rc(r,c) and CMsect(ksec) and CO2(EMcp)),CMprocessuse(CMci,CMp)*CMmassout(CMci,'CO2',CMp)*CMop(CMci,CMp,CMf,t,r,c))

*Refining sector
* -sum((RFf,r,c)$(rc(r,c) and RFsect(ksec)),EMfactors(ksec,RFf,EMcp)*sum((RFs,RFp,RFff),RFyield(RFs,RFf,RFff,RFp)*RFop(RFs,RFf,RFp,t,r,c)))

*Petrochemicals sector
* -sum(PCpp,sum((PCm,PCp,r,c)$(rc(r,c) and PCsect(ksec)),EMPCrecovery(EMcp,PCp,PCpp)*EMfactors(ksec,PCm,EMcp)*PCfconv(PCm)*PCfuelburn(PCm,PCpp)*PCop(PCpp,t,r,c)))
=g=0;


*DUAL CONSTRANTS:

DEMcost(ksec,EMcp,t,c).. 1=g=DEMcostbal(ksec,EMcp,t,c);

DEMallquant(EMcp,t,c).. 0=g=DEMallquantbal(EMcp,t,c);

DEMquant(ksec,EMcp,t,c).. 0=g=-EMprice(ksec,EMcp,t,c)*DEMcostbal(ksec,EMcp,t,c)
 +DEMquantbal(ksec,EMcp,t,c)
 -DEMallquantbal(EMcp,t,c);


*Remaining dual terms in other sub-models in KEM.

*+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
*+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
*+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
*Parameter EMtotalemit(EMcp,trun) total sectoral emissions by product in millions of metric tons;
*EMtotalemit(EMcp,trun)=sum(ksec,EMquant.l(ksec,EMcp,trun));



