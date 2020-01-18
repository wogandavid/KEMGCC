* write cost calcs to CSV
FILE ANt01 /''/;
*FILE ANt01 /results/%scenario%/costcalcs.csv/;
PUT ANt01; ANt01.ND=6; ANt01.PW=400; ANt01.PC=5;
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
PUTCLOSE ANt01;

* write Capacities to CSV
FILE ANt02 /''/;
PUT ANt02; ANt02.ND=6; ANt02.PW=400; ANt02.PC=5;
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
PUTCLOSE ANt02;

* write Builds to CSV
FILE ANt03 /''/;
PUT ANt03; ANt03.ND=6; ANt03.PW=400; ANt03.PC=5;
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
PUTCLOSE ANt03;

* write Electricity Supply to CSV
FILE ANt04 /''/;
PUT ANt04; ANt04.ND=6; ANt04.PW=400; ANt04.PC=5;
put "scenario","trun", "Country", "Technology", "Electricity Supply";
loop((trun,c,ELp),
put / '%scenario%',trun.TL, c.TL,ELp.TL,
    ELWAsupELp_xls(trun,c,ELp)
);
loop((trun,c),
put / '%scenario%',trun.TL, c.TL,'Cogen',
    ELWAsupELp_xls(trun,c,'Cogen')
);
PUTCLOSE ANt04;

* write Fuel Consumption to CSV
FILE ANt05 /''/;
PUT ANt05; ANt05.ND=6; ANt05.PW=400; ANt05.PC=5;
put "scenario","trun", "Country", "Fuel", "Fuel consumption","Fuel consumption - physical";
loop((trun,c,f),
put / '%scenario%',trun.TL, c.TL,f.TL,
    ELWAfcon_tot(trun,c,f),
    ELWAfcon_physical(c,trun,f)
);
PUTCLOSE ANt05;

* write Electricity Trade to CSV
FILE ANt06 /''/;
PUT ANt06; ANt06.ND=6; ANt06.PW=400; ANt06.PC=5;
put "scenario","trun", "Country", "Fuel", "ELectricity Trade";
loop((trun,c,cc),
put / '%scenario%',trun.TL, c.TL, cc.TL,
    RWELtrade_tot(trun,c,cc)
);
PUTCLOSE ANt06;



