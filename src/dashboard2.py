import numpy as np
import pandas as pd
import param
import panel as pn
import holoviews as hv
from holoviews import opts, dim
import hvplot.pandas

# IMPORT results files
df_cap = pd.read_csv('../results/capacity.csv')
df_fuel = pd.read_csv('../results/fuel_cons.csv')
df_ELsup = pd.read_csv('../results/Elsup.csv')
df_emissions = pd.read_csv('../results/emissions.csv')
df_trade = pd.read_csv('../results/trade.csv')
df_investments = pd.read_csv('../results/investments.csv')

df_investments['value'] = np.divide(df_investments['value'],1000)

names = {
    'bah':'Bahrain',
    'kuw':'Kuwait',
    'ksa':'Saudi Arabia',
    'omn':'Oman',
    'qat':'Qatar',
    'uae':'UAE'}

df_cap = df_cap.replace(names)
df_fuel = df_fuel.replace(names)
df_ELsup = df_ELsup.replace(names)
df_emissions = df_emissions.replace(names)
df_trade = df_trade.replace(names)
df_investments = df_investments.replace(names)

countries = ['Bahrain','Kuwait','Oman','Qatar','Saudi Arabia','UAE']
fuels = ['HFO','diesel','NG','Arablight']
scenarios = ['A','B','C','D','E','F','G','H']

# CREATE CLASSES FOR PLOTS
class CAPACITY(param.Parameterized):
    country_selector = param.ObjectSelector(default="Saudi Arabia", objects=countries)
    year_range = param.Range(default=(2015, 2030), bounds=(2015, 2030))
    #scenario_selector = param.ObjectSelector(default="G", objects=scenarios)
    show_legend = param.Boolean(False, doc="Show the legend")
    
    def get_data_cap(self):
        start_date = self.year_range[0]
        end_date = self.year_range[1]
        country = self.country_selector
        
        mask =  (df_cap['c'] == country) & (df_cap['trun'] >= start_date) & (df_cap['trun'] <= end_date)
        
        _df = df_cap.loc[mask]
        
        df_pivot = _df.pivot_table(index=['c','trun','scenario'],columns='ELp',values='value',fill_value=0)
        df_pivot = df_pivot.reset_index(drop=False)
        
        return df_pivot
   
    def plot_cap(self,scenario):
        country = self.country_selector
        #scenario = self.scenario_selector
        _df  = self.get_data_cap()
        mask = (_df['scenario']==scenario)
        data = _df.loc[mask].reset_index(drop=True)      
        
        title = country + ' for Scenario ' + scenario
        
        ELp_list = data.drop(['c','trun','scenario'],axis=1).columns.values.tolist()

        plot = data.hvplot.bar(x='trun',
                               y=ELp_list,
                               value_label='GW',
                               title=title,
                               alpha=0.4,
                               stacked=True,
                               width=300,
                               shared_axes=False,
                               legend=self.show_legend,
                               rot=90)
        return plot
        
    def plot_caps(self):
        p_list = []
        for scenario in scenarios:
            p = self.plot_cap(scenario)
            p_list.append(p)
            layout_cap = hv.Layout(p_list)
        return layout_cap

    def plot_cap_tot(self,scenario):
        _df = df_cap.pivot_table(index=['trun','scenario'],columns='ELp',values='value',fill_value=0,aggfunc=np.sum).reset_index()
        
        start_date = self.year_range[0]
        end_date = self.year_range[1]
       
        mask = (_df['scenario']==scenario) & (df_ELsup['trun'] >= start_date) & (df_ELsup['trun'] <= end_date)
        data = _df.loc[mask]    
        
        title = 'Scenario ' + scenario
        
        ELp_list = data.drop(['trun','scenario'],axis=1).columns.values.tolist()

        plot = data.hvplot.bar(x='trun',
                               y=ELp_list,
                               value_label='GW',
                               title=title,
                               alpha=0.4,
                               stacked=True,
                               width=300,
                               shared_axes=False,
                               legend=self.show_legend,
                               rot=90)
        return plot
    
    def plot_caps_tot(self):
        p_list = []
        for scenario in scenarios:
            p = self.plot_cap_tot(scenario)
            p_list.append(p)
            layout_cap = hv.Layout(p_list)
        return layout_cap

cap = CAPACITY()

