* Emissions reports

RWEMquant(trun,EMcp,c,ksec)= EMquant.l(ksec,EMcp,trun,c);
RWEMallquant(trun,c)=EMallquant.l('CO2',trun,c);

option RWEMquant:3:3:1;
option RWEMallquant:3:1:1;

display
RWEMquant
RWEMallquant
;

