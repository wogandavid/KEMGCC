* solve transmission

option limcol=1e5;
option limrow=1e5;

option lp=cbc;

t(trun)=yes;
t_ind(t) = ord(t)-1;
t_ind(t)$(t_ind(t)<=0)=1;

* set administered fuel credit to 0
fcr(f,trun,c) = 0;

* capital subsidy
capsub(ELp,t)=0;

* Variable fixes and settings
*============================
*ftrans.fx(fup,t,r,c,rr,cc)$(not sameas(c,cc))=0;
* Dolphin:
ftrans.up('methane',t,'qatr','qat','adwe','uae')=400+300+100;
*ftrans.up('methane',t,'adwe','uae','dewa','uae')=300;
ftrans.lo('methane',t,'adwe','uae','omnr','omn')=50;
ftrans.lo('arablight',t,'east','ksa','bahr','bah')=100;

* control plant builds and fuel
ELbld.fx('CoalSteam',v,trun,r,c)=0;
ELbld.fx('Nuclear',v,trun,r,c)=0;
*ELrenbld.up(ELpsw,v,trun,r,c)=0;

* Qatar policy of no RO investments
*WAbld.up(WApsingle,v,'t1','qatr','qat')=0;

*TRnodaltrans.up(ELl,ELs,ELday,t,r,c,rr,cc)$(not sameas(c,cc))=0;

*execute_loadpoint "DO.gdx";

*OTHERfconsump('methane','t1','east','ksa')=OTHERfconsump('methane','t1','east','ksa')*0.96;

TRbld.up(r,c,rr,cc,trun)$(not sameas(c,cc))=0;

* to remove Qatar
TRtransyield('east','ksa','qatr','qat')=0;
TRtransyield('qatr','qat','east','ksa')=0;

*fMP(f,c)= no;
*fMP('methane','ksa')= yes;
fMP(f,c)= yes;

ELfMP(ELf,c)$fmp(ELf,c)= yes;
ELfAP(ELf,c)= not fmp(ELf,c);
WAfMP(WAf,c)$fmp(WAf,c)= yes;
WAfAP(WAf,c)= not fmp(WAf,c);

* renewable trade
rentrade=0;

* GCC sets
fMPt(f,c)=  no;
*fMPt('methane',c)= yes;
*fMPt(f,c)= yes;

ELfMPt(ELf,c)$fMPt(ELf,c)= yes;
WAfMPt(WAf,c)$fMPt(WAf,c)= yes;

display fMPt,ELfMPt,WAfMPt, ftransexist;

*$ontext
ELWAcoord('ksa')=1;
ELWAcoord('kuw')=1;
ELWAcoord('qat')=1;
ELWAcoord('bah')=1;
ELWAcoord('omn')=1;
ELWAcoord('uae')=1;
*$offtext

$ontext
ELWAcoord('ksa')=1;
ELWAcoord('kuw')=1;
ELWAcoord('qat')=1;
ELWAcoord('bah')=1;
ELWAcoord('omn')=1;
ELWAcoord('uae')=1;
$offtext

display ELfAP,WAfAP;

* set administered prices - Bahrain
fAP('methane','t1','bah')=2.75;
fAP('arablight','t1','bah')=fintlprice('arablight','t1');
fAP('u-235','t1','bah')=fintlprice('u-235','t1');
fAP('ethane','t1','bah')=2.00;
fAP('arabheavy','t1','bah')=fintlprice('arablight','t1');
fAP('diesel','t1','bah')=268.48;
fAP('HFO','t1','bah')= 1e2;
fAP('Coal','t1','bah')=fintlprice('coal','t1');

* Kuwait
*fAP('methane','t1','kuw')=fintlprice('methane','t1');
fAP('methane','t1','kuw')=3.53;
fAP('arablight','t1','kuw')=42.10;
fAP('u-235','t1','kuw')=fintlprice('u-235','t1');
fAP('ethane','t1','kuw')=2.00;
fAP('arabheavy','t1','kuw')=fintlprice('arabheavy','t1');
fAP('diesel','t1','kuw')=470.46;
fAP('HFO','t1','kuw')= 297.91;
fAP('Coal','t1','kuw')=fintlprice('coal','t1');

* set administered prices - Oman
fAP('methane','t1','omn')=2.00;
fAP('arablight','t1','omn')=fintlprice('arablight','t1');
fAP('u-235','t1','omn')=fintlprice('u-235','t1');
fAP('ethane','t1','omn')=2.00;
fAP('arabheavy','t1','omn')=fintlprice('arablight','t1');
fAP('diesel','t1','omn')=1e2;
fAP('HFO','t1','omn')= 1e2;
fAP('Coal','t1','omn')=fintlprice('coal','t1');

* set administered prices - Qatar
fAP('methane','t1','qat')=1.50;
fAP('arablight','t1','qat')=fintlprice('arablight','t1');
fAP('u-235','t1','qat')=fintlprice('u-235','t1');
fAP('ethane','t1','qat')=2.00;
fAP('arabheavy','t1','qat')=fintlprice('arablight','t1');
fAP('diesel','t1','qat')=1e2;
fAP('HFO','t1','qat')= 1e2;
fAP('Coal','t1','qat')=fintlprice('coal','t1');

* set administered prices - KSA
fAP('methane','t1','ksa')=0.75;
fAP('arablight','t1','ksa')=4.24;
fAP('u-235','t1','ksa')=101.5;
fAP('ethane','t1','ksa')=0.75;
fAP('arabheavy','t1','ksa')=6;
fAP('diesel','t1','ksa')=27;
fAP('HFO','t1','ksa')= 14;
fAP('Coal','t1','ksa')=fintlprice('coal','t1');


*fAP('arablight','t1','ksa')=4.25+(fintlprice('arablight','t1')-4.25)*(ord(g)/(card(g)-1)-1/(card(g)-1));
*fAP('diesel','t1','ksa')=26.66+(RFintlprice('diesel','t1')-26.66)*(ord(g)/(card(g)-1)-1/(card(g)-1));
*fAP('HFO','t1','ksa')= 14.05+(RFintlprice('HFO','t1')-14.05)*(ord(g)/(card(g)-1)-1/(card(g)-1));

* set administered prices - UAE
fAP('methane','t1','uae')=2.00;
fAP('arablight','t1','uae')=fintlprice('arablight','t1');
fAP('u-235','t1','uae')=fintlprice('u-235','t1');
fAP('ethane','t1','uae')=2.00;
fAP('arabheavy','t1','uae')=fintlprice('arablight','t1');
fAP('diesel','t1','uae')=1e2;
fAP('HFO','t1','uae')= 1e2;
fAP('Coal','t1','uae')=fintlprice('coal','t1');

ELAPf(ELf,trun,r,c) = fAP(ELf,trun,c);
WAAPf(ELf,trun,r,c) = fAP(ELf,trun,c);

solve integratedMCP using MCP;

$INCLUDE simple_report.gms
$INCLUDE RW_emissions.gms
$INCLUDE costcalcs.gms










