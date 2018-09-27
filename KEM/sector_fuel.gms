*following section only needed if the submodel is run on a stand-alone basis
$inlinecom /* */

$ontext
*=============================
Fuel units:
- Crude oil (all grades): million barrels
- Refined oil products: million metric tons
- Petrochemical products: million metric tons
- Methane and ethane: trillion BTU
- Uranium: kg
- Coal: million metric tons
- Propane, gas condensate, and other NGL: million metric tons
*=============================
$offtext

*Converting above from million metric tons to million BBL.
table Fuelcst(fup,ss,c) marginal prod cost in million USD per trillion BTU or million barrels or million tons
          ss1.ksa     ss1.uae   ss1.qat   ss1.kuw   ss1.bah  ss1.omn
Crude     5           5         5         5         5        5
Gcond     5           5         5         5         5        5
Arabsuper 5           5         5         5         5        5
Arabextra 5           5         5         5         5        5
Arablight 5           5         5         5         5        5
Arabmed   5           5         5         5         5        5
Arabheavy 5           5         5         5         5        5
Methane   3.50        3.50      3.50      3.50      3.50     3.50
Ethane    0.75        0.75      0.75      0.75      0.75     0.75
Propane   37.50       37.50     37.50     37.50     37.50    37.50
NGL       37.13       37.13     37.13     37.13     37.13    37.13
u-235     101.27      101.27    101.27    101.27    101.27   101.27
Coal      69.39       69.39     69.39     69.39     69.39    69.39
*DMW: Coal export (FOB) price of $57.04 - http://www.indexmundi.com/commodities/?commodity=coal-south-african&months=120
* UAE will have different shipping cost from Richards Bay (or possibly other source)
*We add freight cost (from Richards Bay Coal Terminal to western Saudi Arabia) to FOB to obtain value in above table.
*Using 0.157333 US cents per km-ton (or 12.35 USD/ton for the route we chose).
*For NGL, cost estimated at 0.75 USD/MMBTU and using a 49.51 GJ/ton energy density.
*For propane, cost estimated at 0.75 USD/MMBTU and using a 50 GJ/ton energy density.
*Uranium and coal are imported fuels, and their Fuelcst reprsents purchase costs.
;

* Fuel supply from Aramco Annual Report for 2014 (end of it).
*Crude units in MMbbl/year
*methane and ethane units in trillion BTU/year
*propane, condensate, and other NGL units in million metric tons/year

* Domestic fuel supply. Production + imports (Dolphin and LNG). Natural gas is sales gas.


parameter fimportcst(time,fup) LNG import cost - includes regasification;
fimportcst(time,'methane')=9.0;


Table fuelsupmax(f,time,r,c,ss) maximum fuel supply in each region-country MMBBL Million Tonnes and Trillion BTU
                east.ksa.ss1
crude    . t1   3700
methane  . t1   2941.46

+               adwe.uae.ss1    dewa.uae.ss1    sewa.uae.ss1    fewa.uae.ss1
crude    . t1   1068.575        18.25           0               0
methane  . t1   2000.00         44.23           0               0

+               qatr.qat.ss1    kuwr.kuw.ss1   bahr.bah.ss1      omnr.omn.ss1
crude    . t1   239.44          603.651        73.56             358.065
*methane  . t1   6371.45         741.167        546.575           1000
methane  . t1   6371.45         741.167        760.13            1000
;

* Kuwait 1052.295 TBTU
* Oman 1209.84
* Abu Dhabi 3127.58
* Dubai 667.256
* SEWA 59.22
* FEWA 3.44

*fuelsupmax('methane','t1','east','ksa','ss1')=7000;
*fuelsupmax('methane','t1','kuwr','kuw','ss1')=1400;
*fuelsupmax('methane','t1','bahr','bah','ss1')=150;

table Fuelsplit(crude,c,time) proportion of grades
                 ksa.t1    uae.t1   qat.t1   kuw.t1    bah.t1     omn.t1
Arablight        0.65      1.00     1.00     1.0       1.0        1.0
Arabmed          0.25      0        0        0         0          0
Arabheavy        0.10      0        0        0         0          0
;

*Fuelsplit(crude,c,time)=0;
*Fuelsplit('arablight',c,time)=1;

*Fuelsplit(crude,c,time)=Fuelsplit(crude,c,'t1');

