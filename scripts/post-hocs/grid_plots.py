#!/usr/bin/env python
# coding: utf-8

# In[90]:


import json
import itertools
import pandas as pd
import numpy as np
import plotly.graph_objects as go
import sys

# In[145]:


#JSON_FILE = "FUBAR/SARS/N.fasta_CODON_AWARE_ALN.fasta.FUBAR.json"
#plot_title = "SARS N"
JSON_FILE = sys.argv[1]
plot_title = sys.argv[2]

# In[146]:


def get_json_data(filename):
    with open(filename) as fh:
        json_data = json.load(fh)
    #end with

    return json_data["grid"]
#end method


grid = get_json_data(JSON_FILE)


# In[147]:


x2, y2, z2 = [], [] , []

for item in grid:
    x2.append(item[0])
    y2.append(item[1])
    z2.append(item[2])


# In[148]:


#df = pd.DataFrame(data=numpy_data, index=["row1", "row2"], columns=["column1", "column2"])
df = pd.DataFrame(data=[], index=sorted(set(x2)), columns=sorted(set(y2)))


# In[149]:


for item in sorted(set(y2)): #loops across columns
    #print("# column (beta)", item)
    for index, row in df.iteritems():
        #print(index, row)
        #print("\t", index, df[item][index])
        alpha = index
        beta = item
        #print("\t", alpha, beta)
        
        #Search in grid.
        for entry in grid:
            #print("# checking:", entry)
            a = entry[0]
            b = entry[1]
            
            weight = entry[2]
            
            if a == alpha and b == beta:
                #print("# match:", entry)
                #print(alpha, beta, weight)
                #assign
                df[item][index] = weight
                
            #end if
        #end for
    #end for
#end for
    
          


# In[150]:


#x, y = list(set(x2)), list(set(y2))

x, y = np.linspace(0, 50), np.linspace(0, 50)
#x, y = np.array(list(set(x2))), np.array(list(set(y2)))

fig = go.Figure(data=[go.Surface(z=df.values, x=x, y=y)])
fig.update_layout(title=plot_title.replace("_", " ") + ' - Surface plot', autosize=False,
                  width=1000, height=800,
                  margin=dict(l=65, r=50, b=65, t=90))

fig.update_layout(
    title={
        'y':0.9,
        'x':0.5,
        'xanchor': 'center',
        'yanchor': 'top'})

fig.update_layout(

    font=dict(
        size=18
    )
)

#fig.show()

fig.write_image("images/" + plot_title + "_fig1.png")


# In[ ]:



print("Done")

# In[ ]:


# ###################################################################################################################
# ###################################################################################################################
# ###################################################################################################################
# ###################################################################################################################
# ###################################################################################################################
# ###################################################################################################################