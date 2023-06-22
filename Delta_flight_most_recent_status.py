#!/usr/bin/env python
# coding: utf-8

# In[1]:


#Task 2: Write Python function with input parameter as file path, ingest the provided dummy data and report all 
#the available flights with their most recent status.


# In[2]:


import pandas as pd


# In[8]:


def flight_with_most_recent_status(input, output):
    """
    A function which is used to report all the available flights with their most recent status
    
    input: str
        The input is the input file location.
    output: str
        The output is the output file location.
    """
    
    #read data: skip the first 7 rows and last 2 rows which contains unstructured info
    df_flight = pd.read_csv(input, skiprows =7, skipfooter=2, engine='python')
    #remove duplicate records
    df_flight_dedup = df_flight.drop_duplicates()
    #get the most recent status for all the available flights
    df_flight_most_recent = df_flight_dedup.sort_values('lastupdt').groupby('flightkey').tail(1).sort_index()
    print(df_flight_most_recent)
    #output the results and save it 
    df_flight_most_recent.to_csv(output)


# In[9]:


input = 'Downloads/Dummy_Flight_Leg_Data.csv'
output = 'Downloads/Flight_w_mrs.csv'


# In[10]:


flight_with_most_recent_status(input, output)


# In[11]:


input = 'Downloads/test.csv'
output = 'Downloads/test_w_mrs.csv'


# In[12]:


flight_with_most_recent_status(input, output)


# In[ ]:




