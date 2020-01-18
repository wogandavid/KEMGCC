*Cement sub-model used in KAPSARC Energy Model (KEM) - Expanded to GCC countries
*+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

*CMop.fx(CMm,CMp,CMf,trun,r,c) = 0;
*CMELconsump.fx(ELl,ELs,ELday,trun,r,c) = 0;
*CMfconsump.fx(f,trun,r,c) = 0;

$ontext
Cement Model for Saudi Arabia
All the kiln technologies considered in this model are for dry processes. Three
cement types are represented; Portland Types I and V, and Pozzolan cement. According
to El-Nagadi (2007), these represent 99% of domestic cement production. Varying
by composition, clinker is produced according to international standards for each
type of cement. Calcite, or calcium carbonate, is used as a proxy for limestone.
Complementing production, the model may also import finished cements and clinker.
$offtext
*+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
*option LP=cbc;

*option LP=pathnlp;
*option MCP=path;
*option limrow=1000;
*option limcol=1000;
*option decimals=6;

*$include C:\Users\Walid Matar\Desktop\Macros.gms
*$include C:\Users\Walid Matar\Desktop\SetsandVariables.gms
*+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
Parameter CMELprice(ELl,ELs,ELday,c) price paid by cement industry to power sector in million USD per TWh;
CMELprice(ELl,ELs,ELday,c)=999999;
CMELprice(ELl,ELs,ELday,'ksa')=34.67;
CMELprice('L1','Summ','wday','ksa')=0.1*1000/3.75;
CMELprice('L2','Summ','wday','ksa')=0.1*1000/3.75;
CMELprice('L3','Summ','wday','ksa')=0.15*1000/3.75;
CMELprice('L4','Summ','wday','ksa')=0.26*1000/3.75;
CMELprice('L5','Summ','wday','ksa')=0.26*1000/3.75;
CMELprice('L6','Summ','wday','ksa')=0.15*1000/3.75;
CMELprice('L7','Summ','wday','ksa')=0.15*1000/3.75;
CMELprice('L8','Summ','wday','ksa')=0.15*1000/3.75;
CMELprice('L1','Summ','wendhol','ksa')=0.1*1000/3.75;
CMELprice('L2','Summ','wendhol','ksa')=0.1*1000/3.75;
CMELprice('L3','Summ','wendhol','ksa')=0.15*1000/3.75;
CMELprice('L4','Summ','wendhol','ksa')=0.15*1000/3.75;
CMELprice('L5','Summ','wendhol','ksa')=0.15*1000/3.75;
CMELprice('L6','Summ','wendhol','ksa')=0.15*1000/3.75;
CMELprice('L7','Summ','wendhol','ksa')=0.15*1000/3.75;
CMELprice('L8','Summ','wendhol','ksa')=0.1*1000/3.75;

*34.67 million USD per TWh is equivalent to 0.13 SAR per kWh.
;
*Discount factors:
Parameters CMdiscfact(time) discount factors for cement sector;

* Normalizing number of hours each load segment by total annual hours to
* distribute electricity consumption over all the load segments:

* Number of hours in a day
Scalar     Hoursinaday /24/
Parameters CMELlchrsfraction(ELl,c);
        CMELlchrsfraction(ELl,c)=ELlchours(ELl,c)/sum(ELll,ELlchours(ELll,c));

*Raw material costs from Al-Jazirah Capital (2011, p.2) and NCB Capital correspondence.
*Although these values exclude transportation costs, raw materials are usually mined
*on or near the manufacturing site. MAY REVISE IF BETTER SOURCES ARE OBTAINED.
Parameter CMfeedcst(CMcr,time,r,c) cost of feedstock in millions of USD per million ton;
CMfeedcst('CaCO3',time,r,'ksa')=6.25/3.75;
CMfeedcst('Sand',time,r,'ksa')=5/3.75;
CMfeedcst('Clay',time,r,'ksa')=15/3.75;
CMfeedcst('Irono',time,r,'ksa')=18.85/3.75;
CMfeedcst('Gypsum',time,r,'ksa')=10/3.75;
CMfeedcst('Pozzn',time,r,'ksa')=75/3.75;

*Fuel prices from KFUPM Generation Report p. 3-9.
Table CMAPf(f,time,r,c) administered price for fuels
                 (east,cent,west,sout).ksa     (adwe,dewa,sewa,fewa).uae  qatr.qat  kuwr.kuw bahr.bah omnr.omn
*Units in million USD per trillion BTU
Methane.t01       0.75                          99                         99        99       99       99
*Units in million USD per million barrels (oil price from Al-Rajhi (2012) p.10)
Arabheavy.t01     6                             99                         99        99       99       99
*Units in million USD per million tons
HFO.t01           14.05                         99                         99        99       99       99
*Units in million USD per million tons
Diesel.t01        26.66                         99                         99        99       99       99

* Calibrated to 2011 based on Al-Nagadi (2007) and CSDI production/exports/imports.
Table CMdemval(CMcf,time,rr,cc) cement demand in millions of metric tons
           west.ksa      sout.ksa        cent.ksa        east.ksa    (adwe,dewa,sewa,fewa).uae  qatr.qat  kuwr.kuw bahr.bah omnr.omn
PortI.t01   11.53         6.17            13.17           10.29       0.0                        0.0       0.0      0.0      0.0
PortV.t01   3.16          1.69            3.61            2.82        0.0                        0.0       0.0      0.0      0.0
PozzC.t01   1.11          0.59            1.26            0.99        0.0                        0.0       0.0      0.0      0.0
;
Loop(time,CMdemval(CMcf,time+1,rr,cc)$rc(rr,cc)=CMdemval(CMcf,time,rr,cc)*1.03);
;
Parameter CMfeedsuplim(CMcr,time,r,c) feedstock supply limit in millions of tons;
CMfeedsuplim(CMcr,time,r,c)$rc(r,c)=9e9;
;
*The fuel allocation for HFO and methane is based on Saudi Aramco (2009) p.19, in
*which the author details the 2011-2015 allocation values.
$ontext
Parameter CMfconsumpmax(CMf,time,r,c) fuel supply limit;
*Methane in trillion BTU, Crude in million bbl, HFO in million tons
CMfconsumpmax('Methane',time,'west','ksa')=0;
CMfconsumpmax('Methane',time,'sout','ksa')=0;
CMfconsumpmax('Methane',time,'cent','ksa')=25.177;
CMfconsumpmax('Methane',time,'east','ksa')=42.671;
CMfconsumpmax('Methane',time,'cent','ksa')=38.008;
CMfconsumpmax('Methane',time,'east','ksa')=36.451;
$offtext
Table CMfconsumpmax(CMf,time,r,c) fuel supply limit
                 west.ksa      sout.ksa        cent.ksa        east.ksa    (adwe,dewa,sewa,fewa).uae  qatr.qat  kuwr.kuw bahr.bah omnr.omn
Methane.t01       0             0               38.008          36.451      1                          1         1        1        1
HFO.t01           1.953         0.925           0.695           0.465       1                          1         1        1        1
Arabheavy.t01     0             0.584           3.358           5.694       1                          1         1        1        1
Diesel.t01        0             0               0               0           1                          1         1        1        1
;

CMfconsumpmax('Methane',time,r,c)$rc(r,c)=CMfconsumpmax('Methane',time,r,c)*3066/2951.755;
CMfconsumpmax('Arabheavy',time,r,c)$rc(r,c)=CMfconsumpmax('Arabheavy',time,r,c)*1.1;

Parameter CMfconsumpmaxcr (CMf,time,r,c) supply constraint for allocated fuel

Table atomsub(CMcl,CMma) number of atoms in one mole of molecule CMcl
        Ca  O   Si  Al  Fe
