*$ontext
* projections
* ===========
* fuels
* announcement that natural gas production will double by 2025

parameter natgas_growth(time,c) growth of natural gas production relative to t01;
Parameter oilprodgrowth(time,c) growth in oil production;
Parameter oilpricegrowth(time) growth of Brent crude price in 2015 real USD;
Parameter coalpricegrowth(time) growth in coal price;
Parameter HFO_growth(time,c) growth in coal price;
Parameter diesel_growth(time,c) growth in coal price;

$ontext
table natgas_growth(time,c)
      bah    kuw   ksa   omn   qat   uae   
t01    1.0    1.0   1.0   1.0   1.0   1.0   
t02    1.01   1.1   1.05  1.0   1.1   1.1  
t03    1.01   1.2   1.10  1.0   1.2   1.2  
t04    1.02   1.2   1.15  1.0   1.3   1.3  
t05    1.03   1.3   1.20  1.0   1.4   1.4  
t06    1.04   1.3   1.25  1.0   1.5   1.5  
t07    1.04   1.4   1.30  1.0   1.6   1.6  
t08    1.05   1.4   1.35  1.0   1.7   1.7  
t09    1.06   1.5   1.40  1.0   1.8   1.8  
t10    1.06   1.6   1.45  1.0   1.9   1.9  
t11    1.07   1.6   1.1   1.0   2.0   2.0  
t12    1.08   1.7   1.1   1.0   2.1   2.1  
t13    1.09   1.7   1.1   1.0   2.2   2.2  
t14    1.09   1.8   1.1   1.0   2.3   2.3  
t15    1.10   1.8   1.1   1.0   2.4   2.4  
t16    1.11   1.9   1.1   1.0   2.6   2.6  
;
$offtext

table natgas_growth(time,c)
      bah    kuw   ksa   omn   qat   uae   
t01    1.0    1.0   1.0   1.0   1.0   1.0   
t02    1.01   1.1   1.1   1.0   1.1   1.1  
t03    1.01   1.2   1.2   1.0   1.2   1.2  
t04    1.02   1.2   1.3   1.0   1.3   1.3  
t05    1.03   1.3   1.4   1.0   1.4   1.4  
t06    1.04   1.3   1.5   1.0   1.5   1.5  
t07    1.04   1.4   1.6   1.0   1.6   1.6  
t08    1.05   1.4   1.7   1.0   1.7   1.7  
t09    1.06   1.5   1.8   1.0   1.8   1.8  
t10    1.06   1.6   1.9   1.0   1.9   1.9  
t11    1.07   1.6   2.0   1.0   2.0   2.0  
t12    1.08   1.7   2.1   1.0   2.1   2.1  
t13    1.09   1.7   2.2   1.0   2.2   2.2  
t14    1.09   1.8   2.3   1.0   2.3   2.3  
t15    1.10   1.8   2.4   1.0   2.4   2.4  
t16    1.11   1.9   2.6   1.0   2.6   2.6  
;

fuelsupmax(natgas,time,r,c,'ss1')=fuelsupmax(natgas,'t01',r,c,'ss1')*natgas_growth(time,c);

table HFO_growth(time,c)
       ksa 
t01    1.0
t02    1.6  
t03    2.3   
t04    2.6   
t05    3.0   
t06    3.1   
t07    3.2   
t08    3.3   
t09    3.3   
t10    3.3   
t11    3.3   
t12    3.3   
t13    3.4   
t14    3.5   
t15    3.6   
t16    3.7   
;

table diesel_growth(time,c)
       kuw 
t01    1.0
t02    1.6  
t03    2.3   
t04    2.6   
t05    3.0   
t06    3.1   
t07    3.2   
t08    3.3   
t09    3.3   
t10    3.3   
t11    3.3   
t12    3.3   
t13    3.3   
t14    3.3   
t15    3.3   
t16    3.3   
;

table oilprodgrowth(time,c)
      bah   kuw    ksa    omn   qat   uae  
t01    1.0   1.00   1.00   1.0   1.0   1.00
t02    1.0   1.04   1.04   1.0   1.0   1.04
t03    1.0   1.00   1.00   1.0   1.0   1.00
t04    1.0   1.02   1.02   1.0   1.0   1.02
t05    1.0   1.03   1.03   1.0   1.0   1.03
t06    1.0   1.05   1.05   1.0   1.0   1.05
t07    1.0   1.06   1.06   1.0   1.0   1.06
t08    1.0   1.08   1.08   1.0   1.0   1.08
t09    1.0   1.11   1.11   1.0   1.0   1.11
t10    1.0   1.15   1.15   1.0   1.0   1.15
t11    1.0   1.19   1.19   1.0   1.0   1.19
t12    1.0   1.22   1.22   1.0   1.0   1.22
t13    1.0   1.26   1.26   1.0   1.0   1.26
t14    1.0   1.29   1.29   1.0   1.0   1.29
t15    1.0   1.32   1.32   1.0   1.0   1.32
t16    1.0   1.35   1.35   1.0   1.0   1.35
;

fuelsupmax(crude,time,r,c,ss)$rc(r,c)=fuelsupmax(crude,'t01',r,c,ss)*oilprodgrowth(time,c);
* increase fuel supply with growth in production
Fueluse.up(fup,ss,trun,r,c)=fuelsupmax(fup,trun,r,c,ss);

Parameter oilpricegrowth(time) growth of Brent crude price in 2015 real USD
/
t01       1.00
t02       0.85
t03       1.04
t04       1.50
t05       1.63
t06       1.63
t07       1.63
t08       1.63
t09       1.63
t10       1.63
t11       1.63
t12       1.63
t13       1.63
t14       1.63
t15       1.63
t16       1.63
/
;
fintlprice(crude,time)=fintlprice(crude,'t01')*oilpricegrowth(time);

