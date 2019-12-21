* Post Solution Calculations for Power and Water sectors
* The parameters are defined in RW_Parameters.gms
* ===============================================

parameters
*test parameters for dual of el supply
ELWAsupELp                       TWh electricity produced by power plants
ELWAsupWAp                       TWh electricity produced by water plants
ELWAconsumpWAp                   TWh electricity consumed by water plants
ELWAsup_tot                      TWh electricity produced
ELWAtrans                        TWh electricity sent out
ELWAsupELp_xls
ELWAbld_xls
ELWAcap_xls
ELWAfcon_xls
WAbld_xls
WAcap_xls

ELWAfDem_reg(trun,f,c,r,ksec)    Fuel consumption by Power and Water sectors by region [MMBBL-TBTU-MMtons]
ELWAfDem_agg(trun,f,c,ksec)      Fuel consumption by Power and Water sectors by country [MMBBL-TBTU-MMtons]

ELWAfCon_reg(trun,f,c,r,ksec)    Fuel consumption by Power and Water sectors by region [TBTU]
ELWAfCon_agg(trun,f,c,ksec)      Fuel consumption by Power and Water sectors by country [TBTU]
ELWAfCon_tot(trun,f,c)           Fuel consumption by country [TBTU]

ELWAfCon_tech

ELWAbld_reg                      Addition of power and cogeneration plants by region in GW
ELWAbld_agg                      Addition of power and cogeneration plants by country in GW
ELWAbld_tot(trun,c)              Total addition of power plants by country in GW

ELWAcap_reg                      Installed power and cogeneration capacity in GW by technology and region [GW]
ELWAcap_agg                      Installed power and cogeneration capacity in GW by technology and country [GW]
ELWAcap_tot(trun,c,ksec)         Installed cumulative power and cogeneration capacity in GW by country [GW]

ELWAdemand_ELd                   Electricity demand by load segment
ELWApwrdemand_ELd                Power demand by load segment [GW]
ELWAdemand_reg                   Electricity demand by power and water sectors by region in TWh
ELWAdemand_agg                   Electricity demand by power and water sectors by country in TWh
ELWAdemand_tot(trun,c)           Total electricity demand by country in TWh

ELWAsupELp_reg                       Electricity supply by technology [TWh]
ELWAsupELp_ELp                   Electricity by technology and country
ELWAsupELp_ELf                   Electricity supply by technology by region [TWh]
ELWAsupELp_ELl                   Electricity supply by fuel and load segment
ELWAsupELp_ELd                   by
ELWAsupELp_agg                   Electricity supply by country and sector [TWh]
ELWAsupELp_tot                      Electricity supplied by country

ELtrans_reg(c,r,cc,rr,trun)              Electricity transmission by region [TWh]


ELpeakdem(trun,rr,cc)                    Peak load in GW by region
ELpeakdem_agg(trun,cc)                   Cumulative peak load in GW by country

ELNgsShare_reg(Elf,trun,r,c)             Natural gas's share in fuels used in power generation in energy terms by region
ELNgsShare(Elf,trun,c)                   Natural gas's share in fuels used in power generation in energy terms by country

ELAvgPwrGenEff_reg(trun,r,c)             Weighted average thermal efficiency in power generation by region-country
ELAvgPwrGenEff(trun,c)                   Weighted average thermal efficiency in power generation by country
ELAvgPwrGenEffSeason_reg(ELs,trun,r,c)   Seasonal weighted average thermal efficiency in power generation by region-country
ELAvgPwrGenEffSeason(ELs,trun,c)         Seasonal weighted average thermal efficiency in power generation by country

ELpowerdem(trun,ELl,ELs,ELday,r,c)       Total power demand in GW
ELREdem_ELl(trun,ELl,ELs,ELday,r,c)      Residential power demand in GW
*ELREdem_reg(trun,c,r)                    Residential power demand in GW

ELWAtariff_del(trun,c,r,ELl,ELs,Elday)   deregulated electricity tariff cents per kWh
ELWAtariff_max(trun,c,r)                 max electricity tariff in cents per kWh

ELREcostHH_reg(c,r,trun)                 Total residential electricity cost in MMUSD

