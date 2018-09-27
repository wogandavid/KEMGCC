* simple reports
* ==============

* technology builds
ELWAbld_reg(trun,ELpd,c,'EL')=0;
ELWAbld_reg(trun,WApCO,c,'WA')=0;

ELWAbld_reg(trun,ELpd,c,'EL')= sum((v,r), ELbld.l(ELpd,v,trun,r,c)$rc(r,c) );
ELWAbld_reg(trun,ELpsw,c,'EL')= sum((v,r), ELrenbld.l(ELpsw,v,trun,r,c)$rc(r,c) );
ELWAbld_reg(trun,WApCO,c,'WA')= sum((v,r), WAbld.l(WApCO,v,trun,r,c)$rc(r,c) );

ELWAbld_xls(c,trun,ELp)=ELWAbld_reg(trun,ELp,c,'EL');
ELWAbld_xls(c,trun,WApCo)=ELWAbld_reg(trun,WApCO,c,'WA');

* electricity production from power (total)
ELWAsupELp(trun,r,c)$rc(r,c)=0;
ELWAsupELp(trun,r,c)$rc(r,c)=
  sum((ELpd,v,ELf,ELl,ELs,ELday),ELop.l(ELpd,v,ELl,ELs,ELday,ELf,trun,r,c))
 +sum((ELpd,v,ELf,ELl,ELs,ELday),ELop_trade.l(ELpd,v,ELl,ELs,ELday,ELf,trun,r,c))
 +sum((ELps,v,ELl,ELs,ELday),ELsolop.l(ELps,v,ELl,ELs,ELday,trun,r,c))
 +sum((ELpw,v,ELl,ELs,ELday),ELwindop.l(ELpw,v,ELl,ELs,ELday,trun,r,c))
* -sum((Ell,ELs,ELday),WAELconsump.l(ELl,ELs,ELday,trun,r,c))
;

* electricity production from water (total)
ELWAsupWAp(trun,r,c)=0;
ELWAsupWAp(trun,r,c)$rc(r,c)= sum((ELl,ELs,ELday),WAELsupply.l(ELl,ELs,ELday,trun,r,c));

* electricity consumption by water sector (total)
ELWAconsumpWAp(trun,r,c)=0;
ELWAconsumpWAp(trun,r,c)$rc(r,c)= sum((ELl,ELs,ELday), WAELconsump.l(ELl,ELs,ELday,trun,r,c));

* total electricity supplied to grid (net of WA consumption)
ELWAsup_tot(trun,c)=0;
ELWAsup_tot(trun,c)=
  sum(r$rc(r,c),ELWAsupELp(trun,r,c)
 +ELWAsupWAp(trun,r,c)
 -ELWAconsumpWAp(trun,r,c)
     )
;
* electricity trade (total)
RWELtrade_tot(trun,c,cc)=0;
RWELtrade_tot(trun,c,cc)$(not sameas(c,cc))=
  sum((r,rr,Ell,ELs,ELday),TRnodaltrans.l(ELl,ELs,ELday,trun,r,c,rr,cc)$(    (rc(r,c) and rc(rr,cc) )
                                           and (not sameas(c,cc))
                                           )
    )
;

RWELtrans_tot(trun,r,c,rr,cc)$(rc(r,c) and rc(rr,cc))=
  sum((Ell,ELs,ELday),TRnodaltrans.l(ELl,ELs,ELday,trun,r,c,rr,cc)
    )
;


* total electricity supplied to rr
RWELtrade_demanded(trun,cc)=0;
RWELtrade_demanded(trun,cc)=
  sum((rr,ELl,ELs,ELday)$rc(rr,cc),ELsupply.l(ELl,ELs,ELday,trun,rr,cc))
 +sum((r,rr,c,ELl,ELs,ELday)$(rc(r,c) and rc(rr,cc) ),
          TRnodaltrans.l(ELl,ELs,ELday,trun,r,c,rr,cc)
         -TRnodaltrans.l(ELl,ELs,ELday,trun,rr,cc,r,c)
      )
;
* load curve demand
RWELdemand(trun,cc,rr)=0;
RWELdemand(trun,cc,rr)$rc(rr,cc)= sum((ELl,ELs,ELday),ELlchours(ELl,cc)*ELdaysinseason(ELs,ELday)*ELlcgw(ELl,ELs,ELday,rr,cc)*ELdemgro(trun,rr,cc))
;