* define max fuel for individual crude grades
fuelsupmax(crude,time,r,c,ss)=fuelsupmax('crude',time,r,c,ss)*fuelsplit(crude,c,time);
fuelsupmax('u-235',time,r,c,'ss1')=1e3;
fuelsupmax('Coal',time,r,c,'ss1')=1e3;
fuelsupmax('Coal',time,'west','ksa','ss1')=1e3;
fuelsupmax('dummyf',time,r,c,'ss1')=9e5;

* Other fuel consumption = domestic supply - power and water consumption in current policy

* set ss2 fuelmax to 0
fuelsupmax(f,time,r,c,'ss2')=0;

Parameter OTHERfconsump(fup,time,r,c);
OTHERfconsump(fup,time,r,c)=0;
OTHERfconsump('methane','t1','east','ksa')=1610;
*OTHERfconsump('methane','t1','qatr','qat')=400;
OTHERfconsump('methane',time,'qatr','qat')=0;

*OTHERfconsump('arablight',time,'kuwr','kuw')=336;
*OTHERfconsump('arablight',time,'kuwr','kuw')=500;

OTHERfconsump('methane',time,'kuwr','kuw')=540;

*OTHERfconsump('methane',time,'bahr','bah')=546-100;
OTHERfconsump('arablight',time,'bahr','bah')=98;

OTHERfconsump('arablight',time,'adwe','uae')=176.17;
OTHERfconsump('methane',time,'adwe','uae')=1000;
*OTHERfconsump('methane',time,'adwe','uae')=500;

OTHERfconsump('arablight',time,'dewa','uae')=18.25;
OTHERfconsump('methane',time,'dewa','uae')=550;

OTHERfconsump('arablight',time,'sewa','uae')=0;
OTHERfconsump('methane',time,'sewa','uae')=0;

OTHERfconsump('arablight',time,'fewa','uae')=0;
OTHERfconsump('methane',time,'fewa','uae')=0;

OTHERfconsump('arablight',time,'omnr','omn')=70;
OTHERfconsump('methane',time,'omnr','omn')=500;



display OTHERfconsump;

* keep for checking until replace
*The following values include exports
$ontext
OTHERfconsump('crude',time,'bahr','bah')=163.49;
OTHERfconsump('crude',time,'kuwr','kuw')=1032.89;
OTHERfconsump('crude',time,'omnr','omn')=358.065;
*OTHERfconsump('crude',time,'qatr','qat')=692.79;
OTHERfconsump('crude',time,'qatr','qat')=0 ;
OTHERfconsump('crude',time,'east','ksa')=3549;
OTHERfconsump('crude',time,'adwe','uae')=1068.4;
OTHERfconsump('crude',time,'dewa','uae')=18.25;
*In long-term static setting, use (936-865.127) million barrels for other-industry oil use for KSA.

OTHERfconsump('methane',time,'bahr','bah')=398.62;
OTHERfconsump('methane',time,'kuwr','kuw')=642.07;
OTHERfconsump('methane',time,'omnr','omn')=945.66;
OTHERfconsump('methane',time,'qatr','qat')=6043.93;
OTHERfconsump('methane',time,'east','ksa')=3090.4;
OTHERfconsump('methane',time,'adwe','uae')=2438.21;
OTHERfconsump('methane',time,'dewa','uae')=200.24;

OTHERfconsump('crude',time,'bahr','bah')=97.52;
OTHERfconsump('crude',time,'kuwr','kuw')=317.11;
OTHERfconsump('crude',time,'omnr','omn')=70.45;
OTHERfconsump('crude',time,'qatr','qat')=60.33;
*OTHERfconsump('crude',time,'east','ksa')=934.40;
OTHERfconsump('crude',time,'adwe','uae')=176.17;
OTHERfconsump('crude',time,'dewa','uae')=18.25;
*In long-term static setting, use (936-865.127) million barrels for other-industry oil use for KSA.

OTHERfconsump('methane',time,'bahr','bah')=311.25;
OTHERfconsump('methane',time,'kuwr','kuw')=642.07;
OTHERfconsump('methane',time,'omnr','omn')=561.23;
OTHERfconsump('methane',time,'qatr','qat')=1407.31;

OTHERfconsump('methane',time,'adwe','uae')=1966.97;
OTHERfconsump('methane',time,'dewa','uae')=200.24;
$offtext

