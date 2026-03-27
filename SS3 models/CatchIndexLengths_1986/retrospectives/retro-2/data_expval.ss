#V3.30.22.1;_safe;_compile_date:_Jan 30 2024;_Stock_Synthesis_by_Richard_Methot_(NOAA)_using_ADMB_13.1
#_Stock_Synthesis_is_a_work_of_the_U.S._Government_and_is_not_subject_to_copyright_protection_in_the_United_States.
#_Foreign_copyrights_may_apply._See_copyright.txt_for_more_information.
#_User_support_available_at:NMFS.Stock.Synthesis@noaa.gov
#_User_info_available_at:https://vlab.noaa.gov/group/stock-synthesis
#_Source_code_at:_https://github.com/nmfs-ost/ss3-source-code

#_Start_time: Sat Oct  4 19:10:21 2025
#_expected_values
#C should work with SS version:
#C file created using an r4ss function
#C file write time: 2025-10-04  14:24:25
#V3.30.22.1;_safe;_compile_date:_Jan 30 2024;_Stock_Synthesis_by_Richard_Methot_(NOAA)_using_ADMB_13.1
1986 #_StartYr
2023 #_EndYr
1 #_Nseas
 12 #_months/season
2 #_Nsubseasons (even number, minimum is 2)
1 #_spawn_month
2 #_Nsexes: 1, 2, -1  (use -1 for 1 sex setup with SSB multiplied by female_frac parameter)
22 #_Nages=accumulator age, first age is always age 0
1 #_Nareas
2 #_Nfleets (including surveys)
#_fleet_type: 1=catch fleet; 2=bycatch only fleet; 3=survey; 4=predator(M2) 
#_sample_timing: -1 for fishing fleet to use season-long catch-at-age for observations, or 1 to use observation month;  (always 1 for surveys)
#_fleet_area:  area the fleet/survey operates in 
#_units of catch:  1=bio; 2=num (ignored for surveys; their units read later)
#_catch_mult: 0=no; 1=yes
#_rows are fleets
#_fleet_type fishery_timing area catch_units need_catch_mult fleetname
 1 -1 1 1 0 Fleet_1  # 1
 1 -1 1 1 0 Fleet_2  # 2
#Bycatch_fleet_input_goes_next
#a:  fleet index
#b:  1=include dead bycatch in total dead catch for F0.1 and MSY optimizations and forecast ABC; 2=omit from total catch for these purposes (but still include the mortality)
#c:  1=Fmult scales with other fleets; 2=bycatch F constant at input value; 3=bycatch F from range of years
#d:  F or first year of range
#e:  last year of range
#f:  not used
# a   b   c   d   e   f 
#_catch:_columns_are_year,season,fleet,catch,catch_se
#_Catch data: yr, seas, fleet, catch, catch_se
-999 1 1 11033.1 0.01
1986 1 1 2456.58 0.01
1987 1 1 3843.14 0.01
1988 1 1 3805.9 0.01
1989 1 1 1895.17 0.01
1990 1 1 3458.42 0.01
1991 1 1 4584.3 0.01
1992 1 1 4320.68 0.01
1993 1 1 3681.75 0.01
1994 1 1 3855.44 0.01
1995 1 1 4134.56 0.01
1996 1 1 1522.96 0.01
1997 1 1 2807.06 0.01
1998 1 1 2651.98 0.01
1999 1 1 2862.87 0.01
2000 1 1 3779.01 0.01
2001 1 1 2319.49 0.01
2002 1 1 2791.6 0.01
2003 1 1 1139.13 0.01
2004 1 1 1670.34 0.01
2005 1 1 1574.07 0.01
2006 1 1 1580.1 0.01
2007 1 1 3552.61 0.01
2008 1 1 3724.09 0.01
2009 1 1 4662.89 0.01
2010 1 1 2922.09 0.01
2011 1 1 2309.76 0.01
2012 1 1 4052.03 0.01
2013 1 1 3245.1 0.01
2014 1 1 2603.69 0.01
2015 1 1 3797.43 0.01
2016 1 1 3887.78 0.01
2017 1 1 4047.52 0.01
2018 1 1 3049.93 0.01
2019 1 1 3512.03 0.01
2020 1 1 2998.55 0.01
2021 1 1 2818.49 0.01
2022 1 1 3657.59 0.01
2023 1 1 2909.4 0.01
-999 1 2 0.00616329 0.01
1986 1 2 5508.68 0.01
1987 1 2 8846.38 0.01
1988 1 2 7838.26 0.01
1989 1 2 7748.17 0.01
1990 1 2 7577.51 0.01
1991 1 2 7754.22 0.01
1992 1 2 7102.91 0.01
1993 1 2 6004.94 0.01
1994 1 2 6516.71 0.01
1995 1 2 6836.13 0.01
1996 1 2 5505.59 0.01
1997 1 2 4807.68 0.01
1998 1 2 4599.86 0.01
1999 1 2 4950.3 0.01
2000 1 2 5703.72 0.01
2001 1 2 4848.87 0.01
2002 1 2 2.34748 0.01
2003 1 2 4666.01 0.01
2004 1 2 3832.01 0.01
2005 1 2 5470.06 0.01
2006 1 2 4571.22 0.01
2007 1 2 5265.96 0.01
2008 1 2 5405.41 0.01
2009 1 2 5324.01 0.01
2010 1 2 4796.16 0.01
2011 1 2 4021.32 0.01
2012 1 2 5195.57 0.01
2013 1 2 4355.44 0.01
2014 1 2 2884.83 0.01
2015 1 2 3449.07 0.01
2016 1 2 2149.63 0.01
2017 1 2 2251.09 0.01
2018 1 2 2094.21 0.01
2019 1 2 2134.46 0.01
2020 1 2 2014.99 0.01
2021 1 2 1872.76 0.01
2022 1 2 1531.05 0.01
2023 1 2 1340.38 0.01
-9999 0 0 0 0
#
#
 #_CPUE_and_surveyabundance_observations
