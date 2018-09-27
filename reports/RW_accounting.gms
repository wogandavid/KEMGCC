* accounting reports
* ==================

parameters
Invest_reg                       sector investments by technology by region [million USD]
Invest_agg                       sector investments by technology by country [million USD]
Invest_tot

Investment_ELP           investment in specific technology [million USD]
AverageCost              average cost of generating electricity [million USD per TWh]

ELcost_marginal(trun,c) average marginal cost of electricity (USD per kWh)

*Discounted system cost
NetCashFlow(c,ksec)                  Revenues minus costs in [millions USD 2015]
SectorCost(c,ksec)                   Aggregate costs by sector [million USD 2015]
SectorRevenue(c,ksec)                Aggregate revenues by sector [million USD 2015]
;


* sector investments by technology by region
Invest_reg(trun,c,r,ELpd,'EL')$rc(r,c)=
   sum(v$rc(r,c),ELCapital(ELpd,trun,r,c)*(1-(capsub(ELpd,trun))$ELpdsub(ELpd))*
   ELbld.l(ELpd,v,trun,r,c)$( ((ELpcom(ELpd) and vn(v)) or (vo(v) and ELpgttocc(ELpd)))));

Invest_reg(trun,c,r,ELpsw,'EL')$rc(r,c)=
  +sum(v$rc(r,c),ELCapital(ELpsw,trun,r,c)*(1-(capsub(ELpsw,trun))$ELprsub(ELpsw))*
   ELrenbld.l(ELpsw,v,trun,r,c)$vn(v));

Invest_reg(trun,c,r,WAp,'WA')$rc(r,c)=
   sum(v$(rc(r,c) and vn(v)),WApurcst(WAp,trun,r,c)*WAbld.l(WAp,v,trun,r,c))
  +sum((rr,cc)$rc(rr,cc),WAstopurcst(trun,rr,cc)*WAstobld.l(trun,rr,cc));

* sector investments by technology by country
Invest_agg(trun,ELpd,c,'EL')=
   sum((v,r)$rc(r,c),ELCapital(ELpd,trun,r,c)*(1-(capsub(ELpd,trun))$ELpdsub(ELpd))*
   ELbld.l(ELpd,v,trun,r,c)$( ((ELpcom(ELpd) and vn(v)) or (vo(v) and ELpgttocc(ELpd)))));

Invest_agg(trun,ELpsw,c,'EL')=
  +sum((v,r)$rc(r,c),ELCapital(ELpsw,trun,r,c)*(1-(capsub(ELpsw,trun))$ELprsub(ELpsw))*
   ELrenbld.l(ELpsw,v,trun,r,c)$vn(v));

Invest_agg(trun,c,WAp,'WA')=
   sum((v,r)$(rc(r,c) and vn(v)),WApurcst(WAp,trun,r,c)*WAbld.l(WAp,v,trun,r,c))
  +sum((rr,cc)$rc(rr,cc),WAstopurcst(trun,rr,cc)*WAstobld.l(trun,rr,cc));


Invest_tot(trun,c)=
   sum(ELpd,invest_agg(trun,ELpd,c,'EL'))
  +sum(WAp, invest_agg(trun,WAp,c,'WA'));



NetCashFlow(c,ksec)$(not INTsec(ksec))=0;

