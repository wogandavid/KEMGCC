* Unnamed reports used for Qatar calibration

parameters
report6 short run marginal costs - fuel consumption and var om
report7 up-spin fuel consumption
report9 electricity production by technology and load segment for excel tabulation
report10 water production by technology and load segment for excel tabulation
report11 to compute capacity utilization
report12 water demand
report14 EL el production
report15 EL trans
report16 15 - 17
report17 WAELsupply
report18 WAELconsump
report19 exogenous el demand
report20 ELdem equation
report21 WAsup equation
report22 ELsup equation
report23 total water production
report24 excess electricity supply Twh
report25 power generation GW
report26 ELsup.m by load segment
report27 capacity utilization op - available
report28 value of flexibility
report_xls report for excel tabulation
;

* created when checking ELsup.m
report6(w,trun,ELp,v,ELf,r,c)$rc(r,c)  =
  ELfuelburn(ELp,v,ELf,r,c)*Dfdem.l(ELf,trun,r,c)
 +ELomcst(ELp,v,r,c);

report7(trun,ELpd,v,ELl,ELs,ELday,ELf,r,c)$(rc(r,c) and ELfspin(ELf) and Elfuelburn(ELpd,v,ELf,r,c)>0 and ELpspin(ELpd)) =
 ELusrfuelfrac*ELfuelburn(ELpd,v,ELf,r,c)*ELlchours(ELl,c)*
 ELdaysinseason(ELs,ELday)*ELupspincap.l(ELpd,v,ELl,ELs,ELday,ELf,trun,r,c);

report9(trun,ELs,ELday,ELl,r,c,ELpd)$rc(r,c)=
  sum((v,ELf)$(Elfuelburn(ELpd,v,ELf,r,c)>0 and ELpcom(ELpd)),
         ELop.l(ELpd,v,ELl,ELs,ELday,ELf,trun,r,c));

report9(trun,ELs,ELday,ELl,r,c,ELps)$rc(r,c)=
  sum(v,ELsolop.l(ELps,v,ELl,ELs,ELday,trun,r,c));

report9(trun,ELs,ELday,ELl,r,c,WApf)$rc(r,c)=
  sum((v,WAf)$(WAfuelburn(WApf,v,WAf,r,c)>0),
         WAFop.l(WApF,v,WAf,trun,r,c)*(1-WAyield(WApF,v,r,c)*WAelrate(WApF,v))*ELnormhours(ELl,ELs,ELday,c));

report9(trun,ELs,ELday,ELl,r,c,WApV)$rc(r,c)=
  sum((v,WAf,opm)$(WAVfuelburn(WApV,v,WAf,opm,r,c)>0),
         WAVop.l(WApV,v,ELl,ELs,ELday,WAf,opm,trun,r,c)*(1-WAVyield(WApV,v,opm,r,c)*WAelrate(WApV,v)));


*report9(trun,ELs,ELday,ELl,r,c,'waelsupply')$rc(r,c)=
* WAELsupply.l(ELl,ELs,ELday,trun,r,c);

*report9(trun,ELs,ELday,ELl,r,c,'el trans')$rc(r,c)=
* sum((rr,cc)$rc(rr,cc),ELtrans.l(ELl,ELs,ELday,trun,r,c,rr,cc));

*report9(trun,ELs,ELday,ELl,r,c,'watrans')$rc(r,c)=
*  sum((rr,cc)$rc(rr,cc),WAtrans.l(ELl,ELs,ELday,trun,r,c,rr,cc));

report10(trun,ELs,ELday,ELl,r,c,WApF)$rc(r,c)=
  sum((v,WAf)$(WAfuelburn(WApF,v,WAf,r,c)<>0),
         WAFop.l(WApF,v,WAf,trun,r,c)*WAyield(WApF,v,r,c)*ELnormhours(ELl,ELs,ELday,c) )
;
report10(trun,ELs,ELday,ELl,r,c,WApV)$rc(r,c)=
+ sum((v,WAf,opm)$(WAVfuelburn(WApV,v,WAf,opm,r,c)>0),
         WAVop.l(WApV,v,ELl,ELs,ELday,WAf,opm,trun,r,c)*WAVyield(WApV,v,opm,r,c))
;

report11(trun,'new',ELs,ELday,ELl,r,c,ELpd)$rc(r,c)=
  ELcapfactor(ELpd)*ELlchours(ELl,c)*ELdaysinseason(ELs,ELday)*
 (ELexistcp.l(ELpd,'new',trun,r,c)
 +sum(ELpp,
  ELcapadd(ELpp,ELpd)*ELbld.l(ELpp,'new',trun,r,c))
 -sum(ELfspin$(ELpspin(ELpd) and ELfuelburn(ELpd,'new',ELfspin,r,c)>0),
  ELupspincap.l(ELpd,'new',ELl,ELs,ELday,ELfspin,trun,r,c)))
