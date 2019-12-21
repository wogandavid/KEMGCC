*$ontext
* projections
* ===========
* fuels
* announcement that natural gas production will double by 2025

parameter natgas_growth(time,c) growth of natural gas production relative to t1;
Parameter oilprodgrowth(time,c) growth in oil production;
Parameter oilpricegrowth(time) growth of Brent crude price in 2015 real USD;
Parameter coalpricegrowth(time) growth in coal price;

table natgas_growth(time,c)
      bah    kuw   ksa   omn   qat   uae   
t1    1.0    1.0   1.0   1.0   1.0   1.0   
t2    1.01   1.1   1.1   1.0   1.1   1.1  
t3    1.01   1.2   1.2   1.0   1.2   1.2  
t4    1.02   1.2   1.3   1.0   1.3   1.3  
t5    1.03   1.3   1.4   1.0   1.4   1.4  
t6    1.04   1.3   1.5   1.0   1.5   1.5  
t7    1.04   1.4   1.6   1.0   1.6   1.6  
t8    1.05   1.4   1.7   1.0   1.7   1.7  
t9    1.06   1.5   1.8   1.0   1.8   1.8  
t10   1.06   1.6   1.9   1.0   1.9   1.9  
t11   1.07   1.6   2.0   1.0   2.0   2.0  
t12   1.08   1.7   2.1   1.0   2.1   2.1  
t13   1.09   1.7   2.2   1.0   2.2   2.2  
t14   1.09   1.8   2.3   1.0   2.3   2.3  
t15   1.10   1.8   2.4   1.0   2.4   2.4  
t16   1.11   1.9   2.6   1.0   2.6   2.6  
;
fuelsupmax(natgas,time,r,c,'ss1')=fuelsupmax(natgas,'t1',r,c,'ss1')*natgas_growth(time,c);

table oilprodgrowth(time,c)
      bah   kuw    ksa    omn   qat   uae  
t1    1.0   1.00   1.00   1.0   1.0   1.00
t2    1.0   1.04   1.04   1.0   1.0   1.04
t3    1.0   1.00   1.00   1.0   1.0   1.00
t4    1.0   1.02   1.02   1.0   1.0   1.02
t5    1.0   1.03   1.03   1.0   1.0   1.03
t6    1.0   1.05   1.05   1.0   1.0   1.05
t7    1.0   1.06   1.06   1.0   1.0   1.06
t8    1.0   1.08   1.08   1.0   1.0   1.08
t9    1.0   1.11   1.11   1.0   1.0   1.11
t10   1.0   1.15   1.15   1.0   1.0   1.15
t11   1.0   1.19   1.19   1.0   1.0   1.19
t12   1.0   1.22   1.22   1.0   1.0   1.22
t13   1.0   1.26   1.26   1.0   1.0   1.26
t14   1.0   1.29   1.29   1.0   1.0   1.29
t15   1.0   1.32   1.32   1.0   1.0   1.32
t16   1.0   1.35   1.35   1.0   1.0   1.35
;

fuelsupmax(crude,time,r,c,ss)$rc(r,c)=fuelsupmax(crude,'t1',r,c,ss)*oilprodgrowth(time,c);
* increase fuel supply with growth in production
Fueluse.up(fup,ss,trun,r,c)=fuelsupmax(fup,trun,r,c,ss);

Parameter oilpricegrowth(time) growth of Brent crude price in 2015 real USD
/
t1       1.00
t2       0.85
t3       1.04
t4       1.50
t5       1.63
t6       1.63
t7       1.63
t8       1.63
t9       1.63
t10      1.63
t11      1.63
t12      1.63
t13      1.63
t14      1.63
t15      1.63
t16      1.63
/
;
fintlprice(crude,time)=fintlprice(crude,'t1')*oilpricegrowth(time);

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

fuelsupmax(natgas,time,r,c,'ss1')=fuelsupmax(natgas,'t1',r,c,'ss1')*natgas_growth(time,c);
fuelsupmax(crude,time,r,c,ss)$rc(r,c)=fuelsupmax(crude,'t1',r,c,ss)*oilprodgrowth(time,c);

* assume natural gas price increases with oil price
fintlprice(natgas,time)=fintlprice(natgas,'t1')*oilpricegrowth(time);
RFintlprice('diesel',time)=RFintlprice('diesel','t1')*oilpricegrowth(time);
RFintlprice('HFO',time)=RFintlprice('HFO','t1')*oilpricegrowth(time);