* electricity production by technology
ELWAsupELp_ELp(trun,ELpd,c,'EL')=0;
ELWAsupELp_ELp(trun,ELpd,c,'WA')=0;

ELWAsupELp_ELp(trun,ELpd,c,'EL')=
  sum((v,r,ELl,ELs,ELday,ELf)$(Elfuelburn(ELpd,v,ELf,r,c)>0 and ELpcom(ELpd)),ELop.l(ELpd,v,ELl,ELs,ELday,ELf,trun,r,c))
 +sum((v,r,ELl,ELs,ELday,ELf)$(Elfuelburn(ELpd,v,ELf,r,c)>0 and ELpcom(ELpd)),ELop_trade.l(ELpd,v,ELl,ELs,ELday,ELf,trun,r,c))
;
ELWAsupELp_ELp(trun,ELps,c,'EL')=
  sum((v,r,ELl,ELs,ELday),ELsolop.l(ELps,v,ELl,ELs,ELday,trun,r,c))
;

ELWAsupELp_ELp(trun,ELpw,c,'EL')=
  sum((v,r,ELl,ELs,ELday),ELwindop.l(ELpw,v,ELl,ELs,ELday,trun,r,c))
;




ELWAsupELp_ELp(trun,WApf,c,'WA')=
  sum((v,r,ELl,ELs,ELday,WAf)$(WAfuelburn(WApf,v,WAf,r,c)>0),
      WAFop.l(WApf,v,WAf,trun,r,c)*(1-WAyield(WApf,v,r,c)*WAelrate(WApF,v))*ELnormhours(ELl,ELs,ELday,c))
 +sum((v,r,ELl,ELs,ELday,WAf)$(WAfuelburn(WApf,v,WAf,r,c)>0),
      WAFop_trade.l(WApf,v,WAf,trun,r,c)*(1-WAyield(WApf,v,r,c)*WAelrate(WApF,v))*ELnormhours(ELl,ELs,ELday,c))
;

ELWAsupELp_ELp(trun,WApV,c,'WA')=
  sum((v,r,opm,ELl,ELs,ELday,WAf)$(WAVfuelburn(WApV,v,WAf,opm,r,c)>0),
      WAVop.l(WApV,v,ELl,ELs,ELday,WAf,opm,trun,r,c)*(1-WAVyield(WApV,v,opm,r,c)*WAelrate(WApV,v)))
 +sum((v,r,opm,ELl,ELs,ELday,WAf)$(WAVfuelburn(WApV,v,WAf,opm,r,c)>0),
      WAVop_trade.l(WApV,v,ELl,ELs,ELday,WAf,opm,trun,r,c)*(1-WAVyield(WApV,v,opm,r,c)*WAelrate(WApV,v)))
;

ELWAsupELp_xls(trun,c,ELp)$(not ELCCcon(ELp))= ELWAsupELp_ELp(trun,ELp,c,'EL');
ELWAsupELp_xls(trun,c,'CCGT')= sum(ELp$ELCCcon(ELp),ELWAsupELp_ELp(trun,ELp,c,'EL'));

ELWAsupELp_xls(trun,c,'Cogen')= sum(WAp,ELWAsupELp_ELp(trun,WAp,c,'WA'));















* fuel consumption (total)
ELWAfcon_xls(c,trun,f)=0;

ELWAfcon_xls(c,trun,f)=
  sum((r,ELpd)$rc(r,c),ELfconsump.l(ELpd,f,trun,r,c)*Fuelencon1(f))$ELf(f)
+ sum(r$rc(r,c), WAfconsump.l(f,trun,r,c)$WAf(f)*Fuelencon1(f))
;

ELWAfcon_trade(c,trun,f)=
+sum((r,ELpd)$(rc(r,c) and fMPt(f,c)),ELfconsump_trade.l(ELpd,f,trun,r,c)*Fuelencon1(f))
+sum(r$(rc(r,c) and fMPt(f,c)),WAfconsump_trade.l(f,trun,r,c)*Fuelencon1(f))
;

ELWAfcon_tot(trun,c,f)= ELWAfcon_xls(c,trun,f) +ELWAfcon_trade(c,trun,f);

* CAPACITIES

