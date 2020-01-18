* solve climate scnenarios
* GRADUAL

* multi-period

option limcol=1e5;
option limrow=1e5;
option savepoint=2;

capsub(ELp,trun)=0;

* =========================================================
tradecap=1;
ELWAcoord(c)=0;

fMP(f,c)= no;
fMPt(f,c)=no;

ELfMP(ELf,c)=no;
WAfMP(WAf,c)=no;

ELfAP(ELf,c)=yes;
WAfAP(WAf,c)=yes;

* set administered prices - Bahrain
fAP('methane','t01','bah')=2.75;
fAP('arablight','t01','bah')=fintlprice('arablight','t01');
fAP('u-235','t01','bah')=fintlprice('u-235','t01');
fAP('ethane','t01','bah')=2.00;
fAP('arabheavy','t01','bah')=fintlprice('arablight','t01');
fAP('diesel','t01','bah')=268.48;
fAP('HFO','t01','bah')= 1e2;
fAP('Coal','t01','bah')=fintlprice('coal','t01');

* Kuwait
*fAP('methane','t01','kuw')=fintlprice('methane','t01');
fAP('methane','t01','kuw')=3.53;
fAP('arablight','t01','kuw')=42.10;
fAP('u-235','t01','kuw')=fintlprice('u-235','t01');
fAP('ethane','t01','kuw')=2.00;
fAP('arabheavy','t01','kuw')=fintlprice('arabheavy','t01');
fAP('diesel','t01','kuw')=470.46;
fAP('HFO','t01','kuw')= 297.91;
fAP('Coal','t01','kuw')=fintlprice('coal','t01');

* set administered prices - Oman
fAP('methane','t01','omn')=2.00;
fAP('arablight','t01','omn')=fintlprice('arablight','t01');
fAP('u-235','t01','omn')=fintlprice('u-235','t01');
fAP('ethane','t01','omn')=2.00;
fAP('arabheavy','t01','omn')=fintlprice('arablight','t01');
fAP('diesel','t01','omn')=1e2;
fAP('HFO','t01','omn')= 1e2;
fAP('Coal','t01','omn')=fintlprice('coal','t01');

* set administered prices - Qatar
fAP('methane','t01','qat')=1.50;
fAP('arablight','t01','qat')=fintlprice('arablight','t01');
fAP('u-235','t01','qat')=fintlprice('u-235','t01');
fAP('ethane','t01','qat')=2.00;
fAP('arabheavy','t01','qat')=fintlprice('arablight','t01');
fAP('diesel','t01','qat')=1e2;
fAP('HFO','t01','qat')= 1e2;
fAP('Coal','t01','qat')=fintlprice('coal','t01');

* set administered prices - KSA
fAP('methane','t01','ksa')=0.75;
fAP('arablight','t01','ksa')=4.24;
fAP('u-235','t01','ksa')=101.5;
fAP('ethane','t01','ksa')=0.75;
fAP('arabheavy','t01','ksa')=6;
fAP('diesel','t01','ksa')=27;
fAP('HFO','t01','ksa')= 14;
fAP('Coal','t01','ksa')=fintlprice('coal','t01');

* set administered prices - UAE
fAP('methane','t01','uae')=2.00;
fAP('arablight','t01','uae')=fintlprice('arablight','t01');
fAP('u-235','t01','uae')=fintlprice('u-235','t01');
fAP('ethane','t01','uae')=2.00;
fAP('arabheavy','t01','uae')=fintlprice('arablight','t01');
fAP('diesel','t01','uae')=1e2;
fAP('HFO','t01','uae')= 1e2;
fAP('Coal','t01','uae')=fintlprice('coal','t01');

*ELfconsumpmax(ELf,trun,r,c)$rc(r,c)=fconsumpmax_save("EL",ELf,trun,r,c);
*WAfconsumpmax(WAf,trun,r,c)$rc(r,c)=fconsumpmax_save("WA",WAf,trun,r,c);

* =========================================================
* policies for multi-year solve

* set administered fuel credit to 0
fcr(f,trun,c)=0;

* initialize dynamic set t
t(trun)=yes$time2(trun);

