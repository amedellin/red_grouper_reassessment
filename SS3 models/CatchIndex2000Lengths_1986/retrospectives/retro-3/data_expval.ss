#V3.30.22.1;_safe;_compile_date:_Jan 30 2024;_Stock_Synthesis_by_Richard_Methot_(NOAA)_using_ADMB_13.1
#_Stock_Synthesis_is_a_work_of_the_U.S._Government_and_is_not_subject_to_copyright_protection_in_the_United_States.
#_Foreign_copyrights_may_apply._See_copyright.txt_for_more_information.
#_User_support_available_at:NMFS.Stock.Synthesis@noaa.gov
#_User_info_available_at:https://vlab.noaa.gov/group/stock-synthesis
#_Source_code_at:_https://github.com/nmfs-ost/ss3-source-code

#_Start_time: Sat Oct  4 19:10:42 2025
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
-999 1 1 3407.14 0.01
1986 1 1 2461.7 0.01
1987 1 1 3843.58 0.01
1988 1 1 3811.12 0.01
1989 1 1 1895.16 0.01
1990 1 1 3458.43 0.01
1991 1 1 4584.36 0.01
1992 1 1 4320.71 0.01
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
-999 1 2 9013.53 0.01
1986 1 2 5511.39 0.01
1987 1 2 8831.28 0.01
1988 1 2 7848.51 0.01
1989 1 2 7748.15 0.01
1990 1 2 7577.54 0.01
1991 1 2 7754.35 0.01
1992 1 2 7103.01 0.01
1993 1 2 6004.98 0.01
1994 1 2 6516.76 0.01
1995 1 2 6836.25 0.01
1996 1 2 5505.59 0.01
1997 1 2 4807.7 0.01
1998 1 2 4599.88 0.01
1999 1 2 4950.38 0.01
2000 1 2 5694.44 0.01
2001 1 2 4842.35 0.01
2002 1 2 2.3474 0.01
2003 1 2 4656.27 0.01
2004 1 2 3825.34 0.01
2005 1 2 5458.19 0.01
2006 1 2 4560.63 0.01
2007 1 2 5254.77 0.01
2008 1 2 5394.94 0.01
2009 1 2 5329.11 0.01
2010 1 2 4793.21 0.01
2011 1 2 4017.9 0.01
2012 1 2 5197.77 0.01
2013 1 2 4360.61 0.01
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
2000 7 1 0.000138717 0.152765 #_orig_obs: 0.000157071 Fleet_1
2001 7 1 0.000127098 0.152765 #_orig_obs: 0.000126056 Fleet_1
2002 7 1 0.000124425 0.152765 #_orig_obs: 0.000143716 Fleet_1
2003 7 1 0.000130504 0.152765 #_orig_obs: 9.7e-05 Fleet_1
2004 7 1 0.000128952 0.152765 #_orig_obs: 0.000115653 Fleet_1
2005 7 1 0.000131474 0.152765 #_orig_obs: 0.000110721 Fleet_1
2006 7 1 0.000133655 0.152765 #_orig_obs: 0.000123072 Fleet_1
2007 7 1 0.00012961 0.152765 #_orig_obs: 0.000143974 Fleet_1
2008 7 1 0.000126297 0.152765 #_orig_obs: 0.00013286 Fleet_1
2009 7 1 0.000129225 0.152765 #_orig_obs: 0.000147786 Fleet_1
2010 7 1 0.000132624 0.152765 #_orig_obs: 0.000118078 Fleet_1
2011 7 1 0.000137145 0.152765 #_orig_obs: 0.000111093 Fleet_1
2012 7 1 0.000139939 0.152765 #_orig_obs: 0.000147501 Fleet_1
2013 7 1 0.000139789 0.152765 #_orig_obs: 0.000128946 Fleet_1
2014 7 1 0.000134975 0.152765 #_orig_obs: 0.00011487 Fleet_1
2015 7 1 0.000126097 0.152765 #_orig_obs: 0.000135493 Fleet_1
2016 7 1 0.000115549 0.152765 #_orig_obs: 0.00013237 Fleet_1
2017 7 1 0.00010338 0.152765 #_orig_obs: 0.000130696 Fleet_1
2018 7 1 9.54594e-05 0.152765 #_orig_obs: 0.000103782 Fleet_1
2019 7 1 0.00010584 0.152765 #_orig_obs: 0.000127599 Fleet_1
2020 7 1 0.00013911 0.152765 #_orig_obs: 0.000127537 Fleet_1
2021 7 -1 0.000177573 0.152765 #_orig_obs: 8.67e-05 Fleet_1
2022 7 -1 0.000203878 0.152765 #_orig_obs: 8.61e-05 Fleet_1
2000 7 2 2.67607e-05 0.0401056 #_orig_obs: 2.7e-05 Fleet_2
2001 7 2 2.28836e-05 0.040106 #_orig_obs: 2.28e-05 Fleet_2
2002 7 2 2.40062e-05 0.0401059 #_orig_obs: 2.45e-05 Fleet_2
2003 7 2 2.38852e-05 0.0401059 #_orig_obs: 2.39e-05 Fleet_2
2004 7 2 2.49184e-05 0.0401058 #_orig_obs: 2.49e-05 Fleet_2
2005 7 2 2.81856e-05 0.0401054 #_orig_obs: 2.87e-05 Fleet_2
2006 7 2 2.61436e-05 0.0401057 #_orig_obs: 2.58e-05 Fleet_2
2007 7 2 2.62149e-05 0.0401057 #_orig_obs: 2.61e-05 Fleet_2
2008 7 2 3.0548e-05 0.0401052 #_orig_obs: 3.07e-05 Fleet_2
2009 7 2 3.16262e-05 0.0401051 #_orig_obs: 3.18e-05 Fleet_2
2010 7 2 2.91251e-05 0.0401053 #_orig_obs: 2.97e-05 Fleet_2
2011 7 2 2.7721e-05 0.0401056 #_orig_obs: 2.73e-05 Fleet_2
2012 7 2 3.18507e-05 0.040105 #_orig_obs: 3.26e-05 Fleet_2
2013 7 2 2.76283e-05 0.0401055 #_orig_obs: 2.77e-05 Fleet_2
2014 7 2 2.26842e-05 0.0401061 #_orig_obs: 2.18e-05 Fleet_2
2015 7 2 2.3377e-05 0.0401059 #_orig_obs: 2.4e-05 Fleet_2
2016 7 2 2.03859e-05 0.0401063 #_orig_obs: 1.96e-05 Fleet_2
2017 7 2 1.791e-05 0.0401065 #_orig_obs: 1.78e-05 Fleet_2
2018 7 2 1.97211e-05 0.0401064 #_orig_obs: 1.94e-05 Fleet_2
2019 7 2 3.21924e-05 0.0401051 #_orig_obs: 3.24e-05 Fleet_2
2020 7 2 3.93043e-05 0.0401044 #_orig_obs: 3.94e-05 Fleet_2
2021 7 -2 3.89532e-05 0.040106 #_orig_obs: 2.32e-05 Fleet_2
2022 7 -2 3.73753e-05 0.0401062 #_orig_obs: 2.06e-05 Fleet_2
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
 1988 6 1 1 0 62.3694  0.061754 2.65559 19.5704 23.5165 13.5101 2.31986 0.237514 0.067441 0.0615387 0.0614482 0.0614477 0.0614477 0.0614477 0.0614477 0.0614477 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
 1997 6 1 1 0 1.80543  0.00178011 0.00841114 0.0637196 0.23808 0.465205 0.490034 0.306801 0.158991 0.0509206 0.0112154 0.00297172 0.00192751 0.00180883 0.00178446 0.00177955 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
 2001 6 1 1 0 4.08137  0.00402373 0.0148674 0.108096 0.401615 0.867444 1.08928 0.82076 0.508245 0.193122 0.0462489 0.0101406 0.00498912 0.00432738 0.00413673 0.0040679 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
 2003 6 1 1 0 2.92151  0.00288061 0.0129853 0.0805498 0.273128 0.67575 0.787546 0.539724 0.34667 0.144147 0.0369867 0.00820423 0.00379345 0.00319386 0.00301032 0.00294496 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
 1988 6 1 2 0 8.91226  0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0.00882432 0.37947 2.79651 3.36039 1.93052 0.331496 0.0339395 0.00963696 0.00879356 0.00878062 0.00878055 0.00878055 0.00878055 0.00878055 0.00878055
 1997 6 1 2 0 0.486919  0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0.00048009 0.00226846 0.017185 0.0642093 0.125464 0.132161 0.0827434 0.0428794 0.0137331 0.00302477 0.000801463 0.000519843 0.000487836 0.000481264 0.00047994
 2001 6 1 2 0 0.760469  0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0.00074973 0.0027702 0.0201412 0.0748318 0.161628 0.202963 0.15293 0.0946998 0.0359839 0.00861742 0.00188946 0.000929608 0.000806309 0.000770785 0.00075796
 2003 6 1 2 0 0.497861  0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0.00049089 0.00221286 0.0137267 0.0465443 0.115156 0.134207 0.0919754 0.0590767 0.0245644 0.00630298 0.0013981 0.00064645 0.000544272 0.000512994 0.000501856
 1988 6 2 1 0 3.2148  0.00317282 0.00317224 0.582108 2.2378 0.340141 0.0195197 0.00354572 0.00317074 0.00316733 0.00316729 0.00316729 0.00316729 0.00316729 0.00316729 0.00316729 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
 1990 6 2 1 0 0.17625  0.000173762 0.000173692 0.0067419 0.0985454 0.0585158 0.0100869 0.000613596 0.000183144 0.00017389 0.000173654 0.000173646 0.000173645 0.000173645 0.000173645 0.000173645 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
 2008 6 2 1 0 0.2397  0.000236285 0.000236225 0.0112488 0.1427 0.061948 0.016728 0.00367722 0.000826357 0.000401683 0.000337483 0.000308902 0.00028512 0.000265685 0.000251707 0.000248544 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
 2022 10 2 1 0 0.780294  0.000769174 0.000768942 0.0275137 0.377389 0.243958 0.097844 0.0220399 0.00348848 0.00126052 0.000992184 0.000917982 0.000873984 0.000839176 0.000811904 0.000826124 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
 1988 6 2 2 0 0.459378  0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0.000453379 0.000453296 0.0831802 0.31977 0.0486044 0.00278926 0.000506665 0.000453082 0.000452594 0.000452589 0.000452589 0.000452589 0.000452589 0.000452589 0.000452589
 1990 6 2 2 0 0.065988  0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 6.50565e-05 6.50301e-05 0.00252417 0.0368954 0.0219083 0.00377653 0.000229731 6.85691e-05 6.51044e-05 6.50162e-05 6.50129e-05 6.50128e-05 6.50128e-05 6.50128e-05 6.50128e-05
 2008 6 2 2 0 0.0423  0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 4.16973e-05 4.16868e-05 0.00198509 0.0251823 0.010932 0.002952 0.000648921 0.000145828 7.08852e-05 5.95559e-05 5.45121e-05 5.03153e-05 4.68856e-05 4.44189e-05 4.38607e-05
 2022 10 2 2 0 0.170892  0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0.000168457 0.000168406 0.00602578 0.082652 0.0534293 0.0214288 0.00482695 0.00076401 0.000276067 0.000217298 0.000201047 0.000191411 0.000183788 0.000177815 0.000180929
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

