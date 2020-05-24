$ontext
===================
Welcome to KEM-GCC

Included sectors:
 Upstream
 Power
 Water
===================
$offtext
$inlinecom {{ }}

$INCLUDE src/Macros.gms
$INCLUDE src/Sets.gms
$INCLUDE src/Variables.gms
$INCLUDE src/common.gms

*==================
* configure run

call(c)=no;
call('ksa')=yes;
call('uae')=yes;
call('kuw')=yes;
call('qat')=yes;
call('bah')=yes;
call('omn')=yes;

*call(c)=yes;
rc(r,c)$(not call(c))=no;

display call;
display rc;

* name the scenario
$setglobal scenario A

scalars
savedrun load saved run: 1 /0/
tradecap cap electricity to GCC grid - 1 = yes cap /0/
rentrade include renewables in tradeable electricity quota /0/

TRdereg set to 1 for marginal price electricity trade  /1/
t_start build planning starts in t= /5/
partialdereg set to 1 for partial fuel deregulation /0/
dereg_time period for gradual deregulation /12/
dereg_factor fraction of dereg price /1/
writetoexcel set to 1 to produce Excel workbook of results /0/
lts long-term static set to 1 to enable /0/
;

option savepoint=2;
*==================
parameter ELWAcoord(c) water sector see deregulated price;
parameter t_ind(trun) index of absolute time;
parameter f_ratio ratio of international crude or refined products price with respect to Arab Light;
parameter fcr(f,trun,c) administered price credit applied to fuel quota;
parameter fcr_red(f,trun,c),savefAP(f,trun,c);
parameter fAP(f,trun,c) administered prices;
parameter capsub(ELp,trun);
parameter EMfactors(ksec,f,EMcp) emissions factors;
parameter EMprice(ksec,EMcp,trun,c) emissions price;

parameter TRdiscfact(time);

display r;

$INCLUDE src/fuel.gms
$INCLUDE src/power.gms
$INCLUDE src/water.gms
$INCLUDE src/transmission.gms
$INCLUDE src/trade.gms
$INCLUDE src/emissions.gms

$INCLUDE src/discounting.gms
$INCLUDE src/report_parameters

parameter fconsumpmax_save for allocating methane;
fconsumpmax_save('EL',ELf,time,r,c)$rc(r,c)=ELfconsumpmax(ELf,time,r,c);
fconsumpmax_save('WA',WAf,time,r,c)$rc(r,c)=WAfconsumpmax(WAf,time,r,c);

*To revert to a long-term static model:
if(lts=1,
    If(card(trun)=1,
    ELleadtime(ELp)=0;
    WAleadtime(WAp)=0;
    TRleadtime(r,c,rr,cc)=0;

    fdiscfact(time)=1;
    ELdiscfact(time)=1;
    WAdiscfact(time)=1;
    TRdiscfact(time)=1;
    );
);

$INCLUDE src/create_models.gms

option
LP=cbc
MCP=path
limrow=0
limcol=0
solveopt = merge
profile=0
;


*$INCLUDE foresight.gms
*$INCLUDE src/scenarios/solve_singleperiod.gms

parameter methane_add(time);

* == multi-period scenarios
$INCLUDE src/projections.gms
$INCLUDE src/scenarios/solve_GCC_multiperiod_A.gms
*$INCLUDE src/scenarios/solve_GCC_multiperiod_B.gms
*$INCLUDE src/scenarios/solve_GCC_multiperiod_C.gms
*$INCLUDE src/scenarios/solve_GCC_multiperiod_D.gms
*$INCLUDE src/scenarios/solve_GCC_multiperiod_E.gms
*$INCLUDE src/scenarios/solve_GCC_multiperiod_F.gms
*$INCLUDE src/scenarios/solve_GCC_multiperiod_G.gms
*$INCLUDE src/scenarios/solve_GCC_multiperiod_H.gms

$INCLUDE src/report_excel.gms
* write to CSV:
*$INCLUDE src/summary.gms

