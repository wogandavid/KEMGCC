* cost calculations
* =================

* capex
RWcapex(trun,c)=
 sum((fup,r,rr,cc)$(rc(r,c) and rc(rr,cc)),
ftranspurcst(fup,trun,r,c,rr,cc)*ftransbld.l(fup,trun,r,c,rr,cc))
+sum((ELpd,v,r)$rc(r,c),ELCapital(ELpd,trun,r,c)*(1-(capsub(ELpd,trun))$ELpdsub(ELpd))*ELbld.l(ELpd,v,trun,r,c)$( ((ELpcom(ELpd) and vn(v)) or (vo(v) and ELpgttocc(ELpd)))  ))
+sum((ELpsw,v,r)$rc(r,c),ELCapital(ELpsw,trun,r,c)*(1-(capsub(ELpsw,trun))$ELprsub(ELpsw))*ELrenbld.l(ELpsw,v,trun,r,c)$vn(v))

+sum((WAP,v,r)$(rc(r,c) and vn(v)), WApurcst(WAp,trun,r,c)*WAbld.l(WAp,v,trun,r,c))
+sum((r,rr,cc)$(rc(r,c) and rc(rr,cc)), WAtranspurcst(trun,r,c,rr,cc)*WAtransbld.l(trun,r,c,rr,cc))
+sum((rr,cc)$rc(rr,cc),WAstopurcst(trun,rr,cc)*WAstobld.l(trun,rr,cc))

+sum((r,rr,cc)$(rc(r,c) and rc(rr,cc) and t_ind(trun)>TRleadtime(r,c,rr,cc)),
        TRcapital(trun,r,c,rr,cc)*TRdistance(r,rr)*TRbld.l(r,c,rr,cc,trun))
;
* opex
RWopex(trun,c)=
 sum((fup,r,rr,cc)$(rc(r,c) and rc(rr,cc) and ftransyield(fup,r,c,rr,cc)>0),(1/fdiscfact(trun))*ftransomcst(fup,r,c,rr,cc)*ftrans.l(fup,trun,r,c,rr,cc))

+sum((ELpd,v,ELl,ELs,ELday,ELf,r)$(rc(r,c) and Elfuelburn(ELpd,v,ELf,r,c)>0 and Elpcom(ELpd)),
   (1/ELdiscfact(trun))*ELomcst(ELpd,v,r,c)*ELop.l(ELpd,v,ELl,ELs,ELday,ELf,trun,r,c))
+sum((ELpd,v,ELl,ELs,ELday,ELf,r)$(fMPt(ELf,c) and rc(r,c) and Elfuelburn(ELpd,v,ELf,r,c)>0 and Elpcom(ELpd)),
   (1/ELdiscfact(trun))*ELomcst(ELpd,v,r,c)*ELop_trade.l(ELpd,v,ELl,ELs,ELday,ELf,trun,r,c))
+sum((ELps,v,ELl,ELs,ELday,r)$rc(r,c),(1/ELdiscfact(trun))*ELomcst(ELps,v,r,c)*ELsolop.l(ELps,v,ELl,ELs,ELday,trun,r,c))
+sum((ELpw,v,ELl,ELs,Elday,r)$rc(r,c),(1/ELdiscfact(trun))*ELomcst(ELpw,v,r,c)*ELwindop.l(ELpw,v,ELl,ELs,ELday,trun,r,c))
+sum((ELpd,v,r)$rc(r,c),(1/ELdiscfact(trun))*ELfixedOMcst(ELpd,trun)*(
         sum(ELpp$( ((ELpcom(ELpp) and vn(v)) or (vo(v) and ELpgttocc(ELpp))) ),
         ELcapadd(ELpp,ELpd)*ELbld.l(ELpp,v,trun,r,c))+ELexistcp.l(ELpd,v,trun,r,c)))
+sum((ELpsw,v,r)$rc(r,c),(1/ELdiscfact(trun))*ELfixedOMcst(ELpsw,trun)*(ELrenbld.l(ELpsw,v,trun,r,c)$vn(v)+ELrenexistcp.l(ELpsw,v,trun,r,c)))
+sum((ELpd,ELstorage,ELl,ELs,ELday,r)$rc(r,c),(1/ELdiscfact(trun))*ELstoromcst(ELstorage,r,c)*ELheatstorage.l(ELl,ELs,ELday,trun,r,c))
+sum((ELpd,ELl,ELs,ELday,r)$rc(r,c),(1/ELdiscfact(trun))*ELrampupcst.l(ELpd,ELl,ELs,ELday,trun,r,c)+ELrampdncst.l(ELpd,ELl,ELs,ELday,trun,r,c))