* solve recursive
loop(trun,

if(t_start<=4,
t_ind(t)= ord(t)+ord(trun)-t_start;
else
t_ind(t)= ord(t)+ord(trun)-4;
);
t_ind(t)$(t_ind(t)<=0)= 1;

display t_ind;


* Dolphin:
ftrans.up('methane',trun,'qatr','qat','adwe','uae')=400+300+100;
*ftrans.up('methane',t,'adwe','uae','dewa','uae')=300;
ftrans.lo('methane',trun,'adwe','uae','omnr','omn')=50;
ftrans.lo('arablight',trun,'east','ksa','bahr','bah')=100;

* control plant builds and fuel
ELbld.fx('CoalSteam',v,trun,r,c)=0;

if(ord(trun)=1,
*execute_loadpoint "integratedMCP_p1.gdx";

fMP(f,c)= no;
*fMP('methane')= yes;
*fMP(f)= yes;

ELfMP(ELf,c)$fmp(ELf,c)= yes;
ELfAP(ELf,c)= not fmp(ELf,c);

WAfMP(WAf,c)$fmp(WAf,c)= yes;
WAfAP(WAf,c)= not fmp(WAf,c);

tradecap=1;

*$ontext
ELWAcoord('ksa')=0;
ELWAcoord('kuw')=1;
ELWAcoord('qat')=1;
ELWAcoord('bah')=1;
ELWAcoord('omn')=1;
ELWAcoord('uae')=1;
*$offtext

ELAPf(ELf,trun,r,c) = fAP(ELf,trun,c);
WAAPf(WAf,trun,r,c) = fAP(WAf,trun,c);

ELop_trade.fx(ELpd,v,ELl,ELs,ELday,ELf,trun,r,c)=0;
ELfconsump_trade.fx(ELpd,ELf,trun,r,c)=0;
WAFop_trade.fx(WApF,v,WAf,trun,r,c)=0;
WAfconsump_trade.fx(fup,t,rr,cc)$WAf(fup)=0;

solve integratedMCP using MCP;
);


* ======== t02 =========
if(ord(trun)=2,

*execute_loadpoint "integratedMCP_p2.gdx";

fMP(f,c)= no;
*fMP('methane')= yes;
*fMP(f)= yes;

ELfMP(ELf,c)$fmp(ELf,c)= yes;
ELfAP(ELf,c)= not fmp(ELf,c);

WAfMP(WAf,c)$fmp(WAf,c)= yes;
WAfAP(WAf,c)= not fmp(WAf,c);

tradecap=1;

*$ontext
ELWAcoord('ksa')=0;
ELWAcoord('kuw')=1;
ELWAcoord('qat')=1;
ELWAcoord('bah')=1;
ELWAcoord('omn')=1;
ELWAcoord('uae')=1;
*$offtext

* set administered prices - Bahrain
fAP('methane','t02','bah')=2.75;
fAP('arablight','t02','bah')=fintlprice('arablight','t01');
fAP('u-235','t02','bah')=fintlprice('u-235','t01');
fAP('ethane','t02','bah')=2.00;
fAP('arabheavy','t02','bah')=fintlprice('arablight','t01');
fAP('diesel','t02','bah')=268.48;
fAP('HFO','t02','bah')= 1e2;
fAP('Coal','t02','bah')=fintlprice('coal','t01');

* Kuwait
*fAP('methane','t02','kuw')=fintlprice('methane','t02');
fAP('methane','t02','kuw')=3.53;
fAP('arablight','t02','kuw')=42.10;
fAP('u-235','t02','kuw')=fintlprice('u-235','t01');
fAP('ethane','t02','kuw')=2.00;
fAP('arabheavy','t02','kuw')=fintlprice('arabheavy','t01');
fAP('diesel','t02','kuw')=470.46;
fAP('HFO','t02','kuw')= 297.91;
fAP('Coal','t02','kuw')=fintlprice('coal','t01');

* set administered prices - Oman
fAP('methane','t02','omn')=2.00;
fAP('arablight','t02','omn')=fintlprice('arablight','t01');
fAP('u-235','t02','omn')=fintlprice('u-235','t01');
fAP('ethane','t02','omn')=2.00;
fAP('arabheavy','t02','omn')=fintlprice('arablight','t01');
fAP('diesel','t02','omn')=1e2;
fAP('HFO','t02','omn')= 1e2;
fAP('Coal','t02','omn')=fintlprice('coal','t01');

* set administered prices - Qatar
fAP('methane','t02','qat')=1.50;
fAP('arablight','t02','qat')=fintlprice('arablight','t01');
fAP('u-235','t02','qat')=fintlprice('u-235','t01');
fAP('ethane','t02','qat')=2.00;
fAP('arabheavy','t02','qat')=fintlprice('arablight','t01');
fAP('diesel','t02','qat')=1e2;
fAP('HFO','t02','qat')= 1e2;
fAP('Coal','t02','qat')=fintlprice('coal','t01');

* set adminstered prices - KSA
fAP('methane','t02','ksa')=1.25;
*fAP('arablight','t02','ksa')=6.35;
fAP('arablight','t02','ksa')=7.25;
fAP('u-235','t02','ksa')=101.5;
fAP('ethane','t02','ksa')=0.75;
fAP('arabheavy','t02','ksa')=6;

fAP('diesel','t02','ksa')=105.26/2;
fAP('HFO','t02','ksa')= 28.52;
fAP('Coal','t02','ksa')=fintlprice('coal','t01');


* set administered prices - UAE
fAP('methane','t02','uae')=2.00;
fAP('arablight','t02','uae')=fintlprice('arablight','t01');
fAP('u-235','t02','uae')=fintlprice('u-235','t01');
fAP('ethane','t02','uae')=2.00;
fAP('arabheavy','t02','uae')=fintlprice('arablight','t01');
fAP('diesel','t02','uae')=1e2;
fAP('HFO','t02','uae')= 1e2;
fAP('Coal','t02','uae')=fintlprice('coal','t01');

ELAPf(ELf,trun,r,c) = fAP(ELf,trun,c);
WAAPf(WAf,trun,r,c) = fAP(WAf,trun,c);


ELop_trade.fx(ELpd,v,ELl,ELs,ELday,ELf,trun,r,c)=0;
ELfconsump_trade.fx(ELpd,ELf,trun,r,c)=0;
WAFop_trade.fx(WApF,v,WAf,trun,r,c)=0;
WAfconsump_trade.fx(fup,t,rr,cc)$WAf(fup)=0;

display ELfAP,ELAPf;

solve integratedMCP using MCP;

);
* ===== t03 ======

if((ord(trun)=3),

*execute_loadpoint "integratedMCP_p3.gdx";

fMP(f,c)= no;
*fMP('methane')= yes;
*fMP(f)= yes;

ELfMP(ELf,c)$fmp(ELf,c)= yes;
ELfAP(ELf,c)= not fmp(ELf,c);

WAfMP(WAf,c)$fmp(WAf,c)= yes;
WAfAP(WAf,c)= not fmp(WAf,c);

tradecap=1;

*$ontext
ELWAcoord('ksa')=0;
ELWAcoord('kuw')=1;
ELWAcoord('qat')=1;
ELWAcoord('bah')=1;
ELWAcoord('omn')=1;
ELWAcoord('uae')=1;
*$offtext

* set administered prices - Bahrain
fAP('methane','t03','bah')=2.75;
fAP('arablight','t03','bah')=fintlprice('arablight','t01');
fAP('u-235','t03','bah')=fintlprice('u-235','t01');
fAP('ethane','t03','bah')=2.00;
fAP('arabheavy','t03','bah')=fintlprice('arablight','t01');
fAP('diesel','t03','bah')=268.48;
fAP('HFO','t03','bah')= 1e2;
fAP('Coal','t03','bah')=fintlprice('coal','t01');

* Kuwait
*fAP('methane','t03','kuw')=fintlprice('methane','t03');
fAP('methane','t03','kuw')=3.53;
fAP('arablight','t03','kuw')=42.10;
fAP('u-235','t03','kuw')=fintlprice('u-235','t01');
fAP('ethane','t03','kuw')=2.00;
fAP('arabheavy','t03','kuw')=fintlprice('arabheavy','t01');
fAP('diesel','t03','kuw')=470.46;
fAP('HFO','t03','kuw')= 297.91;
fAP('Coal','t03','kuw')=fintlprice('coal','t01');

* set administered prices - Oman
fAP('methane','t03','omn')=2.00;
fAP('arablight','t03','omn')=fintlprice('arablight','t01');
fAP('u-235','t03','omn')=fintlprice('u-235','t01');
fAP('ethane','t03','omn')=2.00;
fAP('arabheavy','t03','omn')=fintlprice('arablight','t01');
fAP('diesel','t03','omn')=1e2;
fAP('HFO','t03','omn')= 1e2;
fAP('Coal','t03','omn')=fintlprice('coal','t01');

* set administered prices - Qatar
fAP('methane','t03','qat')=1.50;
fAP('arablight','t03','qat')=fintlprice('arablight','t01');
fAP('u-235','t03','qat')=fintlprice('u-235','t01');
fAP('ethane','t03','qat')=2.00;
fAP('arabheavy','t03','qat')=fintlprice('arablight','t01');
fAP('diesel','t03','qat')=1e2;
fAP('HFO','t03','qat')= 1e2;
fAP('Coal','t03','qat')=fintlprice('coal','t01');

* set adminstered prices - KSA
fAP('methane','t03','ksa')=1.25;
*fAP('arablight','t03','ksa')=6.35;
fAP('arablight','t03','ksa')=7.25;
fAP('u-235','t03','ksa')=101.5;
fAP('ethane','t03','ksa')=0.75;
fAP('arabheavy','t03','ksa')=6;

fAP('diesel','t03','ksa')=105.26/2;
fAP('HFO','t03','ksa')= 28.52;
fAP('Coal','t03','ksa')=fintlprice('coal','t01');


* set administered prices - UAE
fAP('methane','t03','uae')=2.00;
fAP('arablight','t03','uae')=fintlprice('arablight','t01');
fAP('u-235','t03','uae')=fintlprice('u-235','t01');
fAP('ethane','t03','uae')=2.00;
fAP('arabheavy','t03','uae')=fintlprice('arablight','t01');
fAP('diesel','t03','uae')=1e2;
fAP('HFO','t03','uae')= 1e2;
fAP('Coal','t03','uae')=fintlprice('coal','t01');

ELAPf(ELf,trun,r,c) = fAP(ELf,trun,c);
WAAPf(WAf,trun,r,c) = fAP(WAf,trun,c);

display ELfMP,WAfMP,ELAPf,WAAPf;

ELop_trade.fx(ELpd,v,ELl,ELs,ELday,ELf,trun,r,c)=0;
ELfconsump_trade.fx(ELpd,ELf,trun,r,c)=0;
WAFop_trade.fx(WApF,v,WAf,trun,r,c)=0;
WAfconsump_trade.fx(fup,t,rr,cc)$WAf(fup)=0;

solve integratedMCP using MCP;

);
* ===== t>3 ======

if((ord(trun)>3),


fMP(f,c)=no;
ELWAcoord(c)=1;
tradecap=1;


fAP(fup,trun,c)$(ord(trun)>3)=
  fAP(fup,'t03',c)+(ord(trun)-4)*(dereg_factor*fintlprice(fup,'t16')-fAP(fup,'t03',c))/12;

fAP(ELfref,trun,c)$(ord(trun)>3)=
  fAP(ELfref,'t03',c)+(ord(trun)-4)*(dereg_factor*RFintlprice(ELfref,'t16')-fAP(ELfref,'t03',c))/12;

display fMP,fintlprice,fAP;

ELWAcoord(c)=1;
tradecap=1;

*$ontext
ELfMP(ELf,c)$fmp(ELf,c)= yes;
ELfAP(ELf,c)= not fmp(ELf,c);

WAfMP(WAf,c)$fmp(WAf,c)= yes;
WAfAP(WAf,c)= not fmp(WAf,c);
*$offtext

ELAPf(ELf,trun,r,c) = fAP(ELf,trun,c);
WAAPf(WAf,trun,r,c) = fAP(WAf,trun,c);

ELop_trade.fx(ELpd,v,ELl,ELs,ELday,ELf,trun,r,c)=0;
ELfconsump_trade.fx(ELpd,ELf,trun,r,c)=0;
WAFop_trade.fx(WApF,v,WAf,trun,r,c)=0;
WAfconsump_trade.fx(fup,t,rr,cc)$WAf(fup)=0;

ELbld.fx('Nuclear','new','t14','cent','ksa')=2.8;

ELrenbld.lo('pv',vn,'t05','east','ksa')=0.5;
ELrenbld.lo('wind',vn,'t05','east','ksa')=0.5;
ELrenbld.lo('pv',vn,'t06','east','ksa')=0.5;
ELrenbld.lo('wind',vn,'t06','east','ksa')=0.5;

ELrenbld.lo('pv',vn,'t07','east','ksa')=1.0;
ELrenbld.lo('wind',vn,'t07','east','ksa')=1.0;

ELrenbld.lo('pv',vn,'t08','east','ksa')=1.5;
ELrenbld.lo('wind',vn,'t08','east','ksa')=1.0;

ELrenbld.lo('pv',vn,'t09','east','ksa')=1.5;
ELrenbld.lo('wind',vn,'t09','east','ksa')=1.5;

solve integratedMCP using MCP;

);


*$ontext
t_ind(t)=0;
* variable fix and bounds
ftransexistcp.fx(fup,trun+1,r,c,rr,cc)$(rc(r,c) and rc(rr,cc))=
  ftransexistcp.l(fup,trun,r,c,rr,cc)
 +ftransbld.l(fup,trun-ftransleadtime(fup,r,c,rr,cc),r,c,rr,cc)
 -ftransexistcp.l(fup,trun+1,r,c,rr,cc);

WAexistcp.fx(WAp,v,trun+1,r,c)$rc(r,c)=
 +WAaddition(WAp,v,trun+1,r,c)
 -WAretirement(WAp,v,trun+1,r,c)
 +WAexistcp.l(WAp,v,trun,r,c)
 +WAbld.l(WAp,v,trun,r,c);

WAtransexistcp.fx(trun+1,r,c,rr,cc)$(rc(r,c) and rc(rr,cc))=
  WAtransexistcp.l(trun,r,c,rr,cc)
 +WAtransbld.l(trun-WAtransleadtime(r,c,rr,cc),r,c,rr,cc)
 -WAtransexistcp.l(trun+1,r,c,rr,cc);

WAstoexistcp.fx(trun+1,r,c)$rc(r,c)=
  WAstoexistcp.l(trun,r,c)
 +WAstobld.l(trun-WAstoleadtime,r,c)
 -WAstoexistcp.l(trun+1,r,c);

ELexistcp.fx(ELpd,v,trun+1,r,c)$rc(r,c)=
 +ELaddition(ELpd,v,trun,r,c)
 -ELretirement(ELpd,v,trun,r,c)
 +ELexistcp.l(ELpd,v,trun,r,c)
 +sum(ELpp$((ELpcom(ELpp) and vn(v)) or (vo(v) and ELpgttocc(ELpp))),
      ELcapadd(ELpp,ELpd)*ELbld.l(ELpp,v,trun,r,c));

ELrenexistcp.fx(ELpsw,v,trun+1,r,c)$rc(r,c)=(ELrenexistcp.l(ELpsw,v,trun,r,c)
 +ELrenbld.l(ELpsw,v,trun,r,c)$vn(v))*(1-PVdegrade(r,c)$(ELppv(ELpsw)));

TRexistcp.fx(r,c,rr,cc,trun+1)$(rc(r,c) and rc(rr,cc))= TRexistcp.l(r,c,rr,cc,trun)
 +TRbld.l(r,c,rr,cc,trun-TRleadtime(r,c,rr,cc));

*ELtransexistcp.fx(trun+1,r,c,rr,cc)$(rc(r,c) and rc(rr,cc))=ELtransexistcp.l(trun,r,c,rr,cc)
* +ELtransbld.l(trun-ELtransleadtime(r,c,rr,cc),r,c,rr,cc);

ELgttocc.fx('GTtoCC','old',trun+1,r,c)$rc(r,c)=(ELgttocc.l('GTtoCC','old',trun,r,c)
 -ELbld.l('GTtoCC','old',trun,r,c))$(ELbld.l('GTtoCC','old',trun,r,c)<0.999*ELgttocc.l('GTtoCC','old',trun,r,c));

* add the next time periods to dynamic set t
if(card(trun) -ord(trun) >= card(time2),
 t(trun+card(time2))=yes;
);

*  push forward all discounted investment costs
*  only when horizon is constant, i.e. not shrinking
if(card(trun) - ord(trun) >= card(time2),

fdiscfact(t+1)= fdiscfact(t);
ftranspurcst(fup,t+1,r,c,rr,cc)$(rc(r,c) and rc(rr,cc))= ftranspurcst(fup,t,r,c,rr,cc);

WAdiscfact(t+1)= WAdiscfact(t);
WApurcst(WAp,t+1,r,c)= WApurcst(WAp,t,r,c);
WAtranspurcst(t+1,r,c,rr,cc)= WAtranspurcst(t,r,c,rr,cc);
WAstopurcst(t+1,r,c)= WAstopurcst(t,r,c);

* step forward discount coefficient and recalculate the discounted purchase cost
ELdiscfact(t+1)=ELdiscfact(t);
ELdiscoef1(ELp,t+1)=ELdiscoef1(ELp,t);
ELCapital(ELp,t+1,r,c)$(rc(r,c) and ELcapital(ELp,t,r,c)>0)=ELcapital(ELp,t,r,c)*1.0;

TRcapital(t+1,r,c,rr,cc)$(rc(r,c) and rc(rr,cc))=TRcapital(t+1,r,c,rr,cc);

*ELtranspurcst(r,c,t+1,rr,cc)$(rc(r,c) and rc(rr,cc))=ELtranspurcst(r,c,t,rr,cc);
);

* remove the initial time period from dynamic set t
t(trun)=no;

* close trun loop
$INCLUDE simple_report.gms
$INCLUDE RW_emissions.gms

)
;