*Using IHS Midstream database, we used the cost estimate, capacity, and length of
*the Yanbu-to-Rabigh pipeline that was commissioned in 2006 to estimate the capital
*cost of an oil pipeline (36-inch-diameter) in USD/km/bbl of oil.
*Capacity: 181.405 million barrels per year.
*Capital cost: 130 million USD.
*Length: 146 km.
*Distances of east<->west(1200 km), east<->cent(400 km), east<->south(1700 km),
*and intra-regional(150 km) were then applied.

parameter ftranscapital_cost(fup) capital costs;
* methane USD/MMBTU-km
ftranscapital_cost('methane')=0.00041765;
* ethane USD/MMBTU-km
ftranscapital_cost('ethane')=0.00041765;
* crude USD/BBL-km
ftranscapital_cost('crude')=0.00490841;
* propane USD/ton-km
ftranscapital_cost('propane')=0.00067059;

parameter ftransom_cost(fup) O&M;
* methane USD/MMBTU-km
ftransom_cost('methane')=0.000021;
* ethane USD/MMBTU-km
ftransom_cost('ethane')=0.000021;
* crude USD/BBL-km
ftransom_cost('crude')=0.000021;
* propane USD/ton-km
ftransom_cost('propane')=0.000021;
* Gcond USD/ton-km
ftransom_cost('Gcond')=0.000021;
* Coal USD/ton-km
ftransom_cost('coal')=0.003225;

parameter ftranspurcst(fup,time,r,c,rr,cc) capital costs for transmission capacity in USD per MMBTU or BBL or ton;
ftranspurcst(fup,time,r,c,rr,cc)=distances(r,c,rr,cc)*ftranscapital_cost(fup);

parameter ftransomcst(fup,r,c,rr,cc) O&M costs in USD per MMBTU or BBL or ton;
ftransomcst(fup,r,c,rr,cc)=distances(r,c,rr,cc)*ftransom_cost(fup);

*Estimating that fuel costs represent 33% of coal transport cost;
ftransomcst('Coal',r,c,rr,cc)=ftransomcst('Coal',r,c,rr,cc)/0.33;

*48-inch natural gas line from east to west: 1.85 MMboe/day
*56-in crude oil line from east to west: 3.25 MMboe/day
*26- to 30-in NGL line from east to west: 0.55 MMboe/day
*Source: Document on Saudi Arabia
*All lines can service Riyadh.

parameter ftransexist(fup,r,c,rr,cc)  existing transportation capacity in MMBTU or bbl or ton;
ftransexist(fup,r,c,rr,cc)=0;
ftransexist(fup,r,c,rr,cc)$( rc(r,c) and rc(rr,cc) and sameas(c,cc) )=9999;
ftransexist(fup,r,c,rr,cc)$c('ksa')=0;

ftransexist('ethane','east','ksa','west','ksa')=1229.70;
ftransexist('ethane','east','ksa','cent','ksa')=1229.70;
ftransexist('methane','east','ksa','west','ksa')=4365;
ftransexist('methane','east','ksa','cent','ksa')=4365;
*ftransexist('Gcond',r,'ksa',rr,'ksa')=0;
ftransexist('Gcond','east','ksa','east','ksa')=9999;
*ftransexist('propane',r,'ksa',rr,'ksa')=0;
ftransexist('propane','east','ksa','west','ksa')=27.40;
ftransexist('propane','east','ksa','east','ksa')=27.40;

ftransexist('crude',r,c,rr,cc)=0;

*ftransexist('methane',r,'uae',rr,'uae')= 1e3;
ftransexist('arablight',r,'uae',rr,'uae')= 1e3;

* Dolphin pipeline
*ftransexist('methane','qatr','qat','adwe','uae')=737;
*ftransexist('methane','adwe','uae','dewa','uae')=337;
*ftransexist('methane','adwe','uae','omnr','omn')=74;

ftransexist('methane','qatr','qat','adwe','uae')=800;
*ftransexist('methane','adwe','uae','dewa','uae')=300;
ftransexist('methane','adwe','uae','omnr','omn')=100;


display ftransexist;

* DMW - need to add fuel pipeline capacities for UAE etc

parameter ftransleadtime(fup,r,c,rr,cc) lead time for building tranmission;
ftransleadtime(fup,r,c,rr,cc)=0;

table ftransyield(fup,r,c,rr,cc) net of self-consumption and distribution losses
                 west.ksa  sout.ksa  cent.ksa  east.ksa
