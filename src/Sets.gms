* This file contains all sets and indexes used in KEM
* ===================================================


* General and time sets
* t1 = 2015
Sets
time            time period for defining parameters and tables   /t1*t30/
trun(time)      final model run time period                      /t1*t16/
time2(trun)     myopic horizon for hybrid recursive dynamics     /t1*t1/
i               time summation index for discounting             /1*100/
t(trun)         dynamic set for time ;

alias (trun,ttrun)
alias (t,tt)


sets
ksec  sectors in KEM /UP,EL,WA,RF,PC,CM,OT/
ELsect(ksec) power sector
WAsect(ksec) water sector
UPsect(ksec) upstream sector
CMsect(ksec) cement sector
PCsect(ksec) petrochemicals sector
RFsect(ksec) refining sector
INTsec(ksec) sectors in integrated model
;

ELsect(ksec)=no;
CMsect(ksec)=no;
WAsect(ksec)=no;
UPsect(ksec)=no;
PCsect(ksec)=no;
RFsect(ksec)=no;
INTsec(ksec)=no;

ELsect('EL')=yes;
WAsect('WA')=yes;
CMsect('CM')=yes;
PCsect('PC')=yes;
RFsect('RF')=yes;
INTsec('EL')=yes;
INTsec('WA')=yes;
INTsec('UP')=yes;

sets
allmaterials all materials in KEM
/
crude,HFO, diesel, dummyf,u-235,ethane, methane, NGL, propane,naphtha,
ethylene,methanol, MTBE, styrene,propylene,ethylene-glycol,vcm,
ldpe, lldpe, hdpe, pp, pvc, polystyrene,ammonia,urea,2EH,DAP
vinacetate,propoxide,prop-glycol,toluene,formald,urea-formald,
butadiene,Gcond,Arabsuper,Arabextra,Arablight,Arabmed,Arabheavy,
sr-gas-oil,hsr-naphtha,lsr-naphtha,hh-naphtha,hl-naphtha,sr-resid,
sr-keros,sr-distill,cc-gasoline,cc-naphtha,lhc-naphtha,lt-naphtha,
a-gasoline,v-gas-oil,hv-gas-oil,v-resid,cc-gas-oil,c-gas-oil,c-naphtha,
ref-gas,fuel-gas,isomerate,h-reformate,l-reformate,95motorgas,91motorgas,
LPG,vis-resid,olefingas,petcoke,Butane,Pentane,Jet-fuel,Asphalt,
ht-diesel,hc-diesel,CaCO3,CaCO3c,CaCO3SAFm,Sand,Clay,Irono,Gypsum,
Pozzn,PortI,PortV,PozzC,PortIp,PortVp,PozzCp,ClinkIh,ClinkVh,ClinkPh,
ClinkI,ClinkV,ClinkP,CKD,CaCO3SAF,CSAF,Ca,O,Si,Al,Fe,CO2,CaO,SiO2,
Al2O3,Fe2O3,C3S,C2S,C3A,C4AF,Coal,photons,air
/

f(allmaterials) fuels
/
crude,dummyf,u-235,ethane,methane,NGL,Coal
propane,naphtha,Gcond,Arabsuper,Arabextra,Arablight,Arabmed,Arabheavy,
hsr-naphtha,lsr-naphtha,hh-naphtha,hl-naphtha,sr-resid,Asphalt
sr-keros,sr-distill,cc-gasoline,cc-naphtha,lhc-naphtha,lt-naphtha,
a-gasoline,v-gas-oil,hv-gas-oil,v-resid,cc-gas-oil,c-gas-oil,c-naphtha,
ref-gas,fuel-gas,isomerate,h-reformate,l-reformate,95motorgas,91motorgas,
LPG,vis-resid,olefingas,petcoke,HFO,Diesel,Butane,Pentane,Jet-fuel,
ht-diesel,hc-diesel,MTBE,photons,air
/


fup(f) upstream fuels /crude,Arabsuper,Arabextra,Arablight,Arabmed,Arabheavy,
                         methane,ethane,NGL,propane,Gcond,u-235,dummyf,Coal/

