* Electricity sub-model
* Expanding to include GCC countries
$ontext
*========================
This version of the electricity generation model considers hourly load curves
and contains CSPw/storage, PV, wind, and nuclear activities. It also includes
spinning reserves to mitigate the effects of PV/wind output unreliability.
*========================
$offtext
*HFO consumption constraint is not considered for steam plants with scrubbers (see constraints).

Parameters
ELAPelwa(ELl,ELs,ELday,time,r,c) administered electricity sold by cogen plants USD per MWh
WAdiscfact(time) discount factor for water sector;
Parameters ELdiscfact(time) discount factor for electricity sector;
parameter ELdemgro(time,r,c);
parameter ELexist(ELp,v,r,c);
parameter ELfuelburn(ELp,v,ELf,r,c);

$onecho > taskEL.txt
  par=ELdemgro rng=ELdemgro! Rdim=3
  par=ELexist rng=ELexist! Rdim=4
  par=ELfuelburn rng=ELfuelburn! Rdim=5
$offecho

$call GDXXRW C:\GitHub\KEM-GCC\data\ELdata.xlsx @taskEL.txt
execute_load "ELdata.gdx",
  ELdemgro
  ELexist
  ELfuelburn
;

Parameter ELfconsumpmax(ELf,time,r,c) fuel supply quotas if they exist [MMBBL-TBTU-MMtons per year];

ELfconsumpmax('Arablight',time,r,c)=9e9;
ELfconsumpmax('u-235',time,r,c)=9e9;
ELfconsumpmax('Coal',time,r,c)=9e9;

* KSA

ELfconsumpmax('methane',time,'west','ksa')=30.00442156;
ELfconsumpmax('methane',time,'cent','ksa')=375.13244;
ELfconsumpmax('methane',time,'east','ksa')=495.0079;
$ontext
ELfconsumpmax('methane',time,'west','ksa')=1e3;
ELfconsumpmax('methane',time,'cent','ksa')=1e3;
ELfconsumpmax('methane',time,'east','ksa')=1e3;
$offtext
ELfconsumpmax('HFO',time,r,c)=0;
ELfconsumpmax('HFO',time,'west','ksa')=6.473516;

ELfconsumpmax('diesel',time,'east','ksa')=1.586186;
ELfconsumpmax('diesel',time,'west','ksa')=3.660628;
ELfconsumpmax('diesel',time,'sout','ksa')=4.319887;
ELfconsumpmax('diesel',time,'cent','ksa')=1.219691;

* UAE
ELfconsumpmax('arablight',time,'adwe','uae')=0;
ELfconsumpmax('methane',time,'adwe','uae')=9e9;
ELfconsumpmax('diesel',time,'adwe','uae')=0;
ELfconsumpmax('HFO',time,'adwe','uae')=0;

ELfconsumpmax('arablight',time,'dewa','uae')=0;
ELfconsumpmax('methane',time,'dewa','uae')=9e9;
ELfconsumpmax('diesel',time,'dewa','uae')=0;
ELfconsumpmax('HFO',time,'dewa','uae')=0;

ELfconsumpmax('arablight',time,'sewa','uae')=0;
ELfconsumpmax('methane',time,'sewa','uae')=9e9;
ELfconsumpmax('diesel',time,'sewa','uae')=0;
ELfconsumpmax('HFO',time,'sewa','uae')=0;

ELfconsumpmax('arablight',time,'fewa','uae')=0;
ELfconsumpmax('methane',time,'fewa','uae')=9e9;
ELfconsumpmax('diesel',time,'fewa','uae')=0;
ELfconsumpmax('HFO',time,'fewa','uae')=0;

* Qatar
ELfconsumpmax('arablight',time,'qatr','qat')=0;
ELfconsumpmax('methane',time,'qatr','qat')=9e9;
ELfconsumpmax('diesel',time,'qatr','qat')=0;
ELfconsumpmax('HFO',time,'qatr','qat')=0;

$ontext
* Kuwait
ELfconsumpmax('arablight',time,'kuwr','kuw')=5;
ELfconsumpmax('methane',time,'kuwr','kuw')=350;
ELfconsumpmax('HFO',time,'kuwr','kuw')=7;
ELfconsumpmax('diesel',time,'kuwr','kuw')=1.25;
$offtext
$ontext
ELfconsumpmax('arablight',time,'kuwr','kuw')=0;
ELfconsumpmax('methane',time,'kuwr','kuw')=400;
ELfconsumpmax('HFO',time,'kuwr','kuw')=6.0;
ELfconsumpmax('diesel',time,'kuwr','kuw')=1.0;
$offtext

ELfconsumpmax('arablight',time,'kuwr','kuw')=0;
ELfconsumpmax('methane',time,'kuwr','kuw')=0;
ELfconsumpmax('HFO',time,'kuwr','kuw')=0;
ELfconsumpmax('diesel',time,'kuwr','kuw')=0;


* Bahrain
ELfconsumpmax('arablight',time,'bahr','bah')=0;
ELfconsumpmax('methane',time,'bahr','bah')=9e9;
ELfconsumpmax('HFO',time,'bahr','bah')=0;
ELfconsumpmax('diesel',time,'bahr','bah')=9e9;

* Oman
ELfconsumpmax('arablight',time,'omnr','omn')=0;
ELfconsumpmax('methane',time,'omnr','omn')=9e9;
ELfconsumpmax('HFO',time,'omnr','omn')=0;
ELfconsumpmax('diesel',time,'omnr','omn')=0;


* for hybrid scenario, to find point where KSA does not consume crude for exchange
*ELfconsumpmax('methane',time,'east','ksa')=ELfconsumpmax('methane',time,'east','ksa')+75;

**Existing capacities in 2015 (taken from the ECRA database and SEC document):
*ELexist('cc','new','east','ksa')=10;

*Source for CC, GT, and Steam: KFUPM Generation Report (2006 ver. on ECRA's
*website for existing plants p. 38). (2010 ver. on ECRA's website for proposed
*plants p. 3-10).
*Nuclear is estimated from Nuclear Energy Institute's website for US plants.
*CSP is assumed to be taken offline for maintenance 6 weeks/year.

Parameter
ELcapital(ELp,time,r,c) Capital cost of equipment million USD per GW;
*$ontext
ELcapital('Steam',time,r,c)=     1026;
ELcapital('Stscrub',time,r,c)=   1026+442;
ELcapital('GT',time,r,c)=        1026;
ELcapital('CoalSteam',time,r,c)= 1600;
ELcapital('CC',time,r,c)=        911;
*ELcapital('GTtoCC',time,r,c)=    240;
ELcapital('GTtoCC',time,r,c)=    ELcapital('CC',time,r,c)*0.2;
ELcapital('PV',time,r,c)=        2360;
ELcapital('CSP',time,r,c)=       5250;
*ELcapital('Nuclear',time,r,c)=   5288;
ELcapital('Nuclear',time,r,c)=   6500;
ELcapital('Wind',time,r,c)=      2020;
*$offtext

$ontext
         ELcapital('Steam','t01',r,c)=1584;
         ELcapital('Steam','t01','east','ksa')=1680;
         ELcapital('Stscrub','t01',r,c)=2026;
         ELcapital('Stscrub','t01','east','ksa')=2122;
         ELcapital('GT','t01',r,c)=1069;
         ELcapital('GT','t01','cent','ksa')=1176.5;
         ELcapital('CC','t01',r,c)=943;
         ELcapital('CC','t01','cent','ksa')=1102;
         ELcapital('GTtoCC','t01',r,c)=240;
         ELcapital('PV','t01',r,c)=1436;
         ELcapital('CSP','t01',r,c)=7448;
         ELcapital('Wind','t01',r,c)=1804;
         ELcapital('Nuclear','t01',r,c)=6500;
         ELcapital('CoalSteam','t01',r,c)=2934;
$offtext

Parameter
ELfixedOMcst(ELp,time) fixed O&M costs in million USD per GW;
*$ontext
ELfixedOMcst('Steam',time)=      17.2;
ELfixedOMcst('Stscrub',time)=    17.2;
ELfixedOMcst('CoalSteam',time)=  65;
ELfixedOMcst('GT',time)=         17.2;
ELfixedOMcst('CC',time)=         10.76;
ELfixedOMcst('CCcon',time)=      10.76;
ELfixedOMcst('PV',time)=         24;
ELfixedOMcst('CSP',time)=        210;
ELfixedOMcst('Nuclear',time)=    98.11;
ELfixedOMcst('Wind',time)=       50;
*$offtext
$ontext
* SEC costs
ELfixedOMcst('Steam',time)=      36.5;
ELfixedOMcst('Stscrub',time)=    42;
ELfixedOMcst('CoalSteam',time)=  37.8;
ELfixedOMcst('GT',time)=         10.11;
ELfixedOMcst('CC',time)=         19.94;
ELfixedOMcst('CCcon',time)=      20.94;
ELfixedOMcst('PV',time)=         26.67;
ELfixedOMcst('CSP',time)=        70;
ELfixedOMcst('Nuclear',time)=    130;
ELfixedOMcst('Wind',time)=       45.475;
$offtext


Parameter
ELomcst(ELp,v,r,c) no-fuel variable O&M costs in USD per GWh;
*$ontext
ELomcst('steam',v,r,c)=          3420;
ELomcst('stscrub',v,r,c)=        4430;
ELomcst('coalsteam',v,r,c)=      6950;
ELomcst('GT',v,r,c)=             3420;
ELomcst('CC',v,r,c)=             3420;
ELomcst('CCcon',v,r,c)=          3420;
ELomcst('PV',v,r,c)=             0;
ELomcst('CSP',v,r,c)=            4100;
ELomcst('nuclear',v,r,c)=        2300;
ELomcst('wind',v,r,c)=           0;
*$offtext
$ontext
* SEC costs
ELomcst('steam',v,r,c)=          1640;
ELomcst('stscrub',v,r,c)=        4430;
ELomcst('coalsteam',v,r,c)=      4470;
ELomcst('GT',v,r,c)=             4000;
ELomcst('CC',v,r,c)=             3300;
ELomcst('CCcon',v,r,c)=          3800;
ELomcst('PV',v,r,c)=             0;
ELomcst('CSP',v,r,c)=            2700;
ELomcst('nuclear',v,r,c)=        6900;
ELomcst('wind',v,r,c)=           0;
$offtext

Parameter ELpurcst(ELp,time,r,c) Cost of purchasing equipment million USD per GW;

* Rescale ELomsct to MMUSD per TWh
ELomcst(ELp,v,r,c)=1e-3*ELomcst(ELp,v,r,c);

Parameter ELAPf(f,time,r,c);
ELAPf(f,time,r,c)$rc(r,c)=1;

Scalars
*Coefficients related to planning and operating reserves:
ELreserve scale factor for reserve margin GW /1.1/
ELsolspin fraction of solar gen. defining spin. reserve /0.2/
ELwindspin fraction of wind gen. defining spin. reserve /0.2/
ELusrfuelfrac ELfuelburn fraction for operating up spinning reserves /0.1/

*CSP-related coefficients:
ELCSPthermaleff thermal efficiency of CSP steam cycle /0.38/
ELCSPtransloss fraction loss in heat transfer from solar field to CSP cycle /0.35/
ELstorehrloss fraction of stored CSP heat dissipated per hour /0.00031/
ELstorecycloss fraction of heat lost by passing through storage cycle /0.015/
ELminDNI minimum DNI required for instantaneous CSP operation in W per sq. m /300/
ELaperturearea CSP collector area use in km^2 per GWe capacity /10.25/
CSPstoragehours hours equivalent to the amount of energy stored /8/
CSPreservecontr percent contribution of CSP capacity to reserve margin /0/

*Source for CSP Rankine thermal efficiency: US parabolic trough data on NREL
*Source for CSP transfer losses from solar field to steam cycle: Rovira et al. (2013, p. 269)
*Source for hourly heat dissipation from CSP storage: Sioshansi and Denholm (2010, p. 4)
*Source for cycle loss in CSP storage: Madaeni et al. (2012, p. 338)
*Source for minimum DNI requirement: Zhang et al. (2010, p. 7885-7887)
*Source for direct land use ratio: Kearney (2010, p. 18, NREL)
*Source for reserve contribution: Sioshansi and Denholm (2010, p. 16)

*Wind-related coefficients:
ELcutinspeed cut-in speed for wind turbine operation in m per sec /3/
ELcutoffspeed cut-off speed for wind turbine operation in m per sec /25/
ELratedspeed rated speed for wind turbine in m per sec /13/

*Source for cut-in speed: Adaramola et al. (2014), Al-Abbadi (2005), Ucar and Balo (2009), and Ahmed (2012)
*Source for cut-off speed: Adaramola et al. (2014), Al-Abbadi (2005), and Ucar and Balo (2009)
*Source for rated speed: Adaramola et al. (2014), Al-Abbadi (2005), and Ucar and Balo (2009)

Hoursinayear /8760/;

Parameter PVdegrade(r,c) degradation factor for PV panels;
PVdegrade(r,c)=0.009;
PVdegrade('sout','ksa')=0.005;
*Source for PV degradation factor in hot climates/desert: NREL (2012, p. 14);
*Southern climate is much more forgiving.