* yields for KSA
methane.sout.ksa 0.98      0.9975    0.98      0.96
methane.cent.ksa 0.98      0.98      0.9975    0.98
methane.east.ksa 0.96      0.96      0.98      0.9975
ethane.west.ksa  0.9975    0.98      0.98      0.96
ethane.sout.ksa  0.98      0.9975    0.98      0.96
ethane.cent.ksa  0.98      0.98      0.9975    0.98
ethane.east.ksa  0.96      0.96      0.98      0.9975
Coal.west.ksa    1         1         1         1

* yields for UAE
methane.adwe.uae
methane.dewa.uae
methane.sewa.uae
methane.fewa.uae
ethane.adwe.uae
ethane.dewa.uae
ethane.sewa.uae
ethane.fewa.uae
coal.adwe.uae
coal.dewa.uae
coal.sewa.uae
coal.fewa.uae

* yields for QAT
methane.qatr.qat
ethane.qatr.qat
coal.qatr.qat

* yields for KUW
methane.kuwr.kuw
ethane.kuwr.kuw
coal.kuwr.kuw

* yields for BAH
methane.bahr.bah
ethane.bahr.bah
coal.bahr.bah

* yields for OMN
methane.omnr.omn
ethane.omnr.omn
coal.omnr.omn

+                 adwe.uae  dewa.uae  sewa.uae  fewa.uae
* yields for KSA
methane.sout.ksa  0         0         0         0
methane.cent.ksa  0         0         0         0
methane.east.ksa  0         0         0         0
ethane.west.ksa   0         0         0         0
ethane.sout.ksa   0         0         0         0
ethane.cent.ksa   0         0         0         0
ethane.east.ksa   0         0         0         0
Coal.west.ksa     0         0         0         0

* yields for UAE
methane.adwe.uae  0.99      0.99      0.99      0.99
methane.dewa.uae  0.99      0.99      0.99      0.99
methane.sewa.uae  0.99      0.99      0.99      0.99
methane.fewa.uae  0.99      0.99      0.99      0.99
ethane.adwe.uae   0.99      0.99      0.99      0.99
ethane.dewa.uae   0.99      0.99      0.99      0.99
ethane.sewa.uae   0.99      0.99      0.99      0.99
ethane.fewa.uae   0.99      0.99      0.99      0.99
coal.adwe.uae     1         1         1         1
coal.dewa.uae     1         1         1         1
coal.sewa.uae     1         1         1         1
coal.fewa.uae     1         1         1         1

* yields for QAT
methane.qatr.qat  1
ethane.qatr.qat
coal.qatr.qat

* yields for KUW
methane.kuwr.kuw
ethane.kuwr.kuw
coal.kuwr.kuw

* yields for BAH
methane.bahr.bah
ethane.bahr.bah
coal.bahr.bah

* yields for OMN
methane.omnr.omn  0
ethane.omnr.omn
coal.omnr.omn

+                  qatr.qat  kuwr.kuw  bahr.bah  omnr.omn
* yields for KSA
methane.sout.ksa   0          0        0         0
methane.cent.ksa   0          0        0         0
methane.east.ksa   0          0        0         0
ethane.west.ksa    0          0        0         0
ethane.sout.ksa    0          0        0         0
ethane.cent.ksa    0          0        0         0
ethane.east.ksa    0          0        0         0
Coal.west.ksa      0          0        0         0

* yields for UAE
methane.adwe.uae   0                             1
methane.dewa.uae
methane.sewa.uae
methane.fewa.uae
ethane.adwe.uae
ethane.dewa.uae
ethane.sewa.uae
ethane.fewa.uae
coal.adwe.uae
coal.dewa.uae
coal.sewa.uae
coal.fewa.uae

* yields for QAT
methane.qatr.qat   0.99
ethane.qatr.qat    0.99
coal.qatr.qat      1

* yields for KUW
methane.kuwr.kuw             0.99
ethane.kuwr.kuw              0.99
coal.kuwr.kuw                1

* yields for BAH
methane.bahr.bah                       0.99
ethane.bahr.bah                        0.99
coal.bahr.bah                          1

* yields for OMN
methane.omnr.omn                                 0.99
ethane.omnr.omn                                  0.99
coal.omnr.omn                                    1
;