+sum((WApF,v,WAf,r)$(rc(r,c) and WAfuelburn(WApF,v,WAf,r,c)<>0),
   (1/WAdiscfact(trun))*(WAELomcst(WApF,r,c)+WAomcst(WApF,r,c)*WAyield(WApF,v,r,c))*WAFop.l(WApF,v,WAf,trun,r,c))
+sum((WApV,v,ELl,ELs,ELday,WAf,opm,r)$(rc(r,c) and WAVfuelburn(WApV,v,WAf,opm,r,c)>0),
   (1/WAdiscfact(trun))*(WAELomcst(WApV,r,c)+WAomcst(WApV,r,c)*WAVyield(WApV,v,opm,r,c))*WAVop.l(WApV,v,ELl,Els,ELday,WAf,opm,trun,r,c))

+sum((WApF,v,WAf,r)$(fMPt(WAf,c) and rc(r,c) and WAfuelburn(WApF,v,WAf,r,c)<>0),
   (1/WAdiscfact(trun))*(WAELomcst(WApF,r,c)+WAomcst(WApF,r,c)*WAyield(WApF,v,r,c))*WAFop_trade.l(WApF,v,WAf,trun,r,c))
+sum((WApV,v,ELl,ELs,ELday,WAf,opm,r)$(fMPt(WAf,c) and rc(r,c) and WAVfuelburn(WApV,v,WAf,opm,r,c)>0),
   (1/WAdiscfact(trun))*(WAELomcst(WApV,r,c)+WAomcst(WApV,r,c)*WAVyield(WApV,v,opm,r,c))*WAVop_trade.l(WApV,v,ELl,Els,ELday,WAf,opm,trun,r,c))

+sum((WAp,v,r)$rc(r,c),(1/WAdiscfact(trun))*WAfixedOMcst(WAp,trun,c)*(WAbld.l(WAp,v,trun,r,c)$vn(v)+WAexistcp.l(WAp,v,trun,r,c)) )
+sum((ELl,ELs,ELday,r,rr,cc)$(rc(r,c) and rc(rr,cc)),(1/WAdiscfact(trun))*WAtransomcst(r,c,rr,cc)*WAtrans.l(ELl,ELs,ELday,trun,r,c,rr,cc))
+sum((WAprn,v,ELl,ELs,ELday,r)$rc(r,c), (1/WAdiscfact(trun))*WAELomcst(WAprn,r,c)*WAsolop.l(WAprn,v,ELl,ELs,Elday,trun,r,c))
+sum((ELl,ELs,ELday,rr,cc)$rc(rr,cc),(1/WAdiscfact(trun))*WAstoomcst(rr,cc)*WAstoop.l(ELl,ELs,ELday,trun,rr,cc))

+sum((r,rr,cc)$(rc(r,c) and rc(rr,cc)),
      (1/TRdiscfact(trun))*TRfixedomcst(r,c,rr,cc)*TRdistance(r,rr)*(TRexistcp.l(r,c,rr,cc,trun)+TRbld.l(r,c,rr,cc,trun)$(t_ind(trun)>TRleadtime(r,c,rr,cc))))

+sum((ELl,ELs,ELday,r,rr,cc)$(rc(r,c) and rc(rr,cc) and (TRtransyield(r,c,rr,cc)>0)),
       (1/TRdiscfact(trun))*TRomcst(r,c,rr,cc)*TRdistance(r,rr)*TRnodaltrans.l(ELl,ELs,ELday,trun,r,c,rr,cc)*TRtransyield(r,c,rr,cc))

+sum((ELl,ELs,ELday,r)$(rc(r,c)), TRomcst(r,c,r,c)*TRdistance(r,r)*(ELsupply.l(ELl,ELs,ELday,trun,r,c)
                               -sum((rr,cc)$(rc(rr,cc)and (TRtransyield(r,c,rr,cc)>0)),
                                    (1/TRdiscfact(trun))*TRnodaltrans.l(ELl,ELs,ELday,trun,r,c,rr,cc)*TRtransyield(r,c,rr,cc)) ))
;

* fuel consumption costs (opp cost?)
RWfuelex(trun,c)=

 sum((Elpd,ELf,r)$(rc(r,c) and ELfAP(ELf,c)),(fintlprice(ELf,trun)-ELAPf(ELf,trun,r,c))*(1/ELdiscfact(trun))*ELfconsump.l(ELpd,ELf,trun,r,c))
+sum((Elpd,ELfref,r)$(rc(r,c) and ELfAP(ELfref,c)),(Rfintlprice(ELfref,trun)-ELAPf(ELfref,trun,r,c))*(1/ELdiscfact(trun))*ELfconsump.l(ELpd,ELfref,trun,r,c))
*+sum((Elpd,ELf,r)$rc(r,c),Dfdem.l(ELf,trun,r,c)*(1/ELdiscfact(trun))*ELfconsump.l(ELpd,ELf,trun,r,c))
*+sum((Elpd,ELf,r)$rc(r,c),Dfdem.l(ELf,trun,r,c)*(1/ELdiscfact(trun))*ELfconsump_trade.l(ELpd,ELf,trun,r,c))