ELREpriceHH_ELl(trun,ELl,c,r)            Residential electricity price in USD per MWh
ELREpriceHH_agg(c,r,trun)                Residential electricity price in USD per MWh

*Water Sector
*===============================================================================
WAcapSin_reg(trun,WAp,c,r,ksec)          Capacity of water-only plants by technology and region in MMm3
WAcapSin_agg(trun,WAp,c,ksec)            Capacity of water-only plants by technology and country in MMm3
WAcapSin_tot(trun,c,ksec)                Capacity of water-only plants by country in MMm3

WAbld_reg(trun,WApSingle,c,r,ksec)       Addition of water-only plants by technology and region in MMm3
WAbld_agg(trun,WApSingle,c,ksec)         Addition of water-only plants by technology and country in MMm3
WAbld_tot(trun,c,ksec)                   Addition of water-only plants by country in MMm3
;

* =============== reports ==================

* Fuel consumption in electricity sector in physical units
ELWAfDem_reg(trun,f,c,r,'EL') = sum(ELpd,ELfconsump.l(ELpd,f,trun,r,c)$rc(r,c))$ELf(f);
ELWAfDem_agg(trun,f,c,'EL') = sum((r,ELpd)$rc(r,c),ELfconsump.l(ELpd,f,trun,r,c))$ELf(f);

* Fuel consumption in electricity sector in energy (TBTU) units
ELWAfCon_reg(trun,f,c,r,'EL') = sum(ELpd,ELfconsump.l(ELpd,f,trun,r,c)$rc(r,c)*Fuelencon1(f))$ELf(f);
ELWAfCon_agg(trun,f,c,'EL') = sum((r,ELpd)$rc(r,c),ELfconsump.l(ELpd,f,trun,r,c)*Fuelencon1(f))$ELf(f);

* fuel consumed by water sector in physical units
ELWAfDem_reg(trun,f,c,r,'WA') = WAfconsump.l(f,trun,r,c)$WAf(f);
ELWAfDem_agg(trun,f,c,'WA') = sum(r$rc(r,c), WAfconsump.l(f,trun,r,c)$WAf(f) );

* fuel consumed by water sector in energy (TBTU) units
ELWAfCon_reg(trun,f,c,r,'WA') = WAfconsump.l(f,trun,r,c)$WAf(f)*Fuelencon1(f);
ELWAfCon_agg(trun,f,c,'WA') = sum(r$rc(r,c), WAfconsump.l(f,trun,r,c)$WAf(f)*Fuelencon1(f) );

* fuel consumed by power and water sectors in energy (TBTU) units
ELWAfCon_tot(trun,f,c)= sum(ksec, ELWAfCon_agg(trun,f,c,ksec) );
ELWAfcon_xls(c,trun,f)=ELWAfCon_tot(trun,f,c);

* fuel consumed by technology

ELWAfCon_tech(trun,f,ELpd,c)= sum(r$rc(r,c),ELfconsump.l(ELpd,f,trun,r,c));
ELWAfCon_tech(trun,f,'Cogen',c)= sum(r$rc(r,c),WAfconsump.l(f,trun,r,c));


* fuel transported to demand side
Fup_Other(trun,fup,c)$(Fuelencon1(fup)>0)=  ( sum((r,ss)$rc(r,c), fuelsupmax(fup,trun,r,c,ss) )
 -sum((r,rr,cc),ftrans.l(fup,trun,r,c,rr,cc)$(rc(r,c)))

 )/Fuelencon1(fup);

* addition of power and cogeneration capacity in GW
ELWAbld_reg(trun,ELp,c,r,'EL')$rc(r,c)=0;
ELWAbld_reg(trun,WAp,c,r,'WA')$rc(r,c)=0;
ELWAbld_reg(trun,ELpd,c,r,'EL')= sum(v, ELbld.l(ELpd,v,trun,r,c)$rc(r,c) );
ELWAbld_reg(trun,ELpsw,c,r,'EL')= sum(v, ELrenbld.l(ELpsw,v,trun,r,c)$rc(r,c) );
ELWAbld_reg(trun,WApCO,c,r,'WA')= sum(v, WAbld.l(WApCO,v,trun,r,c)$rc(r,c) );