#_Units:  0=numbers; 1=biomass; 2=F; 30=spawnbio; 31=recdev; 32=spawnbio*recdev; 33=recruitment; 34=depletion(&see Qsetup); 35=parm_dev(&see Qsetup)
#_Errtype:  -1=normal; 0=lognormal; 1=lognormal with bias correction; >1=df for T-dist
#_SD_Report: 0=not; 1=include survey expected value with se
#_Fleet Units Errtype SD_Report
1 1 0 0 # Fleet_1
2 1 0 0 # Fleet_2
#_year month index obs err
2000 7 1 0.000149739 0.152765 #_orig_obs: 0.000157071 Fleet_1
2001 7 1 0.000109046 0.152765 #_orig_obs: 0.000126056 Fleet_1
2002 7 1 0.000114647 0.152765 #_orig_obs: 0.000143716 Fleet_1
2003 7 1 0.000115426 0.152765 #_orig_obs: 9.7e-05 Fleet_1
2004 7 1 0.00012137 0.152765 #_orig_obs: 0.000115653 Fleet_1
2005 7 1 0.000131201 0.152765 #_orig_obs: 0.000110721 Fleet_1
2006 7 1 0.000125381 0.152765 #_orig_obs: 0.000123072 Fleet_1
2007 7 1 0.000131384 0.152765 #_orig_obs: 0.000143974 Fleet_1
2008 7 1 0.000148596 0.152765 #_orig_obs: 0.00013286 Fleet_1
2009 7 1 0.000149928 0.152765 #_orig_obs: 0.000147786 Fleet_1
2010 7 1 0.000134515 0.152765 #_orig_obs: 0.000118078 Fleet_1
2011 7 1 0.000134975 0.152765 #_orig_obs: 0.000111093 Fleet_1
2012 7 1 0.000152173 0.152765 #_orig_obs: 0.000147501 Fleet_1
2013 7 1 0.000125515 0.152765 #_orig_obs: 0.000128946 Fleet_1
2014 7 1 0.000109076 0.152765 #_orig_obs: 0.00011487 Fleet_1
2015 7 1 0.00011284 0.152765 #_orig_obs: 0.000135493 Fleet_1
2016 7 1 9.68182e-05 0.152765 #_orig_obs: 0.00013237 Fleet_1
2017 7 1 8.7421e-05 0.152765 #_orig_obs: 0.000130696 Fleet_1
2018 7 1 9.87996e-05 0.152765 #_orig_obs: 0.000103782 Fleet_1
2019 7 1 0.000147119 0.152765 #_orig_obs: 0.000127599 Fleet_1
2020 7 1 0.000163909 0.152765 #_orig_obs: 0.000127537 Fleet_1
2021 7 1 0.000111297 0.152765 #_orig_obs: 8.67e-05 Fleet_1
2022 7 -1 7.571e-05 0.152765 #_orig_obs: 8.61e-05 Fleet_1
2000 7 2 2.72898e-05 0.0401056 #_orig_obs: 2.7e-05 Fleet_2
2001 7 2 2.29417e-05 0.040106 #_orig_obs: 2.28e-05 Fleet_2
2002 7 2 2.48679e-05 0.0401059 #_orig_obs: 2.45e-05 Fleet_2
2003 7 2 2.37646e-05 0.0401059 #_orig_obs: 2.39e-05 Fleet_2
2004 7 2 2.4802e-05 0.0401058 #_orig_obs: 2.49e-05 Fleet_2
2005 7 2 2.8409e-05 0.0401054 #_orig_obs: 2.87e-05 Fleet_2
2006 7 2 2.57744e-05 0.0401057 #_orig_obs: 2.58e-05 Fleet_2
2007 7 2 2.62278e-05 0.0401057 #_orig_obs: 2.61e-05 Fleet_2
2008 7 2 3.05688e-05 0.0401052 #_orig_obs: 3.07e-05 Fleet_2
2009 7 2 3.17081e-05 0.0401051 #_orig_obs: 3.18e-05 Fleet_2
2010 7 2 2.94188e-05 0.0401053 #_orig_obs: 2.97e-05 Fleet_2
2011 7 2 2.70741e-05 0.0401056 #_orig_obs: 2.73e-05 Fleet_2
2012 7 2 3.24721e-05 0.040105 #_orig_obs: 3.26e-05 Fleet_2
2013 7 2 2.76932e-05 0.0401055 #_orig_obs: 2.77e-05 Fleet_2
2014 7 2 2.19338e-05 0.0401061 #_orig_obs: 2.18e-05 Fleet_2
2015 7 2 2.42393e-05 0.0401059 #_orig_obs: 2.4e-05 Fleet_2
2016 7 2 1.99894e-05 0.0401063 #_orig_obs: 1.96e-05 Fleet_2
2017 7 2 1.81977e-05 0.0401065 #_orig_obs: 1.78e-05 Fleet_2
2018 7 2 1.9516e-05 0.0401064 #_orig_obs: 1.94e-05 Fleet_2
2019 7 2 3.21279e-05 0.0401051 #_orig_obs: 3.24e-05 Fleet_2
2020 7 2 3.80542e-05 0.0401044 #_orig_obs: 3.94e-05 Fleet_2
2021 7 2 2.30324e-05 0.040106 #_orig_obs: 2.32e-05 Fleet_2
2022 7 -2 1.44714e-05 0.0401062 #_orig_obs: 2.06e-05 Fleet_2
-9999 1 1 1 1 # terminator for survey observations 
#
0 #_N_fleets_with_discard
#_discard_units (1=same_as_catchunits(bio/num); 2=fraction; 3=numbers)
#_discard_errtype:  >0 for DF of T-dist(read CV below); 0 for normal with CV; -1 for normal with se; -2 for lognormal; -3 for trunc normal with CV
# note: only enter units and errtype for fleets with discard 
# note: discard data is the total for an entire season, so input of month here must be to a month in that season
#_Fleet units errtype
# -9999 0 0 0.0 0.0 # terminator for discard data 
#
0 #_use meanbodysize_data (0/1)
#_COND_0 #_DF_for_meanbodysize_T-distribution_like
# note:  type=1 for mean length; type=2 for mean body weight 
#_yr month fleet part type obs stderr
#  -9999 0 0 0 0 0 0 # terminator for mean body size data 
#
# set up population length bin structure (note - irrelevant if not using size data and using empirical wtatage
2 # length bin method: 1=use databins; 2=generate from binwidth,min,max below; 3=read vector
5 # binwidth for population size comp 
5 # minimum size in the population (lower edge of first bin and size at age 0.00) 
95 # maximum size in the population (lower edge of last bin) 
1 # use length composition data (0/1/2) where 2 invokes new comp_comtrol format
#_mintailcomp: upper and lower distribution for females and males separately are accumulated until exceeding this level.
#_addtocomp:  after accumulation of tails; this value added to all bins
#_combM+F: males and females treated as combined sex below this bin number 
#_compressbins: accumulate upper tail by this number of bins; acts simultaneous with mintailcomp; set=0 for no forced accumulation
#_Comp_Error:  0=multinomial, 1=dirichlet using Theta*n, 2=dirichlet using beta, 3=MV_Tweedie
#_ParmSelect:  consecutive index for dirichlet or MV_Tweedie
#_minsamplesize: minimum sample size; set to 1 to match 3.24, minimum value is 0.001
#
#_Using old format for composition controls
#_mintailcomp addtocomp combM+F CompressBins CompError ParmSelect minsamplesize
-1 0.001 0 0 0 0 0.001 #_fleet:1_Fleet_1
-1 0.001 0 0 0 0 0.001 #_fleet:2_Fleet_2
# sex codes:  0=combined; 1=use female only; 2=use male only; 3=use both as joint sex*length distribution
# partition codes:  (0=combined; 1=discard; 2=retained
15 #_N_LengthBins
 20 25 30 35 40 45 50 55 60 65 70 75 80 85 90