Parameter coalpricegrowth(time) growth in coal price
/
t01        1
t02        0.9585
t03        1.0194
t04        1.0803
t05        1.1412
t06        1.2021
t07        1.263
t08        1.3239
t09        1.3848
t10        1.4457
t11        1.5066
t12        1.5675
t13        1.6284
t14        1.6893
t15        1.7502
t16        1.8111
t17        1.872
t18        1.9329
t19        1.9938
t20        2.0547
/
;
fintlprice('coal',time)=fintlprice('coal',time)*coalpricegrowth(time);

fuelsupmax(natgas,time,r,c,'ss1')=fuelsupmax(natgas,'t01',r,c,'ss1')*natgas_growth(time,c);
fuelsupmax(crude,time,r,c,ss)$rc(r,c)=fuelsupmax(crude,'t01',r,c,ss)*oilprodgrowth(time,c);

* assume natural gas price increases with oil price
fintlprice(natgas,time)=fintlprice(natgas,'t01')*oilpricegrowth(time);
RFintlprice('diesel',time)=RFintlprice('diesel','t01')*oilpricegrowth(time);
RFintlprice('HFO',time)=RFintlprice('HFO','t01')*oilpricegrowth(time);

fintlprice('coal',time)=fintlprice('coal',time)*coalpricegrowth(time);

display fuelcst,fuelsupmax;

** new cost declines
*
Elcapital('PV','t02',r,c)=1777;
Elcapital('PV','t03',r,c)=1211;
Elcapital('PV','t04',r,c)=1064;
Elcapital('PV','t05',r,c)=1024;
Elcapital('PV','t06',r,c)=964;
Elcapital('PV','t07',r,c)=913;
Elcapital('PV','t08',r,c)=903;
Elcapital('PV','t09',r,c)=893;
Elcapital('PV','t10',r,c)=883;
Elcapital('PV','t11',r,c)=872;
Elcapital('PV','t12',r,c)=862;
Elcapital('PV','t13',r,c)=852;
Elcapital('PV','t14',r,c)=841;
Elcapital('PV','t15',r,c)=831;
Elcapital('PV','t16',r,c)=821;

Elcapital('CSP','t02',r,c)=7872;
Elcapital('CSP','t03',r,c)=7564;
Elcapital('CSP','t04',r,c)=7257;
Elcapital('CSP','t05',r,c)=6950;
Elcapital('CSP','t06',r,c)=6642;
Elcapital('CSP','t07',r,c)=6559;
Elcapital('CSP','t08',r,c)=6475;
Elcapital('CSP','t09',r,c)=6391;
Elcapital('CSP','t10',r,c)=6308;
Elcapital('CSP','t11',r,c)=6224;
Elcapital('CSP','t12',r,c)=6140;
Elcapital('CSP','t13',r,c)=6057;
Elcapital('CSP','t14',r,c)=5973;
Elcapital('CSP','t15',r,c)=5889;
Elcapital('CSP','t16',r,c)=5806;

Elcapital('Wind','t02',r,c)=1528;
Elcapital('Wind','t03',r,c)=1508;
Elcapital('Wind','t04',r,c)=1488;
Elcapital('Wind','t05',r,c)=1469;
Elcapital('Wind','t06',r,c)=1450;
Elcapital('Wind','t07',r,c)=1432;
Elcapital('Wind','t08',r,c)=1415;
Elcapital('Wind','t09',r,c)=1399;
Elcapital('Wind','t10',r,c)=1383;
Elcapital('Wind','t11',r,c)=1368;
Elcapital('Wind','t12',r,c)=1353;
Elcapital('Wind','t13',r,c)=1340;
Elcapital('Wind','t14',r,c)=1327;
Elcapital('Wind','t15',r,c)=1315;
Elcapital('Wind','t16',r,c)=1303;

Elcapital('Nuclear','t02',r,c)=6157;
Elcapital('Nuclear','t03',r,c)=6154;
Elcapital('Nuclear','t04',r,c)=6150;
Elcapital('Nuclear','t05',r,c)=6147;
Elcapital('Nuclear','t06',r,c)=6143;
Elcapital('Nuclear','t07',r,c)=6139;
Elcapital('Nuclear','t08',r,c)=6136;
Elcapital('Nuclear','t09',r,c)=6110;
Elcapital('Nuclear','t10',r,c)=6075;
Elcapital('Nuclear','t11',r,c)=6043;
Elcapital('Nuclear','t12',r,c)=6003;
Elcapital('Nuclear','t13',r,c)=5976;
Elcapital('Nuclear','t14',r,c)=5951;
Elcapital('Nuclear','t15',r,c)=5919;
Elcapital('Nuclear','t16',r,c)=5886;

ELfixedOMcst('PV','t02')=14.0;
ELfixedOMcst('PV','t03')=9.6;
ELfixedOMcst('PV','t04')=9.2;
ELfixedOMcst('PV','t05')=8.8;
ELfixedOMcst('PV','t06')=8.1;
ELfixedOMcst('PV','t07')=7.5;
ELfixedOMcst('PV','t08')=7.5;
ELfixedOMcst('PV','t09')=7.4;
ELfixedOMcst('PV','t10')=7.3;
ELfixedOMcst('PV','t11')=7.2;
ELfixedOMcst('PV','t12')=7.1;
ELfixedOMcst('PV','t13')=7.0;
ELfixedOMcst('PV','t14')=6.9;
ELfixedOMcst('PV','t15')=6.9;
ELfixedOMcst('PV','t16')=6.8;

ELfixedOMcst('Wind','t02')=51.3;
ELfixedOMcst('Wind','t03')=50.9;
ELfixedOMcst('Wind','t04')=50.6;
ELfixedOMcst('Wind','t05')=50.2;
ELfixedOMcst('Wind','t06')=49.9;
ELfixedOMcst('Wind','t07')=49.5;
ELfixedOMcst('Wind','t08')=49.2;
ELfixedOMcst('Wind','t09')=48.8;
ELfixedOMcst('Wind','t10')=48.4;
ELfixedOMcst('Wind','t11')=48.0;
ELfixedOMcst('Wind','t12')=47.6;
ELfixedOMcst('Wind','t13')=47.3;
ELfixedOMcst('Wind','t14')=46.9;
ELfixedOMcst('Wind','t15')=46.5;
ELfixedOMcst('Wind','t16')=46.2;