* costs for power sector - MMUSD
SectorCost(c,'EL') = sum(trun,ELdiscfact(trun)*(
* capital cost
  sum((ELpd,v,r)$rc(r,c),ELCapital(ELpd,trun,r,c)*(1-(capsub(ELpd,trun))$ELpdsub(ELpd))*
  ELbld.l(ELpd,v,trun,r,c)$( ((ELpcom(ELpd) and vn(v)) or (vo(v) and ELpgttocc(ELpd)))  ))
 +sum((ELpsw,v,r)$rc(r,c),ELCapital(ELpsw,trun,r,c)*(1-(capsub(ELpsw,trun))$ELprsub(ELpsw))*
  ELrenbld.l(ELpsw,v,trun,r,c)$vn(v))
 +sum((r,rr,cc)$(rc(r,c) and rc(rr,cc)), ELtranspurcst(r,c,trun,rr,cc)*
  ELtransbld.l(trun,r,c,rr,cc))
* opmaint cost
 +sum((ELpd,v,ELl,ELs,ELday,ELf,r)$(rc(r,c) and Elfuelburn(ELpd,v,ELf,r,c)>0 and Elpcom(ELpd)),
  ELomcst(ELpd,v,r,c)*ELop.l(ELpd,v,ELl,ELs,ELday,ELf,trun,r,c))
 +sum((ELps,v,ELl,ELs,ELday,r)$rc(r,c),ELomcst(ELps,v,r,c)*ELsolop.l(ELps,v,ELl,ELs,ELday,trun,r,c))
 +sum((ELpw,v,ELl,ELs,Elday,r)$rc(r,c),ELomcst(ELpw,v,r,c)*ELwindop.l(ELpw,v,ELl,ELs,ELday,trun,r,c))
 +sum((ELpd,v,r)$rc(r,c),ELfixedOMcst(ELpd,trun)*(
       sum(ELpp$( ((ELpcom(ELpp) and vn(v)) or (vo(v) and ELpgttocc(ELpp))) ),
       ELcapadd(ELpp,ELpd)*ELbld.l(ELpp,v,trun,r,c))+ELexistcp.l(ELpd,v,trun,r,c)))
 +sum((ELpsw,v,r)$rc(r,c),ELfixedOMcst(ELpsw,trun)*(ELrenbld.l(ELpsw,v,trun,r,c)$vn(v)+ELrenexistcp.l(ELpsw,v,trun,r,c)))
 +sum((ELstorage,ELl,ELs,ELday,r)$rc(r,c),ELstoromcst(ELstorage,r,c)*ELheatstorage.l(ELl,ELs,ELday,trun,r,c))
 +sum((ELl,ELs,ELday,r,rr,cc)$(rc(r,c) and rc(rr,cc)),ELtransomcst(r,c,rr,cc)*ELtrans.l(ELl,ELs,ELday,trun,r,c,rr,cc))
 +sum((ELpd,ELl,ELs,ELday,r)$rc(r,c),ELrampupcst.l(ELpd,ELl,ELs,ELday,trun,r,c)+ELrampdncst.l(ELpd,ELl,ELs,ELday,trun,r,c))
* fuel cost
 +sum((Elpd,ELf,r)$rc(r,c),ELfconsump.l(ELpd,ELf,trun,r,c)*(
     ((Dfdem.l(ELf,trun,r,c)/ELdiscfact(trun))$ELfup(ELf))$ElfMP(ELf)
 +ELAPf(ELf,trun,r,c)$ELfAP(ELf)))
* electricity purchased from water sector
 +sum((ELl,ELs,ELday,r)$rc(r,c),WAELsupply.l(ELl,ELs,ELday,trun,r,c)*
     (ELAPELwa(ELl,ELs,ELday,trun,r,c)$(ELWAcoord<>1)
 +DELsup.l(ELl,ELs,ELday,trun,r,c)$(ELWAcoord=1)))

))
;

* revenue for power sector
SectorRevenue(c,'EL')= sum((trun,ELl,ELs,ELday,r)$rc(r,c),ELdiscfact(trun)*
     (WAELconsump.l(ELl,ELs,ELday,trun,r,c)*
      DELsup.l(ELl,ELs,ELday,trun,r,c)));

* cost for water sector - MMUSD
SectorCost(c,'WA') =
  sum(trun,WAdiscfact(trun)*(
* capital cost
  sum((WAP,v,r)$(rc(r,c) and vn(v)),WApurcst(WAp,trun,r,c)*WAbld.l(WAp,v,trun,r,c))
 +sum((r,rr,cc)$(rc(r,c) and rc(rr,cc)),WAtranspurcst(trun,r,c,rr,cc)*
  WAtransbld.l(trun,r,c,rr,cc))
 +sum((rr,cc)$rc(rr,cc),WAstopurcst(trun,rr,cc)*WAstobld.l(trun,rr,cc))
* opmaincost
 +sum((WApF,v,WAf,r)$(rc(r,c) and WAfuelburn(WApF,v,WAf,r,c)<>0),
   (WAELomcst(WApF,r,c)+WAomcst(WApF,r,c)*WAyield(WApF,v,r,c))*WAFop.l(WApF,v,WAf,trun,r,c))
 +sum((WApV,v,ELl,ELs,ELday,WAf,opm,r)$(rc(r,c) and WAVfuelburn(WApV,v,WAf,opm,r,c)>0),
   (WAELomcst(WApV,r,c)+WAomcst(WApV,r,c)*WAVyield(WApV,v,opm,r,c))*
  WAVop.l(WApV,v,ELl,Els,ELday,WAf,opm,trun,r,c))
 +sum((WAp,v,r)$rc(r,c),WAfixedOMcst(WAp,trun,c)*
     (WAbld.l(WAp,v,trun,r,c)$vn(v)+WAexistcp.l(WAp,v,trun,r,c)) )
 +sum((ELl,ELs,ELday,r,rr,cc)$(rc(r,c) and rc(rr,cc)),WAtransomcst(r,c,rr,cc)*
  WAtrans.l(ELl,ELs,ELday,trun,r,c,rr,cc))
 +sum((WAprn,v,ELl,ELs,ELday,r)$rc(r,c),WAELomcst(WAprn,r,c)*
  WAsolop.l(WAprn,v,ELl,ELs,Elday,trun,r,c))
 +sum((ELl,ELs,ELday,rr,cc)$rc(rr,cc),WAstoomcst(rr,cc)*
  WAstoop.l(ELl,ELs,ELday,trun,rr,cc))
* fuel cost
 +sum((WAf,r)$rc(r,c),WAfconsump.l(WAf,trun,r,c)*(
    ((Dfdem.l(WAf,trun,r,c)/WAdiscfact(trun))$WAfup(WAf))$WAfMP(WAf)
 +WAAPf(WAf,trun,r,c)$WAfAP(WAf)))
* electricity purchased from power sector
 +sum((ELl,ELs,ELday,r)$rc(r,c), ELdiscfact(trun)*(
  WAELconsump.l(ELl,ELs,ELday,trun,r,c)*DELsup.l(ELl,ELs,ELday,trun,r,c)))

))
;

