* This file contains all variables in KEM
* =======================================

positive Variables
capsubsidy(trun) investment subsidy variable
fuelsubsidy(trun) fuel subsidy variable;

variable
z overall objective variable for LP
DELtradebal(trun,ELl,ELs,ELday,c)   dual

;
* trade variables
positive variables
ELfconsump_trade(ELpd,f,trun,r,c) fuel consumed at marginal price for trade
ELop_trade(ELpd,v,ELl,ELs,ELday,f,trun,r,c)  electricity produced for trade

ELtrademax(trun,ELl,ELs,ELday,c) upper bound on electricity sent to GCC grid

*ELtrademax(trun,ELl,ELs,ELday,c) upper bound on electricity sent to GCC grid
DTRtradecap(ELl,ELs,ELday,trun,c)

DELfcons_trade(ELpd,f,trun,r,c)  dual variable for fuel consumption balance
*DELtradebal(trun,ELl,ELs,ELday,c)   dual

$ontext
ELtradesupmax(trun,ELl,ELs,ELday,c) max electricity trade
WAELtradesupmax(trun,ELl,ELs,ELday,c) max electricity trade
$offtext
;


positive variable
WAfconsump_trade(f,trun,r,c) fuel consumption for cogen electricity for trade
WAFop_trade(WApF,v,WAf,trun,r,c) electricity production from cogen for trade
WAVop_trade(WApV,v,ELl,ELs,ELday,WAf,opm,trun,r,c) electricity production from cogen for trade

DWAfcons_trade(WAf,trun,r,c)
;

positive variables
DELtradesup(trun,ELl,ELs,ELday,c)   dual
*DWAELtradesup(trun,ELl,ELs,ELday,c) dual
;

* transmission variables
variable
TRz objective variable

TRpangle(ELl,ELs,ELday,r,c,trun)
DTRpanglebal(ELl,ELs,ELday,r,c,rr,cc,trun)
;

Positive variables


TRopmaint(trun) Operation and maintenance cost for transmission  in million USD
TRcapitalcost(trun) Capital cost for transmission in million USD
TRexistcp(r,c,rr,cc,trun) Existing transmission capacity in GW in time trun
TRbld(r,c,rr,cc,trun) transmission buil in GW
TRnodaltrans(ELl,ELs,ELday,trun,r,c,rr,cc) Electricity transmitted in TWh
ELsupply(ELl,ELs,ELday,trun,r,c) electricity supplied by power plants

*TRtransloss(ELl,ELs,ELday,v,GRn,GRnn,GRvolt,trun,r,rr) Losses in transmission in MW
;

variables
DTRanglebal(ELl,ELs,ELday,trun,r,c,rr,cc)
DTRcapitalcostbal(trun)
DTRopmaintbal(trun)
DTRbldbal(r,c,rr,cc,trun)
;

positive variables
DTRcapbal(r,c,rr,cc,trun)
DTRcaplim(ELl,ELs,ELday,trun,r,c,rr,cc)
DTRdem(ELl,ELs,ELday,trun,r,c)
;

* Power sector
* ============
Variables
ELz  Power objective function LP

DELcapitalcostbal(trun) free dual of Capital purchase cost
DELopmaintbal(trun) free dual of opmaintbal
DELnucconstraint(ELl,ELs,Elday,trun,r,c) free dual variable of the nuclear operation constraint
DELstorenergybal(ELl,ELs,ELday,trun,r,c)
DELstorenergyballast(ELl,ELs,ELday,trun,r,c)
DELrampbal(ELpd,ELl,ELs,ELday,trun,r,c)

*DELcostrecovery(ELl,ELs,ELday,trun,rr,cc) residential sector
;

Positive variables
ELavgcost(ELll,ELs,ELday,trun,r,c) avg cost of electricity USD per MWh

*electricity production activities
ELbld(ELpd,v,trun,r,c)
ELrenbld(ELpsw,v,trun,r,c) for renewable technologies?? new capacity built?
ELexistcp(ELpd,v,trun,r,c) electric existing capacity ???
ELrenexistcp(ELpsw,v,trun,r,c) for renewable technologies ??? existing capacity?
ELop(ELpd,v,ELl,ELs,ELday,ELf,trun,r,c) electric power operating????
ELrampupcst(ELpd,ELl,ELs,ELday,trun,r,c)
ELrampdncst(ELpd,ELl,ELs,ELday,trun,r,c)
ELsolop(ELpsw,v,ELl,ELs,ELday,trun,r,c) solar power operating ????
ELsoloplevel(ELppv,v,trun,r,c) level of non-dispatchable PV utilization in between capacity steps
ELgttocc(Elpd,v,trun,r,c)
ELupspincap(ELpd,v,ELl,ELs,ELday,ELf,trun,r,c)
ELdnspincap(ELpd,v,ELl,ELs,ELday,ELf,trun,r)
ELCSPlandarea(trun,r,c) land collection area used for CSP in km^2

