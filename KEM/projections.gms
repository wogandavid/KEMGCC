*$ontext
* projections
* ===========
* fuels
* announcement that natural gas production will double by 2025
parameter natgas_growth(time) growth of natural gas production relative to t1
/
t1        1.000
t2        1.040
t3        1.175
t4        1.188
t5        1.287
t6        1.402
t7        1.553
t8        1.703
t9        1.854
t10       2.004
t11       2.155
t12       2.155
t13       2.155
t14       2.155
t15       2.155
t16       2.155
/

* t2 = Aramco reported production 2016
;
fuelsupmax(natgas,time,r,c,'ss1')=fuelsupmax(natgas,'t1',r,c,'ss1')*natgas_growth(time);

* update with established source
Parameter oilprodgrowth(time) growth in oil production
/
t1        1.00
t2        1.04
t3        1.00
t4        1.02
t5        1.03
t6        1.05
t7        1.06
t8        1.08
t9        1.11
t10        1.15
t11        1.19
t12        1.22
t13        1.26
t14        1.29
t15        1.32
t16        1.35
/

* t2 = Aramco reported production 2016
;

fuelsupmax(crude,time,r,c,ss)$rc(r,c)=fuelsupmax(crude,'t1',r,c,ss)*oilprodgrowth(time);

* increase fuel supply with growth in production
Fueluse.up(fup,ss,trun,r,c)=fuelsupmax(fup,trun,r,c,ss);

display fuelsupmax;

Parameter oilpricegrowth(time) growth of Brent crude price in 2015 real USD
/
t1     1
t2     0.658396947
t3     0.721374046
t4     0.816793893
t5     0.891221374
t6     0.734732824
t7     0.654580153
t8     0.763358779
t9     0.917938931
t10    1.06870229
t11    1.148854962
t12    1.145038168
t13    1.141221374
t14    1.13740458
t15    1.118320611
t16    1.083969466
/
* IHS Autonomy, 2016 release
;

fintlprice(crude,time)=fintlprice(crude,'t1')*oilpricegrowth(time);

* assume natural gas price increases with oil price
fintlprice(natgas,time)=fintlprice(natgas,'t1')*oilpricegrowth(time);
RFintlprice('diesel',time)=RFintlprice('diesel','t1')*oilpricegrowth(time);
RFintlprice('HFO',time)=RFintlprice('HFO','t1')*oilpricegrowth(time);


* update with established source
Parameter coalpricegrowth(time) growth in coal price
/
t1        1
t2        0.9585
t3        1.0194
t4        1.0803
t5        1.1412
t6        1.2021
t7        1.263
t8        1.3239
t9        1.3848
t10       1.4457
t11       1.5066
t12       1.5675
t13       1.6284
t14       1.6893
t15       1.7502
t16       1.8111
t17       1.872
t18       1.9329
t19       1.9938
t20       2.0547
/
;

fintlprice('coal',time)=fintlprice('coal',time)*coalpricegrowth(time);

display fuelcst,fuelsupmax;

*OTHERfconsump(fup,time,r,c)=1;

* capital cost declines
ELcapital('Steam','t6',r,c)=     ELcapital('Steam','t1',r,c);
ELcapital('Stscrub','t6',r,c)=   ELcapital('Stscrub','t1',r,c);
ELcapital('GT','t6',r,c)=        ELcapital('GT','t1',r,c);
ELcapital('CoalSteam','t6',r,c)= ELcapital('CoalSteam','t1',r,c);
ELcapital('CC','t6',r,c)=        ELcapital('CC','t1',r,c);
*ELcapital('GTtoCC','t6',r,c)=    240;
ELcapital('GTtoCC','t6',r,c)=    ELcapital('CC','t1',r,c)*0.2;
ELcapital('PV','t6',r,c)=        ELcapital('PV','t1',r,c);
ELcapital('CSP','t6',r,c)=       4700;
ELcapital('Nuclear','t6',r,c)=   ELcapital('Nuclear','t1',r,c);
ELcapital('Wind','t6',r,c)=      1920;

