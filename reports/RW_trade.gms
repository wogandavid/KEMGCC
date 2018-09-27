* trade reports

parameter
RWELtradesupmax(trun,c) tradesupmax
RWELsolop(trun,c)
RWELtrade_fMP(trun,c,cc) allowable trade
RWELtrade_dom(trun,ELs,ELday,ELl,r,c,rr,cc) in country trade
RWELtrade_tot(trun,c,cc) annual trade between countries
RWELtrade_ELl(trun,ELl,c,cc) load segment trade between countries
RWELtrade_ELs(trun,ELs,ELl,c,cc)
RWtrade_delsup(trun,ELs,ELl,c)

*RW_objvalues(trun,c) cost of meeting demand
RWELtransbld(trun,r,c,rr,cc) transmission capacity built
RWELtrade(trun,ELs,ELday,ELl,r,c,rr,cc) only trade between countries
;

RWELtrade_dom(trun,ELs,ELday,ELl,r,c,rr,cc)=
 TRnodaltrans.l(ELl,ELs,ELday,trun,r,c,rr,cc)$(    (rc(r,c) and rc(rr,cc) )
                                           and (TRline(r,c,rr,cc) or TRline2(r,c,rr,cc))
*                                           and (not sameas(c,cc))
                                           )
;

RWELtrade(trun,ELs,ELday,ELl,r,c,rr,cc)=
 TRnodaltrans.l(ELl,ELs,ELday,trun,r,c,rr,cc)$(    (rc(r,c) and rc(rr,cc) )
                                           and (TRline(r,c,rr,cc) or TRline2(r,c,rr,cc))
                                           and (not sameas(c,cc))
                                           )
;

RWELtrade_tot(trun,c,cc)=
  sum((r,rr,Ell,ELs,ELday),TRnodaltrans.l(ELl,ELs,ELday,trun,r,c,rr,cc)$(    (rc(r,c) and rc(rr,cc) )
                                           and (TRline(r,c,rr,cc) or TRline2(r,c,rr,cc))
*                                           and (not sameas(c,cc))
                                           )
    )
;

RWELtrade_ELl(trun,ELl,c,cc)=
  sum((r,rr,ELs,ELday),TRnodaltrans.l(ELl,ELs,ELday,trun,r,c,rr,cc)$(    (rc(r,c) and rc(rr,cc) )
                                           and (TRline(r,c,rr,cc) or TRline2(r,c,rr,cc))
                                           and (not sameas(c,cc))
                                           )
   )
;

RWELtrade_ELs(trun,ELs,ELl,c,cc)$(not sameas(c,cc))=
  sum((r,rr,ELday),TRnodaltrans.l(ELl,ELs,ELday,trun,r,c,rr,cc)$(    (rc(r,c) and rc(rr,cc) )
                                           and (TRline(r,c,rr,cc) or TRline2(r,c,rr,cc))
                                           and (not sameas(c,cc))
                                           )
   )
;


RWELtransbld(trun,r,c,rr,cc)$(rc(r,c) and rc(rr,cc))=
  TRbld.l(r,c,rr,cc,trun)
;

$ontext
RW_objvalues(trun,c)$call(c)=

  (ELCapitalCost.l(trun)+ELOpandmaint.l(trun))*ELdiscfact(trun)
 +sum((Elpd,ELf,r)$rc(r,c),Dfdem.l(ELf,trun,r,c)*ELfconsump.l(ELpd,ELf,trun,r,c)*ELdiscfact(trun))
 +(WAcapitalcost.l(trun)+WAOpandmaint.l(trun))*WAdiscfact(trun)
 +sum((WAf,r)$rc(r,c),Dfdem.l(WAf,trun,r,c)*WAfconsump.l(WAf,trun,r,c)*WAdiscfact(trun))
;
$offtext

$ontext
RWELtradesupmax(trun,c)=
  sum((ELl,ELs,ELday),ELtradesupmax.l(trun,ELl,ELs,ELday,c))
 +sum((ELl,ELs,ELday),WAELtradesupmax.l(trun,ELl,ELs,ELday,c))
;
$offtext

RWELsolop(trun,c)=
  sum((ELps,v,r,ELl,ELs,ELday),ELsolop.l(ELps,v,ELl,ELs,ELday,trun,r,c))
 +sum((ELpw,v,r,ELl,ELs,ELday),ELwindop.l(ELpw,v,ELl,ELs,ELday,trun,r,c));

RWtrade_delsup(trun,ELs,ELl,c)$call(c)=
  sum((r,ELday)$rc(r,c),DELsup.l(ELl,ELs,ELday,trun,r,c))
;

*option RW_objvalues:3:0:1;
*option RWELtradesupmax:3:0:1;
option RWELsolop:3:0:1;
option RWELtrade:3:0:1;
option RWELtrade_dom:3:0:1;
option RWELtrade_tot:3:2:1;
option RWELtrade_ELl:3:0:1;
option RWELtrade_ELs:3:3:2;
option RWtrade_delsup:3:3:1;
*option ELtradesupmax:3:0:1;
*option WAELtradesupmax:3:0:1;
option RWELtransbld:3:2:2;


*display RW_objvalues;
*display RWELtradesupmax;
display RWELsolop;
display RWELtrade;
display RWELtrade_dom;
display RWELtrade_tot;
display RWELtrade_ELl;
display RWELtrade_ELs;
display RWtrade_delsup;
*display ELtradesupmax.l;
*display WAELtradesupmax.l;
display RWELtransbld;