class FUEL(param.Parameterized):
    country_selector = param.ObjectSelector(default="Saudi Arabia", objects=countries)
    #scenario_selector = param.ObjectSelector(default="B", objects=scenarios)
    year_range = param.Range(default=(2015, 2030), bounds=(2015, 2030))
    show_legend = param.Boolean(False, doc="Show the legend")
    
    def get_data_fuel(self):
        start_date = self.year_range[0]
        end_date = self.year_range[1]
        country = self.country_selector
        
        mask = (df_fuel['c'] == country) & (df_fuel['trun'] >= start_date) & (df_fuel['trun'] <= end_date)
        
        _df = df_fuel.loc[mask]
        
        #df_pivot = _df.pivot_table(index=['c','trun','scenario'],columns='f',values='value',fill_value=0)
        #df_pivot = df_pivot.reset_index(drop=False)
        
        return _df
    
    def plot_fuel(self,scenario):    
        #scenario = self.scenario_selector
        _df  = self.get_data_fuel()
        
        df_pivot = _df.pivot_table(index=['c','trun','scenario'],columns='f',values='value',fill_value=0)
        df_pivot = df_pivot.reset_index(drop=False)
        
        mask = (df_pivot['scenario']==scenario)               # come back to this
        data = df_pivot.loc[mask].reset_index(drop=True)      
        
        title = self.country_selector + ' Scenario ' + scenario
        
        fuel_list = data.drop(['c','trun','scenario'],axis=1).columns.values.tolist()

        plot = data.hvplot.bar(
            x='trun',
            y=fuel_list,
            #by='scenario',
            stacked=True,
            subplots=False,
            value_label='TBTU',
            title=title,
            alpha=0.4,
            width=300,
            legend=self.show_legend,
            shared_axes=True,
            rot=90)
        return plot
    
    def plot_fuels(self):
        p_list = []
        for scenario in scenarios:
            p = self.plot_fuel(scenario)
            p_list.append(p)
            layout_fuel = hv.Layout(p_list)
        return layout_fuel
    
    def plot_fuel_tot(self,scenario):    
        _df = df_fuel.pivot_table(index=['trun','scenario'],columns='f',values='value',fill_value=0,aggfunc=np.sum).reset_index()
        start_date = self.year_range[0]
        end_date = self.year_range[1]
        
        mask = (_df['scenario']==scenario) & (df_ELsup['trun'] >= start_date) & (df_ELsup['trun'] <= end_date)
        data = _df.loc[mask]     
        
        title = 'Scenario ' + scenario
        
        fuel_list = data.drop(['trun','scenario'],axis=1).columns.values.tolist()

        plot = data.hvplot.bar(
            x='trun',
            y=fuel_list,
            stacked=True,
            subplots=False,
            value_label='TBTU',
            title=title,
            alpha=0.4,
            width=300,
            legend=self.show_legend,
            shared_axes=True,
            rot=90)
        return plot
    
    def plot_fuels_tot(self):
        p_list = []
        for scenario in scenarios:
            p = self.plot_fuel_tot(scenario)
            p_list.append(p)
            layout_fuel = hv.Layout(p_list)
        return layout_fuel

fuel = FUEL()