ELcapital('Steam','t16',r,c)=     ELcapital('Steam','t1',r,c);
ELcapital('Stscrub','t16',r,c)=   ELcapital('Stscrub','t1',r,c);
ELcapital('GT','t16',r,c)=        ELcapital('GT','t1',r,c);
ELcapital('CoalSteam','t16',r,c)= ELcapital('CoalSteam','t1',r,c);
ELcapital('CC','t16',r,c)=        ELcapital('CC','t1',r,c);
*ELcapital('GTtoCC','t16',r,c)=    240;
ELcapital('GTtoCC','t16',r,c)=    ELcapital('CC','t1',r,c)*0.2;
ELcapital('PV','t16',r,c)=        ELcapital('PV','t1',r,c);
ELcapital('CSP','t16',r,c)=       3900;
ELcapital('Nuclear','t16',r,c)=   ELcapital('Nuclear','t1',r,c);
ELcapital('Wind','t16',r,c)=      1840;

* Fixed O&M declines
ELfixedOMcst('Steam','t6')=      ELfixedOMcst('Steam','t1');
ELfixedOMcst('Stscrub','t6')=    ELfixedOMcst('Stscrub','t1');
ELfixedOMcst('CoalSteam','t6')=  ELfixedOMcst('CoalSteam','t1');
ELfixedOMcst('GT','t6')=         ELfixedOMcst('GT','t1');
ELfixedOMcst('CC','t6')=         ELfixedOMcst('CC','t1');
ELfixedOMcst('CCcon','t6')=      ELfixedOMcst('CCcon','t1');
ELfixedOMcst('PV','t6')=         22;
ELfixedOMcst('CSP','t6')=        190;
ELfixedOMcst('Nuclear','t6')=   ELfixedOMcst('Nuclear','t1');
ELfixedOMcst('Wind','t6')=       48;

ELfixedOMcst('Steam','t16')=      ELfixedOMcst('Steam','t1');
ELfixedOMcst('Stscrub','t16')=    ELfixedOMcst('Stscrub','t1');
ELfixedOMcst('CoalSteam','t16')=  ELfixedOMcst('CoalSteam','t1');
ELfixedOMcst('GT','t16')=         ELfixedOMcst('GT','t1');
ELfixedOMcst('CC','t16')=         ELfixedOMcst('CC','t1');
ELfixedOMcst('CCcon','t16')=      ELfixedOMcst('CCcon','t1');
ELfixedOMcst('PV','t16')=         20;
ELfixedOMcst('CSP','t16')=        160;
ELfixedOMcst('Nuclear','t16')=   ELfixedOMcst('Nuclear','t1');
ELfixedOMcst('Wind','t16')=       48;

* interpolate
ELcapital(ELp,time,r,c)$(ord(time)<6)=ELcapital(ELp,'t1',r,c)+(ELcapital(ELp,'t6',r,c)-ELcapital(ELp,'t1',r,c))*(ord(time)-1)/5;
ELcapital(ELp,time,r,c)$(ord(time)>=6)=Elcapital(ELp,'t6',r,c)+(ELcapital(ELp,'t16',r,c)-ELcapital(ELp,'t6',r,c))*(ord(time)-6)/10;

ELfixedOMcst(ELp,time)$(ord(time)<6)=ELfixedOMcst(ELp,'t1')+(ELfixedOMcst(ELp,'t6')-ELfixedOMcst(ELp,'t1'))*(ord(time)-1)/5;
ELfixedOMcst(ELp,time)$(ord(time)>=6)=ELfixedOMcst(ELp,'t6')+(ELfixedOMcst(ELp,'t16')-ELfixedOMcst(ELp,'t6'))*(ord(time)-6)/10;

parameter popgrowthrate(time,r,c);
*Annual population growth between 2015 and 2025 (Source:CDSI):
*popgrowthrate('t1','west','ksa')=0.0216;
*popgrowthrate('t1','sout','ksa')=0.0205;
*popgrowthrate('t1','cent','ksa')=0.0215;
*popgrowthrate('t1','east','ksa')=0.0211;
popgrowthrate('t1',r,c)=0.02;

parameter popgrowth(time,r,c);
popgrowth(time,r,c)$rc(r,c)=(1+popgrowthrate('t1',r,c))**(ord(time)-1);

* other
Parameter realGDPgrowth(time) GDP growth relative to t1 2015;
realGDPgrowth(time)=1;
*realGDPgrowth('t2')=1.34;

WAdemval(time,r,c)$rc(r,c) = WAdemval('t1',r,c)*popgrowth(time,r,c);
*WAdemval(time,r,c)$rc(r,c) = WAdemval('t1',r,c);

WAgrdem(time,rr,cc)$rc(rr,cc)= WAgrdem('t1',rr,cc);