Parameter ELleadtime(ELp) Lead time for plant construction units of time

/
 Steam   2
 Stscrub 2
 CoalSteam 4
 GT      0
 CC      3
 GTtoCC  1
 PV      2
 CSP     3
 Wind    3
 Nuclear 9
* Nuclear 10
/
$ontext
 /
 Steam   2
 Stscrub 2
 CoalSteam 4
 GT      0
 CC      3
 GTtoCC  1
 PV      3
 CSP     3
 Wind    3
 Nuclear 7
 /
$offtext
;

*Number of days in each season split up into work days and weekends/holidays.
*SP: Assuming it will be same for all GCC countries
Table ELdaysinseason(ELs,ELday) Days of each type in a season
      wday wendhol
summ  63   31
wint  63   25
spfa  122  61
;
*To rescale to TWh rather than GWh in the ELcaplim equations
ELdaysinseason(ELs,ELday)=1e-3*ELdaysinseason(ELs,ELday);

Parameter ELnormdays(ELs,ELday) ELdaysinseason normalized by total days in a year;
ELnormdays(ELs,ELday)=ELdaysinseason(ELs,ELday)/sum((ELss,ELdayy),ELdaysinseason(ELss,ELdayy));

*The ELsolcap and ELwindcap parameters are the regional non-dispatchable solar and
*wind capacity limits. We can vary them below. The limits are now set at 50 GW.

Parameter ELsolcap(c) Maxmimum capacity solar in GCC countries in GW
/
ksa   50
uae   50
qat   10
kuw   50
bah   50
omn   50
/;

Parameter ELwindcap(c) Maxmimum capacity wind power in GCC countries in GW
/
ksa   50
uae   50
qat   50
kuw   50
bah   50
omn   50
/;


Table ELlchours(ELl,c) time in hours in each load segment
         ksa uae qat kuw bah omn
L1       4   4   4   4   4   4
L2       4   4   4   4   4   4
L3       4   4   4   4   4   4
L4       2   2   2   2   2   2
L5       3   3   3   3   3   3
L6       2   2   2   2   2   2
L7       2   2   2   2   2   2
L8       3   3   3   3   3   3
;

* Normalizing number of hours each load segment by total annual hours to
* distribute consumption over all the load segments:
Parameters ELlchrsfraction(ELl,c);
ELlchrsfraction(ELl,c)=ELlchours(ELl,c)/sum(ELll,ELlchours(ELll,c));

* load curves
Parameter ELlcgw(ELl,ELs,ELday,rr,cc) regional load in GW for each load segment in ELlchours

$GDXIN data\loadcurve\ELlcgw_ksa.gdx
Parameter ELlcgw_ksa(ELl,ELs,ELday,r,c) discretized load curve ;
$LOAD ELlcgw_ksa = ELlcgw
$GDXIN
;

$GDXIN data\loadcurve\ELlcgw_kuw.gdx
Parameter ELlcgw_kuw(ELl,ELs,ELday,r,c) discretized load curve ;
$LOAD ELlcgw_kuw = ELlcgw
$GDXIN
;

$GDXIN data\loadcurve\ELlcgw_uae.gdx
Parameter ELlcgw_uae(ELl,ELs,ELday,r,c) discretized load curve ;
$LOAD ELlcgw_uae = ELlcgw
$GDXIN
;

$GDXIN data\loadcurve\ELlcgw_bah.gdx
Parameter ELlcgw_bah(ELl,ELs,ELday,r,c) discretized load curve ;
$LOAD ELlcgw_bah = ELlcgw
$GDXIN
;

$GDXIN data\loadcurve\ELlcgw_qat.gdx
Parameter ELlcgw_qat(ELl,ELs,ELday,r,c) discretized load curve ;
$LOAD ELlcgw_qat = ELlcgw
$GDXIN
;

$GDXIN data\loadcurve\ELlcgw_omn.gdx
Parameter ELlcgw_omn(ELl,ELs,ELday,r,c) discretized load curve ;
$LOAD ELlcgw_omn = ELlcgw
$GDXIN
;

ELlcgw(ELl,ELs,ELday,r,'bah') = 1.2*ELlcgw_bah(ELl,ELs,ELday,r,'bah') ;
ELlcgw(ELl,ELs,ELday,r,'kuw') = ELlcgw_kuw(ELl,ELs,ELday,r,'kuw') ;
ELlcgw(ELl,ELs,ELday,r,'omn') = 1.1*ELlcgw_omn(ELl,ELs,ELday,r,'omn') ;
ELlcgw(ELl,ELs,ELday,r,'qat') = 1.2*ELlcgw_qat(ELl,ELs,ELday,r,'qat') ;
ELlcgw(ELl,ELs,ELday,r,'ksa') = ELlcgw_ksa(ELl,ELs,ELday,r,'ksa') ;
ELlcgw(ELl,ELs,ELday,r,'uae') = ELlcgw_uae(ELl,ELs,ELday,r,'uae') ;

option ELlcgw:3:3:2;
display 'load curve just imported', ELlcgw;

Parameter WAELdemand(rr,cc) Water Electricty demand in GW
/
west.ksa 0.252
sout.ksa 0.068
cent.ksa 0
east.ksa 0.028

*adwe.uae 0.2
*adwe.uae = 0
*dewa.uae = 0.048
*sewa.uae = 0.119
*fewa.uae = 0.0378995
*fewa.uae = 0.177
*$ontext
adwe.uae = 0.2
dewa.uae = 0.2
sewa.uae = 0.2
fewa.uae = 0.5
*$offtext

qatr.qat 0.250
kuwr.kuw 0
bahr.bah 0.7
omnr.omn 1
/
;

option WAELdemand:3:0:1;
display 'WAELdemand defined',WAELdemand;

$ontext
Parameter ELREpwrdemand2015(ELl,ELs,ELday,rr,cc) residential power demand in GW;
* proportion of total demand
ELREpwrdemand2015(ELl,'summ',ELday,rr,cc)=ELlcgw(ELl,'summ',ELday,rr,cc)*0.4;
ELREpwrdemand2015(ELl,'spfa',ELday,rr,cc)=ELlcgw(ELl,'spfa',ELday,rr,cc)*0.4;
ELREpwrdemand2015(ELl,'wint',ELday,rr,cc)=ELlcgw(ELl,'wint',ELday,rr,cc)*0.4;

ELREpwrdemand2015(ELl,'summ',ELday,'west','ksa')=ELlcgw(ELl,'summ',ELday,'west','ksa')*0.6631;
ELREpwrdemand2015(ELl,'summ',ELday,'east','ksa')=ELlcgw(ELl,'summ',ELday,'east','ksa')*0.2918;
ELREpwrdemand2015(ELl,'summ',ELday,'cent','ksa')=ELlcgw(ELl,'summ',ELday,'cent','ksa')*0.5180;
ELREpwrdemand2015(ELl,'summ',ELday,'sout','ksa')=ELlcgw(ELl,'summ',ELday,'sout','ksa')*0.7049;

ELREpwrdemand2015(ELl,'spfa',ELday,'west','ksa')=ELlcgw(ELl,'spfa',ELday,'west','ksa')*0.5192;
ELREpwrdemand2015(ELl,'spfa',ELday,'east','ksa')=ELlcgw(ELl,'spfa',ELday,'east','ksa')*0.2197;
ELREpwrdemand2015(ELl,'spfa',ELday,'cent','ksa')=ELlcgw(ELl,'spfa',ELday,'cent','ksa')*0.4599;
ELREpwrdemand2015(ELl,'spfa',ELday,'sout','ksa')=ELlcgw(ELl,'spfa',ELday,'sout','ksa')*0.5136;

ELREpwrdemand2015(ELl,'wint',ELday,'west','ksa')=ELlcgw(ELl,'wint',ELday,'west','ksa')*0.5108;
ELREpwrdemand2015(ELl,'wint',ELday,'east','ksa')=ELlcgw(ELl,'wint',ELday,'east','ksa')*0.1887;
ELREpwrdemand2015(ELl,'wint',ELday,'cent','ksa')=ELlcgw(ELl,'wint',ELday,'cent','ksa')*0.4332;
ELREpwrdemand2015(ELl,'wint',ELday,'sout','ksa')=ELlcgw(ELl,'wint',ELday,'sout','ksa')*0.4357;

* remaining GCC:
ELREpwrdemand2015(ELl,'summ',ELday,'qatr','qat')=ELlcgw(ELl,'summ',ELday,'qatr','qat')*0.5;
ELREpwrdemand2015(ELl,'spfa',ELday,'qatr','qat')=ELlcgw(ELl,'spfa',ELday,'qatr','qat')*0.5;
ELREpwrdemand2015(ELl,'wint',ELday,'qatr','qat')=ELlcgw(ELl,'wint',ELday,'qatr','qat')*0.5;

option ELREpwrdemand2015:3:3:2;
display 'ELREpwrdemand2015 as portion of overall load',ELREpwrdemand2015;
$offtext

*Calculating the maximum regional load for the reserve margin constraint;

Parameter ELlcgwmax(rr,cc) maximum regional load in GW
          Ellmax(rr,cc), ELsmax(rr,cc),ELdaymax(rr,cc);
*SP: Outer loop, by region-country, first, find the maximum load
loop((rr,cc)$rc(rr,cc),
ELlcgwmax(rr,cc)=smax((ELl,ELs,ELday),ELlcgw(ELl,ELs,ELday,rr,cc));
*SP: second, assign the rank order of the maximum load in load segments
loop(ELl$(smax((ELs,ELday),ELlcgw(ELl,ELs,ELday,rr,cc))=ELlcgwmax(rr,cc)),
ELlmax(rr,cc) = ord(ELl)
);
*SP: third, assign the rank order of the maximum load in seasons
loop(ELs$(smax((ELl,ELday),ELlcgw(ELl,ELs,ELday,rr,cc))=ELlcgwmax(rr,cc)),
ELsmax(rr,cc) = ord(ELs)
);
*SP: fourth, assign the rank order of the maximum load in days
loop(ELday$(smax((ELl,ELs),ELlcgw(ELl,ELs,ELday,rr,cc))=ELlcgwmax(rr,cc)),
ELdaymax(rr,cc) = ord(ELday)
);
*SP: Closing the outer loop
);

option ELlcgwmax:3:0:1;
display 'ELlcgwmax calculated',ELlcgwmax,ELlmax,ELsmax,ELdaymax;

* update load curve by removing endogenous loads
ELlcgw(ELl,ELs,ELday,rr,cc)$rc(rr,cc)= ELlcgw(ELl,ELs,ELday,rr,cc)
 -WAELdemand(rr,cc)
* -PCELpwrdemand2013(rr,cc)
* -CMELpwrdemand2013(rr,cc)
* -ELREpwrdemand2015(ELl,ELs,ELday,rr,cc)
;

option ELlcgw:3:3:2;
display 'updated load curve by removing WAELdemand and ELREpwrdemand2015',ELlcgw;


$ontext
*The above section determines the time during which the load is maximum.
*Below,*since we use average values for the load curves,
*we manually define the absolute

*peak load in 2015 before removing endogenous loads
ELlcgwmax('West','ksa')=16.972;
ELlcgwmax('Sout','ksa')=5.031;
ELlcgwmax('Cent','ksa')=19.892;
ELlcgwmax('East','ksa')=18.527;
*ELlcgwmax('adwe','uae')=10.17;
*ELlcgwmax('dewa','uae')=7.696;
*ELlcgwmax('sewa','uae')=2.0874;
*ELlcgwmax('fewa','uae')=0.0446;
ELlcgwmax('qatr','qat')=6.8;

ELlcgwmax('adwe','uae')=8.98;
ELlcgwmax('dewa','uae')=7.23;
ELlcgwmax('sewa','uae')=2.15;
ELlcgwmax('fewa','uae')=2.16;


option ELlcgwmax:3:0:1;
display 'peak load is manually defined',ELlcgwmax;


* update peak by removing endogenous loads
ELlcgwmax(rr,cc)=
 ELlcgwmax(rr,cc)
-WAELdemand(rr,cc)
*-PCELpwrdemand2013(rr,cc)
*-CMELpwrdemand2013(rr,cc)
*-smax((ELl,ELs,ELday),ELREpwrdemand2015(ELl,ELs,ELday,rr,cc))
;
$offtext

*parameter res_pwrdemand2015(rr,cc);
*res_pwrdemand2015(rr,cc) = smax((ELl,ELs,ELday),ELREpwrdemand2015(ELl,ELs,ELday,rr,cc));

*display 'peak is updated a second time by removing endogenous loads',res_pwrdemand2015,ELlcgwmax;

*The solar DNI curves were obtained from NREL/KACST. The cities used for each region
*are: West-Jeddah,   South-Abha,  Central-Solar Village,  East-AlQusaimah. The values
*represent average DNI levels for each segment over the seasonal period for each
*region. The data from the year 2002 are used.

parameter ELsolcurve(ELl,ELs,r,c);

