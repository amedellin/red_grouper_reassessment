#V3.30.22.1;_safe;_compile_date:_Jan 30 2024;_Stock_Synthesis_by_Richard_Methot_(NOAA)_using_ADMB_13.1
#_Stock_Synthesis_is_a_work_of_the_U.S._Government_and_is_not_subject_to_copyright_protection_in_the_United_States.
#_Foreign_copyrights_may_apply._See_copyright.txt_for_more_information.
#_User_support_available_at:NMFS.Stock.Synthesis@noaa.gov
#_User_info_available_at:https://vlab.noaa.gov/group/stock-synthesis
#_Source_code_at:_https://github.com/nmfs-ost/ss3-source-code

#_Start_time: Sat Oct  4 19:09:46 2025
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
-999 1 1 10735.3 0.01
1986 1 1 2456.69 0.01
1987 1 1 3831.5 0.01
1988 1 1 3805.14 0.01
1989 1 1 1895.34 0.01
1990 1 1 3458.42 0.01
1991 1 1 4584.03 0.01
1992 1 1 4320.36 0.01
1993 1 1 3681.65 0.01
1994 1 1 3855.31 0.01
1995 1 1 4133.99 0.01
1996 1 1 1523.02 0.01
1997 1 1 2806.51 0.01
1998 1 1 2652.24 0.01
1999 1 1 2863.44 0.01
2000 1 1 3770.93 0.01
2001 1 1 2312.84 0.01
2002 1 1 2791.67 0.01
2003 1 1 1136.78 0.01
2004 1 1 1668.49 0.01
2005 1 1 1570.77 0.01
2006 1 1 1577.35 0.01
2007 1 1 3544.74 0.01
2008 1 1 3718.24 0.01
2009 1 1 4668.5 0.01
2010 1 1 2921.72 0.01
2011 1 1 2310.08 0.01
2012 1 1 4055.15 0.01
2013 1 1 3252.43 0.01
2014 1 1 2607.42 0.01
2015 1 1 3809.3 0.01
2016 1 1 3890.76 0.01
2017 1 1 4060.36 0.01
2018 1 1 3051.33 0.01
2019 1 1 3512.58 0.01
2020 1 1 2997.93 0.01
2021 1 1 2817.94 0.01
2022 1 1 3657.68 0.01
2023 1 1 2909.68 0.01
-999 1 2 0.47782 0.01
1986 1 2 5508.98 0.01
1987 1 2 8838.68 0.01
1988 1 2 7836.26 0.01
1989 1 2 7748.97 0.01
1990 1 2 7577.5 0.01
1991 1 2 7753.71 0.01
1992 1 2 7102.29 0.01
1993 1 2 6004.76 0.01
1994 1 2 6516.45 0.01
1995 1 2 6835.07 0.01
1996 1 2 5505.86 0.01
1997 1 2 4806.61 0.01
1998 1 2 4600.39 0.01
1999 1 2 4951.51 0.01
2000 1 2 5689.57 0.01
2001 1 2 4832.97 0.01
2002 1 2 2.34754 0.01
2003 1 2 4655.04 0.01
2004 1 2 3827.14 0.01
2005 1 2 5457.26 0.01
2006 1 2 4562.12 0.01
2007 1 2 5252.13 0.01
2008 1 2 5395.49 0.01
2009 1 2 5331.33 0.01
2010 1 2 4795.57 0.01
2011 1 2 4022.18 0.01
2012 1 2 5200.11 0.01
2013 1 2 4366.47 0.01
2014 1 2 2889.82 0.01
2015 1 2 3461.22 0.01
2016 1 2 2151.49 0.01
2017 1 2 2259.28 0.01
2018 1 2 2095.38 0.01
2019 1 2 2134.83 0.01
2020 1 2 2014.53 0.01
2021 1 2 1872.06 0.01
2022 1 2 1531.11 0.01
2023 1 2 1340.53 0.01
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
2000 7 1 0.000139132 0.152765 #_orig_obs: 0.000157071 Fleet_1
2001 7 1 0.000106125 0.152765 #_orig_obs: 0.000126056 Fleet_1
2002 7 1 0.000111544 0.152765 #_orig_obs: 0.000143716 Fleet_1
2003 7 1 0.000107136 0.152765 #_orig_obs: 9.7e-05 Fleet_1
2004 7 1 0.000123599 0.152765 #_orig_obs: 0.000115653 Fleet_1
2005 7 1 0.000132237 0.152765 #_orig_obs: 0.000110721 Fleet_1
2006 7 1 0.000122786 0.152765 #_orig_obs: 0.000123072 Fleet_1
2007 7 1 0.00013654 0.152765 #_orig_obs: 0.000143974 Fleet_1
2008 7 1 0.000155352 0.152765 #_orig_obs: 0.00013286 Fleet_1
2009 7 1 0.000156418 0.152765 #_orig_obs: 0.000147786 Fleet_1
2010 7 1 0.000137864 0.152765 #_orig_obs: 0.000118078 Fleet_1
2011 7 1 0.000131848 0.152765 #_orig_obs: 0.000111093 Fleet_1
2012 7 1 0.000160676 0.152765 #_orig_obs: 0.000147501 Fleet_1
2013 7 1 0.000123178 0.152765 #_orig_obs: 0.000128946 Fleet_1
2014 7 1 0.000108406 0.152765 #_orig_obs: 0.00011487 Fleet_1
2015 7 1 0.000116707 0.152765 #_orig_obs: 0.000135493 Fleet_1
2016 7 1 9.57084e-05 0.152765 #_orig_obs: 0.00013237 Fleet_1
2017 7 1 9.22401e-05 0.152765 #_orig_obs: 0.000130696 Fleet_1
2018 7 1 0.000101048 0.152765 #_orig_obs: 0.000103782 Fleet_1
2019 7 1 0.000154974 0.152765 #_orig_obs: 0.000127599 Fleet_1
2020 7 1 0.000146775 0.152765 #_orig_obs: 0.000127537 Fleet_1
2021 7 1 9.61056e-05 0.152765 #_orig_obs: 8.67e-05 Fleet_1
2022 7 1 9.9869e-05 0.152765 #_orig_obs: 8.61e-05 Fleet_1
2000 7 2 2.73254e-05 0.0401056 #_orig_obs: 2.7e-05 Fleet_2
2001 7 2 2.27999e-05 0.040106 #_orig_obs: 2.28e-05 Fleet_2
2002 7 2 2.5049e-05 0.0401059 #_orig_obs: 2.45e-05 Fleet_2
2003 7 2 2.38898e-05 0.0401059 #_orig_obs: 2.39e-05 Fleet_2
2004 7 2 2.48602e-05 0.0401058 #_orig_obs: 2.49e-05 Fleet_2
2005 7 2 2.83959e-05 0.0401054 #_orig_obs: 2.87e-05 Fleet_2
2006 7 2 2.57418e-05 0.0401057 #_orig_obs: 2.58e-05 Fleet_2
2007 7 2 2.63264e-05 0.0401057 #_orig_obs: 2.61e-05 Fleet_2
2008 7 2 3.0318e-05 0.0401052 #_orig_obs: 3.07e-05 Fleet_2
2009 7 2 3.18777e-05 0.0401051 #_orig_obs: 3.18e-05 Fleet_2
2010 7 2 2.92597e-05 0.0401053 #_orig_obs: 2.97e-05 Fleet_2
2011 7 2 2.71747e-05 0.0401056 #_orig_obs: 2.73e-05 Fleet_2
2012 7 2 3.23749e-05 0.040105 #_orig_obs: 3.26e-05 Fleet_2
2013 7 2 2.75692e-05 0.0401055 #_orig_obs: 2.77e-05 Fleet_2
2014 7 2 2.20506e-05 0.0401061 #_orig_obs: 2.18e-05 Fleet_2
2015 7 2 2.39003e-05 0.0401059 #_orig_obs: 2.4e-05 Fleet_2
2016 7 2 2.00203e-05 0.0401063 #_orig_obs: 1.96e-05 Fleet_2
2017 7 2 1.81014e-05 0.0401065 #_orig_obs: 1.78e-05 Fleet_2
2018 7 2 1.95549e-05 0.0401064 #_orig_obs: 1.94e-05 Fleet_2
2019 7 2 3.22168e-05 0.0401051 #_orig_obs: 3.24e-05 Fleet_2
2020 7 2 3.81788e-05 0.0401044 #_orig_obs: 3.94e-05 Fleet_2
2021 7 2 2.34343e-05 0.040106 #_orig_obs: 2.32e-05 Fleet_2
2022 7 2 2.03406e-05 0.0401062 #_orig_obs: 2.06e-05 Fleet_2
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
 1988 6 1 1 0 62.3694  0.0615258 1.58505 18.0639 27.3579 12.2838 2.27018 0.249375 0.0674461 0.0615453 0.0614489 0.0614478 0.0614477 0.0614477 0.0614477 0.0614477 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
 1997 6 1 1 0 1.80543  0.00178098 0.0178772 0.208519 0.646481 0.578443 0.256848 0.0701637 0.011669 0.00280479 0.00190203 0.00180918 0.00179086 0.00178265 0.00177961 0.00177889 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
 2001 6 1 1 0 4.08137  0.00402724 0.0537151 0.659127 1.88464 1.15774 0.263126 0.0258339 0.00479616 0.00411684 0.00405834 0.00404449 0.00404283 0.004038 0.00403061 0.00402621 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
 2003 6 1 1 0 2.92151  0.00288344 0.0577146 0.59555 1.18216 0.769438 0.243068 0.0444354 0.00596262 0.00298565 0.0028873 0.00288461 0.00288596 0.00288613 0.00288419 0.00288319 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
 1988 6 1 2 0 8.91226  0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0.00879172 0.226495 2.58124 3.90929 1.7553 0.324396 0.0356343 0.00963769 0.00879451 0.00878073 0.00878056 0.00878056 0.00878055 0.00878055 0.00878055
 1997 6 1 2 0 0.486919  0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0.000480326 0.00482142 0.056237 0.174354 0.156004 0.0692712 0.0189229 0.00314709 0.000756444 0.000512971 0.00048793 0.000482988 0.000480775 0.000479954 0.000479761
 2001 6 1 2 0 0.760469  0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0.000750384 0.0100086 0.122813 0.35116 0.215718 0.0490275 0.00481355 0.000893654 0.000767078 0.000756178 0.000753599 0.000753288 0.000752389 0.000751012 0.000750192
 2003 6 1 2 0 0.497861  0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0.000491373 0.00983525 0.101489 0.201455 0.131121 0.0414217 0.00757232 0.0010161 0.000508791 0.000492031 0.000491572 0.000491803 0.000491831 0.0004915 0.00049133
 1988 6 2 1 0 3.2148  0.00317702 0.0111169 0.308197 1.26786 1.28666 0.278922 0.032272 0.0043917 0.00319272 0.00316763 0.00316731 0.0031673 0.00316729 0.00316729 0.00316729 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
 1990 6 2 1 0 0.17625  0.000173807 0.000238971 0.00319734 0.0352939 0.0919836 0.0379857 0.00563764 0.000513493 0.000183541 0.000173794 0.000173647 0.000173645 0.000173645 0.000173645 0.000173645 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
 2008 6 2 1 0 0.2397  0.000236826 0.000601539 0.0150201 0.094049 0.103259 0.0219772 0.0025505 0.000348157 0.000239967 0.000236315 0.000236203 0.000236213 0.000236248 0.000236285 0.00023673 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
 2022 10 2 1 0 0.780294  0.000771514 0.00186122 0.0442766 0.299004 0.322561 0.0807483 0.0210239 0.00436626 0.00105745 0.00077975 0.000769167 0.000768799 0.000768774 0.000768774 0.000768826 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
 1988 6 2 2 0 0.459378  0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0.00045398 0.00158854 0.0440398 0.181171 0.183857 0.0398565 0.0046115 0.000627551 0.000456222 0.000452638 0.000452591 0.00045259 0.00045259 0.000452589 0.000452589
 1990 6 2 2 0 0.065988  0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 6.50733e-05 8.94706e-05 0.00119708 0.013214 0.0344387 0.0142219 0.00211073 0.000192252 6.87177e-05 6.50686e-05 6.50136e-05 6.50128e-05 6.50128e-05 6.50128e-05 6.50128e-05
 2008 6 2 2 0 0.0423  0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 4.17928e-05 0.000106154 0.00265061 0.0165969 0.0182221 0.00387833 0.000450089 6.14394e-05 4.23472e-05 4.17026e-05 4.16829e-05 4.16847e-05 4.16908e-05 4.16973e-05 4.17759e-05
 2022 10 2 2 0 0.170892  0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0.000168969 0.000407626 0.00969702 0.0654848 0.070644 0.0176847 0.00460443 0.000956254 0.000231592 0.000170773 0.000168455 0.000168375 0.000168369 0.000168369 0.00016838
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

