import numpy as np
import gdxpds
import pandas as pd

files = [
    '../results/Sensitivities/CO2/costs/results_cost_calcs_B30.gdx',
    '../results/Sensitivities/CO2/costs/results_cost_calcs_D30.gdx',
    '../results/Sensitivities/CO2/costs/results_cost_calcs_F30.gdx',
    '../results/Sensitivities/CO2/costs/results_cost_calcs_H30.gdx',
    '../results/Sensitivities/CO2/costs/results_cost_calcs_B90.gdx',
    '../results/Sensitivities/CO2/costs/results_cost_calcs_D90.gdx',
    '../results/Sensitivities/CO2/costs/results_cost_calcs_F90.gdx',
    '../results/Sensitivities/CO2/costs/results_cost_calcs_H90.gdx'
]
scenarios = ['B30','D30','F30','H30','B90','D90','F90','H90']
countries = ['bah','kuw','omn','qat','ksa','uae']

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

costcalclist = []

for filename, scenario in zip(files, scenarios):
    _df = gdxpds.to_dataframes(filename)
    costcalcs = _df['RWcostcalcs']
    costcalcs.columns = ['trun','item','c','value']
    costcalcs['scenario'] = scenario
    
    costcalcs = costcalcs[costcalcs['item']=='Total System']
    
    costcalcs = costcalcs.replace(years)
    costcalclist.append(costcalcs)
    
final_df = pd.concat(costcalclist)

to_write ={}
to_write['costcalcs'] = final_df

with pd.ExcelWriter('../results/Sensitivities/costcalcs_sensitivities.xlsx') as writer:
    for k, v in to_write.items():
        v.to_excel(writer, sheet_name=k, merge_cells=False,float_format='%.2f',index=False)