Table ELsolcurve(ELl,ELs,r,c) regional and seasonal solar DNI profiles in W per sq. m
               west.ksa       sout.ksa   cent.ksa    east.ksa
L1.summ        0.00           0.00       0.00        0.00
L2.summ        110.09         259.83     308.17      301.34
L3.summ        295.82         530.41     701.85      682.11
L4.summ        364.87         436.38     759.63      741.60
L5.summ        286.14         249.75     537.49      556.56
L6.summ        107.01         83.94      171.54      195.74
L7.summ        0.00           0.00       0.00        0.00
L8.summ        0.00           0.00       0.00        0.00
*
L1.wint        0.00           0.00       0.00        0.00
L2.wint        118.65         240.74     208.64      147.02
L3.wint        366.36         580.38     544.80      370.83
L4.wint        501.84         646.97     658.06      426.94
L5.wint        385.92         447.85     421.11      253.03
L6.wint        131.80         140.52     99.21       49.90
L7.wint        0.00           0.00       0.00        0.00
L8.wint        0.00           0.00       0.00        0.00
*
L1.spfa        0.00           0.00       0.00        0.00
L2.spfa        133.59         321.61     268.68      185.34
L3.spfa        366.00         717.74     631.74      453.89
L4.spfa        446.01         725.93     683.32      500.01
L5.spfa        326.06         464.02     401.39      292.48
L6.spfa        112.45         134.21     81.12       61.02
L7.spfa        0.00           0.00       0.00        0.00
L8.spfa        0.00           0.00       0.00        0.00

+              adwe.uae        dewa.uae        sewa.uae        fewa.uae
L1.summ        1               1               1               1
L2.summ        0               0               0               0
L3.summ        0               0               0               0
L4.summ        0               0               0               0
L5.summ        0               0               0               0
L6.summ        0               0               0               0
L7.summ        0               0               0               0
L8.summ        0               0               0               0
*
L1.wint        1               1               1               1
L2.wint        0               0               0               0
L3.wint        0               0               0               0
L4.wint        0               0               0               0
L5.wint        0               0               0               0
L6.wint        0               0               0               0
L7.wint        0               0               0               0
L8.wint        0               0               0               0
*
L1.spfa        1               1               1               1
L2.spfa        0               0               0               0
L3.spfa        0               0               0               0
L4.spfa        0               0               0               0
L5.spfa        0               0               0               0
L6.spfa        0               0               0               0
L7.spfa        0               0               0               0
L8.spfa        0               0               0               0
$ontext
+              qatr.qat        kuwr.kuw        bahr.bah        omnr.omn
L1.summ        0.00            1               1               1
L2.summ        301.34          0               0               0
L3.summ        682.11          0               0               0
L4.summ        741.60          0               0               0
L5.summ        556.56          0               0               0
L6.summ        195.74          0               0               0
L7.summ        0.00            0               0               0
L8.summ        0.00            0               0               0
*
L1.wint        0.00            1               1               1
L2.wint        147.02          0               0               0
L3.wint        370.83          0               0               0
L4.wint        426.94          0               0               0
L5.wint        253.03          0               0               0
L6.wint        49.90           0               0               0
L7.wint        0.00            0               0               0
L8.wint        0.00            0               0               0
*
L1.spfa        0.00            1               1               1
L2.spfa        185.34          0               0               0
L3.spfa        453.89          0               0               0
L4.spfa        500.01          0               0               0
L5.spfa        292.48          0               0               0
L6.spfa        61.02           0               0               0
L7.spfa        0.00            0               0               0
L8.spfa        0.00            0               0               0
;
$offtext

$GDXIN data\loadcurve\ELlsolcurve_uae.gdx
Parameter ELlsolcurve_uae(ELl,ELs,r,c) discretized load curve ;
$LOAD ELlsolcurve_uae = ELlsolcurve
$GDXIN
;

$GDXIN data\loadcurve\ELlsolcurve_qat.gdx
Parameter ELlsolcurve_qat(ELl,ELs,r,c) discretized load curve ;
$LOAD ELlsolcurve_qat = ELlsolcurve
$GDXIN
;


*ELsolcurve(ELl,ELs,r,'bah') = ELlsolcurve_bah(ELl,ELs,r,'bah') ;
*ELsolcurve(ELl,ELs,r,'kuw') = ELlsolcurve_kuw(ELl,ELs,r,'kuw') ;
*ELsolcurve(ELl,ELs,r,'omn') = ELlsolcurve_omn(ELl,ELs,r,'omn') ;
ELsolcurve(ELl,ELs,r,'qat') = ELlsolcurve_qat(ELl,ELs,r,'qat') ;
ELsolcurve(ELl,ELs,r,'uae') = ELlsolcurve_uae(ELl,ELs,r,'uae') ;
ELsolcurve(ELl,ELs,'kuwr','kuw') = ELlsolcurve_qat(ELl,ELs,'qatr','qat') ;
ELsolcurve(ELl,ELs,'bahr','bah') = ELlsolcurve_qat(ELl,ELs,'qatr','qat') ;
ELsolcurve(ELl,ELs,'omnr','omn') = ELlsolcurve_qat(ELl,ELs,'qatr','qat') ;

