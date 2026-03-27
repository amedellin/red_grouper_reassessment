#V3.30.22.1;_safe;_compile_date:_Jan 30 2024;_Stock_Synthesis_by_Richard_Methot_(NOAA)_using_ADMB_13.1
#_Stock_Synthesis_is_a_work_of_the_U.S._Government_and_is_not_subject_to_copyright_protection_in_the_United_States.
#_Foreign_copyrights_may_apply._See_copyright.txt_for_more_information.
#_User_support_available_at:NMFS.Stock.Synthesis@noaa.gov
#_User_info_available_at:https://vlab.noaa.gov/group/stock-synthesis
#_Source_code_at:_https://github.com/nmfs-ost/ss3-source-code

#_Start_time: Sun Oct  5 18:33:06 2025
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
-999 1 1 6.68341 0.01
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
-999 1 2 6.13464 0.01
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
2000 7 1 0.000124357 0.152765 #_orig_obs: 0.000157071 Fleet_1
2001 7 1 0.000124356 0.152765 #_orig_obs: 0.000126056 Fleet_1
2002 7 1 0.000124356 0.152765 #_orig_obs: 0.000143716 Fleet_1
2003 7 1 0.000124356 0.152765 #_orig_obs: 9.7e-05 Fleet_1
2004 7 1 0.000124356 0.152765 #_orig_obs: 0.000115653 Fleet_1
2005 7 1 0.000124356 0.152765 #_orig_obs: 0.000110721 Fleet_1
2006 7 1 0.000124356 0.152765 #_orig_obs: 0.000123072 Fleet_1
2007 7 1 0.000124356 0.152765 #_orig_obs: 0.000143974 Fleet_1
2008 7 1 0.000124356 0.152765 #_orig_obs: 0.00013286 Fleet_1
2009 7 1 0.000124355 0.152765 #_orig_obs: 0.000147786 Fleet_1
2010 7 1 0.000124355 0.152765 #_orig_obs: 0.000118078 Fleet_1
2011 7 1 0.000124355 0.152765 #_orig_obs: 0.000111093 Fleet_1
2012 7 1 0.000124355 0.152765 #_orig_obs: 0.000147501 Fleet_1
2013 7 1 0.000124355 0.152765 #_orig_obs: 0.000128946 Fleet_1
2014 7 1 0.000124355 0.152765 #_orig_obs: 0.00011487 Fleet_1
2015 7 1 0.000124356 0.152765 #_orig_obs: 0.000135493 Fleet_1
2016 7 1 0.000124356 0.152765 #_orig_obs: 0.00013237 Fleet_1
2017 7 1 0.000124356 0.152765 #_orig_obs: 0.000130696 Fleet_1
2018 7 1 0.000124356 0.152765 #_orig_obs: 0.000103782 Fleet_1
2019 7 1 0.000124356 0.152765 #_orig_obs: 0.000127599 Fleet_1
2020 7 1 0.000124356 0.152765 #_orig_obs: 0.000127537 Fleet_1
2021 7 1 0.000124356 0.152765 #_orig_obs: 8.67e-05 Fleet_1
2022 7 -1 0.000124356 0.152765 #_orig_obs: 8.61e-05 Fleet_1
2000 7 2 2.59585e-05 0.195 #_orig_obs: 2.7e-05 Fleet_2
2001 7 2 2.59584e-05 0.195 #_orig_obs: 2.28e-05 Fleet_2
2002 7 2 2.59583e-05 0.195 #_orig_obs: 2.45e-05 Fleet_2
2003 7 2 2.59583e-05 0.195 #_orig_obs: 2.39e-05 Fleet_2
2004 7 2 2.59583e-05 0.195 #_orig_obs: 2.49e-05 Fleet_2
2005 7 2 2.59583e-05 0.195 #_orig_obs: 2.87e-05 Fleet_2
2006 7 2 2.59583e-05 0.195 #_orig_obs: 2.58e-05 Fleet_2
2007 7 2 2.59582e-05 0.195 #_orig_obs: 2.61e-05 Fleet_2
2008 7 2 2.59582e-05 0.195 #_orig_obs: 3.07e-05 Fleet_2
2009 7 2 2.59582e-05 0.195 #_orig_obs: 3.18e-05 Fleet_2
2010 7 2 2.59581e-05 0.195 #_orig_obs: 2.97e-05 Fleet_2
2011 7 2 2.59582e-05 0.195 #_orig_obs: 2.73e-05 Fleet_2
2012 7 2 2.59582e-05 0.195 #_orig_obs: 3.26e-05 Fleet_2
2013 7 2 2.59582e-05 0.195 #_orig_obs: 2.77e-05 Fleet_2
2014 7 2 2.59582e-05 0.195 #_orig_obs: 2.18e-05 Fleet_2
2015 7 2 2.59582e-05 0.195 #_orig_obs: 2.4e-05 Fleet_2
2016 7 2 2.59582e-05 0.195 #_orig_obs: 1.96e-05 Fleet_2
2017 7 2 2.59582e-05 0.195 #_orig_obs: 1.78e-05 Fleet_2
2018 7 2 2.59582e-05 0.195 #_orig_obs: 1.94e-05 Fleet_2
2019 7 2 2.59583e-05 0.195 #_orig_obs: 3.24e-05 Fleet_2
2020 7 2 2.59583e-05 0.195 #_orig_obs: 3.94e-05 Fleet_2
2021 7 2 2.59583e-05 0.195 #_orig_obs: 2.32e-05 Fleet_2
2022 7 -2 2.59583e-05 0.195 #_orig_obs: 2.06e-05 Fleet_2
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
 2001 6 1 1 0 10.0233  0.00987602 0.171218 0.900191 1.28209 1.5104 1.64509 1.55068 1.39077 0.949874 0.408672 0.117777 0.0334057 0.0184502 0.0155786 0.0191879 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
 2003 6 1 1 0 7.17482  0.00706943 0.122561 0.644373 0.917746 1.08117 1.17759 1.11 0.995533 0.679933 0.292532 0.0843061 0.0239123 0.013207 0.0111514 0.0137351 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
 2001 6 1 2 0 1.8676  0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0.00184017 0.0319026 0.16773 0.238889 0.281428 0.306525 0.288933 0.259138 0.176987 0.0761466 0.021945 0.00622439 0.00343777 0.00290271 0.00357523
 2003 6 1 2 0 1.22268  0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0.00120472 0.0208859 0.109809 0.156395 0.184245 0.200675 0.189158 0.169651 0.115869 0.049851 0.0143668 0.00407494 0.00225062 0.00190033 0.00234062
 2008 6 2 1 0 5.01245  0.00493887 0.0784893 0.427006 0.68146 0.854204 0.933831 0.843441 0.671181 0.339125 0.110856 0.0288426 0.0118223 0.0090953 0.00806424 0.0100934 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
 2022 10 2 1 0 16.317  0.0160775 0.255505 1.39003 2.21835 2.78068 3.0399 2.74565 2.1849 1.10395 0.360868 0.093891 0.038485 0.0296078 0.0262513 0.0328566 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
 2008 6 2 2 0 0.88455  0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0.000871565 0.013851 0.0753541 0.120258 0.150742 0.164794 0.148842 0.118444 0.0598455 0.0195628 0.00508987 0.00208629 0.00160505 0.0014231 0.00178118
 2022 10 2 2 0 3.57358  0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0.00352112 0.0559581 0.30443 0.48584 0.608997 0.665767 0.601324 0.478513 0.241776 0.0790336 0.0205631 0.00842859 0.00648439 0.0057493 0.00719591
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

