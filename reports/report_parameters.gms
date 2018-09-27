* parameters for simple report

parameter
obj_value(trun,c) objective value

ELWAbld_xls build of power generation technology
ELWAsupELp(trun,r,c) electricity production from power (total)
ELWAsupWAp(trun,r,c) electricity production from water (total)
ELWAsup_tot(trun,c) total electricity supplied to grid (net of WA consumption)
ELWAconsumpWAp(trun,r,c) electricity consumption by water sector (total)
RWELtrans_tot(trun,r,c,rr,cc) electricity trans
RWELtrade_tot(trun,c,cc) annual trade between countries
RWELtrade_ELl(trun,ELl,ELs,c,cc) load segment transmission on interconnector
RWELtrade_demanded(trun,cc) total electricity supplied to rr
RWELdemand(trun,cc,rr) load curve demand
ELWAsupELp_ELp intermediate report for electricity production
ELWAsupELp_xls electricity production by technology
ELWAfcon_xls(c,trun,f) fuel consumption (total)
ELWAfcon_trade(c,trun,f) fuel consumed for gcc grid activity
ELWAfcon_tot(trun,c,f)

ELWAbld_reg intermediate build parameter

ELWAsupELp_reg

RWEMquant    emissions by sector in tons
RWEMallquant emissions of all sectors in tons

ELWAcap capacity of power and cogen plants

RWcaputil  capacity utilization

WAcapSingle capacity of water only plants
WAbld_tot build of water only plants

Invest investment in millions USD

Shadowprice(trun,c,r,fup) shadow price of fuels

fuelimports_phys(trun,c,fup)

Fuelexports_TBTU(trun,c,fup) exports of upstream fuels for power or water
Fuelexports_phys(trun,c,fup) exports of upstream fuels for power or water

ELWAfcon_physical(c,trun,f) fuel consumption in physical units

fueltrans(trun,fup,r,c,rr,cc) fuel transport

EMaddlcost(trun,ELf,c)
fRelativecost(trun,ELf,r,c)

excessmethane(trun,f,r,c)

ELWAfcon_sec(trun,f,c,ksec)

transbld(trun,r,c,rr,cc)

ELWAfortrade(trun,c,ELl)

RWDELsup(trun,ELl,ELs,ELday,r,c)

* cost calculations

RWcapex(trun,c)
RWopex(trun,c)
RWfuelex(trun,c)
RWELimportex(trun,c)
RWfimportex(trun,c)
RWELexportrev(trun,c)
RWfexportrev(trun,c)
RWnetex(trun,c)
RWcostcalcs
RWmargencost(trun,c)
;