fintlprice('coal',time)=fintlprice('coal',time)*coalpricegrowth(time);

display fuelcst,fuelsupmax;

** new cost declines
*
Elcapital('PV','t2',r,c)=1777.99097225561;
Elcapital('PV','t3',r,c)=1211.91796518971;
Elcapital('PV','t4',r,c)=1064.64398066585;
Elcapital('PV','t5',r,c)=1024.46873611242;
Elcapital('PV','t6',r,c)=964.205869282276;
Elcapital('PV','t7',r,c)=913.986813590491;
Elcapital('PV','t8',r,c)=903.66776595431;
Elcapital('PV','t9',r,c)=893.348718318129;
Elcapital('PV','t10',r,c)=883.029670681948;
Elcapital('PV','t11',r,c)=872.710623045768;
Elcapital('PV','t12',r,c)=862.391575409587;
Elcapital('PV','t13',r,c)=852.072527773406;
Elcapital('PV','t14',r,c)=841.753480137225;
Elcapital('PV','t15',r,c)=831.434432501045;
Elcapital('PV','t16',r,c)=821.115384864863;

Elcapital('CSP','t2',r,c)=7872.20749555855;
Elcapital('CSP','t3',r,c)=7564.85660598783;
Elcapital('CSP','t4',r,c)=7257.50571641711;
Elcapital('CSP','t5',r,c)=6950.15482684639;
Elcapital('CSP','t6',r,c)=6642.80393727567;
Elcapital('CSP','t7',r,c)=6559.12400086147;
Elcapital('CSP','t8',r,c)=6475.44406444727;
Elcapital('CSP','t9',r,c)=6391.76412803307;
Elcapital('CSP','t10',r,c)=6308.08419161887;
Elcapital('CSP','t11',r,c)=6224.40425520468;
Elcapital('CSP','t12',r,c)=6140.72431879048;
Elcapital('CSP','t13',r,c)=6057.04438237628;
Elcapital('CSP','t14',r,c)=5973.36444596208;
Elcapital('CSP','t15',r,c)=5889.68450954788;
Elcapital('CSP','t16',r,c)=5806.00457313368;

Elcapital('Wind','t2',r,c)=1528.78267934989;
Elcapital('Wind','t3',r,c)=1508.16327081305;
Elcapital('Wind','t4',r,c)=1488.24188269035;
Elcapital('Wind','t5',r,c)=1469.01851498177;
Elcapital('Wind','t6',r,c)=1450.49316768733;
Elcapital('Wind','t7',r,c)=1432.66584080702;
Elcapital('Wind','t8',r,c)=1415.53653434084;
Elcapital('Wind','t9',r,c)=1399.10524828879;
Elcapital('Wind','t10',r,c)=1383.37198265088;
Elcapital('Wind','t11',r,c)=1368.33673742709;
Elcapital('Wind','t12',r,c)=1353.99951261744;
Elcapital('Wind','t13',r,c)=1340.36030822192;
Elcapital('Wind','t14',r,c)=1327.41912424053;
Elcapital('Wind','t15',r,c)=1315.17596067327;
Elcapital('Wind','t16',r,c)=1303.63081752015;

Elcapital('Nuclear','t2',r,c)=6157.89053057038;
Elcapital('Nuclear','t3',r,c)=6154.26332383328;
Elcapital('Nuclear','t4',r,c)=6150.63611709618;
Elcapital('Nuclear','t5',r,c)=6147.00891035908;
Elcapital('Nuclear','t6',r,c)=6143.38170362198;
Elcapital('Nuclear','t7',r,c)=6139.75449688488;
Elcapital('Nuclear','t8',r,c)=6136.12729014778;
Elcapital('Nuclear','t9',r,c)=6110.97882701257;
Elcapital('Nuclear','t10',r,c)=6075.10300559862;
Elcapital('Nuclear','t11',r,c)=6043.69275321349;
Elcapital('Nuclear','t12',r,c)=6003.5186620131;
Elcapital('Nuclear','t13',r,c)=5976.38706710901;
Elcapital('Nuclear','t14',r,c)=5951.25300737095;
Elcapital('Nuclear','t15',r,c)=5919.84771946274;
Elcapital('Nuclear','t16',r,c)=5886.77614831866;

