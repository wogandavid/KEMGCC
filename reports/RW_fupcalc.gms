* The following are calculation expost of the model run for the Sector Upstream Fuel!
* The parameters are defined in RW_Parameters.gms
* ===============================================

parameters
dfdem_physical(trun,c,r,f)                      Marginal value of fuels USD per physcial unit
dfdem_energy(trun,c,r,f)                        Marginal value of fuels USD per energy unit

FupSup_agg(trun,c)                  Aggregate fuel supplied by country [TBTU]
FupSup_typ(trun,c,fup)              Total fuel supplied by fuel type-country [TBTU]
FupSup_typ_reg(trun,r,c,fup)        Total fuel supplied by fuel type-region-country [TBTU]

CruSup_reg(trun,r,c)                Crude oil production net of exports by region  [MMBBL]
CruSup_agg(trun,c)                  Crude oil production net of exports by country [MMBBL]

*Upstream fuel consumption by sectors
FupDem_reg(trun,fup,c,r,ksec)                Total upstream fuel consumption by region-country [MMBBL-TBTU-MMtons]
FupCon_reg(trun,fup,c,r,ksec)                Total upstream fuel consumption by region-country (TBTU)
FupDem_agg(trun,fup,c)                  Aggregate upstream fuel consumption by country [MMBBL-TBTU-MMtons]
FupDem_exp(trun,fup,c)              Total fuel upstream exports by country and fuel type [MMBBL-TBTU-MMtons]

*Upstream fuel transmission by region and country
Fuptrans_reg(trun,fup,c,r,cc,rr)      Region-country wise upstream fuel transmission [MMBBL-TBTU-MMtons]
Fuptrans_typ_reg(trun,fup,c,r)        Aggregate upstream fuel transmission from region-country [MMBBL-TBTU-MMtons]
Fuptrans_typ_agg(trun,c,fup)          Aggregate upstream fuel transmission from country [MMBBL-TBTU-MMtons]

Fup_Other(trun,fup,c)                Non-ELWA fuel consumption in energy (TBTU) units
;


dfdem_physical(trun,c,r,f)$(rc(r,c) and Fuelencon1(f)>0)=Dfdem.l(f,trun,r,c);
dfdem_energy(trun,c,r,f)$(rc(r,c) and Fuelencon1(f)>0)=Dfdem.l(f,trun,r,c)/Fuelencon1(f);

* Upstream Fuel Supply Calculation

* Total annual upstream fuel supplied by fuel type and country (in Trillion BTU)
FupSup_typ(trun,c,fup) = sum(r$rc(r,c),(sum(ss,fueluse.l(fup,ss,trun,r,c))
 -OTHERfconsump(fup,trun,r,c)-fExports.l(fup,trun,r,c))*Fuelencon1(fup));

* Total annual upstream fuel supplied by fuel type, region and country (in Trillion BTU)
FupSup_typ_reg(trun,r,c,fup) = (sum(ss$rc(r,c),fueluse.l(fup,ss,trun,r,c))
 -OTHERfconsump(fup,trun,r,c)-fExports.l(fup,trun,r,c))*Fuelencon1(fup);

* Aggregate annual upstream fuel supplied by country (in Trillion BTU)
FupSup_agg(trun,c) = sum((r,fup)$rc(r,c),(sum(ss,fueluse.l(fup,ss,trun,r,c))
 -OTHERfconsump(fup,trun,r,c)-fExports.l(fup,trun,r,c))*Fuelencon1(fup));


* Total annual crude oil demand (consumption) by region country (MMBBL)
CruSup_reg(trun,r,c) = sum((crude)$rc(r,c),sum(ss,fueluse.l(crude,ss,trun,r,c))-fExports.l(crude,trun,r,c));

* Total annual crude oil supply by country (MMBBL)
CruSup_agg(trun,c) = sum((crude,r)$rc(r,c),sum(ss,fueluse.l(crude,ss,trun,r,c))-fExports.l(crude,trun,r,c));

