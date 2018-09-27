* common parameters


* Energy density of refined products from IEA Statistics Manual (p.181).
* Energy density of steam coal exported from South Africa from Eberhard (2011, p.3)
Parameters Fuelencon1(f) Fuel energy content in trillion BTU
/
Arabsuper 5.73
Arabextra 5.73
Arablight 5.43
Arabmed   5.73
Arabheavy 5.94
Gcond    5.73
Methane   1
Ethane    1
Propane   43.87
HFO       39.4
diesel    41.1
naphtha   43.00
LPG       43.74
91motorgas 42.41
95motorgas 42.41
Jet-fuel  41.63
Coal      23.39/
;

Parameter fPCconv(fup) conversion factors from the units used in petrochemicals;
fPCconv('Ethane')=44.99;
*Converting ethane from million metric tons to trillion BTU. (47.51 GJ/ton)
fPCconv('Methane')=47.38;
*Converting methane from million metric tons to trillion BTU (50.03 GJ/ton)
fPCconv('Propane')=1;
*Keeping propane in million metric tons

Parameter fRFconv(fup) conversion factors from the units used in refining;
fRFconv('Gcond')=7.813;
fRFconv('Arabsuper')=7.659;
fRFconv('Arabextra')=7.485;
fRFconv('Arablight')=7.310;
fRFconv('Arabmed')=7.135;
fRFconv('Arabheavy')=6.999;

Table distances(r,c,rr,cc) distances
         east.ksa  west.ksa  sout.ksa  cent.ksa
east.ksa 150       1200      1700      400
west.ksa 1200      150       650       900
sout.ksa 1700      650       150       1000
cent.ksa 400       900       1000      150
adwe.uae
dewa.uae
sewa.uae
fewa.uae
qatr.qat
kuwr.kuw
bahr.bah
omnr.omn

+        adwe.uae  dewa.uae  sewa.uae  fewa.uae
east.ksa 
west.ksa
sout.ksa
cent.ksa
adwe.uae 100       120       140       120
dewa.uae 120       50        25        130
sewa.uae 145       25        25        140
fewa.uae 120       130       140       25
qatr.qat
kuwr.kuw
bahr.bah
omnr.omn

+        qatr.qat  kuwr.kuw  bahr.bah  omnr.omn
east.ksa
west.ksa
sout.ksa
cent.ksa
adwe.uae
dewa.uae
sewa.uae
fewa.uae
qatr.qat 90
kuwr.kuw           55
bahr.bah                     20
omnr.omn                                  300
;