;

report12(trun,c,r,ELs,ELday,ELl)$rc(r,c)=
(WAdemval(trun,r,c)+WAgrdem(trun,r,c))*WAlc(ELl,ELs,ELday,c);

report14(trun,r,c,ELs,ELday,ELl,ELpd)$rc(r,c)=
sum((v,ELf)$(Elfuelburn(ELpd,v,ELf,r,c)>0 and ELpcom(ELpd)),
   ELop.l(ELpd,v,ELl,ELs,ELday,ELf,trun,r,c))
  +sum((ELps,v),ELsolop.l(ELps,v,ELl,ELs,ELday,trun,r,c))
  +sum((ELpw,v),ELwindop.l(ELpw,v,ELl,ELs,ELday,trun,r,c))
*  +WAELsupply.l(ELl,ELs,ELday,trun,r,c)
*  -sum((rr,cc)$rc(rr,cc),ELtrans.l(ELl,ELs,ELday,trun,r,c,rr,cc))
;

report17(trun,r,c,ELs,ELday,ELl)$rc(r,c)=
  WAELsupply.l(ELl,ELs,ELday,trun,r,c)
;

report15(trun,r,c,ELs,ELday,ELl)$rc(r,c)=sum((rr,cc)$rc(rr,cc),ELtrans.l(ELl,ELs,ELday,trun,r,c,rr,cc));

report16(trun,r,c,ELs,ELday,ELl)$rc(r,c)=
  sum(ELpd,report14(trun,r,c,ELs,ELday,ELl,ELpd))
 +report17(trun,r,c,ELs,ELday,ELl)
 -report15(trun,r,c,ELs,ELday,ELl);

report18(trun,r,c,ELs,ELday,ELl)$rc(r,c)=
*  sum((rr,cc)$rc(rr,cc),Eltransyield(r,c,rr,cc)*ELtrans.l(ELl,ELs,ELday,trun,r,c,rr,cc))
  WAELconsump.l(ELl,ELs,ELday,trun,r,c)
* -ELlchours(ELl,c)*ELdaysinseason(ELs,ELday)*ELlcgw(ELl,ELs,ELday,r,c)*ELdemgro(trun,r,c)
;

report19(trun,r,c,ELs,ELday,ELl)$rc(r,c)=
*  sum((rr,cc)$rc(rr,cc),Eltransyield(r,c,rr,cc)*ELtrans.l(ELl,ELs,ELday,trun,r,c,rr,cc))
* -WAELconsump.l(ELl,ELs,ELday,trun,r,c)
  ELlchours(ELl,c)*ELdaysinseason(ELs,ELday)*ELlcgw(ELl,ELs,ELday,r,c)*ELdemgro(trun,r,c)
;

report20(trun,r,c,ELs,ELday,ELl)$rc(r,c)=
*  sum((rr,cc)$rc(rr,cc),Eltransyield(r,c,rr,cc)*ELtrans.l(ELl,ELs,ELday,trun,r,c,rr,cc))
 -WAELconsump.l(ELl,ELs,ELday,trun,r,c)
 -ELlchours(ELl,c)*ELdaysinseason(ELs,ELday)*ELlcgw(ELl,ELs,ELday,r,c)*ELdemgro(trun,r,c)
;

report21(trun,r,c,ELs,ELday,ELl)$rc(r,c)=
  sum((WAp),report10(trun,ELs,ELday,ELl,r,c,WAp))
 -sum((rr,cc)$rc(rr,cc),WAtrans.l(ELl,ELs,ELday,trun,r,c,rr,cc))

* -report9(trun,ELs,ELday,ELl,r,c,'watrans')
;

report22(trun,r,c,ELs,ELday,ELl)$rc(r,c)=
sum((v,ELf,ELpd)$(Elfuelburn(ELpd,v,ELf,r,c)>0 and ELpcom(ELpd)),
   ELop.l(ELpd,v,ELl,ELs,ELday,ELf,trun,r,c))
  +sum((ELps,v),ELsolop.l(ELps,v,ELl,ELs,ELday,trun,r,c))
  +sum((ELpw,v),ELwindop.l(ELpw,v,ELl,ELs,ELday,trun,r,c))
  +WAELsupply.l(ELl,ELs,ELday,trun,r,c)
  -sum((rr,cc)$rc(rr,cc),ELtrans.l(ELl,ELs,ELday,trun,r,c,rr,cc))