ELfixedOMcst('Nuclear','t02')=99.2;
ELfixedOMcst('Nuclear','t03')=99.2;
ELfixedOMcst('Nuclear','t04')=99.2;
ELfixedOMcst('Nuclear','t05')=99.2;
ELfixedOMcst('Nuclear','t06')=99.2;
ELfixedOMcst('Nuclear','t07')=99.2;
ELfixedOMcst('Nuclear','t08')=99.2;
ELfixedOMcst('Nuclear','t09')=99.2;
ELfixedOMcst('Nuclear','t10')=99.2;
ELfixedOMcst('Nuclear','t11')=99.2;
ELfixedOMcst('Nuclear','t12')=99.2;
ELfixedOMcst('Nuclear','t13')=99.2;
ELfixedOMcst('Nuclear','t14')=99.2;
ELfixedOMcst('Nuclear','t15')=99.2;
ELfixedOMcst('Nuclear','t16')=99.2;

parameter popgrowthrate(time,r,c);
*Annual population growth between 2015 and 2025 (Source:CDSI):
*popgrowthrate('t01','west','ksa')=0.0216;
*popgrowthrate('t01','sout','ksa')=0.0205;
*popgrowthrate('t01','cent','ksa')=0.0215;
*popgrowthrate('t01','east','ksa')=0.0211;
popgrowthrate('t01',r,c)=0.015;

parameter popgrowth(time,r,c);
popgrowth(time,r,c)$rc(r,c)=(1+popgrowthrate('t01',r,c))**(ord(time)-1);

* other
Parameter realGDPgrowth(time) GDP growth relative to t01 2015;
realGDPgrowth(time)=1;
*realGDPgrowth('t02')=1.34;

WAdemval(time,r,c)$rc(r,c) = WAdemval('t01',r,c);
*WAdemval(time,r,c)$rc(r,c) = WAdemval('t01',r,c);

WAgrdem(time,rr,cc)$rc(rr,cc)= WAgrdem('t01',rr,cc);

*Fuelcst(fup,ss,c)=Fuelcst(fup,ss,c);
*Fuelcst('coal',ss,c)= Fuelcst('coal',ss,c)*coalpricegrowth(time);

* fuel quotas

* bah
*ELfconsumpmax(ELf,trun,'bahr','bah')=fconsumpmax_save('EL',ELf,trun,'bahr','bah');
ELfconsumpmax('arablight',trun,'bahr','bah')$(ord(trun)>1)=ELfconsumpmax('arablight','t01','bahr','bah')*oilprodgrowth(trun,'bah');
ELfconsumpmax('HFO',trun,'bahr','bah')$(ord(trun)>1)=ELfconsumpmax('HFO','t01','bahr','bah')*oilprodgrowth(trun,'bah');
ELfconsumpmax('diesel',trun,'bahr','bah')$(ord(trun)>1)=ELfconsumpmax('diesel','t01','bahr','bah')*oilprodgrowth(trun,'bah');
ELfconsumpmax('methane',trun,'bahr','bah')$(ord(trun)>1)=ELfconsumpmax('methane','t01','bahr','bah')*natgas_growth(trun,'bah');

WAfconsumpmax('methane',trun,'bahr','bah')$(ord(trun)>1)=WAfconsumpmax('methane','t01','bahr','bah')*natgas_growth(trun,'bah');
WAfconsumpmax('arablight',trun,'bahr','bah')$(ord(trun)>1)=WAfconsumpmax('arablight','t01','bahr','bah')*oilprodgrowth(trun,'bah');
WAfconsumpmax('HFO',trun,'bahr','bah')$(ord(trun)>1)=WAfconsumpmax('HFO','t01','bahr','bah')*oilprodgrowth(trun,'bah');
WAfconsumpmax('diesel',trun,'bahr','bah')$(ord(trun)>1)=WAfconsumpmax('diesel','t01','bahr','bah')*oilprodgrowth(trun,'bah');

* kuw
*ELfconsumpmax(ELf,trun,'kuwr','kuw')=fconsumpmax_save('EL',ELf,trun,'kuwr','kuw');
ELfconsumpmax('arablight',trun,'kuwr','kuw')$(ord(trun)>1)=ELfconsumpmax('arablight','t01','kuwr','kuw');
ELfconsumpmax('HFO',trun,'kuwr','kuw')$(ord(trun)>1)=ELfconsumpmax('HFO','t01','kuwr','kuw')*oilprodgrowth(trun,'kuw');
ELfconsumpmax('diesel',trun,'kuwr','kuw')$(ord(trun)>1)=ELfconsumpmax('diesel','t01','kuwr','kuw')*diesel_growth(trun,'kuw');
ELfconsumpmax('methane',trun,'kuwr','kuw')$(ord(trun)>1)=ELfconsumpmax('methane','t01','kuwr','kuw')*natgas_growth(trun,'kuw');

WAfconsumpmax('methane',trun,'kuwr','kuw')$(ord(trun)>1)=WAfconsumpmax('methane','t01','kuwr','kuw')*natgas_growth(trun,'kuw');
WAfconsumpmax('arablight',trun,'kuwr','kuw')$(ord(trun)>1)=WAfconsumpmax('arablight','t01','kuwr','kuw')*oilprodgrowth(trun,'kuw');
WAfconsumpmax('HFO',trun,'kuwr','kuw')$(ord(trun)>1)=WAfconsumpmax('HFO','t01','kuwr','kuw')*oilprodgrowth(trun,'kuw');
WAfconsumpmax('diesel',trun,'kuwr','kuw')$(ord(trun)>1)=WAfconsumpmax('diesel','t01','kuwr','kuw')*diesel_growth(trun,'kuw');

