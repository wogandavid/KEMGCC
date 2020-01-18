* Water Model - A sub-model of the KAPSARC Energy Model (KEM) (Now expanded to GCC countries)
*-------------------------------------------------------------------------------
* The model focues is on energy requirements for desalination demand
* It includes thermal and RO desalination plants.
* Cogneration plants (power/water) are included.
* Both fixed and variable PWR can be used in cogen desalination
* Ground water demand (non agricultural) is included, however in runs it should
* be exogenously fixed as ground supply constraints have not been modeled
* Water treatment and wastewater recyling is not yet included
*-------------------------------------------------------------------------------


Scalars

glperm3         gallons per cubic meter                          /264.172/
MBTUperkgst     BTU per kg of steam at 100C                      /2.139/
MBTUperKWH      MBTU per KWH                                     /3.412/
* derived from BHP = 33475 BTU/hr per 15.65 kg/hr 100 C
Boilereff     boiler efficieny for thermal desal plant fuel rate /0.9/
rhoH2O          density of water kg per m3                       /1000/
hrsperday       number of hrs in a day                           /24/
daysperyear     number of days in an hr                          /365/
hrsperyear      number of hrs per year                           /8760/
;

Parameter
ELlcnorm(ELl,c) normalized load hours curve;
ELlcnorm(ELl,c) = ELlchours(ELl,c)/sum(ELll,ELlchours(ELll,c));
* use to convert baseload hours into load curve hours for WAELsupply

Parameter
WAlc(ELl,ELs,ELday,c)   load curve demand for water (normalized);
WAlc(ELl,ELs,ELday,c)= ELlcnorm(ELl,c)*ELnormdays(ELs,ELday);
* set flat load curve with normalized values proportioanl to the number of hours in each load segments


* Maximum fuel allocated to water producers
Table WAfconsumpmax(WAf,time,r,c) fuel supply constraint in MMBBL MMTonne  trillion BTU
                west.ksa        sout.ksa        cent.ksa        east.ksa
Arablight.t01    200             0              0               200
methane.t01      10.089                                          340.277
diesel.t01       0.198           0.002                           0.00183
*HFO.t01          3.0             0.50                            0.10
HFO.t01          2.842           0.092                           0.0715

+               adwe.uae        dewa.uae        sewa.uae        fewa.uae
Arablight.t01    0               0               0               0
methane.t01      9e9             9e9             9e9             9e9
diesel.t01       0               0               0               0
HFO.t01          0               0               0               0

+               qatr.qat        kuwr.kuw        bahr.bah        omnr.omn
Arablight.t01    0               5               0                0
methane.t01      9e9             400             9e9              9e9
*methane.t01      9e9             0.05             9e9              9e9
*diesel.t01       0               0               9e9              0
diesel.t01       0               2               9e9              0
HFO.t01          0               4               0                0
;

*WAfconsumpmax('methane','t01',r,c)=WAfconsumpmax('methane','t01',r,c)*3066/2689.685;

Parameter
WAAPf(f,time,r,c)   administered price of fuel for water sector;
* modified in solve_models.gms
WAAPf(f,time,r,c)$rc(r,c)=1;

* administered electricity sold by cogen plants USD per MWh
* defined in sector_power.gms
ELAPelwa(ELl,ELs,ELday,time,r,'ksa')= 0.038/3.75*1e3;
ELAPelwa(ELl,ELs,ELday,time,r,'uae')= 0.038/3.75*1e3;
ELAPelwa(ELl,ELs,ELday,time,r,'qat')= 0.038/3.75*1e3;
ELAPelwa(ELl,ELs,ELday,time,r,'kuw')= 0.038/3.75*1e3;
ELAPelwa(ELl,ELs,ELday,time,r,'bah')= 0.038/3.75*1e3;
ELAPelwa(ELl,ELs,ELday,time,r,'omn')= 0.038/3.75*1e3;

parameters
WAAPel(time,r,c) Administered price elec for RO plants USD per MHW;
WAAPel(time,r,'ksa') = 0.05/3.75*1e3;
WAAPel(time,r,'uae') = 0.05/3.75*1e3;
WAAPel(time,r,'qat') = 0.05/3.75*1e3;
WAAPel(time,r,'kuw') = 0.05/3.75*1e3;
WAAPel(time,r,'bah') = 0.05/3.75*1e3;
WAAPel(time,r,'omn') = 0.05/3.75*1e3;

* water demand

table WAdemval(time,r,c) water demand in billions m3
         west.ksa        sout.ksa        cent.ksa        east.ksa
*t01       0.831           0.093           0.339           0.332
*t01       0.7             0.0             0.4             0.3
*t01       0.580                                            0.711
t01       1.065                                           0.983

+        adwe.uae        dewa.uae        sewa.uae        fewa.uae
t01       0.96            0.39            0.12            0.10

+        qatr.qat        kuwr.kuw        bahr.bah        omnr.omn
t01       0.493           0.6824          0.150           0.222
*t01       0               0.50351         0.1744          0.222
;

parameter WAgrdem(time,rr,cc) ground water demand bcm;
WAgrdem(time,rr,cc)=0;

$ontext
table WAgrdem(time,rr,cc) ground water demand billions m3
         west.ksa        sout.ksa        cent.ksa        east.ksa
*t01       0.080           0.028           0.545           0.295
t01       0               0               0               0

+        adwe.uae        dewa.uae        sewa.uae        fewa.uae
t01       0.001           0.001           0.001           0.001

+        qatr.qat        kuwr.kuw        bahr.bah        omnr.omn
t01       0               0.533           0.001           0.001
;
$offtext

* to increase water demand in multi-period model
*loop(time,WAdemval(time+1,rr,cc)$rc(rr,cc) =WAdemval(time,rr,cc)*1;);

* existing plant capacities
* cogen plants are in GW
* water-only plants are in MMm3/day

Table WAexist(WAp,v,r,c) existing capacity of desal plants MMm3 per day (single) and GW (cogen)

                 west.ksa        sout.ksa        cent.ksa        east.ksa

MED.old          0.483686                                        0.446479
MED.new          0.0360          0.0180
SWROfl.new       0.0520
SWRO.new         0.299201        0.21917                         0.070448
SWRO.old                         0.0027
SWROhyb.new      0.63178                                         0.1494

StCo.old         0.933           0.108                           1.715
StCo.new         1.191
CCCoMED.old                                                      2.237
GTCo.old         0.202
StCoV.old        1.203                                           1.070
CCCoVMED.old     0                                               0.733



*StCo.new         1.958                                           1.808
*GTco.new         2.393                                           2.209

+                adwe.uae        dewa.uae        sewa.uae        fewa.uae
MED.old          0               0               0               0
MED.new          0               0               0               0
MSF.old          0               0               0               0
SWROfl.new       0               0               0               0
SWRO.new         0               0.095           0.435           0.29
SWRO.old         0               0               0               0
SWROhyb.new      0               0               0               0
StCo.old         0               0               0               0
StCo.new         1.49            0.34            0.4             0
CCCoMED.old      0               5.0             0               0
CCCoMSF.old      13.34           0               0               0
CCCoMSF.new      0               0               0               0
GTCo.old         0               0               0               0
GTCo.new         0               0               0               0
StCoV.old        0               0               0               0
CCCoVMED.old     0               0               0               0
CCCoVMED.new     0               0               0               0

+                qatr.qat        kuwr.kuw        bahr.bah        omnr.omn
MED.old          0               0               0               0
MED.new          0               0               0               0
MSF.old          0.306618        0               0.341           0
*MSF.old          0.306618        1.772           0.05678115      0
SWROfl.new       0               0               0               0
SWRO.new         0.1637          0.5             0.061           0.274583836
SWRO.old         0               0                               0
SWROhyb.new      0               0               0               0
StCo.old         0               0               0.182           0
StCo.new         0               0               0               0
CCCoMED.old      0               0               0               0
CCcoMSF.new      4.511           2.262           0               2.466
*CCcoMSF.new      4.511                           0               2.392
GTCo.new         1.673           7.027           0.1             0
StCoV.old        0               0               0               0
StCoV.new                        8.970
CCCoVMED.old     0               0               0               0
*CCCoVMSF.old     0               2.262           0               0

;

Parameter
WAgrexist(time,r,c) groundwater supply;
WAgrexist(time,r,c)$rc(r,c)= 1e9;

* operation parameters

scalar hybratio minimum ratio of cogen distilate to RO product /0.5/

Parameters
WAcapfac(WAp,v) capacity factor for plants
WAoptime(WAp,v,ELl,ELs,ELday,c) time in operation
WAVoptime(WAp,v,ELl,ELs,ELday,c) time in operation
WAFoptime(WAp,v) time for fixed cogen operation
ELnormhours(ELl,ELs,ELday,c) normalized hourly load curve;
ELnormhours(ELl,ELs,ELday,c) = ELlcnorm(ELl,c)*ELnormdays(ELs,ELday);