CaO     1   1   0   0   0
SiO2    0   2   1   0   0
Al2O3   0   3   0   2   0
Fe2O3   0   3   0   0   2
C3S     3   5   1   0   0
C2S     2   4   1   0   0
C3A     3   6   0   2   0
C4AF    4   10  0   2   2
;
*Kiln mass inputs are from stoichiometric calculations. According to van Oss (2005, p.33),
*CKD is produced at a mass equivalent to 15 to 20% of the clinker produced. So the
*split 83%/17% is made in the mass balance. Based on stoichiometric calculations,
*CaCO3 -> CaO + CO2 results in 65% of raw mix products being CSAF.
Table CMmassout(CMm,CMmm,CMp) to specify mass balance relationships
                   crushing milling mixing1 mixing2I calcining1 sinteringI cooling grinding
CaCO3.CaCO3c       1        0       0       0        0          0          0       0
CaCO3c.CaCO3SAF    0        0       1       0        0          0          0       0
Sand.CaCO3SAF      0        0       1       0        0          0          0       0
Clay.CaCO3SAF      0        0       1       0        0          0          0       0
Irono.CaCO3SAF     0        0       1       0        0          0          0       0
CaCO3SAF.CaCO3SAFm 0        1       0       0        0          0          0       0
CaCO3SAFm.CSAF     0        0       0       0        0.65       0          0       0
CaCO3SAFm.CO2      0        0       0       0        0.35       0          0       0
CSAF.ClinkIh       0        0       0       0        0          0.83       0       0
CSAF.CKD           0        0       0       0        0          0.17       0       0
Gypsum.PortIp      0        0       0       1        0          0          0       0
ClinkI.PortIp      0        0       0       1        0          0          0       0
ClinkIh.ClinkI     0        0       0       0        0          0          1       0
ClinkVh.ClinkV     0        0       0       0        0          0          1       0
ClinkPh.ClinkP     0        0       0       0        0          0          1       0
PortIp.PortI       0        0       0       0        0          0          0       1
PortVp.PortV       0        0       0       0        0          0          0       1
PozzCp.PozzC       0        0       0       0        0          0          0       1

+                mixing2V mixing2P calciningph sinteringphI calciningphpc sinteringphpcI
Gypsum.PortVp    1        0        0           0            0             0
ClinkV.PortVp    1        0        0           0            0             0
Gypsum.PozzCp    0        1        0           0            0             0
Pozzn.PozzCp     0        1        0           0            0             0
ClinkP.PozzCp    0        1        0           0            0             0
CaCO3SAFm.CSAF   0        0        0.65        0            0.65          0
CaCO3SAFm.CO2    0        0        0.35        0            0.35          0
CSAF.ClinkIh     0        0        0           0.83         0             0.83
CSAF.CKD         0        0        0           0.17         0             0.17

+                sinteringV sinteringP sinteringphV sinteringphP sinteringphpcV sinteringphpcP
CSAF.ClinkVh     0.83       0          0.83         0            0.83           0
CSAF.ClinkPh     0          0.83       0            0.83         0              0.83
CSAF.CKD         0.17       0.17       0.17         0.17         0.17           0.17

;
Table CMprocessuse(CMm,CMp) 1 if CMm is used in process CMp
          crushing milling mixing1 mixing2I calcining1 sinteringI cooling grinding
CaCO3     1        0       0       0        0          0          0       0
CaCO3c    0        0       1       0        0          0          0       0
CaCO3SAF  0        1       0       0        0          0          0       0
CaCO3SAFm 0        0       0       0        1          0          0       0
CSAF      0        0       0       0        0          1          0       0
ClinkIh   0        0       0       0        0          0          1       0
ClinkVh   0        0       0       0        0          0          1       0
ClinkPh   0        0       0       0        0          0          1       0
PortIp    0        0       0       0        0          0          0       1
PortVp    0        0       0       0        0          0          0       1
PozzCp    0        0       0       0        0          0          0       1
Sand      0        0       1       0        0          0          0       0
Clay      0        0       1       0        0          0          0       0
Irono     0        0       1       0        0          0          0       0
ClinkI    0        0       0       1        0          0          0       0
Gypsum    0        0       0       1        0          0          0       0

+         mixing2V mixing2P calciningph sinteringphI calciningphpc sinteringphpcI
ClinkV    1        0        0           0            0             0
Gypsum    1        1        0           0            0             0
ClinkP    0        1        0           0            0             0
Pozzn     0        1        0           0            0             0
CaCO3SAFm 0        0        1           0            1             0
CSAF      0        0        0           1            0             1

+         sinteringV sinteringP sinteringphV sinteringphP sinteringphpcV sinteringphpcP
CSAF      1          1          1            1            1              1
;
Table CMcapfactor(CMu,CMp) relating processes and units
          crushing milling mixing1 mixing2I sinteringI sinteringphI sinteringphpcI
crusher   1        0       0       0        0          0            0
rawmill   0        1       0       0        0          0            0
mixer     0        0       1       1        0          0            0
kiln      0        0       0       0        1          0            0
phkiln    0        0       0       0        0          1            0
phpckiln  0        0       0       0        0          0            1

+         mixing2V mixing2P cooling grinding sinteringV sinteringP sinteringphV
mixer     1        1        0       0        0          0          0
cooler    0        0        1       0        0          0          0
grinder   0        0        0       1        0          0          0
kiln      0        0        0       0        1          1          0
phkiln    0        0        0       0        0          0          1

+        sinteringphP sinteringphpcV sinteringphpcP
phkiln   1            0              0
phpckiln 0            1              1
;
*The table below is used to allow for the conversion of existing long dry kilns
*to kilns with either preheat only or preheat and precalcination.
Table CMcapadd(CMuu,CMu) table to allow for upgrading kiln capacities
               kiln phkiln phpckiln crusher grinder mixer rawmill cooler
