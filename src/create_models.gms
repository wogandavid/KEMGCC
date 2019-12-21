* create LP and MCP models

* LP models
* ============
model transLP
/
TRobjective
TRcapitalcostbal
TRopmaintbal
TRbldbal
TRcapbal
TRcaplim
TRdem
*TRanglebal
/

model powerLP
/
ELobjective,
ELopmaintbal
ELcaplim
ELdem
ELrsrvreq
ELcapitalcostbal
ELcapbal
ELgtconvlim
ELsup
*ELtranscapbal
*ELtranscaplim
ELfcons
ELfavail
ELfavailcr
ELrencapbaln
ELrencapbalo
ELsolcaplimn
ELsolcaplimo
ELsolutil
ELsolcapsum
ELupspinres
ELstorenergyballast
ELsolenergybal
ELstorenergybal
ELCSPutil
ELCSPcaplim
ELnucconstraint
ELwindcapsum
ELwindutil
ELwindcaplim
ELCSPlanduselim
ELrenprodreq
ELbldreq
ELnucprodreq
ELstorlim
ELrampbal

*ELtradesup
*ELtradelim

$ontext
ELopmaintbal,
ELcaplim,
ELdem,
ELrsrvreq,
ELcapitalcostbal
ELcapbal,
ELgtconvlim,
ELsup,
ELtranscapbal,
ELtranscaplim,
ELfcons,
ELfavail,
ELfavailcr,
ELrencapbaln,
ELrencapbalo,
ELsolcaplimn,
ELsolcaplimo,
ELsolutil,
ELsolcapsum,
ELupspinres,
ELstorenergyballast,
ELsolenergybal,
ELstorenergybal,
ELCSPutil,
ELCSPcaplim,
ELnucconstraint,
ELwindcapsum,
ELwindutil,
ELwindcaplim,
ELCSPlanduselim,
ELrenprodreq,
*ELpurchbal,
*ELcnstrctbal,
$offtext
/
;

model waterLP
/
WAobjective
WApurchbal
WAopmaintbal
WAfcons
WAfavail
WAfavailcr
WAELsup
WAELcons
WAVcaplim
WAELsol
WAELrsrvreq
DWAELpwrdemand
WAELpwrdem
WAcapbal
WAFcaplim
WAhybratio
WAsup
WAdem
WAtranscapbal
WAtranscaplim
WAstocaplim
WAstocapbal

*WAELtradesup

$ontext
WAobjective
WApurchbal,
*WAcnstrctbal,
WAopmaintbal,
WAfcons,
WAfavail,
WAfavailcr,
WAELsup,
WAELcons,
WAELsol,
WAELrsrvreq,
WAELpwrdem,
WAcapbal,
WAFcaplim,
WAVcaplim,
WAhybratio,
WAsup,
WAdem,
WAtranscapbal,
WAtranscaplim,
WAstocaplim,
WAstocapbal,
$offtext
/

;

model fuelLP
/
fObjective
fpurchbal
fopmaintbal
fuelsup
ftranscapbal
ftranscaplim
fdem
frevenuesbal
fExportsum

$ontext
fObjective
fpurchbal,
fopmaintbal,
fuelsup,
ftranscapbal,
ftranscaplim,
fdem,
frevenuesbal,
fExportsum,
$offtext
/
;

model emissionsLP
/
EMobjective
EMquantbal
EMcostbal
EMallquantbal

$ontext
EMobjective
EMquantbal,
EMcostbal,
EMallquantbal,
$offtext
/;

* LP objective function
equation
objective objective function;

objective.. z=e=UPz+ELz+WAz+EMtotcost;

model integratedLP /objective,powerLP,waterLP,fuelLP,emissionsLP/
model upLP /fuelLP/
model elLP /powerLP/
model waLP /waterLP/
;

* MCP models
* ============
 model transMCP
/
TRcapitalcostbal.DTRcapitalcostbal
TRopmaintbal.DTRopmaintbal
TRbldbal.DTRbldbal
TRcapbal.DTRcapbal
TRcaplim.DTRcaplim
TRdem.DTRdem