$ontext
crudeexport(trun) = sum((crude,r),fExports.l(crude,trun,r));
totalgcond(trun) = sum((r),sum(ss,fueluse.l('gcond',ss,trun,r))-fExports.l('gcond',trun,r));
gcondexport(trun) = sum((r),fExports.l('gcond',trun,r));
$offtext

* Fuel consumption

* By region
FupDem_reg(trun,fup,c,r,'EL')= sum(ELpd,ELfconsump.l(ELpd,fup,trun,r,c))$(rc(r,c) and ELf(fup));
FupDem_reg(trun,fup,c,r,'WA')= WAfconsump.l(fup,trun,r,c)$(rc(r,c) and WAf(fup));
FupDem_reg(trun,fup,c,r,'OT')= OTHERfconsump(fup,trun,r,c)$rc(r,c);

FupCon_reg(trun,fup,c,r,'EL')= sum(ELpd,ELfconsump.l(ELpd,fup,trun,r,c)*Fuelencon1(fup))$(rc(r,c) and ELf(fup));
FupCon_reg(trun,fup,c,r,'WA')= WAfconsump.l(fup,trun,r,c)*Fuelencon1(fup)$(rc(r,c) and WAf(fup));
FupCon_reg(trun,fup,c,r,'OT')= OTHERfconsump(fup,trun,r,c)*Fuelencon1(fup)$rc(r,c);


* + PCfconsump.l(fup,trun,r,c)*fPCconv(fup)$(rc(r,c) and PCm(fup))
* + RFcrconsump.l(fup,trun,r,c)*fRFconv(fup)$(rc(r,c) and RFf(fup))
* + CMfconsump.l(fup,trun,r,c)$(rc(r,c) and CMf(fup))

* Aggregate Upstream fuel consumption
FupDem_agg(trun,fup,c) = sum((r)$rc(r,c),sum(ELpd,ELfconsump.l(ELpd,fup,trun,r,c))$ELf(fup)
 + WAfconsump.l(fup,trun,r,c)$WAf(fup)
* + PCfconsump.l(fup,trun,r,c)*fPCconv(fup)$PCm(fup)
* + RFcrconsump.l(fup,trun,r,c)*fRFconv(fup)$RFf(fup)
* + CMfconsump.l(fup,trun,r,c)$CMf(fup)
*  and consumption from all other sectors
 + OTHERfconsump(fup,trun,r,c));


* Exports by country and fueltype in physical units
FupDem_exp(trun,fup,c) = sum(r$rc(r,c), fExports.l(fup,trun,r,c));

* Upstream Fuel Transmission by region-country
Fuptrans_reg(trun,fup,c,r,cc,rr) = ftrans.l(fup,trun,r,c,rr,cc)$(rc(r,c) and rc(rr,cc));

* Upstream Fuel Transmission by region and country
Fuptrans_typ_reg(trun,fup,c,r) = sum((rr,cc),ftrans.l(fup,trun,r,c,rr,cc)$(rc(r,c) and rc(rr,cc)));
Fuptrans_typ_agg(trun,c,fup) = sum((r,rr,cc),ftrans.l(fup,trun,r,c,rr,cc)$(rc(r,c) and rc(rr,cc)));

option FupDem_reg:3:4:1;
option FupDem_agg:3:2:1;
option FupCon_reg:3:4:1;
option Fuptrans_reg:3:4:2;
option FupSup_typ_reg:3:3:1;
option Fuptrans_typ_reg:3:3:1;
option Fuptrans_reg:3:4:2;
option dfdem_physical:3:3:1;
option dfdem_energy:3:3:1;
option OTHERfconsump:3:3:1;
option fueluse:3:4:1;
option fexports:3:3:1;
option ftrans:3:5:1;
option ftransexist:0:3:2;

display
dfdem_physical,
dfdem_energy,
FupSup_agg,
FupSup_typ,
FupSup_typ_reg,
CruSup_agg,
CruSup_reg,
FupDem_reg,
FupDem_agg,
FupDem_reg,
FupDem_exp,
Fuptrans_reg,
Fuptrans_typ_agg,
Fuptrans_typ_reg
;

