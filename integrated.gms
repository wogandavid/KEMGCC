$ontext
===================
Welcome to KEM-GCC

Included sectors:
 Upstream
 Power
 Water

 Developed by David Wogan, Frederic Murphy, and Axel Pierru
 It is a forked model from the KAPSARC Energy Model available at:

 https://www.kapsarc.org/openkapsarc/the-kapsarc-energy-model-for-saudi-arabia/

This model was used to generate results for "The costs and gains of
policy options for coordinating electricity production
in the Gulf Cooperation Council" in Energy Policy.

===================
$offtext

$INCLUDE Macros.gms
$INCLUDE Sets.gms
$INCLUDE Variables.gms
$INCLUDE common.gms

*==================
* configure run

call(c)=no;
call('ksa')=yes;
call('uae')=no;
call('kuw')=no;
call('qat')=no;
call('bah')=no;
call('omn')=no;

call(c)=yes;
rc(r,c)$(not call(c))=no;

display call;
display rc;

scalars
savedrun load saved run: 1 /0/
tradecap cap electricity to GCC grid - 1 = yes cap /1/
rentrade include renewables in tradeable electricity quota /0/

TRdereg set to 1 for marginal price electricity trade  /0/
t_start build planning starts in t= /4/
partialdereg set to 1 for partial fuel deregulation /0/
dereg_time period for gradual deregulation /12/
dereg_factor fraction of dereg price /1/
writetoexcel set to 1 to produce Excel workbook of results /0/
;

*option savepoint=2;
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


$INCLUDE sector_fuel.gms
$INCLUDE sector_power.gms
$INCLUDE sector_water.gms
$INCLUDE module_transmission.gms
$INCLUDE module_trade.gms
$INCLUDE module_emissions.gms

$INCLUDE discounting.gms
$INCLUDE report_parameters

parameter fconsumpmax_save for allocating methane;
fconsumpmax_save('EL',ELf,time,r,c)$rc(r,c)=ELfconsumpmax(ELf,time,r,c);
fconsumpmax_save('WA',WAf,time,r,c)$rc(r,c)=WAfconsumpmax(WAf,time,r,c);

*To revert to a long-term static model:
*$ontext
If(card(trun)=1,
ELleadtime(ELp)=0;
WAleadtime(WAp)=0;
TRleadtime(r,c,rr,cc)=0;

fdiscfact(time)=1;
ELdiscfact(time)=1;
WAdiscfact(time)=1;
TRdiscfact(time)=1;
  );
*$offtext

$INCLUDE create_models.gms

$ontext
parameter gridreport;
set g /g1*g11/;


loop(g,
*Fuelcst('methane','ss1','ksa')=3.5+(2.0*ord(g));
$offtext

*$INCLUDE foresight.gms
$INCLUDE solve_singleperiod.gms

parameter methane_add(time);
* to run multi-period include these two:
*$INCLUDE projections.gms
*$INCLUDE solve_multi.gms

$INCLUDE report_excel.gms

$ontext
gridreport(g,'fAP - AL')=fAP('arablight','t1','ksa');
gridreport(g,'fAP - AL in MMBTU')=fAP('arablight','t1','ksa')/5.43;
gridreport(g,'fAP - HFO')=fAP('HFO','t1','ksa')/39.4;
gridreport(g,'fAP - diesel')=fAP('diesel','t1','ksa')/41.1;
gridreport(g,'dfdem')=dfdem.l('methane','t1','east','ksa');
gridreport(g,'transmission')= sum(cc,RWELtrade_tot('t1','ksa',cc))-sum(c,RWELtrade_tot('t1',c,'ksa'));
gridreport(g,'methane consump adm - KSA')=ELWAfcon_xls('ksa','t1','methane');
gridreport(g,'methane consump der - KSA')=ELWAfcon_trade('ksa','t1','methane');
gridreport(g,'crude consump - KSA')=ELWAfcon_tot('t1','ksa','arablight');
gridreport(g,'HFO consump - KSA')=ELWAfcon_tot('t1','ksa','HFO');
gridreport(g,'diesel consump - KSA')=ELWAfcon_tot('t1','ksa','diesel');
gridreport(g,'CC bld')=ELWAbld_xls('ksa','t1','CC');
gridreport(g,'PV bld KSA')=ELWAbld_xls('ksa','t1','PV');
gridreport(g,'PV bld UAE')=ELWAbld_xls('uae','t1','PV');
gridreport(g,'PV bld QAT')=ELWAbld_xls('qat','t1','PV');
gridreport(g,'PV bld KUW')=ELWAbld_xls('kuw','t1','PV');
gridreport(g,'CSP bld QAT')=ELWAbld_xls('qat','t1','CSP');
gridreport(g,'CSP bld BAH')=ELWAbld_xls('bah','t1','CSP');
gridreport(g,'PV TWh')=ELWAsupELp_xls('t1','ksa','PV');
*gridreport(g,'methane import')=fimports.l('t1','methane','kuwr','kuw');
*gridreport(g,'Kuwait HFO consumption')=ELWAfcon_xls('kuw','t1','HFO');
*gridreport(g,'Kuwait methane consumption')=ELWAfcon_xls('kuw','t1','methane');
gridreport(g,'KSA AL export')=fexports.l('arablight','t1','east','ksa')/5.43;
);


execute_unload 'grid.gdx'
gridreport
;
display gridreport;
execute 'gdxxrw.exe grid.gdx o=grid.xlsx par=gridreport rng=sheet1!A1:Z9999';
$offtext