natgas(fup) natural gas / methane,ethane,NGL,propane,Gcond/
crude(fup) crude grades /Arabsuper,Arabextra,Arablight,Arabmed,Arabheavy/

rall all regions and countries /sout,west,cent,east,adwe,dewa,sewa,fewa,qatr,kuwr,bahr,omnr,gcc/
c all countries in GCC region /ksa,uae,qat,kuw,bah,omn/

r(rall) regions /sout,west,cent,east,adwe,dewa,sewa,fewa,qatr,kuwr,bahr,omnr/

rc(r,c) all region and country relationship in GCC region
/(sout,west,cent,east).ksa,(adwe,dewa,sewa,fewa).uae,qatr.qat,kuwr.kuw,bahr.bah,omnr.omn/
* country sets
rKSA(r,c) all region and country relationship within Saudi Arabia
/(west,sout,cent,east).ksa/
rUAE(r,c)
/(adwe,dewa,sewa,fewa).uae/
rQAT(r,c)
/qatr.qat/
rKUW(r,c)
/kuwr.kuw/
rBAH(r,c)
/bahr.bah/
rOMN(r,c)
/omnr.omn/

cKSA(c) /ksa/
cUAE(c) /uae/
cQAT(c) /qat/
cBAH(c) /bah/
cKUW(c) /kuw/

call(c) /ksa,uae,qat,kuw,bah,omn/

*trd=no;


* rEW(r)  /west,east/
* rEWS(r) /west,east,sout/

* SP: Declaring sets for running models with sectors in isolation
* DMW - might not need this:
 built_models /power,water,upstream,refining,petrochem,cement,integrated_EL_WA,integrated/
 run_model(built_models)

alias (r,rr);
alias (c,cc);

* Power
* ===================
Sets
ELp power plant types /Steam,Stscrub,GT,CC,CCcon,GTtoCC,CoalSteam,Nuclear,PV,CSP,Wind/

ELpd(ELp) dispatchable technologies /Steam,Stscrub,GT,CC,CCcon,GTtoCC,Nuclear,CoalSteam/
ELpcom(ELpd) technologies without GTtoCC /Steam,Stscrub,GT,CC,CCcon,Nuclear,CoalSteam/
ELpnoscrub(ELpd) technologies without scrubber /Steam,GT,CC,CCcon,GTtoCC,Nuclear,CoalSteam/
ELpGTtoCC(ELpd) GTtoCC conversion only /GTtoCC/
ELpnuc(ELpd) nuclear power plant /Nuclear/
ELpspin(ELpd) plants used for spinning reserves /GT/
ELCCcon(ELp) /CC,CCcon/

ELpsw(ELp) renewable technologies /PV,CSP,Wind/
ELps(ELpsw) solar technologies /PV,CSP/
ELppv(ELpsw) non-dispatchable solar technologies /PV/
ELpcsp(ELpsw) CSP plants with storage /CSP/
ELpw(ELpsw) Wind technologies /Wind/
GTtoCC is an intermediate process that represents the retrofitting of existing
GT plants into CC plants.

ELstorage thermal storage technologies /moltensalt/

ELl load segments /L1*L8/
ELlpeak(ELl) peak load segments /L4*L6/
ELloffpeak(ELl) off-peak load segments /L1*L3,L7*L8/

ELs seasons /summ,wint,spfa/
ELday types of day /wday,wendhol/
coord geographical coordinates /lat latitude,long longitude/

ELf(f) /Arablight,HFO,diesel,methane,u-235,Coal/
ELfsol(f) /photons/
ELfwin(f) /air/
ELfref(ELf) refined fuels /HFO,diesel/
ELfup(ELf) upstream fuels /Arablight,methane,u-235,Coal/
ELfspin(ELf) fuels used for up spinning capacity /diesel,methane/
ELfnoHFO(ELf)

clc cloud cover /nc,pc,oc,dust/

ss supply step for upstream fuel production cost /ss1*ss2/

v plant vintage /old,new/
vo(v) old vintage /old/
vn(v) new vintage /new/
;

