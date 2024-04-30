# -*- coding: utf-8 -*-
import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
from scipy.stats import ttest_ind
from scipy.stats import ttest_rel
from scipy.stats import ttest_1samp
import mysql.connector

cnx = mysql.connector.connect(user='com303dsandoval', password='ds8498ds',
                             host='136.244.224.221',
                             database='com303fpad')