$ontext
parameter ftransyield(fup,r,c,rr,cc) net of self-consumption and distribution losses;
ftransyield(fup,r,c,rr,cc)$(rc(r,c) and rc(rr,cc) and sameas(c,cc) )=1;
ftransyield('Arablight',r,c,rr,cc)$(rc(r,c) and rc(rr,cc) and sameas(c,cc) )=0.98;
ftransyield('Arabmed',r,c,rr,cc)$(rc(r,c) and rc(rr,cc) and sameas(c,cc) )=0.98;
ftransyield('Arabheavy',r,c,rr,cc)$(rc(r,c) and rc(rr,cc) and sameas(c,cc) )=0.98;

ftransyield('methane',r,c,rr,cc)$(rc(r,c) and rc(rr,cc) and sameas(c,cc) )=0.98;
$offtext

ftransyield('methane','qatr','qat','adwe','uae')=0.98;
ftransyield('methane','adwe','uae','qatr','qat')=0.98;
ftransyield('methane','adwe','uae','omnr','omn')=0.98;
ftransyield('Arablight','east','ksa','bahr','bah')=0.98;


ftransyield('crude',r,c,rr,cc)$(rc(r,c) and rc(rr,cc) and sameas(c,cc) )=1;
ftransyield('NGL',r,c,rr,cc)$(rc(r,c) and rc(rr,cc) and sameas(c,cc) )=1;
ftransyield('propane',r,c,rr,cc)$(rc(r,c) and rc(rr,cc) and sameas(c,cc) )=1;
ftransyield('Arabsuper',r,c,rr,cc)$(rc(r,c) and rc(rr,cc) and sameas(c,cc) )=1;
ftransyield('Arabextra',r,c,rr,cc)$(rc(r,c) and rc(rr,cc) and sameas(c,cc) )=1;
ftransyield('Arablight',r,c,rr,cc)$(rc(r,c) and rc(rr,cc) and sameas(c,cc) )=1;
ftransyield('Arabmed',r,c,rr,cc)$(rc(r,c) and rc(rr,cc) and sameas(c,cc) )=1;
ftransyield('Arabheavy',r,c,rr,cc)$(rc(r,c) and rc(rr,cc) and sameas(c,cc) )=1;
ftransyield('Gcond',r,c,rr,cc)$(rc(r,c) and rc(rr,cc) and sameas(c,cc) )=1;
ftransyield('dummyf',r,c,rr,cc)$(rc(r,c) and rc(rr,cc) and sameas(c,cc) )=1;
ftransyield('u-235',r,c,rr,cc)$(rc(r,c) and rc(rr,cc) and sameas(c,cc) )=1;

display ftransyield;

parameter fintlprice(f,time) market price for fuels in USD per MMBTU or bbl or ton;
fintlprice('arablight','t1')=55;
fintlprice('arabmed','t1')=60;
fintlprice('arabheavy','t1')=60;

fintlprice('Gcond','t1')=fintlprice('Arablight','t1')+4;
fintlprice('propane',time)=851.4;
*fintlprice('methane',time)=0.15*fintlprice('Arablight','t1');
* netback
fintlprice('methane',time)=7.0;

fintlprice('ethane',time)=9;
fintlprice('NGL','t1')=657;
fintlprice('u-235',time)=101.27;
fintlprice('Coal','t1')=84.26;

parameter RFintlprice(f,time) market price for refinied products;
RFintlprice('diesel',time)=677.08;
RFintlprice('HFO',time)=791.64;

Parameter flifetime(fup) lifetime of tranportation equipment;
flifetime(fup)=35;

Parameter fdiscfact(time) discount factor for fuel fector;

* set initial transmission capacity
ftransexistcp.fx(fup,'t1',r,c,rr,cc)$(rc(r,c) and rc(rr,cc))=ftransexist(fup,r,c,rr,cc);

* in lieu of constraining fuel consumption directly:
Fueluse.up(fup,ss,trun,r,c)$rc(r,c)=fuelsupmax(fup,trun,r,c,ss);

* export controls
fExports.fx('ethane',trun,r,'ksa')=0;
fExports.fx('methane',trun,r,'ksa')=0;
fExports.fx('coal',trun,r,'ksa')=0;
fExports.fx('coal',trun,r,c)=0;
fExports.fx('u-235',trun,r,c)=0;

*fExports.up('methane',trun,r,'qat')=4636;
fExports.up('methane',trun,r,'qat')=9e3;

fExports.up('methane',trun,r,'bah')=0;
*fExports.up('arablight',trun,r,'bah')=1e3;