ELfixedOMcst('PV','t2')=14.0313794048719;
ELfixedOMcst('PV','t3')=9.56409849234746;
ELfixedOMcst('PV','t4')=9.20185572195811;
ELfixedOMcst('PV','t5')=8.80480456263893;
ELfixedOMcst('PV','t6')=8.08922782366017;
ELfixedOMcst('PV','t7')=7.5329138745112;
ELfixedOMcst('PV','t8')=7.45147899956552;
ELfixedOMcst('PV','t9')=7.37004412461983;
ELfixedOMcst('PV','t10')=7.28860924967414;
ELfixedOMcst('PV','t11')=7.20717437472845;
ELfixedOMcst('PV','t12')=7.12573949978276;
ELfixedOMcst('PV','t13')=7.04430462483707;
ELfixedOMcst('PV','t14')=6.96286974989138;
ELfixedOMcst('PV','t15')=6.88143487494569;
ELfixedOMcst('PV','t16')=6.8;

ELfixedOMcst('Wind','t2')=51.3309866959286;
ELfixedOMcst('Wind','t3')=50.9616990218572;
ELfixedOMcst('Wind','t4')=50.5924113477857;
ELfixedOMcst('Wind','t5')=50.2231236737143;
ELfixedOMcst('Wind','t6')=49.8538359996429;
ELfixedOMcst('Wind','t7')=49.4845483255714;
ELfixedOMcst('Wind','t8')=49.1152606515;
ELfixedOMcst('Wind','t9')=48.7459729774286;
ELfixedOMcst('Wind','t10')=48.3766853033572;
ELfixedOMcst('Wind','t11')=48.0073976292857;
ELfixedOMcst('Wind','t12')=47.6381099552143;
ELfixedOMcst('Wind','t13')=47.2688222811429;
ELfixedOMcst('Wind','t14')=46.8995346070715;
ELfixedOMcst('Wind','t15')=46.530246933;
ELfixedOMcst('Wind','t16')=46.1609592589286;

ELfixedOMcst('Nuclear','t2')=99.1968658178257;
ELfixedOMcst('Nuclear','t3')=99.1968658178257;
ELfixedOMcst('Nuclear','t4')=99.1968658178257;
ELfixedOMcst('Nuclear','t5')=99.1968658178257;
ELfixedOMcst('Nuclear','t6')=99.1968658178257;
ELfixedOMcst('Nuclear','t7')=99.1968658178257;
ELfixedOMcst('Nuclear','t8')=99.1968658178257;
ELfixedOMcst('Nuclear','t9')=99.1968658178257;
ELfixedOMcst('Nuclear','t10')=99.1968658178257;
ELfixedOMcst('Nuclear','t11')=99.1968658178257;
ELfixedOMcst('Nuclear','t12')=99.1968658178257;
ELfixedOMcst('Nuclear','t13')=99.1968658178257;
ELfixedOMcst('Nuclear','t14')=99.1968658178257;
ELfixedOMcst('Nuclear','t15')=99.1968658178257;
ELfixedOMcst('Nuclear','t16')=99.1968658178257;

parameter popgrowthrate(time,r,c);
*Annual population growth between 2015 and 2025 (Source:CDSI):
*popgrowthrate('t1','west','ksa')=0.0216;
*popgrowthrate('t1','sout','ksa')=0.0205;
*popgrowthrate('t1','cent','ksa')=0.0215;
*popgrowthrate('t1','east','ksa')=0.0211;
popgrowthrate('t1',r,c)=0.015;

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

* fuel quotas

* bah
ELfconsumpmax(ELf,trun,'bahr','bah')=fconsumpmax_save('EL',ELf,trun,'bahr','bah');
ELfconsumpmax('arablight',trun,'bahr','bah')$(ord(trun)>1)=ELfconsumpmax('arablight','t1','bahr','bah');
ELfconsumpmax('HFO',trun,'bahr','bah')$(ord(trun)>1)=ELfconsumpmax('HFO','t1','bahr','bah')*oilprodgrowth(trun,'bah');
ELfconsumpmax('diesel',trun,'bahr','bah')$(ord(trun)>1)=ELfconsumpmax('diesel','t1','bahr','bah')*oilprodgrowth(trun,'bah');
ELfconsumpmax('methane',trun,'bahr','bah')$(ord(trun)>1)=ELfconsumpmax('methane','t1','bahr','bah')*natgas_growth(trun,'bah');