*We let the hourly operation of solar without storage to be proportional to the DNI.
*In actuality, the output from solar plants is equal to some efficiency times the
*irradiance (heat input). For thermal plants, it's the first law thermal efficiency.
*While CSP plants only utilize direct irradiation (DI), the DI is linearly
*proportional to the DNI. From this, we set the solar plant electricity output equal to its
*peak nominal output (i.e. the plant's output capacity) multiplied by the solar irradiance
*normalized by the maximum irradiance value throughout the year.

Parameter ELsolcurvenorm(ELl,ELs,r,c) normalized DNI profiles from ELsolcurve;
Elsolcurvenorm(ELl,ELs,r,c)$rc(r,c)=ELsolcurve(ELl,ELs,r,c)/smax((ELll,ELss),ELsolcurve(ELll,ELss,r,c));

*The following table considers the impact of incrementally adding solar capacity
*in each region. These capacities are defined as the nominal peak output
*throughout the year since this is at the point of load. The solar contribution is
*multiplied by 0.96 to account for losses between generation and point of load.
Parameter ELdiffGWsol(ELl,ELs,rr,cc) load difference due to introduction of solar capacity;
ELdiffGWsol(ELl,ELs,r,c)=ELsolcurvenorm(ELl,ELs,r,c)*ELsolcap(c)*0.96;

display ELdiffGWsol;

*=======
*This section deals with calculating the direct irradiance (DI) from the DNI curves above.
*Using trigonometric relations from McQuiston et al (2005), the earth's position and
*the resulting angle of incidence on a surface are computed for each season, region,
*and load segment. The equations are written out in the file Macros.gms.
*Each hour is equivalent to 15 degrees of rotation, and we are assuming single-axis
*tracking along the north-south axis (for CSP).

* need to update
Parameter timezone(c) Time zone in degrees W relative to Prime Meridian
/
ksa 315
uae 415
qat 315
kuw 315
bah 315
omn 415
/
;

*georgraphical coordinates for each region. Units are deg W for longitude and
*deg N for latitude. Coordinates obtained from NREL's website.
*SP: Need to update Coordinates for GCC regions other than ksa
Table ELgeocoord(coord,r,c) latitude and longitude
       west.ksa    sout.ksa    cent.ksa    east.ksa
lat    21.68       18.23       24.91       28.32
long   320.85      341.77      313.59      313.87

+      adwe.uae    dewa.uae    sewa.uae    fewa.uae
lat    24.30       25.27       25.2        25.4
long   305.3       304.73      304.5       303.75

+      qatr.qat    kuwr.kuw    bahr.bah    omnr.omn
lat    28          28          28          28
long   313         313         313         313

*SP: Assuming the following is same for all GCC countries
Parameter dayofyear(ELs) day number during the year;
dayofyear('summ')=213;
dayofyear('wint')=37;
dayofyear('spfa')=121;
;
*Table assigns the number of hour to the solar curves:
Parameter hourofday(ELl) hour of day representing each load segment
/
L1  2
L2  6
L3  10
L4  13
L5  15.5
L6  18
L7  20
L8  22.5
/
;

Parameter ELpositionofearth(ELs) position of earth in degrees;
Parameter ELequationoftime(ELs) Equation of time in minutes;
*SP: Added country index
Parameter ELlocalsolartime(ELl,ELs,r,c) Local solar time in hours;
*Hour angle is angle between the projection of the vector of location-to-center of earth on
*the equitorial plane and the associated projection of the line from the center of the sun
*to the center of the earth.
*By convention, the hour angle is negative in the morning, zero at noon, and positive in the afternoon.
Parameter ELhourangle(ELl,ELs,r,c) the hour angle in degrees;
*sol dec: Angle between the line connecting the origins of the Earth and Sun and the line projection
*of that line on the earth's equitorial plane.
Parameter ELsurazimuth(ELl,ELs,r,c) the surface azimuth;
*orientation of the aperture plane from the north
Parameter ELtiltangle(ELl,ELs,r,c) tilt angle of surface;
*orientation of aperture plane in degrees(0 for horizontal 90 for vertical)
Parameter ELsoldeclination(ELs) solar declination angle in degrees;
*sol alt: Angle between the sun's rays and the projection of the rays on a horizontal surface.
Parameter ELsolaltitude(ELl,ELs,r,c) solar altitude in degrees;
*sol azim: Angle between horizontal projection of the sun's rays and the horizontal direction
*measured from the north (clockwise direction).
Parameter ELsolazimuth(ELl,ELs,r,c) solar azimuth in degrees;
*solsurfazim: Absolute value of the difference between the solar azimuth (phi) and the surface azimuth (psi).
Parameter ELsolarsurfaceazimuth(ELl,ELs,r,c) solar surface azimuth in degrees;
*ang of inc: angle between sun's rays and the normal of the surface
Parameter ELangleofincidence(ELl,ELs,r,c) the angle of incidence in degrees;

ELpositionofearth(ELs)=earthpos(dayofyear(ELs));

ELequationoftime(ELs)=EOT(ELpositionofearth(ELs));
*SP: Added country index
ELlocalsolartime(ELl,ELs,r,c)=solhr(hourofday(ELl),Dayofyear(ELs),ELgeocoord('long',r,c),timezone(c));

ELhourangle(ELl,ELs,r,c)=hourangle(ELlocalsolartime(ELl,ELs,r,c));

*To accommodate single-axis tracking, the following is imposed:
*in the morning, hour angle is negative, surface facing east.
*at solar noon, hour angle is zero, value is arbitrary.
*in the afternoon, hour angle is positive, surface facing west.
*SP: Added country index
ELsurazimuth(ELl,ELs,r,c)$(ELhourangle(ELl,ELs,r,c)<0)=90;
ELsurazimuth(ELl,ELs,r,c)$(ELhourangle(ELl,ELs,r,c)=0)=0;
ELsurazimuth(ELl,ELs,r,c)$(ELhourangle(ELl,ELs,r,c)>0)=270;

ELsoldeclination(ELs)=soldecl(ELpositionofearth(ELs));

ELsolaltitude(ELl,ELs,r,c)=solalt(ELhourangle(ELl,ELs,r,c),ELsoldeclination(ELs),ELgeocoord('lat',r,c));

*To have tilt of collectors change throughout the day to match solar zenith:
ELtiltangle(ELl,ELs,r,c)=90-ELsolaltitude(ELl,ELs,r,c)$(ELsolaltitude(ELl,ELs,r,c)>0);

ELsolazimuth(ELl,ELs,r,c)=solazim(ELhourangle(ELl,ELs,r,c),ELsoldeclination(ELs),ELgeocoord('lat',r,c),ELsolaltitude(ELl,ELs,r,c));
ELsolazimuth(ELl,ELs,r,c)$(Elhourangle(ELl,ELs,r,c)>0 or ELlocalsolartime(ELl,ELs,r,c)>12)=360-ELsolazimuth(ELl,ELs,r,c);

ELsolarsurfaceazimuth(ELl,ELs,r,c)=Gamma(ELsolazimuth(ELl,ELs,r,c),ELsurazimuth(ELl,ELs,r,c));

ELangleofincidence(ELl,ELs,r,c)=Incidence(ELsolaltitude(ELl,ELs,r,c),ELsolarsurfaceazimuth(ELl,ELs,r,c),ELtiltangle(ELl,ELs,r,c));

*The direct irradiance is now calculated as a function of DNI, and is used in the
*CSP-related computations.
Parameter ELdirectirradiance(ELl,ELs,r,c) the direct irradiance in GW per sq. km;
ELdirectirradiance(ELl,ELs,r,c)=ELsolcurve(ELl,ELs,r,c)*COS(ELangleofincidence(ELl,ELs,r,c)*pi/180)$(ELsolaltitude(ELl,ELs,r,c)>0);

*To rescale the DI to GW/km^2 and neglect very small values (i.e. less than ~2 W/m^2):
ELdirectirradiance(ELl,ELs,r,c)=1e-3*ELdirectirradiance(ELl,ELs,r,c);
*ELdirectirradiance(ELl,ELs,r)$(ELdirectirradiance(ELl,ELs,r)<2e-3)=0;
*=======================================================================
;
*nc=no clouds;pc=partly cloudy;oc=overcast;dust=dusty
*sum of regional fractions should be unity.
*SP: Added country index. Need to update the date for other GCC countries if different.
table ELccfrac(r,c,clc) fraction of hours for cloud cover scenarios
           nc   pc   oc   dust
west.ksa   1
sout.ksa   1
cent.ksa   1
east.ksa   1
adwe.uae   1
dewa.uae   1
sewa.uae   1
fewa.uae   1
qatr.qat   1
kuwr.kuw   1
bahr.bah   1
omnr.omn   1
;

Table ELsolopfrac(ELppv,clc) fraction of solar operation based on cloud cover
       nc   pc   oc   dust
PV     1    .6   .1    0
;
* Wind power generation parameters
$ontext
We could not obtain hourly wind speed data for Saudi Arabia. To bypass this issue,
we used the monthly data presented by Rehman et al. (1994) to construct cumulative
Weibull distribution functions for Jeddah(west,19 years of data), Riyadh(cent,18 years
of data), Gizan(south,17 years of data), and Dhahran(east,19 years of data).
Using the inverse transform method and a random number generator for probabilities,
we here estimate profiles of the hourly wind speed using season- and region-specific
Weibull shape(which we call "k") and scale(which we call "c") parameters. The shape
of the daily profiles is then calibrated to the distributions' mean values and
diurnal speed variations graphically presented by Al-Abbadi (2005) and Rehman and
Ahmad (2004) for measurements taken over the period of years.

While the distribution of wind speeds closely follows a Weibull curve, this approach
does not take into account the auto-correlation present between hourly wind speeds.
It is therefore a purely probablistic and independent hourly estimation. Weibull
distributions have been commonly applied in the literature to evaluate the LCOE of wind turbine
generation (e.g., Rehman et al. (2003), Adaramola et al. (2014), and Ucar and Balo (2009)).
van Donk et al. (2005) have also applied the Weibull approach in generating hourly
wind speed values from monthly data, and although they do not recommend it in favor of
the direct use of the data distribution, the overall logic of random probability
generation is still applied. Also, they claim that average hourly wind speeds were
under- or over-predicted less than 5% of the time (p. 507).

Other methods, like an autoregressive estimation or a wavelet estimation, have been
proposed (e.g., Aksoy et al. (2004), Carapellucci and Giordano (2013)),
but the lack of hourly data makes them difficult to apply. Additionally, the method
Carapellucci and Giordano (2013) makes an assumption that wind always exhibits
low speeds in the morning hours, higher speeds in the afternoon, and lower again in
the evening (not true for all regions in Saudi Arabia). When they compared to measurements,
their results suggest that with monthly mean wind speeds, the error in hourly speed
is between 12 to 14%, and the error in the maximum hourly speed is between 5.1 to 20.4%.
$offtext
Table ELwindspeed(ELl,ELs,r,c) wind speeds in meters per second
               west.ksa     sout.ksa     cent.ksa     east.ksa
L1.summ        0.785        2.818        2.883        2.641
L2.summ        1.812        3.188        2.255        2.879
L3.summ        4.424        3.782        3.740        4.728
L4.summ        5.329        5.631        2.512        5.502
L5.summ        6.046        6.767        2.353        6.579
L6.summ        3.940        3.837        2.726        5.155
L7.summ        3.411        2.903        5.019        4.292
L8.summ        2.283        2.029        5.833        2.883
*
L1.wint        1.278        2.680        4.418        2.262
L2.wint        2.061        2.798        3.115        3.454
L3.wint        4.286        3.794        3.991        5.155
L4.wint        4.473        4.280        2.460        6.597
L5.wint        7.411        5.838        2.257        6.662
L6.wint        4.451        3.543        2.996        4.786
L7.wint        4.123        2.601        4.203        3.296
L8.wint        2.436        1.904        4.458        2.724
*
L1.spfa        0.953        1.052        4.329        1.489
L2.spfa        1.434        2.369        2.244        3.248
L3.spfa        3.128        3.133        4.534        3.847
L4.spfa        6.315        4.612        2.212        5.670
L5.spfa        6.404        6.784        2.022        7.939
L6.spfa        4.006        5.579        2.220        6.743
L7.spfa        2.946        2.621        2.345        4.355
L8.spfa        2.496        0.903        4.826        2.472

+              adwe.uae        dewa.uae        sewa.uae        fewa.uae
L1.summ        5               5               5               5
L2.summ        1               1               1               1
L3.summ        0               0               0               0
L4.summ        0               0               0               0
L5.summ        0               0               0               0
L6.summ        0               0               0               0
L7.summ        0               0               0               0
L8.summ        0               0               0               0
*
L1.wint        5               5               5               5
L2.wint        0               0               0               0
L3.wint        0               0               0               0
L4.wint        0               0               0               0
L5.wint        0               0               0               0
L6.wint        0               0               0               0
L7.wint        0               0               0               0
L8.wint        0               0               0               0
*
L1.spfa        5               5               5               5
L2.spfa        0               0               0               0
L3.spfa        0               0               0               0
L4.spfa        0               0               0               0
L5.spfa        0               0               0               0
L6.spfa        0               0               0               0
L7.spfa        0               0               0               0
L8.spfa        0               0               0               0

+              qatr.qat        kuwr.kuw        bahr.bah        omnr.omn
L1.summ        5               5               5               5
L2.summ        1               1               1               1
L3.summ        0               0               0               0
L4.summ        0               0               0               0
L5.summ        0               0               0               0
L6.summ        0               0               0               0
L7.summ        0               0               0               0
L8.summ        0               0               0               0
*
L1.wint        5               5               5               5
L2.wint        0               0               0               0
L3.wint        0               0               0               0
L4.wint        0               0               0               0
L5.wint        0               0               0               0
L6.wint        0               0               0               0
L7.wint        0               0               0               0
L8.wint        0               0               0               0
*
L1.spfa        5               5               5               5
L2.spfa        0               0               0               0
L3.spfa        0               0               0               0
L4.spfa        0               0               0               0
L5.spfa        0               0               0               0
L6.spfa        0               0               0               0
L7.spfa        0               0               0               0
L8.spfa        0               0               0               0
;

$GDXIN data\loadcurve\ELwindspeed_uae.gdx
Parameter ELwindspeed_uae(ELl,ELs,r,c) discretized load curve ;
$LOAD ELwindspeed_uae = ELwindspeed
$GDXIN
;

$GDXIN data\loadcurve\ELwindspeed_qat.gdx
Parameter ELwindspeed_qat(ELl,ELs,r,c) discretized load curve ;
$LOAD ELwindspeed_qat = ELwindspeed
$GDXIN
;

*ELwindspeed(ELl,ELs,r,'bah') = ELwindspeed_bah(ELl,ELs,r,'bah') ;
*ELwindspeed(ELl,ELs,r,'kuw') = ELwindspeed_kuw(ELl,ELs,r,'kuw') ;
*ELwindspeed(ELl,ELs,r,'omn') = ELwindspeed_omn(ELl,ELs,r,'omn') ;
ELwindspeed(ELl,ELs,r,'qat') = ELwindspeed_qat(ELl,ELs,r,'qat') ;
ELwindspeed(ELl,ELs,r,'uae') = ELwindspeed_uae(ELl,ELs,r,'uae') ;
ELwindspeed(ELl,ELs,'kuwr','kuw') = ELwindspeed_qat(ELl,ELs,'qatr','qat') ;
ELwindspeed(ELl,ELs,'bahr','bah') = ELwindspeed_qat(ELl,ELs,'qatr','qat') ;
ELwindspeed(ELl,ELs,'omnr','omn') = ELwindspeed_qat(ELl,ELs,'qatr','qat') ;

display Elwindspeed ;

*If we opt to model wind power generation using different wind turbine technlogies
*or sizes, we may have to include air densities specific to the measurement locations.
*SP: Added country index. Replace '0's in other GCC region with corresponding data.
Parameter ELairdensity(r,c) mass density of air in kg per cu. m at wind speed measurement conditions;
ELairdensity(r,c)=1.225;

*The power generated or transfered through a fluid is proportional to the velocity
*raised to the third power.
Parameter ELwindpower(ELl,ELs,r,c) rate of energy transfer in wind in W per sq. m of swept area;
ELwindpower(ELl,ELs,r,c)=0.5*ELairdensity(r,c)*(ELwindspeed(ELl,ELs,r,c))**3;
*Once the wind speed reaches the rated speed for the turbine, the production reaches a limit:

ELwindpower(ELl,ELs,r,c)$(ELwindspeed(ELl,ELs,r,c)>=ELratedspeed)=0.5*ELairdensity(r,c)*(ELratedspeed)**3;
ELwindpower(ELl,ELs,r,c)$(ELwindspeed(ELl,ELs,r,c)<ELcutinspeed)=0;
ELwindpower(ELl,ELs,r,c)$(ELwindspeed(ELl,ELs,r,c)>=ELcutoffspeed)=0;

*By taking the normalization approach, we remove the need to specify a sweep area
*or turbine conversion efficiency. Moreover, this approach simulates the wind turbine
*power output to be proportional to the power in the wind:
Parameter ELwindpowernorm(ELl,ELs,r,c) power generated normalized by maximum annual value (regional);
ELwindpowernorm(ELl,ELs,r,c)$rc(r,c)=ELwindpower(ELl,ELs,r,c)/smax((ELll,ELss),ELwindpower(ELll,ELss,r,c));

*The following table considers the impact of incrementally adding wind capacity
*in each region. These capacities are defined as the nominal peak output
*throughout the year since this is at the point of load. The wind contribution is
*multiplied by 0.96 to account for losses between generation and point of load.
Parameter ELdiffGWwind(ELl,ELs,r,c) difference in load resulting from introducing wind turbine output in GW;
ELdiffGWwind(ELl,ELs,r,c)=ELwindpowernorm(ELl,ELs,r,c)*ELwindcap(c)*0.96;


* Right now taking 10% of total CSP variable cost from IRENA (2013, p. 18):
*This value is 300 USD/MWhe converted to USD/MWhthermal using the 35.4% efficiency.
Table ELstoromcst(ELstorage,r,c)  Variable O&M cost for storing energy in MMUSD per TWh_thermal
               (west,sout,cent,east).ksa
moltensalt      0.11

+              (adwe,dewa,sewa,fewa).uae
moltensalt      0.11

+              (qatr.qat,kuwr.kuw,bahr.bah,omnr.omn)
moltensalt      0.11
;


Parameter ELcapfactor(ELp) capacity factors for dispatchable plants
/
Steam   0.885
Stscrub 0.885
CoalSteam 0.885
GT      0.923
CC      0.885
CCcon   0.885
Nuclear 0.860
*We assume below that CSP maintenance can be done when storage heat is used up
CSP     1
/
;

*Costs of ramping from Van den Bergh and Delarue (2015, p. 75) (converted to USD).
*Nuclear is forced not ramp up or down in the model.
Parameter ELrampcst(ELpd) costs of ramping up and down by dispatchable plant in mill. USD per dTW
/
Steam 1.61
Stscrub 1.61
CoalSteam 2.07
GT 0.92
CC 0.58
CCcon 0.58
/
;
ELrampcst(ELpd)=0;
*Can turn on the ramping cost by commenting above line.

*We estimate the conversion from GTtoCC adds 50% more capacity based on data on page 5-5 of KFUPM report.
Table ELcapadd(ELpp,ELp) a factor for adding capacity (only applicable to dispatchable tech)
         Steam  Stscrub GT  CC  GTtoCC   CCcon  Nuclear  CoalSteam
Steam    1
Stscrub         1
GT                      1
CC                          1
GTtoCC                  -1               1.5
Nuclear                                         1
CoalSteam                                                1
;
* Amounts of fuels used per GWh produced (i.e. efficiencies).
* Old-vintage efficiencies from actual SEC operation data.
* New-vintage efficiencies from KFUPM (2010) heat rates for proposed units. (e.g. p.3-7)
* New-vintage and converted CC are estimated to have thermal efficiencies of 50% CCcon (gas)
* and 55% for new CC.
* Nuclear plants' thermal efficiency calculated based on information from European Nuclear Society.
* EPA (2013, p. 5-4) claims a 1.33% increase in heat rate due to scrubber operation,
* we apply that to all fuels used in steam plants.
ELfuelburn('Stscrub',v,ELf,r,c)=ELfuelburn('Steam',v,ELf,r,c)*1.0133;
ELfuelburn('Stscrub',v,'Methane',r,c)=ELfuelburn('Steam',v,'methane',r,c);

* Rescale fuel burn to MMBBL Million Tonnes and trillion BTU per TWh
ELfuelburn(Elp,v,ELf,r,c)=1e-3*ELfuelburn(Elp,v,ELf,r,c);

*Design operating life for steam, GT, and CC from KFUPM generation report.
*Wind turbine lifetime taken from Rehman et al. (2003, p.578), Adaramola et al. (2014, p.67).
*CSP lifetime from NREL's SAM and NREL's Heath (2011).
Parameter ELlifetime(ELp) Design life of plant in units of time
/
Steam 35
Stscrub 35
CoalSteam 35
GT 25
CC 30
GTtoCC 20
CCcon 20
PV 25
CSP 30
Nuclear 60
Wind 20
/
;

Parameter ELrenprodlow(ELp,time) lower bound on renewables generation in TWh;
ELrenprodlow(ELp,time)=0;

*Parameter ELbldlow(ELp,time) lower bound on renewables bld in TWh;
*ELbldlow(ELp,time)=0;

Parameter ELbldlow(time) lower bound on bld in GW;
ELbldlow(time)=0;

Parameter ELbldlowTot lower bound on bld in GW;
ELbldlowTot=0;

Parameter ELbldlowELp(ELp) lower bound on bld in GW;
ELbldlowELp(ELp)=0;

Parameters ELretirement(ELp,v,time,r,c) capacity to be retired in GW,
           ELaddition(ELp,v,time,r,c) already-planned capacity addition in GW ;

ELretirement(ELp,v,time,r,c)=0;
ELaddition(ELp,v,time,r,c)=0;

* set existing capacities
ELexistcp.fx(ELpd,v,'t01',r,c)=ELexist(ELpd,v,r,c);
ELrenexistcp.fx(ELpsw,v,'t01',r,c)=ELexist(ELpsw,v,r,c);
ELbld.fx('CCcon','new',trun,r,c)=0;
ELgttocc.fx('GTtoCC','old','t01',r,c)=0.10*ELexist('GT','old',r,c);

*ELfconsump.up(ELpd,'HFO',trun,r,c)= ELfconsumpmax('HFO','t01',r,c);
*ELfconsump.up(ELpd,'diesel',trun,r,c)= ELfconsumpmax('diesel','t01',r,c);


Equations

ELobjective                power sector objective function
ELcaptot(time,r,c)           to display total regional capacity over time
ELoptot(time)              to check the sum of ELop and ELsolop
ELcapitalcostbal(time)           acumulates all capital purchase costs
ELopmaintbal(time)         accumulates operations and maintenance costs
ELfcons(ELpd,ELf,time,r,c)   balance of fuel use for power generation
ELfavail(ELf,time,r,c)       fuel supply constraint
ELfavailcr(Elf,time,r,c)        fuel supply constraint credited
ELgtconvlim(ELpd,v,time,r,c)  conversion limit for existing OCGT plants
ELcapbal(ELpd,v,time,r,c)     capacity balance constraint
ELrencapbalo(ELpsw,v,time,r,c) capacity balance for old renewable plants
ELrencapbaln(ELpsw,v,time,r,c) capacity balance for new renewable plants
ELcaplim(ELpd,v,ELl,ELs,ELday,time,r,c) electricity capacity constraints
ELnucconstraint(ELl,ELs,Elday,time,r,c) to force nuclear to operate continuously
ELsolcaplimo(ELppv,v,time,r,c) capacity constraint for non-dispatchable solar plants
ELsolcaplimn(ELppv,v,time,r,c)
ELwindcaplim(ELpw,v,time,r,c)
ELsolutil(ELppv,v,ELl,ELs,ELday,time,r,c) measures the operate for solar plants
ELwindutil(ELpw,v,ELl,ELs,ELday,time,r,c) measures the operate for wind plants
ELsolcapsum(time,r,c)  carries out interpolation within capacity step(s)
ELwindcapsum(time,r,c) carries out interpolation within capacity step(s)
ELupspinres(ELpd,ELl,ELs,ELday,time,r,c) up spinning reserve (in case of sudden drop in renewable gen)
*ELdnspinres(ELpd,ELl,ELs,ELday,time,r) down spinning reserve (in case of sudden rise in ren. gen.)
ELsup(ELl,ELs,ELday,time,r,c)  electricity supply constraints
ELdem(ELl,ELs,ELday,time,r,c)  electricity demand constraints
*ELrsrvreq(time,r,c)            electricity reserve margin
ELrsrvreq(time)            electricity reserve margin


ELsolenergybal(ELl,ELs,ELday,time,r,c) energy balance for solar collection field (CSP)
ELstorenergybal(ELl,ELs,ELday,time,r,c) energy balance for CSP storage mechanism
ELstorenergyballast(ELl,ELs,ELday,time,r,c) energy balance for CSP storage mechanism (last load segement in the day)
ELCSPcaplim(ELpcsp,v,ELl,ELs,ELday,time,r,c) capacity constraint for CSP plants
ELCSPutil(ELl,ELs,ELday,time,r,c)
ELCSPlanduselim(time,r,c)      To restrict land use to empirical usage per unit capacity
*ELtranscapbal(time,r,c,rr,cc)     electricity transportation capacity balance
*ELtranscaplim(ELl,ELs,ELday,time,r,c,rr,cc) electricity transportation capacity constraint
ELrenprodreq(ELpsw,v,time) renewable electricity generation requirement (not always imposed)
ELnucprodreq(ELpnuc,v,time)

*ELrenbldreq(ELpsw,v,time)
*ELbldreq(ELpd,v,time)

ELbldreq(time)
ELstorlim(ELpsw,ELl,ELs,ELday,time,r,c)
ELrampbal(ELpd,ELl,ELs,ELday,time,r,c) cost of ramping dispatchable plants in millions of USD

DELCapitalCost               dual from capital purchase
*ELImports(time)             dual from imports
*ELConstruct(time)           dual from construct
DELOpandmaint(time)          dual from opandmaint
DELbld(ELpd,v,time,r,c)        dual from Elbld
DELrenbld(ELpsw,v,time,r,c)     dual from ELrenbld
DELgttocc(Elpd,v,time,r,c)     dual from ELgttocc
DELop(ELpd,v,ELl,ELs,ELday,ELf,time,r,c)  dual from ELop
DELsolop(ELpsw,v,ELl,ELs,ELday,time,r,c)  dual from ELsolop
DELwindop(ELpsw,v,ELl,ELs,ELday,time,r,c)
DELexistcp(ELpd,v,time,r,c)    dual from ELexistcp
DELrenexistcp(ELpsw,v,time,r,c) dual from ELrenexistcp
DELsoloplevel(ELppv,v,time,r,c) dual from ELsoloplevel
DELwindoplevel(ELpw,v,time,r,c) dual from ELwindoplevel
DELupspincap(ELpd,v,ELl,ELs,ELday,ELf,time,r,c)  dual from ELupspincap
*DELdnspincap(ELpd,v,ELl,ELs,ELday,ELf,time,r)  dual from ELdnspincap
DELCSPlandarea(time,r,c)
DELheatstorin(ELl,ELs,ELday,time,r,c)
DELheatstorout(ELl,ELs,ELday,time,r,c)
DELheatstorage(ELl,ELs,ELday,time,r,c)
DELheatinstant(ELl,ELs,ELday,time,r,c)
*DELtrans(ELl,ELs,ELday,time,r,c,rr,cc)      dual from ELtrans
*DELtransbld(time,r,c,rr,cc)       dual from ELtransbld
*DELtransexistcp(time,r,c,rr,cc)   dual from ELtransexistcp
DELfconsump(ELpd,f,time,r,c)
DELfconsumpcr(f,time,r,c)
DELrampupcst(ELpd,ELl,ELs,ELday,time,r,c)
DELrampdncst(ELpd,ELl,ELs,ELday,time,r,c)
;
$offorder

ELobjective..
 ELz =e=sum(t,(ELCapitalCost(t)+ELOpandmaint(t))*ELdiscfact(t))
 +sum((Elpd,ELf,t,r,c)$rc(r,c),ELAPf(ELf,t,r,c)*ELfconsump(ELpd,ELf,t,r,c)*ELdiscfact(t))
*This is the cost to power sector and revenue to water sector. Running power only in isolation, it is included
* in the power objective since it takes electricity purchase from the water sector as exogenous.
* +sum((ELl,ELs,ELday,t,r,c)$rc(r,c), WAELsupply(ELl,ELs,ELday,t,r,c)*ELAPelwa(ELl,ELs,ELday,t,r,c)*WAdiscfact(t))
;

* Primal equations
ELcapitalcostbal(t)..
    sum((ELpd,v,r,c)$rc(r,c),ELCapital(ELpd,t,r,c)*(1-(capsub(ELpd,t))$ELpdsub(ELpd))*ELbld(ELpd,v,t,r,c)$( ((ELpcom(ELpd) and vn(v)) or (vo(v) and ELpgttocc(ELpd)))  ))
   +sum((ELpsw,v,r,c)$rc(r,c),ELCapital(ELpsw,t,r,c)*(1-(capsub(ELpsw,t))$ELprsub(ELpsw))*ELrenbld(ELpsw,v,t,r,c)$vn(v))
*   +sum((r,c,rr,cc)$(rc(r,c) and rc(rr,cc)), ELtranspurcst(r,c,t,rr,cc)*ELtransbld(t,r,c,rr,cc))
   -ELCapitalCost(t)
=e=0
;

ELopmaintbal(t)..  sum((ELpd,v,ELl,ELs,ELday,ELf,r,c)$(rc(r,c) and Elfuelburn(ELpd,v,ELf,r,c)>0 and Elpcom(ELpd)),
   ELomcst(ELpd,v,r,c)*ELop(ELpd,v,ELl,ELs,ELday,ELf,t,r,c))
   +sum((ELpd,v,ELl,ELs,ELday,ELf,r,c)$(fMPt(ELf,c) and rc(r,c) and Elfuelburn(ELpd,v,ELf,r,c)>0 and Elpcom(ELpd)),
   ELomcst(ELpd,v,r,c)*ELop_trade(ELpd,v,ELl,ELs,ELday,ELf,t,r,c))
   +sum((ELps,v,ELl,ELs,ELday,r,c)$rc(r,c),ELomcst(ELps,v,r,c)*ELsolop(ELps,v,ELl,ELs,ELday,t,r,c))
   +sum((ELpw,v,ELl,ELs,Elday,r,c)$rc(r,c),ELomcst(ELpw,v,r,c)*ELwindop(ELpw,v,ELl,ELs,ELday,t,r,c))
   +sum((ELpd,v,r,c)$rc(r,c),ELfixedOMcst(ELpd,t)*(
         sum(ELpp$( ((ELpcom(ELpp) and vn(v)) or (vo(v) and ELpgttocc(ELpp))) ),
         ELcapadd(ELpp,ELpd)*ELbld(ELpp,v,t,r,c))+ELexistcp(ELpd,v,t,r,c)))
   +sum((ELpsw,v,r,c)$rc(r,c),ELfixedOMcst(ELpsw,t)*(ELrenbld(ELpsw,v,t,r,c)$vn(v)+ELrenexistcp(ELpsw,v,t,r,c)))
   +sum((ELstorage,ELl,ELs,ELday,r,c)$rc(r,c),ELstoromcst(ELstorage,r,c)*ELheatstorage(ELl,ELs,ELday,t,r,c))
*   +sum((ELl,ELs,ELday,r,c,rr,cc)$(rc(r,c) and rc(rr,cc)),ELtransomcst(r,c,rr,cc)*ELtrans(ELl,ELs,ELday,t,r,c,rr,cc))
   +sum((ELpd,ELl,ELs,ELday,r,c)$rc(r,c),ELrampupcst(ELpd,ELl,ELs,ELday,t,r,c)+ELrampdncst(ELpd,ELl,ELs,ELday,t,r,c))
   -ELOpandmaint(t)
=e=0
;

ELsup(ELl,ELs,ELday,t,r,c)$rc(r,c)..
  sum((ELpd,v,ELf)$(Elfuelburn(ELpd,v,ELf,r,c)>0 and ELpcom(ELpd)),
    ELop(ELpd,v,ELl,ELs,ELday,ELf,t,r,c))
 +sum((ELpd,v,ELf)$(fMPt(ELf,c) and Elfuelburn(ELpd,v,ELf,r,c)>0 and ELpcom(ELpd)),
    ELop_trade(ELpd,v,ELl,ELs,ELday,ELf,t,r,c))
 +sum((ELps,v),ELsolop(ELps,v,ELl,ELs,ELday,t,r,c))
 +sum((ELpw,v),ELwindop(ELpw,v,ELl,ELs,ELday,t,r,c))
 +WAELsupply(ELl,ELs,ELday,t,r,c)
 -WAELconsump(ELl,ELs,ELday,t,r,c)
 -ELsupply(ELl,ELs,ELday,t,r,c)=g=0;
*  -sum((rr,cc)$rc(rr,cc),ELtrans(ELl,ELs,ELday,t,r,c,rr,cc))=g=0
;

$ontext
ELdem(ELl,ELs,ELday,t,rr,cc)$rc(rr,cc)..
*  sum((r,c)$rc(r,c),Eltransyield(r,c,rr,cc)*ELtrans(ELl,ELs,ELday,t,r,c,rr,cc))
 -WAELconsump(ELl,ELs,ELday,t,rr,cc)
* -ELRElcgw(ELl,ELs,ELday,t,rr,cc)*ELlchours(ELl,cc)*ELdaysinseason(ELs,ELday)
 =g=ELlchours(ELl,cc)*ELdaysinseason(ELs,ELday)*ELlcgw(ELl,ELs,ELday,rr,cc)*ELdemgro(t,rr,cc)
;
$offtext
$ontext
ELrsrvreq(t,rr,cc)$rc(rr,cc)..
  sum((ELpd,v),ELexistcp(ELpd,v,t,rr,cc))
 +sum((ELpd,v,ELpp)$(((ELpcom(ELpp) and vn(v)) or (vo(v) and ELpgttocc(ELpp))) and t_ind(t) > ELleadtime(ELpp)),
  ELcapadd(ELpp,ELpd)*ELbld(ELpp,v,t,rr,cc))
 +CSPreservecontr*sum((ELpcsp,v)$(vn(v) and t_ind(t) > ELleadtime(ELpcsp)),ELrenbld(ELpcsp,v,t,rr,cc))
 +CSPreservecontr*sum((ELpcsp,v),ELrenexistcp(ELpcsp,v,t,rr,cc))
 +WAELrsrvcontr(t,rr,cc)
=g=
  ELreserve*(ELlcgwmax(rr,cc)*ELdemgro(t,rr,cc)
*WAELpwrdemand is an estimate of the annual peak power demand for RO plants
 +WAELpwrdemand(t,rr,cc)/(hoursinayear/1000)
* +sum((ELl,ELs,Elday)$(ord(ELl)=ELlmax(rr,cc) and ord(ELs)=ELsmax(rr,cc) and ord(ELday)=ELdaymax(rr,cc)),ELRElcgw(ELl,ELs,Elday,t,rr,cc))
)
;
$offtext

ELrsrvreq(t)..
  sum((ELpd,v,rr,cc)$rc(rr,cc),ELexistcp(ELpd,v,t,rr,cc))
 +sum((ELpd,v,ELpp,rr,cc)$(((ELpcom(ELpp) and vn(v)) or (vo(v) and ELpgttocc(ELpp))) and rc(rr,cc) and t_ind(t) > ELleadtime(ELpp)),
  ELcapadd(ELpp,ELpd)*ELbld(ELpp,v,t,rr,cc))
 +CSPreservecontr*sum((ELpcsp,v,rr,cc)$(rc(rr,cc) and vn(v) and t_ind(t) > ELleadtime(ELpcsp)),ELrenbld(ELpcsp,v,t,rr,cc))
 +CSPreservecontr*sum((ELpcsp,v,rr,cc)$rc(rr,cc),ELrenexistcp(ELpcsp,v,t,rr,cc))
 +sum((rr,cc)$rc(rr,cc),WAELrsrvcontr(t,rr,cc))
=g=
  sum((rr,cc)$rc(rr,cc),ELreserve*(
 ELlcgwmax(rr,cc)*ELdemgro(t,rr,cc)
*WAELpwrdemand is an estimate of the annual peak power demand for RO plants
 +WAELpwrdemand(t,rr,cc)/(hoursinayear/1000)
* +sum((ELl,ELs,Elday)$(ord(ELl)=ELlmax(rr,cc) and ord(ELs)=ELsmax(rr,cc) and ord(ELday)=ELdaymax(rr,cc)),ELRElcgw(ELl,ELs,Elday,t,rr,cc))
            ))
;

ELfcons(ELpd,ELf,t,r,c)$rc(r,c).. ELfconsump(ELpd,ELf,t,r,c)
   -sum((v,ELl,ELs,ELday)$(Elfuelburn(ELpd,v,ELf,r,c)>0 and ELpcom(ELpd)),
    ELfuelburn(ELpd,v,ELf,r,c)*ELop(ELpd,v,ELl,ELs,ELday,ELf,t,r,c))
   -sum((v,ELl,ELs,ELday)$(ELfspin(ELf) and Elfuelburn(ELpd,v,ELf,r,c)>0 and ELpspin(ELpd)),
    ELusrfuelfrac*ELfuelburn(ELpd,v,ELf,r,c)*ELlchours(ELl,c)*ELdaysinseason(ELs,ELday)*ELupspincap(ELpd,v,ELl,ELs,ELday,ELf,t,r,c))=g=0;

* turns on quotas for fuels with administered prices in set ELfAP
ELfavail(ELf,t,r,c)$(rc(r,c) and (ElfAP(Elf,c) or ELfref(ELf)))..
 -sum(ELpd,ELfconsump(ELpd,ELf,t,r,c))
* -sum(ELpd$fMPt(ELf,c),ELfconsump_trade(ELpd,ELf,t,r,c))

  =g=-ELfconsumpmax(ELf,t,r,c)
$ontext
ELfavail(ELf,t,r,c)$(rc(r,c) and (ElfAP(Elf) or ELfref(ELf)))..
 -sum(ELpd$(ELpnoscrub(ELpd) or ELfnoHFO(ELf)) ,ELfconsump(ELpd,ELf,t,r,c))
  =g=-ELfconsumpmax(ELf,t,r,c)
$offtext
;

ELfavailcr(Elf,t,r,c)$rc(r,c)..
 -ELfconsumpcr(ELf,t,r,c)
 +sum(ELpd,ELfconsump(ELpd,ELf,t,r,c)) =g=0
;

ELcapbal(ELpd,v,t,r,c)$rc(r,c).. ELexistcp(ELpd,v,t,r,c)
 +ELaddition(ELpd,v,t+1,r,c)$(card(t)>1)
 -ELretirement(ELpd,v,t+1,r,c)$(card(t)>1)
 +sum(ELpp$( ((ELpcom(ELpp) and vn(v)) or (vo(v) and ELpgttocc(ELpp))) and t_ind(t) > ELleadtime(ELpp) ),
      ELcapadd(ELpp,ELpd)*ELbld(ELpp,v,t,r,c))
 -ELexistcp(ELpd,v,t+1,r,c) =g=0
;

ELrencapbalo(ELpsw,'old',t,r,c)$rc(r,c)..
  ELrenexistcp(ELpsw,'old',t,r,c)*(1-PVdegrade(r,c)$(ELppv(ELpsw)))
 -ELrenexistcp(ELpsw,'old',t+1,r,c) =g=0
;

ELrencapbaln(ELpsw,'new',t,r,c)$rc(r,c)..
  ELrenexistcp(ELpsw,'new',t,r,c)*(1-PVdegrade(r,c)$(ELppv(ELpsw)))
 +(ELrenbld(ELpsw,'new',t,r,c)*
  (1-PVdegrade(r,c)$(ELppv(ELpsw))) )$( t_ind(t) > ELleadtime(ELpsw))
 -ELrenexistcp(ELpsw,'new',t+1,r,c) =g=0
;

*To ensure that remaining convertible capacity can be positive in the last period
ELgtconvlim(ELpgttocc,vo,t,r,c)$rc(r,c)..
 -ELgttocc(ELpgttocc,vo,t+1,r,c)
 -ELbld(ELpgttocc,vo,t,r,c)
 +ELgttocc(ELpgttocc,vo,t,r,c) =g=0
;

ELcaplim(ELpd,v,ELl,ELs,ELday,t,r,c)$(rc(r,c) and ELpcom(ELpd))..
  ELcapfactor(ELpd)*ELlchours(ELl,c)*ELdaysinseason(ELs,ELday)*
 (ELexistcp(ELpd,v,t,r,c)
 +sum(ELpp$(((ELpcom(ELpp) and vn(v)) or (vo(v) and ELpgttocc(ELpp))) and t_ind(t) > ELleadtime(ELpp)),
  ELcapadd(ELpp,ELpd)*ELbld(ELpp,v,t,r,c))
 -sum(ELfspin$(ELpspin(ELpd) and ELfuelburn(ELpd,v,ELfspin,r,c)>0),
  ELupspincap(ELpd,v,ELl,ELs,ELday,ELfspin,t,r,c)))
 -sum(ELf$(Elfuelburn(ELpd,v,ELf,r,c)>0 and ELpcom(ELpd)),
  ELop(ELpd,v,ELl,ELs,ELday,ELf,t,r,c)
 +ELop_trade(ELpd,v,ELl,ELs,ELday,ELf,t,r,c)$fMPt(ELf,c) ) =g=0
;

* enfore nuclear as must run
ELnucconstraint(ELl,ELs,Elday,t,r,c)$rc(r,c)..
  ELcapfactor('Nuclear')*ELlchours(ELl,c)*ELdaysinseason(ELs,ELday)*(sum((ELpnuc,v),
  ELexistcp(ELpnuc,v,t,r,c))
 +sum((ELpnuc,vn)$( t_ind(t) > ELleadtime('Nuclear')),ELbld(ELpnuc,vn,t,r,c)))
 -sum((ELpnuc,v,ELf)$(Elfuelburn(ELpnuc,v,ELf,r,c)>0),
  ELop(ELpnuc,v,ELl,ELs,Elday,ELf,t,r,c)) =e=0
;

ELrampbal(ELpd,ELl,ELs,ELday,t,r,c)$rc(r,c)..
 -ELrampcst(ELpd)*
 (sum((v,ELf)$(ord(ELl)>1 and Elfuelburn(ELpd,v,ELf,r,c)>0 and ELpcom(ELpd)),
  ELop(ELpd,v,ELl,ELs,ELday,ELf,t,r,c)/ELlchours(ELl,c)-ELop(ELpd,v,ELl-1,ELs,ELday,ELf,t,r,c)/
       ELlchours(ELl-1,c))
 +sum((v,ELf)$(ord(ELl)=1 and Elfuelburn(ELpd,v,ELf,r,c)>0 and ELpcom(ELpd)),
  ELop(ELpd,v,ELl,ELs,ELday,ELf,t,r,c)/ELlchours(ELl,c)-ELop(ELpd,v,'L8',ELs,ELday,ELf,t,r,c)/
       ELlchours('L8',c)) )
 +ELrampupcst(ELpd,ELl,ELs,ELday,t,r,c)
 -ELrampdncst(ELpd,ELl,ELs,ELday,t,r,c) =e=0
;

ELsolcaplimo(ELppv,'old',t,r,c)$rc(r,c).. ELrenexistcp(ELppv,'old',t,r,c)*
 (  1$(card(trun)>1)+(1/ELlifetime(ELppv)*((1-PVdegrade(r,c))**ELlifetime(ELppv)-1)/log(1-PVdegrade(r,c)))$(card(trun)=1))
 -ELsolcap(c)*ELsoloplevel(ELppv,'old',t,r,c)=g=0
;
$ontext
ELsolcaplimn(ELppv,'new',t,r,c)$rc(r,c).. ELrenexistcp(ELppv,'new',t,r,c)*
  (  1$(card(trun)>1)+(1/ELlifetime(ELppv)*((1-PVdegrade(r,c))**ELlifetime(ELppv)-1)/log(1-PVdegrade(r,c)))$(card(trun)=1))
   +( ELrenbld(ELppv,'new',t,r,c)*(           1/ELlifetime(ELppv)*((1-PVdegrade(r,c))**ELlifetime(ELppv)-1)/log(1-PVdegrade(r,c)))$(card(trun)=1))$( t_ind(t) > ELleadtime(ELppv))
   -ELsolcap(c)*ELsoloplevel(ELppv,'new',t,r,c)=g=0
;
$offtext
ELsolcaplimn(ELppv,'new',t,r,c)$rc(r,c).. ELrenexistcp(ELppv,'new',t,r,c)*
  (  1$(card(trun)>1)+(1/ELlifetime(ELppv)*((1-PVdegrade(r,c))**ELlifetime(ELppv)-1)/log(1-PVdegrade(r,c)))$(card(trun)=1))
   +( ELrenbld(ELppv,'new',t,r,c)*(  1$(card(trun)>1)+(1/ELlifetime(ELppv)*((1-PVdegrade(r,c))**ELlifetime(ELppv)-1)/log(1-PVdegrade(r,c )))$(card(trun)=1)  ) )$(t_ind(t)>ELleadtime(ELppv))
   -ELsolcap(c)*ELsoloplevel(ELppv,'new',t,r,c)=g=0
;

$ontext
ELsolcaplimn(ELppv,'new',t,r)..
    ELrenexistcp(ELppv,'new',t,r)*
       (  1$(card(trun)>1)+(1/ELlifetime(ELppv)*((1-PVdegrade(r))**ELlifetime(ELppv)-1)/log(1-PVdegrade(r)))$(card(trun)=1)  )
   +( ELrenbld(ELppv,'new',t,r)*(  1$(card(trun)>1)+(1/ELlifetime(ELppv)*((1-PVdegrade(r))**ELlifetime(ELppv)-1)/log(1-PVdegrade(r)))$(card(trun)=1)  ) )$(t_ind(t)>ELleadtime(ELppv))
   -ELsolcap*ELsoloplevel(ELppv,'new',t,r)=g=0;
$offtext



ELsolcapsum(t,r,c)$rc(r,c).. -sum((ELppv,v),ELsoloplevel(ELppv,v,t,r,c))=g=-1
;

ELsolutil(ELppv,v,ELl,ELs,ELday,t,r,c)$rc(r,c).. sum(clc,ELccfrac(r,c,clc)*ELsolopfrac(ELppv,clc)*
   ELlchours(ELl,c)*ELdaysinseason(ELs,ELday)*ELdiffGWsol(ELl,ELs,r,c)*ELsoloplevel(ELppv,v,t,r,c))
   -ELsolop(ELppv,v,ELl,ELs,ELday,t,r,c)=g=0
;

ELwindcaplim(ELpw,v,t,r,c)$rc(r,c).. ELrenexistcp(ELpw,v,t,r,c)
  +ELrenbld(ELpw,v,t,r,c)$(vn(v) and t_ind(t) > ELleadtime(ELpw))
  -ELwindcap(c)*ELwindoplevel(ELpw,v,t,r,c)=g=0
;

ELwindcapsum(t,r,c)$rc(r,c).. -sum((ELpw,v),ELwindoplevel(ELpw,v,t,r,c))=g=-1
;

ELwindutil(ELpw,v,ELl,ELs,ELday,t,r,c)$rc(r,c)..
    ELlchours(ELl,c)*ELdaysinseason(ELs,ELday)*ELdiffGWwind(ELl,ELs,r,c)*ELwindoplevel(ELpw,v,t,r,c)
   -ELwindop(ELpw,v,ELl,ELs,ELday,t,r,c)=g=0
;

ELupspinres(ELpspin,ELl,ELs,ELday,t,r,c)$rc(r,c)..
   -ELsolspin*sum((ELppv,clc,v),ELccfrac(r,c,clc)*ELsolopfrac(ELppv,clc)*
    ELdiffGWsol(ELl,ELs,r,c)*ELsoloplevel(ELppv,v,t,r,c))
   -ELwindspin*sum((ELpw,v),ELdiffGWwind(ELl,ELs,r,c)*ELwindoplevel(ELpw,v,t,r,c))
   +sum((v,ELfspin)$(Elfuelburn(ELpspin,v,ELfspin,r,c)>0),
        ELupspincap(ELpspin,v,ELl,ELs,ELday,ELfspin,t,r,c))=g=0
;

ELsolenergybal(ELl,ELs,Elday,t,r,c)$rc(r,c)..
    (1-ELCSPtransloss)*ELlchours(ELl,c)*ELdaysinseason(ELs,ELday)*ELdirectirradiance(ELl,ELs,r,c)*ELCSPlandarea(t,r,c)
   -ELheatstorin(ELl,ELs,Elday,t,r,c)
   -ELheatinstant(ELl,ELs,ELday,t,r,c)$(ELsolcurve(ELl,ELs,r,c)>=ELminDNI)=g=0

;

ELstorenergybal(ELl,ELs,ELday,t,r,c)$(rc(r,c) and (ord(ELl)<card(ELl)))..
    ((1-ELstorehrloss)**ELlchours(ELl,c))*ELheatstorage(ELl,ELs,ELday,t,r,c)
   +(1-ELstorecycloss)*ELheatstorin(ELl,ELs,ELday,t,r,c)
   -ELheatstorout(ELl,ELs,ELday,t,r,c)
   -ELheatstorage(ELl+1,ELs,ELday,t,r,c)=e=0
;

*to connect the hourly curves from preceeding days:
ELstorenergyballast(ELl,ELs,ELday,t,r,c)$(rc(r,c) and (ord(ELl)=card(ELl)))..
    ((1-ELstorehrloss)**ELlchours(ELl,c))*ELheatstorage(ELl,ELs,ELday,t,r,c)
   +(1-ELstorecycloss)*ELheatstorin(ELl,ELs,ELday,t,r,c)
   -ELheatstorout(ELl,ELs,ELday,t,r,c)
   -ELheatstorage('L1',ELs,ELday,t,r,c)=e=0
;

ELCSPutil(ELl,ELs,ELday,t,r,c)$rc(r,c)..
    ELCSPthermaleff*(ELheatstorout(ELl,ELs,ELday,t,r,c)
     +ELheatinstant(ELl,ELs,ELday,t,r,c)$(ELsolcurve(ELl,ELs,r,c)>=ELminDNI))
   -sum((ELpcsp,v),ELsolop(ELpcsp,v,ELl,ELs,ELday,t,r,c))=g=0
;

ELCSPlanduselim(t,r,c)$rc(r,c).. -ELCSPlandarea(t,r,c)
   +ELaperturearea*sum((ELpcsp,v),ELrenexistcp(ELpcsp,v,t,r,c)
   +ELrenbld(ELpcsp,v,t,r,c)$(vn(v) and t_ind(t) > ELleadtime(ELpcsp)) )=g=0
;

ELCSPcaplim(ELpcsp,v,ELl,ELs,ELday,t,r,c)$rc(r,c)..
    ELcapfactor(ELpcsp)*ELlchours(ELl,c)*ELdaysinseason(ELs,Elday)*(
     ELrenexistcp(ELpcsp,v,t,r,c)
    +ELrenbld(ELpcsp,v,t,r,c)$(vn(v) and t_ind(t) > ELleadtime(ELpcsp)) )
    -ELsolop(ELpcsp,v,ELl,ELs,ELday,t,r,c)=g=0
;

ELstorlim(ELpcsp,ELl,ELs,ELday,t,r,c)$rc(r,c).. -ELheatstorage(ELl,ELs,ELday,t,r,c)
  +sum(v,(ELrenexistcp(ELpcsp,v,t,r,c)+ELrenbld(ELpcsp,v,t,r,c)$(vn(v) and t_ind(t) > ELleadtime(ELpcsp))))*CSPstoragehours/ELCSPthermaleff*ELdaysinseason(ELs,ELday)=g=0
;

ELrenprodreq(ELpsw,v,t)$vn(v) .. sum((ELl,ELs,ELday,r,c)$(rc(r,c) and ELps(ELpsw)),ELsolop(ELpsw,v,ELl,ELs,ELday,t,r,c))
  +sum((ELl,ELs,Elday,r,c)$(rc(r,c) and ELpw(ELpsw)),ELwindop(ELpsw,v,ELl,ELs,ELday,t,r,c))=g=ELrenprodlow(ELpsw,t)
;

ELnucprodreq(ELpnuc,v,t)$vn(v).. sum((ELl,ELs,Elday,ELf,r,c)$(rc(r,c) and Elfuelburn(ELpnuc,v,ELf,r,c)>0),ELop(ELpnuc,v,ELl,ELs,ELday,ELf,t,r,c))=g=ELrenprodlow(ELpnuc,t)
;

*ELrenbldreq(ELpsw,v,t)$vn(v) .. sum(r,ELrenbld(ELpsw,v,t,r))=g=ELbrenldlow(ELpsw,t)
*;

*ELbldreq(ELpd,v,t)$(ELpcom(ELpd) and vn(v)) .. sum(r,ELbld(ELpd,v,t,r))=g=ELbldlow(ELpd,t)
*;

ELbldreq(t).. sum((r,c,v)$(rc(r,c) and vn(v)), sum(ELpnuc,ELbld(ELpnuc,v,t,r,c))+sum(ELpsw,ELrenbld(ELpsw,v,t,r,c)) )=g=ELbldlow(t);
*$(ELbldlowELp(ELpnuc)>0)
*$(ELbldlowELp(ELpsw)>0)

$ontext
*transmission balances

ELtranscapbal(t,r,c,rr,cc)$(rc(r,c) and rc(rr,cc)).. ELtransexistcp(t,r,c,rr,cc)+ELtransbld(t-ELtransleadtime(r,c,rr,cc),r,c,rr,cc)
   -ELtransexistcp(t+1,r,c,rr,cc)=g=0
;

ELtranscaplim(ELl,ELs,ELday,t,r,c,rr,cc)$(rc(r,c) and rc(rr,cc)).. ELlchours(ELl,c)*ELdaysinseason(ELs,ELday)*(ELtransexistcp(t,r,c,rr,cc)
   +ELtransbld(t-ELtransleadtime(r,c,rr,cc),r,c,rr,cc))
   -ELtrans(ELl,ELs,ELday,t,r,c,rr,cc)=g=0
;
$offtext

* Dual equations

*DELimports(t)..  1*ELdiscfact(t)=g=-DELpurchbal(t);
DELCapitalCost(t).. 1*ELdiscfact(t)=g=-DELCapitalCostbal(t)
;
DELOpandmaint(t).. 1*ELdiscfact(t)=g=-DELopmaintbal(t)
;

DELfconsump(ELpd,ELf,t,r,c)$rc(r,c)..
* sets prices to marginal values for selected fules in ELfMP
  ( (Dfdem(ELf,t,r,c)*ELdiscfact(t)*(1-capsub(ELpd,t)$(partialdereg=1)))$ELfup(ELf)
* dual variable for refined products (HFO, diesel) not available because no refining sector
* instead price is set in deregulated scenario definition in solve_models.gms
*   +(DRFdem(ELf,t,r,c)*ELdiscfact(t)*(1-capsub(ELpd,t)$(partialdereg=1)))$ELfref(ELf)
  +RFintlprice(ELf,t)$ELfref(ELf)

  )$(ElfMP(ELf,c))

* turns on administered prices
  +( ELAPf(ELf,t,r,c)*ELdiscfact(t))$(ELfAP(ELf,c))
  =g= DELfcons(ELpd,ELf,t,r,c)
     -DELfavail(ELf,t,r,c)$((ElfAP(ELf,c) or ELfref(ELf)) )
     +DELfavailcr(Elf,t,r,c)
;

DELfconsumpcr(ELf,t,r,c)$rc(r,c)..
 -fcr(ELf,t,c)*ELdiscfact(t) =g= -DELfavailcr(Elf,t,r,c)
;


DELbld(ELpd,v,t,r,c)$(rc(r,c) and ((ELpcom(ELpd) and vn(v)) or (vo(v) and ELpgttocc(ELpd))) )..
0=g=
  DELCapitalCostbal(t)*ELCapital(ELpd,t,r,c)*(1-(capsub(ELpd,t))$ELpdsub(ELpd))
  +sum(ELpp, ELcapadd(ELpd,ELpp)*DELopmaintbal(t)*ELfixedOMcst(ELpp,t))
*((ELpcom(ELpp) and vn(v)) or (vo(v) and ELpgttocc(ELpp))) and
*$((ELpcom(ELpp) and vn(v)) or (vo(v) and ELpgttocc(ELpp)))

 -DELgtconvlim(ELpd,v,t,r,c)$(ELpgttocc(ELpd) and vo(v))
 +sum(ELpp,DELcapbal(ELpp,v,t,r,c)*ELcapadd(ELpd,ELpp))$(t_ind(t) > ELleadtime(ELpd))
 +sum((ELpp,ELl,ELs,ELday)$(t_ind(t) > ELleadtime(ELpd)) ,
       ELcapfactor(ELpp)*ELlchours(ELl,c)*ELdaysinseason(ELs,ELday)*ELcapadd(ELpd,ELpp)*DELcaplim(ELpp,v,ELl,ELs,ELday,t,r,c))
 +sum(ELpp$( (t_ind(t) > ELleadtime(ELpd))) ,DELrsrvreq(t)*ELcapadd(ELpd,ELpp))
 +sum((ELl,ELs,ELday)$(ELpnuc(ELpd) and vn(v) and t_ind(t) > ELleadtime(ELpd)),
         ELcapfactor(ELpd)*ELlchours(ELl,c)*ELdaysinseason(ELs,ELday)*DELnucconstraint(ELl,ELs,Elday,t,r,c))
*  +DELbldreq(Elpd,v,t)$(ELpcom(ELpd) and vn(v));
  +DELbldreq(t)$(ELpnuc(ELpd) and vn(v))
;
*and ELbldlowELp(ELpd)>0


DELgttocc(ELpgttocc,vo,t,r,c)$rc(r,c).. 0=g=DELgtconvlim(ELpgttocc,vo,t,r,c)
  -DELgtconvlim(ELpgttocc,vo,t-1,r,c)
;

$ontext
DELtrans(ELl,ELs,ELday,t,r,c,rr,cc)$(rc(r,c) and rc(rr,cc))..0=g=DELopmaintbal(t)*ELtransomcst(r,c,rr,cc)
  -DELsup(ELl,ELs,ELday,t,r,c)
  +DELdem(ELl,ELs,ELday,t,rr,cc)*ELtransyield(r,c,rr,cc)
  -DELtranscaplim(ELl,ELs,ELday,t,r,c,rr,cc)
*  -DELtradelim(t,ELl,ELs,ELday,c)$(tradelim=1 and not sameas(c,cc))
;

DELtransbld(t,r,c,rr,cc)$(rc(r,c) and rc(rr,cc)).. 0=g=DELCapitalCostbal(t)*ELtranspurcst(r,c,t,rr,cc)
  +DELtranscapbal(t+ELtransleadtime(r,c,rr,cc),r,c,rr,cc)
  +sum((ELl,ELs,ELday),ELlchours(ELl,c)*ELdaysinseason(ELs,ELday)*DELtranscaplim(ELl,ELs,ELday,t+ELtransleadtime(r,c,rr,cc),r,c,rr,cc))
;

DELtransexistcp(t,r,c,rr,cc)$(rc(r,c) and rc(rr,cc))..
   0=n=DELtranscapbal(t,r,c,rr,cc)-DELtranscapbal(t-1,r,c,rr,cc)
  +sum((ELl,ELs,ELday),ELlchours(ELl,c)*ELdaysinseason(ELs,ELday)*DELtranscaplim(ELl,ELs,ELday,t,r,c,rr,cc))
;
$offtext

DELop(ELpd,v,ELl,ELs,ELday,ELf,t,r,c)$(rc(r,c) and Elfuelburn(ELpd,v,ELf,r,c)>0 and ELpcom(ELpd))..
   0=g=
*  -DELtradesup(t,ELl,ELs,ELday,c)$(ELfMP(ELf) and tradelim=1)
  +DELopmaintbal(t)*ELomcst(ELpd,v,r,c)
  -DELcaplim(ELpd,v,ELl,ELs,ELday,t,r,c)
  +DELsup(ELl,ELs,ELday,t,r,c)
  -DELfcons(ELpd,ELf,t,r,c)*ELfuelburn(ELpd,v,ELf,r,c)
  -DELnucconstraint(ELl,ELs,Elday,t,r,c)$(ELpnuc(ELpd))
  -sum((ksec,EMcp)$ELsect(ksec),EMfactors(ksec,ELf,EMcp)*DEMquantbal(ksec,EMcp,t,c))
  +DELnucprodreq(ELpd,v,t)$(vn(v) and ELpnuc(ELpd))
  -ELrampcst(ELpd)*
    ( (DELrampbal(ELpd,ELl,ELs,ELday,t,r,c)/ELlchours(ELl,c)-DELrampbal(ELpd,ELl+1,ELs,ELday,t,r,c)/ELlchours(ELl,c))$(ord(ELl)<card(ELl))
     +(DELrampbal(ELpd,ELl,ELs,ELday,t,r,c)/ELlchours(ELl,c)-DELrampbal(ELpd,'L1',ELs,ELday,t,r,c)/ELlchours(ELl,c))$(ord(ELl)=card(ELl)) )
;

DELexistcp(ELpd,v,t,r,c)$rc(r,c)..
  0=n=
  DELcapbal(ELpd,v,t,r,c)-DELcapbal(ELpd,v,t-1,r,c)
  +DELopmaintbal(t)*ELfixedOMcst(ELpd,t)
  +sum((ELl,ELs,ELday)$(ELpcom(ELpd)),ELcapfactor(ELpd)*ELlchours(ELl,c)*
        ELdaysinseason(ELs,ELday)*DELcaplim(ELpd,v,ELl,ELs,ELday,t,r,c))
  +sum((ELl,ELs,ELday)$(ELpnuc(ELpd)),ELcapfactor(ELpd)*ELlchours(ELl,c)*
        ELdaysinseason(ELs,ELday)*DELnucconstraint(ELl,ELs,Elday,t,r,c))
  +DELrsrvreq(t)
;

DELrenbld(ELpsw,v,t,r,c)$(rc(r,c) and vn(v)).. 0=g=DELCapitalCostbal(t)*ELCapital(ELpsw,t,r,c)*(1-(capsub(ELpsw,t))$ELprsub(ELpsw))
  +DELopmaintbal(t)*ELfixedOMcst(ELpsw,t)
  +( DELrencapbal(ELpsw,v,t,r,c)*(1-PVdegrade(r,c)$(ELppv(ELpsw))) )$(t_ind(t) > ELleadtime(ELpsw))
  +DELwindcaplim(ELpsw,v,t,r,c)$(ELpw(ELpsw) and t_ind(t) > ELleadtime(ELpsw))
  +(DELsolcaplim(ELpsw,v,t,r,c)*(  1$(card(trun)>1)+(1/ELlifetime(ELpsw)*((1-PVdegrade(r,c))**ELlifetime(ELpsw)-1)/log(1-PVdegrade(r,c)))$(card(trun)=1)))$(ELppv(ELpsw) and t_ind(t) > ELleadtime(ELpsw))
  +ELaperturearea*DELCSPlanduselim(t,r,c)$(ELpcsp(ELpsw) and t_ind(t) > ELleadtime(ELpsw))
  +sum((ELl,ELs,Elday)$(ELpcsp(ELpsw) and t_ind(t) > ELleadtime(ELpsw)),
         ELcapfactor(ELpsw)*ELlchours(ELl,c)*ELdaysinseason(ELs,Elday)*
         DELCSPcaplim(ELpsw,v,ELl,ELs,ELday,t,r,c))
*  +DELrenbldreq(ELpsw,v,t)
  +DELbldreq(t)$(vn(v))
  +(CSPstoragehours/ELCSPthermaleff*sum((ELl,ELs,ELday),ELdaysinseason(ELs,ELday)*DELstorlim(ELpsw,ELl,ELs,ELday,t,r,c)))$(ELpcsp(ELpsw) and t_ind(t) > ELleadtime(ELpsw))
  +CSPreservecontr*DELrsrvreq(t)$(ELpcsp(ELpsw) and t_ind(t) > ELleadtime(ELpsw))
;
*ELbldlowELp(ELpsw)>0 and


DELsolop(ELps,v,ELl,ELs,ELday,t,r,c)$rc(r,c).. 0=g=DELopmaintbal(t)*ELomcst(ELps,v,r,c)
  +DELsup(ELl,ELs,ELday,t,r,c)
  -DELsolutil(ELps,v,ELl,ELs,ELday,t,r,c)$(ELppv(ELps))
  -DELCSPutil(ELl,ELs,ELday,t,r,c)$(ELpcsp(ELps))
  -DELCSPcaplim(ELps,v,ELl,ELs,ELday,t,r,c)$(ELpcsp(ELps))
  +DELrenprodreq(ELps,v,t)$vn(v)
  +DELtradebal(t,ELl,ELs,ELday,c)$((rentrade=1) and call(c))
;

DELrenexistcp(ELpsw,v,t,r,c)$rc(r,c).. 0=n=DELrencapbal(ELpsw,v,t,r,c)*(1-PVdegrade(r,c)$(ELppv(ELpsw)))
  -DELrencapbal(ELpsw,v,t-1,r,c)
  +DELopmaintbal(t)*ELfixedOMcst(ELpsw,t)
  +DELwindcaplim(ELpsw,v,t,r,c)$(ELpw(ELpsw))
  +(DELsolcaplim(ELpsw,v,t,r,c)*(  1$(card(trun)>1)+(1/ELlifetime(ELpsw)*((1-PVdegrade(r,c))**ELlifetime(ELpsw)-1)/log(1-PVdegrade(r,c)))$(card(trun)=1)))$(ELppv(ELpsw))
  +ELaperturearea*DELCSPlanduselim(t,r,c)$(ELpcsp(ELpsw))
  +sum((ELl,ELs,ELday),DELstorlim(ELpsw,ELl,ELs,ELday,t,r,c)*CSPstoragehours/ELCSPthermaleff*ELdaysinseason(ELs,ELday))$(ELpcsp(ELpsw))
  +sum((ELl,ELs,ELday),ELcapfactor(ELpsw)*ELlchours(ELl,c)*ELdaysinseason(ELs,Elday)*DELCSPcaplim(ELpsw,v,ELl,ELs,ELday,t,r,c))$(ELpcsp(ELpsw))
  +CSPreservecontr*DELrsrvreq(t)$ELpcsp(ELpsw)
;

DELsoloplevel(ELppv,v,t,r,c)$rc(r,c).. 0=g=-DELsolcaplim(ELppv,v,t,r,c)*ELsolcap(c)
  +sum((ELl,ELs,ELday,clc),ELccfrac(r,c,clc)*ELsolopfrac(ELppv,clc)*ELlchours(ELl,c)*ELdaysinseason(ELs,ELday)
         *ELdiffGWsol(ELl,ELs,r,c)*DELsolutil(ELppv,v,ELl,ELs,ELday,t,r,c))
  -DELsolcapsum(t,r,c)
  -ELsolspin*sum((ELpspin,ELl,ELs,ELday,clc),ELccfrac(r,c,clc)*ELsolopfrac(ELppv,clc)*ELdiffGWsol(ELl,ELs,r,c)*DELupspinres(ELpspin,ELl,ELs,ELday,t,r,c))
;

DELwindop(ELpw,v,ELl,ELs,ELday,t,r,c)$rc(r,c)..0=g=DELopmaintbal(t)*ELomcst(ELpw,v,r,c)
  +DELsup(ELl,ELs,ELday,t,r,c)
  +DELrenprodreq(ELpw,v,t)$vn(v)
  -DELwindutil(ELpw,v,ELl,ELs,ELday,t,r,c)
  +DELtradebal(t,ELl,ELs,ELday,c)$((rentrade=1) and call(c))
;

DELwindoplevel(ELpw,v,t,r,c)$rc(r,c).. 0=g=-DELwindcaplim(ELpw,v,t,r,c)*ELwindcap(c)
  +sum((ELl,ELs,ELday),ELlchours(ELl,c)*ELdaysinseason(ELs,ELday)*ELdiffGWwind(ELl,ELs,r,c)*DELwindutil(ELpw,v,ELl,ELs,ELday,t,r,c))
  -DELwindcapsum(t,r,c)
  -ELwindspin*sum((ELpspin,ELl,ELs,ELday),ELdiffGWwind(ELl,ELs,r,c)*DELupspinres(ELpspin,ELl,ELs,ELday,t,r,c))
;

DELupspincap(ELpspin,v,ELl,ELs,ELday,ELfspin,t,r,c)$(rc(r,c) and Elfuelburn(ELpspin,v,ELfspin,r,c)>0)..
   0=g=DELupspinres(ELpspin,ELl,ELs,ELday,t,r,c)
  -ELlchours(ELl,c)*ELdaysinseason(ELs,ELday)*DELcaplim(ELpspin,v,ELl,ELs,ELday,t,r,c)
  -ELusrfuelfrac*ELlchours(ELl,c)*ELdaysinseason(ELs,ELday)*Elfuelburn(ELpspin,v,ELfspin,r,c)*DELfcons(ELpspin,ELfspin,t,r,c)
;

DELCSPlandarea(t,r,c)$rc(r,c)..
   0=g=sum((ELl,ELs,ELday),(1-ELCSPtransloss)*ELdirectirradiance(ELl,ELs,r,c)*DELsolenergybal(ELl,ELs,ELday,t,r,c)*ELlchours(ELl,c)*ELdaysinseason(ELs,ELday))
  -DELCSPlanduselim(t,r,c)
;

DELheatstorin(ELl,ELs,ELday,t,r,c)$rc(r,c).. 0=g=-DELsolenergybal(ELl,ELs,ELday,t,r,c)
  +(1-ELstorecycloss)*DELstorenergybal(ELl,ELs,ELday,t,r,c)$(ord(ELl)<card(ELl))
  +(1-ELstorecycloss)*DELstorenergyballast(ELl,ELs,ELday,t,r,c)$(ord(ELl)=card(ELl))
;

DELheatstorout(ELl,ELs,ELday,t,r,c)$rc(r,c).. 0=g=-DELstorenergybal(ELl,ELs,ELday,t,r,c)$(ord(ELl)<card(ELl))
  +ELCSPthermaleff*DELCSPutil(ELl,ELs,ELday,t,r,c)
  -DELstorenergyballast(ELl,ELs,ELday,t,r,c)$(ord(ELl)=card(ELl))
;

DELheatstorage(ELl,ELs,ELday,t,r,c)$rc(r,c).. 0=g=((1-ELstorehrloss)**ELlchours(ELl,c))*DELstorenergybal(ELl,ELs,ELday,t,r,c)$(ord(ELl)<card(ELl))
  -DELstorenergybal(ELl-1,ELs,ELday,t,r,c)
  +((1-ELstorehrloss)**ELlchours(ELl,c))*DELstorenergyballast(ELl,ELs,ELday,t,r,c)$(ord(ELl)=card(ELl))
  -DELstorenergyballast('L8',ELs,ELday,t,r,c)$(ord(ELl)=1)
  -sum(ELpcsp,DELstorlim(ELpcsp,ELl,ELs,ELday,t,r,c))
  +sum(ELstorage,DELopmaintbal(t)*ELstoromcst(ELstorage,r,c))
;

DELheatinstant(ELl,ELs,ELday,t,r,c)$(rc(r,c) and ELsolcurve(ELl,ELs,r,c)>=ELminDNI)..
   0=g=-DELsolenergybal(ELl,ELs,ELday,t,r,c)
  +ELCSPthermaleff*DELCSPutil(ELl,ELs,ELday,t,r,c)
;

DELrampupcst(ELpd,ELl,ELs,ELday,t,r,c)$rc(r,c).. 0=g=DELrampbal(ELpd,ELl,ELs,ELday,t,r,c)
 +DELopmaintbal(t)
;

DELrampdncst(ELpd,ELl,ELs,ELday,t,r,c)$rc(r,c).. 0=g=-DELrampbal(ELpd,ELl,ELs,ELday,t,r,c)
 +DELopmaintbal(t)
;