*fExports.up('methane',trun,r,'kuw')=0;
fExports.up('methane',trun,r,'kuw')=1e3;
fExports.up('arablight',trun,r,'kuw')=1e3;

fExports.lo('methane',trun,'adwe','uae')=300;
*fExports.up('arablight',trun,'adwe','uae')=900;

fExports.up('methane',trun,'dewa','uae')=0;
fExports.up('arablight',trun,'dewa','uae')=0;

fExports.up('methane',trun,'sewa','uae')=0;
fExports.up('arablight',trun,'sewa','uae')=0;

fExports.up('methane',trun,'fewa','uae')=0;
fExports.up('arablight',trun,'fewa','uae')=0;

*fExports.up('methane',trun,'omnr','omn')=400;
fExports.up('arablight',trun,'omnr','omn')=1e3;

fimports.up(trun,fup,r,c)=0;
*fimports.up(trun,'methane',r,c)=1e3;
fimports.up(trun,'methane','kuwr','kuw')=1e3;
* for interconnector sensitivity
*fimports.up(trun,'methane','kuwr','kuw')=300;

*fimports.up(trun,'methane','dewa','uae')=570;
* only amount on top of Dolphin
*fimports.up(trun,'methane','sewa','uae')=60;
*fimports.up(trun,'methane','fewa','uae')=5;

fimports.up(trun,'methane','dewa','uae')=250;
fimports.up(trun,'methane','adwe','uae')=0;
fimports.up(trun,'methane','sewa','uae')=0;
fimports.up(trun,'methane','fewa','uae')=0;

Equations
fObjective               Upstream sector objective function
fpurchbal(trun)           acumulates all import purchases
fopmaintbal(trun)         accumulates operations and maintenance costs
fuelsup(fup,trun,r,c)         measures fuel use
ftranscapbal(fup,trun,r,c,rr,cc) natural gas transport balance
ftranscaplim(fup,trun,r,c,rr,cc) natural gas transport capcity constraint
fdem(f,trun,rr,cc)           regionalized fuel demand
frevenuesbal(trun)        aggregates revenues
fExportsum(fup,trun,c)      national exports sum

DfCapitalCost(trun)           dual from imports
Dfopandmaint(trun)        dual from opandmaint
Dfueluse(fup,ss,trun,r,c)      dual from fueluse
Dftrans(fup,trun,r,c,rr,cc)
Dftransexistcp(fup,trun,r,c,rr,cc)
Dftransbld(fup,trun,r,c,rr,cc)
DfExports(fup,trun,r,c)
Dfnatexports(fup,trun,c)
DfRevenues(trun)
Dfimports(trun,fup,r,c)
;
$offorder
*$ontext
fObjective.. UPz =e= sum(t,(fCapitalCost(t) + fOpandmaint(t))*fdiscfact(t))
          + sum((fup,ss,t,r,c)$rc(r,c),fuelcst(fup,ss,c)*fueluse(fup,ss,t,r,c)*fdiscfact(t))
          +sum((t,fup,r,c)$rc(r,c),fimports(t,fup,r,c)*fimportcst(t,fup)*fdiscfact(t))
           -sum(t,fdiscfact(t)*fRevenues(t));
*$offtext


fpurchbal(t).. sum((fup,r,c,rr,cc)$(rc(r,c) and rc(rr,cc)),ftranspurcst(fup,t,r,c,rr,cc)*ftransbld(fup,t,r,c,rr,cc))
           -fCapitalCost(t)=e=0;

fopmaintbal(t).. sum((fup,r,c,rr,cc)$(rc(r,c) and rc(rr,cc) and ftransyield(fup,r,c,rr,cc)>0),ftransomcst(fup,r,c,rr,cc)*ftrans(fup,t,r,c,rr,cc))
          -fopandmaint(t)=e=0;

frevenuesbal(t).. sum((fup,r,c)$rc(r,c),fintlprice(fup,t)*fExports(fup,t,r,c))
 -fRevenues(t)=e=0;

fExportsum(fup,t,c).. -sum(r$rc(r,c),fExports(fup,t,r,c))+fnatexports(fup,t,c)=e=0;

fuelsup(fup,t,r,c)$rc(r,c)..
 sum(ss,Fueluse(fup,ss,t,r,c))
+fimports(t,fup,r,c)
-fExports(fup,t,r,c)
-sum((rr,cc)$(rc(rr,cc) and ftransyield(fup,r,c,rr,cc)>0),ftrans(fup,t,r,c,rr,cc))=g=0;