WAcapfac(WAp,v) = 0.9;

* calibration for 2011 ouptut
WAcapfac(WApFco,"old") = 0.70;
WAcapfac("STCo","old") = 2/3;
*$ontext

* hours of operation for cogen plants [GW]
WAVoptime(WApV,v,Ell,ELs,Elday,c)= ELlchours(ELl,c)*ELdaysinseason(ELs,ELday)*WAcapfac(WApV,v);
WAFoptime(WApF,v) = hrsperyear*WAcapfac(WApF,v)/1e3;
WAFoptime(WApsingle,v) = daysperyear*WAcapfac(WApsingle,v)/1e3;
* days of operation for single purpose plants [MMm3/day]
WAoptime(WApsingle,v,ELl,ELs,ELday,c)= ELlcnorm(ELl,c)*ELdaysinseason(ELs,ELday)*WAcapfac(WApsingle,v);

Parameters

PWR(WAp) power water ratio used for cogen plants in MW per MIGD
/
StCo     5
CCCoMED  10
*CCCoMSF  10
CCCoMSF  16
StCoV    10
CCCoVMED 12
CCCoVMSF 19
GTCo     8
GTCoV    8
/

GOR(WAp) gain output ratio
/
MED     10
StCo     8
StCoV    8
* note the the GOR for EST has been cut in half to inrease heat rate of new plants
CCCoMED  10
CCCoVMED 10
CCCoMSF  8
CCCoVMSF 8
GTCo     8
GTCoV    8
/

* Steam and GT Cogneration plant efficiencies estimated from
* A.M. El-Nashar et al.  state of the art review

Table WApeff(WAp,v)  power plant first law efficiency
         old    new
StCo     0.23   .23
StCoV    0.28   .28
GTCo     0.30   .30
GTCoV    0.30   .30
CCCoMED  0.40   .42
CCCOVMED 0.42   .45
CCCoMSF  0.40   .42
CCCOVMSF 0.42   .45
;

Table WApVeff(WApV,v,opm)  power plant thermal efficiency
         old.m0 new.m0
StCoV    0.38   .38
GTCoV    0.28   .38
CCCoVMED 0.56   .56
CCCoVMSF 0.56   .56
;

WApVeff(WApV,v,"m1")= WApeff(WApV,v)

Parameter
PWR2(WAp)       PWR in GW per MMm3 per day
WAelrate(WAp,v) rate of electricity use by RO plants kWh per m3
WAVpwrincr(WApV,v,opm) power capacity increase for variable cogen plants;

PWR2(WAp)= 1;
PWR2(WApCo)= PWR(WApCO)*glperm3/1e3;

WAelrate("MED",v)= 2;
WAelrate("MSF",v)= 3;
WAelrate("BWRO",v)= 3;
WAelrate("SWRO",v)= 5;
WAelrate("SWROhyb",v)= 5;

WAVpwrincr(WApV,v,opm)= 1 ;
* set pwr increase for both operating mode to 1 (i.e. no power increase).
* WAVpwrincr(WApV,v,"m0") = WApVeff(WApV,v,"m0")/WApVeff(WApV,v,"m1");

parameter WAyield(WAp,v,r,c)  water yield for cogen plants in MMm3 per GWh;

* equation for water yield of new plants at rated PWR
* yield = PWR GW/MMm3/day* hr/day

WAyield(WApFco,v,r,c) = 1/(PWR2(WApFco)*hrsperday);

*  Regional averages for old SWCC plants from SWCC 2011 report
WAyield('STCO','old','west','ksa') = 0.04519;
WAyield('STCO','old','sout','ksa') = 0.03143;
WAyield('STCO','old','east','ksa') = 0.04228;

WAyield(WApsingle,v,r,c)$rc(r,c) = 1

* Regional averages for SWCC plants.
parameter WAVyield(WApV,v,opm,r,c) water yield variable cogen in MMm3 per GWh;
WAVyield(WApV,v,'m1',r,c)$rc(r,c) = 1/(PWR2(WApV)*hrsperday);

*  Regional averages for old SWCC plants from SWCC 2011 report
WAVyield('STCOV','old','m1','west','ksa') = 0.02335;
WAVyield('STCOV','old','m1','east','ksa') = 0.01826;
* water yield at m0 is 0

* fuel burn rates
* single purpose per MMm3
* cogen plants per GWh
* dummy fuel burn for RO plants consuming electricity.
Table WAfuelburn(WAp,v,WAf,r,c) Fixed Desal Fuelburn in MMBTu BBL Tonne per MWH or Thousand m3
                        west.ksa        sout.ksa        cent.ksa        east.ksa
StCo.old.methane                                                        17.510
StCo.old.HFO            0.4815          1.319                           1.790
*StCo.old.HFO            0.4815         0.5                             0.48
StCo.old.Arablight      3.667           7.649                           3.890
SWRO.new.dummyf         -1              -1                              -1
SWROhyb.new.dummyf      -1              -1                              -1
BWRO.new.dummyf                                         -1

+                      adwe.uae        dewa.uae        sewa.uae        fewa.uae
StCo.old.methane       17.51           17.51           17.51           17.51
StCo.old.HFO           1.790           1.790           1.790           1.790
StCo.old.Arablight     3.890           3.890           3.890           3.890
SWRO.new.dummyf        -1              -1              -1              -1
SWROhyb.new.dummyf     -1              -1              -1              -1
BWRO.new.dummyf        -1              -1              -1              -1

+                      qatr.qat        kuwr.kuw        bahr.bah        omnr.omn
StCo.old.methane       17.51           17.51           17.51           17.51
StCo.old.HFO           1.790           1.790           1.790           1.790
StCo.old.Arablight     3.890           3.890           3.890           3.890
SWRO.new.dummyf        -1              -1              -1              -1
SWROhyb.new.dummyf     -1              -1              -1              -1
BWRO.new.dummyf        -1              -1              -1              -1
;

* for thermal desal only plants
* fuelburn = 2.139 MBTU/kg_St *1000 kg/m3 / boiler eff / GOR
WAfuelburn("MED",v,WAf,r,c)$(Fuelencon1(WAf)>0) =
  MBTUperkgst*rhoH2O/boilereff/GOR('MED')/Fuelencon1(WAf);

* for floating RO plant fuel burn = 0.220 MMtonne diesel/TWH * 5 TWH/Bm3
WAfuelburn("SWROfl",v,'diesel',r,c) =  0.220*WAelrate("SWRO",v);

WAfuelburn(WApFco,'new',WAf,r,c)$(Fuelencon1(WAf)>0) =
 (MBTUperkWH/WApeff(WApFco,'new'))/Fuelencon1(WAf);
* Heat rates for new fixed PWR cogen plants

* Heat rates for undefined old fixed PWR cogen plants
WAfuelburn("GTCo","old",WAf,r,c)$(Fuelencon1(WAf)>0) =
 (MBTUperkWH/WApeff("GTCo","old"))/Fuelencon1(WAf);
WAfuelburn("CCCoMED","old",WAf,r,c)$(Fuelencon1(WAf)>0) =
 (MBTUperkWH/WApeff("CCCoMED","old"))/Fuelencon1(WAf);
WAfuelburn("CCCoMSF","old",WAf,r,c)$(Fuelencon1(WAf)>0) =
 (MBTUperkWH/WApeff("CCCoMSF","old"))/Fuelencon1(WAf);
* uel efficeincy can vary with operation mode (m0 m1 ...)
* n this version fuel efficeincy is kept constant

Table WAVfuelburn(WApV,v,WAf,opm,r,c) Fuel burn MMBTu BBL tonne per MWH
                                west.ksa        sout.ksa        cent.ksa        east.ksa
StcoV.old.methane.(m1,m0)       {{21.270}}                                      17.44
StcoV.old.HFO.(m1,m0)           0.4815                                          1.7898
StcoV.old.Arablight.(m1,m0)     3.667

+                               adwe.uae        dewa.uae        sewa.uae        fewa.uae
StcoV.old.methane.(m1,m0)       17.44           17.44           17.44           17.44
StcoV.old.HFO.(m1,m0)           1.7             1.7             1.7             1.7
StcoV.old.Arablight.(m1,m0)     3.7             3.7             3.7             3.7

+                               qatr.qat        kuwr.kuw        bahr.bah        omnr.omn
StcoV.old.methane.(m1,m0)       17.44           17.44           17.44           17.44
StcoV.old.HFO.(m1,m0)           1.7             1.7             1.7             1.7
StcoV.old.Arablight.(m1,m0)     3.7             3.7             3.7             3.7
;

