* transmission

parameters
TRexist(r,c,rr,cc) existing transmission capacity
TRcapital(time,r,c,rr,cc) capital cost of new transmission capacity in USD per GW per km
TRfixedOMcst(r,c,rr,cc) fixed O&M cost in USD per GW per km
TRleadtime(r,c,rr,cc) leadtime of new transmission build activities

TRomcst(r,c,rr,cc) OM cost
;

TRleadtime(r,c,rr,cc)=1;
TRleadtime(rr,cc,r,c)=TRleadtime(r,c,rr,cc);

TRexist(r,c,rr,cc)=0;
TRexist('sout','ksa','west','ksa')=2.5;
TRexist('sout','ksa','cent','ksa')=0.25;
TRexist('sout','ksa','east','ksa')=0;
TRexist('west','ksa','cent','ksa')=1.20;
TRexist('cent','ksa','east','ksa')=0.65*1.05;

TRexist('adwe','uae','dewa','uae')=1.15;
TRexist('adwe','uae','sewa','uae')=1.00;
TRexist('dewa','uae','sewa','uae')=1.15;
TRexist('dewa','uae','fewa','uae')=1.20;
TRexist('sewa','uae','fewa','uae')=1.00;

* GCC Interconnector
TRexist('east','ksa','qatr','qat')=1.20;
TRexist('east','ksa','adwe','uae')=1.20;
TRexist('east','ksa','kuwr','kuw')=1.20;
TRexist('east','ksa','bahr','bah')=0.6;

*TRexist('adwe','uae','omnr','omn')=0.4;

TRexist('sewa','uae','omnr','omn')=0.4;

TRexist(rr,cc,r,c)$(TRexist(r,c,rr,cc)>0)=TRexist(r,c,rr,cc);

TRexist('west','ksa','sout','ksa')=2.0;
TRexist('east','ksa','cent','ksa')=4.8;

TRexist(r,c,rr,cc)$(ord(r)=ord(rr) and rc(r,c) and rc(rr,cc) )=45;

option TRexist:0:3:1;
display TRexist;

* distances between nodes
parameter TRdistance(r,rr);
* intra-country distance unless otherwise specified

TRdistance('adwe','dewa')=100;
TRdistance('adwe','sewa')=100;

TRdistance('dewa','sewa')=100;
TRdistance('dewa','fewa')=100;

TRdistance('sewa','fewa')=100;

*TRdistance('sout','west')=100;

TRdistance('east','west')=850+230;

TRdistance('sout','west')=320;
TRdistance('sout','cent')=815;
TRdistance('sout','east')=1190;
TRdistance('west','cent')=850;
TRdistance('cent','east')=230;

TRdistance('sout','sout')=123;
TRdistance('west','west')=539;
TRdistance('cent','cent')=392;
TRdistance('east','east')=509;

TRdistance('adwe','adwe')=1;
TRdistance('dewa','dewa')=1;
TRdistance('sewa','sewa')=1;
TRdistance('fewa','fewa')=1;

* Interconnector
TRdistance('east','qatr')=290+100;
*TRdistance('qatr','east')=290+100;

TRdistance('east','kuwr')=310;
*TRdistance('kuwr','east')=310;

TRdistance('east','adwe')=290+150;
*TRdistance('adwe','east')=290+150;

TRdistance('east','bahr')=112;
*TRdistance('bahr','east')=112;

TRdistance('adwe','east')=52;
*TRdistance('adwe','east')=52;

*TRdistance('adwe','omnr')=52;
TRdistance('sewa','omnr')=52;

TRdistance(r,rr)$(ord(r)=ord(rr) )=100;

Loop((r,rr),
TRdistance(rr,r)=TRdistance(r,rr);
);

display trdistance;

Table TRtransyield(r,c,rr,cc) net of transmission and distribution losses
          west.ksa  sout.ksa  cent.ksa  east.ksa
west.ksa  0.96      0.925     0.905     0.86
sout.ksa  0.925     0.96      0.87      0.81
cent.ksa  0.905     0.87      0.96      0.93
east.ksa  0.86      0.81      0.93      0.96
adwe.uae  0         0         0         0.9
dewa.uae  0         0         0         0
sewa.uae  0         0         0         0
fewa.uae  0         0         0         0
qatr.qat  0         0         0         0.9
kuwr.kuw  0         0         0         0.9
bahr.bah  0         0         0         0.9
omnr.omn  0         0         0         0

+          adwe.uae     dewa.uae     sewa.uae  fewa.uae
west.ksa   0            0            0         0
sout.ksa   0            0            0         0
cent.ksa   0            0            0         0
east.ksa   0.9          0            0         0
adwe.uae   0.96         0.9          .9        0
dewa.uae   0.9          0.96         0.9       0.9
sewa.uae   0.9          0.9          0.96      0.9
fewa.uae   0            0.9          0.9       0.96
qatr.qat   0            0            0         0
kuwr.kuw   0            0            0         0
bahr.bah   0            0            0         0
omnr.omn   0            0            0.9       0