fdem(fup,t,rr,cc)$rc(rr,cc).. sum((r,c)$(rc(r,c) and ftransyield(fup,r,c,rr,cc)>0),ftransyield(fup,r,c,rr,cc)*ftrans(fup,t,r,c,rr,cc))
         -sum(ELpd,ELfconsump(ELpd,fup,t,rr,cc))$ELf(fup)
         -sum(ELpd,ELfconsump_trade(ELpd,fup,t,rr,cc))$(ELf(fup) and fMPt(fup,cc))
         -WAfconsump(fup,t,rr,cc)$WAf(fup)
         -WAfconsump_trade(fup,t,rr,cc)$(fMPt(fup,cc) and WAf(fup))
*         -PCfconsump(fup,t,rr,cc)*fPCconv(fup)$PCm(fup)
*         -RFcrconsump(fup,t,rr,cc)*fRFconv(fup)$RFf(fup)
*         -CMfconsump(fup,t,rr,cc)$CMf(fup)
*  and consumption from all other sectors
         -OTHERfconsump(fup,t,rr,cc)
         =g=0;

ftranscapbal(fup,t,r,c,rr,cc)$(rc(r,c) and rc(rr,cc)).. ftransexistcp(fup,t,r,c,rr,cc)
         +ftransbld(fup,t-ftransleadtime(fup,r,c,rr,cc),r,c,rr,cc)-ftransexistcp(fup,t+1,r,c,rr,cc)=g=0;

ftranscaplim(fup,t,r,c,rr,cc)$(rc(r,c) and rc(rr,cc) and ftransyield(fup,r,c,rr,cc)>0).. ftransexistcp(fup,t,r,c,rr,cc)
         +ftransbld(fup,t-ftransleadtime(fup,r,c,rr,cc),r,c,rr,cc)
         -ftrans(fup,t,r,c,rr,cc)=g=0;

* Dual Relationships
DfCapitalCost(t)..  1*fdiscfact(t)=g=-Dfpurchbal(t);
Dfopandmaint(t)..  1*fdiscfact(t)=g=-Dfopmaintbal(t);
DfRevenues(t).. -1*fdiscfact(t)=g=-Dfrevenuesbal(t);

Dfueluse(fup,ss,t,r,c)$rc(r,c)..
  Fuelcst(fup,ss,c)*fdiscfact(t)=n=Dfuelsup(fup,t,r,c);

Dfimports(t,fup,r,c)$rc(r,c)..
 fimportcst(t,fup)*fdiscfact(t)=n=Dfuelsup(fup,t,r,c);

DfExports(fup,t,r,c)$rc(r,c)..
 0=g=Dfrevenuesbal(t)*fintlprice(fup,t)
    -Dfuelsup(fup,t,r,c)
    -DfExportsum(fup,t,c);

Dfnatexports(fup,t,c).. 0=e=DfExportsum(fup,t,c);

Dftransexistcp(fup,t,r,c,rr,cc)$(rc(r,c) and rc(rr,cc))..
 0=n=Dftranscapbal(fup,t,r,c,rr,cc)
    -Dftranscapbal(fup,t-1,r,c,rr,cc)
    +Dftranscaplim(fup,t,r,c,rr,cc)$(ftransyield(fup,r,c,rr,cc)>0);

Dftrans(fup,t,r,c,rr,cc)$(rc(r,c) and rc(rr,cc) and ftransyield(fup,r,c,rr,cc)>0)..
 0=g=Dfopmaintbal(t)*ftransomcst(fup,r,c,rr,cc)
    -Dfuelsup(fup,t,r,c)
    +Dfdem(fup,t,rr,cc)*ftransyield(fup,r,c,rr,cc)
    -Dftranscaplim(fup,t,r,c,rr,cc)$(ftransyield(fup,r,c,rr,cc)>0);

Dftransbld(fup,t,r,c,rr,cc)$(rc(r,c) and rc(rr,cc)).. 0=g=Dfpurchbal(t)*ftranspurcst(fup,t,r,c,rr,cc)
  +Dftranscapbal(fup,t+ftransleadtime(fup,r,c,rr,cc),r,c,rr,cc)
  +Dftranscaplim(fup,t+ftransleadtime(fup,r,c,rr,cc),r,c,rr,cc)$(ftransyield(fup,r,c,rr,cc)>0);