#_yr month fleet sex part Nsamp datavector(female-male)
 1988 6 1 1 0 62.3694  0.0614951 1.45222 19.1938 25.362 10.8863 3.80831 0.943942 0.205585 0.0796711 0.064969 0.0630307 0.0623815 0.0620073 0.06177 0.0618569 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
 1997 6 1 1 0 1.80543  0.00177954 0.021749 0.319182 0.691202 0.447384 0.225756 0.0688322 0.0143384 0.00361865 0.00221411 0.00200594 0.00191081 0.00184583 0.00180905 0.00180226 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
 2001 6 1 1 0 4.08137  0.00402615 0.0966351 1.29045 1.95647 0.510023 0.101287 0.0529249 0.0276364 0.0112793 0.00659024 0.00562124 0.00508806 0.00466496 0.00436397 0.00430233 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
 2003 6 1 1 0 2.92151  0.00288303 0.0873267 0.950566 1.19663 0.49645 0.134779 0.0209694 0.00686572 0.00455721 0.00376953 0.0036479 0.00351769 0.00331466 0.00312914 0.00311318 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
 1988 6 1 2 0 8.91226  0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0.00878733 0.207515 2.7427 3.6241 1.5556 0.544187 0.134884 0.0293771 0.0113846 0.00928373 0.00900676 0.00891398 0.00886051 0.00882661 0.00883902
 1997 6 1 2 0 0.486919  0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0.000479937 0.00586564 0.0860825 0.186415 0.120658 0.0608856 0.0185638 0.00386701 0.000975938 0.000597138 0.000540997 0.000515339 0.000497814 0.000487894 0.000486065
 2001 6 1 2 0 0.760469  0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0.00075018 0.0180057 0.240447 0.364543 0.0950312 0.0188725 0.00986134 0.00514941 0.00210164 0.00122794 0.00104739 0.000948043 0.000869208 0.000813126 0.000801641
 2003 6 1 2 0 0.497861  0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0.000491303 0.0148815 0.161988 0.203919 0.0846011 0.0229679 0.00357343 0.00117 0.000776603 0.000642373 0.000621645 0.000599456 0.000564857 0.000533243 0.000530523
 1988 6 2 1 0 3.2148  0.00317115 0.0031696 0.228101 2.08988 0.69709 0.142056 0.0226212 0.00552751 0.00365775 0.00338655 0.0032914 0.00324195 0.00321207 0.00319309 0.00320004 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
 1990 6 2 1 0 0.17625  0.000173801 0.000173707 0.0067819 0.104695 0.050991 0.0105801 0.00129066 0.000294921 0.000200248 0.000186088 0.000180328 0.00017724 0.000175596 0.000174703 0.000174933 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
 2008 6 2 1 0 0.2397  0.000236679 0.000236416 0.0228146 0.177736 0.0337657 0.00254942 0.000370798 0.000249061 0.000240814 0.000241923 0.000245742 0.000250141 0.000252045 0.000250134 0.000260647 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
 2022 10 2 1 0 0.780294  0.000771298 0.000769754 0.0791628 0.528467 0.133051 0.0269557 0.00458122 0.00109331 0.00080375 0.000776257 0.000771607 0.0007707 0.000770592 0.000770842 0.000778914 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
 1988 6 2 2 0 0.459378  0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0.000453141 0.00045292 0.0325944 0.298633 0.0996105 0.0202991 0.00323245 0.000789852 0.000522673 0.00048392 0.000470324 0.000463258 0.000458988 0.000456275 0.000457269
 1990 6 2 2 0 0.065988  0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 6.5071e-05 6.50358e-05 0.00253914 0.0391977 0.019091 0.0039612 0.000483223 0.000110419 7.49729e-05 6.96715e-05 6.7515e-05 6.63586e-05 6.57433e-05 6.54087e-05 6.54951e-05
 2008 6 2 2 0 0.0423  0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 4.17669e-05 4.17205e-05 0.00402611 0.0313652 0.00595865 0.000449898 6.5435e-05 4.3952e-05 4.24966e-05 4.26922e-05 4.33662e-05 4.41425e-05 4.44785e-05 4.41412e-05 4.59965e-05
 2022 10 2 2 0 0.170892  0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0.000168922 0.000168584 0.0173374 0.115739 0.0291394 0.00590356 0.00100333 0.000239445 0.000176029 0.000170008 0.000168989 0.000168791 0.000168767 0.000168822 0.00017059