* omn
*ELfconsumpmax(ELf,trun,'omnr','omn')=fconsumpmax_save('EL',ELf,trun,'omnr','omn');
ELfconsumpmax('arablight',trun,'omnr','omn')$(ord(trun)>1)=ELfconsumpmax('arablight','t01','omnr','omn');
ELfconsumpmax('HFO',trun,'omnr','omn')$(ord(trun)>1)=ELfconsumpmax('HFO','t01','omnr','omn')*oilprodgrowth(trun,'omn');
ELfconsumpmax('diesel',trun,'omnr','omn')$(ord(trun)>1)=ELfconsumpmax('diesel','t01','omnr','omn')*oilprodgrowth(trun,'omn');
ELfconsumpmax('methane',trun,'omnr','omn')$(ord(trun)>1)=ELfconsumpmax('methane','t01','omnr','omn')*natgas_growth(trun,'omn');

WAfconsumpmax('methane',trun,'omnr','omn')$(ord(trun)>1)=WAfconsumpmax('methane','t01','omnr','omn')*natgas_growth(trun,'omn');
WAfconsumpmax('arablight',trun,'omnr','omn')$(ord(trun)>1)=WAfconsumpmax('arablight','t01','omnr','omn')*oilprodgrowth(trun,'omn');
WAfconsumpmax('HFO',trun,'omnr','omn')$(ord(trun)>1)=WAfconsumpmax('HFO','t01','omnr','omn')*oilprodgrowth(trun,'omn');
WAfconsumpmax('diesel',trun,'omnr','omn')$(ord(trun)>1)=WAfconsumpmax('diesel','t01','omnr','omn')*oilprodgrowth(trun,'omn');

* qat
*ELfconsumpmax(ELf,trun,'qatr','qat')=fconsumpmax_save('EL',ELf,trun,'qatr','qat');
ELfconsumpmax('arablight',trun,'qatr','qat')$(ord(trun)>1)=ELfconsumpmax('arablight','t01','qatr','qat');
ELfconsumpmax('HFO',trun,'qatr','qat')$(ord(trun)>1)=ELfconsumpmax('HFO','t01','qatr','qat')*oilprodgrowth(trun,'qat');
ELfconsumpmax('diesel',trun,'qatr','qat')$(ord(trun)>1)=ELfconsumpmax('diesel','t01','qatr','qat')*oilprodgrowth(trun,'qat');
ELfconsumpmax('methane',trun,'qatr','qat')$(ord(trun)>1)=ELfconsumpmax('methane','t01','qatr','qat')*natgas_growth(trun,'qat');

WAfconsumpmax('methane',trun,'qatr','qat')$(ord(trun)>1)=WAfconsumpmax('methane','t01','qatr','qat')*natgas_growth(trun,'qat');
WAfconsumpmax('arablight',trun,'qatr','qat')$(ord(trun)>1)=WAfconsumpmax('arablight','t01','qatr','qat')*oilprodgrowth(trun,'qat');
WAfconsumpmax('HFO',trun,'qatr','qat')$(ord(trun)>1)=WAfconsumpmax('HFO','t01','qatr','qat')*oilprodgrowth(trun,'qat');
WAfconsumpmax('diesel',trun,'qatr','qat')$(ord(trun)>1)=WAfconsumpmax('diesel','t01','qatr','qat')*oilprodgrowth(trun,'qat');

* ksa
$ontext

fconsumpmax_save(ksec,natgas,trun,r,c)=fconsumpmax_save(ksec,natgas,'t01',r,c)*natgas_growth(trun,c);
*fconsumpmax_save(ksec,'arablight','t02',r,c)=fconsumpmax_save(ksec,'arablight','t01',r,c)*oilprodgrowth('t02');
fconsumpmax_save(ksec,'arablight',trun,r,c)$(ord(trun)>2)=9e9;

ELfconsumpmax(ELf,trun,r,c)$rc(r,c)=fconsumpmax_save('EL',ELf,trun,r,c);
ELfconsumpmax('arablight',trun,r,c)$((ord(trun)>1) and rc(r,c))=ELfconsumpmax('arablight','t01',r,c)*1.03;
ELfconsumpmax('HFO',trun,r,c)$((ord(trun)>1) and rc(r,c))=ELfconsumpmax('HFO','t01',r,c)$rc(r,c)*oilprodgrowth(trun,c);

WAfconsumpmax('methane',trun,'west','ksa')$(ord(trun)>1)=fconsumpmax_save('WA','methane','t01','west','ksa')*natgas_growth(trun,'ksa');
*WAfconsumpmax('methane',trun,'cent','ksa')$((ord(trun)>1) and rc(r,c))=fconsumpmax_save('WA','methane',trun,'cent','ksa')*natgas_growth(trun,c);
WAfconsumpmax('methane',trun,'east','ksa')$(ord(trun)>1)=fconsumpmax_save('WA','methane','t01','east','ksa')*natgas_growth(trun,'ksa');
WAfconsumpmax('methane',trun,'sout','ksa')$(ord(trun)>1)=fconsumpmax_save('WA','methane','t01','sout','ksa')*natgas_growth(trun,'ksa');
$offtext

ELfconsumpmax('arablight',trun,'east','ksa')$(ord(trun)>1)=ELfconsumpmax('arablight','t01','east','ksa')*(1-0.05*ord(trun));
ELfconsumpmax('HFO',trun,'east','ksa')$(ord(trun)>1)=ELfconsumpmax('HFO','t01','east','ksa')*HFO_growth(trun,'ksa');
ELfconsumpmax('diesel',trun,'east','ksa')$(ord(trun)>1)=ELfconsumpmax('diesel','t01','east','ksa')*(1-0.06*ord(trun));
ELfconsumpmax('methane',trun,'east','ksa')$(ord(trun)>1)=ELfconsumpmax('methane','t01','east','ksa')*natgas_growth(trun,'ksa');