*Fuelcst(fup,ss,c)=Fuelcst(fup,ss,c);
*Fuelcst('coal',ss,c)= Fuelcst('coal',ss,c)*coalpricegrowth(time);

fconsumpmax_save(ksec,natgas,trun,r,c)=fconsumpmax_save(ksec,natgas,'t1',r,c)*natgas_growth(trun);
*fconsumpmax_save(ksec,'arablight','t2',r,c)=fconsumpmax_save(ksec,'arablight','t1',r,c)*oilprodgrowth('t2');
fconsumpmax_save(ksec,'arablight',trun,r,c)$(ord(trun)>2)=9e9;

ELfconsumpmax(ELf,trun,r,c)$rc(r,c)=fconsumpmax_save('EL',ELf,trun,r,c);
ELfconsumpmax('arablight',trun,r,c)$((ord(trun)>1) and rc(r,c))=ELfconsumpmax('arablight','t1',r,c)*1.03;

ELfconsumpmax('HFO',trun,r,c)$((ord(trun)>1) and rc(r,c))=ELfconsumpmax('HFO','t1',r,c)$rc(r,c)*oilprodgrowth(trun);
$ontext
methane_add('t1')=   103.939;
methane_add('t2')=   109.248;
methane_add('t3')=   155.841;
methane_add('t4')=   152.821;
methane_add('t5')=  184.583;
methane_add('t6')=  222.710;
methane_add('t7')=  275.360;
methane_add('t8')=  327.287;
methane_add('t9')=  379.552 +103.254 ;
methane_add('t10')= 431.253 +117.319;
methane_add('t11')= 483.173 +131.443;
methane_add('t12')= 473.458 +128.816;
methane_add('t13')= 463.203 +126.011;
methane_add('t14')= 450.781 +122.632;
methane_add('t15')= 438.109 +119.184;
methane_add('t16')= 425.212 +115.646;

ELfconsumpmax('methane',trun,'west','ksa')=fconsumpmax_save('EL','methane',trun,'west','ksa')+methane_add(trun)*0.02;
ELfconsumpmax('methane',trun,'cent','ksa')=fconsumpmax_save('EL','methane',trun,'cent','ksa')+methane_add(trun)*0.30;
ELfconsumpmax('methane',trun,'east','ksa')=fconsumpmax_save('EL','methane',trun,'east','ksa')+methane_add(trun)*0.40;
ELfconsumpmax('methane',trun,'sout','ksa')=fconsumpmax_save('EL','methane',trun,'sout','ksa')+methane_add(trun)*0;

WAfconsumpmax(WAf,trun,r,c)$rc(r,c)=fconsumpmax_save('WA',WAf,trun,r,c);
WAfconsumpmax('HFO',trun,r,c)$((ord(trun)>1) and rc(r,c))=WAfconsumpmax('HFO','t1',r,c)$rc(r,c)*oilprodgrowth(trun);
WAfconsumpmax('diesel',trun,r,c)$((ord(trun)>1) and rc(r,c))=WAfconsumpmax('diesel','t1',r,c)$rc(r,c)*oilprodgrowth(trun);

WAfconsumpmax('methane',trun,'west','ksa')=fconsumpmax_save('WA','methane',trun,'west','ksa')+methane_add(trun)*0;
WAfconsumpmax('methane',trun,'cent','ksa')=fconsumpmax_save('WA','methane',trun,'cent','ksa')+methane_add(trun)*0;
WAfconsumpmax('methane',trun,'east','ksa')=fconsumpmax_save('WA','methane',trun,'east','ksa')+methane_add(trun)*0.27;
WAfconsumpmax('methane',trun,'sout','ksa')=fconsumpmax_save('WA','methane',trun,'sout','ksa')+methane_add(trun)*0;
$offtext
OTHERfconsump('methane',trun,r,c)=OTHERfconsump('methane','t1',r,c)*natgas_growth(trun);

fimports.up(trun,'methane',r,c)=fimports.up('t1','methane',r,c)*natgas_growth(trun);

* additions and retirements
*Known capacity additions:

*
*2017:
*$ontext
*Rabigh 2 IPP (2017)
         ELaddition('CC',vn,'t3','west','ksa')=2.06;
*Jeddah South (2017)
         ELaddition('Steam',vn,'t3','west','ksa')=2.65;
*Shuqaiq (2017)
         ELaddition('Stscrub',vn,'t3','sout','ksa')=1.98;
