import numpy as np
import gdxpds
import pandas as pd

#files = [
#    '../results/Sensitivities/CO2/costs/results_cost_calcs_B30.gdx',
#    '../results/Sensitivities/CO2/costs/results_cost_calcs_D30.gdx',
#    '../results/Sensitivities/CO2/costs/results_cost_calcs_F30.gdx',
#    '../results/Sensitivities/CO2/costs/results_cost_calcs_H30.gdx',
#    '../results/Sensitivities/CO2/costs/results_cost_calcs_B90.gdx',
#    '../results/Sensitivities/CO2/costs/results_cost_calcs_D90.gdx',
#    '../results/Sensitivities/CO2/costs/results_cost_calcs_F90.gdx',
#    '../results/Sensitivities/CO2/costs/results_cost_calcs_H90.gdx',
##
#    '../results/Sensitivities/Int2x/costs/results_cost_calcs_Cint.gdx',
#    '../results/Sensitivities/Int2x/costs/results_cost_calcs_Dint.gdx',
#    '../results/Sensitivities/Int2x/costs/results_cost_calcs_Gint.gdx',
#    '../results/Sensitivities/Int2x/costs/results_cost_calcs_Hint.gdx',
##
#    '../results/Sensitivities/Oil and gas prices/costs/results_cost_calcs_Aoil.gdx',
#    '../results/Sensitivities/Oil and gas prices/costs/results_cost_calcs_Boil.gdx',
#    '../results/Sensitivities/Oil and gas prices/costs/results_cost_calcs_Coil.gdx',
#    '../results/Sensitivities/Oil and gas prices/costs/results_cost_calcs_Doil.gdx',
#    '../results/Sensitivities/Oil and gas prices/costs/results_cost_calcs_Eoil.gdx',
#    '../results/Sensitivities/Oil and gas prices/costs/results_cost_calcs_Foil.gdx',
#    '../results/Sensitivities/Oil and gas prices/costs/results_cost_calcs_Goil.gdx',
#    '../results/Sensitivities/Oil and gas prices/costs/results_cost_calcs_Hoil.gdx',
##
#    '../results/Sensitivities/RE costs/costs/results_cost_calcs_Are.gdx',
#    '../results/Sensitivities/RE costs/costs/results_cost_calcs_Bre.gdx',
#    '../results/Sensitivities/RE costs/costs/results_cost_calcs_Cre.gdx',
#    '../results/Sensitivities/RE costs/costs/results_cost_calcs_Dre.gdx',
#    '../results/Sensitivities/RE costs/costs/results_cost_calcs_Ere.gdx',
#    '../results/Sensitivities/RE costs/costs/results_cost_calcs_Fre.gdx',
#    '../results/Sensitivities/RE costs/costs/results_cost_calcs_Gre.gdx',
#    '../results/Sensitivities/RE costs/costs/results_cost_calcs_Hre.gdx',
#]

files = [
    '../results/Sensitivities/CO2/costs/results_cost_calcs_carbon_B30.gdx',
    '../results/Sensitivities/CO2/costs/results_cost_calcs_carbon_D30.gdx',
    '../results/Sensitivities/CO2/costs/results_cost_calcs_carbon_F30.gdx',
    '../results/Sensitivities/CO2/costs/results_cost_calcs_carbon_H30.gdx',
    '../results/Sensitivities/CO2/costs/results_cost_calcs_carbon_B90.gdx',
    '../results/Sensitivities/CO2/costs/results_cost_calcs_carbon_D90.gdx',
    '../results/Sensitivities/CO2/costs/results_cost_calcs_carbon_F90.gdx',
    '../results/Sensitivities/CO2/costs/results_cost_calcs_carbon_H90.gdx',
#
    '../results/Sensitivities/Int2x/costs/results_cost_calcs_carbon_Cint.gdx',
    '../results/Sensitivities/Int2x/costs/results_cost_calcs_carbon_Dint.gdx',
    '../results/Sensitivities/Int2x/costs/results_cost_calcs_carbon_Gint.gdx',
    '../results/Sensitivities/Int2x/costs/results_cost_calcs_carbon_Hint.gdx',
#
    '../results/Sensitivities/Oil and gas prices/costs/results_cost_calcs_carbon_Aoil.gdx',
    '../results/Sensitivities/Oil and gas prices/costs/results_cost_calcs_carbon_Boil.gdx',
    '../results/Sensitivities/Oil and gas prices/costs/results_cost_calcs_carbon_Coil.gdx',
    '../results/Sensitivities/Oil and gas prices/costs/results_cost_calcs_carbon_Doil.gdx',
    '../results/Sensitivities/Oil and gas prices/costs/results_cost_calcs_carbon_Eoil.gdx',
    '../results/Sensitivities/Oil and gas prices/costs/results_cost_calcs_carbon_Foil.gdx',
    '../results/Sensitivities/Oil and gas prices/costs/results_cost_calcs_carbon_Goil.gdx',
    '../results/Sensitivities/Oil and gas prices/costs/results_cost_calcs_carbon_Hoil.gdx',
#
    '../results/Sensitivities/RE costs/costs/results_cost_calcs_carbon_Are.gdx',
    '../results/Sensitivities/RE costs/costs/results_cost_calcs_carbon_Bre.gdx',
    '../results/Sensitivities/RE costs/costs/results_cost_calcs_carbon_Cre.gdx',
    '../results/Sensitivities/RE costs/costs/results_cost_calcs_carbon_Dre.gdx',
    '../results/Sensitivities/RE costs/costs/results_cost_calcs_carbon_Ere.gdx',
    '../results/Sensitivities/RE costs/costs/results_cost_calcs_carbon_Fre.gdx',
    '../results/Sensitivities/RE costs/costs/results_cost_calcs_carbon_Gre.gdx',
    '../results/Sensitivities/RE costs/costs/results_cost_calcs_carbon_Hre.gdx',
]

scenarios = [
    'B30','D30','F30','H30','B90','D90','F90','H90',
    'Cint','Dint','Gint','Hint',
    'Aoil','Boil','Coil','Doil','Eoil','Foil','Goil','Hoil',
    'Are','Bre','Cre','Dre','Ere','Fre','Gre','Hre']
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
    #costcalcs = _df['RWcostcalcs']
    #costcalcs.columns = ['trun','item','c','value']
    costcalcs = _df['RWnet_carbonrecycle']
    costcalcs.columns = ['trun','c','value']
    costcalcs['scenario'] = scenario
    
    #costcalcs = costcalcs[costcalcs['item']=='Total System']
    
    costcalcs = costcalcs.replace(years)
    costcalclist.append(costcalcs)

final_df = pd.concat(costcalclist)

to_write ={}
to_write['costcalcs'] = final_df

with pd.ExcelWriter('../results/Sensitivities/costcalcs_sensitivities_with.xlsx') as writer:
    for k, v in to_write.items():
        v.to_excel(writer, sheet_name=k, merge_cells=False,float_format='%.2f',index=False)