DTRopmaint.TRopmaint
DTRcapitalcost.TRcapitalcost
DTRexistcp.TRexistcp
DTRbld.TRbld
DTRnodaltrans.TRnodaltrans

TRtradecap.DTRtradecap

DELsupply.ELsupply
ELsup.DELsup,

*TRpanglebal.DTRpanglebal
*DTRpangle.TRpangle
/
;



model powerMCP
/

DELtrademax.ELtrademax
ELtradebal.DELtradebal,

ELfcons_trade.DELfcons_trade,
DELfconsump_trade.ELfconsump_trade,
DELop_trade.ELop_trade,

DELbld.ELbld,
DELexistcp.ELexistcp,
DELop.ELop,
ELopmaintbal.dELopmaintbal,
DELgttocc.ELgttocc,
ELrsrvreq.DELrsrvreq,
ELcapitalcostbal.DELcapitalcostbal,
ELcapbal.DELcapbal,
ELcaplim.DELcaplim,
ELgtconvlim.DELgtconvlim,
DELOpandmaint.ELOpandmaint,
*Added
DELcapitalcost.ELCapitalCost,
DELfconsump.ELfconsump,
DELfconsumpcr.ELfconsumpcr,
ELfcons.DELfcons,
ELfavail.DELfavail,
ELfavailcr.DELfavailcr,
DElrenbld.ELrenbld,
DELsolop.ELsolop,
DELrenexistcp.ELrenexistcp,
ELrencapbaln.DELrencapbal,
ELrencapbalo.DELrencapbal,
ELsolcaplimn.DELsolcaplim,
ELsolcaplimo.DELsolcaplim,
DELsoloplevel.ELsoloplevel,
ELsolutil.DELsolutil,
ELsolcapsum.DELsolcapsum,
ELupspinres.DELupspinres,
DELupspincap.ELupspincap,
ELstorenergyballast.DELstorenergyballast,
ELsolenergybal.DELsolenergybal,
ELstorenergybal.DELstorenergybal,
ELCSPutil.DELCSPutil,
DELCSPlandarea.ELCSPlandarea,
DELheatstorin.ELheatstorin,
DELheatstorout.ELheatstorout,
DELheatstorage.ELheatstorage,
DELheatinstant.ELheatinstant,
ELCSPcaplim.DELCSPcaplim,
ELnucconstraint.DELnucconstraint,
DELwindop.ELwindop,
DELwindoplevel.ELwindoplevel,
ELwindcapsum.DELwindcapsum,
ELwindutil.DELwindutil,
ELwindcaplim.DELwindcaplim,
ELCSPlanduselim.DELCSPlanduselim,
ELrenprodreq.DELrenprodreq,
ELbldreq.DELbldreq,
ELnucprodreq.DELnucprodreq,
ELstorlim.DELstorlim,
DELrampupcst.ELrampupcst,
DELrampdncst.ELrampdncst,
ELrampbal.DELrampbal,



$ontext
* demand response
ELREdem.DELREdem,
DELRElcgw.ELRElcgw,
ELcostrecovery.DELcostrecovery,
DELavgcost.ELavgcost,
$offtext
/
;

model waterMCP
/
WApurchbal.DWApurchbal,
*WAcnstrctbal.DWAcnstrctbal,
WAopmaintbal.DWAopmaintbal,
WAfcons.DWAfcons,
WAfavail.DWAfavail,
WAfavailcr.DWAfavailcr,
WAELsup.DWAELsup,
WAELcons.DWAELcons,
WAVcaplim.DWAVcaplim,
DWAstobld.WAstobld,
WAELsol.DWAELsol,
WAELrsrvreq.DWAELrsrvreq,
DWAELpwrdemand.WAELpwrdemand,
WAELpwrdem.DWAELpwrdem,
WAcapbal.DWAcapbal,
WAFcaplim.DWAFcaplim,
WAhybratio.DWAhybratio,
WAsup.DWAsup,
WAdem.DWAdem,
WAtranscapbal.DWAtranscapbal,
WAtranscaplim.DWAtranscaplim,
WAstocaplim.DWAstocaplim,
WAstocapbal.DWAstocapbal,
DWAcapitalcost.WAcapitalcost,
*DWAConstruct.WAConstruct,
DWAOpandmaint.WAOpandmaint,
DWAbld.WAbld,
DWAexistcp.WAexistcp,
DWAFop.WAFop,
DWAVop.WAVop,
DWAstoop.WAstoop,
DWAsolop.WAsolop,
DWAtrans.WAtrans,
DWAtransbld.WAtransbld,
DWAstoexistcp.WAstoexistcp,
DWAtransexistcp.WAtransexistcp,
DWAELsupply.WAELsupply,
DWAELconsump.WAELconsump,
DWAELrsrvcontr.WAELrsrvcontr,
DWAfconsump.WAfconsump,
DWAfconsumpcr.WAfconsumpcr,

