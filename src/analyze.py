# analyze KEM GCC results
import pandas as pd 
import numpy as np 
import matplotlib.pyplot as plt  
import datetime as dt
import os
import sys
import subprocess

print("\nScript started. -- Current date/time:", dt.datetime.now().strftime("%Y-%m-%d %H:%M:%S"))

dfBuilds = pd.read_csv(r'results\DX\Builds.csv')
dfCapacities = pd.read_csv(r'results\DX\Capacities.csv')
dfcostcalcs = pd.read_csv(r'results\DX\costcalcs.csv')
dfELsup = pd.read_csv(r'results\DX\ELsup.csv')
dfELtrade = pd.read_csv(r'results\DX\ELtrade.csv')
dfELWAfcons = pd.read_csv(r'results\DX\ELWAfcons.csv')

# make function to do this for each df
dfPlot = dfBuilds.drop(['scenario','trun'], axis=1)
dfPlot = pd.pivot_table(dfPlot, values='Builds', index=['Country'], columns=['Technology'], aggfunc=np.sum)
dfPlot['Steam'] = dfPlot.loc[:,['Steam','Stscrub']].sum(axis=1)
dfPlot.drop(['Stscrub'],axis=1, inplace=True)
dfPlot['GT'] = dfPlot.loc[:,['GT','GTtoCC']].sum(axis=1)
dfPlot.drop(['GTtoCC'],axis=1, inplace=True)
dfPlot['CC'] = dfPlot.loc[:,['CC','CCcon']].sum(axis=1)
dfPlot.drop(['CCcon'],axis=1, inplace=True)

N = 6
ind = np.arange(N)
plt.rc(legend.fontsize=10)

plt.style.use('tableau-colorblind10')
dfPlot.plot(kind='bar', stacked=True, figsize=(16,12))
plt.show()

fig, axes = plt.subplots(nrows=3, ncols=7, sharex=share_x, sharey=share_y, figsize=(16,12))



dfELWAcap
dfELWAcap.rename(columns={'Unnamed: 0':'trun','Unnamed: 1':'Country','Unnamed: 2':'Technology'}, inplace=True)
dfELWAcap = dfELWAcap.set_index(['trun','Country','Technology']).stack().reset_index(name='Capacity')
dfELWAcap.rename(columns={'level_3':'Sector'}, inplace=True)
dfELWAcap = dfELWAcap.drop(['trun','Sector'], axis=1)
dfELWAcap = dfELWAcap.set_index(['Country','Technology']).unstack('Technology').reset_index()
dfELWAcap
#dfELWAcap[['']].plot(kind='bar', stacked=True)




print('\nScript finished.')