WAfconsumpmax('methane',trun,'bahr','bah')$(ord(trun)>1)=WAfconsumpmax('methane','t1','bahr','bah')*natgas_growth(trun,'bah');
WAfconsumpmax('arablight',trun,'bahr','bah')$(ord(trun)>1)=WAfconsumpmax('arablight','t1','bahr','bah')*oilprodgrowth(trun,'bah');
WAfconsumpmax('HFO',trun,'bahr','bah')$(ord(trun)>1)=WAfconsumpmax('HFO','t1','bahr','bah')*oilprodgrowth(trun,'bah');
WAfconsumpmax('diesel',trun,'bahr','bah')$(ord(trun)>1)=WAfconsumpmax('diesel','t1','bahr','bah')*oilprodgrowth(trun,'bah');

* kuw
ELfconsumpmax(ELf,trun,'kuwr','kuw')=fconsumpmax_save('EL',ELf,trun,'kuwr','kuw');
ELfconsumpmax('arablight',trun,'kuwr','kuw')$(ord(trun)>1)=ELfconsumpmax('arablight','t1','kuwr','kuw');
ELfconsumpmax('HFO',trun,'kuwr','kuw')$(ord(trun)>1)=ELfconsumpmax('HFO','t1','kuwr','kuw')*oilprodgrowth(trun,'kuw');
ELfconsumpmax('diesel',trun,'kuwr','kuw')$(ord(trun)>1)=ELfconsumpmax('diesel','t1','kuwr','kuw')*oilprodgrowth(trun,'kuw');
ELfconsumpmax('methane',trun,'kuwr','kuw')$(ord(trun)>1)=ELfconsumpmax('methane','t1','kuwr','kuw')*natgas_growth(trun,'kuw');

WAfconsumpmax('methane',trun,'kuwr','kuw')$(ord(trun)>1)=WAfconsumpmax('methane','t1','kuwr','kuw')*natgas_growth(trun,'kuw');
WAfconsumpmax('arablight',trun,'kuwr','kuw')$(ord(trun)>1)=WAfconsumpmax('arablight','t1','kuwr','kuw')*oilprodgrowth(trun,'kuw');
WAfconsumpmax('HFO',trun,'kuwr','kuw')$(ord(trun)>1)=WAfconsumpmax('HFO','t1','kuwr','kuw')*oilprodgrowth(trun,'kuw');
WAfconsumpmax('diesel',trun,'kuwr','kuw')$(ord(trun)>1)=WAfconsumpmax('diesel','t1','kuwr','kuw')*oilprodgrowth(trun,'kuw');

* omn
ELfconsumpmax(ELf,trun,'omnr','omn')=fconsumpmax_save('EL',ELf,trun,'omnr','omn');
ELfconsumpmax('arablight',trun,'omnr','omn')$(ord(trun)>1)=ELfconsumpmax('arablight','t1','omnr','omn');
ELfconsumpmax('HFO',trun,'omnr','omn')$(ord(trun)>1)=ELfconsumpmax('HFO','t1','omnr','omn')*oilprodgrowth(trun,'omn');
ELfconsumpmax('diesel',trun,'omnr','omn')$(ord(trun)>1)=ELfconsumpmax('diesel','t1','omnr','omn')*oilprodgrowth(trun,'omn');
ELfconsumpmax('methane',trun,'omnr','omn')$(ord(trun)>1)=ELfconsumpmax('methane','t1','omnr','omn')*natgas_growth(trun,'omn');

WAfconsumpmax('methane',trun,'omnr','omn')$(ord(trun)>1)=WAfconsumpmax('methane','t1','omnr','omn')*natgas_growth(trun,'omn');
WAfconsumpmax('arablight',trun,'omnr','omn')$(ord(trun)>1)=WAfconsumpmax('arablight','t1','omnr','omn')*oilprodgrowth(trun,'omn');
WAfconsumpmax('HFO',trun,'omnr','omn')$(ord(trun)>1)=WAfconsumpmax('HFO','t1','omnr','omn')*oilprodgrowth(trun,'omn');
WAfconsumpmax('diesel',trun,'omnr','omn')$(ord(trun)>1)=WAfconsumpmax('diesel','t1','omnr','omn')*oilprodgrowth(trun,'omn');