ELheatstorin(ELl,ELs,ELday,trun,r,c) in TWh
ELheatstorout(ELl,ELs,ELday,trun,r,c) in TWh
ELheatstorage(ELl,ELs,ELday,trun,r,c) in TWh
ELheatinstant(ELl,ELs,ELday,trun,r,c) in TWh
ELwindoplevel(ELpw,v,trun,r,c) level of non-dispatchable wind utilization in between capacity steps
ELwindop(ELpsw,v,ELl,ELs,ELday,trun,r,c) operation of wind turbine

ELCapitalCost(trun) Costs in purchase and construction of equipment in USD
ELOpandmaint(trun) Operation and maintenance costs in USD
ELfconsump(ELpd,f,trun,r,c) Fuel consumption by power sector
ELfconsumpcr(f,trun,r,c) Fuel consumption by power sector (cr?)
ELRElcgw(ELl,ELs,ELday,trun,r,c) residential loads in GW

DELcapbal(Elpd,v,trun,r,c) dual of capbal
DELrencapbal(ELpsw,v,trun,r,c)
DELgtconvlim(ELpd,v,trun,r,c) dual of Elgtconvlim
DELcaplim(ELpd,v,ELl,ELs,ELday,trun,r,c) dual of ELcaplim
DELsolcaplim(ELpsw,v,trun,r,c)
DELsolutil(ELpsw,v,ELl,ELs,ELday,trun,r,c)
DELsolcapsum(trun,r,c)
DELupspinres(ELpd,ELl,ELs,ELday,trun,r,c)
DELdnspinres(ELpd,ELl,ELs,ELday,trun,r,c)
DELCSPutil(ELl,ELs,ELday,trun,r,c)
DELsup(ELl,ELs,ELday,trun,r,c) dual of ELsup
DELdem(ELl,ELs,ELday,trun,r,c) dual of DELdem

*DELrsrvreq(trun,r,c) dual of ELrsrvreq
DELrsrvreq(trun) dual of ELrsrvreq

DELtranscapbal(trun,r,c,rr,cc) dual of ELtranscapbal
DELtranscaplim(ELl,ELs,ELday,trun,r,c,rr,cc) dual of ELtranscaplim
DELfcons(ELpd,ELf,trun,r,c)
DELfavail(ELf,trun,r,c) dual of ELfavail
DELfavailcr(ELf,trun,r,c) dual of ELfavail
DELsolenergybal(ELl,ELs,ELday,trun,r,c)
DELCSPcaplim(ELpsw,v,ELl,ELs,ELday,trun,r,c)
DELCSPlanduselim(trun,r,c)
DELwindcaplim(ELpsw,v,trun,r,c)
DELwindutil(ELpw,v,ELl,ELs,ELday,trun,r,c)
DELwindcapsum(trun,r,c) dual from ELwindcapsum
DELrenprodreq(ELpsw,v,trun)
DELnucprodreq(ELpd,v,trun)
DELrenbldreq(ELpsw,v,trun)
* DELbldreq(ELpd,v,trun)
DELbldreq(trun)
DELstorlim(ELpsw,ELl,ELs,ELday,trun,r,c)
DELREdem(ELl,ELs,ELday,trun,r,c)
;

* Upstream sector
* ================================
variables

UPz   Upstream objective function LP

Dfpurchbal(trun) free dual of purchbal
Dfcnstrctbal(trun) free dual of cnstrctbal
Dfopmaintbal(trun) free dual of opmaintbal
Dfrevenuesbal(trun)
DfExportsum(fup,trun,c)

positive Variables
ftrans(f,trun,r,c,rr,cc)
ftransexistcp(fup,trun,r,c,rr,cc)
ftransbld(fup,trun,r,c,rr,cc)
fCapitalCost(trun) Equipment purchased costs in USD (typically imported)
fOpandmaint(trun) Operation and maintenance costs in USD
fueluse(fup,ss,trun,r,c)  Quantity of fuel used by material
fExports(fup,trun,r,c)
fnatexports(fup,trun,c)
fRevenues(trun)

fimports(trun,fup,r,c) import of fuel from external market

Dfuelsup(fup,trun,r,c) free dual of fuelsup
Dfdem(f,trun,rr,cc) dual of fconsump
Dftranscapbal(fup,trun,r,c,rr,cc) fuel transport balance
Dftranscaplim(fup,trun,r,c,rr,cc) fuel transport capacity constraint
;

* Water sector
* ============
Variables
WAz  Water objective function LP