class ELSUP(param.Parameterized):
    country_selector = param.ObjectSelector(default="Saudi Arabia", objects=countries)
    year_range = param.Range(default=(2015, 2030), bounds=(2015, 2030))
    show_legend = param.Boolean(False, doc="Show the legend")
    
    def get_data_sup(self):
        start_date = self.year_range[0]
        end_date = self.year_range[1]
        country = self.country_selector
        
        mask =  (df_ELsup['c'] == country) & (df_ELsup['trun'] >= start_date) & (df_ELsup['trun'] <= end_date)
        
        _df = df_ELsup.loc[mask]
        
        df_pivot = _df.pivot_table(index=['c','trun','scenario'],columns='ELp',values='value',fill_value=0)
        df_pivot = df_pivot.reset_index(drop=False)
        
        return df_pivot
    
    def plot_sup(self,scenario):
        #country = self.country_selector
        _df  = self.get_data_sup()
        
        #df_pivot = _df.pivot_table(index=['c','trun','scenario'],columns='ELp',values='value',fill_value=0)
        #df_pivot = df_pivot.reset_index(drop=False)
        
        mask = (_df['scenario']==scenario)
        data = _df.loc[mask].reset_index(drop=True)      

        title = self.country_selector + ' for Scenario ' + scenario
        
        ELp_list = data.drop(['c','trun','scenario'],axis=1).columns.values.tolist()

        plot = data.hvplot.bar(
            x='trun',
            y=ELp_list,
            value_label='GW',
            title=title,
            alpha=0.4,
            stacked=True,
            width=300,
            shared_axes=False,
            legend=self.show_legend,
            rot=90)
        return plot

    def plot_sups(self):
        p_list = []
        for scenario in scenarios:
            p = self.plot_sup(scenario)
            p_list.append(p)
            layout_sup = hv.Layout(p_list)
        return layout_sup

    def plot_sups_tot(self):
        p_list = []
        for scenario in scenarios:
            p = self.plot_sup_tot(scenario)
            p_list.append(p)
            layout_sup = hv.Layout(p_list)
        return layout_sup

    def plot_sup_tot(self,scenario):
        _df = df_ELsup.pivot_table(index=['trun','scenario'],columns='ELp',values='value',fill_value=0,aggfunc=np.sum).reset_index()
        
        start_date = self.year_range[0]
        end_date = self.year_range[1]
       
        mask = (_df['scenario']==scenario) & (df_ELsup['trun'] >= start_date) & (df_ELsup['trun'] <= end_date)
        data = _df.loc[mask]

        title = 'Scenario ' + scenario
        
        ELp_list = data.drop(['trun','scenario'],axis=1).columns.values.tolist()

        plot = data.hvplot.bar(
            x='trun',
            y=ELp_list,
            value_label='GW',
            title=title,
            alpha=0.4,
            stacked=True,
            width=300,
            shared_axes=False,
            legend=self.show_legend,
            rot=90)
        return plot
sup=ELSUP()

class EMISSIONS1(param.Parameterized):
    # EMISSIONS SUBPLOTS
    # https://hvplot.holoviz.org/user_guide/Subplots.html
    
    #country_selector = param.ObjectSelector(default="Saudi Arabia", objects=countries)
    year_range = param.Range(default=(2015, 2030), bounds=(2015, 2030))
    show_legend = param.Boolean(False, doc="Show the legend")

    def get_data_emissions(self):
        start_date = self.year_range[0]
        end_date = self.year_range[1]
        #country = self.country_selector
        
        mask = (df_emissions['trun'] >= start_date) & (df_emissions['trun'] <= end_date)
        _df = df_emissions.loc[mask]
        
        #df_pivot = _df.pivot_table(index=['trun','scenario'],columns='c',values='value',fill_value=0)
        #df_pivot = df_pivot.reset_index(drop=False)
        
        return _df
    
    def plot_emissions_scenario(self,scenario):
        _df  = self.get_data_emissions()
        mask = (_df['scenario']==scenario)
        _df = _df.loc[mask].reset_index(drop=True)
        
        df_pivot = _df.pivot_table(index=['trun','scenario'],columns='c',values='value',fill_value=0,aggfunc=np.sum)
        data = df_pivot.reset_index(drop=False)
        c_list = data.drop(['scenario','trun'],axis=1).columns.values.tolist()
        title = 'Emissions for ' + scenario
        
        plot = data.hvplot.bar(
            x='trun',
            y=c_list,
            title=title,
            value_label='million tons',
            alpha=0.7,
            width=300,
            stacked=True,
            shared_axes=True,
            legend=self.show_legend,
            rot=90)
        return plot
    
    def plot_emissions_country(self,country):
        _df  = self.get_data_emissions()
        mask = (_df['c']==country)
        _df = _df.loc[mask].reset_index(drop=True)
        
        df_pivot = _df.pivot_table(index=['trun','c'],columns='scenario',values='value',fill_value=0,aggfunc=np.sum)
        data = df_pivot.reset_index(drop=False)
        s_list = data.drop(['c','trun'],axis=1).columns.values.tolist()
        title = 'Emissions for ' + country
        
        plot = (data.hvplot(
            x='trun',
            y=s_list,
            title=title,
            value_label='million tons',
            alpha=0.7,
            width=300,
            shared_axes=False,
            legend=self.show_legend,
            rot=90) * data.hvplot.scatter(
            x='trun',
            y=s_list,
            title=title,
            line_color='k',
            legend=self.show_legend,
            shared_axes=False))
        return plot
    
    def plot_emissions_s(self):
        p_list = []
        for scenario in scenarios:
            p = self.plot_emissions_scenario(scenario)
            p_list.append(p)
            layout_emissions = hv.Layout(p_list)
        return layout_emissions
    
    def plot_emissions_c(self):
        p_list = []
        for country in countries:
            p = self.plot_emissions_country(country)
            p_list.append(p)
            layout_emissions = hv.Layout(p_list)
        return layout_emissions    