* revenue for water sector
SectorRevenue(c,'WA')=
* electricity sold to power sector
 sum((trun,ELl,ELs,ELday,r)$rc(r,c),WAELsupply.l(ELl,ELs,ELday,trun,r,c)*
         ( ELAPELwa(ELl,ELs,ELday,trun,r,c)$(ELWAcoord<>1)
          +DELsup.l(ELl,ELs,ELday,trun,r,c)$(ELWAcoord=1)))
;

* costs for upstream sector - MMUSD
SectorCost(c,'UP') = sum(trun,
* capital costs
  sum((fup,r,rr,cc)$(rc(r,c) and rc(rr,cc)),
  ftranspurcst(fup,trun,r,c,rr,cc)*ftransbld.l(fup,trun,r,c,rr,cc))
* opmaint costs
 +sum((fup,r,rr,cc)$(rc(r,c) and rc(rr,cc) and ftransyield(fup,r,c,rr,cc)>0),
  ftransomcst(fup,r,c,rr,cc)*ftrans.l(fup,trun,r,c,rr,cc))
* fuel production costs
 +sum((fup,ss,r)$(ss('ss1') and fup('arablight') ),fuelcst(trun,fup,ss,c)*fueluse.l(fup,ss,trun,r,c))
)
;

$ontext
parameter production(c,fup,ss);
production(c,'methane','ss1') = sum((trun,r)$rc(r,c),fuelcst('methane','ss1',c)*fueluse.l('methane','ss1',trun,r,c));
production(c,'arablight','ss1') = sum((trun,r)$rc(r,c),fuelcst('arablight','ss1',c)*fueluse.l('arablight','ss1',trun,r,c));
production(c,'crude','ss1') = sum((trun,r)$rc(r,c),fuelcst('crude','ss1',c)*fueluse.l('crude','ss1',trun,r,c));
$offtext

* revenue for upstream sector
SectorRevenue(c,'UP')= sum(trun,
* exports
  sum((fup,r)$rc(r,c),fintlprice(fup,trun)*fExports.l(fup,trun,r,c))
* fuel sold to power sector
 +sum((Elpd,ELf,r)$rc(r,c),ELfconsump.l(ELpd,ELf,trun,r,c)*(
     ((Dfdem.l(ELf,trun,r,c)/ELdiscfact(trun))$ELfup(ELf))$ElfMP(ELf)
 +ELAPf(ELf,trun,r,c)$ELfAP(ELf)))
* fuel sold to water sector
 +sum((WAf,r)$rc(r,c),WAfconsump.l(WAf,trun,r,c)*(
    ((Dfdem.l(WAf,trun,r,c)/WAdiscfact(trun))$WAfup(WAf))$WAfMP(WAf)
 +WAAPf(WAf,trun,r,c)$WAfAP(WAf)))
)
;

* calculate net cash flow (revenue-cost)
NetCashFlow(c,ksec)= SectorRevenue(c,ksec)-SectorCost(c,ksec);

Investment_ELp(trun,c)=
  sum((ELpsw,v,r)$rc(r,c),ELCapital(ELpsw,trun,r,c)*(1-(capsub(ELpsw,trun))$ELprsub(ELpsw))*
  ELrenbld.l(ELpsw,v,trun,r,c)$vn(v))
 +sum((ELps,v,ELl,ELs,ELday,r)$rc(r,c),ELomcst(ELps,v,r,c)*ELsolop.l(ELps,v,ELl,ELs,ELday,trun,r,c))
 +sum((ELpsw,v,r)$rc(r,c),ELfixedOMcst(ELpsw,trun)*
     (ELrenbld.l(ELpsw,v,trun,r,c)$vn(v)+ELrenexistcp.l(ELpsw,v,trun,r,c)))
;

*AverageCost(trun,w,c)= sum(ksec,SectorCost(c,ksec))/ELWAsupELp_tot(trun,c);

ELcost_marginal(trun,c)= sum((ELl,ELs,ELday,r),delsup.l(ELl,ELs,ELday,trun,r,c))/
                 (card(ELl) + card(ELs) + card(ELday) + card(r));

option Invest_reg:3:4:1;
option Invest_agg:3:3:1;
option Invest_tot:3:1:1;
option SectorCost:3:1:1;
option SectorRevenue:3:1:1;
option NetCashFlow:3:1:1;

display
Investment_ELp
Invest_reg
Invest_agg
Invest_tot
NetCashFlow
SectorCost
SectorRevenue
NetCashFlow
ELcost_marginal
;