+sum((WAf,r)$(rc(r,c) and ELfAP(WAf,c)),(fintlprice(WAf,trun)-WAAPf(WAf,trun,r,c))*(1/WAdiscfact(trun))*WAfconsump.l(WAf,trun,r,c))
+sum((WAfref,r)$(rc(r,c) and ELfAP(WAfref,c)),(RFintlprice(WAfref,trun)-WAAPf(WAfref,trun,r,c))*(1/WAdiscfact(trun))*WAfconsump.l(WAfref,trun,r,c))
*+sum((WAf,r)$rc(r,c),Dfdem.l(WAf,trun,r,c)*(1/WAdiscfact(trun))*WAfconsump.l(WAf,trun,r,c))
*+sum((WAf,r)$rc(r,c),Dfdem.l(WAf,trun,r,c)*(1/WAdiscfact(trun))*WAfconsump_trade.l(WAf,trun,r,c))


;
* import expenditure (electricity, gas)
RWELimportex(trun,cc)=
sum((r,c,rr,ELl,ELs,ELday)$(rc(r,c) and rc(rr,cc) and (not sameas(c,cc))),(1/TRdiscfact(trun))*DELsup.l(ELl,ELs,ELday,trun,r,c)*TRnodaltrans.l(ELl,ELs,ELday,trun,r,c,rr,cc)*TRtransyield(r,c,rr,cc));

RWfimportex(trun,cc)=
 sum((rr,fup)$rc(rr,cc),(1/fdiscfact(trun))*fimports.l(trun,fup,rr,cc)*fintlprice(fup,trun));


* export revenue (oil, gas, and electricity)
RWELexportrev(trun,c)=
sum((r,rr,cc,ELl,ELs,ELday)$(rc(r,c) and rc(rr,cc) and (not sameas(c,cc))),(1/TRdiscfact(trun))*DELsup.l(ELl,ELs,ELday,trun,r,c)*TRnodaltrans.l(ELl,ELs,ELday,trun,r,c,rr,cc)*TRtransyield(r,c,rr,cc));

RWfexportrev(trun,c)= sum((r,fup)$rc(r,c),(1/fdiscfact(trun))*fExports.l(fup,trun,r,c)*fintlprice(fup,trun));


** average cost of generation
*
*RWmargencost(trun,c)=
*
*sum((ELpd,v,ELl,ELs,ELday,ELf,r)$(rc(r,c) and Elfuelburn(ELpd,v,ELf,r,c)>0 and Elpcom(ELpd)),
*   (1/ELdiscfact(trun))*(ELop.l(ELpd,v,ELl,ELs,ELday,ELf,trun,r,c)
*                        +ELop_trade.l(ELpd,v,ELl,ELs,ELday,ELf,trun,r,c)
*                        +WAELsupply.l(ELl,ELs,ELday,trun,r,c))*DELsup.l(ELl,ELs,ELday,trun,r,c))
*   /
*sum((ELpd,v,ELl,ELs,ELday,ELf,r)$(rc(r,c) and Elfuelburn(ELpd,v,ELf,r,c)>0 and Elpcom(ELpd)),
*   (1/ELdiscfact(trun))*(ELop.l(ELpd,v,ELl,ELs,ELday,ELf,trun,r,c)
*                        +ELop_trade.l(ELpd,v,ELl,ELs,ELday,ELf,trun,r,c)
*                        +WAELsupply.l(ELl,ELs,ELday,trun,r,c)));
*

* total cost
RWnetex(trun,c)=
-RWcapex(trun,c)
-RWopex(trun,c)
-RWfuelex(trun,c)
-RWELimportex(trun,c)
-RWfimportex(trun,c)
+RWELexportrev(trun,c)
+RWfexportrev(trun,c)
;

* table
RWcostcalcs(trun,'Capex',c)=RWcapex(trun,c)/1e3;
RWcostcalcs(trun,'Opex',c)=RWopex(trun,c)/1e3;
RWcostcalcs(trun,'Fuelex',c)=RWfuelex(trun,c)/1e3;
RWcostcalcs(trun,'ELimportex',c)=RWELimportex(trun,c)/1e3;
RWcostcalcs(trun,'fImportex',c)=RWfimportex(trun,c)/1e3;
RWcostcalcs(trun,'ELexportrev',c)=RWELexportrev(trun,c)/1e3;
RWcostcalcs(trun,'fExportrev',c)=RWfexportrev(trun,c)/1e3;
RWcostcalcs(trun,'Total System',c)=RWnetex(trun,c)/1e3;

execute_unload 'results/MainScenarios/2020_05_12/results_cost_calcs_%scenario%.gdx'
RWcostcalcs
;