-9999 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 
#
22 #_N_age_bins
 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21
1 #_N_ageerror_definitions
 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1
 0.001 0.001 0.001 0.001 0.001 0.001 0.001 0.001 0.001 0.001 0.001 0.001 0.001 0.001 0.001 0.001 0.001 0.001 0.001 0.001 0.001 0.001 0.001
#_mintailcomp: upper and lower distribution for females and males separately are accumulated until exceeding this level.
#_addtocomp:  after accumulation of tails; this value added to all bins
#_combM+F: males and females treated as combined sex below this bin number 
#_compressbins: accumulate upper tail by this number of bins; acts simultaneous with mintailcomp; set=0 for no forced accumulation
#_Comp_Error:  0=multinomial, 1=dirichlet using Theta*n, 2=dirichlet using beta, 3=MV_Tweedie
#_ParmSelect:  parm number for dirichlet or MV_Tweedie
#_minsamplesize: minimum sample size; set to 1 to match 3.24, minimum value is 0.001
#
#_mintailcomp addtocomp combM+F CompressBins CompError ParmSelect minsamplesize
-1 0.001 0 0 0 0 0.001 #_fleet:1_Fleet_1
-1 0.001 0 0 0 0 0.001 #_fleet:2_Fleet_2
3 #_Lbin_method_for_Age_Data: 1=poplenbins; 2=datalenbins; 3=lengths
# sex codes:  0=combined; 1=use female only; 2=use male only; 3=use both as joint sex*length distribution
# partition codes:  (0=combined; 1=discard; 2=retained
#_yr month fleet sex part ageerr Lbin_lo Lbin_hi Nsamp datavector(female-male)
-9999  0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
#
0 #_Use_MeanSize-at-Age_obs (0/1)
#
0 #_N_environ_variables
# -2 in yr will subtract mean for that env_var; -1 will subtract mean and divide by stddev (e.g. Z-score)
#Yr Variable Value
#
# Sizefreq data. Defined by method because a fleet can use multiple methods
0 # N sizefreq methods to read (or -1 for expanded options)
#
0 # do tags (0/1)
#
0 #    morphcomp data(0/1) 
#  Nobs, Nmorphs, mincomp
#  yr, seas, type, partition, Nsamp, datavector_by_Nmorphs
#
0  #  Do dataread for selectivity priors(0/1)
# Yr, Seas, Fleet,  Age/Size,  Bin,  selex_prior,  prior_sd
# feature not yet implemented
#
999