WAfcons_trade.DWAfcons_trade,
DWAfconsump_trade.WAfconsump_trade,
DWAFop_trade.WAFop_trade,
DWAVop_trade.WAVop_trade,




*WAELtradesup.DWAELtradesup,
*DWAELtradesupmax.WAELtradesupmax,
/
;

model fuelMCP
/
fpurchbal.dfpurchbal,
fopmaintbal.dfopmaintbal,
fuelsup.dfuelsup,
DfCapitalCost.fCapitalCost,
Dfopandmaint.fopandmaint,
ftranscapbal.Dftranscapbal,
ftranscaplim.Dftranscaplim,
Dftransbld.ftransbld,
Dftransexistcp.ftransexistcp,
fdem.Dfdem,
Dftrans.ftrans,
Dfueluse.fueluse,
frevenuesbal.Dfrevenuesbal
,fExportsum.DfExportsum,
DfRevenues.fRevenues,
Dfnatexports.fnatexports,
DfExports.fExports,
Dfimports.fimports
/
;

model emissionsMCP
/
EMquantbal.DEMquantbal,
EMcostbal.DEMcostbal,
EMallquantbal.DEMallquantbal,
DEMcost.EMcost,
DEMquant.EMquant,
DEMallquant.EMallquant,
/;


model integratedMCP /transMCP,powerMCP,waterMCP,fuelMCP,emissionsMCP/
model upMCP /fuelMCP/
model elMCP /powerMCP/
model waMCP /waterMCP/
;

* configuring solver

* use all available CPU cores:
IntegratedMCP.threads=0;
* include PATH.opt
IntegratedMCP.optfile=1;
* use maximum RAM
integratedMCP.solvelink=5;
* turn on scaling
IntegratedMCP.scaleopt=1;

option
LP=cbc
MCP=path
limrow=0
limcol=0
solveopt = merge
profile=0
;


*$offtext
*Scaling to improve solver performance:

WAhybratio.scale(trun,r,c)=1e-1;
DWAhybratio.scale(trun,r,c)=1e1;
WAopmaintbal.scale(trun)=1e1;
DWAopmaintbal.scale(trun)=1e-1;

ELfconsump.scale(ELpd,ELf,trun,r,c)=1e1;
DELfconsump.scale(ELpd,ELf,trun,r,c)=1e-1;

ELcapitalcostbal.scale(trun)=1e1;
DELcapitalcostbal.scale(trun)=1e-1;

WAsup.scale(ELl,ELs,ELday,trun,r,c)=1e-1;
DWAsup.scale(ELl,ELs,ELday,trun,r,c)=1e1;

WAELconsump.scale(ELl,ELs,ELday,trun,r,c)=1e1;

DWAtransbld.scale(trun,r,c,rr,cc)=1e-1;
WAtransbld.scale(trun,r,c,rr,cc)=1e1;

ELrenbld.scale(ELpsw,v,trun,r,c)=1e-1;
DELrenbld.scale(ELpsw,v,trun,r,c)=1e-1;

ELsoloplevel.scale(ELppv,v,trun,r,c)=1e-1;
DELsoloplevel.scale(ELppv,v,trun,r,c)=1e-1;

WAfcons.scale(WAf,trun,r,c)=1e1;
DWAfcons.scale(WAf,trun,r,c)=1e-1;