;

report23(trun,c,r,ELs,ELday)$rc(r,c)=
  sum((ELl,WAp),report10(trun,ELs,ELday,ELl,r,c,WAp))
* -sum((ELl),report12(trun,c,r,ELs,ELday,ELl));
;

report24(trun,ELs,ELday,ELl,r,c)$rc(r,c)=
  sum(ELpd,report9(trun,ELs,ELday,ELl,r,c,ELpd))
 +sum(ELps,report9(trun,ELs,ELday,ELl,r,c,ELps))
 +sum(WApF,report9(trun,ELs,ELday,ELl,r,c,WApf))
 +sum(WApV,report9(trun,ELs,ELday,ELl,r,c,WApV))
 -report15(trun,r,c,ELs,ELday,ELl)
;

report25(trun,ELs,ELday,ELl,r,c,'thermal')$rc(r,c)=
( sum(ELpd,report9(trun,ELs,ELday,ELl,r,c,ELpd))
)/
 (ELlchours(ELl,c)*ELdaysinseason(ELs,ELday));

report25(trun,ELs,ELday,ELl,r,c,'cogen')$rc(r,c)=
( sum(WApF,report9(trun,ELs,ELday,ELl,r,c,WApf))
 +sum(WApV,report9(trun,ELs,ELday,ELl,r,c,WApV))
)/
 (ELlchours(ELl,c)*ELdaysinseason(ELs,ELday));

report25(trun,ELs,ELday,ELl,r,c,'PV')$rc(r,c)=
  report9(trun,ELs,ELday,ELl,r,c,'PV')/
 (ELlchours(ELl,c)*ELdaysinseason(ELs,ELday));

report26(trun,ELs,ELday,ELl,r,c)$rc(r,c)=
  ELsup.m(ELl,ELs,ELday,trun,r,c);


report27(trun,ELs,ELday,ELl,r,c,ELpd,'ELpd')$rc(r,c)= sum((v,ELf)$(ELop.l(ELpd,v,ELl,ELs,ELday,ELf,trun,r,c)>0),ELcaplim.m(ELpd,v,ELl,ELs,ELday,trun,r,c));
report27(trun,ELs,ELday,ELl,r,c,WApF,'WApF')$rc(r,c)= sum((v,WAf)$(WAFop.l(WApF,v,WAf,trun,r,c)>0),WAfcaplim.m(WApF,v,trun,r,c));
report27(trun,ELs,ELday,ELl,r,c,WApV,'WApV')$rc(r,c)= sum((v,WAf,opm)$(WAVop.l(WApV,v,ELl,ELs,ELday,WAf,opm,trun,r,c)>0),WAVcaplim.m(WApV,v,ELl,ELs,ELday,trun,r,c));

report28(trun)=
* power
  (ELCapitalCost.l(trun)+ELOpandmaint.l(trun))*ELdiscfact(trun)
 +sum((Elpd,ELf,r,c)$rc(r,c),Dfdem.l(ELf,trun,r,c)*ELfconsump.l(ELpd,ELf,trun,r,c)*ELdiscfact(trun))
* water
 +(WAcapitalcost.l(trun)+WAOpandmaint.l(trun))*WAdiscfact(trun)
 +sum((WAf,r,c)$rc(r,c),Dfdem.l(WAf,trun,r,c)*WAfconsump.l(WAf,trun,r,c)*WAdiscfact(trun))
;

report_xls(trun,ELs,ELday,ELl,r,c,'DELsup')$rc(r,c)=report26(trun,ELs,ELday,ELl,r,c);

report_xls(trun,ELs,ELday,ELl,r,c,'GT Twh')$rc(r,c)=report9(trun,ELs,ELday,ELl,r,c,'GT');

report_xls(trun,ELs,ELday,ELl,r,c,'CC TWh')$rc(r,c)=report9(trun,ELs,ELday,ELl,r,c,'CC');

report_xls(trun,ELs,ELday,ELl,r,c,'PV TWh')$rc(r,c)=report9(trun,ELs,ELday,ELl,r,c,'PV');

report_xls(trun,ELs,ELday,ELl,r,c,'GTco TWh')$rc(r,c)=report9(trun,ELs,ELday,ELl,r,c,'GTco');

report_xls(trun,ELs,ELday,ELl,r,c,'CCco TWh')$rc(r,c)=report9(trun,ELs,ELday,ELl,r,c,'CCCoMSF');

report_xls(trun,ELs,ELday,ELl,r,c,'GTcoV TWh')$rc(r,c)=report9(trun,ELs,ELday,ELl,r,c,'GTcoV');