WAfconsumpmax('methane',trun,'east','ksa')$(ord(trun)>1)=WAfconsumpmax('methane','t01','east','ksa')*natgas_growth(trun,'ksa');
WAfconsumpmax('arablight',trun,'east','ksa')$(ord(trun)>1)=WAfconsumpmax('arablight','t01','east','ksa')*(1-0.05*ord(trun));
WAfconsumpmax('HFO',trun,'east','ksa')$(ord(trun)>1)=WAfconsumpmax('HFO','t01','east','ksa')*HFO_growth(trun,'ksa');
WAfconsumpmax('diesel',trun,'east','ksa')$(ord(trun)>1)=WAfconsumpmax('diesel','t01','east','ksa')*(1-0.06*ord(trun));

ELfconsumpmax('arablight',trun,'cent','ksa')$(ord(trun)>1)=ELfconsumpmax('arablight','t01','cent','ksa')*(1-0.05*ord(trun));
ELfconsumpmax('HFO',trun,'cent','ksa')$(ord(trun)>1)=ELfconsumpmax('HFO','t01','cent','ksa')*HFO_growth(trun,'ksa');
ELfconsumpmax('diesel',trun,'cent','ksa')$(ord(trun)>1)=ELfconsumpmax('diesel','t01','cent','ksa')*(1-0.06*ord(trun));
ELfconsumpmax('methane',trun,'cent','ksa')$(ord(trun)>1)=ELfconsumpmax('methane','t01','cent','ksa')*natgas_growth(trun,'ksa');

WAfconsumpmax('methane',trun,'cent','ksa')$(ord(trun)>1)=WAfconsumpmax('methane','t01','cent','ksa')*natgas_growth(trun,'ksa');
WAfconsumpmax('arablight',trun,'cent','ksa')$(ord(trun)>1)=WAfconsumpmax('arablight','t01','cent','ksa')*(1-0.05*ord(trun));
WAfconsumpmax('HFO',trun,'cent','ksa')$(ord(trun)>1)=WAfconsumpmax('HFO','t01','cent','ksa')*HFO_growth(trun,'ksa');
WAfconsumpmax('diesel',trun,'cent','ksa')$(ord(trun)>1)=WAfconsumpmax('diesel','t01','cent','ksa')*(1-0.06*ord(trun));

ELfconsumpmax('arablight',trun,'west','ksa')$(ord(trun)>1)=ELfconsumpmax('arablight','t01','west','ksa')*(1-0.05*ord(trun));
ELfconsumpmax('HFO',trun,'west','ksa')$(ord(trun)>1)=ELfconsumpmax('HFO','t01','west','ksa')*HFO_growth(trun,'ksa');
ELfconsumpmax('diesel',trun,'west','ksa')$(ord(trun)>1)=ELfconsumpmax('diesel','t01','west','ksa')*(1-0.06*ord(trun));
ELfconsumpmax('methane',trun,'west','ksa')$(ord(trun)>1)=ELfconsumpmax('methane','t01','west','ksa')*natgas_growth(trun,'ksa');

WAfconsumpmax('methane',trun,'west','ksa')$(ord(trun)>1)=WAfconsumpmax('methane','t01','west','ksa')*natgas_growth(trun,'ksa');
WAfconsumpmax('arablight',trun,'west','ksa')$(ord(trun)>1)=WAfconsumpmax('arablight','t01','west','ksa')*(1-0.05*ord(trun));
WAfconsumpmax('HFO',trun,'west','ksa')$(ord(trun)>1)=WAfconsumpmax('HFO','t01','west','ksa')*HFO_growth(trun,'ksa');
WAfconsumpmax('diesel',trun,'west','ksa')$(ord(trun)>1)=WAfconsumpmax('diesel','t01','west','ksa')*(1-0.06*ord(trun));

ELfconsumpmax('arablight',trun,'sout','ksa')$(ord(trun)>1)=ELfconsumpmax('arablight','t01','sout','ksa')*(1-0.05*ord(trun));
ELfconsumpmax('HFO',trun,'sout','ksa')$(ord(trun)>1)=ELfconsumpmax('HFO','t01','sout','ksa')*HFO_growth(trun,'ksa');
ELfconsumpmax('diesel',trun,'sout','ksa')$(ord(trun)>1)=ELfconsumpmax('diesel','t01','sout','ksa')*(1-0.06*ord(trun));
ELfconsumpmax('methane',trun,'sout','ksa')$(ord(trun)>1)=ELfconsumpmax('methane','t01','sout','ksa')*natgas_growth(trun,'ksa');

WAfconsumpmax('methane',trun,'sout','ksa')$(ord(trun)>1)=WAfconsumpmax('methane','t01','sout','ksa')*natgas_growth(trun,'ksa');
WAfconsumpmax('arablight',trun,'sout','ksa')$(ord(trun)>1)=WAfconsumpmax('arablight','t01','sout','ksa')*(1-0.05*ord(trun));
WAfconsumpmax('HFO',trun,'sout','ksa')$(ord(trun)>1)=WAfconsumpmax('HFO','t01','sout','ksa')*HFO_growth(trun,'ksa');
WAfconsumpmax('diesel',trun,'sout','ksa')$(ord(trun)>1)=WAfconsumpmax('diesel','t01','sout','ksa')*(1-0.06*ord(trun));


* uae

ELfconsumpmax('arablight',trun,'adwe','uae')$(ord(trun)>1)=ELfconsumpmax('arablight','t01','adwe','uae');
ELfconsumpmax('HFO',trun,'adwe','uae')$(ord(trun)>1)=ELfconsumpmax('HFO','t01','adwe','uae');
ELfconsumpmax('diesel',trun,'adwe','uae')$(ord(trun)>1)=ELfconsumpmax('diesel','t01','adwe','uae');
ELfconsumpmax('methane',trun,'adwe','uae')$(ord(trun)>1)=ELfconsumpmax('methane','t01','adwe','uae');