WAVfuelburn(WApV,'new',WAf,opm,r,c)$(Fuelencon1(WAf)>0)=
(MBTUperKWH/WApVeff(WApV,'new',opm))/Fuelencon1(WAf);
WAVfuelburn("GTCOV","old",WAf,opm,r,c)$(Fuelencon1(WAf)>0)=
(MBTUperKWH/WApVeff("GTCOV","old",opm))/Fuelencon1(WAf);
WAVfuelburn("CCCOVMED","old",WAf,opm,r,c)$(Fuelencon1(WAf)>0)=
(MBTUperKWH/WApVeff("CCCOVMED","old",opm))/Fuelencon1(WAf);
WAVfuelburn("CCCOVMSF","old",WAf,opm,r,c)$(Fuelencon1(WAf)>0)=
(MBTUperKWH/WApVeff("CCCOVMSF","old",opm))/Fuelencon1(WAf);

Parameter WAgrfuelburn(WAf,r,c);
WAgrfuelburn('dummyf',r,c) = -1;

WAVpwrincr(WApV,v,opm) = 1 ;

Parameter WAcapital(WAp)    Current capital needed for new plants in MMUSD per GW or MMm3perday
/
MED             1200
MSF             1700
SWROfl          2200
SWRO            1600
SWROhyb         1550
BWRO             315
PVhybWA         2500
/;

WAcapital(STCo) = 2130;
* don't build the other RO types:
WAcapital('BWRO') = 9e9;
WAcapital('PVhybWA') = 9e9;
WAcapital('SWROhyb') = 9e9;
WAcapital('SWROfl') = 9e9;
WAcapital('SWRO') = 1000;

* the new estimates below align with IWPP project estimates for cogen plants
WAcapital(GTCo) =  1485;
WAcapital(CCCo) =  1740;

* Redefining capital costs of conventional thermal plants from 2010 USD/kW to 2014 USD/kW:
* Using the Saudi Imports price deflators for 2014 and 2010 from Oxford Economics Model:
WAcapital(WApCO) = WAcapital(WApCO)*140.1375/129.1254;

Parameter WAredcost(WApCO) What is this parameter?;
WAredcost(WApCO) = 0.75;

WAcapital(WApV) = WAcapital(WApV)*WAVpwrincr(WApV,"new","m0");
* Include WAVpwrincr to include additional capital ost of building
* a trubine with higher peak power when water plant is turned off.
* This has been set to 1, assuming that the turbine produces the same
* output with higher efficiency. (see WApVeff)

* Reduced cost of desal plant in cogen project
WAcapital(WApCO)=  WAcapital('MSF')/PWR2(WApCO)*WAredcost(WapCO)
                   +WAcapital(WApCo);

WAcapital('CCcoVMED')=  WAcapital('MED')/PWR2('CCcoVMED')*WAredcost('CCcoVMED')
                        +WAcapital('CCcoVMED');
* use capital cost of MED plant for cogen plants (Juabil cogen)
WAcapital('CCCoMED')=  WAcapital('MED')/PWR2('CCCoMED')*WAredcost('CCcoMED')
                       +WAcapital('CCCoMED');

parameters
WApurcst(WAp,time,r,c) Equipment cost in MMUSD per MMm3 per day or GW
*WAconstcst(WAp,time,r,c) Construction cost in MMUSD per MMm3 per day or GW
;
WApurcst(WAp,time,r,c) = 1*WAcapital(WAp);
*WAconstcst(WAp,time,r,c) = 0.2*WAcapital(WAp);

* Variable O&M are the minimum consumable costs sourced from a
* masters project by John Frederick Thye at Yale School of Forestry and Environmental Studies
* Note: For SWRO these were in line with reported value for a 40000 m3/day plant by
* Nicholav Voutchkov from the Middle East Desalination Center
table WAomcst(WAp,r,c) Variable O&M cost for desal capacity USD per Mm3
          (west,sout,east).ksa        cent.ksa
SWROfl     125
SWRO       100
SWROhyb    80
BWRO                                  50
MED        80

+          adwe.uae        dewa.uae        sewa.uae        fewa.uae
SWROfl     125             125             125             125
SWRO       100             100             100             100
SWROhyb    80              80              80              80
BWRO       50              50              50              50
MED        80              80              80              80

+          qatr.qat        kuwr.kuw        bahr.bah        omnr.omn
SWROfl     125             125             125             125
SWRO       100             100             100             100
SWROhyb    80              80              80              80
BWRO       50              50              50              50
MED        80              80              80              80
;

WAomcst(WApco,r,c) = 50;                {{OM large scale MSF}}
WAomcst("CCCoMED",r,c) = 80;            {{OM large scale MED}}
WAomcst("CCcoVMED",r,c) = 80;           {{OM large scale MED}}

table WAELomcst(WAp,r,c) Variable O&M cost for cogen power plant USD per MWH

          (west,sout,east).ksa        cent.ksa
Stco      3.42                        9
GTco      3.42                        9
StCoV     3.42                        9
GTCoV     3.42                        9
$ontext
          (west,sout,east).ksa        cent.ksa
Stco      1.640                       9
GTco      4.0                         9
StCoV     1.640                       9
GTCoV     4.000                       9
$offtext
+         adwe.uae        dewa.uae        sewa.uae        fewa.uae
Stco      1.640           1.640           1.640           1.640
GTco      4               4               4               4
StCoV     1.64            1.64            1.64            1.64
GTCoV     4               4               4               4

+         qatr.qat        kuwr.kuw        bahr.bah        omnr.omn
Stco      1.640           1.640           1.640           1.640
GTco      4               4               4               4
StCoV     1.64            1.64            1.64            1.64
GTCoV     4               4               4               4
;

WAELomcst(CCCo,r,c)= 3.3;

*Redefining fixed and variable OM costs of conventional thermal plants from 2010 USD/kW to 2014 USD/kW:
*Using the Saudi CPI for 2014 and 2010 from Oxford Economics Model:
WAELomcst(WAp,r,c)=WAELomcst(WAp,r,c)*130.7622/119.0000

* Fixed OM costs are taken from JF Thye's master project sourced from
* derived from data presented in NRC, 2008
parameter WAfixedOMcst(WAp,time,c) Fixed O&M costs  USD per m3 per day;
WAfixedOMcst('SWRO',time,c)= 48;
WAfixedOMcst('SWROhyb',time,c)= 48;
WAfixedOMcst('SWROfl',time,c)= 55;
* SWRO barge includes fixed OM of operating diesel generator  (estimated at 20 USD/KW)
* 20 USD/KW * 5 KWh/mm3 *1day/24 hr ~ 4 USD/m3/day

WAfixedOMcst('MED',time,c)= 33;
WAfixedOMcst('MSF',time,c)= 33;

WAfixedOMcst("SWROhyb",time,c) = WAfixedOMcst("SWRO",time,c)*0.8;
WAOMcst("SWROhyb",r,c) = WAOMcst("SWRO",r,c)*0.8;

*        Values sourced from ECRA report (se power submodel) for current single purpose power plants in Kingdom
*SP: Replace '99' by corresponding GCC data
Table WAELfixedOMcst(WAp,c) Fixed O&M costs USD per KW
        ksa       uae       qat        kuw        bah        omn
Stco    17.2      11.2      11.2       11.2       11.2       11.2
GTco    17.2      11.2      11.2       11.2       11.2       11.2
StcoV   17.2      11.2      11.2       11.2       11.2       11.2
GTcoV   17.2      11.2      11.2       11.2       11.2       11.2
PVhybWA 30        30        30         30         30         30
;

WAELfixedOMcst(WApCo,c)  = 12.4;
*Redefining fixed and variable OM costs of conventional thermal plants from 2010 USD/kW to 2014 USD/kW:
*Using the Saudi CPI for 2014 and 2010 from Oxford Economics Model:
WAELfixedOMcst(WApCo,c) = WAELfixedOMcst(WApCo,c)*130.7622/119.0000;
WAfixedOMcst(WApco,time,c) = 33;
*        Fixed OM for MSF and MED plantse

WAfixedOMcst(WApCO,time,c) = WAELfixedOMcst(WApCO,c) +WAfixedOMcst(WApCO,time,c)/PWR2(WApCO);
WAfixedOMcst(WAprn,time,c) = WAELfixedOMcst(WAprn,c);
*        Sum fixed OM cost of cogen water and power plants and convert desal plant to USD/KW using PWR2 ratio

parameter WAgromcst(r,c)
/
(east,sout,cent,west).ksa       0
(adwe,dewa,sewa,fewa).uae       0
qatr.qat                        0
kuwr.kuw                        0
bahr.bah                        0
omnr.omn                        0
/;

parameter WAgrtransomcst(r,c)
/
(east,sout,cent,west).ksa       0
(adwe,dewa,sewa,fewa).uae       0
qatr.qat                        0
kuwr.kuw                        0
bahr.bah                        0
omnr.omn                        0
/;

table WAtransyield(r,c,rr,cc) mainline transmission losses
          west.ksa   sout.ksa  cent.ksa  east.ksa