+           qatr.qat   kuwr.kuw   bahr.bah   omnr.omn
west.ksa    0          0          0          0
sout.ksa    0          0          0          0
cent.ksa    0          0          0          0
east.ksa    0.9        0.9        0.9        0
adwe.uae    0          0          0          0
dewa.uae    0          0          0          0
sewa.uae    0          0          0          0.9
fewa.uae    0          0          0          0
qatr.qat    0.94       0          0          0
kuwr.kuw    0          0.9        0          0
bahr.bah    0          0          0.9        0
omnr.omn    0          0          0          0.9
;



*ETSAP (2014), page 12.
TRcapital(time,r,c,rr,cc)=3.00*1e0;
TRcapital(time,rr,cc,r,c)=TRcapital(time,r,c,rr,cc);

TRfixedomcst(r,c,rr,cc)=0.015*TRcapital('t1',r,c,rr,cc);
TRfixedomcst(rr,cc,r,c)=TRfixedomcst(r,c,rr,cc);

TRomcst(r,c,rr,cc)=0.005*TRcapital('t1',r,c,rr,cc);
TRomcst(rr,cc,r,c)=TRomcst(r,c,rr,cc);

parameter TReleccst(ELl,ELs,ELday,time,r,c) adminstered electricity price in USD per MWh;
TReleccst(ELl,ELs,ELday,time,r,c)$rKSA(r,c)=20;
TReleccst(ELl,ELs,ELday,time,r,c)$rQAT(r,c)=20;
TReleccst(ELl,ELs,ELday,time,r,c)$rUAE(r,c)=20;
TReleccst(ELl,ELs,ELday,time,r,c)$rKUW(r,c)=20;
TReleccst(ELl,ELs,ELday,time,r,c)$rBAH(r,c)=20;
TReleccst(ELl,ELs,ELday,time,r,c)$rOMN(r,c)=20;

* set existing capacity
TRexistcp.fx(r,c,rr,cc,'t1')=TRexist(r,c,rr,cc);
TRexistcp.fx(r,c,rr,cc,'t1')=TRexist(r,c,rr,cc);
;

TRpangle.up(ELl,ELs,ELday,r,c,trun)=0.6;
TRpangle.lo(ELl,ELs,ELday,r,c,trun)=-0.6;

Equations
TRobjective objective function of transmission sector

TRdem(ELl,ELs,ELday,time,r,c) demand balance
TRcaplim(ELl,ELs,ELday,time,r,c,rr,cc)

TRcapitalcostbal(time)
TRopmaintbal(time)
TRbldbal(r,c,rr,cc,time) build equal capacity in both directions
TRcapbal(r,c,rr,cc,time)

TRtradecap(ELl,ELs,ELday,time,c)

*TRpanglebal(ELl,ELs,ELday,r,c,rr,cc,time)
*DTRpangle(ELl,ELs,ELday,r,c,time)
;

$ontext
TRpanglebal(ELl,ELs,ELday,r,c,rr,cc,t)$(rc(r,c) and rc(rr,cc) and (ord(r)<ord(rr)) and TRtransyield(r,c,rr,cc)>0)..
 TRnodaltrans(ELl,ELs,ELday,t,r,c,rr,cc)*TRtransyield(r,c,rr,cc)/(ELlchours(ELl,c)*ELdaysinseason(ELs,ELday))
-(TRpangle(ELl,ELs,ELday,r,c,t)
 -TRpangle(ELl,ELs,ELday,rr,cc,t)
  )=e=0;

DTRpangle(ELl,ELs,ELday,r,c,t)$rc(r,c)..
0=g=
-sum((rr,cc)$(rc(r,c) and rc(rr,cc) and (ord(r)<ord(rr)) and TRtransyield(r,c,rr,cc)>0),DTRpanglebal(ELl,ELs,ELday,r,c,rr,cc,t))
+sum((rr,cc)$(rc(r,c) and rc(rr,cc) and (ord(r)>ord(rr)) and TRtransyield(r,c,rr,cc)>0),DTRpanglebal(ELl,ELs,ELday,rr,cc,r,c,t))
;
$offtext

TRtradecap(ELl,ELs,ELday,t,c)$(call(c) and tradecap=1)..
 ELtrademax(t,ELl,ELs,ELday,c)$call(c)
-sum((r,rr,cc)$(not sameas(c,cc) and call(cc)) ,TRnodaltrans(ELl,ELs,ELday,t,r,c,rr,cc)*TRtransyield(r,c,rr,cc))
=g=0
;