WAfconsumpmax('methane',trun,'adwe','uae')$(ord(trun)>1)=WAfconsumpmax('methane','t01','adwe','uae');
WAfconsumpmax('arablight',trun,'adwe','uae')$(ord(trun)>1)=WAfconsumpmax('arablight','t01','adwe','uae');
WAfconsumpmax('HFO',trun,'adwe','uae')$(ord(trun)>1)=WAfconsumpmax('HFO','t01','adwe','uae');
WAfconsumpmax('diesel',trun,'adwe','uae')$(ord(trun)>1)=WAfconsumpmax('diesel','t01','adwe','uae');


ELfconsumpmax('arablight',trun,'dewa','uae')$(ord(trun)>1)=ELfconsumpmax('arablight','t01','dewa','uae');
ELfconsumpmax('HFO',trun,'dewa','uae')$(ord(trun)>1)=ELfconsumpmax('HFO','t01','dewa','uae');
ELfconsumpmax('diesel',trun,'dewa','uae')$(ord(trun)>1)=ELfconsumpmax('diesel','t01','dewa','uae');
ELfconsumpmax('methane',trun,'dewa','uae')$(ord(trun)>1)=ELfconsumpmax('methane','t01','dewa','uae');

WAfconsumpmax('methane',trun,'dewa','uae')$(ord(trun)>1)=WAfconsumpmax('methane','t01','dewa','uae');
WAfconsumpmax('arablight',trun,'dewa','uae')$(ord(trun)>1)=WAfconsumpmax('arablight','t01','dewa','uae');
WAfconsumpmax('HFO',trun,'dewa','uae')$(ord(trun)>1)=WAfconsumpmax('HFO','t01','dewa','uae');
WAfconsumpmax('diesel',trun,'dewa','uae')$(ord(trun)>1)=WAfconsumpmax('diesel','t01','dewa','uae');


ELfconsumpmax('arablight',trun,'sewa','uae')$(ord(trun)>1)=ELfconsumpmax('arablight','t01','sewa','uae');
ELfconsumpmax('HFO',trun,'sewa','uae')$(ord(trun)>1)=ELfconsumpmax('HFO','t01','sewa','uae');
ELfconsumpmax('diesel',trun,'sewa','uae')$(ord(trun)>1)=ELfconsumpmax('diesel','t01','sewa','uae');
ELfconsumpmax('methane',trun,'sewa','uae')$(ord(trun)>1)=ELfconsumpmax('methane','t01','sewa','uae');

WAfconsumpmax('methane',trun,'sewa','uae')$(ord(trun)>1)=WAfconsumpmax('methane','t01','sewa','uae');
WAfconsumpmax('arablight',trun,'sewa','uae')$(ord(trun)>1)=WAfconsumpmax('arablight','t01','sewa','uae');
WAfconsumpmax('HFO',trun,'sewa','uae')$(ord(trun)>1)=WAfconsumpmax('HFO','t01','sewa','uae');
WAfconsumpmax('diesel',trun,'sewa','uae')$(ord(trun)>1)=WAfconsumpmax('diesel','t01','sewa','uae');


ELfconsumpmax('arablight',trun,'fewa','uae')$(ord(trun)>1)=ELfconsumpmax('arablight','t01','fewa','uae');
ELfconsumpmax('HFO',trun,'fewa','uae')$(ord(trun)>1)=ELfconsumpmax('HFO','t01','fewa','uae');
ELfconsumpmax('diesel',trun,'fewa','uae')$(ord(trun)>1)=ELfconsumpmax('diesel','t01','fewa','uae');
ELfconsumpmax('methane',trun,'fewa','uae')$(ord(trun)>1)=ELfconsumpmax('methane','t01','fewa','uae');

WAfconsumpmax('methane',trun,'fewa','uae')$(ord(trun)>1)=WAfconsumpmax('methane','t01','fewa','uae');
WAfconsumpmax('arablight',trun,'fewa','uae')$(ord(trun)>1)=WAfconsumpmax('arablight','t01','fewa','uae');
WAfconsumpmax('HFO',trun,'fewa','uae')$(ord(trun)>1)=WAfconsumpmax('HFO','t01','fewa','uae');
WAfconsumpmax('diesel',trun,'fewa','uae')$(ord(trun)>1)=WAfconsumpmax('diesel','t01','fewa','uae');

ELfconsumpmax('coal',trun,'fewa','uae')$(ord(trun)>6)=9e9;
ELfconsumpmax('coal',trun,'dewa','uae')$(ord(trun)>7)=9e9;

fimports.up(trun,'methane','dewa','uae')$(ord(trun)>3)=1e3;

display ELfconsumpmax, WAfconsumpmax;

$ontext
methane_add('t01')=   103.939;
methane_add('t02')=   109.248;
methane_add('t03')=   155.841;
methane_add('t04')=   152.821;
methane_add('t05')=  184.583;
methane_add('t06')=  222.710;
methane_add('t07')=  275.360;
methane_add('t08')=  327.287;
methane_add('t09')=  379.552 +103.254 ;
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
WAfconsumpmax('HFO',trun,r,c)$((ord(trun)>1) and rc(r,c))=WAfconsumpmax('HFO','t01',r,c)$rc(r,c)*oilprodgrowth(trun,c);
WAfconsumpmax('diesel',trun,r,c)$((ord(trun)>1) and rc(r,c))=WAfconsumpmax('diesel','t01',r,c)$rc(r,c)*oilprodgrowth(trun,c);