* qat
ELfconsumpmax(ELf,trun,'qatr','qat')=fconsumpmax_save('EL',ELf,trun,'qatr','qat');
ELfconsumpmax('arablight',trun,'qatr','qat')$(ord(trun)>1)=ELfconsumpmax('arablight','t1','qatr','qat');
ELfconsumpmax('HFO',trun,'qatr','qat')$(ord(trun)>1)=ELfconsumpmax('HFO','t1','qatr','qat')*oilprodgrowth(trun,'qat');
ELfconsumpmax('diesel',trun,'qatr','qat')$(ord(trun)>1)=ELfconsumpmax('diesel','t1','qatr','qat')*oilprodgrowth(trun,'qat');
ELfconsumpmax('methane',trun,'qatr','qat')$(ord(trun)>1)=ELfconsumpmax('methane','t1','qatr','qat')*natgas_growth(trun,'qat');

WAfconsumpmax('methane',trun,'qatr','qat')$(ord(trun)>1)=WAfconsumpmax('methane','t1','qatr','qat')*natgas_growth(trun,'qat');
WAfconsumpmax('arablight',trun,'qatr','qat')$(ord(trun)>1)=WAfconsumpmax('arablight','t1','qatr','qat')*oilprodgrowth(trun,'qat');
WAfconsumpmax('HFO',trun,'qatr','qat')$(ord(trun)>1)=WAfconsumpmax('HFO','t1','qatr','qat')*oilprodgrowth(trun,'qat');
WAfconsumpmax('diesel',trun,'qatr','qat')$(ord(trun)>1)=WAfconsumpmax('diesel','t1','qatr','qat')*oilprodgrowth(trun,'qat');

* ksa
fconsumpmax_save(ksec,natgas,trun,r,c)=fconsumpmax_save(ksec,natgas,'t1',r,c)*natgas_growth(trun,c);
*fconsumpmax_save(ksec,'arablight','t2',r,c)=fconsumpmax_save(ksec,'arablight','t1',r,c)*oilprodgrowth('t2');
fconsumpmax_save(ksec,'arablight',trun,r,c)$(ord(trun)>2)=9e9;

ELfconsumpmax(ELf,trun,r,c)$rc(r,c)=fconsumpmax_save('EL',ELf,trun,r,c);
ELfconsumpmax('arablight',trun,r,c)$((ord(trun)>1) and rc(r,c))=ELfconsumpmax('arablight','t1',r,c)*1.03;
ELfconsumpmax('HFO',trun,r,c)$((ord(trun)>1) and rc(r,c))=ELfconsumpmax('HFO','t1',r,c)$rc(r,c)*oilprodgrowth(trun,c);

WAfconsumpmax('methane',trun,'west','ksa')$(ord(trun)>1)=fconsumpmax_save('WA','methane','t1','west','ksa')*natgas_growth(trun,'ksa');
*WAfconsumpmax('methane',trun,'cent','ksa')$((ord(trun)>1) and rc(r,c))=fconsumpmax_save('WA','methane',trun,'cent','ksa')*natgas_growth(trun,c);
WAfconsumpmax('methane',trun,'east','ksa')$(ord(trun)>1)=fconsumpmax_save('WA','methane','t1','east','ksa')*natgas_growth(trun,'ksa');
WAfconsumpmax('methane',trun,'sout','ksa')$(ord(trun)>1)=fconsumpmax_save('WA','methane','t1','sout','ksa')*natgas_growth(trun,'ksa');

* uae
ELfconsumpmax(ELf,trun,'adwe','uae')=fconsumpmax_save('EL',ELf,trun,'adwe','uae');
ELfconsumpmax('arablight',trun,'adwe','uae')$(ord(trun)>1)=ELfconsumpmax('arablight','t1','adwe','uae');
ELfconsumpmax('HFO',trun,'adwe','uae')$(ord(trun)>1)=ELfconsumpmax('HFO','t1','adwe','uae')*oilprodgrowth(trun,'uae');
ELfconsumpmax('diesel',trun,'adwe','uae')$(ord(trun)>1)=ELfconsumpmax('diesel','t1','adwe','uae')*oilprodgrowth(trun,'uae');
ELfconsumpmax('methane',trun,'adwe','uae')$(ord(trun)>1)=ELfconsumpmax('methane','t1','adwe','uae')*natgas_growth(trun,'uae');