ELWAbld_agg(trun,ELp,c,'EL')= sum(r$rc(r,c), ELWAbld_reg(trun,ELp,c,r,'EL') );
ELWAbld_agg(trun,WApCO,c,'WA')= sum(r$rc(r,c), ELWAbld_reg(trun,WApCO,c,r,'WA') );
ELWAbld_tot(trun,c)= sum((ksec,WApCO)$ksec('WA'), ELWAbld_agg(trun,WApCO,c,ksec) )
                    +sum((ksec,ELp)$ksec('EL'), ELWAbld_agg(trun,ELp,c,ksec) );


ELWAbld_xls(c,trun,ELp)=ELWAbld_agg(trun,ELp,c,'EL');
ELWAbld_xls(c,trun,WApCo)=ELWAbld_agg(trun,WApCO,c,'WA');

* power plants
ELWAcap_reg(trun,ELpd,c,r,'EL')$rc(r,c) =
         sum(v, sum(ELpp,ELcapadd(ELpp,ELpd)*ELbld.l(ELpp,v,trun,r,c)$rc(r,c))+
                         ELexistcp.l(ELpd,v,trun,r,c)$rc(r,c));

ELWAcap_reg(trun,ELpsw,c,r,'EL')$rc(r,c) =
         sum(v, ELrenbld.l(ELpsw,v,trun,r,c)$rc(r,c)+
                ELrenexistcp.l(ELpsw,v,trun,r,c)$rc(r,c));

* thermal cogeneration (GW)
ELWAcap_reg(trun,WApCO,c,r,'WA')$rc(r,c)= sum(v, WAbld.l(WApCO,v,trun,r,c)
                                          +WAexistcp.l(WApCo,v,trun,r,c)
                                          +WAaddition(WApCo,v,trun,r,c)
                                          -WAretirement(WApCo,v,trun,r,c) );

ELWAcap_agg(trun,ELp,c,'EL') = sum(r$rc(r,c), ELWAcap_reg(trun,ELp,c,r,'EL'));
ELWAcap_agg(trun,WApCO,c,'WA')=sum(r$rc(r,c), ELWAcap_reg(trun,WApCO,c,r,'WA') );

ELWAcap_tot(trun,c,'EL') = sum(ELp, ELWAcap_agg(trun,ELp,c,'EL'));
ELWAcap_tot(trun,c,'WA') = sum(WApCO, ELWAcap_agg(trun,WApCO,c,'WA') );

ELWAcap_xls(c,trun,ELp)=ELWAcap_agg(trun,ELp,c,'EL');
ELWAcap_xls(c,trun,WApCO)=ELWAcap_agg(trun,WApCO,c,'WA');


* water only (MMm3)
WAbld_reg(trun,WApSingle,c,r,'WA')=  sum(v, WAbld.l(WApSingle,v,trun,r,c)$rc(r,c) );
WAbld_agg(trun,WApSingle,c,'WA')= sum(r$rc(r,c),WAbld_reg(trun,WApSingle,c,r,'WA') );
WAbld_tot(trun,c,'WA')= sum(WApSingle, WAbld_agg(trun,WApSingle,c,'WA') );

WAcapSin_reg(trun,WApSingle,c,r,'WA')$rc(r,c) = sum(v, WAbld.l(WApsingle,v,trun,r,c)+
                             WAexistcp.l(WApsingle,v,trun,r,c)+
                             WAaddition(WApsingle,v,trun,r,c)-
                             WAretirement(WApsingle,v,trun,r,c));

WAcapSin_agg(trun,WApSingle,c,'WA')= sum(r$rc(r,c), WAcapSin_reg(trun,WApSingle,c,r,'WA') );
WAcapSin_tot(trun,c,'WA')= sum(WApSingle, WAcapSin_agg(trun,WApSingle,c,'WA') );

WAbld_xls(c,trun,WApsingle)=WAbld_agg(trun,WApSingle,c,'WA');
WAcap_xls(c,trun,WApsingle)=WAcapSin_agg(trun,WApSingle,c,'WA');

* Electricity demand
* ===================