west.ksa  .98
sout.ksa            .98
cent.ksa                      .98
east.ksa                      .95       .98
adwe.uae
dewa.uae
sewa.uae
fewa.uae
qatr.qat
kuwr.kuw
bahr.bah
omnr.omn

+         adwe.uae   dewa.uae  sewa.uae  fewa.uae
west.ksa
sout.ksa
cent.ksa
east.ksa
adwe.uae  1
dewa.uae             1
sewa.uae                       1
fewa.uae                                 1
qatr.qat
kuwr.kuw
bahr.bah
omnr.omn

+         qatr.qat   kuwr.kuw  bahr.bah  omnr.omn
west.ksa
sout.ksa
cent.ksa
east.ksa
adwe.uae
dewa.uae
sewa.uae
fewa.uae
qatr.qat  1
kuwr.kuw             1
bahr.bah                        1
omnr.omn                                  1
;

Parameter WAtransyieldmu(r,c) municipal transmission losses;
*SP: Replace with corresponding data or expand by region-country if needed.
WAtransyieldmu(r,c) = 0.85;
;

*SP: Question - Check my modification on the following line. But do not we have to divide instead of multiply?
WAdemval(time,r,c) = WAdemval(time,r,c)*WAtransyieldmu(r,c);

table WAtransexist(r,c,rr,cc)    existing transmission capacity in MMm3 per day
          west.ksa  sout.ksa   cent.ksa   east.ksa
west.ksa  1e3
sout.ksa            1e3
cent.ksa                       1e3
east.ksa                       1e3        1e3
adwe.uae
dewa.uae
sewa.uae
fewa.uae
qatr.qat
kuwr.kuw
bahr.bah
omnr.omn

+         adwe.uae  dewa.uae   sewa.uae   fewa.uae
west.ksa
sout.ksa
cent.ksa
east.ksa
adwe.uae  1e3
dewa.uae            1e3
sewa.uae                       1e3
fewa.uae                                  1e3
qatr.qat
kuwr.kuw
bahr.bah
omnr.omn

+         qatr.qat  kuwr.kuw   bahr.bah   omnr.omn
west.ksa
sout.ksa
cent.ksa
east.ksa
adwe.uae
dewa.uae
sewa.uae
fewa.uae
qatr.qat  1e3
kuwr.kuw            1e3
bahr.bah                        1e3
omnr.omn                                  1e3
;

WAtransexist(r,c,rr,cc)$(rc(r,c) and rc(rr,cc)) = WAtransexist(r,c,rr,cc)$(rc(r,c) and rc(rr,cc))/365;

parameter WAtranscapital(time,r,c,rr,cc) capital cost of trans in USD per m3 per day;
WAtranscapital(time,r,c,rr,cc)=0;
WAtranscapital(time,r,c,rr,cc)$(rc(r,c) and rc(rr,cc) and sameas(c,cc) )=1;

parameter
WAtranspurcst(time,r,c,rr,cc) purch cost of trans cap USD per m3;
WAtranspurcst(time,r,c,rr,cc)$(rc(r,c) and rc(rr,cc)) = WAtranscapital(time,r,c,rr,cc)*0.25;

parameter WAtransomcst(r,c,rr,cc) O&M cost of transmission capacity USD per Mm3;
WAtransomcst(r,c,rr,cc)=0;
WAtransomcst(r,c,rr,cc)$(rc(r,c) and rc(rr,cc) and sameas(c,cc) )=299;

parameter WAtransleadtime(r,c,rr,cc)  lead time for building transmission cap;
WAtransleadtime(r,c,rr,cc)=0;
WAtransleadtime(r,c,rr,cc)$(rc(r,c) and rc(rr,cc) and sameas(c,cc) )=0;

parameter WAtranslifetime(r,c,rr,cc)  lead time for building transmission cap;
WAtransleadtime(r,c,rr,cc)=0;
WAtransleadtime(r,c,rr,cc)$(rc(r,c) and rc(rr,cc) and sameas(c,cc) )=0;

Parameter
WAlifetime(WAp) Lifetime of plant in units of years
/
MED        30
MSF        30
SWROfl     25
SWRO       25
BWRO       25
Stco       30
GTco       30
CCCoMED    30
CCCoMSF    30
StcoV      30
GTcoV      30
CCcoVMED   30
CCcoVMSF   30
SWROhyb    30
PVhybWA    25
/

WAleadtime(WAp) Lead time for plant construction units of time
/
MED      0
MSF      0
SWROfl   1
SWRO     0
BWRO     1
Stco     2
GTco     2
CCCoMED  2
CCCoMSF  2
StcoV    2
GTcoV    2
CCcoVMED 2
CCcoVMSF 2
SWROhyb  2
PVhybWA  1
/
;

Parameters
WAretirement(WAp,v,time,r,c) capacity to be retired
WAaddition(WAp,v,time,r,c) already-planned capacity addition;

*WAretirement(WAp,v,time,r,c)$rc(r,c)=0;
*WAaddition(WAp,v,time,r,c)$rc(r,c)=0;
;

parameter WAstoexist(r,c) Existing pipeline water storage capacity in million m3
/
west.ksa  3.664
sout.ksa  2.60
cent.ksa  4.160
east.ksa  1.162
adwe.uae  1.5
dewa.uae  1.5
sewa.uae  1.5
fewa.uae  1.5
qatr.qat  1000
kuwr.kuw  1.5
bahr.bah  1.5
omnr.omn  1.5
/
;

parameter WAstocapital(rr,cc) storage capital cost in MMUSD- million m3;
WAstocapital(rr,cc) = 540/3.75/1.5;

parameter
WAstopurcst(time,rr,cc)
WAstoconstcst(time,rr,cc);

WAstopurcst(time,rr,cc)$rc(rr,cc) = WAstocapital(rr,cc)*0.8;
WAstoconstcst(time,rr,cc)$rc(rr,cc) = WAstocapital(rr,cc)*0.2;

Parameter WAstoomcst(rr,cc)
/
west.ksa  0
sout.ksa  0
cent.ksa  0
east.ksa  0
adwe.uae  0
dewa.uae  0
sewa.uae  0
fewa.uae  0
qatr.qat  0
kuwr.kuw  0
bahr.bah  0
omnr.omn  0
/
;

scalar
WAstolifetime    liftime storage /35/
WAstoleadtime    leadtime storage /0/
;

WAVfuelburn(WApV,v,WAf,opm,"cent",'ksa') = 0;
WAfuelburn(WApnoBWRO,v,WAf,"cent",'ksa') = 0;


* variable fixes and bounds
WAexistcp.fx(WAp,v,'t01',r,c)$rc(r,c)= WAexist(WAp,v,r,c);
WAtransexistcp.fx('t01',r,c,rr,cc)$(rc(r,c) and rc(rr,cc))= WAtransexist(r,c,rr,cc);
WAgr.fx(WAf,trun,r,c)$rc(r,c)=0;
WAstoexistcp.fx('t01',r,c)$rc(r,c) = WAstoexist(r,c);
WAsolop.up(WAprn,v,ELl,ELs,ELday,trun,r,c)$rc(r,c)=0;
WAbld.up('BWRO','new',trun,r,c)=0;
*WAstoop.up(ELl,ELs,ELday,trun,rr,cc)=0;

*WAfconsump.up('HFO',trun,r,c)=WAfconsumpmax('HFO','t01',r,c);
*WAfconsump.up('diesel',trun,r,c)=WAfconsumpmax('diesel','t01',r,c);

Equations

WAobjective               minimizing cost
WApurchbal(trun)        accumulates all import purchases
WAopmaintbal(trun)      accumulates operations and maintenance costs

WAfcons(WAf,trun,r,c)     regionalized fuel consumption for WAp in MMBTU BBL and Tonne
WAfavail(WAf,trun,r,c)    Fuel use constraint
*  WAfavail(WAf,trun)    Fuel use constraint
WAfavailcr(WAf,trun,r,c)  Fuel use constraint

WAELsup(ELl,ELs,ELday,trun,r,c)     electricity supplied by WAp in TWH
WAELcons(ELl,ELs,ELday,trun,r,c)    electricity consumption by WAp in TWH
WAROconslimsol(WApRO,ELl,ELs,ELday,trun,r,c)  limit on solar electricity produced for RO plants
WAELsol(ELl,ELs,ELday,trun,r,c)   electricity supply to reverse osmosis plants

WAELrsrvreq(trun,r,c)      Cogen contribution to electricity reserve in GW
WAELpwrdem(trun,r,c)       Water plants electricity demand calculated in GW

WAcapbal(WAp,v,trun,r,c)     water capacity balance constraint
WAFcaplim(WApF,v,trun,r,c)     water capacity constraint fixed PWR
WAVcaplim(WApV,v,ELl,ELs,ELday,trun,r,c)     water capacity constraint variable PWR
WAcaplim(WApsingle,v,ELl,ELs,ELday,trun,r,c)    water capacity constraint for hybrid   (disp power + SWRO)
WAsolcaplim(WAprn,v,ELl,ELs,ELday,trun,r,c)    water capacity constraint for hybrid solar power plants
* WAGTCoVratio(v,WAl,trun,r)