WAfconsumpmax('methane',trun,'adwe','uae')$(ord(trun)>1)=WAfconsumpmax('methane','t1','adwe','uae')*natgas_growth(trun,'uae');
WAfconsumpmax('arablight',trun,'adwe','uae')$(ord(trun)>1)=WAfconsumpmax('arablight','t1','adwe','uae')*oilprodgrowth(trun,'uae');
WAfconsumpmax('HFO',trun,'adwe','uae')$(ord(trun)>1)=WAfconsumpmax('HFO','t1','adwe','uae')*oilprodgrowth(trun,'uae');
WAfconsumpmax('diesel',trun,'adwe','uae')$(ord(trun)>1)=WAfconsumpmax('diesel','t1','adwe','uae')*oilprodgrowth(trun,'uae');

ELfconsumpmax(ELf,trun,'dewa','uae')=fconsumpmax_save('EL',ELf,trun,'dewa','uae');
ELfconsumpmax('arablight',trun,'dewa','uae')$(ord(trun)>1)=ELfconsumpmax('arablight','t1','dewa','uae');
ELfconsumpmax('HFO',trun,'dewa','uae')$(ord(trun)>1)=ELfconsumpmax('HFO','t1','dewa','uae')*oilprodgrowth(trun,'uae');
ELfconsumpmax('diesel',trun,'dewa','uae')$(ord(trun)>1)=ELfconsumpmax('diesel','t1','dewa','uae')*oilprodgrowth(trun,'uae');
ELfconsumpmax('methane',trun,'dewa','uae')$(ord(trun)>1)=ELfconsumpmax('methane','t1','dewa','uae')*natgas_growth(trun,'uae');

WAfconsumpmax('methane',trun,'dewa','uae')$(ord(trun)>1)=WAfconsumpmax('methane','t1','dewa','uae')*natgas_growth(trun,'uae');
WAfconsumpmax('arablight',trun,'dewa','uae')$(ord(trun)>1)=WAfconsumpmax('arablight','t1','dewa','uae')*oilprodgrowth(trun,'uae');
WAfconsumpmax('HFO',trun,'dewa','uae')$(ord(trun)>1)=WAfconsumpmax('HFO','t1','dewa','uae')*oilprodgrowth(trun,'uae');
WAfconsumpmax('diesel',trun,'dewa','uae')$(ord(trun)>1)=WAfconsumpmax('diesel','t1','dewa','uae')*oilprodgrowth(trun,'uae');

ELfconsumpmax(ELf,trun,'sewa','uae')=fconsumpmax_save('EL',ELf,trun,'sewa','uae');
ELfconsumpmax('arablight',trun,'sewa','uae')$(ord(trun)>1)=ELfconsumpmax('arablight','t1','sewa','uae');
ELfconsumpmax('HFO',trun,'sewa','uae')$(ord(trun)>1)=ELfconsumpmax('HFO','t1','sewa','uae')*oilprodgrowth(trun,'uae');
ELfconsumpmax('diesel',trun,'sewa','uae')$(ord(trun)>1)=ELfconsumpmax('diesel','t1','sewa','uae')*oilprodgrowth(trun,'uae');
ELfconsumpmax('methane',trun,'sewa','uae')$(ord(trun)>1)=ELfconsumpmax('methane','t1','sewa','uae')*natgas_growth(trun,'uae');

WAfconsumpmax('methane',trun,'sewa','uae')$(ord(trun)>1)=WAfconsumpmax('methane','t1','sewa','uae')*natgas_growth(trun,'uae');
WAfconsumpmax('arablight',trun,'sewa','uae')$(ord(trun)>1)=WAfconsumpmax('arablight','t1','sewa','uae')*oilprodgrowth(trun,'uae');
WAfconsumpmax('HFO',trun,'sewa','uae')$(ord(trun)>1)=WAfconsumpmax('HFO','t1','sewa','uae')*oilprodgrowth(trun,'uae');
WAfconsumpmax('diesel',trun,'sewa','uae')$(ord(trun)>1)=WAfconsumpmax('diesel','t1','sewa','uae')*oilprodgrowth(trun,'uae');

