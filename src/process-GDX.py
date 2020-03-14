import matplotlib.pyplot as plt
import numpy as np
import gdxpds
import pandas as pd
import glob

#files = glob.glob('../results/Sensitivies/results_0*.gdx')
files = ['../results/Sensitivies/results_A.gdx',
         '../results/Sensitivies/results_B.gdx',
         '../results/Sensitivies/results_C.gdx',
         '../results/Sensitivies/results_D.gdx',
         '../results/Sensitivies/results_E.gdx',
         '../results/Sensitivies/results_F.gdx',
         '../results/Sensitivies/results_G.gdx',
         '../results/Sensitivies/results_H.gdx']

scenarios = ['A','B','C','D','E','F','G','H']
countries = ['bah','kuw','omn','qat','ksa','uae']

_fuel_cons_list = []
_ELWAbld_xls_list = []
_ELWAcap_list = []
_ELWAsupELp_xls_list = []
_WAcapSingle_list = []
_RWELtrade_tot_list = []
_RWEMallquant_list = []
_Invest_list = []

_RWELtrade_tot_dict ={}

years = {'t01':'2015',
         't02':'2016',
         't03':'2017',
         't04':'2018',
         't05':'2019',
         't06':'2020',
         't07':'2021',
         't08':'2022',
         't09':'2023',
         't10':'2024',
         't11':'2025',
         't12':'2026',
         't13':'2027',
         't14':'2028',
         't15':'2029',
         't16':'2030'}

fuels = {'methane':'NG',
         'arablight':'oil'}

# reshape
for filename, scenario in zip(files, scenarios):
    
    _dataframes = gdxpds.to_dataframes(filename)
    
    # fuel consumption
    _fuel_cons = _dataframes['ELWAfcon_xls']
    _fuel_cons.columns = ['c','trun','f','value']
    _fuel_cons['scenario'] = scenario
    #_fuel_cons = _fuel_cons.set_index(['scenario','c','trun','f'])
    #_fuel_cons = _fuel_cons.pivot_table(values='Value',index=['scenario','c'],columns='f')
    _fuel_cons = _fuel_cons.replace(years)
    _fuel_cons = _fuel_cons.replace(fuels)
    _fuel_cons_list.append(_fuel_cons)
    
    # Technology builds
    _ELWAbld_xls = _dataframes['ELWAbld_xls']
    _ELWAbld_xls.columns = ['c','trun','ELp','value']
    _ELWAbld_xls['scenario'] = scenario
    _ELWAbld_xls = _ELWAbld_xls.replace(years)
    _ELWAbld_xls = _ELWAbld_xls.replace(fuels)
    _ELWAbld_xls_list.append(_ELWAbld_xls)
    
    # Installed Capacity
    _ELWAcap = _dataframes['ELWAcap']
    _ELWAcap.columns = ['trun','c','ELp','sector','value']
    _ELWAcap = _ELWAcap.drop(columns='sector')
    _ELWAcap['scenario'] = scenario
    _ELWAcap = _ELWAcap.replace(years)
    _ELWAcap = _ELWAcap.replace(fuels)
    #_ELWAcap = _ELWAcap.pivot_table(values='value',index=['scenario','c','trun'],columns='ELp')
    _ELWAcap_list.append(_ELWAcap)

    # Electricity Generation
    _ELWAsupELp_xls = _dataframes['ELWAsupELp_xls']
    _ELWAsupELp_xls.columns = ['trun','c','ELp','value']
    _ELWAsupELp_xls['scenario'] = scenario
    _ELWAsupELp_xls = _ELWAsupELp_xls.replace(years)
    _ELWAsupELp_xls = _ELWAsupELp_xls.replace(fuels)
    #_ELWAsupELp_xls = _ELWAsupELp_xls.pivot_table(values='value',index=['scenario','c','trun'],columns='ELp')
    _ELWAsupELp_xls_list.append(_ELWAsupELp_xls)
    
    # Water capacity
    _WAcapSingle = _dataframes['WAcapSingle']
    _WAcapSingle.columns = ['trun','c','WAp','sector','value']
    _WAcapSingle = _WAcapSingle.drop(columns='sector')
    _WAcapSingle['scenario'] = scenario
    _WAcapSingle = _WAcapSingle.replace(years)
    _WAcapSingle = _WAcapSingle.replace(fuels)
    _WAcapSingle_list.append(_WAcapSingle)
    
    # Electrcitiy trade
    _RWELtrade_tot = _dataframes['RWELtrade_tot']
    _RWELtrade_tot.columns = ['trun','c','cc','value']
    _RWELtrade_tot['scenario'] = scenario
    _RWELtrade_tot = _RWELtrade_tot.replace(years)
    
    #_RWELtrade_tot = _RWELtrade_tot.set_index(['scenario','c','trun','cc'])
    #_RWELtrade_tot = _RWELtrade_tot.pivot_table(values='value',index=['scenario','c'],columns='cc')
    #_RWELtrade_tot_dict[scenario] = _RWELtrade_tot
    _RWELtrade_tot_list.append(_RWELtrade_tot)
    
    # CO2 emissions
    _RWEMallquant = _dataframes['RWEMallquant']
    _RWEMallquant.columns = ['trun','c','value']
    _RWEMallquant['scenario'] = scenario 
    _RWEMallquant = _RWEMallquant.replace(years)
    _RWEMallquant_list.append(_RWEMallquant)
    
    # Investments
    _Invest = _dataframes['Invest']
    _Invest.columns = ['trun','tech','sector','value']
    _Invest['scenario'] = scenario
    _Invest = _Invest.replace(years)
    _Invest_list.append(_Invest)

# concat
fuel_cons_df = pd.concat(_fuel_cons_list)
#fuel_cons_df.info()

ELWAbld_xls_df = pd.concat(_ELWAbld_xls_list)
#ELWAbld_xls_df.info()

_ELWAcap_df = pd.concat(_ELWAcap_list)
#_ELWAcap_df.info()

_ELWAsupELp_xls_df = pd.concat(_ELWAsupELp_xls_list)
#_ELWAsupELp_xls_df.info()

_WAcapSingle_df = pd.concat(_WAcapSingle_list)
_RWELtrade_tot_df = pd.concat(_RWELtrade_tot_list)
_RWEMallquant_df = pd.concat(_RWEMallquant_list)
_Invest_df = pd.concat(_Invest_list)

fuel_cons_df = fuel_cons_df.astype({"trun": int})
_ELWAcap_df = _ELWAcap_df.astype({"trun": int})
ELWAbld_xls_df = ELWAbld_xls_df.astype({"trun": int})
_ELWAsupELp_xls_df = _ELWAsupELp_xls_df.astype({"trun": int})
_RWEMallquant_df = _RWEMallquant_df.astype({"trun": int})
_Invest_df = _Invest_df.astype({"trun": int})

_RWELtrade_tot_df = _RWELtrade_tot_df.astype({"trun": int})

# write to CSV
fuel_cons_df.to_csv('../tableau/fuel_cons.csv', index=False)
_ELWAcap_df.to_csv('../tableau/capacity.csv', index=False)
ELWAbld_xls_df.to_csv('../tableau/builds.csv', index=False)
_ELWAsupELp_xls_df.to_csv('../tableau/Elsup.csv', index=False)
_RWEMallquant_df.to_csv('../tableau/emissions.csv', index=False)
_Invest_df.to_csv('../tableau/investments.csv', index=False)
_RWELtrade_tot_df.to_csv('../tableau/trade.csv', index=False)