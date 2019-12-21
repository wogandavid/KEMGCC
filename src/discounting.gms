Scalar TRdiscountrate real discount rate for the transmission sector /0.06/;
Parameter TRdiscoef1(rr,cc,r,c,trun) discounting coefficient;

         TRdiscfact(trun)=discfact(TRdiscountrate,ord(trun));

*        Discounting capital costs over 35 years
         TRdiscoef1(rr,cc,r,c,trun) = discounting(30,TRdiscountrate,i,trun,time2);

         TRcapital(trun,rr,cc,r,c)=TRcapital(trun,rr,cc,r,c)*TRdiscoef1(rr,cc,r,c,trun);

*+++++++ Discounting power sector
*Capital costs will be discounted at 6% annually.
         scalar ELdiscountrate discount rate for electricity sector
/0.06/;
         ELdiscfact(trun)=discfact(ELdiscountrate,ord(trun));

         Parameter ELdiscoef1(ELp,trun), ELdiscoef2(trun);

*        Discounting plant capital costs over lifetime
         ELdiscoef1(ELp,trun) = discounting(ELlifetime(ELp),ELdiscountrate,i,trun,time2);
*        intdiscfact(ELdiscountrate,trun,time2)/sumdiscfact(ELlifetime(ELp),ELdiscountrate,i);

*        Discounting transmission capital costs over lifetime (35 trun periods)
         ELdiscoef2(trun) = discounting(35,ELdiscountrate,i,trun,time2);
*intdiscfact(ELdiscountrate,trun,time2)/sumdiscfact(35,ELdiscountrate,i);

         ELcapital(ELp,trun,r,c)=ELcapital(ELp,trun,r,c)*ELdiscoef1(ELp,trun);
*         ELconstcst(ELp,trun,r,c)=ELconstcst(ELp,trun,r,c)*ELdiscoef1(ELp,trun);
*         ELtranspurcst(r,c,trun,rr,cc)=ELtranspurcst(r,c,trun,rr,cc)*ELdiscoef2(trun);
*         ELtransconstcst(r,c,trun,rr,cc)=ELtransconstcst(r,c,trun,rr,cc)*ELdiscoef2(trun);

*+++++++ Discounting water submodel

         scalar  WAdiscrate discount rate for water sector /0.06/;
         WAdiscfact(trun) = discfact(WAdiscrate,ord(trun));

         parameter WAdiscoef1(WAp,trun),WAdiscoef2(trun);
         WAdiscoef2(trun) = intdiscfact(WAdiscrate,trun,time2);
*        intermediate discounting coefficients
         WAdiscoef1(WAp,trun) = discounting(WAlifetime(WAp),WAdiscrate,i,trun,time2);
*WAdiscoef2(trun)/sumdiscfact(WAlifetime(WAp),WAdiscrate,i);
*        discounting for Water plants over lifetime

         WAdiscoef2(trun) =  discounting(35,WAdiscrate,i,trun,time2);
*WAdiscoef2(trun)/sumdiscfact(35,WAdiscrate,i);
*        discounting for water transportation and storage equipment  for 35 year lifetime

         WApurcst(WAp,trun,r,c) = WApurcst(WAp,trun,r,c)*WAdiscoef1(WAp,trun);
         WAtranspurcst(trun,r,c,rr,cc) = WAtranspurcst("t1",r,c,rr,cc)* WAdiscoef2(trun);
         WAstopurcst(trun,rr,cc) = WAstopurcst("t1",rr,cc)* WAdiscoef2(trun);
         WAstoconstcst(trun,rr,cc) = WAstoconstcst("t1",rr,cc)* WAdiscoef2(trun);

*+++++++ Discounting upstream fuel submodel

         scalar  fdiscrate  fuel sector discounting rate /0.06/;
         fdiscfact(trun)=discfact(fdiscrate,ord(trun));

         parameter fdiscoef(fup,trun);
         fdiscoef(fup,trun) = discounting(35,fdiscrate,i,trun,time2);
*intdiscfact(fdiscrate,trun,time2)/sumdiscfact(flifetime(fup),fdiscrate,i);
*        discounting for transportation equipment  for 35 year lifetime

         ftranspurcst(fup,trun,r,c,rr,cc)=ftranspurcst(fup,"t1",r,c,rr,cc)*fdiscoef(fup,trun);