WAfconsumpmax('methane',trun,'west','ksa')=fconsumpmax_save('WA','methane',trun,'west','ksa')+methane_add(trun)*0;
WAfconsumpmax('methane',trun,'cent','ksa')=fconsumpmax_save('WA','methane',trun,'cent','ksa')+methane_add(trun)*0;
WAfconsumpmax('methane',trun,'east','ksa')=fconsumpmax_save('WA','methane',trun,'east','ksa')+methane_add(trun)*0.27;
WAfconsumpmax('methane',trun,'sout','ksa')=fconsumpmax_save('WA','methane',trun,'sout','ksa')+methane_add(trun)*0;
$offtext
OTHERfconsump('methane',trun,r,c)$((ord(trun)>1) and rc(r,c))=OTHERfconsump('methane','t01',r,c)$rc(r,c);
OTHERfconsump('arablight',trun,r,c)$((ord(trun)>1) and rc(r,c))=OTHERfconsump('arablight','t01',r,c)$rc(r,c);

*fimports.up(trun,'methane',r,c)=fimports.up('t01','methane',r,c)*natgas_growth(trun,c);
*fimports.up(trun,'methane',r,c)=fimports.up('t01','methane',r,c);

display fimports.up;

* Power additions

*2016
ELaddition('CC',vn,'t02','east','ksa')=3.927;
ELaddition('GT',vn,'t02','east','ksa')=0.224;
ELaddition('Steam',vn,'t02','west','ksa')=2.892;
ELaddition('GT',vn,'t02','west','ksa')=0.040;
ELaddition('Steam',vn,'t02','cent','ksa')=1.488;
ELaddition('GT',vn,'t02','sout','ksa')=0.093;

ELaddition('CC',vn,'t02','omnr','omn')=0.121;

ELaddition('CC',vn,'t02','dewa','uae')=0.34;

*2017:
*$ontext
ELaddition('Steam',vn,'t03','cent','ksa')=0.976;
ELaddition('wind',vn,'t03','cent','ksa')=0.003;
ELaddition('GT',vn,'t03','west','ksa')=0.141;
ELaddition('Steam',vn,'t03','sout','ksa')=2.664;

ELaddition('PV',vn,'t03','dewa','uae')=0.20;

*2018:
ELaddition('GT',vn,'t04','east','ksa')=0.436;
ELaddition('Steam',vn,'t04','cent','ksa')=0.392;
ELaddition('GT',vn,'t04','west','ksa')=0.318;
ELaddition('CC',vn,'t04','west','ksa')=2.06;

ELaddition('CC',vn,'t04','adwe','uae')=1.24;
ELaddition('PV',vn,'t04','fewa','uae')=0.20;

*2019:
ELaddition('CC',vn,'t05','east','ksa')=1.504;
ELaddition('PV',vn,'t05','cent','ksa')=0.010+0.300;

ELaddition('CC',vn,'t05','omnr','omn')=3.269;


*2020:
ELaddition('CC',vn,'t06','cent','ksa')=3.6;
ELaddition('CC',vn,'t06','west','ksa')=3.6-0.180;
ELaddition('CSP',vn,'t06','west','ksa')=0.180;

ELaddition('Nuclear',vn,'t06','adwe','uae')=5.6;
ELaddition('PV',vn,'t06','adwe','uae')=1.177;
ELaddition('PV',vn,'t06','dewa','uae')=0.60;

*2021:
ELaddition('CC',vn,'t07','cent','ksa')=5.4;

ELaddition('CC',vn,'t07','omnr','omn')=0.500;

ELaddition('CoalSteam',vn,'t07','fewa','uae')=1.8;

*$offtext

*2022:
ELaddition('CC',vn,'t08','omnr','omn')=0.700;
ELaddition('PV',vn,'t08','dewa','uae')=0.15;

* 2023
ELaddition('CoalSteam',vn,'t09','dewa','uae')=2.4;


*$ontext
*Source: KFUPM Generation Report (2010)
ELretirement('GT',vo,'t02','west','ksa')=0.207;
ELretirement('GT',vo,'t03','west','ksa')=0.217;
ELretirement('GT',vo,'t04','west','ksa')=0.214;
ELretirement('GT',vo,'t06','west','ksa')=0.271;
ELretirement('GT',vo,'t05','west','ksa')=0.240;

ELretirement('GT',vo,'t01','sout','ksa')=0.015;
ELretirement('GT',vo,'t02','sout','ksa')=0.089;
ELretirement('GT',vo,'t02','sout','ksa')=0.085;
ELretirement('GT',vo,'t04','sout','ksa')=0.091;
ELretirement('GT',vo,'t05','sout','ksa')=0.089;

ELretirement('GT',vo,'t01','cent','ksa')=0.126;
ELretirement('GT',vo,'t02','cent','ksa')=0.210;
ELretirement('GT',vo,'t03','cent','ksa')=0.228;
ELretirement('GT',vo,'t04','cent','ksa')=0.240;
ELretirement('GT',vo,'t05','cent','ksa')=0.254;

ELretirement('GT',vo,'t01','east','ksa')=0.100;
ELretirement('GT',vo,'t02','east','ksa')=0.287;
ELretirement('GT',vo,'t03','east','ksa')=0.232;
ELretirement('GT',vo,'t04','east','ksa')=0.232;
ELretirement('GT',vo,'t05','east','ksa')=0.232;
*$offtext

$ontext
ELretirement(ELp,vo,time,r,c)$rc(r,c)=0;
*$ontext
*Source: SEC (in June 2017)
ELretirement('GT',vo,'t02','west','ksa')=0.16447;
ELretirement('GT',vo,'t03','west','ksa')=0.22537;
ELretirement('GT',vo,'t04','west','ksa')=0.33327;
ELretirement('GT',vo,'t05','west','ksa')=0.13627;
ELretirement('GT',vo,'t06','west','ksa')=1.90627;
ELretirement('GT',vo,'t07','west','ksa')=0.27777;
ELretirement('GT',vo,'t08','west','ksa')=0.29277;
ELretirement('GT',vo,'t09','west','ksa')=0.124;
ELretirement('CC',vo,'t10','west','ksa')=1.0906;
ELretirement('Steam',vo,'t11','west','ksa')=0.532;