* power plants
ELWAcap(trun,c,ELpd,'EL') =
   sum((v,r)$rc(r,c), sum(ELpp,ELcapadd(ELpp,ELpd)*ELbld.l(ELpp,v,trun,r,c)$rc(r,c))
  +ELexistcp.l(ELpd,v,trun,r,c)$rc(r,c));

ELWAcap(trun,c,ELpsw,'EL') =
  sum((v,r)$rc(r,c), ELrenbld.l(ELpsw,v,trun,r,c)$rc(r,c)
  +ELrenexistcp.l(ELpsw,v,trun,r,c)$rc(r,c));

* thermal cogeneration (GW)
ELWAcap(trun,c,WApCO,'WA')=
  sum((v,r)$rc(r,c), WAbld.l(WApCO,v,trun,r,c)
 +WAexistcp.l(WApCo,v,trun,r,c)
 +WAaddition(WApCo,v,trun,r,c)
 -WAretirement(WApCo,v,trun,r,c) );

* water only plants
WAcapSingle(trun,c,WApSingle,'WA') =
  sum((v,r)$rc(r,c), WAbld.l(WApsingle,v,trun,r,c)
 +WAexistcp.l(WApsingle,v,trun,r,c)
 +WAaddition(WApsingle,v,trun,r,c)
 -WAretirement(WApsingle,v,trun,r,c));


RWcaputil(trun,c,ELpd)$(ELWAcap(trun,c,ELpd,'EL')>0)=
 (sum((v,r,ELday,ELs,ELl,ELf)$(Elfuelburn(ELpd,v,ELf,r,c)>0 and ELpcom(ELpd) and rc(r,c)),ELop.l(ELpd,v,ELl,ELs,ELday,ELf,trun,r,c))
 +sum((v,r,ELday,ELs,ELl,ELf)$(Elfuelburn(ELpd,v,ELf,r,c)>0 and ELpcom(ELpd) and rc(r,c)),ELop_trade.l(ELpd,v,ELl,ELs,ELday,ELf,trun,r,c))
 )/
 sum((ELday,ELs,ELl,v,r)$rc(r,c),ELWAcap(trun,c,ELpd,'EL')*ELlchours(ELl,c)*ELdaysinseason(ELs,ELday))
;

RWcaputil(trun,c,WApf)$(ELWAcap(trun,c,WApf,'WA')>0)=
( sum((v,r,ELday,ELs,ELl,WAf)$(WAfuelburn(WApf,v,WAf,r,c)>0),
      WAFop.l(WApf,v,WAf,trun,r,c)*(1-WAyield(WApf,v,r,c)*WAelrate(WApF,v))*ELnormhours(ELl,ELs,ELday,c))
 +sum((v,r,ELday,ELs,ELl,WAf)$(WAfuelburn(WApf,v,WAf,r,c)>0),
      WAFop_trade.l(WApf,v,WAf,trun,r,c)*(1-WAyield(WApf,v,r,c)*WAelrate(WApF,v))*ELnormhours(ELl,ELs,ELday,c))
)/
sum((ELday,ELs,ELl),ELWAcap(trun,c,WApf,'WA')*ELlchours(ELl,c)*ELdaysinseason(ELs,ELday))
;

RWcaputil(trun,c,WApV)$(ELWAcap(trun,c,WApV,'WA')>0)=
( sum((v,r,opm,ELday,ELs,ELl,WAf)$(WAVfuelburn(WApV,v,WAf,opm,r,c)>0),
      WAVop.l(WApV,v,ELl,ELs,ELday,WAf,opm,trun,r,c)*(1-WAVyield(WApV,v,opm,r,c)*WAelrate(WApV,v)))
 +sum((v,r,opm,ELday,ELs,ELl,WAf)$(WAVfuelburn(WApV,v,WAf,opm,r,c)>0),
      WAVop_trade.l(WApV,v,ELl,ELs,ELday,WAf,opm,trun,r,c)*(1-WAVyield(WApV,v,opm,r,c)*WAelrate(WApV,v)))
)/
sum((ELday,ELs,ELl),ELWAcap(trun,c,WApV,'WA')*ELlchours(ELl,c)*ELdaysinseason(ELs,ELday))
;









WAbld_tot(trun,c,WApSingle)=  sum((v,r)$rc(r,c), WAbld.l(WApSingle,v,trun,r,c));


