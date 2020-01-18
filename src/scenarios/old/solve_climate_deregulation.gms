* solve climate scnenarios
* REFERENCE

* multi-period

* multi-period

option limcol=0;
option limrow=0;
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
ELbld.up('CoalSteam',v,ttrun,r,c)=0;
ELop.fx('CoalSteam',v,ELl,ELs,ELday,'coal',trun,r,c)=0;


* ======== t01 =========
if(ord(trun)=1,
execute_loadpoint "data\integratedMCP_p1.gdx";

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

ELAPf(ELf,ttrun,r,c) = fAP(ELf,ttrun,c);
WAAPf(WAf,ttrun,r,c) = fAP(WAf,ttrun,c);

ELop_trade.fx(ELpd,v,ELl,ELs,ELday,ELf,ttrun,r,c)=0;
ELfconsump_trade.fx(ELpd,ELf,ttrun,r,c)=0;
WAFop_trade.fx(WApF,v,WAf,ttrun,r,c)=0;
WAfconsump_trade.fx(fup,ttrun,rr,cc)$WAf(fup)=0;

solve integratedMCP using MCP;
);


* ======== t02 =========
if(ord(trun)=2,

execute_loadpoint "data\integratedMCP_p2.gdx";

fMP(f,c)= no;
*fMP('methane',c)= yes;
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

fAP('diesel','t02','ksa')=fAP('diesel','t01','ksa');
fAP('HFO','t02','ksa')= fAP('HFO','t01','ksa');
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



ELAPf(ELf,ttrun,r,c) = fAP(ELf,ttrun,c);
WAAPf(WAf,ttrun,r,c) = fAP(WAf,ttrun,c);


ELop_trade.fx(ELpd,v,ELl,ELs,ELday,ELf,ttrun,r,c)=0;
ELfconsump_trade.fx(ELpd,ELf,ttrun,r,c)=0;
WAFop_trade.fx(WApF,v,WAf,ttrun,r,c)=0;
WAfconsump_trade.fx(fup,ttrun,rr,cc)$WAf(fup)=0;

display ELfAP,ELAPf;

solve integratedMCP using MCP;

);

* ===== t03 ======