ELfconsumpmax(ELf,trun,'fewa','uae')=fconsumpmax_save('EL',ELf,trun,'fewa','uae');
ELfconsumpmax('arablight',trun,'fewa','uae')$(ord(trun)>1)=ELfconsumpmax('arablight','t1','fewa','uae');
ELfconsumpmax('HFO',trun,'fewa','uae')$(ord(trun)>1)=ELfconsumpmax('HFO','t1','fewa','uae')*oilprodgrowth(trun,'uae');
ELfconsumpmax('diesel',trun,'fewa','uae')$(ord(trun)>1)=ELfconsumpmax('diesel','t1','fewa','uae')*oilprodgrowth(trun,'uae');
ELfconsumpmax('methane',trun,'fewa','uae')$(ord(trun)>1)=ELfconsumpmax('methane','t1','fewa','uae')*natgas_growth(trun,'uae');

WAfconsumpmax('methane',trun,'fewa','uae')$(ord(trun)>1)=WAfconsumpmax('methane','t1','fewa','uae')*natgas_growth(trun,'uae');
WAfconsumpmax('arablight',trun,'fewa','uae')$(ord(trun)>1)=WAfconsumpmax('arablight','t1','fewa','uae')*oilprodgrowth(trun,'uae');
WAfconsumpmax('HFO',trun,'fewa','uae')$(ord(trun)>1)=WAfconsumpmax('HFO','t1','fewa','uae')*oilprodgrowth(trun,'uae');
WAfconsumpmax('diesel',trun,'fewa','uae')$(ord(trun)>1)=WAfconsumpmax('diesel','t1','fewa','uae')*oilprodgrowth(trun,'uae');


display WAfconsumpmax;

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
WAfconsumpmax('HFO',trun,r,c)$((ord(trun)>1) and rc(r,c))=WAfconsumpmax('HFO','t1',r,c)$rc(r,c)*oilprodgrowth(trun,c);
WAfconsumpmax('diesel',trun,r,c)$((ord(trun)>1) and rc(r,c))=WAfconsumpmax('diesel','t1',r,c)$rc(r,c)*oilprodgrowth(trun,c);

WAfconsumpmax('methane',trun,'west','ksa')=fconsumpmax_save('WA','methane',trun,'west','ksa')+methane_add(trun)*0;
WAfconsumpmax('methane',trun,'cent','ksa')=fconsumpmax_save('WA','methane',trun,'cent','ksa')+methane_add(trun)*0;
WAfconsumpmax('methane',trun,'east','ksa')=fconsumpmax_save('WA','methane',trun,'east','ksa')+methane_add(trun)*0.27;
WAfconsumpmax('methane',trun,'sout','ksa')=fconsumpmax_save('WA','methane',trun,'sout','ksa')+methane_add(trun)*0;
$offtext
OTHERfconsump('methane',trun,r,c)$((ord(trun)>1) and rc(r,c))=OTHERfconsump('methane','t1',r,c)$rc(r,c)*natgas_growth(trun,c);
OTHERfconsump('arablight',trun,r,c)$((ord(trun)>1) and rc(r,c))=OTHERfconsump('arablight','t1',r,c)$rc(r,c)*oilprodgrowth(trun,c);

fimports.up(trun,'methane',r,c)=fimports.up('t1','methane',r,c)*natgas_growth(trun,c);

display fimports.up;

* Power additions

*2016
ELaddition('CC',vn,'t2','east','ksa')=3.927;
ELaddition('GT',vn,'t2','east','ksa')=0.224;
ELaddition('Steam',vn,'t2','west','ksa')=2.892;
ELaddition('GT',vn,'t2','west','ksa')=0.040;
ELaddition('Steam',vn,'t2','cent','ksa')=1.488;
ELaddition('GT',vn,'t2','sout','ksa')=0.093;

ELaddition('CC',vn,'t2','omnr','omn')=0.121;

ELaddition('CC',vn,'t2','dewa','uae')=0.34;

*2017:
*$ontext
ELaddition('Steam',vn,'t3','cent','ksa')=0.976;
ELaddition('wind',vn,'t3','cent','ksa')=0.003;
ELaddition('GT',vn,'t3','west','ksa')=0.141;
ELaddition('Steam',vn,'t3','sout','ksa')=2.664;

ELaddition('PV',vn,'t3','dewa','uae')=0.20;

*2018:
ELaddition('GT',vn,'t4','east','ksa')=0.436;
ELaddition('Steam',vn,'t4','cent','ksa')=0.392;
ELaddition('GT',vn,'t4','west','ksa')=0.318;
ELaddition('CC',vn,'t4','west','ksa')=2.06;