WAhybratio(trun,r,c)
WAsup(ELl,ELs,ELday,trun,r,c)              water supply in MMm3
WAdem(ELl,ELs,ELday,trun,r,c)              water demand in MMm3
WAtranscapbal(trun,r,c,rr,cc)   water transport capacity balance constraint
WAtranscaplim(Ell,Els,ELday,trun,r,c,rr,cc)   water transport capacity contraint
WAstocaplim(ELl,ELs,ELday,trun,rr,cc)        water storage caapcity limit
WAstocapbal(trun,rr,cc)        water storage capcity balance
WAgrcaplim(trun,r,c)            capacity limit of groundwater supply

DWAcapitalcost(trun)
DWAOpandmaint(trun)
DWAbld(WAp,v,trun,r,c)
DWAexistcp(WAp,v,trun,r,c)
DWAFop(WApF,v,WAf,trun,r,c)
DWAVop(WApV,v,ELl,ELs,ELday,WAf,opm,trun,r,c)
DWAop(WApsingle,v,ELl,ELs,ELday,WAf,trun,r,c)
DWAsolop(WAprn,v,ELl,ELs,ELday,trun,r,c)
DWAtrans(ELl,ELs,ELday,trun,r,c,rr,cc)
DWAtransbld(trun,r,c,rr,cc)
DWAtransexistcp(trun,r,c,rr,cc)
DWAELsupply(ELl,ELs,ELday,trun,r,c)
DWAELconsump(ELl,ELs,ELday,trun,r,c)
DWAelconsumpsol(WApRO,ELl,ELs,ELday,trun,r,c)
DWAELpwrdemand(trun,r,c)
DWAELrsrvcontr(trun,r,c)
DWAfconsump(f,trun,r,c)
DWAfconsumpcr(f,trun,r,c)
DWAstoexistcp(trun,r,c)
DWAstobld(trun,r,c)
DWAstoop(ELl,ELs,ELday,trun,rr,cc)
DWAgr(WAf,trun,r,c)
DWAgrexistcp(trun,r,c)
;

$offorder

* =======
*Objective equation for water activities
WAobjective.. WAz =e= sum(t,(WAcapitalcost(t)+WAOpandmaint(t))*WAdiscfact(t) )
*+ sum((ELl,ELs,ELday,t,r,c)$rc(r,c), WAELconsump(ELl,ELs,Elday,t,r,c)*DELsup(ELl,ELs,ELday,t,r,c)*WAdiscfact(t) )
+ sum((WAf,t,r,c)$rc(r,c),WAAPf(WAf,t,r,c)*WAfconsump(WAf,t,r,c)*WAdiscfact(t) )
*- sum((ELl,ELs,ELday,t,r,c)$rc(r,c), WAELsupply(ELl,ELs,ELday,t,r,c)*ELAPelwa(ELl,ELs,ELday,t,r,c)*WAdiscfact(t) )
;
* =======

WApurchbal(t)..
  sum((WAP,v,r,c)$(rc(r,c) and vn(v)), WApurcst(WAp,t,r,c)*WAbld(WAp,v,t,r,c))
 +sum((r,c,rr,cc)$(rc(r,c) and rc(rr,cc)), WAtranspurcst(t,r,c,rr,cc)*WAtransbld(t,r,c,rr,cc))
 +sum((rr,cc)$rc(rr,cc),WAstopurcst(t,rr,cc)*WAstobld(t,rr,cc))
 -WAcapitalcost(t) =e=0;

WAopmaintbal(t)..
  sum((WApF,v,WAf,r,c)$(rc(r,c) and WAfuelburn(WApF,v,WAf,r,c)<>0),
   (WAELomcst(WApF,r,c)+WAomcst(WApF,r,c)*WAyield(WApF,v,r,c))*WAFop(WApF,v,WAf,t,r,c))
 +sum((WApV,v,ELl,ELs,ELday,WAf,opm,r,c)$(rc(r,c) and WAVfuelburn(WApV,v,WAf,opm,r,c)>0),
   (WAELomcst(WApV,r,c)+WAomcst(WApV,r,c)*WAVyield(WApV,v,opm,r,c))*WAVop(WApV,v,ELl,Els,ELday,WAf,opm,t,r,c))

 +sum((WApF,v,WAf,r,c)$(fMPt(WAf,c) and rc(r,c) and WAfuelburn(WApF,v,WAf,r,c)<>0),
   (WAELomcst(WApF,r,c)+WAomcst(WApF,r,c)*WAyield(WApF,v,r,c))*WAFop_trade(WApF,v,WAf,t,r,c))
 +sum((WApV,v,ELl,ELs,ELday,WAf,opm,r,c)$(fMPt(WAf,c) and rc(r,c) and WAVfuelburn(WApV,v,WAf,opm,r,c)>0),
   (WAELomcst(WApV,r,c)+WAomcst(WApV,r,c)*WAVyield(WApV,v,opm,r,c))*WAVop_trade(WApV,v,ELl,Els,ELday,WAf,opm,t,r,c))

 +sum((WAp,v,r,c)$rc(r,c),WAfixedOMcst(WAp,t,c)*(WAbld(WAp,v,t,r,c)$vn(v)+WAexistcp(WAp,v,t,r,c)) )
 +sum((ELl,ELs,ELday,r,c,rr,cc)$(rc(r,c) and rc(rr,cc)),WAtransomcst(r,c,rr,cc)*WAtrans(ELl,ELs,ELday,t,r,c,rr,cc))
* +sum((WApsingle,v,ELl,Els,ELday,WAf,r)$(WAfuelburn(WApsingle,v,WAf,r)<>0),
*   WAomcst(WApsingle,r)*WAop(WApsingle,v,ELl,ELs,ELday,WAf,t,r))
 +sum((WAprn,v,ELl,ELs,ELday,r,c)$rc(r,c), WAELomcst(WAprn,r,c)*WAsolop(WAprn,v,ELl,ELs,Elday,t,r,c))
 +sum((ELl,ELs,ELday,rr,cc)$rc(rr,cc),WAstoomcst(rr,cc)*WAstoop(ELl,ELs,ELday,t,rr,cc))
*+ sum((WAf,r)$(WAgrfuelburn(WAf,r)<>0),(WAgromcst(r)+WAgrtransomcst(r))*WAgr(WAf,t,r))
 -WAOpandmaint(t) =e=0 ;

WAcapbal(WAp,v,t,r,c)$rc(r,c)..
  WAexistcp(WAp,v,t,r,c)
 +WAaddition(WAp,v,t+1,r,c)$(card(t)>1)
 -WAretirement(WAp,v,t+1,r,c)$(card(t)>1)
 +WAbld(WAp,v,t,r,c)$(vn(v) and t_ind(t) > WAleadtime(WAp))
 -WAexistcp(WAp,v,t+1,r,c) =g=0;

* Capacity limit for fixed cogen plants
WAFcaplim(WApF,v,t,r,c)$rc(r,c)..
  (WAexistcp(WApF,v,t,r,c)+WAbld(WApF,v,t,r,c)$(vn(v) and t_ind(t) > WAleadtime(WApF)) )
  *WAFoptime(WApF,v)
 -sum(WAf$(WAfuelburn(WApF,v,WAf,r,c)<>0),WAFop(WApF,v,WAf,t,r,c))
 -sum(WAf$(WAfuelburn(WApF,v,WAf,r,c)<>0 and fMPt(WAf,c)),WAFop_trade(WApF,v,WAf,t,r,c))
=g=0;

* Capacity limit for variable cogen plants with two operation modes (opm)
* Divide WAVop by relative power increase when operating at m0 (no water)
WAVcaplim(WApV,v,ELl,ELs,ELday,t,r,c)$rc(r,c)..
  (WAexistcp(WApV,v,t,r,c) + WAbld(WApV,v,t,r,c)$(vn(v) and t_ind(t) > WAleadtime(WApV)) )
          *WAVoptime(WApV,v,ELl,ELs,ELday,c)
- sum((WAf,opm)$(WAVfuelburn(WApV,v,WAf,opm,r,c)>0),
         WAVop(WApV,v,ELl,ELs,ELday,WAf,opm,t,r,c)/WAVpwrincr(WApV,v,opm))
- sum((WAf,opm)$(WAVfuelburn(WApV,v,WAf,opm,r,c)>0 and fMPt(WAf,c)),
         WAVop_trade(WApV,v,ELl,ELs,ELday,WAf,opm,t,r,c)/WAVpwrincr(WApV,v,opm))

=g= 0;

WAhybratio(t,r,c)$(rc(r,c) and rsea(r,c))..
+ sum((WApFco,v,WAf)$(WAfuelburn(WApFco,v,WAf,r,c)<>0),
         WAFop(WApFco,v,WAf,t,r,c)*WAyield(WApFco,v,r,c))