em1 = EMISSIONS1()

class EMISSIONS2(param.Parameterized):
    # EMISSIONS SUBPLOTS
    # https://hvplot.holoviz.org/user_guide/Subplots.html
    
    #country_selector = param.ObjectSelector(default="Saudi Arabia", objects=countries)
    year_range = param.Range(default=(2015, 2030), bounds=(2015, 2030))
    show_legend = param.Boolean(False, doc="Show the legend")
    
    def get_data_emissions(self):
        start_date = self.year_range[0]
        end_date = self.year_range[1]
        
        mask = (df_emissions['trun'] >= start_date) & (df_emissions['trun'] <= end_date)
        _df = df_emissions.loc[mask]    
        return _df
       
    def plot_emissions_country(self,country):
        _df  = self.get_data_emissions()
        mask = (_df['c']==country)
        _df = _df.loc[mask].reset_index(drop=True)
        
        df_pivot = _df.pivot_table(index=['trun','c'],columns='scenario',values='value',fill_value=0)
        data = df_pivot.reset_index(drop=False)
        s_list = data.drop(['c','trun'],axis=1).columns.values.tolist()
        title = 'Emissions for ' + country
        
        plot = (data.hvplot(
            x='trun',
            y=s_list,
            title=title,
            value_label='million tons',
            alpha=0.7,
            width=300,
            shared_axes=False,
            legend=self.show_legend,
            rot=90,
            ylim=(0,500)) * data.hvplot.scatter(
            x='trun',
            y=s_list,
            title=title,
            line_color='k',
            legend=self.show_legend,
            shared_axes=False,
            ylim=(0,500)))
        return plot
    
    def plot_emissions_c(self):
        p_list = []
        for country in countries:
            p = self.plot_emissions_country(country)
            p_list.append(p)
            layout_emissions = hv.Layout(p_list)
        return layout_emissions    
em2 = EMISSIONS2()

class INVESTMENTS(param.Parameterized):
    
    def get_data(self):
        _df = df_investments
        
        _df = (_df
               .drop(['trun'],axis=1)
               .pivot_table(index=['scenario'],
                            columns=['tech'],
                            fill_value=0,
                            aggfunc=np.sum)
              )
        
        _df.columns = _df.columns.droplevel()
        return _df

    def plot_data(self):
        data = self.get_data()
        #_df  = self.get_data()
             
        title = 'Cumulative investments'
        ELp_list = data.columns.values.tolist()

        plot = data.hvplot.bar(value_label='billion USD',
                               title=title,
                               alpha=0.4,
                               stacked=True,
                               width=800,
                               height=600)
        return plot
inv = INVESTMENTS()

# CREATE DASHBOARD
about_capacities = """The capacity of power plants and water desalination plants change over time based on investment decisions made by the model.
"""
about_fuel = """Fuel consumption.
"""
about_sup = """Electricity produced by power plants.
"""

about_emissions = """CO2 emissions.
"""

about_inv = """Cumulative investments by all countries.Add:
- investments by country
- investments by technology
"""

about_ex = """Exchange from one country to another per year."""

desc_capacity = pn.layout.Row(pn.pane.Markdown(about_capacities))
desc_fuel = pn.layout.Row(pn.pane.Markdown(about_fuel))
desc_sup = pn.layout.Row(pn.pane.Markdown(about_sup))
desc_em = pn.layout.Row(pn.pane.Markdown(about_emissions))
desc_inv = pn.layout.Row(pn.pane.Markdown(about_inv))
desc_ex = pn.layout.Row(pn.pane.Markdown(about_ex))

widgets_cap = pn.WidgetBox('### Select your query',cap.param)
widgets_fuel = pn.WidgetBox('### Select your query',fuel.param)
widgets_sup = pn.WidgetBox('### Select your query',sup.param)
widgets_em1 = pn.WidgetBox('### Select your query',em1.param)
widgets_em2 = pn.WidgetBox('### Select your query',em2.param)
widgets_ex = pn.WidgetBox('### Select your query',ex.param)

dashboard = pn.Tabs(('Capacity',
    pn.Row(
        pn.Column(
            pn.Row('## Capacities'),
            pn.Row(widgets_cap),
            pn.Row(desc_capacity)),
        pn.Column(
            pn.Row(cap.plot_caps_tot))                 
            )))