ELretirement('GT',vo,'t03','sout','ksa')=0.053;
ELretirement('GT',vo,'t04','sout','ksa')=0.036;
ELretirement('GT',vo,'t05','sout','ksa')=0.130;
ELretirement('GT',vo,'t06','sout','ksa')=0.2065;
ELretirement('GT',vo,'t07','sout','ksa')=0.225;
ELretirement('GT',vo,'t10','sout','ksa')=0.100;
ELretirement('GT',vo,'t11','sout','ksa')=0.045;
ELretirement('GT',vo,'t18','sout','ksa')=0.136;

ELretirement('GT',vo,'t02','cent','ksa')=0.44488;
ELretirement('GT',vo,'t03','cent','ksa')=0.32188;
ELretirement('GT',vo,'t04','cent','ksa')=0.15488;
ELretirement('GT',vo,'t05','cent','ksa')=0.23648;
ELretirement('GT',vo,'t06','cent','ksa')=0.25500;
ELretirement('GT',vo,'t07','cent','ksa')=0.29267;
ELretirement('GT',vo,'t08','cent','ksa')=0.29267;
ELretirement('GT',vo,'t09','cent','ksa')=0.29267;
ELretirement('CC',vo,'t09','cent','ksa')=0.33360;
ELretirement('CC',vo,'t10','cent','ksa')=0.33360;
ELretirement('GT',vo,'t10','cent','ksa')=0.48000+0.34380;
ELretirement('CC',vo,'t11','cent','ksa')=0.66720;
ELretirement('GT',vo,'t13','cent','ksa')=0.030;
ELretirement('GT',vo,'t18','cent','ksa')=0.051;

ELretirement('GT',vo,'t02','east','ksa')=0.237;
ELretirement('GT',vo,'t03','east','ksa')=0.296;
ELretirement('GT',vo,'t04','east','ksa')=0.268;
ELretirement('GT',vo,'t05','east','ksa')=0.268;
ELretirement('GT',vo,'t06','east','ksa')=0.310;
ELretirement('GT',vo,'t07','east','ksa')=0.242;
ELretirement('GT',vo,'t08','east','ksa')=0.388;
ELretirement('GT',vo,'t09','east','ksa')=0.239;
ELretirement('GT',vo,'t10','east','ksa')=0.240;
ELretirement('GT',vo,'t11','east','ksa')=0.118;
ELretirement('Steam',vo,'t13','east','ksa')=0.430;
ELretirement('Steam',vo,'t18','east','ksa')=0.625;
$offtext

* Water additions
* 2016
WAaddition('CCCoMSF','new','t02','east','ksa') = 2.120; {{ Ras Az Zawr cogen plant CC MSF }}
WAaddition('CCCoVMSF','new','t02','east','ksa') = 0.530;

WAaddition('SWRO','new','t02','omnr','omn')=0.006814;

* 2017
WAaddition('CCCoMED','new','t03','west','ksa') = 1.2; {{ Marafiq YANBU 3 new CCOO MED plant }}
WAaddition('CCCoVMED','new','t03','west','ksa') = 1.5;

WAaddition('SWRO','new','t03','omnr','omn')=0.166558;

WAaddition('CCCoMSF','new','t03','qatr','qat')=0.800;

* 2018
WAaddition('StCoV','new','t04','kuwr','kuw')=0.764;

WAaddition('SWRO','new','t04','omnr','omn')=0.450464;

WAaddition('CCCoMSF','new','t04','qatr','qat')=0.812;

WAaddition('SWRO','new','t04','adwe','uae')=0.12;

* 2019
*WAaddition('GTco','new','t05','kuwr','kuw')=300;

* 2020
WAaddition('CCcoMSF','new','t06','kuwr','kuw')=0.300;

WAaddition('SWRO','new','t06','omnr','omn')=0.094635;

* 2021
WAaddition('SWRO','new','t07','omnr','omn')=0.066623;

* 2022
WAaddition('CCcoMSF','new','t08','kuwr','kuw')=1.800;
WAaddition('SWRO','new','t08','omnr','omn')=0.466363;

* 2023
*WAaddition('CCcoMSF','new','t09','kuwr','kuw')=900;

*WAretirement('StCoV','old','t09','kuwr','kuw') = 660;

WAretirement(WAp,vo,time,r,c)$rc(r,c) = 0;
$ontext
WAretirement('STco','old','t04','east','ksa') = 1.225;
WAretirement('STco','old','t06','east','ksa') = 0.011;
WAretirement('STco','old','t20','east','ksa') = 0.479;
WAretirement('STco','old','t09','sout','ksa') = 0.108;
WAretirement('STco','old','t09','west','ksa') = 0.263;
WAretirement('STco','old','t18','west','ksa') = 0.150;
WAretirement('STco','old','t21','west','ksa') = 0.520;

WAretirement('STcoV','old','t03','east','ksa') = 0.360;
WAretirement('STcoV','old','t03','east','ksa') = 0.710;
WAretirement('STcoV','old','t03','west','ksa') = 0.256;
WAretirement('STcoV','old','t02','west','ksa') = 0.357;
WAretirement('STcoV','old','t03','west','ksa') = 0.590;

WAretirement('MED','old','t07','west','ksa') = 0.0045;
WAretirement('SWRO','old','t03','sout','ksa') = 0.00227;
WAretirement('SWRO','new','t04','west','ksa') = 0.0044;
WAretirement('SWRO','new','t05','west','ksa') = 0.0044;
WAretirement('SWRO','new','t24','west','ksa') = 0.0134;
WAretirement('SWROhyb','new','t13','west','ksa') = 1.28182;
WAretirement('SWROhyb','new','t04','west','ksa') = 0.05680;
WAretirement('SWROhyb','new','t09','west','ksa') = 0.05680;
WAretirement('SWROhyb','new','t09','east','ksa') = 0.0909;
$offtext
