* trade equations

$ontext
variable
ELfconsump_trade(ELpd,ELf,t,r,c) fuel consumed at marginal price for trade
ELop_trade(ELpd,v,ELl,ELs,ELday,ELf,t,r,c)  electricity produced for trade

DELfcons_trade(ELpd,ELf,t,r,c)  dual variable for fuel consumption balance
;
$offtext


Equation
ELfcons_trade(ELpd,ELf,time,r,c) fuel consumption balance for trade activities
ELtradebal(time,ELl,ELs,ELday,c)  enforces max

DELfconsump_trade(ELpd,ELf,time,r,c) pricing rule for fuel consumption
DELop_trade(ELpd,v,ELl,ELs,ELday,ELf,time,r,c) dual equation for electricity for trade activity

DELtrademax(time,ELl,ELs,ELday,c) dual of upper bound on electricity sent to GCC grid
;


ELfcons_trade(ELpd,ELf,t,r,c)$(rc(r,c) and fMPt(ELf,c))..
  ELfconsump_trade(ELpd,ELf,t,r,c)$fMPt(ELf,c)
   -sum((v,ELl,ELs,ELday)$(fMPt(ELf,c) and Elfuelburn(ELpd,v,ELf,r,c)>0 and ELpcom(ELpd)),
    ELfuelburn(ELpd,v,ELf,r,c)*ELop_trade(ELpd,v,ELl,ELs,ELday,ELf,t,r,c))
=g=0;

ELtradebal(t,ELl,ELs,ELday,c)$(call(c))..
* from power sector
  sum((ELpd,v,ELf,r)$(fMPt(ELf,c) and Elfuelburn(ELpd,v,ELf,r,c)>0 and ELpcom(ELpd)),
    ELop_trade(ELpd,v,ELl,ELs,ELday,ELf,t,r,c))

* renewables
 +sum((ELps,v,r)$(rc(r,c) and (rentrade=1)),ELsolop(ELps,v,ELl,ELs,ELday,t,r,c))
 +sum((ELpw,v,r)$(rc(r,c) and (rentrade=1)),ELwindop(ELpw,v,ELl,ELs,ELday,t,r,c))

* from water sector
 +sum((WApF,v,WAf,r)$(fMPt(WAf,c) and WAfuelburn(WApF,v,WAf,r,c)>0 and rc(r,c)),
         WAFop_trade(WApF,v,WAf,t,r,c)*(1-WAyield(WApF,v,r,c)*WAelrate(WApF,v))*ELnormhours(ELl,ELs,ELday,c))
+ sum((WApV,v,WAf,opm,r)$(fMPt(WAf,c) and WAVfuelburn(WApV,v,WAf,opm,r,c)>0 and rc(r,c)),
         WAVop_trade(WApV,v,ELl,ELs,ELday,WAf,opm,t,r,c)*(1-WAVyield(WApV,v,opm,r,c)*WAelrate(WApV,v)))

-ELtrademax(t,ELl,ELs,ELday,c)$call(c)
=e=0
;


DELop_trade(ELpd,v,ELl,ELs,ELday,ELf,t,r,c)$(fMPt(ELf,c) and rc(r,c) and Elfuelburn(ELpd,v,ELf,r,c)>0 and ELpcom(ELpd))..
0=g=
  DELtradebal(t,ELl,ELs,ELday,c)$(call(c))
 -DELfcons_trade(ELpd,ELf,t,r,c)*ELfuelburn(ELpd,v,ELf,r,c)$(Elfuelburn(ELpd,v,ELf,r,c)>0 and ELpcom(ELpd) and fMPt(ELf,c))
 +DELopmaintbal(t)*ELomcst(ELpd,v,r,c)
 +DELsup(ELl,ELs,ELday,t,r,c)
 -DELcaplim(ELpd,v,ELl,ELs,ELday,t,r,c)
  -sum((ksec,EMcp)$ELsect(ksec),EMfactors(ksec,ELf,EMcp)*DEMquantbal(ksec,EMcp,t,c))

;

DELtrademax(t,ELl,ELs,ELday,c)$call(c)..
0=g=
-DELtradebal(t,ELl,ELs,ELday,c)$call(c)
+DTRtradecap(ELl,ELs,ELday,t,c)$(call(c) and tradecap=1)
;

DELfconsump_trade(ELpd,ELf,t,r,c)$(fMPt(ELf,c) and rc(r,c))..
0=g=
  DELfcons_trade(ELpd,ELf,t,r,c)$fMPt(ELf,c)
 -Dfdem(ELf,t,r,c)$(ELfup(ELf) and fMPt(ELf,c))*ELdiscfact(t)
 -RFintlprice(ELf,t)$ELfref(ELf)
* -DELfavail(ELf,t,r,c)$(rc(r,c) and (ElfAP(Elf,c) or ELfref(ELf)))
;


equations
WAfcons_trade(WAf,time,r,c) fuel consumption balance for trade activities


DWAfconsump_trade(WAf,time,r,c)  pricing rule for fuel consumption
DWAFop_trade(WApF,v,WAf,time,r,c) dual equation for electricity for trade activity
DWAVop_trade(WApV,v,ELl,ELs,ELday,WAf,opm,time,r,c) dual equation for electricity for trade activity
;