ELWAdemand_ELd(trun,ELl,ELs,ELday,c,r,'EL')$rc(r,c)=
  ELlchours(ELl,c)*ELdaysinseason(ELs,ELday)*ELlcgw(ELl,ELs,ELday,r,c)*ELdemgro(trun,r,c)
* +ELRElcgw.l(ELl,ELs,ELday,trun,r,c)*ELlchours(ELl,c)*ELdaysinseason(ELs,ELday)
;

ELWApwrdemand_ELd(trun,ELl,ELs,ELday,r,c)=
  ELlcgw(ELl,ELs,ELday,r,c)
* +ELRElcgw.l(ELl,ELs,ELday,trun,r,c)
;

ELWAdemand_reg(trun,c,r,'EL')$rc(r,c)=
  sum((ELl,ELs,ELday), ELlchours(ELl,c)*ELdaysinseason(ELs,ELday)*ELlcgw(ELl,ELs,ELday,r,c)*ELdemgro(trun,r,c))
* +sum((ELl,ELs,ELday),ELRElcgw.l(ELl,ELs,ELday,trun,r,c)*ELlchours(ELl,c)*ELdaysinseason(ELs,ELday))
;

ELWAdemand_reg(trun,c,r,'WA')$rc(r,c)= sum((Ell,ELs,ELday),WAELconsump.l(ELl,ELs,ELday,trun,r,c));

ELWAdemand_agg(trun,c,'EL')= sum(r, ELWAdemand_reg(trun,c,r,'EL') );
ELWAdemand_agg(trun,c,'WA')= sum(r, ELWAdemand_reg(trun,c,r,'WA') );

*ELWAdemand_tot(trun,c)=
*  sum((ELl,ELs,ELday,r,rr,cc)$(rc(r,c) and rc(rr,cc)), Eltransyield(r,c,rr,cc)*ELtrans.l(ELl,ELs,ELday,trun,r,c,rr,cc) );



* Electricity supply
* ==================
* Electricity supply by technology by region (TWh)
ELWAsupELp_reg(trun,ELpd,c,r,'EL')=
   sum((v,ELl,ELs,ELday,ELf)$(Elfuelburn(ELpd,v,ELf,r,c)>0 and ELpcom(ELpd)),ELop.l(ELpd,v,ELl,ELs,ELday,ELf,trun,r,c));

ELWAsupELp_reg(trun,ELps,c,r,'EL')=
   sum((v,ELl,ELs,ELday),ELsolop.l(ELps,v,ELl,ELs,ELday,trun,r,c));

ELWAsupELp_reg(trun,ELpw,c,r,'EL')=
   sum((v,ELl,ELs,ELday),ELwindop.l(ELpw,v,ELl,ELs,ELday,trun,r,c));


ELWAsupELp_reg(trun,WApf,c,r,'WA')$rc(r,c)=
   sum((v,ELl,ELs,ELday,WAf)$(WAfuelburn(WApf,v,WAf,r,c)>0),
      WAFop.l(WApf,v,WAf,trun,r,c)*(1-WAyield(WApf,v,r,c)*WAelrate(WApF,v))*ELnormhours(ELl,ELs,ELday,c))

;

ELWAsupELp_reg(trun,WApv,c,r,'WA')$rc(r,c)=
   sum((v,opm,ELl,ELs,ELday,WAf)$(WAVfuelburn(WApV,v,WAf,opm,r,c)>0),
      WAVop.l(WApV,v,ELl,ELs,ELday,WAf,opm,trun,r,c)*(1-WAVyield(WApV,v,opm,r,c)*WAelrate(WApV,v)));

*$ontext
* sum up regions in ELWAsupELp_reg to show technology by sector and country
ELWAsupELp_ELp(trun,ELpd,c,'EL')=
   sum((v,r,ELl,ELs,ELday,ELf)$(Elfuelburn(ELpd,v,ELf,r,c)>0 and ELpcom(ELpd)),ELop.l(ELpd,v,ELl,ELs,ELday,ELf,trun,r,c))
* added
+sum((v,r,ELl,ELs,ELday,ELf)$(Elfuelburn(ELpd,v,ELf,r,c)>0 and ELpcom(ELpd)),ELop_trade.l(ELpd,v,ELl,ELs,ELday,ELf,trun,r,c))
;