+ sum((WApV,v,ELl,ELs,ELday,WAf,opm)$(WAVfuelburn(WApV,v,WAf,opm,r,c)>0),
         WAVop(WApV,v,ELl,ELs,ELday,WAf,opm,t,r,c)*WAVyield(WApV,v,opm,r,c))
-hybratio*sum((SWROhyb,v,WAf)$(WAfuelburn(SWROhyb,v,WAf,r,c)<>0),WAFop(SWROhyb,v,WAf,t,r,c))

+ sum((WApFco,v,WAf)$(WAfuelburn(WApFco,v,WAf,r,c)<>0 and fMPt(WAf,c)),
         WAFop_trade(WApFco,v,WAf,t,r,c)*WAyield(WApFco,v,r,c))
+ sum((WApV,v,ELl,ELs,ELday,WAf,opm)$(WAVfuelburn(WApV,v,WAf,opm,r,c)>0 and fMPt(WAf,c)),
         WAVop_trade(WApV,v,ELl,ELs,ELday,WAf,opm,t,r,c)*WAVyield(WApV,v,opm,r,c))
-hybratio*sum((SWROhyb,v,WAf)$(WAfuelburn(SWROhyb,v,WAf,r,c)<>0 and fMPt(WAf,c)),WAFop_trade(SWROhyb,v,WAf,t,r,c))

=g=0;

WAsolcaplim(WAprn,v,ELl,ELs,Elday,t,r,c)$rc(r,c)..
  (WAexistcp(WAprn,v,t,r,c)+WAbld(WAprn,v,t,r,c)$(vn(v) and t_ind(t) > WAleadtime(WAprn)) )*
                 ELsolcurvenorm(ELl,ELs,r,c)*ELlchours(ELl,c)*ELdaysinseason(ELs,ELday)
         -WAsolop(WAprn,v,ELl,ELs,ELday,t,r,c)
                         =g= 0;

WAstocapbal(t,rr,cc)$rc(rr,cc)..   WAstoexistcp(t,rr,cc)
+ WAstobld(t-WAstoleadtime,rr,cc)
- WAstoexistcp(t+1,rr,cc) =g= 0;

WAstocaplim(ELl,ELs,ELday,t,rr,cc)$rc(rr,cc)..  -WAstoop(ELl,ELs,ELday,t,rr,cc)
                         +(WAstoexistcp(t,rr,cc)+ WAstobld(t-WAstoleadtime,rr,cc))*ELdaysinseason(ELs,ELday) =g= 0;

*WAgracpabl(t,r).. capacity balance for ground water wells ...?

WAgrcaplim(t,r,c)$rc(r,c)..
         WAgrexistcp(t,r,c)-sum(WAf$(WAgrfuelburn(WAf,r,c)<>0),WAgr(WAf,t,r,c)) =g= 0;

WAdem(ELl,ELs,ELday,t,rr,cc)$rc(rr,cc)..
         sum((r,c)$rc(r,c),(WAtrans(ELl,ELs,ELday,t,r,c,rr,cc)*WAtransyield(r,c,rr,cc)))
                 -WAstoop(ELl,ELs,ELday,t,rr,cc)
         +WAstoop(ELl-1,ELs,ELday,t,rr,cc)$(ord(ELl)<>1)
         +WAstoop(ELl-(1+card(ELl)),ELs,ELday,t,rr,cc)$(ord(ELl)=1)
*        add in the ground water into demand (exclude from transportation cost for desal)
*+ sum(WAf$(WAgrfuelburn(WAf,rr)<>0),WAgr(WAf,t,rr))*ELnormhours(ELl,ELs,ELday)
                         =g= (WAdemval(t,rr,cc)+WAgrdem(t,rr,cc))*WAlc(ELl,ELs,ELday,cc)
*
;

WAsup(ELl,ELs,ELday,t,r,c)$rc(r,c)..
* for domestic consumption
  sum((WApF,v,WAf)$(WAfuelburn(WApF,v,WAf,r,c)<>0),
         WAFop(WApF,v,WAf,t,r,c)*WAyield(WApF,v,r,c)*ELnormhours(ELl,ELs,ELday,c) )
+ sum((WApV,v,WAf,opm)$(WAVfuelburn(WApV,v,WAf,opm,r,c)>0),
         WAVop(WApV,v,ELl,ELs,ELday,WAf,opm,t,r,c)*WAVyield(WApV,v,opm,r,c))

* trade activity also produces water
 +sum((WApF,v,WAf)$(WAfuelburn(WApF,v,WAf,r,c)<>0 and fMPt(WAf,c)),
         WAFop_trade(WApF,v,WAf,t,r,c)*WAyield(WApF,v,r,c)*ELnormhours(ELl,ELs,ELday,c) )
+ sum((WApV,v,WAf,opm)$(WAVfuelburn(WApV,v,WAf,opm,r,c)>0 and fMPt(WAf,c)),
         WAVop_trade(WApV,v,ELl,ELs,ELday,WAf,opm,t,r,c)*WAVyield(WApV,v,opm,r,c))
 -sum((rr,cc)$rc(rr,cc),WAtrans(ELl,ELs,ELday,t,r,c,rr,cc))
=g=0
;



WAtranscapbal(t,r,c,rr,cc)$(rc(r,c) and rc(rr,cc))..  WAtransexistcp(t,r,c,rr,cc)
+ WAtransbld(t-WAtransleadtime(r,c,rr,cc),r,c,rr,cc)
                 -WAtransexistcp(t+1,r,c,rr,cc)=g=0;

WAtranscaplim(Ell,Els,Elday,t,r,c,rr,cc)$(rc(r,c) and rc(rr,cc)).. (WAtransexistcp(t,r,c,rr,cc)
+ WAtransbld(t-WAtransleadtime(r,c,rr,cc),r,c,rr,cc))*ELdaysinseason(ELs,ELday)*ELlcnorm(ELl,c)
         - WAtrans(ELl,ELs,ELday,t,r,c,rr,cc)
                         =g= 0;
*$(WAtransyield(r,rr)>0)

*ELECTRCITY EQUATIONS FOR WATER PLANTS
*$ontext

WAELsup(ELl,ELs,ELday,t,r,c)$rc(r,c)..
* for domestic consumption
  sum((WApF,v,WAf)$(WAfuelburn(WApF,v,WAf,r,c)>0),
         WAFop(WApF,v,WAf,t,r,c)*(1-WAyield(WApF,v,r,c)*WAelrate(WApF,v))*ELnormhours(ELl,ELs,ELday,c))
+ sum((WApV,v,WAf,opm)$(WAVfuelburn(WApV,v,WAf,opm,r,c)>0),
         WAVop(WApV,v,ELl,ELs,ELday,WAf,opm,t,r,c)*(1-WAVyield(WApV,v,opm,r,c)*WAelrate(WApV,v)))
* for trade consumption
 +sum((WApF,v,WAf)$(WAfuelburn(WApF,v,WAf,r,c)>0 and fMPt(WAf,c)),
         WAFop_trade(WApF,v,WAf,t,r,c)*(1-WAyield(WApF,v,r,c)*WAelrate(WApF,v))*ELnormhours(ELl,ELs,ELday,c))
+ sum((WApV,v,WAf,opm)$(WAVfuelburn(WApV,v,WAf,opm,r,c)>0 and fMPt(WAf,c)),
         WAVop_trade(WApV,v,ELl,ELs,ELday,WAf,opm,t,r,c)*(1-WAVyield(WApV,v,opm,r,c)*WAelrate(WApV,v)))
- WAELsupply(ELl,ELs,ELday,t,r,c) =g= 0 ;

WAELcons(ELl,ELs,ELday,t,r,c)$rc(r,c)..
  WAELconsump(ELl,ELs,ELday,t,r,c)
- sum((WApsat,v,WAf)$(WAfuelburn(WApsat,v,WAf,r,c)<0),
         WAFop(wapsat,v,WAf,t,r,c)*WAelrate(WApsat,v))*ELnormhours(ELl,ELs,ELday,c)
- sum((WApsat,v,WAf)$(WAfuelburn(WApsat,v,WAf,r,c)<0 and fMPt(WAf,c)),
         WAFop_trade(wapsat,v,WAf,t,r,c)*WAelrate(WApsat,v))*ELnormhours(ELl,ELs,ELday,c)
=g=0;
*$ontext
WAELsol(ELl,ELs,ELday,t,r,c)$rc(r,c)..
         + sum((WAprn,v), WAsolop(WAprn,v,ELl,ELs,ELday,t,r,c))
*         -sum(WApRO,WAelconsumpsol(WApRO,ELl,ELs,ELday,t,r))
                 =g= 0;
*$offtext

