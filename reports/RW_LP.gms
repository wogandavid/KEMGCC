* report writer for LP
display z.l;

parameter
ELWAsupELp_ELp                   electricity supplied by technology
ELWAsupELp_tot(trun,c)           electricity supplied and transmitted

ELWAbld_reg                      Addition of power and cogeneration plants by region in GW
ELWAbld_agg                      Addition of power and cogeneration plants by country in GW
ELWAbld_tot(trun,c)              Total addition of power plants by country in GW
WAbld_reg(trun,WApSingle,c,r,ksec)       Addition of water-only plants by technology and region in MMm3
WAbld_agg(trun,WApSingle,c,ksec)         Addition of water-only plants by technology and country in MMm3
WAbld_tot(trun,c,ksec)                   Addition of water-only plants by country in MMm3


ELWAfCon_reg(trun,f,c,r,ksec)    Fuel consumption by Power and Water sectors by region [TBTU]
ELWAfCon_agg(trun,f,c,ksec)      Fuel consumption by Power and Water sectors by country [TBTU]
ELWAfCon_tot(trun,f,c)           Fuel consumption by country [TBTU]

ELWAsupELp_xls
ELWAbld_xls
ELWAfcon_xls
;

* sum up regions in ELWAsupELp_reg to show technology by sector and country
ELWAsupELp_ELp(trun,ELpd,c,'EL')=
   sum((v,r,ELl,ELs,ELday,ELf)$(Elfuelburn(ELpd,v,ELf,r,c)>0 and ELpcom(ELpd)),ELop.l(ELpd,v,ELl,ELs,ELday,ELf,trun,r,c));

ELWAsupELp_ELP(trun,ELps,c,'EL')=
   sum((v,r,ELl,ELs,ELday),ELsolop.l(ELps,v,ELl,ELs,ELday,trun,r,c));

ELWAsupELp_ELp(trun,ELpw,c,'EL')=
   sum((v,r,ELl,ELs,ELday),ELwindop.l(ELpw,v,ELl,ELs,ELday,trun,r,c));

ELWAsupELp_ELp(trun,WApf,c,'WA')=
   sum((v,r,ELl,ELs,ELday,WAf)$(WAfuelburn(WApf,v,WAf,r,c)>0),
      WAFop.l(WApf,v,WAf,trun,r,c)*(1-WAyield(WApf,v,r,c)*WAelrate(WApF,v))*ELnormhours(ELl,ELs,ELday,c));

ELWAsupELp_ELp(trun,WApv,c,'WA')=
   sum((v,r,opm,ELl,ELs,ELday,WAf)$(WAVfuelburn(WApV,v,WAf,opm,r,c)>0),
      WAVop.l(WApV,v,ELl,ELs,ELday,WAf,opm,trun,r,c)*(1-WAVyield(WApV,v,opm,r,c)*WAelrate(WApV,v)));

ELWAsupELp_tot(trun,c)=  sum((ELl,ELs,ELday,r,rr,cc)$(rc(r,c) and rc(rr,cc)),ELtrans.l(ELl,ELs,ELday,trun,r,c,rr,cc));


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

* Fuel consumption in electricity sector in energy (TBTU) units
ELWAfCon_reg(trun,f,c,r,'EL') = sum(ELpd,ELfconsump.l(ELpd,f,trun,r,c)$rc(r,c)*Fuelencon1(f))$ELf(f);
ELWAfCon_agg(trun,f,c,'EL') = sum((r,ELpd)$rc(r,c),ELfconsump.l(ELpd,f,trun,r,c)*Fuelencon1(f))$ELf(f);

* fuel consumed by water sector in energy (TBTU) units
ELWAfCon_reg(trun,f,c,r,'WA') = WAfconsump.l(f,trun,r,c)$WAf(f)*Fuelencon1(f);
ELWAfCon_agg(trun,f,c,'WA') = sum(r$rc(r,c), WAfconsump.l(f,trun,r,c)$WAf(f)*Fuelencon1(f) );

* fuel consumed by power and water sectors in energy (TBTU) units
ELWAfCon_tot(trun,f,c)= sum(ksec, ELWAfCon_agg(trun,f,c,ksec) );


ELWAsupELp_xls(c,trun,ELp)=
   ELWAsupELp_ELp(trun,ELp,c,'EL');
*  +ELWAsupELp_ELP(trun,ELp,c,'EL')
*  +ELWAsupELp_ELP(trun,ELpw,c,'EL');

ELWAsupELp_xls(c,trun,WAp)=
   ELWAsupELp_ELp(trun,WAp,c,'WA');
*  +ELWAsupELp_ELp(trun,WApv,c,'WA');

WAbld_reg(trun,WApSingle,c,r,'WA')=  sum(v, WAbld.l(WApSingle,v,trun,r,c)$rc(r,c) );
WAbld_agg(trun,WApSingle,c,'WA')= sum(r$rc(r,c),WAbld_reg(trun,WApSingle,c,r,'WA') );
WAbld_tot(trun,c,'WA')= sum(WApSingle, WAbld_agg(trun,WApSingle,c,'WA') );

$ontext
option ELWAsupELp_xls:3:1:1;
option ELWAbld_xls:3:1:1;
option ELWAfcon_xls:3:1:1;
$offtext
option ELWAsupELp_ELp:3:3:1;
option ELWAsupELp_tot:3:1:1;
option ELWAfCon_reg:3:4:1;
option ELWAfCon_agg:3:3:1;
option ELWAfCon_tot:3:2:1;
option ELWAbld_reg:3:4:1;
option ELWAbld_agg:3:3:1;
option ELWAbld_tot:3:1:1;
option WAbld_reg:3:0:1;
option WAbld_agg:3:0:1;
option WAbld_tot:3:0:1;

display
$ontext
ELWAsupELp_xls
ELWAbld_xls
ELWAcap_xls
ELWAfcon_xls
$offtext
ELWAsupELp_ELp
ELWAsupELp_tot
ELWAfCon_reg
ELWAfCon_agg
ELWAfCon_tot
ELWAbld_reg
ELWAbld_agg
ELWAbld_tot
WAbld_reg
WAbld_agg
WAbld_tot
;