ELWAsupELp_ELP(trun,ELps,c,'EL')=
   sum((v,r,ELl,ELs,ELday),ELsolop.l(ELps,v,ELl,ELs,ELday,trun,r,c));

ELWAsupELp_ELp(trun,ELpw,c,'EL')=
   sum((v,r,ELl,ELs,ELday),ELwindop.l(ELpw,v,ELl,ELs,ELday,trun,r,c));

ELWAsupELp_ELp(trun,WApf,c,'WA')=
   sum((v,r,ELl,ELs,ELday,WAf)$(WAfuelburn(WApf,v,WAf,r,c)>0),
      WAFop.l(WApf,v,WAf,trun,r,c)*(1-WAyield(WApf,v,r,c)*WAelrate(WApF,v))*ELnormhours(ELl,ELs,ELday,c))
+   sum((v,r,ELl,ELs,ELday,WAf)$(WAfuelburn(WApf,v,WAf,r,c)>0),
      WAFop_trade.l(WApf,v,WAf,trun,r,c)*(1-WAyield(WApf,v,r,c)*WAelrate(WApF,v))*ELnormhours(ELl,ELs,ELday,c))

;

ELWAsupELp_ELp(trun,WApv,c,'WA')=
   sum((v,r,opm,ELl,ELs,ELday,WAf)$(WAVfuelburn(WApV,v,WAf,opm,r,c)>0),
      WAVop.l(WApV,v,ELl,ELs,ELday,WAf,opm,trun,r,c)*(1-WAVyield(WApV,v,opm,r,c)*WAelrate(WApV,v)))
+   sum((v,r,opm,ELl,ELs,ELday,WAf)$(WAVfuelburn(WApV,v,WAf,opm,r,c)>0),
      WAVop_trade.l(WApV,v,ELl,ELs,ELday,WAf,opm,trun,r,c)*(1-WAVyield(WApV,v,opm,r,c)*WAelrate(WApV,v)))
;

* show by country and sector
ELWAsupELp_agg(trun,c,r,'EL')=
   sum(ELpd,ELWAsupELp_reg(trun,ELpd,c,r,'EL'))
  +sum(ELps,ELWAsupELp_reg(trun,ELps,c,r,'EL'))
  +sum(ELpw,ELWAsupELp_reg(trun,ELpw,c,r,'EL'))
;
ELWAsupELp_agg(trun,c,r,'WA')$rc(r,c)=
   sum(WApf,ELWAsupELp_reg(trun,WApf,c,r,'WA'))
  +sum(WApv,ELWAsupELp_reg(trun,WApv,c,r,'WA'));

* show by fuel type

ELWAsupELp_ELf(trun,ELpd,ELf,c,r,'EL')=
   sum((v,ELl,ELs,ELday)$(Elfuelburn(ELpd,v,ELf,r,c)>0 and ELpcom(ELpd)),ELop.l(ELpd,v,ELl,ELs,ELday,ELf,trun,r,c));

ELWAsupELp_ELf(trun,ELps,ELfsol,c,r,'EL')=
   sum((v,ELl,ELs,ELday),ELsolop.l(ELps,v,ELl,ELs,ELday,trun,r,c));

ELWAsupELp_ELf(trun,ELpw,ELfwin,c,r,'EL')=
   sum((v,ELl,ELs,ELday),ELwindop.l(ELpw,v,ELl,ELs,ELday,trun,r,c));

ELWAsupELp_ELf(trun,WApf,WAf,c,r,'WA')$rc(r,c)=
   sum((v,ELl,ELs,ELday)$(WAfuelburn(WApf,v,WAf,r,c)>0),
      WAFop.l(WApf,v,WAf,trun,r,c)*(1-WAyield(WApf,v,r,c)*WAelrate(WApF,v))*ELnormhours(ELl,ELs,ELday,c));

ELWAsupELp_ELf(trun,WApv,WAf,c,r,'WA')$rc(r,c)=
   sum((v,opm,ELl,ELs,ELday)$(WAVfuelburn(WApV,v,WAf,opm,r,c)>0),
      WAVop.l(WApV,v,ELl,ELs,ELday,WAf,opm,trun,r,c)*(1-WAVyield(WApV,v,opm,r,c)*WAelrate(WApV,v)));