*Objective function, to minimize total transmission costs. O&M costs, investment
*costs, and electricity purchase from generators.
TRobjective.. TRz=e=
  sum(t,TRopmaint(t)*TRdiscfact(t))
 +sum(t,TRcapitalcost(t)*TRdiscfact(t))
 +sum( (ELl,ELs,ELday,t,r,c)$rc(r,c),
*           ( (TReleccst(ELl,ELs,ELday,t,r,c)*TRdiscfact(t)))
           ( TReleccst(ELl,ELs,ELday,t,r,c)*TRdiscfact(t)$(TRdereg=0)
*             +DELsup(ELl,ELs,ELday,t,r,c)$(TRdereg=1)
            )*ELsupply(ELl,ELs,ELday,t,r,c)
       );

TRdem(ELl,ELs,ELday,t,rr,cc)$(rc(rr,cc))..
  ELsupply(ELl,ELs,ELday,t,rr,cc)
 +sum((r,c)$(rc(r,c) and rc(rr,cc) and (TRtransyield(r,c,rr,cc)>0)),
          TRnodaltrans(ELl,ELs,ELday,t,r,c,rr,cc)*TRtransyield(r,c,rr,cc)
         -TRnodaltrans(ELl,ELs,ELday,t,rr,cc,r,c)*TRtransyield(r,c,rr,cc)
      )
 =g=
  ELlchours(ELl,cc)*ELdaysinseason(ELs,ELday)*ELlcgw(ELl,ELs,ELday,rr,cc)*ELdemgro(t,rr,cc);

TRcaplim(ELl,ELs,ELday,t,r,c,rr,cc)$(rc(r,c) and rc(rr,cc) and TRtransyield(r,c,rr,cc)>0)..
  ELlchours(ELl,c)*ELdaysinseason(ELs,ELday)*( TRexistcp(r,c,rr,cc,t)
                                            +TRbld(r,c,rr,cc,t)$(t_ind(t)>TRleadtime(r,c,rr,cc))
                                            )
 -TRnodaltrans(ELl,ELs,ELday,t,r,c,rr,cc)*TRtransyield(r,c,rr,cc)
 -TRnodaltrans(ELl,ELs,ELday,t,rr,cc,r,c)*TRtransyield(r,c,rr,cc)
 =g=0;

* balance existing capacity with new builds
TRcapbal(r,c,rr,cc,t)$(rc(r,c) and rc(rr,cc) )..
  TRexistcp(r,c,rr,cc,t)
 +TRbld(r,c,rr,cc,t)$(t_ind(t)>TRleadtime(r,c,rr,cc))
 -TRexistcp(r,c,rr,cc,t+1)
 =g=0;

* build in both directions
TRbldbal(r,c,rr,cc,t)$(rc(r,c) and rc(rr,cc) and t_ind(t)>TRleadtime(r,c,rr,cc) and (not sameas(r,rr)))..
  TRbld(r,c,rr,cc,t)
 -TRbld(rr,cc,r,c,t)
 =e=0;


TRopmaintbal(t)..
* fixed OM
TRopmaint(t)
 -sum((r,c,rr,cc)$(rc(r,c) and rc(rr,cc)),
      TRfixedomcst(r,c,rr,cc)*TRdistance(r,rr)*(TRexistcp(r,c,rr,cc,t)+TRbld(r,c,rr,cc,t)$(t_ind(t)>TRleadtime(r,c,rr,cc)))
      )

* variable OM of nodal transmission
 -sum((ELl,ELs,ELday,r,c,rr,cc)$(rc(r,c) and rc(rr,cc) and (TRtransyield(r,c,rr,cc)>0)),
       TRomcst(r,c,rr,cc)*TRdistance(r,rr)*TRnodaltrans(ELl,ELs,ELday,t,r,c,rr,cc)*TRtransyield(r,c,rr,cc))

* variable OM of same region transmission - do not double count nodal trans
 -sum((ELl,ELs,ELday,r,c)$(rc(r,c)), TRomcst(r,c,r,c)*TRdistance(r,r)*(ELsupply(ELl,ELs,ELday,t,r,c)
                               -sum((rr,cc)$(rc(rr,cc)and (TRtransyield(r,c,rr,cc)>0)),
                                    TRnodaltrans(ELl,ELs,ELday,t,r,c,rr,cc)*TRtransyield(r,c,rr,cc)) )
      )
  =e=0;

TRcapitalcostbal(t)..
  TRcapitalcost(t)
 -sum((r,c,rr,cc)$(rc(r,c) and rc(rr,cc) and t_ind(t)>TRleadtime(r,c,rr,cc)),
        TRcapital(t,r,c,rr,cc)*TRdistance(r,rr)*TRbld(r,c,rr,cc,t)
      )
 =e=0;