*Qurayyah IPPs (2017)
         ELaddition('CC',vn,'t3','east','ksa')=3.927;
         ELaddition('Steam',vn,'t3','cent','ksa')=0.258;
         ELaddition('CC',vn,'t3','cent','ksa')=1.164*2+0.230;
*2018:
         ELaddition('CC',vn,'t4','cent','ksa')=1.283;
         ELaddition('Steam',vn,'t4','cent','ksa')=0.129+0.148;
         ELaddition('CC',vn,'t4','east','ksa')=.872+.605-.05;
         ELaddition('CSP',vn,'t4','east','ksa')=0.05;
         ELaddition('Steam',vn,'t4','sout','ksa')=0.66;
*2019:
         ELaddition('CC',vn,'t5','east','ksa')=0.519-0.05;
         ELaddition('CSP',vn,'t5','east','ksa')=0.05;
*2020:
         ELaddition('CC',vn,'t6','cent','ksa')=3.6;
         ELaddition('CC',vn,'t6','west','ksa')=3.6-0.180;
         ELaddition('CSP',vn,'t6','west','ksa')=0.180;
*2021:
         ELaddition('CC',vn,'t6','cent','ksa')=5.4;
*$offtext
ELretirement(ELp,vo,time,r,c)=0;

*$ontext
*Source: KFUPM Generation Report (2010)
* t1=2015
         ELretirement('GT',vo,'t2','west','ksa')=0.207;
         ELretirement('GT',vo,'t3','west','ksa')=0.217;
         ELretirement('GT',vo,'t4','west','ksa')=0.214;
         ELretirement('GT',vo,'t6','west','ksa')=0.271;
         ELretirement('GT',vo,'t5','west','ksa')=0.240;

* where t1=2015
         ELretirement('GT',vo,'t1','sout','ksa')=0.015;
         ELretirement('GT',vo,'t2','sout','ksa')=0.089;
         ELretirement('GT',vo,'t2','sout','ksa')=0.085;
         ELretirement('GT',vo,'t4','sout','ksa')=0.091;
         ELretirement('GT',vo,'t5','sout','ksa')=0.089;

* t1=2015
         ELretirement('GT',vo,'t1','cent','ksa')=0.126;
         ELretirement('GT',vo,'t2','cent','ksa')=0.210;
         ELretirement('GT',vo,'t3','cent','ksa')=0.228;
         ELretirement('GT',vo,'t4','cent','ksa')=0.240;
         ELretirement('GT',vo,'t5','cent','ksa')=0.254;

*t1=2015
         ELretirement('GT',vo,'t1','east','ksa')=0.100;
         ELretirement('GT',vo,'t2','east','ksa')=0.287;
         ELretirement('GT',vo,'t3','east','ksa')=0.232;
         ELretirement('GT',vo,'t4','east','ksa')=0.232;
         ELretirement('GT',vo,'t5','east','ksa')=0.232;
*$offtext

$ontext
ELretirement(ELp,vo,time,r,c)$rc(r,c)=0;
*$ontext
*Source: SEC (in June 2017)
ELretirement('GT',vo,'t2','west','ksa')=0.16447;
ELretirement('GT',vo,'t3','west','ksa')=0.22537;
ELretirement('GT',vo,'t4','west','ksa')=0.33327;
ELretirement('GT',vo,'t5','west','ksa')=0.13627;
ELretirement('GT',vo,'t6','west','ksa')=1.90627;
ELretirement('GT',vo,'t7','west','ksa')=0.27777;
ELretirement('GT',vo,'t8','west','ksa')=0.29277;
ELretirement('GT',vo,'t9','west','ksa')=0.124;
ELretirement('CC',vo,'t10','west','ksa')=1.0906;
ELretirement('Steam',vo,'t11','west','ksa')=0.532;

ELretirement('GT',vo,'t3','sout','ksa')=0.053;
ELretirement('GT',vo,'t4','sout','ksa')=0.036;
ELretirement('GT',vo,'t5','sout','ksa')=0.130;
ELretirement('GT',vo,'t6','sout','ksa')=0.2065;
ELretirement('GT',vo,'t7','sout','ksa')=0.225;
ELretirement('GT',vo,'t10','sout','ksa')=0.100;
ELretirement('GT',vo,'t11','sout','ksa')=0.045;
ELretirement('GT',vo,'t18','sout','ksa')=0.136;

