* solve climate scnenarios
* Carbon Intensity Standard

* multi-period

option limcol=1e5;
option limrow=1e5;
option savepoint=2;

capsub(ELp,trun)=0;

* =========================================================
tradecap=1;
ELWAcoord(c)=0;

fMP(f,c)= no;

ELfMP(ELf,c)=no;
WAfMP(WAf,c)=no;

ELfAP(ELf,c)=yes;
WAfAP(WAf,c)=yes;

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

* set administered prices - UAE
fAP('methane','t1','uae')=2.00;
fAP('arablight','t1','uae')=fintlprice('arablight','t1');
fAP('u-235','t1','uae')=fintlprice('u-235','t1');
fAP('ethane','t1','uae')=2.00;
fAP('arabheavy','t1','uae')=fintlprice('arablight','t1');
fAP('diesel','t1','uae')=1e2;
fAP('HFO','t1','uae')= 1e2;
fAP('Coal','t1','uae')=fintlprice('coal','t1');

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

$ontext
if(ord(trun)=1 and savedrun>=1,
        execute_loadpoint "integratedMCP_p1.gdx";
elseif ord(trun)=1+1 and savedrun>=2,
        execute_loadpoint "integratedMCP_p2.gdx";
elseif ord(trun)=1+2 and savedrun>=3,
        execute_loadpoint "integratedMCP_p3.gdx";
elseif ord(trun)=1+3 and savedrun>=4,
        execute_loadpoint "integratedMCP_p4.gdx";
elseif ord(trun)=1+4 and savedrun>=5,
        execute_loadpoint "integratedMCP_p5.gdx";
elseif ord(trun)=1+5 and savedrun>=6,
        execute_loadpoint "integratedMCP_p6.gdx";
elseif ord(trun)=1+6 and savedrun>=7,
        execute_loadpoint "integratedMCP_p7.gdx";
elseif ord(trun)=1+7 and savedrun>=8,
        execute_loadpoint "integratedMCP_p8.gdx";
elseif ord(trun)=1+8 and savedrun>=9,
        execute_loadpoint "integratedMCP_p9.gdx";
elseif ord(trun)=1+9 and savedrun>=10,
        execute_loadpoint "integratedMCP_p10.gdx";
elseif ord(trun)=1+10 and savedrun>=11,
        execute_loadpoint "integratedMCP_p11.gdx";
elseif ord(trun)=1+11 and savedrun>=12,
        execute_loadpoint "integratedMCP_p12.gdx";
elseif ord(trun)=1+12 and savedrun>=13,
        execute_loadpoint "integratedMCP_p13.gdx";
elseif ord(trun)=1+13 and savedrun>=14,
        execute_loadpoint "integratedMCP_p14.gdx";
elseif ord(trun)=1+14 and savedrun>=15,
        execute_loadpoint "integratedMCP_p15.gdx";
elseif ord(trun)=1+15 and savedrun>=16,
        execute_loadpoint "integratedMCP_p16.gdx";
);
$offtext