* do not sum up by ELl to show technology and fuel by load segment
ELWAsupELp_ELl(trun,ELl,ELpd,ELf,c,r,'EL')=
   sum((v,ELs,ELday)$(Elfuelburn(ELpd,v,ELf,r,c)>0 and ELpcom(ELpd)),ELop.l(ELpd,v,ELl,ELs,ELday,ELf,trun,r,c));

ELWAsupELp_ELl(trun,ELl,ELps,ELfsol,c,r,'EL')=
   sum((v,ELs,ELday),ELsolop.l(ELps,v,ELl,ELs,ELday,trun,r,c));

ELWAsupELp_ELl(trun,ELl,ELpw,ELfwin,c,r,'EL')=
   sum((v,ELs,ELday),ELwindop.l(ELpw,v,ELl,ELs,ELday,trun,r,c));

ELWAsupELp_ELl(trun,ELl,WApf,WAf,c,r,'WA')$rc(r,c)=
   sum((v,ELs,ELday)$(WAfuelburn(WApf,v,WAf,r,c)>0),
      WAFop.l(WApf,v,WAf,trun,r,c)*(1-WAyield(WApf,v,r,c)*WAelrate(WApF,v))*ELnormhours(ELl,ELs,ELday,c));

ELWAsupELp_ELl(trun,ELl,WApv,WAf,c,r,'WA')$rc(r,c)=
   sum((v,opm,ELs,ELday)$(WAVfuelburn(WApV,v,WAf,opm,r,c)>0),
      WAVop.l(WApV,v,ELl,ELs,ELday,WAf,opm,trun,r,c)*(1-WAVyield(WApV,v,opm,r,c)*WAelrate(WApV,v)));

* ELS

ELWAsupELp_ELd(trun,ELl,ELs,ELday,ELpd,ELf,c,r,'EL')=
   sum(v$(Elfuelburn(ELpd,v,ELf,r,c)>0 and ELpcom(ELpd)),ELop.l(ELpd,v,ELl,ELs,ELday,ELf,trun,r,c));

ELWAsupELp_ELd(trun,ELl,ELs,ELday,ELps,ELfsol,c,r,'EL')=
   sum(v,ELsolop.l(ELps,v,ELl,ELs,ELday,trun,r,c));

ELWAsupELp_ELd(trun,ELl,ELs,ELday,ELpw,ELfwin,c,r,'EL')=
   sum(v,ELwindop.l(ELpw,v,ELl,ELs,ELday,trun,r,c));

ELWAsupELp_ELd(trun,ELl,ELs,ELday,WApf,WAf,c,r,'WA')$rc(r,c)=
   sum(v$(WAfuelburn(WApf,v,WAf,r,c)>0),
      WAFop.l(WApf,v,WAf,trun,r,c)*(1-WAyield(WApf,v,r,c)*WAelrate(WApF,v))*ELnormhours(ELl,ELs,ELday,c));

ELWAsupELp_ELd(trun,ELl,ELs,ELday,WApv,WAf,c,r,'WA')$rc(r,c)=
   sum((v,opm)$(WAVfuelburn(WApV,v,WAf,opm,r,c)>0),
      WAVop.l(WApV,v,ELl,ELs,ELday,WAf,opm,trun,r,c)*(1-WAVyield(WApV,v,opm,r,c)*WAelrate(WApV,v)));

ELWAsupELp_agg(trun,c,r,'EL')$rc(r,c)=
   sum((ELpd,ELf), ELWAsupELp_ELf(trun,ELpd,ELf,c,r,'EL'))
  +sum((ELps,ELfsol),ELWAsupELp_ELf(trun,ELps,ELfsol,c,r,'EL'))
  +sum((ELpw,ELfwin),ELWAsupELp_ELf(trun,ELpw,ELfwin,c,r,'EL'))
;
ELWAsupELp_agg(trun,c,r,'WA')$rc(r,c)=
   sum((WAPf,WAf),ELWAsupELp_ELf(trun,WApf,WAf,c,r,'WA'))
  +sum((WApv,WAf),ELWAsupELp_ELf(trun,WApv,WAf,c,r,'WA'));