ELretirement('GT',vo,'t2','cent','ksa')=0.44488;
ELretirement('GT',vo,'t3','cent','ksa')=0.32188;
ELretirement('GT',vo,'t4','cent','ksa')=0.15488;
ELretirement('GT',vo,'t5','cent','ksa')=0.23648;
ELretirement('GT',vo,'t6','cent','ksa')=0.25500;
ELretirement('GT',vo,'t7','cent','ksa')=0.29267;
ELretirement('GT',vo,'t8','cent','ksa')=0.29267;
ELretirement('GT',vo,'t9','cent','ksa')=0.29267;
ELretirement('CC',vo,'t9','cent','ksa')=0.33360;
ELretirement('CC',vo,'t10','cent','ksa')=0.33360;
ELretirement('GT',vo,'t10','cent','ksa')=0.48000+0.34380;
ELretirement('CC',vo,'t11','cent','ksa')=0.66720;
ELretirement('GT',vo,'t13','cent','ksa')=0.030;
ELretirement('GT',vo,'t18','cent','ksa')=0.051;

ELretirement('GT',vo,'t2','east','ksa')=0.237;
ELretirement('GT',vo,'t3','east','ksa')=0.296;
ELretirement('GT',vo,'t4','east','ksa')=0.268;
ELretirement('GT',vo,'t5','east','ksa')=0.268;
ELretirement('GT',vo,'t6','east','ksa')=0.310;
ELretirement('GT',vo,'t7','east','ksa')=0.242;
ELretirement('GT',vo,'t8','east','ksa')=0.388;
ELretirement('GT',vo,'t9','east','ksa')=0.239;
ELretirement('GT',vo,'t10','east','ksa')=0.240;
ELretirement('GT',vo,'t11','east','ksa')=0.118;
ELretirement('Steam',vo,'t13','east','ksa')=0.430;
ELretirement('Steam',vo,'t18','east','ksa')=0.625;
$offtext

* water sector

*Capacity additions:
*        addition desalination plants sourced from   ' DesalDataPojects2014'
*        Marafiq YANBU 3 new CCOO MED plant  (Source MARAFIQ.com)
WAaddition('CCCoMED','new','t3','west','ksa') = 1.2;
WAaddition('CCCoVMED','new','t3','west','ksa') = 1.5;
*        Ras Az Zawr cogen plant CC MSF
*        (source  http://www.desalination.biz/news/news_story.asp?id=5997 and
*        http://www.doosanhydro.com/news-releases/doosan-wins-worlds-largest-seawater-desalination-project-worth-us-146-billion-in-saudi-arabia.aspx)
WAaddition('CCCoMSF','new','t2','east','ksa') = 2.120;
WAaddition('CCCoVMSF','new','t2','east','ksa') = 0.530;

* Retired cogen plants sourced from ECRA National ELectricity Registry

WAretirement(WAp,vo,time,r,c)$rc(r,c) = 0;
$ontext
WAretirement('STco','old','t4','east','ksa') = 1.225;
WAretirement('STco','old','t6','east','ksa') = 0.011;
WAretirement('STco','old','t20','east','ksa') = 0.479;
WAretirement('STco','old','t9','sout','ksa') = 0.108;
WAretirement('STco','old','t9','west','ksa') = 0.263;
WAretirement('STco','old','t18','west','ksa') = 0.150;
WAretirement('STco','old','t21','west','ksa') = 0.520;

WAretirement('STcoV','old','t3','east','ksa') = 0.360;
WAretirement('STcoV','old','t3','east','ksa') = 0.710;
WAretirement('STcoV','old','t3','west','ksa') = 0.256;
WAretirement('STcoV','old','t2','west','ksa') = 0.357;
WAretirement('STcoV','old','t3','west','ksa') = 0.590;

WAretirement('MED','old','t7','west','ksa') = 0.0045;
WAretirement('SWRO','old','t3','sout','ksa') = 0.00227;
WAretirement('SWRO','new','t4','west','ksa') = 0.0044;
WAretirement('SWRO','new','t5','west','ksa') = 0.0044;
WAretirement('SWRO','new','t24','west','ksa') = 0.0134;
WAretirement('SWROhyb','new','t13','west','ksa') = 1.28182;
WAretirement('SWROhyb','new','t4','west','ksa') = 0.05680;
WAretirement('SWROhyb','new','t9','west','ksa') = 0.05680;
WAretirement('SWROhyb','new','t9','east','ksa') = 0.0909;
$offtext