* ======== t1 =========
if(ord(trun)=1,
execute_loadpoint "integratedMCP_p1.gdx";

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
ELWAcoord('kuw')=0;
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


* ======== t2 =========
if(ord(trun)=2,

execute_loadpoint "integratedMCP_p2.gdx";

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
ELWAcoord('kuw')=0;
ELWAcoord('qat')=1;
ELWAcoord('bah')=1;
ELWAcoord('omn')=1;
ELWAcoord('uae')=1;
*$offtext

* set administered prices - Bahrain
fAP('methane','t2','bah')=2.75;
fAP('arablight','t2','bah')=fintlprice('arablight','t1');
fAP('u-235','t2','bah')=fintlprice('u-235','t1');
fAP('ethane','t2','bah')=2.00;
fAP('arabheavy','t2','bah')=fintlprice('arablight','t1');
fAP('diesel','t2','bah')=268.48;
fAP('HFO','t2','bah')= 1e2;
fAP('Coal','t2','bah')=fintlprice('coal','t1');

* Kuwait
*fAP('methane','t2','kuw')=fintlprice('methane','t2');
fAP('methane','t2','kuw')=3.53;
fAP('arablight','t2','kuw')=42.10;
fAP('u-235','t2','kuw')=fintlprice('u-235','t1');
fAP('ethane','t2','kuw')=2.00;
fAP('arabheavy','t2','kuw')=fintlprice('arabheavy','t1');
fAP('diesel','t2','kuw')=470.46;
fAP('HFO','t2','kuw')= 297.91;
fAP('Coal','t2','kuw')=fintlprice('coal','t1');

* set administered prices - Oman
fAP('methane','t2','omn')=2.00;
fAP('arablight','t2','omn')=fintlprice('arablight','t1');
fAP('u-235','t2','omn')=fintlprice('u-235','t1');
fAP('ethane','t2','omn')=2.00;
fAP('arabheavy','t2','omn')=fintlprice('arablight','t1');
fAP('diesel','t2','omn')=1e2;
fAP('HFO','t2','omn')= 1e2;
fAP('Coal','t2','omn')=fintlprice('coal','t1');

* set administered prices - Qatar
fAP('methane','t2','qat')=1.50;
fAP('arablight','t2','qat')=fintlprice('arablight','t1');
fAP('u-235','t2','qat')=fintlprice('u-235','t1');
fAP('ethane','t2','qat')=2.00;
fAP('arabheavy','t2','qat')=fintlprice('arablight','t1');
fAP('diesel','t2','qat')=1e2;
fAP('HFO','t2','qat')= 1e2;
fAP('Coal','t2','qat')=fintlprice('coal','t1');

* set adminstered prices - KSA
fAP('methane','t2','ksa')=1.25;
*fAP('arablight','t2','ksa')=6.35;
fAP('arablight','t2','ksa')=7.25;
fAP('u-235','t2','ksa')=101.5;
fAP('ethane','t2','ksa')=0.75;
fAP('arabheavy','t2','ksa')=6;

fAP('diesel','t2','ksa')=105.26/2;
fAP('HFO','t2','ksa')= 28.52;
fAP('Coal','t2','ksa')=fintlprice('coal','t1');


* set administered prices - UAE
fAP('methane','t2','uae')=2.00;
fAP('arablight','t2','uae')=fintlprice('arablight','t1');
fAP('u-235','t2','uae')=fintlprice('u-235','t1');
fAP('ethane','t2','uae')=2.00;
fAP('arabheavy','t2','uae')=fintlprice('arablight','t1');
fAP('diesel','t2','uae')=1e2;
fAP('HFO','t2','uae')= 1e2;
fAP('Coal','t2','uae')=fintlprice('coal','t1');



ELAPf(ELf,trun,r,c) = fAP(ELf,trun,c);
WAAPf(WAf,trun,r,c) = fAP(WAf,trun,c);


ELop_trade.fx(ELpd,v,ELl,ELs,ELday,ELf,trun,r,c)=0;
ELfconsump_trade.fx(ELpd,ELf,trun,r,c)=0;
WAFop_trade.fx(WApF,v,WAf,trun,r,c)=0;
WAfconsump_trade.fx(fup,t,rr,cc)$WAf(fup)=0;

display ELfAP,ELAPf;

solve integratedMCP using MCP;

);

* ===== t3 ======

if((ord(trun)=3),

execute_loadpoint "integratedMCP_p3.gdx";

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
ELWAcoord('kuw')=0;
ELWAcoord('qat')=1;
ELWAcoord('bah')=1;
ELWAcoord('omn')=1;
ELWAcoord('uae')=1;
*$offtext

* set administered prices - Bahrain
fAP('methane','t3','bah')=2.75;
fAP('arablight','t3','bah')=fintlprice('arablight','t1');
fAP('u-235','t3','bah')=fintlprice('u-235','t1');
fAP('ethane','t3','bah')=2.00;
fAP('arabheavy','t3','bah')=fintlprice('arablight','t1');
fAP('diesel','t3','bah')=268.48;
fAP('HFO','t3','bah')= 1e2;
fAP('Coal','t3','bah')=fintlprice('coal','t1');

* Kuwait
*fAP('methane','t3','kuw')=fintlprice('methane','t3');
fAP('methane','t3','kuw')=3.53;
fAP('arablight','t3','kuw')=42.10;
fAP('u-235','t3','kuw')=fintlprice('u-235','t1');
fAP('ethane','t3','kuw')=2.00;
fAP('arabheavy','t3','kuw')=fintlprice('arabheavy','t1');
fAP('diesel','t3','kuw')=470.46;
fAP('HFO','t3','kuw')= 297.91;
fAP('Coal','t3','kuw')=fintlprice('coal','t1');

* set administered prices - Oman
fAP('methane','t3','omn')=2.00;
fAP('arablight','t3','omn')=fintlprice('arablight','t1');
fAP('u-235','t3','omn')=fintlprice('u-235','t1');
fAP('ethane','t3','omn')=2.00;
fAP('arabheavy','t3','omn')=fintlprice('arablight','t1');
fAP('diesel','t3','omn')=1e2;
fAP('HFO','t3','omn')= 1e2;
fAP('Coal','t3','omn')=fintlprice('coal','t1');

* set administered prices - Qatar
fAP('methane','t3','qat')=1.50;
fAP('arablight','t3','qat')=fintlprice('arablight','t1');
fAP('u-235','t3','qat')=fintlprice('u-235','t1');
fAP('ethane','t3','qat')=2.00;
fAP('arabheavy','t3','qat')=fintlprice('arablight','t1');
fAP('diesel','t3','qat')=1e2;
fAP('HFO','t3','qat')= 1e2;
fAP('Coal','t3','qat')=fintlprice('coal','t1');

* set adminstered prices - KSA
fAP('methane','t3','ksa')=1.25;
*fAP('arablight','t3','ksa')=6.35;
fAP('arablight','t3','ksa')=7.25;
fAP('u-235','t3','ksa')=101.5;
fAP('ethane','t3','ksa')=0.75;
fAP('arabheavy','t3','ksa')=6;

fAP('diesel','t3','ksa')=105.26/2;
fAP('HFO','t3','ksa')= 28.52;
fAP('Coal','t3','ksa')=fintlprice('coal','t1');


* set administered prices - UAE
fAP('methane','t3','uae')=2.00;
fAP('arablight','t3','uae')=fintlprice('arablight','t1');
fAP('u-235','t3','uae')=fintlprice('u-235','t1');
fAP('ethane','t3','uae')=2.00;
fAP('arabheavy','t3','uae')=fintlprice('arablight','t1');
fAP('diesel','t3','uae')=1e2;
fAP('HFO','t3','uae')= 1e2;
fAP('Coal','t3','uae')=fintlprice('coal','t1');

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

tradecap=1;

*$ontext
ELWAcoord('ksa')=0;
ELWAcoord('kuw')=0;
ELWAcoord('qat')=1;
ELWAcoord('bah')=1;
ELWAcoord('omn')=1;
ELWAcoord('uae')=1;
*$offtext

*$ontext
ELfMP(ELf,c)$fmp(ELf,c)= yes;
ELfAP(ELf,c)= not fmp(ELf,c);

WAfMP(WAf,c)$fmp(WAf,c)= yes;
WAfAP(WAf,c)= not fmp(WAf,c);
*$offtext


* set administered prices - Bahrain
fAP('methane',trun,'bah')=2.75;
fAP('arablight',trun,'bah')=fintlprice('arablight','t1');
fAP('u-235',trun,'bah')=fintlprice('u-235','t1');
fAP('ethane',trun,'bah')=2.00;
fAP('arabheavy',trun,'bah')=fintlprice('arablight','t1');
fAP('diesel',trun,'bah')=268.48;
fAP('HFO',trun,'bah')= 1e2;
fAP('Coal',trun,'bah')=fintlprice('coal','t1');

* Kuwait
*fAP('methane',trun,'kuw')=fintlprice('methane',trun);
fAP('methane',trun,'kuw')=3.53;
fAP('arablight',trun,'kuw')=42.10;
fAP('u-235',trun,'kuw')=fintlprice('u-235','t1');
fAP('ethane',trun,'kuw')=2.00;
fAP('arabheavy',trun,'kuw')=fintlprice('arabheavy','t1');
fAP('diesel',trun,'kuw')=470.46;
fAP('HFO',trun,'kuw')= 297.91;
fAP('Coal',trun,'kuw')=fintlprice('coal','t1');

* set administered prices - Oman
fAP('methane',trun,'omn')=2.00;
fAP('arablight',trun,'omn')=fintlprice('arablight','t1');
fAP('u-235',trun,'omn')=fintlprice('u-235','t1');
fAP('ethane',trun,'omn')=2.00;
fAP('arabheavy',trun,'omn')=fintlprice('arablight','t1');
fAP('diesel',trun,'omn')=1e2;
fAP('HFO',trun,'omn')= 1e2;
fAP('Coal',trun,'omn')=fintlprice('coal','t1');

* set administered prices - Qatar
fAP('methane',trun,'qat')=1.50;
fAP('arablight',trun,'qat')=fintlprice('arablight','t1');
fAP('u-235',trun,'qat')=fintlprice('u-235','t1');
fAP('ethane',trun,'qat')=2.00;
fAP('arabheavy',trun,'qat')=fintlprice('arablight','t1');
fAP('diesel',trun,'qat')=1e2;
fAP('HFO',trun,'qat')= 1e2;
fAP('Coal',trun,'qat')=fintlprice('coal','t1');

* set adminstered prices - KSA
fAP('methane',trun,'ksa')=1.25;
*fAP('arablight',trun,'ksa')=6.35;
fAP('arablight',trun,'ksa')=7.25;
fAP('u-235',trun,'ksa')=101.5;
fAP('ethane',trun,'ksa')=0.75;
fAP('arabheavy',trun,'ksa')=6;

fAP('diesel',trun,'ksa')=105.26/2;
fAP('HFO',trun,'ksa')= 28.52;
fAP('Coal',trun,'ksa')=fintlprice('coal','t1');


* set administered prices - UAE
fAP('methane',trun,'uae')=2.00;
fAP('arablight',trun,'uae')=fintlprice('arablight','t1');
fAP('u-235',trun,'uae')=fintlprice('u-235','t1');
fAP('ethane',trun,'uae')=2.00;
fAP('arabheavy',trun,'uae')=fintlprice('arablight','t1');
fAP('diesel',trun,'uae')=1e2;
fAP('HFO',trun,'uae')= 1e2;
fAP('Coal',trun,'uae')=fintlprice('coal','t1');

$ontext
fAP('methane',trun,'ksa')$(ord(trun)>3)=1.25;
fAP('arablight',trun,'ksa')$(ord(trun)>3)=7.25;
fAP('diesel',trun,'ksa')$(ord(trun)>3)=26.66;
fAP('HFO',trun,'ksa')$(ord(trun)>3)= 14.05;

fAP('Coal',trun,'ksa')$(ord(trun)>3)=fintlprice('coal','t1');
fAP('u-235',trun,'ksa')$(ord(trun)>3)=101.5;
fAP('ethane',trun,'ksa')$(ord(trun)>3)=0.75;
fAP('arabheavy',trun,'ksa')$(ord(trun)>3)=6;
$offtext

ELAPf(ELf,trun,r,c) = fAP(ELf,trun,c);
WAAPf(WAf,trun,r,c) = fAP(WAf,trun,c);

display ELfMP,WAfMP,ELAPf,WAAPf;

*$ontext

ELbld.fx('Nuclear','new','t14','cent','ksa')=2.8;

* planned renewable builds
ELrenbld.lo('pv',vn,'t4','east','ksa')=0.3;
ELrenbld.lo('wind',vn,'t4','west','ksa')=0.4;
ELrenbld.lo('pv',vn,'t5','east','ksa')=0.65;
ELrenbld.lo('wind',vn,'t5','west','ksa')=0.4;
ELrenbld.lo('pv',vn,'t6','cent','ksa')=0.98;
ELrenbld.lo('wind',vn,'t6','east','ksa')=0.4;
ELrenbld.lo('csp',vn,'t6','west','ksa')=0.3;
*$offtext

*$ontext
ELrenbld.lo('pv',vn,'t5','east','ksa')=0.5;
ELrenbld.lo('wind',vn,'t5','east','ksa')=0.5;
ELrenbld.lo('pv',vn,'t6','east','ksa')=0.5;
ELrenbld.lo('wind',vn,'t6','east','ksa')=0.5;

ELrenbld.lo('pv',vn,'t7','east','ksa')=1.0;
ELrenbld.lo('wind',vn,'t7','east','ksa')=1.0;


ELrenbld.lo('pv',vn,'t8','east','ksa')=1.5;
ELrenbld.lo('wind',vn,'t8','east','ksa')=1.0;

ELrenbld.lo('pv',vn,'t9','east','ksa')=1.5;
ELrenbld.lo('wind',vn,'t9','east','ksa')=1.5;
*$offtext

ELop_trade.fx(ELpd,v,ELl,ELs,ELday,ELf,trun,r,c)=0;
ELfconsump_trade.fx(ELpd,ELf,trun,r,c)=0;
WAFop_trade.fx(WApF,v,WAf,trun,r,c)=0;
WAfconsump_trade.fx(fup,t,rr,cc)$WAf(fup)=0;

EMallquant.up('CO2','t6','ksa')=181;
EMallquant.up('CO2','t7','ksa')=178;
EMallquant.up('CO2','t8','ksa')=176;
EMallquant.up('CO2','t9','ksa')=174;
EMallquant.up('CO2','t10','ksa')=172;
EMallquant.up('CO2','t11','ksa')=169;
EMallquant.up('CO2','t12','ksa')=167;
EMallquant.up('CO2','t13','ksa')=165;
EMallquant.up('CO2','t14','ksa')=163;
EMallquant.up('CO2','t15','ksa')=160;
EMallquant.up('CO2','t16','ksa')=158;


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
*$INCLUDE costcalcs.gms

)
;
