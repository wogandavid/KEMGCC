* write cost calcs to CSV
FILE ANT1 /''/;
*FILE ANT1 /results/%scenario%/costcalcs.csv/;
PUT ANT1; ANT1.ND=6; ANT1.PW=400; ANT1.PC=5;
put "scenario","trun", "Country", "Capex", "Opex", "Fuelex", "ELimportex", "fImportex", "ELexportrev", "fExportrev","Total System";
loop((trun,c),
put / "%scenario%",trun.TL, c.TL,
    RWcostcalcs(trun,'Capex',c),
    RWcostcalcs(trun,'Opex',c),
    RWcostcalcs(trun,'Fuelex',c),
    RWcostcalcs(trun,'ELimportex',c),
    RWcostcalcs(trun,'fImportex',c),
    RWcostcalcs(trun,'ELexportrev',c),
    RWcostcalcs(trun,'fExportrev',c),
    RWcostcalcs(trun,'Total System',c)
);
PUTCLOSE ANT1;

* write Capacities to CSV
FILE ANT2 /''/;
PUT ANT2; ANT2.ND=6; ANT2.PW=400; ANT2.PC=5;
put "scenario","trun", "Country", "Technology", "Capacity";
loop((trun,c,ELpd),
put / '%scenario%',trun.TL, c.TL,ELpd.TL,
    ELWAcap(trun,c,ELpd,'EL')
);
loop((trun,c,ELpsw),
put / '%scenario%',trun.TL, c.TL,ELpsw.TL,
    ELWAcap(trun,c,ELpsw,'EL')
);
loop((trun,c),
put / '%scenario%',trun.TL, c.TL, "Cogen"
    ELWAcap(trun,c,'Cogen','WA')
);
PUTCLOSE ANT2;

* write Builds to CSV
FILE ANT3 /''/;
PUT ANT3; ANT3.ND=6; ANT3.PW=400; ANT3.PC=5;
put "scenario","trun", "Country", "Technology", "Builds";
loop((trun,c,ELp),
put / '%scenario%',trun.TL, c.TL,ELp.TL,
    ELWAbld_xls(c,trun,ELp)
);
loop((trun,c),
put / '%scenario%',trun.TL, c.TL,'Cogen',
    ELWAbld_xls(c,trun,'Cogen')
);
loop((trun,c),
put / '%scenario%',trun.TL, c.TL, "Water"
    WAbld_tot(trun,c,'Water')
);
PUTCLOSE ANT3;

* write Electricity Supply to CSV
FILE ANT4 /''/;
PUT ANT4; ANT4.ND=6; ANT4.PW=400; ANT4.PC=5;
put "scenario","trun", "Country", "Technology", "Electricity Supply";
loop((trun,c,ELp),
put / '%scenario%',trun.TL, c.TL,ELp.TL,
    ELWAsupELp_xls(trun,c,ELp)
);
loop((trun,c),
put / '%scenario%',trun.TL, c.TL,'Cogen',
    ELWAsupELp_xls(trun,c,'Cogen')
);
PUTCLOSE ANT4;

* write Fuel Consumption to CSV
FILE ANT5 /''/;
PUT ANT5; ANT5.ND=6; ANT5.PW=400; ANT5.PC=5;
put "scenario","trun", "Country", "Fuel", "Fuel consumption","Fuel consumption - physical";
loop((trun,c,f),
put / '%scenario%',trun.TL, c.TL,f.TL,
    ELWAfcon_tot(trun,c,f),
    ELWAfcon_physical(c,trun,f)
);
PUTCLOSE ANT5;

* write Electricity Trade to CSV
FILE ANT6 /''/;
PUT ANT6; ANT6.ND=6; ANT6.PW=400; ANT6.PC=5;
put "scenario","trun", "Country", "Fuel", "ELectricity Trade";
loop((trun,c,cc),
put / '%scenario%',trun.TL, c.TL, cc.TL,
    RWELtrade_tot(trun,c,cc)
);
PUTCLOSE ANT6;