if((ord(trun)=3),

execute_loadpoint "data\integratedMCP_p3.gdx";

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

fAP('diesel','t03','ksa')=fAP('diesel','t01','ksa');
fAP('HFO','t03','ksa')= fAP('HFO','t01','ksa');
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


* ===== t04 ======

if((ord(trun)=4),

execute_loadpoint "data\integratedMCP_p4.gdx";

*WAbld.up('SWRO','new','t04',r,c)=1;

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
fAP('methane','t04','bah')=2.75;
fAP('arablight','t04','bah')=fintlprice('arablight','t01');
fAP('u-235','t04','bah')=fintlprice('u-235','t01');
fAP('ethane','t04','bah')=2.00;
fAP('arabheavy','t04','bah')=fintlprice('arablight','t01');
fAP('diesel','t04','bah')=268.48;
fAP('HFO','t04','bah')= 1e2;
fAP('Coal','t04','bah')=fintlprice('coal','t01');

* Kuwait
*fAP('methane','t04','kuw')=fintlprice('methane','t04');
fAP('methane','t04','kuw')=3.53;
fAP('arablight','t04','kuw')=42.10;
fAP('u-235','t04','kuw')=fintlprice('u-235','t01');
fAP('ethane','t04','kuw')=2.00;
fAP('arabheavy','t04','kuw')=fintlprice('arabheavy','t01');
fAP('diesel','t04','kuw')=470.46;
fAP('HFO','t04','kuw')= 297.91;
fAP('Coal','t04','kuw')=fintlprice('coal','t01');

* set administered prices - Oman
fAP('methane','t04','omn')=2.00;
fAP('arablight','t04','omn')=fintlprice('arablight','t01');
fAP('u-235','t04','omn')=fintlprice('u-235','t01');
fAP('ethane','t04','omn')=2.00;
fAP('arabheavy','t04','omn')=fintlprice('arablight','t01');
fAP('diesel','t04','omn')=1e2;
fAP('HFO','t04','omn')= 1e2;
fAP('Coal','t04','omn')=fintlprice('coal','t01');

* set administered prices - Qatar
fAP('methane','t04','qat')=1.50;
fAP('arablight','t04','qat')=fintlprice('arablight','t01');
fAP('u-235','t04','qat')=fintlprice('u-235','t01');
fAP('ethane','t04','qat')=2.00;
fAP('arabheavy','t04','qat')=fintlprice('arablight','t01');
fAP('diesel','t04','qat')=1e2;
fAP('HFO','t04','qat')= 1e2;
fAP('Coal','t04','qat')=fintlprice('coal','t01');

* set adminstered prices - KSA
fAP('methane','t04','ksa')=1.25;
*fAP('arablight','t04','ksa')=6.35;
fAP('arablight','t04','ksa')=7.25;
fAP('u-235','t04','ksa')=101.5;
fAP('ethane','t04','ksa')=0.75;
fAP('arabheavy','t04','ksa')=6;

fAP('diesel','t04','ksa')=fAP('diesel','t01','ksa');
fAP('HFO','t04','ksa')= fAP('HFO','t01','ksa');
fAP('Coal','t04','ksa')=fintlprice('coal','t04')*coalpricegrowth('t04');


* set administered prices - UAE
fAP('methane','t04','uae')=2.00;
fAP('arablight','t04','uae')=fintlprice('arablight','t01');
fAP('u-235','t04','uae')=fintlprice('u-235','t01');
fAP('ethane','t04','uae')=2.00;
fAP('arabheavy','t04','uae')=fintlprice('arablight','t01');
fAP('diesel','t04','uae')=1e2;
fAP('HFO','t04','uae')= 1e2;
fAP('Coal','t04','uae')=fintlprice('coal','t04')*coalpricegrowth('t04');

ELAPf(ELf,ttrun,r,c) = fAP(ELf,ttrun,c);
WAAPf(WAf,ttrun,r,c) = fAP(WAf,ttrun,c);

display ELfMP,WAfMP,ELAPf,WAAPf;

ELop_trade.fx(ELpd,v,ELl,ELs,ELday,ELf,ttrun,r,c)=0;
ELfconsump_trade.fx(ELpd,ELf,ttrun,r,c)=0;
WAFop_trade.fx(WApF,v,WAf,ttrun,r,c)=0;
WAfconsump_trade.fx(fup,ttrun,rr,cc)$WAf(fup)=0;

solve integratedMCP using MCP;

);
* ===== t>4 ======

if((ord(trun)>4),

fMP('methane',c)=yes;
fMP('arablight',c)=yes;
fMP('diesel',c)=yes;
fMP('HFO',c)=yes;

ELWAcoord(c)=0;
tradecap=1;


*fAP('Coal',trun,'ksa')$(ord(trun)>3)=fintlprice('coal',trun)*coalpricegrowth(trun);

*WAbld.up('SWRO','new','t04',r,c)=1;

*$ontext
ELfMP(ELf,c)$fmp(ELf,c)= yes;
ELfAP(ELf,c)= not fmp(ELf,c);

WAfMP(WAf,c)$fmp(WAf,c)= yes;
WAfAP(WAf,c)= not fmp(WAf,c);
*$offtext

ELAPf(ELf,ttrun,r,c) = fAP(ELf,ttrun,c);
WAAPf(WAf,ttrun,r,c) = fAP(WAf,ttrun,c);

display ELfMP,WAfMP,ELAPf,WAAPf,trun,ttrun,t;
*$ontext
* turn this back on!!!
ELbld.fx('CoalSteam',v,ttrun,r,c)$(ord(ttrun)>3)=0;

ELbld.up('Nuclear',vn,ttrun,r,c)$(ord(ttrun)>3)=2.0;
ELbld.fx('Nuclear',vn,ttrun,'cent','ksa')$(ord(ttrun)>3)=0;
ELbld.up('Nuclear',vn,ttrun,'sout','ksa')$(ord(ttrun)>3)=0;
ELbld.fx('Nuclear','new','t14','west','ksa')=2.8;
ELbld.fx('Nuclear','new','t14','east','ksa')=0;

ELrenbld.up(ELpsw,v,ttrun,r,c)$(ord(ttrun)>3)=2;


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



ELop_trade.fx(ELpd,v,ELl,ELs,ELday,ELf,ttrun,r,c)=0;
ELfconsump_trade.fx(ELpd,ELf,ttrun,r,c)=0;
WAFop_trade.fx(WApF,v,WAf,ttrun,r,c)=0;
WAfconsump_trade.fx(fup,ttrun,rr,cc)$WAf(fup)=0;
*$offtext
*ELrenbld.up(ELpsw,v,t,r,c)=5;

$ontext
if(ord(trun)=4,
        execute_loadpoint "integratedMCP_p4.gdx";
elseif ord(trun)=1+4,
        execute_loadpoint "integratedMCP_p5.gdx";
elseif ord(trun)=1+5,
        execute_loadpoint "integratedMCP_p6.gdx";
elseif ord(trun)=1+6,
        execute_loadpoint "integratedMCP_p7.gdx";
elseif ord(trun)=1+7,
        execute_loadpoint "integratedMCP_p8.gdx";
elseif ord(trun)=1+8,
        execute_loadpoint "integratedMCP_p9.gdx";
elseif ord(trun)=1+9,
        execute_loadpoint "integratedMCP_p10.gdx";
elseif ord(trun)=11,
        execute_loadpoint "integratedMCP_p10.gdx";
elseif ord(trun)=12,
        execute_loadpoint "integratedMCP_p10.gdx";
elseif ord(trun)=13,
        execute_loadpoint "integratedMCP_p10.gdx";
elseif ord(trun)=14,
        execute_loadpoint "integratedMCP_p10.gdx";
elseif ord(trun)=15,
        execute_loadpoint "integratedMCP_p10.gdx";
elseif ord(trun)=16,
        execute_loadpoint "integratedMCP_p10.gdx";
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

$INCLUDE code/reports/simple_report.gms
*$INCLUDE code/reports/RW_emissions.gms
$INCLUDE code/reports/costcalcs.gms

* close trun loop
)
;
