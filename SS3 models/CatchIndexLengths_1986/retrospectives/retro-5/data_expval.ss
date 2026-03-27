#V3.30.22.1;_safe;_compile_date:_Jan 30 2024;_Stock_Synthesis_by_Richard_Methot_(NOAA)_using_ADMB_13.1
#_Stock_Synthesis_is_a_work_of_the_U.S._Government_and_is_not_subject_to_copyright_protection_in_the_United_States.
#_Foreign_copyrights_may_apply._See_copyright.txt_for_more_information.
#_User_support_available_at:NMFS.Stock.Synthesis@noaa.gov
#_User_info_available_at:https://vlab.noaa.gov/group/stock-synthesis
#_Source_code_at:_https://github.com/nmfs-ost/ss3-source-code

#_Start_time: Sat Oct  4 19:11:18 2025
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
-999 1 1 3383.75 0.01
1986 1 1 2456.7 0.01
1987 1 1 3843.09 0.01
1988 1 1 3805.83 0.01
1989 1 1 1895.16 0.01
1990 1 1 3458.44 0.01
1991 1 1 4584.37 0.01
1992 1 1 4320.72 0.01
1993 1 1 3681.76 0.01
1994 1 1 3855.46 0.01
1995 1 1 4134.62 0.01
1996 1 1 1522.95 0.01
1997 1 1 2807.07 0.01
1998 1 1 2651.99 0.01
1999 1 1 2862.9 0.01
2000 1 1 3773.76 0.01
2001 1 1 2316.75 0.01
2002 1 1 2791.51 0.01
2003 1 1 1137.02 0.01
2004 1 1 1667.83 0.01
2005 1 1 1571 0.01
2006 1 1 1576.92 0.01
2007 1 1 3546.22 0.01
2008 1 1 3717.92 0.01
2009 1 1 4666.81 0.01
2010 1 1 2920.47 0.01
2011 1 1 2308.1 0.01
2012 1 1 4053.55 0.01
2013 1 1 3248.62 0.01
2014 1 1 2604.5 0.01
2015 1 1 3804.21 0.01
2016 1 1 3891.54 0.01
2017 1 1 4053.01 0.01
2018 1 1 3050.77 0.01
2019 1 1 3512.55 0.01
2020 1 1 2999 0.01
2021 1 1 2821.39 0.01
2022 1 1 3655.91 0.01
2023 1 1 2909.75 0.01
-999 1 2 16064.9 0.01
1986 1 2 5508.97 0.01
1987 1 2 8846.22 0.01
1988 1 2 7838.09 0.01
1989 1 2 7748.14 0.01
1990 1 2 7577.55 0.01
1991 1 2 7754.36 0.01
1992 1 2 7102.99 0.01
1993 1 2 6004.97 0.01
1994 1 2 6516.75 0.01
1995 1 2 6836.23 0.01
1996 1 2 5505.58 0.01
1997 1 2 4807.69 0.01
1998 1 2 4599.88 0.01
1999 1 2 4950.37 0.01
2000 1 2 5694.42 0.01
2001 1 2 4842.34 0.01
2002 1 2 2.3474 0.01
2003 1 2 4656.27 0.01
2004 1 2 3825.34 0.01
2005 1 2 5458.19 0.01
2006 1 2 4560.63 0.01
2007 1 2 5254.76 0.01
2008 1 2 5394.94 0.01
2009 1 2 5329.1 0.01
2010 1 2 4793.21 0.01
2011 1 2 4017.9 0.01
2012 1 2 5197.76 0.01
2013 1 2 4360.6 0.01
2014 1 2 2885.88 0.01
2015 1 2 3455.93 0.01
2016 1 2 2152 0.01
2017 1 2 2254.56 0.01
2018 1 2 2094.89 0.01
2019 1 2 2134.81 0.01
2020 1 2 2015.3 0.01
2021 1 2 1874.83 0.01
2022 1 2 1530.24 0.01
2023 1 2 1340.57 0.01
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
2000 7 1 0.000135163 0.152765 #_orig_obs: 0.000157071 Fleet_1
2001 7 1 0.000131404 0.152765 #_orig_obs: 0.000126056 Fleet_1
2002 7 1 0.000126111 0.152765 #_orig_obs: 0.000143716 Fleet_1
2003 7 1 0.000124521 0.152765 #_orig_obs: 9.7e-05 Fleet_1
2004 7 1 0.000121343 0.152765 #_orig_obs: 0.000115653 Fleet_1
2005 7 1 0.000122646 0.152765 #_orig_obs: 0.000110721 Fleet_1
2006 7 1 0.00012605 0.152765 #_orig_obs: 0.000123072 Fleet_1
2007 7 1 0.000125663 0.152765 #_orig_obs: 0.000143974 Fleet_1
2008 7 1 0.00012556 0.152765 #_orig_obs: 0.00013286 Fleet_1
2009 7 1 0.000130474 0.152765 #_orig_obs: 0.000147786 Fleet_1
2010 7 1 0.000136253 0.152765 #_orig_obs: 0.000118078 Fleet_1
2011 7 1 0.000138749 0.152765 #_orig_obs: 0.000111093 Fleet_1
2012 7 1 0.000139967 0.152765 #_orig_obs: 0.000147501 Fleet_1
2013 7 1 0.000140592 0.152765 #_orig_obs: 0.000128946 Fleet_1
2014 7 1 0.000136179 0.152765 #_orig_obs: 0.00011487 Fleet_1
2015 7 1 0.000127586 0.152765 #_orig_obs: 0.000135493 Fleet_1
2016 7 1 0.000117789 0.152765 #_orig_obs: 0.00013237 Fleet_1
2017 7 1 0.000106916 0.152765 #_orig_obs: 0.000130696 Fleet_1
2018 7 1 9.77847e-05 0.152765 #_orig_obs: 0.000103782 Fleet_1
2019 7 -1 9.56678e-05 0.152765 #_orig_obs: 0.000127599 Fleet_1
2020 7 -1 0.000101474 0.152765 #_orig_obs: 0.000127537 Fleet_1
2021 7 -1 0.000112825 0.152765 #_orig_obs: 8.67e-05 Fleet_1
2022 7 -1 0.000124594 0.152765 #_orig_obs: 8.61e-05 Fleet_1
2000 7 2 2.6655e-05 0.0401056 #_orig_obs: 2.7e-05 Fleet_2
2001 7 2 2.31964e-05 0.040106 #_orig_obs: 2.28e-05 Fleet_2
2002 7 2 2.39782e-05 0.0401059 #_orig_obs: 2.45e-05 Fleet_2
2003 7 2 2.38702e-05 0.0401059 #_orig_obs: 2.39e-05 Fleet_2
2004 7 2 2.52471e-05 0.0401058 #_orig_obs: 2.49e-05 Fleet_2
2005 7 2 2.81711e-05 0.0401054 #_orig_obs: 2.87e-05 Fleet_2
2006 7 2 2.61532e-05 0.0401057 #_orig_obs: 2.58e-05 Fleet_2
2007 7 2 2.63012e-05 0.0401057 #_orig_obs: 2.61e-05 Fleet_2
2008 7 2 3.02867e-05 0.0401052 #_orig_obs: 3.07e-05 Fleet_2
2009 7 2 3.1834e-05 0.0401051 #_orig_obs: 3.18e-05 Fleet_2
2010 7 2 2.87291e-05 0.0401053 #_orig_obs: 2.97e-05 Fleet_2
2011 7 2 2.84031e-05 0.0401056 #_orig_obs: 2.73e-05 Fleet_2
2012 7 2 3.13088e-05 0.040105 #_orig_obs: 3.26e-05 Fleet_2
2013 7 2 2.73192e-05 0.0401055 #_orig_obs: 2.77e-05 Fleet_2
2014 7 2 2.3245e-05 0.0401061 #_orig_obs: 2.18e-05 Fleet_2
2015 7 2 2.29482e-05 0.0401059 #_orig_obs: 2.4e-05 Fleet_2
2016 7 2 2.02365e-05 0.0401063 #_orig_obs: 1.96e-05 Fleet_2
2017 7 2 1.79396e-05 0.0401065 #_orig_obs: 1.78e-05 Fleet_2
2018 7 2 1.94605e-05 0.0401064 #_orig_obs: 1.94e-05 Fleet_2
2019 7 -2 2.29117e-05 0.0401051 #_orig_obs: 3.24e-05 Fleet_2
2020 7 -2 2.59157e-05 0.0401044 #_orig_obs: 3.94e-05 Fleet_2
2021 7 -2 2.76815e-05 0.040106 #_orig_obs: 2.32e-05 Fleet_2
2022 7 -2 2.85441e-05 0.0401062 #_orig_obs: 2.06e-05 Fleet_2
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
 1988 6 1 1 0 62.3694  0.061519 2.83927 17.1698 23.8857 14.467 3.13918 0.311413 0.0654054 0.0614652 0.0614477 0.0614477 0.0614477 0.0614477 0.0614477 0.0614477 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
 1997 6 1 1 0 1.80543  0.00177974 0.0270233 0.163811 0.39015 0.493134 0.367214 0.233878 0.0910657 0.0224651 0.00512279 0.00238264 0.00197882 0.00184728 0.00179584 0.0017821 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
 2001 6 1 1 0 4.08137  0.00402242 0.0380311 0.218682 0.595199 1.06235 1.01793 0.732326 0.299384 0.0744266 0.015387 0.00610049 0.00481782 0.00441213 0.00419333 0.00410331 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
 2003 6 1 1 0 2.92151  0.00287983 0.0276972 0.162102 0.531955 0.753921 0.60756 0.485964 0.247497 0.0698853 0.0140969 0.00493908 0.00367884 0.0032822 0.00306726 0.00298774 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
 1988 6 1 2 0 8.91226  0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0.00879074 0.405717 2.45348 3.41313 2.06726 0.448573 0.0444992 0.00934608 0.00878305 0.00878056 0.00878055 0.00878055 0.00878055 0.00878055 0.00878055
 1997 6 1 2 0 0.486919  0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0.000479991 0.00728811 0.0441793 0.105222 0.132997 0.0990365 0.0630761 0.0245601 0.00605877 0.0013816 0.00064259 0.000533682 0.000498206 0.000484332 0.000480627
 2001 6 1 2 0 0.760469  0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0.000749486 0.00708622 0.0407463 0.110902 0.197945 0.189668 0.136452 0.0557833 0.0138677 0.00286701 0.00113669 0.000897691 0.0008221 0.00078133 0.000764558
 2003 6 1 2 0 0.497861  0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0.000490758 0.00471993 0.0276242 0.0906515 0.128477 0.103535 0.0828141 0.0421765 0.0119093 0.00240228 0.000841678 0.000626918 0.000559325 0.000522697 0.000509146
 1988 6 2 1 0 3.2148  0.00316881 0.0347752 2.30989 0.71101 0.116948 0.0103454 0.00332248 0.00316896 0.00316731 0.00316729 0.00316729 0.00316729 0.00316729 0.00316729 0.00316729 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
 1990 6 2 1 0 0.17625  0.000173762 0.00136097 0.0871252 0.0576456 0.0241508 0.00390965 0.000464894 0.000200303 0.000176756 0.000173869 0.000173653 0.000173645 0.000173645 0.000173645 0.000173645 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
 2008 6 2 1 0 0.2397  0.000236257 0.00184135 0.133413 0.071871 0.022145 0.00588145 0.00138762 0.000577389 0.000450097 0.000401689 0.000361615 0.000323152 0.000288573 0.000263154 0.000258181 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
 2022 10 2 1 0 0.780294  0.000769137 0.00536734 0.386902 0.251418 0.0984132 0.0234917 0.00453509 0.00175421 0.00136145 0.00124773 0.00116281 0.00107064 0.000976432 0.000895889 0.000928863 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
 1988 6 2 2 0 0.459378  0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0.000452806 0.00496919 0.330071 0.1016 0.0167112 0.00147831 0.000474765 0.000452828 0.000452592 0.000452589 0.000452589 0.000452589 0.000452589 0.000452589 0.000452589
 1990 6 2 2 0 0.065988  0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 6.50565e-05 0.000509546 0.0326197 0.0215825 0.00904207 0.00146377 0.000174056 7.49935e-05 6.61774e-05 6.50964e-05 6.50156e-05 6.50129e-05 6.50128e-05 6.50128e-05 6.50128e-05
 2008 6 2 2 0 0.0423  0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 4.16924e-05 0.000324943 0.0235435 0.0126831 0.00390794 0.0010379 0.000244874 0.000101892 7.94288e-05 7.08863e-05 6.38144e-05 5.70269e-05 5.09246e-05 4.64389e-05 4.55614e-05
 2022 10 2 2 0 0.170892  0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0.000168449 0.0011755 0.0847353 0.0550629 0.0215535 0.0051449 0.000993229 0.000384189 0.000298172 0.000273266 0.000254666 0.00023448 0.000213848 0.000196208 0.00020343
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