WAROconslimsol(WApRO,ELl,ELs,ELday,t,r,c)$rc(r,c)..
        sum((v,WAf)$(WAfuelburn(WApRO,v,WAf,r,c)<0),
                 WAop(WApRO,v,ELl,Els,ELday,WAf,t,r,c)*WAelrate(WApRO,v))
- WAelconsumpsol(WApRO,ELl,ELs,ELday,t,r,c)
         =g= 0 ;

*$ontext
WAELrsrvreq(t,r,c)$rc(r,c)..
  sum((WApCo,v),WAexistcp(WApCo,v,t,r,c)+WAbld(WApCo,v,t,r,c)$(vn(v)and t_ind(t) > WAleadtime(WApCO)) )
         -WAELrsrvcontr(t,r,c) =e= 0   ;
*$offtext

WAELpwrdem(t,rr,cc)$rc(rr,cc)..  WAELpwrdemand(t,rr,cc)
-sum((ELl,ELs,Elday)$(   ord(ELl)=ELlmax(rr,cc) and ord(ELs)=ELsmax(rr,cc) and
                         ord(ELday)=ELdaymax(rr,cc)),
WAELconsump(ELl,ELs,ELday,t,rr,cc)/(ELlchours(ELl,cc)*ELdaysinseason(ELs,ELday)))
                  =e=  0;

WAfcons(WAf,t,r,c)$rc(r,c).. WAfconsump(WAf,t,r,c)
- sum((WApF,v)$(WAfuelburn(WApF,v,WAf,r,c)>0),
         WAfuelburn(WApF,v,WAf,r,c)*WAFop(WApF,v,WAf,t,r,c))
- sum((WApV,v,ELl,ELs,ELday,opm)$(WAVfuelburn(WApV,v,WAf,opm,r,c)>0),
         WAVfuelburn(WApV,v,WAf,opm,r,c)*WAVop(WApV,v,ELl,ELs,ELday,WAf,opm,t,r,c))
*- sum((WApsingle,v,ELl,ELs,ELday)$(WAfuelburn(WApsingle,v,WAf,r)>0),
*         WAfuelburn(WApsingle,v,WAf,r)*WAop(WApsingle,v,ELl,ELs,ELday,WAf,t,r))
*- WAgr(WAf,t,r)*WAgrfuelburn(WAf,r)$(WAgrfuelburn(WAf,r)>0)
     =g=0    ;

WAfavail(WAf,t,r,c)$(rc(r,c) and (WAfAP(WAf,c) or WAfref(WAf)))..
-WAfconsump(WAf,t,r,c)
*-WAfconsump_trade(WAf,t,r,c)$fMPt(Waf,c)

=g=
-WAfconsumpmax(WAf,t,r,c);


WAfavailcr(WAf,t,r,c)$rc(r,c)..
         -WAfconsumpcr(WAf,t,r,c) + WAfconsump(WAf,t,r,c) =g= 0 ;
*$ontext
*dual relationships
DWAcapitalcost(t)..  1*WAdiscfact(t)=g=-DWApurchbal(t);
DWAOpandmaint(t)..  1*WAdiscfact(t) =g=-DWAopmaintbal(t);

DWAfconsump(WAf,t,r,c)$rc(r,c)..
* using deregulated fuel prices
 ( (Dfdem(WAf,t,r,c)*WAdiscfact(t))$WAfup(WAf)
* +(DRFdem(WAf,t,r,c)*WAdiscfact(t)*(1-subsidy(t)$(partialdereg=1)))$WAfref(WAf)
  +RFintlprice(WAf,t)$WAfref(WAf)
  )$(WAfMP(WAf,c))
* using administered fuel prices
 +( WAAPf(WAf,t,r,c)*WAdiscfact(t))$(WAfAP(WAf,c))
 =g= DWAfcons(WAf,t,r,c)
    -DWAfavail(WAf,t,r,c)$(WAfAP(WAf,c) or WAfref(WAf))
    +DWAfavailcr(WAf,t,r,c)
  -sum((ksec,EMcp)$WAsect(ksec),EMfactors(ksec,WAf,EMcp)*DEMquantbal(ksec,EMcp,t,c))
;

DWAfconsumpcr(WAf,t,r,c)$rc(r,c)..
 -fcr(WAf,t,c)*WAdiscfact(t)=g=-DWAfavailcr(WAf,t,r,c);

DWAELsupply(ELl,ELs,ELday,t,r,c)$rc(r,c)..
 -( ELAPELwa(ELl,ELs,ELday,t,r,c)*WAdiscfact(t)$(ELWAcoord(c)<>1)
 +DELSUP(ELl,ELs,ELday,t,r,c)*WAdiscfact(t)$(ELWAcoord(c)=1)
   )
 =g= -DWAELsup(ELl,ELs,ELday,t,r,c);



DWAELconsump(ELl,ELs,ELday,t,rr,cc)$rc(rr,cc)..

0 =g=
-DELsup(ELl,ELs,ELday,t,rr,cc)$rc(rr,cc)
*-DTRdem(ELl,ELs,ELday,t,rr,cc)$(rc(rr,cc))
*   -DELdem(ELl,ELs,ELday,t,rr,cc)*WAdiscfact(t)
   +DWAELcons(ELl,ELs,ELday,t,rr,cc)
  -(DWAELpwrdem(t,rr,cc)/(ELlchours(ELl,cc)*ELdaysinseason(ELs,ELday)))$(ord(ELl)=ELlmax(rr,cc) and ord(ELs)=ELsmax(rr,cc) and ord(ELday)=ELdaymax(rr,cc));




DWAelconsumpsol(WApRO,ELl,ELs,ELday,t,r,c)$rc(r,c)..
 0=g=
     DWAELsup(ELl,ELs,ELday,t,r,c)$SWROhyb(WApRO)
   + DWAELcons(ELl,ELs,ELday,t,r,c)$RO(WApRO)
   - DWAELsol(ELl,ELs,ELday,t,r,c)
* - DWAROconslimsol(WApRO,ELl,ELs,ELday,t,r)
;


DWAbld(WAp,v,t,r,c)$(rc(r,c) and vn(v)).. 0=g=
  DWApurchbal(t)*WApurcst(WAp,t,r,c)
*+ DWAcnstrctbal(t)*WAconstcst(WAp,t,r,c)
+ DWAopmaintbal(t)*WAfixedOMcst(WAp,t,c)
+ DWAcapbal(WAp,v,t,r,c)$(t_ind(t) > WAleadtime(WAp))
+ DWAFcaplim(WAp,v,t,r,c)*WAFoptime(WAp,v)$(WApF(WAp) and t_ind(t) > WAleadtime(WAp))
+ sum((ELl,ELs,ELday)$(WApV(WAp) and t_ind(t) > WAleadtime(WAp)) ,
         DWAVcaplim(WAp,v,ELl,ELs,ELday,t,r,c)*
         WAVoptime(WAp,v,ELl,ELs,ELday,c))
*+ sum((ELl,ELs,ELday)$WApsingle(WAp),DWAcaplim(WAp,v,ELl,ELs,ELday,t+WAleadtime(WAp),r)*
*         WAoptime(WAp,v,ELl,ELs,ELday))
*+ sum((ELl,ELs,ELday)$WAprn(WAp),DWAsolcaplim(WAp,v,ELl,ELs,ELday,t+WAleadtime(WAp),r)*
*         ELsolcurvenorm(ELl,ELs,r)*ELlchours(ELl)*ELdaysinseason(ELs,ELday))
+ DWAELrsrvreq(t,r,c)$(WApCo(WAp) and t_ind(t) > WAleadtime(WAp))
*- DWAelpwrdem(t,r)*WAelrate(WAp,v)$(WApsingle(WAp))/hrsperday
;

DWAexistcp(WAp,v,t,r,c)$rc(r,c) ..  0=n=
+ DWAopmaintbal(t)*WAfixedOMcst(WAp,t,c)
+ DWAcapbal(WAp,v,t,r,c)
- DWAcapbal(WAp,v,t-1,r,c)
+ DWAFcaplim(WAp,v,t,r,c)*WAFoptime(WAp,v)$WApF(WAp)
+ sum((ELl,ELs,ELday)$WApV(WAp),DWAVcaplim(WAp,v,ELl,ELs,ELday,t,r,c)*
         WAVoptime(WAp,v,ELl,ELs,ELday,c))
*+ sum((ELl,ELs,ELday)$WApsingle(WAp),DWAcaplim(WAp,v,ELl,ELs,ELday,t,r)*
*         WAoptime(WAp,v,ELl,ELs,ELday))
*+ sum((ELl,ELs,ELday)$(WAprn(WAp) and t_ind(t) > WAleadtime(WAp)) ,DWAsolcaplim(WAp,v,ELl,ELs,ELday,t,r)*
*         ELsolcurvenorm(ELl,ELs,r)*ELlchours(ELl)*ELdaysinseason(ELs,ELday))
+ DWAELrsrvreq(t,r,c)$(WApCo(WAp))
*- DWAelpwrdem(t,r)*WAelrate(WAp,v)$(WApsingle(WAp))/hrsperday
;