ELWAsupELp_xls(c,trun,ELp)=
   ELWAsupELp_ELp(trun,ELp,c,'EL')
;
*  +ELWAsupELp_ELP(trun,ELp,c,'EL')
*  +ELWAsupELp_ELP(trun,ELpw,c,'EL');

ELWAsupELp_xls(c,trun,WAp)=
   ELWAsupELp_ELp(trun,WAp,c,'WA');
*  +ELWAsupELp_ELp(trun,WApv,c,'WA');

*ELWAsupELp_tot(trun,c)=  sum((ELl,ELs,ELday,r,rr,cc)$(rc(r,c) and rc(rr,cc)),ELtrans.l(ELl,ELs,ELday,trun,r,c,rr,cc));

*$offtext

* correct reports for electricity production and consumption

ELWAsupELp(trun,r,c)$rc(r,c)=
  sum((ELpd,v,ELf,ELl,ELs,ELday),ELop.l(ELpd,v,ELl,ELs,ELday,ELf,trun,r,c))
 +sum((ELpd,v,ELf,ELl,ELs,ELday),ELop_trade.l(ELpd,v,ELl,ELs,ELday,ELf,trun,r,c))
 +sum((ELps,v,ELl,ELs,ELday),ELsolop.l(ELps,v,ELl,ELs,ELday,trun,r,c))
 +sum((ELpw,v,ELl,ELs,ELday),ELwindop.l(ELpw,v,ELl,ELs,ELday,trun,r,c))
* -sum((Ell,ELs,ELday),WAELconsump.l(ELl,ELs,ELday,trun,r,c))
;

ELWAsupWAp(trun,r,c)$rc(r,c)= sum((ELl,ELs,ELday),WAELsupply.l(ELl,ELs,ELday,trun,r,c));
ELWAconsumpWAp(trun,r,c)$rc(r,c)= sum((ELl,ELs,ELday), WAELconsump.l(ELl,ELs,ELday,trun,r,c));
ELWAsup_tot(trun,c)=   sum(r$rc(r,c),ELWAsupELp(trun,r,c) + ELWAsupWAp(trun,r,c)
 -ELWAconsumpWAp(trun,r,c)
);

ELWAtrans(trun,c)=
  sum((ELl,ELs,ELday,r,rr,cc)$(rc(r,c) and rc(rr,cc) ),TRnodaltrans.l(ELl,ELs,ELday,trun,r,c,rr,cc))
 -sum((ELl,ELs,ELday,r,rr,cc)$(rc(r,c) and rc(rr,cc) ),TRnodaltrans.l(ELl,ELs,ELday,trun,rr,cc,r,c))
 +sum((ELl,ELs,ELday,r),ELsupply.l(ELl,ELs,ELday,trun,r,c))
;

*ELWAtrans(trun,c)=sum((ELl,ELs,ELday,r,rr,cc)$(rc(r,c) and rc(rr,cc)),ELtrans.l(ELl,ELs,ELday,trun,r,c,rr,cc));

* Electricity Peak Demand
ELpeakdem(trun,rr,cc) = (ELlcgwmax(rr,cc)*ELdemgro(trun,rr,cc)
* +WAELpwrdemand.l(trun,rr,cc)+PCELpwrdemand.l(trun,rr,cc)
 )$rc(rr,cc);

ELpeakdem_agg(trun,cc) = sum(rr$rc(rr,cc),ELpeakdem(trun,rr,cc)) ;

ELWAtariff_del(trun,c,r,ELl,ELs,Elday)$rc(r,c)= DELsup.l(ELl,ELs,Elday,trun,r,c)/10;
ELWAtariff_max(trun,c,r)=smax((ELl,ELs,Elday),ELWAtariff_del(trun,c,r,ELl,ELs,Elday));

$ontext
*Units for emissions factors in million metric tons of CO2 per TWh_e produced.
* IEA CO2 Emissions from Fuel Combustion: Highlights (2013, p. 43)
ELco2factors('Coal')=0.860;
ELco2factors('Arablight')=0.635;
ELco2factors('methane')=0.400;
ELco2factors('diesel')=0.715;
ELco2factors('HFO')=0.670;

