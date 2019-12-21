* solve climate scnenarios
* REFERENCE

* multi-period

* multi-period

option limcol=1000;
option limrow=1000;
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

if(t_start<=5,
t_ind(t)= ord(t)+ord(trun)-t_start;
else
t_ind(t)= ord(t)+ord(trun)-5;
);
t_ind(t)$(t_ind(t)<=0)= 1;

display t_ind;


* Dolphin:
ftrans.up('methane',trun,'qatr','qat','adwe','uae')=400+300+100;
*ftrans.up('methane',t,'adwe','uae','dewa','uae')=300;
ftrans.lo('methane',trun,'adwe','uae','omnr','omn')=50;
ftrans.lo('arablight',trun,'east','ksa','bahr','bah')=100;

* control plant builds and fuel
*ELbld.up('CoalSteam',v,ttrun,r,c)=0;
*ELop.fx('CoalSteam',v,ELl,ELs,ELday,'coal',trun,r,c)=0;


* ======== t1 =========
if(ord(trun)=1,
execute_loadpoint "integratedMCP_p1.gdx";

fMP(f,c)= no;
*fMP('methane')= yes;
*fMP('Kuwait',f)= yes;

ELfMP(ELf,c)$fmp(ELf,c)= yes;
ELfAP(ELf,c)= not fmp(ELf,c);

WAfMP(WAf,c)$fmp(WAf,c)= yes;
WAfAP(WAf,c)= not fmp(WAf,c);

* GCC sets
fMPt(f,c)=  no;
*fMPt('methane',c)= yes;
fMPt(f,c)= yes;

ELfMPt(ELf,c)$fMPt(ELf,c)= yes;
WAfMPt(WAf,c)$fMPt(WAf,c)= yes;

display fMPt,ELfMPt,WAfMPt,ttrun;

tradecap=1;

*$ontext
ELWAcoord('ksa')=0;
ELWAcoord('kuw')=1;
ELWAcoord('qat')=1;
ELWAcoord('bah')=1;
ELWAcoord('omn')=1;
ELWAcoord('uae')=1;
*$offtext

ELAPf(ELf,ttrun,r,c) = fAP(ELf,ttrun,c);
WAAPf(WAf,ttrun,r,c) = fAP(WAf,ttrun,c);

ELop_trade.fx(ELpd,v,ELl,ELs,ELday,ELf,ttrun,r,c)=0;
ELfconsump_trade.fx(ELpd,ELf,ttrun,r,c)=0;
WAFop_trade.fx(WApF,v,WAf,ttrun,r,c)=0;
WAfconsump_trade.fx(fup,ttrun,rr,cc)$WAf(fup)=0;

display ELfAP,ELAPf;

solve integratedMCP using MCP;

);


* ======== t2 =========
if(ord(trun)=2,

execute_loadpoint "integratedMCP_p2.gdx";

fMP(f,c)= no;
*fMP('methane')= yes;
*fMP('arablight','kuw')= yes;

ELfMP(ELf,c)$fmp(ELf,c)= yes;
ELfAP(ELf,c)= not fmp(ELf,c);

WAfMP(WAf,c)$fmp(WAf,c)= yes;
WAfAP(WAf,c)= not fmp(WAf,c);

* GCC sets
fMPt(f,c)=  no;
*fMPt('methane',c)= yes;
*fMPt(f,'kuw')= yes;

ELfMPt(ELf,c)$fMPt(ELf,c)= yes;
WAfMPt(WAf,c)$fMPt(WAf,c)= yes;

display fMPt,ELfMPt,WAfMPt,ttrun;

* works when 0
tradecap=1;

*$ontext
ELWAcoord('ksa')=0;
ELWAcoord('kuw')=1;
ELWAcoord('qat')=1;
ELWAcoord('bah')=1;
ELWAcoord('omn')=1;
ELWAcoord('uae')=1;
*$offtext
*$ontext
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
*fAP('diesel','t2','kuw')=470.46/8;
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

fAP('diesel','t2','ksa')=fAP('diesel','t1','ksa');
fAP('HFO','t2','ksa')= fAP('HFO','t1','ksa');
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
*$offtext

ELAPf(ELf,ttrun,r,c) = fAP(ELf,ttrun,c);
WAAPf(WAf,ttrun,r,c) = fAP(WAf,ttrun,c);

ELop_trade.fx(ELpd,v,ELl,ELs,ELday,ELf,ttrun,r,c)=0;
ELfconsump_trade.fx(ELpd,ELf,ttrun,r,c)=0;
WAFop_trade.fx(WApF,v,WAf,ttrun,r,c)=0;
WAfconsump_trade.fx(fup,ttrun,rr,cc)$WAf(fup)=0;
display ELfAP,ELAPf;

solve integratedMCP using MCP;

);