report_xls(trun,ELs,ELday,ELl,r,c,'CCcoV TWh')$rc(r,c)=report9(trun,ELs,ELday,ELl,r,c,'CCcoVMSF');

report_xls(trun,ELs,ELday,ELl,r,c,'WAELsupply')$rc(r,c)=report17(trun,r,c,ELs,ELday,ELl);

report_xls(trun,ELs,ELday,ELl,r,c,'Produced TWh')$rc(r,c)=
  report_xls(trun,ELs,ELday,ELl,r,c,'GT Twh')
 +report_xls(trun,ELs,ELday,ELl,r,c,'CC TWh')
 +report_xls(trun,ELs,ELday,ELl,r,c,'PV TWh')
* +report_xls(trun,ELs,ELday,ELl,r,c,'GTco TWh')
* +report_xls(trun,ELs,ELday,ELl,r,c,'CCco TWh')
 +report_xls(trun,ELs,ELday,ELl,r,c,'GTcoV TWh')
 +report_xls(trun,ELs,ELday,ELl,r,c,'CCcoV TWh')
;

report_xls(trun,ELs,ELday,ELl,r,c,'Supplied TWh')$rc(r,c)=report15(trun,r,c,ELs,ELday,ELl);

report_xls(trun,ELs,ELday,ELl,r,c,'Delivered TWh')$rc(r,c)=
  report15(trun,r,c,ELs,ELday,ELl)*Eltransyield(r,c,r,c);

report_xls(trun,ELs,ELday,ELl,r,c,'WAELconsump TWh')$rc(r,c)=report18(trun,r,c,ELs,ELday,ELl);

report_xls(trun,ELs,ELday,ELl,r,c,'Consumed TWh')$rc(r,c)=report19(trun,r,c,ELs,ELday,ELl);

report_xls(trun,ELs,ELday,ELl,r,c,'Total consump TWh')$rc(r,c)=
  report18(trun,r,c,ELs,ELday,ELl)
 +report19(trun,r,c,ELs,ELday,ELl);

report_xls(trun,ELs,ELday,ELl,r,c,'Excess supply TWh')$rc(r,c)=
  report_xls(trun,ELs,ELday,ELl,r,c,'Produced TWh')
 -report_xls(trun,ELs,ELday,ELl,r,c,'Supplied TWh');

report_xls(trun,ELs,ELday,ELl,r,c,'RO m3')$rc(r,c)=report10(trun,ELs,ELday,ELl,r,c,'BWRO');

report_xls(trun,ELs,ELday,ELl,r,c,'GTco m3')$rc(r,c)=report10(trun,ELs,ELday,ELl,r,c,'GTco');

report_xls(trun,ELs,ELday,ELl,r,c,'CCcoMSF m3')$rc(r,c)=report10(trun,ELs,ELday,ELl,r,c,'CCCoMSF');

report_xls(trun,ELs,ELday,ELl,r,c,'GTcoV m3')$rc(r,c)=report10(trun,ELs,ELday,ELl,r,c,'GTcoV');

report_xls(trun,ELs,ELday,ELl,r,c,'CCcoVMSF m3')$rc(r,c)=report10(trun,ELs,ELday,ELl,r,c,'CCcoVMSF');

report_xls(trun,ELs,ELday,ELl,r,c,'total water')$rc(r,c)=
  sum(WApF,report10(trun,ELs,ELday,ELl,r,c,WApF))
 +sum(WApV,report10(trun,ELs,ELday,ELl,r,c,WApV));

report_xls(trun,ELs,ELday,ELl,r,c,'excess water')$rc(r,c)=
  report_xls(trun,ELs,ELday,ELl,r,c,'total water')
 -report12(trun,c,r,ELs,ELday,ELl);

* for checking ELsup.m
option report6:2:0:1;
option report7:2:0:1;
option report9:5:5:1;
option report10:5:5:1;
option report11:5:6:1;
option report12:6:0:1;
option report14:5:6:1;
option report15:5:0:1;
option report16:5:0:1;
option report17:5:0:1;
option report18:5:0:1;
option report19:5:0:1;
option report20:5:0:1;
option report21:5:0:1;
option report22:5:0:1;
option report23:8:0:1;
option report24:8:0:1;
option report25:8:6:1;
option report26:8:0:1;
option report27:2:7:1;
option report28:5:0:1;
option report_xls:8:6:1;

display
report6
report7
report9
report10
report11
report12
report14
report15
report16
report17
report18
report19
report20
report21
report22
report23
report24
report25
report26
report27
report28
report_xls
;