equations
DTRopmaint(time) Operation and maintenance cost for transmission  in million USD
DTRcapitalcost(time) Capital cost for transmission in million USD
DTRexistcp(r,c,rr,cc,time) Existing transmission capacity in GW in time trun
DTRbld(r,c,rr,cc,time) transmission buil in GW
DTRnodaltrans(ELl,ELs,ELday,time,r,c,rr,cc) Electricity transmitted in TWh
DELsupply(ELl,ELs,ELday,time,r,c) electricity supplied by power plants
;

DTRnodaltrans(ELl,ELs,ELday,t,r,c,rr,cc)$((rc(r,c) and rc(rr,cc)) and (TRtransyield(r,c,rr,cc)>0) )..
 0=g=
 -TRomcst(r,c,rr,cc)*TRdistance(r,rr)*DTRopmaintbal(t)*TRtransyield(r,c,rr,cc)
 +DTRdem(ELl,ELs,ELday,t,rr,cc)*TRtransyield(r,c,rr,cc)
 -DTRdem(ELl,ELs,ELday,t,r,c)*TRtransyield(r,c,rr,cc)
 +(
 -DTRcaplim(ELl,ELs,ELday,t,r,c,rr,cc)*TRtransyield(r,c,rr,cc)$(TRtransyield(r,c,rr,cc)>0)
 -DTRcaplim(ELl,ELs,ELday,t,rr,cc,r,c)*TRtransyield(r,c,rr,cc)$(TRtransyield(r,c,rr,cc)>0)
 +TRomcst(r,c,r,c)*TRdistance(r,r)*DTRopmaintbal(t)*TRtransyield(r,c,rr,cc)
 )
*-DTRtradecap(ELl,ELs,ELday,t,c)$(call(c)  and call(cc) and (not sameas(c,cc)) and tradecap=1)*TRtransyield(r,c,rr,cc)
-DTRtradecap(ELl,ELs,ELday,t,c)$(call(c) and (not sameas(c,cc)) and tradecap=1)*TRtransyield(r,c,rr,cc)
*+DTRpanglebal(ELl,ELs,ELday,r,c,rr,cc,t)*TRtransyield(r,c,rr,cc)$(ord(r)<ord(rr))/(ELlchours(ELl,c)*ELdaysinseason(ELs,ELday))
;

DTRopmaint(t)..
  1*TRdiscfact(t) =g= DTRopmaintbal(t);

DTRcapitalcost(t)..
  1*TRdiscfact(t) =g= DTRcapitalcostbal(t);

DTRexistcp(r,c,rr,cc,t)$(rc(r,c) and rc(rr,cc) )..
0=g=
 -TRfixedomcst(r,c,rr,cc)*TRdistance(r,rr)*DTRopmaintbal(t)
 +DTRcapbal(r,c,rr,cc,t)
 -DTRcapbal(r,c,rr,cc,t-1)
 +sum((ELl,ELs,ELday)$(TRtransyield(r,c,rr,cc)>0),DTRcaplim(ELl,ELs,ELday,t,r,c,rr,cc)*ELlchours(ELl,c)*ELdaysinseason(ELs,ELday))
;

DTRbld(r,c,rr,cc,t)$(rc(r,c) and rc(rr,cc) and t_ind(t)>TRleadtime(r,c,rr,cc))..
0=g=
 -DTRcapitalcostbal(t)*TRcapital(t,r,c,rr,cc)*TRdistance(r,rr)
 -TRfixedomcst(r,c,rr,cc)*TRdistance(r,rr)*DTRopmaintbal(t)
 +DTRbldbal(r,c,rr,cc,t)$((not sameas(r,rr)))
 -DTRbldbal(rr,cc,r,c,t)$((not sameas(r,rr)))
 +DTRcapbal(r,c,rr,cc,t)
 +sum((ELl,ELs,ELday)$(TRtransyield(r,c,rr,cc)>0),DTRcaplim(ELl,ELs,ELday,t,r,c,rr,cc)*ELlchours(ELl,c)*ELdaysinseason(ELs,ELday));



DELsupply(ELl,ELs,ELday,t,r,c)$(rc(r,c) )..
0=g=
* needs to be minus
 -(
  TReleccst(ELl,ELs,ELday,t,r,c)*TRdiscfact(t)$(TRdereg=0)
 +DELsup(ELl,ELs,ELday,t,r,c)$(rc(r,c) and (TRdereg=1))
   )
+DTRdem(ELl,ELs,ELday,t,r,c)$rc(r,c)
-DELsup(ELl,ELs,ELday,t,r,c)$rc(r,c)
-TRomcst(r,c,r,c)*TRdistance(r,r)*DTRopmaintbal(t)
;