ELfnoHFO(ELf) = yes;
ELfnoHFO('HFO') = no;

alias (ELpd,ELpp);
alias (ELs,ELss);
alias (ELl,ELll);
alias (ELday,ELdayy);

* Water
* ===================
Sets
WAp water plant types
/
MED, MSF, SWROfl,BWRO,SWROhyb,SWRO,
StCo,GTCo,CCCoMED,CCCoMSF
StCoV,GTCoV,CCCoVMED,CCCoVMSF
PVhybWA
/

WApco(WAp)      all cogen plants
/
StCo,GTCo,CCCoMED,CCCoMSF,
StCoV,GTCoV,CCCoVMED,CCCoVMSF
/

WApV(WAp)       variable PWR cogen plants
/
StCoV,GTCoV,CCCoVMED,CCCoVMSF
/
*        include Steam to operate variable GT as CC when water is switched off

WApF(WAp)       fixed PWR both thermal cogen and RO
/
MED,MSF,SWROfl,BWRO,SWROhyb,SWRO,
StCo,GTCo,CCCoMED,CCCoMSF  /
WApFco(WApF)       fixed PWR thermal cogen
/
 StCo,GTCo,CCCoMED,CCCoMSF  /

WApsingle(WApF) single purpose plant - water only
 /       MED,SWROfl,SWRO,BWRO,SWROhyb    /

WApRO(WApsingle)     SWRO plants operating on WA loadcurve
/       SWROhyb, SWRO, BWRO   /

WApsat(WApF)    sat plant
/       MED,SWROfl,SWRO,BWRO    /

WAprn(WAp) renewable power supply for water plants  /PVhybWA/

SWROhyb(WApF)   hybrid RO consuming cogen power   /SWROhyb/
RO(WApsingle)     Ro consuming EL power             /SWRO, BWRO/
*         BWRO(WApRO)     BWRO consuming EL power             /BWRO/
CCCo(WApCO)     /CCCoMED,CCCoMSF,CCCoVMED,CCCoVMSF /
STCo(WApCO)     /STCo,STCoV/
GTCo(WApCO)     /GTCo,GTCoV/

WAf(f)          water fuels    /Arablight, HFO, diesel, methane, dummyf/
WAfref(WAf)     refined fuels  /HFO,diesel/
WAfup(WAf)      upstream fuels  /Arablight,methane,dummyf/

ELlnotlast(ELl)         hourly load segments for stoarge excpet last
ELLnotfirst(ELl)        all hourly load segements but the first

WApGTCo(WApV)    GTCoV  only                    /GTCOV/
WApnoBWRO(WAp)  all but BWRO
*SP: I have added the regions below. Check if these are right!
rsea(r,c)  regions with direct sea access /(west,sout,east).ksa,(adwe,dewa,sewa,fewa).uae,qatr.qat,kuwr.kuw,bahr.bah,omnr.omn/
opm variable cogen operation modes /m0,m1/
;
WApnoBWRO(WAp)=yes;
WApnoBWRO("BWRO")=no;

* price sets
* ==========
sets

fMP(f,c) fuels set to marginal price
* power sub-model fuel subsets
ELfAP(f,c) fuels with predefined allocation or no allocation requirements
ELfMP(f,c) optimal allocation of fuels conditional on administered prices
* water sub-model fuel subsets
WAfMP(f,c) fuels with predefined allocation or no allocation requirements
WAfAP(f,c) optimal allocation of fuels conditional on administered prices

fMPt(f,c)
ELfMPt(f,c)
WAfMPt(f,c)
;

fmp(f,c) = no;
ELfMP(f,c) = no;
ELfAP(f,c) = no;
WAfMP(f,c)= no;
WAfAP(f,c) = no;

fMPt(f,c)=no;
ELfMPt(f,c)=no;
WAfMPt(f,c)=no;

* Emissions
* =========
Sets
EMcp /CO2/
*EMcp /CO2,NOx,SOx/
CO2(EMcp) CO2 only /CO2/