ELaddition('CC',vn,'t4','adwe','uae')=1.24;
ELaddition('PV',vn,'t4','fewa','uae')=0.20;

*2019:
ELaddition('CC',vn,'t5','east','ksa')=1.504;
ELaddition('PV',vn,'t5','cent','ksa')=0.010+0.300;

ELaddition('CC',vn,'t5','omnr','omn')=3.269;


*2020:
ELaddition('CC',vn,'t6','cent','ksa')=3.6;
ELaddition('CC',vn,'t6','west','ksa')=3.6-0.180;
ELaddition('CSP',vn,'t6','west','ksa')=0.180;

ELaddition('nuclear',vn,'t6','adwe','uae')=5.6;
ELaddition('PV',vn,'t6','adwe','uae')=1.177;
ELaddition('PV',vn,'t6','dewa','uae')=0.60;

*2021:
ELaddition('CC',vn,'t7','cent','ksa')=5.4;

ELaddition('CC',vn,'t7','omnr','omn')=0.500;

*ELaddition('CoalSteam',vn,'t7','fewa','uae')=1.8;

*$offtext

*2022:
ELaddition('CC',vn,'t8','omnr','omn')=0.700;
ELaddition('PV',vn,'t8','dewa','uae')=0.15;

* 2023
ELaddition('coalsteam',vn,'t9','dewa','uae')=2.4;


*$ontext
*Source: KFUPM Generation Report (2010)
ELretirement('GT',vo,'t2','west','ksa')=0.207;
ELretirement('GT',vo,'t3','west','ksa')=0.217;
ELretirement('GT',vo,'t4','west','ksa')=0.214;
ELretirement('GT',vo,'t6','west','ksa')=0.271;
ELretirement('GT',vo,'t5','west','ksa')=0.240;

ELretirement('GT',vo,'t1','sout','ksa')=0.015;
ELretirement('GT',vo,'t2','sout','ksa')=0.089;
ELretirement('GT',vo,'t2','sout','ksa')=0.085;
ELretirement('GT',vo,'t4','sout','ksa')=0.091;
ELretirement('GT',vo,'t5','sout','ksa')=0.089;

ELretirement('GT',vo,'t1','cent','ksa')=0.126;
ELretirement('GT',vo,'t2','cent','ksa')=0.210;
ELretirement('GT',vo,'t3','cent','ksa')=0.228;
ELretirement('GT',vo,'t4','cent','ksa')=0.240;
ELretirement('GT',vo,'t5','cent','ksa')=0.254;

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

* Water additions
* 2016
WAaddition('CCCoMSF','new','t2','east','ksa') = 2.120; {{ Ras Az Zawr cogen plant CC MSF }}
WAaddition('CCCoVMSF','new','t2','east','ksa') = 0.530;

WAaddition('SWRO','new','t2','omnr','omn')=0.006814;

* 2017
WAaddition('CCCoMED','new','t3','west','ksa') = 1.2; {{ Marafiq YANBU 3 new CCOO MED plant }}
WAaddition('CCCoVMED','new','t3','west','ksa') = 1.5;

WAaddition('SWRO','new','t3','omnr','omn')=0.166558;

WAaddition('CCCoMSF','new','t3','qatr','qat')=800;

* 2018
WAaddition('StCoV','new','t4','kuwr','kuw')=764;

WAaddition('SWRO','new','t4','omnr','omn')=0.450464;

WAaddition('CCCoMSF','new','t4','qatr','qat')=812;

WAaddition('SWRO','new','t4','adwe','uae')=0.12;

* 2019
*WAaddition('GTco','new','t5','kuwr','kuw')=300;

* 2020
WAaddition('CCcoMSF','new','t6','kuwr','kuw')=300;

WAaddition('SWRO','new','t6','omnr','omn')=0.094635;

* 2021
WAaddition('SWRO','new','t7','omnr','omn')=0.066623;

* 2022
WAaddition('CCcoMSF','new','t8','kuwr','kuw')=1800;
WAaddition('SWRO','new','t8','omnr','omn')=0.466363;

* 2023
*WAaddition('CCcoMSF','new','t9','kuwr','kuw')=900;

*WAretirement('StCoV','old','t9','kuwr','kuw') = 660;

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