WAfcons_trade(WAf,t,r,c)$(fMPt(WAf,c) and rc(r,c))..
  WAfconsump_trade(WAf,t,r,c)
- sum((WApF,v)$(fMPt(WAf,c) and WAfuelburn(WApF,v,WAf,r,c)>0),
         WAfuelburn(WApF,v,WAf,r,c)*WAFop_trade(WApF,v,WAf,t,r,c))
- sum((WApV,v,ELl,ELs,ELday,opm)$(fMPt(WAf,c) and WAVfuelburn(WApV,v,WAf,opm,r,c)>0),
         WAVfuelburn(WApV,v,WAf,opm,r,c)*WAVop_trade(WApV,v,ELl,ELs,ELday,WAf,opm,t,r,c))
  =g=0
;

DWAFop_trade(WApF,v,WAf,t,r,c)$(fMPt(WAf,c) and rc(r,c) and WAfuelburn(WApF,v,WAf,r,c)<>0)..
0=g=
  DWAopmaintbal(t)*(WAELomcst(WApF,r,c)+WAomcst(WApF,r,c)*WAyield(WApF,v,r,c))
- DWAFcaplim(WApF,v,t,r,c)
+ DWAhybratio(t,r,c)*WAyield(WApF,v,r,c)$(rsea(r,c) and WApFco(WApF))
- hybratio*DWAhybratio(t,r,c)$(SWROhyb(WApF) and rsea(r,c))
+ sum((Ell,ELs,ELday),DWAsup(ELl,ELs,ELday,t,r,c)*WAyield(WApF,v,r,c)*ELnormhours(ELl,ELs,ELday,c))
+ sum((ELl,ELs,ELday)$(WAfuelburn(WApF,v,WAf,r,c)>0),DWAELsup(ELl,ELs,ELday,t,r,c)*(1-WAyield(WApF,v,r,c)
                         *WAelrate(WApF,v))*ELnormhours(ELl,ELs,ELday,c))
- DWAfcons_trade(WAf,t,r,c)*WAfuelburn(WApF,v,WAf,r,c)$(fMPt(WAf,c) and WAfuelburn(WApF,v,WAf,r,c)>0)

- sum((ELl,ELs,ELday)$(WAfuelburn(WApF,v,WAf,r,c)<>0 and WApsat(WApF)),
         DWAELcons(ELl,ELs,ELday,t,r,c)*WAelrate(WApF,v)*ELnormhours(ELl,ELs,ELday,c))

+sum((ELl,ELs,ELday)$(WAfuelburn(WApF,v,WAf,r,c)>0 and rc(r,c) and call(c)),
 DELtradebal(t,ELl,ELs,ELday,c)*(1-WAyield(WApF,v,r,c)*WAelrate(WApF,v))*ELnormhours(ELl,ELs,ELday,c))
;

DWAVop_trade(WApV,v,ELl,ELs,ELday,WAf,opm,t,r,c)$(fMPt(WAf,c) and rc(r,c) and WAVfuelburn(WApV,v,WAf,opm,r,c)>0)..
0=g=
  DWAopmaintbal(t)*(WAELomcst(WApV,r,c)+WAomcst(WApV,r,c)*WAVyield(WApV,v,opm,r,c))
- DWAVcaplim(WApV,v,ELl,ELs,ELday,t,r,c)/WAVpwrincr(WApV,v,opm)
+ DWAhybratio(t,r,c)*WAVyield(WApV,v,opm,r,c)
*$(WAVfuelburn(WApV,v,WAf,opm,r,c)>0)
+ DWAsup(ELl,ELs,ELday,t,r,c)*WAVyield(WApV,v,opm,r,c)
+ DWAELsup(ELl,ELs,ELday,t,r,c)*(1-WAVyield(WApV,v,opm,r,c)*WAelrate(WApV,v))
- DWAfcons_trade(WAf,t,r,c)*WAVfuelburn(WApV,v,WAf,opm,r,c)$(fMPt(WAf,c) and WAVfuelburn(WApV,v,WAf,opm,r,c)>0)

* not summed:
+ DELtradebal(t,ELl,ELs,ELday,c)*(1-WAVyield(WApV,v,opm,r,c)*WAelrate(WApV,v))$(WAVfuelburn(WApV,v,WAf,opm,r,c)>0 and rc(r,c) and call(c))
;


DWAfconsump_trade(WAf,t,r,c)$(fMPt(WAf,c) and rc(r,c))..
0=g=
  DWAfcons_trade(WAf,t,r,c)$fMPt(WAf,c)
 -Dfdem(WAf,t,r,c)$WAfup(WAf)*WAdiscfact(t)
 -RFintlprice(WAf,t)$WAfref(WAf)
 -sum((ksec,EMcp)$WAsect(ksec),EMfactors(ksec,WAf,EMcp)*DEMquantbal(ksec,EMcp,t,c))
*-DWAfavail(WAf,t,r,c)$(rc(r,c) and (WAfAP(WAf,c) or WAfref(WAf)))
;