kiln           1
phkiln              1
phpckiln                   1
kilntophkiln   -1   1
kilntophpckiln -1          1
crusher                             1
grinder                                     1
mixer                                               1
rawmill                                                   1
cooler                                                            1
;
*Source for energy input: Princiotta (2011). The reduced energy consumption as
*we transition to phkiln and phpckiln is attributed to heat transfer from the kiln
*to the pre-heater and/or pre-calciner. Original values have units per short ton,
*which is 2,000 pounds. The 1.1 factor changes them to per metric ton.
Parameter CMfuelburn(CMf,CMp,r,c) Fuel consumption per ton of clinker output;
*SP - These values are from KSA and need to modify for GCC countries
* Units in MMBTU per ton of clinker
CMfuelburn('Methane',CMpkiln,r,'ksa')=4.319*1.1;
CMfuelburn('Methane',CMpkilnph,r,'ksa')=2.969*1.1;
CMfuelburn('Methane',CMpkilnphpc,r,'ksa')=2.825*1.1;
*  Units in barrels per ton of clinker
CMfuelburn('Arabheavy',CMpkiln,r,'ksa')=0.732*1.1;
CMfuelburn('Arabheavy',CMpkilnph,r,'ksa')=0.503*1.1;
CMfuelburn('Arabheavy',CMpkilnphpc,r,'ksa')=0.479*1.1;
* Units in tons per ton of clinker
CMfuelburn('HFO',CMpkiln,r,'ksa')=0.105*1.102;
CMfuelburn('HFO',CMpkilnph,r,'ksa')=0.072*1.102;
CMfuelburn('HFO',CMpkilnphpc,r,'ksa')=0.069*1.1;
* Units in tons per ton of clinker
CMfuelburn('Diesel',CMpkiln,r,'ksa')=0.100*1.1;
CMfuelburn('Diesel',CMpkilnph,r,'ksa')=0.069*1.1;
CMfuelburn('Diesel',CMpkilnphpc,r,'ksa')=0.065*1.1;
;
* The electricity heat rates below are for gas turbines: 11,700 BTU/kWh
* only gas turbines are currently included
*Source for GT heat rate: KFUPM Generation report
Parameter CMelecfuelburn(CMf) fuel consumption per TWh of electricity generated;
*million tons of HFO or trillion BTU of gas or million bbls of crude per TWh
CMelecfuelburn('Methane')=11.700;
CMelecfuelburn('Arabheavy')=1.983;
CMelecfuelburn('HFO')=0.301;
CMelecfuelburn('Diesel')=0.271;
;
*Electricity figures are from Alsop et al. (2001), p. 217. Burning and cooling are
*combined in the reference, so a personal estimate is here made for the split by
*applying the first law of thermodynamics on a cooling process assuming the inlet
*temperature of the cooler is 1100 C and the exit temperature is 100 C.The electricity
*used is the work input by the fans.
*Figures are converted from TWh/Mton cement to TWh/Mton of CMp product using van Oss (2005) p.22.
*grinding includes the grinding electricity plus that of packing/loading/conveying.
Parameter CMELin(CMp) TWh of electricity used per million tons of CMp product;
CMELin('Crushing')=6e-3/1.32;
*25% of mass out of mixing1 is iron,clay, and sand, so based on van Oss (2005),
*0.78 tons of mixing1 output is used to produce one ton of cement.
CMELin('mixing1')=7e-3/0.78;
CMELin('Milling')=28e-3/0.78;
CMELin(CMpk)=5e-3/0.89;
CMELin('Cooling')=20e-3/0.89;
CMELin('mixing2I')=7e-3;
CMELin('mixing2V')=7e-3;
CMELin('mixing2P')=7e-3;
*The value below is representative for a ball mill:
CMELin('Grinding')=50e-3;

