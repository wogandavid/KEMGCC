option fueltrans:3:0:1;
option TRnodaltrans:3:0:1
option RWELtrans_tot:3:0:1
option ELsupply:3:0:1
option excessmethane:3:0:1;
option transbld:3:0:1;
option ELWAfortrade:3:0:1;
option ELtrademax:3:0:1;
option RWELtrade_ELl:3:0:1;
option RWDELsup:3:0:1;
option fimports:3:0:1;
option RWcaputil:3:0:1;
*option RWcostcalcs:3:1:1;

display
ELWAsupELp
ELWAsupWAp
ELWAsup_tot
ELWAsupELp_ELp
ELWAsupELp_xls
ELWAfcon_xls
ELWAfcon_trade
ELWAfcon_tot
ELWAfcon_physical
ELWAconsumpWAp
ELWAbld_xls
WAbld_tot
RWcaputil
ELWAcap
WAcapSingle
ELsupply.l
RWELtrans_tot
RWELtrade_tot
RWELtrade_ELl
RWELtrade_demanded
RWELdemand
dfdem.l
RWDELsup
Shadowprice
fimports.l
Fuelexports_TBTU
Fuelexports_phys
Fuelimports_phys
fexports.l
fueltrans
Invest
TRnodaltrans.l
EMaddlcost
fRelativecost
excessmethane
ELWAfcon_sec
transbld
ELWAfortrade
ELtrademax.l
*RWcapex
*RWopex
*RWfuelex
*RWELimportex
*RWfimportex
*RWELexportrev
*RWfexportrev
*RWnetex
*RWcostcalcs
*RWmargencost
*RWcostcalcs
;

* write to excel
execute_unload 'results/MainScenarios/2020_05_12/results_%scenario%.gdx'
ELWAbld_xls
ELWAcap_xls
ELWAsupELp
ELWAsupWAp
ELWAsup_tot
ELWAconsumpWAp
RWELtrans_tot
RWELtrade_tot
RWELtrade_demanded
RWELdemand
ELWAsupELp_ELp
ELWAsupELp_xls
ELWAfcon_xls
ELWAfcon_trade
ELWAfcon_tot
RWDELsup
RWEMallquant
fimports.l
fexports.l
WAcapSingle
ELWAcap
Invest
Shadowprice
fuelimports_phys
Fuelexports_TBTU
Fuelexports_phys
WAbld_tot
ELWAfcon_physical
fueltrans
fRelativecost
ELWAfcon_sec
*RWcostcalcs
;

*$ontext
if (writetoexcel=1,
execute 'gdxxrw.exe results/results_%scenario%.gdx o=results/results_%scenario%.xlsx par=ELWAbld_xls rng=ELWAbld!A1:Z9999'
execute 'gdxxrw.exe results/results_%scenario%.gdx o=results/results_%scenario%.xlsx par=WAbld_tot rng=WAbld_tot!A1:Z9999'
execute 'gdxxrw.exe results/results_%scenario%.gdx o=results/results_%scenario%.xlsx par=ELWAcap rng=ELWAcap!A1:Z9999'
execute 'gdxxrw.exe results/results_%scenario%.gdx o=results/results_%scenario%.xlsx par=ELWAsup_tot rng=Electricity_tot!A1:Z9999'
execute 'gdxxrw.exe results/results_%scenario%.gdx o=results/results_%scenario%.xlsx par=ELWAsupELp_xls rng=Electricity_tech!A1:Z9999'
execute 'gdxxrw.exe results/results_%scenario%.gdx o=results/results_%scenario%.xlsx par=ELWAfcon_xls rng=ELfuel!A1:Z9999'
execute 'gdxxrw.exe results/results_%scenario%.gdx o=results/results_%scenario%.xlsx par=ELWAfcon_trade rng=ELfuel_trade!A1:Z9999'
execute 'gdxxrw.exe results/results_%scenario%.gdx o=results/results_%scenario%.xlsx par=ELWAfcon_tot rng=ELfuel_tot!A1:Z9999'
execute 'gdxxrw.exe results/results_%scenario%.gdx o=results/results_%scenario%.xlsx par=ELWAfcon_physical rng=ELfuel_phys!A1:Z9999'
execute 'gdxxrw.exe results/results_%scenario%.gdx o=results/results_%scenario%.xlsx par=RWDELsup rng=DELsup!A1:Z9999'
execute 'gdxxrw.exe results/results_%scenario%.gdx o=results/results_%scenario%.xlsx par=excessmethane rng=excessmethane!A1:Z9999'
execute 'gdxxrw.exe results/results_%scenario%.gdx o=results/results_%scenario%.xlsx par=RWELtrans_tot rng=RWELtrans_tot!A1:Z9999'
execute 'gdxxrw.exe results/results_%scenario%.gdx o=results/results_%scenario%.xlsx par=RWELtrade_ELl rng=RWELtrade_ELl!A1:Z9999'
execute 'gdxxrw.exe results/results_%scenario%.gdx o=results/results_%scenario%.xlsx par=ELWAfortrade rng=ELWAfortrade!A1:Z9999'
execute 'gdxxrw.exe results/results_%scenario%.gdx o=results/results_%scenario%.xlsx var=ELtrademax rng=ELtrademax!A1:Z9999'
execute 'gdxxrw.exe results/results_%scenario%.gdx o=results/results_%scenario%.xlsx par=RWELtrade_tot rng=tradetot!A1:Z1000'
execute 'gdxxrw.exe results/results_%scenario%.gdx o=results/results_%scenario%.xlsx par=RWEMallquant rng=CO2!A1:Z9999'
execute 'gdxxrw.exe results/results_%scenario%.gdx o=results/results_%scenario%.xlsx var=transbld rng=transbld!A1:Z9999'
execute 'gdxxrw.exe results/results_%scenario%.gdx o=results/results_%scenario%.xlsx par=Invest rng=Invest!A1:Z9999'
execute 'gdxxrw.exe results/results_%scenario%.gdx o=results/results_%scenario%.xlsx par=Fuelimports_phys rng=Fuelimports_TBTU!A1:Z9999'
execute 'gdxxrw.exe results/results_%scenario%.gdx o=results/results_%scenario%.xlsx par=Fuelexports_TBTU rng=Fuelexports_TBTU!A1:Z9999'
execute 'gdxxrw.exe results/results_%scenario%.gdx o=results/results_%scenario%.xlsx par=Fuelexports_phys rng=Fuelexports_phys!A1:Z9999'

execute 'gdxxrw.exe results/results_%scenario%.gdx o=results/results_%scenario%.xlsx var=fimports rng=imports!A1:Z9999'
execute 'gdxxrw.exe results/results_%scenario%.gdx o=results/results_%scenario%.xlsx var=fexports rng=exports!A1:Z9999'
execute 'gdxxrw.exe results/results_%scenario%.gdx o=results/results_%scenario%.xlsx par=WAcapSingle rng=WAcapSingle!A1:Z9999'
execute 'gdxxrw.exe results/results_%scenario%.gdx o=results/results_%scenario%.xlsx par=Shadowprice rng=Shadowprice!A1:Z9999'
execute 'gdxxrw.exe results/results_%scenario%.gdx o=results/results_%scenario%.xlsx par=fueltrans rng=fueltrans!A1:Z9999'
execute 'gdxxrw.exe results/results_%scenario%.gdx o=results/results_%scenario%.xlsx par=fRelativecost rng=relativecost!A1:Z9999'
)
;
*$offtext