ELco2emit(trun)=sum((ELpd,ELl,ELs,Elday,ELf,v,r),ELco2factors(ELf)*ELop.l(ELpd,v,ELl,ELs,ELday,ELf,trun,r));
$offtext

* electricity demand
option ELWAdemand_reg:3:3:1;
option ELWAdemand_agg:3:2:1;
option ELWAdemand_tot:3:1:1;
option ELpowerdem:2:4:2;
option ELREdem_Ell:2:4:2;

* electricity supply by technology
option ELop:3:0:1;
*option ELtrans:3:0:1;
option ELWAtrans:3:0:1;

option ELWAsupELp_reg:3:4:1;
*$ontext
option ELWAsupELp_ELp:3:3:1;
option ELWAsupELp_ELf:3:5:1;
option ELWAsupELp_ELl:3:6:1;
option ELWAsupELp_ELd:3:0:1;
option ELWAsupELp_agg:3:3:1;
*option ELWAsupELp_tot:3:1:1;
option ELWAsupELp_xls:3:1:1;
option ELWAbld_xls:3:1:1;
option ELWAcap_xls:3:1:1;
option ELWAfcon_xls:3:1:1;
option WAbld_xls:3:1:1;
option WAcap_xls:3:1:1;

*$offtext

option ELWAfDem_reg:3:4:1;
option ELWAfDem_agg:3:3:1;
option ELWAfCon_reg:3:4:1;
option ELWAfCon_agg:3:3:1;
option ELWAfCon_tot:3:2:1;
option ELWAfCon_tech:3:3:1;

option ELWAcap_reg:3:4:1;
option ELWAcap_agg:3:3:1;
option ELWAcap_tot:3:2:1;
option ELWAbld_reg:3:4:1;
option ELWAbld_agg:3:3:1;
option ELWAbld_tot:3:1:1;

*option ELREdem_reg:1:1:1;
option ELWAtariff_del:2:0:1;
option ELWAtariff_max:2:0:1;
option ELREcostHH_reg:2:2:1;
option ELREpriceHH_ELl:3:2:2;
option ELREpriceHH_agg:3:2:1;

* water
* =====
option WAbld_reg:3:4:1;
option WAbld_agg:3:3:1;
option WAbld_agg:3:2:1;
option WAcapSin_reg:3:4:1;
option WAcapSin_agg:3:3:1;
option WAcapSin_tot:3:2:1;

option delsup:3:0:1;
option deldem:3:0:1;
option waelconsump:3:0:1;
option WAfop:3:0:1;
option WAvop:3:0:1;
*display delsup.l,deldem.l,waelconsump.l,WAfop.l,WAvop.l;

display
* power
ELpeakdem,
ELpeakdem_agg,
ELWAdemand_reg,
ELWAdemand_agg,
*ELWAdemand_tot,

ELWAsupELp
ELWAsupWAp
ELWAconsumpWAp
ELWAsup_tot
ELWAtrans
ELop.l

ELWAsupELp_reg,
ELWAsupELp_ELp,
ELWAsupELp_ELl,
ELWAsupELp_ELd,
ELWAsupELp_agg,
ELWAsupELp_ELf,
*ELWAsupELp_tot,
ELWAsupELp_xls,
ELWAbld_xls,
ELWAcap_xls,
ELWAfcon_xls,
WAbld_xls,
WAcap_xls,

ELWAfDem_reg,
ELWAfDem_agg,
ELWAfCon_reg,
ELWAfCon_agg,
ELWAfCon_tot,
ELWAfCon_tech,
ELWAbld_reg,
ELWAbld_agg,
ELWAbld_tot,
ELWAcap_reg,
ELWAcap_agg,
ELWAcap_tot

ELWAtariff_del,
ELWAtariff_max,

* water
WAbld_reg,
WAbld_agg,
WAbld_tot,
WAcapSin_reg,
WAcapSin_agg,
WAcapSin_tot,

* other
waelrate,
wayield,
wafuelburn,
ftrans.l,
fueluse.l,
fexports.l,
OTHERfconsump,
ftransexist
;