;
*capacities from company websites and/or their annual reports (saved on Walid's computer). Grinder
*capacity is equal to the cement capacity.
*Until we get unit-specific capacity values, the rest of the units' capacities are
*scaled according to cement production capacity, which sums up to 64.25 million tons/year.
Parameter CMexist(CMu,r,c) existing capacity in millions of metric tons;
*CMexist(CMu,r)=0;
*$ontext
CMexist(CMu,r,c)=0;
CMexist('Grinder','west','ksa')=8.213+5.0+1.602+2;
CMexist('Grinder','sout','ksa')=7.349+4.1;
CMexist('Grinder','cent','ksa')=6.3+4.182+3.65+1.75+1.9;
CMexist('Grinder','east','ksa')=11+3.5+2+1.7;

CMexist('Crusher','west','ksa')=CMexist('Grinder','west','ksa')*1.32;
CMexist('Crusher','sout','ksa')=CMexist('Grinder','sout','ksa')*1.32;
CMexist('Crusher','cent','ksa')=CMexist('Grinder','cent','ksa')*1.32;
CMexist('Crusher','east','ksa')=CMexist('Grinder','east','ksa')*1.32;

CMexist('Mixer','west','ksa')=100;
CMexist('Mixer','sout','ksa')=100;
CMexist('Mixer','cent','ksa')=100;
CMexist('Mixer','east','ksa')=100;
*The 2.32 multiplier is arbitrary.
CMexist('Rawmill','west','ksa')=CMexist('Grinder','west','ksa')*2.32;
CMexist('Rawmill','sout','ksa')=CMexist('Grinder','sout','ksa')*2.32;
CMexist('Rawmill','cent','ksa')=CMexist('Grinder','cent','ksa')*2.32;
CMexist('Rawmill','east','ksa')=CMexist('Grinder','east','ksa')*2.32;

CMexist('Kiln','west','ksa')=8.213+3.7+1.377;
CMexist('Kiln','sout','ksa')=7.032+3 ;
CMexist('Kiln','cent','ksa')=6+3.648+3.65+1.75+1.825;
CMexist('Kiln','east','ksa')=10.5+2.19+1.6;
*The two companies with phpckiln are Al-Safwa and Eastern Province Cement.
CMexist('phpckiln','west','ksa')=2.0;
CMexist('phpckiln','east','ksa')=3.3;

CMexist('Cooler','west','ksa')=CMexist('Kiln','west','ksa')+CMexist('phpckiln','west','ksa');
CMexist('Cooler','sout','ksa')=CMexist('Kiln','sout','ksa')+CMexist('phpckiln','sout','ksa');
CMexist('Cooler','cent','ksa')=CMexist('Kiln','cent','ksa')+CMexist('phpckiln','cent','ksa');
CMexist('Cooler','east','ksa')=CMexist('Kiln','east','ksa')+CMexist('phpckiln','east','ksa');
*$offtext
;
*On-site power generation capacities from ECRA Activities and Achieve. 2011 (2012) p. 66,98.
Parameter CMELexist(r,c) existing on-site power generation capacity in GW;
CMELexist(r,c) = 0;
CMELexist('west','ksa')=0.1+0.046+0.047;
CMELexist('sout','ksa')=0.056;
CMELexist('cent','ksa')=0.221+0.053+0.046+0.035+0.0768;
CMELexist('east','ksa')=0.049+0.042;
;
*The following estimates for storage capacity are based on the August 2011 cement
*storage levels reported by Al-Yamamah's Finance and Information Systems Department.
*These storage levels were the highest for the year, and while they may very well
*underestimate the actual storage capacity, they're used as estimates for now.
Parameter CMstorexist(r,c) existing storage capacity in million tons;
CMstorexist(r,c) = 0;
CMstorexist('west','ksa')=0.185;
CMstorexist('sout','ksa')=0.138;
CMstorexist('cent','ksa')=0.299;
CMstorexist('east','ksa')=0.330;
;
Parameter molweight(CMcl) molecular weight of clinker components million tons per million kmol;
molweight('CaO')=(15.999+40.078)/1000;
molweight('SiO2')=(2*15.999+28.0855)/1000;
molweight('Al2O3')=(3*15.999+2*26.981539)/1000;
molweight('Fe2O3')=(3*15.999+2*55.847)/1000;
molweight('C3S')=228.324/1000;
molweight('C2S')=172.246/1000;
molweight('C3A')=270.194/1000;
molweight('C4AF')=485.966/1000;
;
Parameter CMmolarfraction(CMclr) molar fraction of reactants in one mol of CSAF
/CaO   0.7299
 SiO2  0.231
 Al2O3 0.031
 Fe2O3 0.0088/
;
* Based on discussions with Al-Yamamah Cement Co., van Oss (2005) and CEMEX info.
Table CMmixingspec(CMqlim,CMm,CMci,CMprop) mixture specifications
                           masscon
 max.Sand.CaCO3SAF         0.05
 min.Sand.CaCO3SAF         0.02
 max.Clay.CaCO3SAF         0.26
 min.Clay.CaCO3SAF         0.24
 max.Irono.CaCO3SAF        0.03
 min.Irono.CaCO3SAF        0.01
 max.CaCO3c.CaCO3SAF       0.71
 min.CaCO3c.CaCO3SAF       0.70

 max.Gypsum.PortIp         0.05
 min.Gypsum.PortIp         0.04
 max.ClinkI.PortIp         0.99
 min.ClinkI.PortIp         0.91

 max.Gypsum.PortVp         0.04
 min.Gypsum.PortVp         0.03
 max.ClinkV.PortVp         0.99
 min.ClinkV.PortVp         0.91

 max.Gypsum.PozzCp         0.05
 min.Gypsum.PozzCp         0.03
 max.Pozzn.PozzCp          0.40
 min.Pozzn.PozzCp          0.15
 max.ClinkP.PozzCp         0.90
 min.ClinkP.PozzCp         0.80
;
*Specifications obtained from van Oss (2005, p.15).
Table CMclinkspec(CMqlim,CMclinker,CMcl,CMprop) Clinker specifications
                   masscon
max.ClinkIh.C3S     0.65
min.ClinkIh.C3S     0.50
max.ClinkIh.C2S     0.30
min.ClinkIh.C2S     0.10
max.ClinkIh.C3A     0.14
min.ClinkIh.C3A     0.06
max.ClinkIh.C4AF    0.10
min.ClinkIh.C4AF    0.07

max.ClinkVh.C3S     0.65
min.ClinkVh.C3S     0.40
max.ClinkVh.C2S     0.30
min.ClinkVh.C2S     0.15
max.ClinkVh.C3A     0.05
min.ClinkVh.C3A     0.01
max.ClinkVh.C4AF    0.17
min.ClinkVh.C4AF    0.10

max.ClinkPh.C3S     0.65
min.ClinkPh.C3S     0.50
max.ClinkPh.C2S     0.30
min.ClinkPh.C2S     0.10
max.ClinkPh.C3A     0.14
min.ClinkPh.C3A     0.06
max.ClinkPh.C4AF    0.10
min.ClinkPh.C4AF    0.07
;
Parameter CMleadtime(CMu) lead time in units t for construction;
CMleadtime(CMu)=0;
;
*Capital investment cost from Alsop et al. (2001), p. 204. Based on this reference,
*we estimate that total investment cost is split 42% for equipment and 68% for
*construction. Cooler cost is from EPA (2010). The original costs are divided by
*factors to convert from cement mass units to component output mass units. Kiln,
*phpckiln, and conversion build costs source is LBNL (2008), p. 9-10.
Parameter CMpurcst(CMu,time) equipment cost in millions of USD per million tons of output;
CMpurcst('Crusher',time)=2/1.32;
CMpurcst('Rawmill',time)=7.8/0.78;
CMpurcst('Mixer',time)=0.87/0.78;
CMpurcst('Grinder',time)=6;
CMpurcst('Cooler',time)=8/0.89;
CMpurcst('kilntophkiln',time)=28*0.42;
CMpurcst('kilntophpckiln',time)=29*0.42;
CMpurcst('kiln',time)=46*0.42;

*Below needs source (right now, they're just the sum of upgrade+long dry kiln costs):
CMpurcst('phkiln',time)=74*0.42;
CMpurcst('phpckiln',time)=75*0.42;

;
Parameter CMconstcst(CMu,time) construction cost in millions of USD per millions of tons of cement;
CMconstcst(CMu,time)=CMpurcst(CMu,time)*1.38;
;
*For now, we estimate that O&M costs represent 6% of capital cost.
Parameter CMomcst(CMp,time) non-fuel operations and maintenance costs in MMUSD;
CMomcst(CMp,time)=sum(CMu,CMcapfactor(CMu,CMp)*(CMpurcst(CMu,time)+CMconstcst(CMu,time)))*0.06;
;
*Electricity capacity units below in million USD per GW.
parameter CMELpurcst(time) purchase cost of on-site power generation;
CMELpurcst(time)=1400;
;
parameter CMELconstcst(time) construction cost of on-site power generation;
CMELconstcst(time)=350;
;
parameter CMELomcst(time) power generation operations cost in million USD per TWh;
CMELomcst(time)=4;
;
*Cement storage purchase cost from Alsop et al. (2001) page 204.
Parameter CMstorpurcst(time) Storage capacity purchase in USD per ton of finished product;
CMstorpurcst(time)=2;
;
Parameter CMstorconstcst(time) Storage capacity construction cost in USD per ton of finished product;
CMstorconstcst(time)=CMstorpurcst(time)*1.38;
;
*Assume operation cost is 3% of capital cost.
Parameter CMstoromcst(time) Cost of operating storage facility i.e. temperature control etc.;
CMstoromcst(time)=(CMstorpurcst(time)+CMstorconstcst(time))*0.03;
;


*Import price based on 2011 Saudi imports (CDSI)
Parameter CMimportprice(CMcf,time,r,c) import price of cement in USD per ton;
CMimportprice('PortI',time,r,c)$rc(r,c)=133.10;
CMimportprice('PortV',time,r,c)$rc(r,c)=135.31;
CMimportprice('PozzC',time,r,c)$rc(r,c)=135.31;
Parameter CMclinkprice(CMcii,time,r,c) clinker import price in USD per ton;
CMclinkprice('ClinkI',time,r,c)$rc(r,c)=54.58;
CMclinkprice('ClinkV',time,r,c)$rc(r,c)=54.58;
CMclinkprice('ClinkP',time,r,c)$rc(r,c)=54.58;
;
*Export prices calibrated based on 2011 Saudi exports (CDSI)
Parameter CMintlprice(CMcf,time) international prices for export in USD per ton;
CMintlprice('PortI',time)=65.62;
CMintlprice('PortV',time)=67.70;
CMintlprice('PozzC',time)=67.70;
;
*cost of transporting from supply region r to demand region rr.
*they are right now normalized by the cost of inner-regional transportation.
table CMtranscst(r,c,rr,cc)
                         west.ksa        sout.ksa        cent.ksa        east.ksa    (adwe,dewa,sewa,fewa).uae  qatr.qat  kuwr.kuw bahr.bah omnr.omn
         west.ksa        1               3               2.5             5           1                          1         1        1        1
         sout.ksa        3               1               3               6           1                          1         1        1        1
         cent.ksa        2.5             3               1               2           1                          1         1        1        1
         east.ksa        5               6               2               1           1                          1         1        1        1
;

CMexistcp.fx(CMu,'t01',r,c)$rc(r,c)=CMexist(CMu,r,c);
CMELexistcp.fx('t01',r,c)$rc(r,c)=CMELexist(r,c);
CMstorexistcp.fx('t01',r,c)$rc(r,c)=CMstorexist(r,c);
CMkupgradetot.fx('t01',r,c)$rc(r,c)=1*CMexist('Kiln',r,c);
CMstorage.fx(CMcements,'t01',r,c)$rc(r,c)=CMstorexist(r,c);

*Exports in 2011 are calibrated to CDSI export statistics:
*SP - Currently these values represent KSA. Need to update with GCC aggregate
CMnatexports.up(CMcf,'t01')=0;
CMnatexports.up('PortI','t01')=0.177;
CMnatexports.up('PortV','t01')=0.208;
CMnatexports.up('PozzC','t01')=0.097;
*To be in line with current policy that exports are banned, the following is imposed:
*CMnatexports.fx(CMcf,time)$(ord(time)>1)=0;

*Cement companies may not be able to anticipate fuel shortages or production outages;
*therefore, a lower bound may be imposed on storage to hedge against that risk:
*CMstorage.lo(CMcements,'t01',r)=0.025;
;
Equations
CMobjective            Cement objective function
CMcapbal(CMu,time,r,c) balances existing and built capacity
CMcaplim(CMu,time,r,c) places capacity limit on operation
CMmassbal(CMm,time,r,c) general mass balance for entire system
CMdem(CMcf,time,rr,cc) meeting domestic demand
CMsup(CMcf,time,r,c) transportation and export balance with production
CMOpmaintbal(time) aggregates operation and maintenance costs
CMPurchbal(time) aggregates capital purchase costs
CMConstructbal(time) aggregates construction costs
CMcravail(CMcr,time,r,c) supply limit equation of raw materials
CMcrcons(CMcr,time,r,c) aggregates the consumption of raw materials
CMmixingconup(CMqlim,CMm,CMci,CMprop,r,c) upper bound on mixture composition
CMmixingconlo(CMqlim,CMm,CMci,CMprop,r,c) lower bound on mixture composition
CMclinkmassbal(CMma,CMclinker,time,r,c) clinker mass balance
CMmassconv(CMclp,CMclinker,time,r,c) converts molest to mass
CMclinkpropconup(CMqlim,CMci,CMclp,CMprop,time,r,c) clinker composition
CMclinkpropconlo(CMqlim,CMci,CMclp,CMprop,time,r,c) clinker composition
CMclinkeroutput(CMclinker,time,r,c) relates general mass balance to clinker mass balance
CMmolconv(CMm,CMcl,time,r,c) converts CSAF mass to moles of CaO
CMfcons(CMf,time,r,c) aggregates fuel consumption
CMfavail(CMf,time,r,c) supply limit of fuel
CMfavailcr(CMf,time,r,c) supply limit of fuel
CMelecbal(ELl,ELs,ELday,time,r,c) aggregates total electricity consumed
CMrevenuesbal(time) aggregates export revenues
CMexportsum(CMcf,time) sums regional exports
CMELcapbal(time,r,c) balances electricity capacity
CMELcaplim(ELl,ELs,ELday,time,r,c) places limit on electricity production
CMelecsum(ELl,ELs,ELday,time,r,c) aggregates purchased and generated electricity
CMkconvlim(CMukcon,time,r,c) conversion limit constraint for existing long dry kilns
CMkconvlimsum(time,r,c) aggregates all convertable capacities
CMstorcapbal(time,r,c) balances storage capacity
CMstorcaplim(time,r,c) makes sure storage doesn't exceed capacity
CMstoragebal(CMcf,time,r,c) transient continuity equation for (accumulating or decumulating) storage stock

*$ontext
DCMmol(CMcl,CMci,time,r,c)
DCMmass(CMcl,CMm,time,r,c)
DCMop(CMm,CMp,CMf,time,r,c)
DCMtrans(CMcf,time,r,c,rr,cc)
DCMOpandmaint(time)
DCMexistcp(CMu,time,r,c)
DCMbld(CMu,time,r,c)
DCMprodimports(CMcf,time,rr,cc)
DCMImports(time)
DCMConstruct(time)
DCMcrconsump(CMcr,time,r,c)
DCMfconsump(CMf,time,r,c)
DCMfconsumpcr(CMf,time,r,c)
DCMELconsump(ELl,ELs,ELday,time,r,c)
DCMexports(CMcf,time,r,c)
DCMnatexports(Cmcf,time)
DCMRevenues(time)
DCMtotELconsump(ELl,ELs,ELday,time,r,c)
DCMELop(CMf,ELl,ELs,ELday,time,r,c)
DCMELbld(time,r,c)
DCMELexistcp(time,r,c)
DCMclinkimport(CMcii,time,r,c)
DCMkupgrade(CMukcon,time,r,c)
DCMkupgradetot(time,r,c)
DCMstorexistcp(time,r,c)
DCMstorbld(time,r,c)
DCMstorage(CMcf,time,r,c)
DCMstoragein(CMcf,time,r,c)
DCMstorageout(CMcf,time,r,c,rr,cc)
*$offtext
;
$offorder
;
*$ontext
CMobjective.. CMzLP=e=sum(t,(CMOpandmaint(t)+CMImports(t)+CMConstruct(t))*CMdiscfact(t))+sum((CMf,t,r,c),CMAPf(CMf,t,r,c)*CMfconsump(CMf,t,r,c)*CMdiscfact(t))
 -sum(t,CMRevenues(t)*CMdiscfact(t)) - sum((CMf,t,r,c)$rks(r,c), fcr(CMf,t,c)*CMfconsumpcr(CMf,t,r,c))
 +sum((ELl,ELs,ELday,t,r,c)$rks(r,c),CMELprice(ELl,ELs,ELday,c)*CMELconsump(ELl,ELs,ELday,t,r,c)*CMdiscfact(t));
*$offtext

*PRIMAL CONSTRAINTS

*Cost and Revenue Balances:
CMOpmaintbal(t)..
  sum((CMm,CMmm,CMp,CMf,r,c)$rks(r,c),CMomcst(CMp,t)*CMmassout(CMm,CMmm,CMp)*CMop(CMm,CMp,CMf,t,r,c))
 +sum((CMcf,r,c,rr,cc)$(rks(r,c) and rks(rr,cc)),CMtranscst(r,c,rr,cc)*(CMtrans(CMcf,t,r,c,rr,cc)+CMstorageout(CMcf,t,r,c,rr,cc)))
 +sum((CMcr,r,c)$rks(r,c),CMcrconsump(CMcr,t,r,c)*CMfeedcst(CMcr,t,r,c))
 +sum((CMcf,r,c)$rks(r,c),CMstoromcst(t)*CMstorage(CMcf,t,r,c))
* +sum((ELl,ELs,ELday,r),DELdem(ELl,ELs,ELday,t,r)*CMELconsump(ELl,ELs,ELday,t,r))
* +sum((ELl,ELs,ELday,r),CMELprice(ELl,ELs,ELday)*CMELconsump(ELl,ELs,ELday,t,r))
 +sum((CMf,ELl,ELs,ELday,r,c)$rks(r,c),CMELomcst(t)*CMELop(CMf,ELl,ELs,ELday,t,r,c))-CMOpandmaint(t)=e=0;

CMPurchbal(t).. sum((CMu,r,c)$rks(r,c),CMpurcst(CMu,t)*CMbld(CMu,t,r,c))
 +sum((r,c)$rks(r,c),CMELpurcst(t)*CMELbld(t,r,c))
 +sum((r,c)$rks(r,c),CMstorpurcst(t)*CMstorbld(t,r,c))
 +sum((CMcf,rr,cc)$rks(rr,cc),CMimportprice(CMcf,t,rr,cc)*CMprodimports(CMcf,t,rr,cc))
 +sum((CMcii,r,c)$(rks(r,c) and CMclinkprice(CMcii,t,r,c)>0),CMclinkprice(CMcii,t,r,c)*CMclinkimport(CMcii,t,r,c))
 -CMImports(t)=e=0;

CMConstructbal(t).. sum((CMu,r,c)$rks(r,c),CMconstcst(CMu,t)*CMbld(CMu,t,r,c))
 +sum((r,c)$rks(r,c),CMstorconstcst(t)*CMstorbld(t,r,c))
 +sum((r,c)$rks(r,c),CMELconstcst(t)*CMELbld(t,r,c))-CMConstruct(t)=e=0;

CMrevenuesbal(t).. sum((CMcf,r,c)$rks(r,c),CMintlprice(CMcf,t)*CMexports(CMcf,t,r,c))
 -CMRevenues(t)=e=0;



* Capacity Balance and Operation Level Constraints:
CMcapbal(CMu,t,r,c)$rks(r,c).. CMexistcp(CMu,t,r,c)+sum(CMuu,CMcapadd(CMuu,CMu)*CMbld(CMuu,t-CMleadtime(CMuu),r,c))
 -CMexistcp(CMu,t+1,r,c)=g=0;

CMcaplim(CMu,t,r,c)$rks(r,c).. CMexistcp(CMu,t,r,c)+sum(CMuu,CMcapadd(CMuu,CMu)*CMbld(CMuu,t-CMleadtime(CMuu),r,c))
 -sum((CMm,CMp,CMf),CMcapfactor(CMu,CMp)*CMprocessuse(CMm,CMp)*CMop(CMm,CMp,CMf,t,r,c))=g=0;

*To ensure that remaining convertible capacity can be positive in the last period
CMkconvlim(CMukcon,t,r,c)$rks(r,c).. -CMkupgrade(CMukcon,t+1,r,c)-CMbld(CMukcon,t,r,c)
 +CMkupgrade(CMukcon,t,r,c)=g=0;

CMkconvlimsum(t,r,c)$rks(r,c).. sum(CMukcon,CMkupgrade(CMukcon,t,r,c))-CMkupgradetot(t,r,c)=e=0;

CMstorcapbal(t,r,c)$rks(r,c).. CMstorexistcp(t,r,c)+CMstorbld(t,r,c)-CMstorexistcp(t+1,r,c)=g=0;

CMstorcaplim(t,r,c)$rks(r,c).. CMstorexistcp(t,r,c)+CMstorbld(t,r,c)-sum(CMcf,CMstorage(CMcf,t,r,c))=g=0;




*Mass Balances
CMmassbal(CMcii,t,r,c)$rks(r,c).. sum((CMm,CMp,CMf),CMprocessuse(CMm,CMp)*CMmassout(CMm,CMcii,CMp)*CMop(CMm,CMp,CMf,t,r,c))
 +CMclinkimport(CMcii,t,r,c)$(CMclinkprice(CMcii,t,r,c)>0)
 -sum((CMf,CMp),CMprocessuse(CMcii,CMp)*CMop(CMcii,CMp,CMf,t,r,c))=e=0;

CMmixingconup('max',CMm,CMci,CMprop,r,c)$(rks(r,c) and CMmixingspec('max',CMm,CMci,CMprop)>0)..
  CMmixingspec('max',CMm,CMci,CMprop)*sum((CMmm,CMp,CMf,t),CMprocessuse(CMmm,CMp)*CMmassout(CMmm,CMci,CMp)*CMop(CMmm,CMp,CMf,t,r,c))
 -sum((CMp,CMf,t),CMprocessuse(CMm,CMp)*CMmassout(CMm,CMci,CMp)*CMop(CMm,CMp,CMf,t,r,c))=g=0;
*SP - Question why we are summing up by time in above equation, which is unusual from the rest of the modules. This may not affect this
* problem but may alter the solution in dynamic model.

CMmixingconlo('min',CMm,CMci,CMprop,r,c)$(rks(r,c) and CMmixingspec('min',CMm,CMci,CMprop)>0)..
 -CMmixingspec('min',CMm,CMci,CMprop)*sum((CMmm,CMp,CMf,t),CMprocessuse(CMmm,CMp)*CMmassout(CMmm,CMci,CMp)*CMop(CMmm,CMp,CMf,t,r,c))
 +sum((CMp,CMf,t),CMprocessuse(CMm,CMp)*CMmassout(CMm,CMci,CMp)*CMop(CMm,CMp,CMf,t,r,c))=g=0;
*+++++++++++++++++++++++++++++++++++++++++++++++
**mass balance in the kiln** (to capture mass in clinkering reaction and meet specifications)
CMmolconv('CSAF','CaO',t,r,c)$rks(r,c).. sum(CMclinker,CMmol('CaO',CMclinker,t,r,c))
 -sum((CMf,CMpk,CMclinker),CMprocessuse('CSAF',CMpk)*CMmassout('CSAF',CMclinker,CMpk)*CMop('CSAF',CMpk,CMf,t,r,c)
       /0.05932*CMmolarfraction('CaO'))=e=0;
* 0.05932 is the molecular weight of CSAF in metric tons/kmol, using
* 1 mole of CSAF is approximately 0.7299CaO+0.231SiO2+0.031Al2O3+0.009Fe2O3

CMclinkmassbal(CMma,CMclinker,t,r,c)$rks(r,c).. sum((CMclr),atomsub(CMclr,CMma)*CMmol(CMclr,CMclinker,t,r,c))
 -sum((CMclp),atomsub(CMclp,CMma)*CMmol(CMclp,CMclinker,t,r,c))=e=0;

CMmassconv(CMclp,CMclinker,t,r,c)$rks(r,c).. molweight(CMclp)*CMmol(CMclp,CMclinker,t,r,c)
 -CMmass(CMclp,CMclinker,t,r,c)=e=0;

CMclinkpropconup('max',CMclinker,CMclp,CMprop,t,r,c)$(rks(r,c) and CMclinkspec('max',CMclinker,CMclp,CMprop)>0)..
  CMclinkspec('max',CMclinker,CMclp,CMprop)*sum(CMcl$CMclp(CMcl),CMmass(CMcl,CMclinker,t,r,c))
 -CMmass(CMclp,CMclinker,t,r,c)=g=0;

CMclinkpropconlo('min',CMclinker,CMclp,CMprop,t,r,c)$(rks(r,c) and CMclinkspec('min',CMclinker,CMclp,CMprop)>0)..
 -CMclinkspec('min',CMclinker,CMclp,CMprop)*sum(CMcl$CMclp(CMcl),CMmass(CMcl,CMclinker,t,r,c))
 +CMmass(CMclp,CMclinker,t,r,c)=g=0;

CMclinkeroutput(CMclinker,t,r,c)$rks(r,c).. sum(CMclp,CMmass(CMclp,CMclinker,t,r,c))
 -sum((CMp,CMf),CMprocessuse('CSAF',CMp)*CMmassout('CSAF',CMclinker,CMp)*CMop('CSAF',CMp,CMf,t,r,c))=e=0;
*+++++++++++++++++++++++++++++++++++++++++++++++
CMcrcons(CMcr,t,r,c)$rks(r,c).. CMcrconsump(CMcr,t,r,c)-sum((CMp,CMf),CMprocessuse(CMcr,CMp)*CMop(CMcr,CMp,CMf,t,r,c))=g=0;

CMcravail(CMcr,t,r,c)$rks(r,c).. -CMcrconsump(CMcr,t,r,c)=g=-CMfeedsuplim(CMcr,t,r,c);

CMexportsum(CMcf,t).. -sum((r,c)$rks(r,c),CMExports(CMcf,t,r,c))+CMnatexports(CMcf,t)=e=0;

CMstoragebal(CMcf,t,r,c)$rks(r,c).. CMstorage(CMcf,t,r,c)
 +CMstoragein(CMcf,t,r,c)
 -sum((rr,cc)$rks(rr,cc),CMstorageout(CMcf,t,r,c,rr,cc))
 -CMstorage(CMcf,t+1,r,c)=e=0;


*Supply and Demand Constraints:
CMsup(CMcf,t,r,c)$rks(r,c).. sum((CMp,CMci,CMf),CMprocessuse(CMci,CMp)*CMmassout(CMci,CMcf,CMp)*CMop(CMci,CMp,CMf,t,r,c))
 -sum((rr,cc)$rks(rr,cc),CMtrans(CMcf,t,r,c,rr,cc))-CMExports(CMcf,t,r,c)-CMstoragein(CMcf,t,r,c)=g=0;

CMdem(CMcf,t,rr,cc)$rks(rr,cc).. sum((r,c)$rks(r,c),CMtrans(CMcf,t,r,c,rr,cc))+CMprodimports(CMcf,t,rr,cc)
 +sum((r,c)$rks(r,c),CMstorageout(CMcf,t,r,c,rr,cc))=g=CMdemval(CMcf,t,rr,cc);



*Energy Balance Relationships
CMfcons(CMf,t,r,c)$rks(r,c).. CMfconsump(CMf,t,r,c)
 -sum((CMmm,CMp),CMfuelburn(CMf,CMp,r,c)*CMprocessuse('CSAF',CMp)*CMmassout('CSAF',CMmm,CMp)*CMop('CSAF',CMp,CMf,t,r,c))
 -sum((ELl,ELs,ELday),CMelecfuelburn(CMf)*CMELop(CMf,ELl,ELs,ELday,t,r,c))=g=0;

CMfavail(CMf,t,r,c)$(rks(r,c) and (CMfAP(CMf) or CMfref(CMf))).. -CMfconsump(CMf,t,r,c)=g=-CMfconsumpmax(CMf,t,r,c);

CMfavailcr(CMf,t,r,c)$rks(r,c).. -CMfconsumpcr(CMf,t,r,c)+CMfconsump(CMf,t,r,c)=g=0;

*Electricity constraints (Operation is in TWh and capacity is in GW (for improved scaling)):
CMELcapbal(t,r,c)$rks(r,c).. CMELexistcp(t,r,c)+CMELbld(t,r,c)-CMELexistcp(t+1,r,c)=g=0;

CMELcaplim(ELl,ELs,ELday,t,r,c)$rks(r,c).. ELdaysinseason(ELs,ELday)*ELlchours(ELl,c)*(CMELexistcp(t,r,c)+CMELbld(t,r,c))
 -sum(CMf,CMELop(CMf,ELl,ELs,ELday,t,r,c))=g=0;

*below, electricity currently computed using TWh per unit of product for a given process.

CMelecbal(ELl,ELs,ELday,t,r,c)$rks(r,c).. CMtotELconsump(ELl,ELs,ELday,t,r,c)
 -sum((CMm,CMci,CMp,CMf),CMELin(CMp)*CMprocessuse(CMm,CMp)*CMmassout(CMm,CMci,CMp)*CMop(CMm,CMp,CMf,t,r,c))*CMELlchrsfraction(ELl,c)*ELnormdays(ELs,ELday)=g=0;

CMelecsum(ELl,ELs,ELday,t,r,c)$rks(r,c).. sum(CMf,CMELop(CMf,ELl,ELs,ELday,t,r,c))+CMELconsump(ELl,ELs,ELday,t,r,c)
 -CMtotELconsump(ELl,ELs,ELday,t,r,c)=g=0;
*$ontext


* DUAL CONSTRAINTS


DCMImports(t).. 1*CMdiscfact(t)=g=-DCMpurchbal(t);
DCMConstruct(t).. 1*CMdiscfact(t)=g=-DCMconstructbal(t);
DCMOpandmaint(t).. 1*CMdiscfact(t)=g=-DCMopmaintbal(t);
DCMRevenues(t).. -1*CMdiscfact(t)=g=-DCMrevenuesbal(t);


DCMfconsump(CMf,t,r,c)$rks(r,c)..
(  ( Dfdem(CMf,t,r,c)*CMdiscfact(t)*(1-subsidy(t)$(partialdereg=1)))$CMfup(CMf)
  +(DRFdem(CMf,t,r,c)*CMdiscfact(t)*(1-subsidy(t)$(partialdereg=1)))$CMfref(CMf)
)$(CMfMP(CMf))
*CMdiscfact(t)
*        conditional for deregulated fuel scenario
 +CMAPf(CMf,t,r,c)*CMdiscfact(t)$(CMfAP(CMf))
*        conditional for administered fuel prices

 =g=DCMfcons(CMf,t,r,c)-DCMfavail(CMf,t,r,c)$(CMfAP(CMf) or CMfref(CMf))
         +DCMfavailcr(CMf,t,r,c)
         -sum((sect,EMcp)$CMsect(sect),EMfactors(sect,CMf,EMcp)*DEMquantbal(sect,EMcp,t));

DCMfconsumpcr(CMf,t,r,c)$rks(r,c)..
         -fcr(CMf,t,c)*CMdiscfact(t)=g=-DCMfavailcr(CMf,t,r,c);

*DCMELconsump(ELl,ELs,ELday,t,r)..
*                                  0=g=DELdem(ELl,ELs,ELday,t,r)*DCMOpmaintbal(t)+DCMelecsum(ELl,ELs,ELday,t,r);
*                                  0=g=CMELprice(ELl,ELs,ELday)*DCMOpmaintbal(t)+DCMelecsum(ELl,ELs,ELday,t,r);
* use for deregulation fo CM electricity price

DCMELconsump(ELl,ELs,ELday,t,r,c)$rks(r,c)..     CMELprice(ELl,ELs,ELday,c)*CMdiscfact(t)$(ELdereg<>1)
                                      +DELdem(ELl,ELs,ELday,t,r,c)*CMdiscfact(t)$(ELdereg=1)
*CMdiscfact(t)
                         =g=DCMelecsum(ELl,ELs,ELday,t,r,c);



DCMop(CMm,CMp,CMf,t,r,c)$(rks(r,c) and CMprocessuse(CMm,CMp)>0)..
          0=g=sum(CMmm,CMomcst(CMp,t)*CMmassout(CMm,CMmm,CMp)*DCMOpmaintbal(t))
 -sum(CMu,CMcapfactor(CMu,CMp)*CMprocessuse(CMm,CMp)*DCMcaplim(CMu,t,r,c))
 +sum(CMcii,CMprocessuse(CMm,CMp)*CMmassout(CMm,CMcii,CMp)*DCMmassbal(CMcii,t,r,c))
 -(CMprocessuse(CMm,CMp)*DCMmassbal(CMm,t,r,c))$CMcii(CMm)
 +sum((CMmm,CMci,CMprop)$(CMmixingspec('max',CMm,CMci,CMprop)>0),CMprocessuse(CMmm,CMp)*CMmassout(CMmm,CMci,CMp)
  *CMmixingspec('max',CMmm,CMci,CMprop)*DCMmixingcon('max',CMmm,CMci,CMprop,r,c))
 -sum((CMci,CMprop)$(CMmixingspec('max',CMm,CMci,CMprop)>0),CMprocessuse(CMm,CMp)
  *CMmassout(CMm,CMci,CMp)*DCMmixingcon('max',CMm,CMci,CMprop,r,c))
 -sum((CMmm,CMci,CMprop)$(CMmixingspec('min',CMm,CMci,CMprop)>0),CMprocessuse(CMmm,CMp)*CMmassout(CMmm,CMci,CMp)
  *CMmixingspec('min',CMmm,CMci,CMprop)*DCMmixingcon('min',CMmm,CMci,CMprop,r,c))
 +sum((CMci,CMprop)$(CMmixingspec('min',CMm,CMci,CMprop)>0),CMprocessuse(CMm,CMp)
  *CMmassout(CMm,CMci,CMp)*DCMmixingcon('min',CMm,CMci,CMprop,r,c))
 -sum(CMclinker$(CMpk(CMp) and CMcsaf(CMm)),CMprocessuse(CMm,CMp)*CMmassout(CMm,CMclinker,CMp)
  *DCMmolconv(CMm,'CaO',t,r,c)/0.05932*CMmolarfraction('CaO'))
 -sum(CMclinker$CMcsaf(CMm),CMprocessuse(CMm,CMp)*CMmassout(CMm,CMclinker,CMp)*DCMclinkeroutput(CMclinker,t,r,c))
 -(CMprocessuse(CMm,CMp)*DCMcrcons(CMm,t,r,c))$CMcr(CMm)
 +sum(CMcf$CMci(CMm),CMprocessuse(CMm,CMp)*CMmassout(CMm,CMcf,CMp)*DCMsup(CMcf,t,r,c))
 -sum(CMmm$CMcsaf(CMm),CMfuelburn(CMf,CMp,r,c)*CMprocessuse(CMm,CMp)*CMmassout(CMm,CMmm,CMp)*DCMfcons(CMf,t,r,c))
 -sum((ELl,ELs,ELday,CMci),CMELin(CMp)*CMprocessuse(CMm,CMp)*CMmassout(CMm,CMci,CMp)*CMELlchrsfraction(ELl,c)
  *DCMelecbal(ELl,ELs,ELday,t,r,c)*ELnormdays(ELs,ELday))
 -sum((sect,EMcp)$(CMsect(sect) and CMci(CMm) and CO2(EMcp)),CMprocessuse(CMm,CMp)*CMmassout(CMm,'CO2',CMp)*DEMquantbal(sect,EMcp,t));


DCMmol(CMcl,CMclinker,t,r,c)$rks(r,c).. 0=g=sum(CMm$(CMlime(CMcl) and CMcsaf(CMm)),DCMmolconv(CMm,CMcl,t,r,c))
 +sum(CMma$CMclr(CMcl),atomsub(CMcl,CMma)*DCMclinkmassbal(CMma,CMclinker,t,r,c))
 -sum(CMma$CMclp(CMcl),atomsub(CMcl,CMma)*DCMclinkmassbal(CMma,CMclinker,t,r,c))
 +(molweight(CMcl)*DCMmassconv(CMcl,CMclinker,t,r,c))$CMclp(CMcl);


DCMmass(CMclp,CMclinker,t,r,c)$rks(r,c).. 0=g=-DCMmassconv(CMclp,CMclinker,t,r,c)
 +sum((CMprop,CMcl)$(CMclp(CMcl) and CMclinkspec('max',CMclinker,CMclp,CMprop)>0),
  CMclinkspec('max',CMclinker,CMcl,CMprop)*DCMclinkpropcon('max',CMclinker,CMcl,CMprop,t,r,c))
 -sum(CMprop$(CMclinkspec('max',CMclinker,CMclp,CMprop)>0),DCMclinkpropcon('max',CMclinker,CMclp,CMprop,t,r,c))
 -sum((CMprop,CMcl)$(CMclp(CMcl) and CMclinkspec('min',CMclinker,CMclp,CMprop)>0),
  CMclinkspec('min',CMclinker,CMcl,CMprop)*DCMclinkpropcon('min',CMclinker,CMcl,CMprop,t,r,c))
 +sum(CMprop$(CMclinkspec('min',CMclinker,CMclp,CMprop)>0),DCMclinkpropcon('min',CMclinker,CMclp,CMprop,t,r,c))
 +DCMclinkeroutput(CMclinker,t,r,c);

DCMexistcp(CMu,t,r,c)$rks(r,c).. 0=n=DCMcapbal(CMu,t,r,c)-DCMcapbal(CMu,t-1,r,c)+DCMcaplim(CMu,t,r,c);

DCMbld(CMu,t,r,c)$rks(r,c).. 0=g=CMpurcst(CMu,t)*DCMPurchbal(t)+CMconstcst(CMu,t)*DCMConstructbal(t)
 +sum(CMuu,CMcapadd(CMu,CMuu)*DCMcapbal(CMuu,t+CMleadtime(CMuu),r,c))
 +sum(CMuu,CMcapadd(CMu,CMuu)*DCMcaplim(CMuu,t+CMleadtime(CMuu),r,c))
 -DCMkconvlim(CMu,t,r,c)$CMukcon(CMu);

DCMkupgrade(CMukcon,t,r,c)$rks(r,c).. 0=g=-DCMkconvlim(CMukcon,t-1,r,c)+DCMkconvlim(CMukcon,t,r,c)
 +DCMkconvlimsum(t,r,c);

DCMkupgradetot(t,r,c)$rks(r,c).. 0=e=-DCMkconvlimsum(t,r,c);

DCMexports(CMcf,t,r,c)$rks(r,c).. 0=g=CMintlprice(CMcf,t)*DCMrevenuesbal(t)-DCMsup(CMcf,t,r,c)
 -DCMexportsum(CMcf,t);

DCMnatExports(CMcf,t).. 0=g=DCMexportsum(CMcf,t);

DCMprodimports(CMcf,t,rr,cc)$rks(rr,cc).. 0=g=DCMdem(CMcf,t,rr,cc)+CMimportprice(CMcf,t,rr,cc)*DCMPurchbal(t);

DCMclinkimport(CMcii,t,r,c)$(rks(r,c) and CMclinkprice(CMcii,t,r,c)>0).. 0=g=DCMmassbal(CMcii,t,r,c)
 +CMclinkprice(CMcii,t,r,c)*DCMpurchbal(t);

DCMcrconsump(CMcr,t,r,c)$rks(r,c).. 0=g=CMfeedcst(CMcr,t,r,c)*DCMOpmaintbal(t)+DCMcrcons(CMcr,t,r,c)
 -DCMcravail(CMcr,t,r,c);

DCMtrans(CMcf,t,r,c,rr,cc)$(rks(r,c) and rks(rr,cc)).. 0=g=CMtranscst(r,c,rr,cc)*DCMOpmaintbal(t)-DCMsup(CMcf,t,r,c)
 +DCMdem(CMcf,t,rr,cc);

DCMtotELconsump(ELl,ELs,ELday,t,r,c)$rks(r,c).. 0=g=DCMelecbal(ELl,ELs,ELday,t,r,c)-DCMelecsum(ELl,ELs,ELday,t,r,c);

DCMELop(CMf,ELl,ELs,ELday,t,r,c)$rks(r,c).. 0=g=-DCMELcaplim(ELl,ELs,ELday,t,r,c)+DCMelecsum(ELl,ELs,ELday,t,r,c)
 -CMelecfuelburn(CMf)*DCMfcons(CMf,t,r,c)+CMELomcst(t)*DCMOpmaintbal(t);

DCMELexistcp(t,r,c)$rks(r,c).. 0=n=DCMELcapbal(t,r,c)-DCMELcapbal(t-1,r,c)
 +sum((ELl,ELs,ELday),ELdaysinseason(ELs,ELday)*ELlchours(ELl,c)*DCMELcaplim(ELl,ELs,ELday,t,r,c));

DCMELbld(t,r,c)$rks(r,c).. 0=g=DCMELcapbal(t,r,c)+sum((ELl,ELs,ELday),ELdaysinseason(ELs,ELday)*ELlchours(ELl,c)*DCMELcaplim(ELl,ELs,ELday,t,r,c))
 +CMELpurcst(t)*DCMPurchbal(t)+CMELconstcst(t)*DCMConstructbal(t);

DCMstorexistcp(t,r,c)$rks(r,c).. 0=n=DCMstorcapbal(t,r,c)+DCMstorcaplim(t,r,c)
 -DCMstorcapbal(t-1,r,c);

DCMstorbld(t,r,c)$rks(r,c).. 0=g=DCMstorcapbal(t,r,c)
 +DCMstorcaplim(t,r,c)
 +CMstorpurcst(t)*DCMpurchbal(t)
 +CMstorconstcst(t)*DCMconstructbal(t);

DCMstorage(CMcf,t,r,c)$rks(r,c).. 0=g=-DCMstorcaplim(t,r,c)
 -DCMstoragebal(CMcf,t-1,r,c)
 +DCMstoragebal(CMcf,t,r,c)
 +CMstoromcst(t)*DCMopmaintbal(t);

DCMstoragein(CMcf,t,r,c)$rks(r,c).. 0=g=DCMstoragebal(CMcf,t,r,c)-DCMsup(CMcf,t,r,c);

DCMstorageout(CMcf,t,r,c,rr,cc)$(rks(r,c) and rks(rr,cc)).. 0=g=-DCMstoragebal(CMcf,t,r,c)
 +DCMdem(CMcf,t,rr,cc)
 +DCMopmaintbal(t)*CMtranscst(r,c,rr,cc);