* sector investments by technology by country
Invest(trun,ELpd,'EL')=
   sum((v,r,c)$(rc(r,c) and ELdiscoef1(ELpd,trun)>0),(1/ELdiscoef1(ELpd,trun))*ELCapital(ELpd,trun,r,c)*(1-(capsub(ELpd,trun))$ELpdsub(ELpd))*
   ELbld.l(ELpd,v,trun,r,c)$( ((ELpcom(ELpd) and vn(v)) or (vo(v) and ELpgttocc(ELpd)))));

Invest(trun,ELpsw,'EL')=
  +sum((v,r,c)$(rc(r,c) and ELdiscoef1(ELpsw,trun)>0),(1/ELdiscoef1(ELpsw,trun))*ELCapital(ELpsw,trun,r,c)*(1-(capsub(ELpsw,trun))$ELprsub(ELpsw))*
   ELrenbld.l(ELpsw,v,trun,r,c)$vn(v));

Invest(trun,WAp,'WA')=
   sum((v,r,c)$(rc(r,c) and vn(v) and WAdiscfact(trun)>0),(1/WAdiscfact(trun))*WApurcst(WAp,trun,r,c)*WAbld.l(WAp,v,trun,r,c))
  +sum((rr,cc)$rc(rr,cc),WAstopurcst(trun,rr,cc)*WAstobld.l(trun,rr,cc));


Shadowprice(trun,c,r,fup)$rc(r,c)= dfdem.l(fup,trun,r,c);

Fuelexports_TBTU(trun,c,fup)$(Fuelencon1(fup)>0)= sum(r$rc(r,c),fExports.l(fup,trun,r,c)/Fuelencon1(fup));
Fuelexports_phys(trun,c,fup)= sum(r$rc(r,c),fExports.l(fup,trun,r,c));

fuelimports_phys(trun,c,fup)= sum(r$rc(r,c),fimports.l(trun,fup,r,c));

ELWAfcon_physical(c,trun,f)$(Fuelencon1(f)>0)=
  ELWAfcon_xls(c,trun,f)/Fuelencon1(f);

fueltrans(trun,fup,r,c,rr,cc)=ftrans.l(fup,trun,r,c,rr,cc);

* relative fuel costs
EMaddlcost(trun,ELf,c)$call(c)= EMfactors2(ELf)*EMprice('EL','CO2',trun,c);
fRelativecost(trun,ELf,r,c)$(rc(r,c) and Fuelencon1(ELf)>0)=
dfdem.l(ELf,trun,r,c)*ELdiscfact(trun)/Fuelencon1(ELf)

$ontext
  +  EMaddlcost(trun,ELf,c)
  +((Dfdem.l(ELf,trun,r,c)*ELdiscfact(trun)/Fuelencon1(ELf))$ELfup(ELf)
    +(RFintlprice(ELf,trun)*ELdiscfact(trun)/Fuelencon1(ELf))$ELfref(ELf))$(ElfMP(ELf))
  +( ELAPf(ELf,trun,r,c)*ELdiscfact(trun)/Fuelencon1(ELf))$(ELfAP(ELf))
$offtext
;

excessmethane(trun,'methane',r,c)$rc(r,c)=
  Fueluse.up('methane','ss1',trun,r,c)
 -Fueluse.l('methane','ss1',trun,r,c)
;


ELWAfcon_sec(trun,f,c,'EL') = sum((r,ELpd),ELfconsump.l(ELpd,f,trun,r,c)$rc(r,c)*Fuelencon1(f))$ELf(f);
ELWAfCon_sec(trun,f,c,'WA') = sum(r,WAfconsump.l(f,trun,r,c))$WAf(f)*Fuelencon1(f);

transbld(trun,r,c,rr,cc)$(not sameas(c,cc))=TRbld.l(r,c,rr,cc,trun);

ELWAfortrade(trun,c,ELl)=sum((ELs,ELday),ELtrademax.l(trun,ELl,ELs,ELday,c));

RWELtrade_ELl(trun,ELl,ELs,c,cc)$(not sameas(c,cc))=sum((r,rr,ELday)$(rc(r,c) and rc(rr,cc)),TRnodaltrans.l(ELl,ELs,ELday,trun,r,c,rr,cc));

RWDELsup(trun,ELl,ELs,ELday,r,c)= DELsup.l(ELl,ELs,ELday,trun,r,c);

