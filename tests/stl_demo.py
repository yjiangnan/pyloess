#!/usr/bin/env python
# -*- coding: utf-8 -*-

import pandas as pd

# set up input parameters

filename_ts = "stl-sample-timeseries.json"
df = pd.read_json(filename_ts)

y = df.series.values

#
np = 12         # period of seasonal component
ns = 7          # length of seasonal smoother
nt = None       # length of trend smoother
nl = None       # length of low-pass filter
isdeg = 1       # Degree of locally-fitted polynomial in seasonal smoothing.
itdeg = 1       # Degree of locally-fitted polynomial in trend smoothing.
ildeg = 1       # Degree of locally-fitted polynomial in low-pass smoothing.
nsjump = None   # Skipping value for seasonal smoothing.
ntjump = 1      # Skipping value for trend smoothing. If None, ntjump= 0.1*nt
nljump = 1      # Skipping value for low-pass smoothing. If None, nljump= 0.1*nl
robust = True   # Flag indicating whether robust fitting should be performed.
ni = None       # Number of loops for updating the seasonal and trend  components.
no = 0          # Number of iterations of robust fitting. The value of no should

import matplotlib as mpl
mpl.rcParams['figure.figsize'] = (16.0, 10.0)
import matplotlib.pyplot as plt

def stl_plot(data, results):
    fig, axes = plt.subplots(4,1)
    _ = axes[0].plot(data)
    _ = axes[1].plot(results.trend)
    _ = axes[2].plot(results.seasonal)
    _ = axes[3].plot(results.residuals)

def run_ndarray():
    from pyloess import stl
    res = stl(y, np, ns, nt, nl, isdeg, itdeg, ildeg, nsjump, ntjump, nljump, robust, ni, no)
    stl_plot(y, res)
    plt.show()

def run_maskedarray():
    from pyloess.mpyloess import stl
    res = stl(y)
    stl_plot(y, res.outputs)
    plt.show()

if __name__ == "__main__":
    run_ndarray()
    run_maskedarray()