*Dual activities for the MCP
DWApurchbal(trun) free dual of WApurchbal
DWAcnstrctbal(trun) free dual of WAcnstrctbal
DWAopmaintbal(trun) free dual of WAopmaintbal

DWAELrsrvreq(trun,r,c)
DWAELpwrdem(trun,r,c)

Positive Variables

*Water production activities
WAbld(WAp,v,trun,r,c) Build new water plants MMm3 per day and GW
WAexistcp(WAp,v,trun,r,c) Existing capacity MMm3 per day and GW
WAFop(WApF,v,WAf,trun,r,c) WAp operation single MMm3 and fixed cogen GWH
WAVop(WApV,v,ELl,ELs,ELday,WAf,opm,trun,r,c) Water plant operation variable cogen in GWH
WAop(WApsingle,v,ELl,ELs,ELday,WAf,trun,r,c) SWRO plant operation in billion m3
WAsolop(WAprn,v,ELl,ELs,ELday,trun,r,c) Water solar plant operation in TWH

*Water transportation activities
WAtrans(ELl,ELs,ELday,trun,r,c,rr,cc) Water transportation in MMm3
WAtransexistcp(trun,r,c,rr,cc) Exisiting waater transporation capacity in MMm3
WAtransbld(trun,r,c,rr,cc) Build new transport capacity  in MMm3

*Cross-cutting activities
WAcapitalcost(trun) Equipment purchased costs in USD
WAConstruct(trun) Construction costs in USD
WAOpandmaint(trun) Operation and maintenance costs in USD

*Water variables relating to electricity and fuel
WAELsupply(ELl,ELs,ELday,trun,r,c) Cogen elec supply for power submodel in GWH
WAELconsump(ELl,ELs,ELday,trun,r,c) Electricity consumption by water prodcuers GWh
WAELconsumphyb(ELl,ELs,ELday,trun,r,c) Electricity consumption by RO prodcuers from cogen TWh

WAelconsumpsol(WApsingle,ELl,ELs,ELday,trun,r,c)

WAELpwrdemand(trun,r,c) Power demand  from water producers in GW
WAELrsrvcontr(trun,r,c) Cogen elec contribution to ELp reserve in GW

WAfconsump(f,trun,r,c) Fuel consumption by water plants in MMBTU BBL Tonne
WAfconsumpcr(f,trun,r,c) Fuel consumption by water plants in MMBTU BBL Tonne

WAstoexistcp(trun,r,c) Existing water storage capacity in billion m3
WAstobld(trun,r,c) Build water storage capacity in billion m3
WAstoop(ELl,ELs,ELday,trun,rr,cc) storage operation in billion m3 at each hourly load segment

* Water variables relating to ground water well extraction
WAgrbld(trun,r) bld new ground water wells
WAgr(WAf,trun,r,c) Supply of ground water in Billion cubic meters
WAgrexistcp(trun,r,c) existing capacity of ground water (wells and surface) in Bilion m3

DWAfcons(WAf,trun,r,c)
DWAfavail(WAf,trun,r,c)
* DWAfavail(WAf,trun)
DWAfavailcr(WAf,trun,r,c)

DWAELsup(ELl,ELs,ELday,trun,r,c)
DWAELcons(ELl,ELs,ELday,trun,r,c)
DWAROconslimsol(WApsingle,ELl,ELs,ELday,trun,r,c)
DWAELsol(ELl,ELs,ELday,trun,r,c)

DWAcapbal(WAp,v,trun,r,c)
DWAFcaplim(WAp,v,trun,r,c)
DWAVcaplim(WAp,v,ELl,ELs,ELday,trun,r,c)
DWAcaplim(WAp,v,ELl,ELs,ELday,trun,r)
DWAsolcaplim(WAp,v,ELl,ELs,ELday,trun,r)

DWAhybratio(trun,r,c)

DWAsup(ELl,ELs,ELday,trun,r,c)
DWAdem(ELl,ELs,ELday,trun,r,c)

DWAtranscapbal(trun,r,c,rr,cc)
DWAtranscaplim(Ell,Els,ELday,trun,r,c,rr,cc)

DWAstocaplim(ELl,ELs,ELday,trun,rr,cc)
DWAstocapbal(trun,rr,cc)

DWAgrcaplim(trun,r,c)

*Emissions variables
* =====================
Variables
EMtotcost
DEMcostbal(ksec,EMcp,trun,c)
;
Positive variables
EMcost(ksec,EMcp,trun,c)
EMquant(ksec,EMcp,trun,c)
EMallquant(EMcp,trun,c)

DEMquantbal(ksec,EMcp,trun,c)
DEMallquantbal(EMcp,trun,c)