dashboard.append(('Fuel',
    pn.Row(
        pn.Column(
            pn.Row(widgets_fuel),
            pn.Row(desc_fuel)),
        pn.Column(
            pn.Row(fuel.plot_fuels_tot))
                 )))

dashboard.append(('Electricity',
    pn.Row(
        pn.Column(
            pn.Row('## Electricity supply'),
            pn.Row(widgets_sup),
            pn.Row(desc_sup)),
        pn.Column(
            pn.Row(sup.plot_sups_tot))                      
            )))

dashboard.append(('Emissions by Scenario',
    pn.Row(
        pn.Column(
            pn.Row('## CO2 emissions'),
            pn.Row(widgets_em1),
            pn.Row(desc_em)),
        pn.Column(
            pn.Row(em1.plot_emissions_s))                  
            )))

dashboard.append(('Investment',
                 pn.Column(
                     pn.Row(desc_inv),
                     pn.Row(inv.plot_data))
                 ))

#dashboard.append(('Exchange',
#    pn.Row(
#        pn.Column(
#            pn.Row('## Electricity exchange'),
#            pn.Row(widgets_ex),
#            pn.Row(desc_ex)),
#        pn.Column(
#            pn.Row(ex.get_exchange_plot))                  
#            )))

dashboard.show()


class EXCHANGE(param.Parameterized):
    trade_scenarios = df_trade['scenario'].unique()
    select_year = param.Integer(2030, bounds=(2015,2030))
    
    def get_cumulative(self,scenario):
        mask = (df_trade['scenario'] == scenario)
        _df = df_trade.loc[mask]
        _df = _df.drop(['scenario'],axis=1)
        
        a = data.pivot_table(index='c',columns='cc',values='value',aggfunc=np.sum)
        b = data.pivot_table(index='cc',columns='c',values='value',aggfunc=np.sum)
        c = b-a
        c[c < 0] = 0
        c = c.replace({np.nan:0})       
        d = c.round(decimals=1)
        return d
        
ex = EXCHANGE()


# %%
J = EXCHANGE()
data = J.get_exchange_plot('H')
data2 = J.get_cumulative('H')


# %%
data2


# %%
a = data.pivot_table(index='c',columns='cc',values='value')
b = data.pivot_table(index='cc',columns='c',values='value')
c = b-a
c[c < 0] = 0
c = c.replace({np.nan:0})       
d = c.round(decimals=1)
d


# %%
a = data.pivot_table(index='c',columns='cc',values='value')
b = data.pivot_table(index='cc',columns='c',values='value')
c = b-a
c[c < 0] = 0
c = c.replace({np.nan:0})       
d = c.round(decimals=1)
d


# %%



# %%
np.array(data)


# %%
a = data.pivot_table(index='c',columns='cc',values='value')

b = data.pivot_table(index='cc',columns='c',values='value')

c = b-a
c[c < 0] = 0
c = c.replace({np.nan:0})

d = c.round(decimals=1)
d


# %%
e = d.reset_index()


# %%
f = e.melt(id_vars='cc')


# %%
g = f[f['value']>0]


# %%
np.array(g)


# %%
h = hv.Sankey([
    ['Bahrain' , 'Bahrain ', 20],
    ['Kuwait', 'Kuwait ', 30],
    ['Oman','Oman ', 75],
    ['Qatar', 'Qatar ', 50],
    ['Saudi Arabia', 'Saudi Arabia ', 280],
    ['UAE','UAE ', 150],
    ['Saudi Arabia', 'Bahrain ', 5.4],
    ['UAE', 'Oman ', 2.8],
    ['Saudi Arabia', 'Qatar ', 11.2],
    ['Kuwait', 'Saudi Arabia ', 1.4],
    ['Saudi Arabia', 'UAE ', 6.9]]
)
h.opts(width=600, height=400)


# %%
sankey = hv.Sankey(np.array(g))


# %%
sankey.opts(width=600, height=400)


# %%
sankey = hv.Sankey([
    ['A', 'X', 0],
    ['A', 'X', 5],
    ['A', 'Y', 7],
    ['A', 'Z', 6],
    ['B', 'X', 2],
    ['B', 'Y', 9],
    ['B', 'Z', 4]]
)
sankey.opts(width=600, height=400)


# %%
nodes = ["PhD", "Career Outside Science",  "Early Career Researcher", "Research Staff",
         "Permanent Research Staff",  "Professor",  "Non-Academic Research"]
nodes = hv.Dataset(enumerate(nodes), 'index', 'label')


# %%
nodes.data


# %%