* ===== t3 ======

if((ord(trun)=3),

execute_loadpoint "integratedMCP_p3.gdx";

fMP(f,c)= no;
*fMP('methane')= yes;
*fMP('methane','kuw')= yes;

ELfMP(ELf,c)$fmp(ELf,c)= yes;
ELfAP(ELf,c)= not fmp(ELf,c);

WAfMP(WAf,c)$fmp(WAf,c)= yes;
WAfAP(WAf,c)= not fmp(WAf,c);

* GCC sets
fMPt(f,c)=  no;
*fMPt('methane',c)= yes;
*fMPt(f,c)= yes;

ELfMPt(ELf,c)$fMPt(ELf,c)= yes;
WAfMPt(WAf,c)$fMPt(WAf,c)= yes;

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
fAP('methane','t3','kuw')=4.20;
fAP('arablight','t3','kuw')=51.20;
fAP('u-235','t3','kuw')=fintlprice('u-235','t1');
fAP('ethane','t3','kuw')=2.00;
fAP('arabheavy','t3','kuw')=fintlprice('arabheavy','t1');
fAP('diesel','t3','kuw')=504.20;
fAP('HFO','t3','kuw')= 370.50;
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

fAP('diesel','t3','ksa')=fAP('diesel','t1','ksa');
fAP('HFO','t3','ksa')= fAP('HFO','t1','ksa');
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

ELAPf(ELf,ttrun,r,c) = fAP(ELf,ttrun,c);
WAAPf(WAf,ttrun,r,c) = fAP(WAf,ttrun,c);

display ELfMP,WAfMP,ELAPf,WAAPf;

ELop_trade.fx(ELpd,v,ELl,ELs,ELday,ELf,ttrun,r,c)=0;
ELfconsump_trade.fx(ELpd,ELf,ttrun,r,c)=0;
WAFop_trade.fx(WApF,v,WAf,ttrun,r,c)=0;
WAfconsump_trade.fx(fup,ttrun,rr,cc)$WAf(fup)=0;

$ontext
if (ord(trun)=1+3 and savedrun>=4,
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

solve integratedMCP using MCP;

);


* ===== t4 ======

if((ord(trun)=4),

execute_loadpoint "integratedMCP_p4.gdx";

*WAbld.up('SWRO','new','t4',r,c)=1;

fMP(f,c)= no;
*fMP('methane')= yes;
*fMP('diesel','kuw')= yes;

ELfMP(ELf,c)$fmp(ELf,c)= yes;
ELfAP(ELf,c)= not fmp(ELf,c);

WAfMP(WAf,c)$fmp(WAf,c)= yes;
WAfAP(WAf,c)= not fmp(WAf,c);

* GCC sets
fMPt(f,c)=  no;
*fMPt('methane',c)= yes;
*fMPt(f,c)= yes;

ELfMPt(ELf,c)$fMPt(ELf,c)= yes;
WAfMPt(WAf,c)$fMPt(WAf,c)= yes;

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
fAP('methane','t4','bah')=2.75;
fAP('arablight','t4','bah')=fintlprice('arablight','t1');
fAP('u-235','t4','bah')=fintlprice('u-235','t1');
fAP('ethane','t4','bah')=2.00;
fAP('arabheavy','t4','bah')=fintlprice('arablight','t1');
fAP('diesel','t4','bah')=268.48;
fAP('HFO','t4','bah')= 1e2;
fAP('Coal','t4','bah')=fintlprice('coal','t1');

* Kuwait
*fAP('methane','t4','kuw')=fintlprice('methane','t4');
fAP('methane','t4','kuw')=4.20;
fAP('arablight','t4','kuw')=51.20;
fAP('u-235','t4','kuw')=fintlprice('u-235','t1');
fAP('ethane','t4','kuw')=2.00;
fAP('arabheavy','t4','kuw')=fintlprice('arabheavy','t1');
fAP('diesel','t4','kuw')=504.20;
fAP('HFO','t4','kuw')= 370.50;
fAP('Coal','t4','kuw')=fintlprice('coal','t1');

* set administered prices - Oman
fAP('methane','t4','omn')=2.00;
fAP('arablight','t4','omn')=fintlprice('arablight','t1');
fAP('u-235','t4','omn')=fintlprice('u-235','t1');
fAP('ethane','t4','omn')=2.00;
fAP('arabheavy','t4','omn')=fintlprice('arablight','t1');
fAP('diesel','t4','omn')=1e2;
fAP('HFO','t4','omn')= 1e2;
fAP('Coal','t4','omn')=fintlprice('coal','t1');

* set administered prices - Qatar
fAP('methane','t4','qat')=1.50;
fAP('arablight','t4','qat')=fintlprice('arablight','t1');
fAP('u-235','t4','qat')=fintlprice('u-235','t1');
fAP('ethane','t4','qat')=2.00;
fAP('arabheavy','t4','qat')=fintlprice('arablight','t1');
fAP('diesel','t4','qat')=1e2;
fAP('HFO','t4','qat')= 1e2;
fAP('Coal','t4','qat')=fintlprice('coal','t1');

* set adminstered prices - KSA
fAP('methane','t4','ksa')=1.25;
*fAP('arablight','t4','ksa')=6.35;
fAP('arablight','t4','ksa')=7.25;
fAP('u-235','t4','ksa')=101.5;
fAP('ethane','t4','ksa')=0.75;
fAP('arabheavy','t4','ksa')=6;

fAP('diesel','t4','ksa')=fAP('diesel','t1','ksa');
fAP('HFO','t4','ksa')= fAP('HFO','t1','ksa');
fAP('Coal','t4','ksa')=fintlprice('coal','t4')*coalpricegrowth('t4');


* set administered prices - UAE
fAP('methane','t4','uae')=2.00;
fAP('arablight','t4','uae')=fintlprice('arablight','t1');
fAP('u-235','t4','uae')=fintlprice('u-235','t1');
fAP('ethane','t4','uae')=2.00;
fAP('arabheavy','t4','uae')=fintlprice('arablight','t1');
fAP('diesel','t4','uae')=1e2;
fAP('HFO','t4','uae')= 1e2;
fAP('Coal','t4','uae')=fintlprice('coal','t4')*coalpricegrowth('t4');

ELAPf(ELf,ttrun,r,c) = fAP(ELf,ttrun,c);
WAAPf(WAf,ttrun,r,c) = fAP(WAf,ttrun,c);

display ELfMP,WAfMP,ELAPf,WAAPf;

*ELop_trade.fx(ELpd,v,ELl,ELs,ELday,ELf,ttrun,r,c)=0;
*ELfconsump_trade.fx(ELpd,ELf,ttrun,r,c)=0;
*WAFop_trade.fx(WApF,v,WAf,ttrun,r,c)=0;
*WAfconsump_trade.fx(fup,ttrun,rr,cc)$WAf(fup)=0;

solve integratedMCP using MCP;

);


* ===== t>4 ======

if((ord(trun)>4),

fMP(f,c)= no;
*fMP('methane',c)=yes;
*fMP('arablight',c)=yes;
*fMP('diesel',c)=yes;
*fMP('HFO',c)=yes;
*fMP(f,c)= yes;

*fMPt(f,c)= yes;
*fMPt(f,c)= no;

ELWAcoord('ksa')=0;
ELWAcoord('kuw')=1;
ELWAcoord('qat')=1;
ELWAcoord('bah')=1;
ELWAcoord('omn')=1;
ELWAcoord('uae')=1;

ELfMP(ELf,c)$fmp(ELf,c)= yes;
ELfAP(ELf,c)= not fmp(ELf,c);

WAfMP(WAf,c)$fmp(WAf,c)= yes;
WAfAP(WAf,c)= not fmp(WAf,c);

* GCC sets
fMPt(f,c)=  no;
*fMPt('methane',c)= yes;

ELfMPt(ELf,c)$fMPt(ELf,c)= yes;
WAfMPt(WAf,c)$fMPt(WAf,c)= yes;

tradecap=1;

* set administered prices - Bahrain
fAP('methane',trun,'bah')$(ord(trun)>4)=2.75;
fAP('arablight',trun,'bah')$(ord(trun)>4)=fintlprice('arablight','t1');
fAP('u-235',trun,'bah')$(ord(trun)>4)=fintlprice('u-235','t1');
fAP('ethane',trun,'bah')$(ord(trun)>4)=2.00;
fAP('arabheavy',trun,'bah')$(ord(trun)>4)=fintlprice('arablight','t1');
fAP('diesel',trun,'bah')$(ord(trun)>4)=268.48;
fAP('HFO',trun,'bah')$(ord(trun)>4)= 1e2;
fAP('Coal',trun,'bah')$(ord(trun)>4)=fintlprice('coal','t1');

* Kuwait
*fAP('methane',trun,'kuw')$(ord(trun)>4)=fintlprice('methane',trun);
fAP('methane',trun,'kuw')$(ord(trun)>4)=4.20;
fAP('arablight',trun,'kuw')$(ord(trun)>4)=51.20;
fAP('u-235',trun,'kuw')$(ord(trun)>4)=fintlprice('u-235','t1');
fAP('ethane',trun,'kuw')$(ord(trun)>4)=2.00;
fAP('arabheavy',trun,'kuw')$(ord(trun)>4)=fintlprice('arabheavy','t1');
fAP('diesel',trun,'kuw')$(ord(trun)>4)=504.20;
fAP('HFO',trun,'kuw')$(ord(trun)>4)= 370.50;
fAP('Coal',trun,'kuw')$(ord(trun)>4)=fintlprice('coal','t1');

* set administered prices - Oman
fAP('methane',trun,'omn')$(ord(trun)>4)=2.00;
fAP('arablight',trun,'omn')$(ord(trun)>4)=fintlprice('arablight','t1');
fAP('u-235',trun,'omn')$(ord(trun)>4)=fintlprice('u-235','t1');
fAP('ethane',trun,'omn')$(ord(trun)>4)=2.00;
fAP('arabheavy',trun,'omn')$(ord(trun)>4)=fintlprice('arablight','t1');
fAP('diesel',trun,'omn')$(ord(trun)>4)=1e2;
fAP('HFO',trun,'omn')$(ord(trun)>4)= 1e2;
fAP('Coal',trun,'omn')$(ord(trun)>4)=fintlprice('coal','t1');

* set administered prices - Qatar
fAP('methane',trun,'qat')$(ord(trun)>4)=1.50;
fAP('arablight',trun,'qat')$(ord(trun)>4)=fintlprice('arablight','t1');
fAP('u-235',trun,'qat')$(ord(trun)>4)=fintlprice('u-235','t1');
fAP('ethane',trun,'qat')$(ord(trun)>4)=2.00;
fAP('arabheavy',trun,'qat')$(ord(trun)>4)=fintlprice('arablight','t1');
fAP('diesel',trun,'qat')$(ord(trun)>4)=1e2;
fAP('HFO',trun,'qat')$(ord(trun)>4)= 1e2;
fAP('Coal',trun,'qat')$(ord(trun)>4)=fintlprice('coal','t1');

* set adminstered prices - KSA
fAP('methane',trun,'ksa')$(ord(trun)>4)=1.25;
*fAP('arablight',trun,'ksa')$(ord(trun)>4)=6.35;
fAP('arablight',trun,'ksa')$(ord(trun)>4)=7.25;
fAP('u-235',trun,'ksa')$(ord(trun)>4)=101.5;
fAP('ethane',trun,'ksa')$(ord(trun)>4)=0.75;
fAP('arabheavy',trun,'ksa')$(ord(trun)>4)=6;

fAP('diesel',trun,'ksa')$(ord(trun)>4)=fAP('diesel','t1','ksa');
fAP('HFO',trun,'ksa')$(ord(trun)>4)= fAP('HFO','t1','ksa');
fAP('Coal',trun,'ksa')$(ord(trun)>4)=fintlprice('coal','t1')*coalpricegrowth('t4');

* set administered prices - UAE
fAP('methane',trun,'uae')$(ord(trun)>4)=2.00;
fAP('arablight',trun,'uae')$(ord(trun)>4)=fintlprice('arablight','t1');
fAP('u-235',trun,'uae')$(ord(trun)>4)=fintlprice('u-235','t1');
fAP('ethane',trun,'uae')$(ord(trun)>4)=2.00;
fAP('arabheavy',trun,'uae')$(ord(trun)>4)=fintlprice('arablight','t1');
fAP('diesel',trun,'uae')$(ord(trun)>4)=1e2;
fAP('HFO',trun,'uae')$(ord(trun)>4)= 1e2;
fAP('Coal',trun,'uae')$(ord(trun)>4)=fintlprice('coal','t1');


*fAP('Coal',trun,'ksa')$(ord(trun)>3)=fintlprice('coal',trun)*coalpricegrowth(trun);

*WAbld.up('SWRO','new','t4',r,c)=1;

ELAPf(ELf,ttrun,r,c) = fAP(ELf,ttrun,c);
WAAPf(WAf,ttrun,r,c) = fAP(WAf,ttrun,c);

display ELfMP,WAfMP,ELAPf,WAAPf,trun,ttrun,t;

$ontext
* turn this back on!!!
ELbld.fx('CoalSteam',v,ttrun,r,c)$(ord(ttrun)>3)=0;

ELbld.up('Nuclear',vn,ttrun,r,c)$(ord(ttrun)>3)=2.0;
ELbld.fx('Nuclear',vn,ttrun,'cent','ksa')$(ord(ttrun)>3)=0;
ELbld.up('Nuclear',vn,ttrun,'sout','ksa')$(ord(ttrun)>3)=0;
ELbld.fx('Nuclear','new','t14','west','ksa')=2.8;
ELbld.fx('Nuclear','new','t14','east','ksa')=0;

ELrenbld.up(ELpsw,v,ttrun,r,c)$(ord(ttrun)>3)=2;


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
$offtext


*ELop_trade.fx(ELpd,v,ELl,ELs,ELday,ELf,ttrun,r,c)=0;
*ELfconsump_trade.fx(ELpd,ELf,ttrun,r,c)=0;
*WAFop_trade.fx(WApF,v,WAf,ttrun,r,c)=0;
*WAfconsump_trade.fx(fup,ttrun,rr,cc)$WAf(fup)=0;

*$offtext
*ELrenbld.up(ELpsw,v,t,r,c)=5;


if(ord(trun)=5,
        execute_loadpoint "integratedMCP_p5.gdx";
elseif ord(trun)=6,
        execute_loadpoint "integratedMCP_p6.gdx";
elseif ord(trun)=7,
        execute_loadpoint "integratedMCP_p7.gdx";
elseif ord(trun)=8,
        execute_loadpoint "integratedMCP_p8.gdx";

);
$ontext


elseif ord(trun)=9,
        execute_loadpoint "integratedMCP_p9.gdx";
elseif ord(trun)=10,
        execute_loadpoint "integratedMCP_p10.gdx";
elseif ord(trun)=11,
        execute_loadpoint "integratedMCP_p11.gdx";
        
elseif ord(trun)=12,
        execute_loadpoint "integratedMCP_p12.gdx";
elseif ord(trun)=13,
        execute_loadpoint "integratedMCP_p13.gdx";
elseif ord(trun)=14,
        execute_loadpoint "integratedMCP_p14.gdx";
elseif ord(trun)=15,
        execute_loadpoint "integratedMCP_p15.gdx";
elseif ord(trun)=16,
        execute_loadpoint "integratedMCP_p16.gdx";
);
$offtext

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

$INCLUDE src/simple_report.gms
*$INCLUDE src/reports/RW_emissions.gms
$INCLUDE src/costcalcs.gms

* close trun loop
)
;