* Subsidy
* ============
sets
ELpsub(ELp)   subset of power plants used in investment credit sceanrio
ELpdsub(ELpd) subset of dispatchable plants used in investment credit scenario
ELprsub(ELpsw) subset of renewable power plants used in investment credit sceanrio
WApsub(WAp)   subset of water plants used in investment credit sceanrio;
*        intialize subsidy grid sets for non susbsidized runs
ELpdsub(Elpd) = no;
ELprsub(Elps) = no;
ELpsub(ELp) = no;
WApsub(WAp) = no;










* not currently used:

$ontext
* Petrochemical Production Submodel Sets
* ======================================
Sets
PCim(allmaterials) all petchem feedstock and products /ethylene, methanol, mtbe,
styrene,propylene, ethylene-glycol, vcm, ldpe, lldpe, hdpe, pp, pvc, polystyrene,
ammonia, urea, 2EH,vinacetate,propoxide,prop-glycol,toluene,formald,DAP
urea-formald,butadiene,ethane, methane, propane, naphtha/
PCMTBE(allmaterials) only MTBE /MTBE/

* i (im) and m (im) declares that i and m a subset of (im)
PCi(PCim) petrochemical products /ethylene, methanol, mtbe, styrene,
propylene, ethylene-glycol, vcm, ldpe, lldpe, hdpe, pp, pvc, polystyrene,
ammonia,urea,2EH,vinacetate,propoxide,prop-glycol,toluene,formald,
urea-formald,butadiene,DAP/

PCm(f) input materials /ethane,methane,propane,naphtha/
PCmCH4(PCm) methane /methane/
PCmnoCH4(PCm) all fuels without methane /ethane,propane,naphtha/
PCmgas(PCm) ethane and methane /methane,ethane/
PCmngas(PCm) not gas /propane,naphtha/

PCmref(PCm) refined inputs /naphtha/
PCmup(PCm) inputs from upstream /ethane,methane,propane/
PCmsub(PCm) subsidized feedstock /methane,ethane/
PCmnsub(PCm) not subsidized feedstock /propane,naphtha/

Sets PCfsub(fup) /methane,ethane/
     PCfnsub(fup) /propane/

PCp petrochemical processes /p1eth, p1naph, p2ethylene, p2propyleneprop,
p3*p7, p8ldpe, p8pp_liq, p8pp_gas, p9*p25/
;

alias(PCp,PCpp);