*         ftransconstcst(fup,trun,r,c,rr,cc)=ftransconstcst(fup,"t1",r,c,rr,cc)*fdiscoef(fup,trun);

$ontext
*+++++++ Discounting petchem submodel

         Scalars PCdiscountrate Real discount rate for petrochemicals sector
/0.08/;
         PCdiscfact(trun)=discfact(PCdiscountrate,ord(trun));

         parameter PCdiscoef(PCp,trun) Discounting coefficient;

*        Discounting process/plant capital costs over lifetime
*         PCdiscoef(PCp,trun) = intdiscfact(PCdiscountrate,trun,time2)/sumdiscfact(35,PCdiscountrate,i);
         PCdiscoef(PCp,trun) = discounting(35,PCdiscountrate,i,trun,time2);

         PCpurcst(PCp,trun,r,c)=PCpurcst(PCp,trun,r,c)*PCdiscoef(PCp,trun);
         PCconstcst(PCp,trun,r,c)=PCconstcst(PCp,trun,r,c)*PCdiscoef(PCp,trun);

*+++++++ Discounting refining submodel

         Scalars RFdiscountrate Real discount rate for refining sector
/0.08/;
         RFdiscfact(trun)=discfact(RFdiscountrate,ord(trun));

         parameter RFdiscoef(RFu,trun) Discounting coefficient for refining units;

         RFdiscoef(RFu,trun)=discounting(35,RFdiscountrate,i,trun,time2);
*intdiscfact(RFdiscountrate,trun,time2)/sumdiscfact(35,RFdiscountrate,i);
         RFpurcst(RFu,trun)=RFpurcst(RFu,trun)*RFdiscoef(RFu,trun);
         RFconstcst(RFu,trun)=RFconstcst(RFu,trun)*RFdiscoef(RFu,trun);

         parameter RFdiscoef2(trun) Discounting coefficient for power capacity;

         RFdiscoef2(trun)= discounting(35,RFdiscountrate,i,trun,time2);
*intdiscfact(RFdiscountrate,trun,time2)/sumdiscfact(35,RFdiscountrate,i);
         RFELpurcst(trun)=RFELpurcst(trun)*RFdiscoef2(trun);
         RFELconstcst(trun)=RFELconstcst(trun)*RFdiscoef2(trun);


*+++++++ Discounting cement sub model

         Scalars CMdiscountrate Real discount rate for cement sector
/0.06/;
         CMdiscfact(trun)=discfact(CMdiscountrate,ord(trun));

         parameter CMdiscoef(CMu,trun) Discounting coefficient for cement production units;
         CMdiscoef(CMu,trun)=discounting(25,CMdiscountrate,i,trun,time2);
*intdiscfact(CMdiscountrate,trun,time2)/sumdiscfact(25,CMdiscountrate,i);
         CMpurcst(CMu,trun)=CMpurcst(CMu,trun)*CMdiscoef(CMu,trun);
         CMconstcst(CMu,trun)=CMconstcst(CMu,trun)*CMdiscoef(CMu,trun);

         parameter CMdiscoef2(trun) Discounting coefficient for on-site power capacity;
         CMdiscoef2(trun)= discounting(35,CMdiscountrate,i,trun,time2);
*intdiscfact(CMdiscountrate,trun,time2)/sumdiscfact(35,CMdiscountrate,i);
         CMELpurcst(trun)=CMELpurcst(trun)*CMdiscoef2(trun);
         CMELconstcst(trun)=CMELconstcst(trun)*CMdiscoef2(trun);

         parameter CMdiscoef3(trun) Discounting coefficient for storage capacity;
         CMdiscoef3(trun)=  discounting(35,CMdiscountrate,i,trun,time2);
*intdiscfact(CMdiscountrate,trun,time2)/sumdiscfact(35,CMdiscountrate,i);
         CMstorpurcst(trun)=CMstorpurcst(trun)*CMdiscoef3(trun);
         CMstorconstcst(trun)=CMstorconstcst(trun)*CMdiscoef3(trun);
$offtext