DWAgrexistcp(t,r,c)$rc(r,c)..  0 =g= DWAgrcaplim(t,r,c);

DWAgr(WAf,t,rr,cc)$(rc(rr,cc) and WAgrfuelburn(WAf,rr,cc)<>0).. 0=g=
                 + DWAopmaintbal(t)*(WAgromcst(rr,cc)+WAgrtransomcst(rr,cc))
                 + sum((ELl,ELs,ELday),DWAdem(ELl,ELs,ELday,t,rr,cc)*ELnormhours(ELl,ELs,ELday,cc))
                 - DWAgrcaplim(t,rr,cc) -DWAfcons(WAf,t,rr,cc)*WAgrfuelburn(WAf,rr,cc)
;

DWAFop(WApF,v,WAf,t,r,c)$(rc(r,c) and WAfuelburn(WApF,v,WAf,r,c)<>0)..  0=g=

  DWAopmaintbal(t)*(WAELomcst(WApF,r,c)+WAomcst(WApF,r,c)*WAyield(WApF,v,r,c))
- DWAFcaplim(WApF,v,t,r,c)
+ DWAhybratio(t,r,c)*WAyield(WApF,v,r,c)$(rsea(r,c) and WApFco(WApF))
- hybratio*DWAhybratio(t,r,c)$(SWROhyb(WApF) and rsea(r,c))
+ sum((Ell,ELs,ELday),DWAsup(ELl,ELs,ELday,t,r,c)*WAyield(WApF,v,r,c)
                         *ELnormhours(ELl,ELs,ELday,c))
+ sum((ELl,ELs,ELday)$(WAfuelburn(WApF,v,WAf,r,c)>0),DWAELsup(ELl,ELs,ELday,t,r,c)*(1-WAyield(WApF,v,r,c)
                         *WAelrate(WApF,v))*ELnormhours(ELl,ELs,ELday,c))
- DWAfcons(WAf,t,r,c)*WAfuelburn(WApF,v,WAf,r,c)$(WAfuelburn(WApF,v,WAf,r,c)>0)
- sum((ELl,ELs,ELday)$(WAfuelburn(WApF,v,WAf,r,c)<>0 and WApsat(WApF)),
         DWAELcons(ELl,ELs,ELday,t,r,c)*WAelrate(WApF,v)*ELnormhours(ELl,ELs,ELday,c))
$ontext
  -sum((ELl,ELs,ELday),DWAELtradesup(t,ELl,ELs,ELday,c)$(call(c) and tradelim=1 and WAfMP(WAf))
  *(1-WAyield(WApF,v,r,c)*WAelrate(WApF,v))*ELnormhours(ELl,ELs,ELday,c))
$offtext
;

DWAVop(WApV,v,ELl,ELs,ELday,WAf,opm,t,r,c)$(rc(r,c) and WAVfuelburn(WApV,v,WAf,opm,r,c)>0)..0=g=
  DWAopmaintbal(t)*(WAELomcst(WApV,r,c)+WAomcst(WApV,r,c)*WAVyield(WApV,v,opm,r,c))
- DWAVcaplim(WApV,v,ELl,ELs,ELday,t,r,c)/WAVpwrincr(WApV,v,opm)
+ DWAhybratio(t,r,c)*WAVyield(WApV,v,opm,r,c)
+ DWAsup(ELl,ELs,ELday,t,r,c)*WAVyield(WApV,v,opm,r,c)
+ DWAELsup(ELl,ELs,ELday,t,r,c)*(1-WAVyield(WApV,v,opm,r,c)*WAelrate(WApV,v))
- DWAfcons(WAf,t,r,c)*WAVfuelburn(WApV,v,WAf,opm,r,c)
-sum((ksec,EMcp)$(WAsect(ksec) and WAVfuelburn(WApV,v,WAf,opm,r,c)>0),EMfactors(ksec,WAf,EMcp)*WAVyield(WApV,v,opm,r,c)*DEMquantbal(ksec,EMcp,t,c))
;

DWAop(WApsingle,v,ELl,ELs,ELday,WAf,t,r,c)$(rc(r,c) and WAfuelburn(WApsingle,v,WAf,r,c)<>0)..0=g=
  DWAopmaintbal(t)*WAomcst(WApsingle,r,c)
*- DWAcaplim(WApsingle,v,ELl,ELs,ELday,t,r)
*- (hybratio*DWAhybratio(ELl,ELs,ELday,t,r))$(SWROhyb(WApsingle) and rsea(r))
+ DWAsup(ELl,ELs,ELday,t,r,c)
- (DWAELsup(ELl,ELs,ELday,t,r,c)*WAelrate(WApsingle,v))$SWROhyb(WApsingle)
- (DWAELcons(ELl,ELs,ELday,t,r,c)*WAelrate(WApsingle,v))$WApsat(WApsingle)
*+ (DWAROconslimsol(WApsingle,ELl,ELs,ELday,t,r)*WAelrate(WApsingle,v))$WApRo(WApsingle)
- DWAfcons(WAf,t,r,c)*WAfuelburn(WApsingle,v,WAf,r,c)$(WAfuelburn(WApsingle,v,WAf,r,c)>0);

DWAsolop(WAprn,v,ELl,ELs,ELday,t,r,c)$rc(r,c).. 0 =g=
  DWAopmaintbal(t)*WAELomcst(WAprn,r,c)
*- DWAsolcaplim(WAprn,v,ELl,ELs,Elday,t,r)
+ DWAELsol(ELl,ELs,ELday,t,r,c);

DWAELpwrdemand(t,r,c)$rc(r,c).. 0=e= DWAELpwrdem(t,r,c);

DWAELrsrvcontr(t,r,c)$rc(r,c).. 0 =e= -DWAELrsrvreq(t,r,c);

DWAtransbld(t,r,c,rr,cc)$(rc(r,c) and rc(rr,cc))..   0=g=
  DWApurchbal(t)*WAtranspurcst(t,r,c,rr,cc)
*+ DWAcnstrctbal(t)*WAtransconstcst(t,r,c,rr,cc)
+ DWAtranscapbal(t+WAtransleadtime(r,c,rr,cc),r,c,rr,cc)
+ sum((Ell,Els,ELday),DWAtranscaplim(Ell,Els,Elday,t+WAtransleadtime(r,c,rr,cc),r,c,rr,cc)
                 *ELdaysinseason(ELs,ELday)*ELlcnorm(ELl,c));

DWAtransexistcp(t,r,c,rr,cc)$(rc(r,c) and rc(rr,cc)).. 0=g=
    DWAtranscapbal(t,r,c,rr,cc)
+ sum((Ell,Els,ELday),DWAtranscaplim(Ell,Els,Elday,t,r,c,rr,cc)
                 *ELdaysinseason(ELs,ELday)*ELlcnorm(ELl,c));

DWAtrans(ELl,ELs,ELday,t,r,c,rr,cc)$(rc(r,c) and rc(rr,cc)).. 0=g=
  DWAopmaintbal(t)*WAtransomcst(r,c,rr,cc)
  +DWAdem(ELl,ELs,ELday,t,rr,cc)*WAtransyield(r,c,rr,cc)
  -DWAsup(ELl,ELs,ELday,t,r,c)
  -DWAtranscaplim(Ell,Els,Elday,t,r,c,rr,cc);

DWAstoop(ELl,ELs,ELday,t,rr,cc)$rc(rr,cc).. 0 =g=
         +DWAopmaintbal(t)*WAstoomcst(rr,cc)
         -DWAstocaplim(ELl,ELs,ELday,t,rr,cc)
         +DWAdem(ELl+1,ELs,ELday,t,rr,cc)$(ord(ELl)<>1)
         +DWAdem(ELl+(1-card(ELl)),ELs,ELday,t,rr,cc)$(ord(ELl)=1)
         -DWAdem(ELl,ELs,ELday,t,rr,cc) ;

DWAstobld(t,rr,cc)$rc(rr,cc)..       0 =g=
         DWApurchbal(t)*WAstopurcst(t,rr,cc)
*         +DWAcnstrctbal(t)*WAstoconstcst(t,rr,cc)
         +DWAstocapbal(t+WAstoleadtime,rr,cc)
         +sum((ELl,Els,ELday),DWAstocaplim(ELl,ELs,ELday,t,rr,cc)*ELdaysinseason(ELs,ELday)) ;

DWAstoexistcp(t,rr,cc)$rc(rr,cc)..       0 =g=
         +DWAstocapbal(t,rr,cc)
         -DWAstocapbal(t-1,rr,cc)
         +sum((ELl,Els,ELday),DWAstocaplim(ELl,ELs,ELday,t,rr,cc)*ELdaysinseason(ELs,ELday))
*$offtext

;