* Refining Submodel Sets
* ======================
Sets
RFf(f) all refining fuels  /Gcond       Gas condensate
                            Arabsuper   Arabian super light crude
                            Arabextra   Arabian extra light crude
                            Arablight   Arabian light crude
                            Arabmed     Arabian medium crude
                            Arabheavy   Arabian heavy crude
                            hsr-naphtha Heavy straight-run naphtha
                            lsr-naphtha Light straight-run naphtha
                            hh-naphtha  Hydrotreated heavy SR-naphtha
                            hl-naphtha  Hydrotreated light SR-naphtha
                            sr-resid    Straight-run residuum
                            sr-keros    Straight-run kerosene or jet fuel
                            sr-distill  Straight-run distillate
                            cc-gasoline CC gasoline
                            cc-naphtha  Catalytic cracked naphtha
                            lhc-naphtha Light hydrocracker naphtha
                            lt-naphtha  Light thermal naphtha
                            a-gasoline  Alkylate gasoline
                            v-gas-oil   Vacuum gas oils
                            hv-gas-oil  Hydrotreated vacuum gas oil
                            v-resid     Vacuum residuum
                            cc-gas-oil  FCC gas oil
                            c-gas-oil   Coker gas oil
                            c-naphtha   Coker naphtha
                            ref-gas     Refinery gas
                            fuel-gas    Fuel gas
                            isomerate   Isomerate
                            h-reformate High severity reformate
                            l-reformate Low severity reformate
                            ht-diesel   Hydrotreater diesel
                            hc-diesel   Hydrocracker diesel
                            MTBE        Methyl Tert-Butyl Ether
                            95motorgas  RON 95 motor gasoline
                            91motorgas  RON 91 motor gasoline
                            LPG         LPG
                            vis-resid   vis breaker residue
                            olefingas   Olefin gas
                            petcoke     Petroleum coke
                            HFO         Heavy Fuel Oil
                            Diesel      Diesel (based on Aramco's A-870 Diesel)
                            Butane      Butane (separate from butane as 'LPG')
                            Pentane     Pentane
                            Naphtha     Naphtha
                            Jet-fuel    Kerosene or jet fuel
                            Asphalt     Asphalt (also known as bitumen)/
*Asphalt is not used as a fuel, but it is included as a final product.

RFcf(RFf) final products    /95motorgas,91motorgas,HFO,Diesel,LPG,Naphtha,Jet-fuel,
                             Asphalt,Petcoke/

RFcr(RFf)  crude oil grades /Gcond,Arabsuper,Arabextra,Arablight,Arabmed,Arabheavy/

RFci(RFf) intermediate products /hsr-naphtha,lsr-naphtha,sr-resid,sr-keros,h-reformate,
                            v-gas-oil,cc-gasoline,c-gas-oil,butane,pentane,
                            a-gasoline,isomerate,sr-distill,c-naphtha,cc-gas-oil,
                            ref-gas,v-resid,petcoke,olefingas,lt-naphtha,cc-naphtha,
                            hh-naphtha,hl-naphtha,lhc-naphtha,vis-resid,hv-gas-oil,fuel-gas,
                            l-reformate,ht-diesel,hc-diesel,MTBE/
RFMTBE(RFf) MTBE only /MTBE/

RFdie(RFcf) /diesel/
RFHFO(RFcf) /HFO/

RFp   refining processes   /a-dist      Atmospheric distillation of crudes
                            refgasp     Processing refinery gas
                            v-dist      Vacuum distillation of sr-residuum
                            n-reform    Naphtha reforming
                            hc-gas-oil  Hydrocracking gas oils
                            cc-gas-oil  Catalytic cracking of gas oils
                            n-hydro     Hydrotreating naphtha
                            d-hydro     Hydrotreating diesel-gasoil
                            vg-hydro    Hydrotreating vacuum gas oil
                            gc-splitp   Gas condensate splitting-including fractionation
                            r-coke      Coking vacuum residuum
                            jf-merox    Merox treatment of jet fuel
                            lpg-merox   Merox treatment of LPG
                            Alkylation  Alkylation of butane to get a-gasoline
                            Isomerp     Isomerization of hydrotreated naphtha
                            visbreakp   Visbreaking
                            Blowing     Asphalt Blowing
                            g95-blend   Gasoline 95 blending
                            g91-blend   Gasoline 95 blending
                            fo-blend    Fuel oil blending
                            d-blend     Diesel blending
                            n-mix       Producing a generic naphtha/

RFu   refining units       /a-still     Atmospheric distiller
                            refgasu     Refinery gas processing unit
                            v-still     Vacuum distiller
                            c-reformer  Catalytic reformer
                            c-crack     Catalytic cracker
                            h-crack     Hydrocracker
                            n-hydrou    Naphtha Hydrotreater
                            d-hydrou    Distillate hydrotreater (diesel-gasoil)
                            vg-hydrou   vacuum gasoil hydrotreating unit
                            coker       Delayed coker
                            meroxu      Mercaptan oxidation treater
                            Alkylu      Alkylation unit
                            Isomeru     Isomerization unit
                            Visbreaku   Visbreaking unit
                            Blower      Asphalt blower unit
                            gc-splitu   Gas condensate splitter-including fractionation
                            Blendu      Blending unit/

* Severities are low and high, but could add more levels in the future.
RFs Process severity          /l,h/

RFqlim  upper and lower limits for quality specification /max,min/

prop  final product properties /RON      Research octane number
                                RVP      Reid vapor pressure (bar)
                                VBI      Kinematic viscosity blending index at 100C
                                Density  Density (Mg per m^3) at 15 deg Celsius
                                Sulfur   Sulfur content (10^3 ppmw)
                                CI       Cetane index (for diesel)
                                MTBEvol  Fraction of MTBE by volume/
;
alias(RFf,RFff);

* Cement Sub-model Sets
* =====================
Sets CMm(allmaterials) all cement production materials
/CaCO3  Calcium Carbonate (approx. for limestone)
 CaCO3c Crushed CaCO3
 CaCO3SAFm Raw mix
 Sand   Sand
 Clay   Clay
 Irono  Iron Ore
 Gypsum Gypsum
 Pozzn  Pozzolan
 PortI  Portland Cement Type I
 PortV  Portland Cement Type V
 PozzC  Pozzolan Cement
 PortIp Prelim. Portland Cement Type I
 PortVp Prelim. Portland Cement Type V
 PozzCp Prelim. Pozzolan Cement
 ClinkIh High temp Clinker for Portland I
 ClinkVh High temp Clinker for Portland V
 ClinkPh High temp Clinker for Pozzolan Cement
 ClinkI Clinker for Portland I
 ClinkV Clinker for Portland V
 ClinkP Clinker for Pozzolan Cement
 CKD    Cement kiln dust (particulate emission)
 CaCO3SAF Mixer 1 output
 CSAF   Clinker reactants
 Ca     Calcium
 O      Oxygen
 Si     Silicon
 Al     Aluminum
 Fe     Iron
 CO2    Carbon Dioxide
 CaO    Calcium Oxide
 SiO2   Silicon Oxide
 Al2O3  Aluminum Oxide
 Fe2O3  Iron Oxide
 C3S    Tricalcium Silicate
 C2S    Dicalcium Silicate
 C3A    Tricalcium Aluminate
 C4AF   Tetracalcium aluminoferrite/

 CMcr(CMm) input materials /CaCO3,Sand,Clay,Irono,Gypsum,Pozzn/

 CMci(CMm) intermediate materials /ClinkI,ClinkV,ClinkP,ClinkIh,ClinkVh,ClinkPh,
                                   CaO,SiO2,Al2O3,Fe2O3,C3S,C2S,C3A,C4AF,PortIp,
                                   PortVp,PozzCp,CaCO3c,CaCO3SAFm,CaCO3SAF,CSAF/
 CMcii(CMm) without molecules or atoms /ClinkI,ClinkV,ClinkP,ClinkIh,ClinkVh,ClinkPh,
                                   PortIp,PortVp,PozzCp,CaCO3c,CaCO3SAFm,CaCO3SAF,CSAF/
 CMclinker(CMci) clinker types only /ClinkIh,ClinkVh,ClinkPh/
 CMcl(CMci) clinker reactants and products /CaO,SiO2,Al2O3,Fe2O3,C3S,C2S,C3A,C4AF/
 CMclr(CMcl) clinker reactants /CaO,SiO2,Al2O3,Fe2O3/
 CMclp(CMcl) clinker products /C3S,C2S,C3A,C4AF/
 CMlime(CMcl) lime only/CaO/

 CMcsaf(CMm) CSAF only/CSAF/

 CMcf(CMm) final products /PortI,PortV,PozzC,CO2,CKD/
 CMcements(CMcf) cements only /PortI,PortV,PozzC/

 CMma(CMm) atomic particles /Ca,O,Si,Al,Fe/

 CMf(f) fuels used in cement production /Methane,Arabheavy,HFO,Diesel/
 CMfup(CMf) upstream fuels /Methane,Arabheavy/
 CMfref(CMf) refined fuels /HFO,Diesel/

 CMu production units /crusher,kiln long dry kiln,
 phkiln 4-stage preheater kiln,
 phpckiln 4-stage preheater kiln with precalcination,
 kilntophkiln converted kiln to phkiln,
 kilntophpckiln converted kiln to phpckiln,
 cooler,grinder,mixer,rawmill/
 CMuk(CMu) kilns only /kiln,phkiln,phpckiln,kilntophkiln,kilntophpckiln/
 CMukcon(CMu) conversion activity units /kilntophkiln,kilntophpckiln/

 CMp processes /crushing,milling,mixing1,mixing2I,mixing2V,mixing2P,calcining1,
                sinteringI,sinteringV,sinteringP,sinteringphI,sinteringphV,sinteringphP,
                sinteringphpcI,sinteringphpcV,sinteringphpcP,cooling,grinding,
                calciningph,calciningphpc/
 CMpk(CMp) sintering processes /sinteringI,sinteringV,sinteringP,sinteringphI,
                sinteringphV,sinteringphP,sinteringphpcI,sinteringphpcV,sinteringphpcP/
 CMpkiln(CMp) operating dry kiln /sinteringI,sinteringV,sinteringP/
 CMpkilnph(CMp) operating dry kiln with preheat /sinteringphI,sinteringphV,sinteringphP/
 CMpkilnphpc(CMp) operating dry kiln with preheat and precalcination /sinteringphpcI,sinteringphpcV,sinteringphpcP/

 CMprop properties /masscon content as mass fraction/
 CMqlim property and mixing limits /max,min/

;
alias(CMm,CMmm);
alias(CMp,CMpp);
alias(CMu,CMuu);
alias(CMuk,CMukk);


* investment credit and fuel subsidy scenario variables parameters and sets
* =========================================================================

*positive Variables       subsidy(time) investment credit variable

parameter        subsidy(trun);
         subsidy(trun) =0;

parameter
         gamma_sub(ELp,trun) specific subsidy grid values
         gamma_upbound_save upperbound on credit when solving subsidy grid
         gamma_lobound_save lowerbound on credit when solving subsidy grid
         capsubsidy_level(trun) optimal level of general subsidy on the grid
         budget_level(trun) budget used in the last grid optimization;

         gamma_sub(ELp,trun) = 0;
         capsubsidy_level(trun) = 0;
         budget_level(trun) = 0;

sets     ii set used to construct budget sensitivity analysis for the subsidy grid /ii1*ii1/
         jj      /jj0*jj20/

         fsub(fup) accounting subset upstream fuels /methane, ethane, arablight, Arabheavy/
         RFfsub(RFcf) accounting subset refined fuels /diesel, HFO/


ELpsub(ELp)   subset of power plants used in investment credit sceanrio
ELpdsub(ELpd) subset of dispatchable plants used in investment credit scenario
ELprsub(ELpsw) subset of renewable power plants used in investment credit sceanrio
WApsub(WAp)   subset of water plants used in investment credit sceanrio;
*        intialize subsidy grid sets for non susbsidized runs
ELpdsub(Elpd) = no;
ELprsub(Elps) = no;
ELpsub(ELp) = no;
WApsub(WAp) = no;


sets

fMP(f) fuels set to marginal price
* power sub-model fuel subsets
ELfAP(f) fuels with predefined allocation or no allocation requirements
ELfMP(f) optimal allocation of fuels conditional on administered prices
* water sub-model fuel subsets
WAfMP(f) fuels with predefined allocation or no allocation requirements
WAfAP(f) optimal allocation of fuels conditional on administered prices
* petchem sub-model fuel subsets
PCmAP(f) feedstock with predefined allocation or no allocation requirements
PCmMP(f) optimal allocation of fuels conditional on administered prices
* cement sub-model fuel subsets
CMfAP(f) fuels with predefined allocation or no allocation requirements
CMfMP(f) optimal allocation of fuels conditional on administered prices;

fmp(f) = no;

ELfMP(f) = no;
ELfAP(f) = no;

WAfMP(f)= no;
WAfAP(f) = no;

PCmMP(f) = no;
PCmAP(f) = no;

CMfMP(f) = no;
CMfAP(f) = no;

sets     fi          1st grid index                              /i0*i20/
         fj          2nd grid index                              /j0*j20/
         fk          3rd grid index                              /k0*k20/
         fx          4th grid index for crude-gas pricing        /x0*x20/
         fy          4th grid index for crude-gas pricing        /y0*y20/

         fj_s(fj), fk_s(fk)

         fi_max(fi), fj_max(fj), fk_max(fk)
         fx_max(fx), fy_max(fy)
         fi_min(fi), fj_min(fj), fk_min(fk);

         fx_max(fx) = no;
         fy_max(fy) = no;
;
$offtext
