#V3.30.22.1;_safe;_compile_date:_Jan 30 2024;_Stock_Synthesis_by_Richard_Methot_(NOAA)_using_ADMB_13.1
#_Stock_Synthesis_is_a_work_of_the_U.S._Government_and_is_not_subject_to_copyright_protection_in_the_United_States.
#_Foreign_copyrights_may_apply._See_copyright.txt_for_more_information.
#_User_support_available_at:NMFS.Stock.Synthesis@noaa.gov
#_User_info_available_at:https://vlab.noaa.gov/group/stock-synthesis
#_Source_code_at:_https://github.com/nmfs-ost/ss3-source-code

#_Start_time: Mon Oct  6 10:03:34 2025
#_expected_values
#C should work with SS version:
#C file created using an r4ss function
#C file write time: 2025-10-03  17:50:59
#V3.30.22.1;_safe;_compile_date:_Jan 30 2024;_Stock_Synthesis_by_Richard_Methot_(NOAA)_using_ADMB_13.1
2000 #_StartYr
2023 #_EndYr
1 #_Nseas
 12 #_months/season
2 #_Nsubseasons (even number, minimum is 2)
1 #_spawn_month
2 #_Nsexes: 1, 2, -1  (use -1 for 1 sex setup with SSB multiplied by female_frac parameter)
24 #_Nages=accumulator age, first age is always age 0
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
-999 1 1 0.00740352 0.01
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
-999 1 2 0.00879807 0.01
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
2000 7 1 0.00012624 0.152765 #_orig_obs: 0.000157071 Fleet_1
2001 7 1 0.000125081 0.152765 #_orig_obs: 0.000126056 Fleet_1
2002 7 1 0.000124538 0.152765 #_orig_obs: 0.000143716 Fleet_1
2003 7 1 0.000124215 0.152765 #_orig_obs: 9.7e-05 Fleet_1
2004 7 1 0.000123823 0.152765 #_orig_obs: 0.000115653 Fleet_1
2005 7 1 0.000123441 0.152765 #_orig_obs: 0.000110721 Fleet_1
2006 7 1 0.000123105 0.152765 #_orig_obs: 0.000123072 Fleet_1
2007 7 1 0.000122701 0.152765 #_orig_obs: 0.000143974 Fleet_1
2008 7 1 0.00012213 0.152765 #_orig_obs: 0.00013286 Fleet_1
2009 7 1 0.000121544 0.152765 #_orig_obs: 0.000147786 Fleet_1
2010 7 1 0.000121148 0.152765 #_orig_obs: 0.000118078 Fleet_1
2011 7 1 0.000121117 0.152765 #_orig_obs: 0.000111093 Fleet_1
2012 7 1 0.000121021 0.152765 #_orig_obs: 0.000147501 Fleet_1
2013 7 1 0.000120852 0.152765 #_orig_obs: 0.000128946 Fleet_1
2014 7 1 0.000120992 0.152765 #_orig_obs: 0.00011487 Fleet_1
2015 7 1 0.000121151 0.152765 #_orig_obs: 0.000135493 Fleet_1
2016 7 1 0.000121233 0.152765 #_orig_obs: 0.00013237 Fleet_1
2017 7 1 0.000121354 0.152765 #_orig_obs: 0.000130696 Fleet_1
2018 7 1 0.000121514 0.152765 #_orig_obs: 0.000103782 Fleet_1
2019 7 1 0.0001217 0.152765 #_orig_obs: 0.000127599 Fleet_1
2020 7 1 0.000121858 0.152765 #_orig_obs: 0.000127537 Fleet_1
2021 7 1 0.00012206 0.152765 #_orig_obs: 8.67e-05 Fleet_1
2022 7 1 0.00012221 0.152765 #_orig_obs: 8.61e-05 Fleet_1
2000 7 2 2.67074e-05 0.195 #_orig_obs: 2.7e-05 Fleet_2
2001 7 2 2.64578e-05 0.195 #_orig_obs: 2.28e-05 Fleet_2
2002 7 2 2.63278e-05 0.195 #_orig_obs: 2.45e-05 Fleet_2
2003 7 2 2.62389e-05 0.195 #_orig_obs: 2.39e-05 Fleet_2
2004 7 2 2.61288e-05 0.195 #_orig_obs: 2.49e-05 Fleet_2
2005 7 2 2.60197e-05 0.195 #_orig_obs: 2.87e-05 Fleet_2
2006 7 2 2.59193e-05 0.195 #_orig_obs: 2.58e-05 Fleet_2
2007 7 2 2.581e-05 0.195 #_orig_obs: 2.61e-05 Fleet_2
2008 7 2 2.56684e-05 0.195 #_orig_obs: 3.07e-05 Fleet_2
2009 7 2 2.55251e-05 0.195 #_orig_obs: 3.18e-05 Fleet_2
2010 7 2 2.54189e-05 0.195 #_orig_obs: 2.97e-05 Fleet_2
2011 7 2 2.53878e-05 0.195 #_orig_obs: 2.73e-05 Fleet_2
2012 7 2 2.5348e-05 0.195 #_orig_obs: 3.26e-05 Fleet_2
2013 7 2 2.52957e-05 0.195 #_orig_obs: 2.77e-05 Fleet_2
2014 7 2 2.53099e-05 0.195 #_orig_obs: 2.18e-05 Fleet_2
2015 7 2 2.53353e-05 0.195 #_orig_obs: 2.4e-05 Fleet_2
2016 7 2 2.53501e-05 0.195 #_orig_obs: 1.96e-05 Fleet_2
2017 7 2 2.53778e-05 0.195 #_orig_obs: 1.78e-05 Fleet_2
2018 7 2 2.54152e-05 0.195 #_orig_obs: 1.94e-05 Fleet_2
2019 7 2 2.54598e-05 0.195 #_orig_obs: 3.24e-05 Fleet_2
2020 7 2 2.55001e-05 0.195 #_orig_obs: 3.94e-05 Fleet_2
2021 7 2 2.55498e-05 0.195 #_orig_obs: 2.32e-05 Fleet_2
2022 7 2 2.55905e-05 0.195 #_orig_obs: 2.06e-05 Fleet_2
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
4 # minimum size in the population (lower edge of first bin and size at age 0.00) 
110 # maximum size in the population (lower edge of last bin) 
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
 2001 6 1 1 0 10.0233  0.00987668 0.174214 0.927381 1.35155 1.52029 1.51723 1.38328 1.17404 0.929455 0.634152 0.276996 0.0789744 0.0217811 0.0121974 0.0118362 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
 2003 6 1 1 0 7.17482  0.00706991 0.12523 0.666943 0.97262 1.09336 1.08832 0.988712 0.836431 0.660619 0.45013 0.196564 0.0561098 0.0155287 0.00872172 0.00846941 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
 2001 6 1 2 0 1.8676  0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0.00184029 0.0324608 0.172796 0.251831 0.283271 0.282701 0.257743 0.218755 0.173183 0.11816 0.0516119 0.0147151 0.0040584 0.00227271 0.00220541
 2003 6 1 2 0 1.22268  0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0.0012048 0.0213408 0.113655 0.165746 0.186321 0.185462 0.168488 0.142538 0.112577 0.0767075 0.0334968 0.00956179 0.00264628 0.00148629 0.00144329
 2008 6 2 1 0 5.01245  0.0049392 0.0733495 0.389315 0.579255 0.667863 0.685661 0.64648 0.571241 0.475963 0.374434 0.275664 0.17265 0.0686855 0.0192269 0.00772198 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
 2022 10 2 1 0 16.317  0.0160786 0.238482 1.26612 1.88606 2.17771 2.23836 2.1117 1.86551 1.55229 1.2174 0.891089 0.553249 0.217739 0.0606184 0.0245757 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
 2008 6 2 2 0 0.88455  0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0.000871624 0.012944 0.0687027 0.102222 0.117858 0.120999 0.114085 0.100807 0.0839935 0.0660766 0.0486467 0.0304677 0.012121 0.00339298 0.0013627
 2022 10 2 2 0 3.57358  0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0.00352136 0.0522298 0.277292 0.413066 0.476941 0.490223 0.462484 0.408565 0.339967 0.266623 0.195157 0.121167 0.0476871 0.013276 0.00538232
-9999 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 
#
24 #_N_age_bins
 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23
1 #_N_ageerror_definitions
 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1
 0.001 0.001 0.001 0.001 0.001 0.001 0.001 0.001 0.001 0.001 0.001 0.001 0.001 0.001 0.001 0.001 0.001 0.001 0.001 0.001 0.001 0.001 0.001 0.001 0.001
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
-9999  0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
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

