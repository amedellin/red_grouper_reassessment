#V3.30.22.1;_safe;_compile_date:_Jan 30 2024;_Stock_Synthesis_by_Richard_Methot_(NOAA)_using_ADMB_13.1
#_Stock_Synthesis_is_a_work_of_the_U.S._Government_and_is_not_subject_to_copyright_protection_in_the_United_States.
#_Foreign_copyrights_may_apply._See_copyright.txt_for_more_information.
#_User_support_available_at:NMFS.Stock.Synthesis@noaa.gov
#_User_info_available_at:https://vlab.noaa.gov/group/stock-synthesis
#_Source_code_at:_https://github.com/nmfs-ost/ss3-source-code

#_Start_time: Sat Oct  4 19:11:04 2025
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
-999 1 1 8268.91 0.01
1986 1 1 2461.33 0.01
1987 1 1 3849.99 0.01
1988 1 1 3807.7 0.01
1989 1 1 1895.16 0.01
1990 1 1 3458.43 0.01
1991 1 1 4584.36 0.01
1992 1 1 4320.72 0.01
1993 1 1 3681.76 0.01
1994 1 1 3855.46 0.01
1995 1 1 4134.62 0.01
1996 1 1 1522.95 0.01
1997 1 1 2807.07 0.01
1998 1 1 2651.99 0.01
1999 1 1 2862.9 0.01
2000 1 1 3773.76 0.01
2001 1 1 2316.76 0.01
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
-999 1 2 4534.51 0.01
1986 1 2 5519.92 0.01
1987 1 2 8862.22 0.01
1988 1 2 7841.89 0.01
1989 1 2 7748.15 0.01
1990 1 2 7577.53 0.01
1991 1 2 7754.33 0.01
1992 1 2 7102.99 0.01
1993 1 2 6004.97 0.01
1994 1 2 6516.75 0.01
1995 1 2 6836.23 0.01
1996 1 2 5505.59 0.01
1997 1 2 4807.69 0.01
1998 1 2 4599.88 0.01
1999 1 2 4950.37 0.01
2000 1 2 5694.43 0.01
2001 1 2 4842.35 0.01
2002 1 2 2.3474 0.01
2003 1 2 4656.27 0.01
2004 1 2 3825.34 0.01
2005 1 2 5458.19 0.01
2006 1 2 4560.63 0.01
2007 1 2 5254.77 0.01
2008 1 2 5394.94 0.01
2009 1 2 5329.1 0.01
2010 1 2 4793.21 0.01
2011 1 2 4017.9 0.01
2012 1 2 5197.77 0.01
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
2000 7 1 0.00014325 0.152765 #_orig_obs: 0.000157071 Fleet_1
2001 7 1 0.00012619 0.152765 #_orig_obs: 0.000126056 Fleet_1
2002 7 1 0.000123541 0.152765 #_orig_obs: 0.000143716 Fleet_1
2003 7 1 0.000128832 0.152765 #_orig_obs: 9.7e-05 Fleet_1
2004 7 1 0.000126924 0.152765 #_orig_obs: 0.000115653 Fleet_1
2005 7 1 0.000132048 0.152765 #_orig_obs: 0.000110721 Fleet_1
2006 7 1 0.000133402 0.152765 #_orig_obs: 0.000123072 Fleet_1
2007 7 1 0.000129292 0.152765 #_orig_obs: 0.000143974 Fleet_1
2008 7 1 0.000130728 0.152765 #_orig_obs: 0.00013286 Fleet_1
2009 7 1 0.000136527 0.152765 #_orig_obs: 0.000147786 Fleet_1
2010 7 1 0.000137701 0.152765 #_orig_obs: 0.000118078 Fleet_1
2011 7 1 0.000139336 0.152765 #_orig_obs: 0.000111093 Fleet_1
2012 7 1 0.000143762 0.152765 #_orig_obs: 0.000147501 Fleet_1
2013 7 1 0.00014126 0.152765 #_orig_obs: 0.000128946 Fleet_1
2014 7 1 0.000130642 0.152765 #_orig_obs: 0.00011487 Fleet_1
2015 7 1 0.000121739 0.152765 #_orig_obs: 0.000135493 Fleet_1
2016 7 1 0.000111199 0.152765 #_orig_obs: 0.00013237 Fleet_1
2017 7 1 9.81781e-05 0.152765 #_orig_obs: 0.000130696 Fleet_1
2018 7 1 9.39703e-05 0.152765 #_orig_obs: 0.000103782 Fleet_1
2019 7 1 0.000115921 0.152765 #_orig_obs: 0.000127599 Fleet_1
2020 7 -1 0.000157088 0.152765 #_orig_obs: 0.000127537 Fleet_1
2021 7 -1 0.000191601 0.152765 #_orig_obs: 8.67e-05 Fleet_1
2022 7 -1 0.000210522 0.152765 #_orig_obs: 8.61e-05 Fleet_1
2000 7 2 2.69023e-05 0.0401056 #_orig_obs: 2.7e-05 Fleet_2
2001 7 2 2.29456e-05 0.040106 #_orig_obs: 2.28e-05 Fleet_2
2002 7 2 2.40634e-05 0.0401059 #_orig_obs: 2.45e-05 Fleet_2
2003 7 2 2.3837e-05 0.0401059 #_orig_obs: 2.39e-05 Fleet_2
2004 7 2 2.48666e-05 0.0401058 #_orig_obs: 2.49e-05 Fleet_2
2005 7 2 2.81029e-05 0.0401054 #_orig_obs: 2.87e-05 Fleet_2
2006 7 2 2.60949e-05 0.0401057 #_orig_obs: 2.58e-05 Fleet_2
2007 7 2 2.6194e-05 0.0401057 #_orig_obs: 2.61e-05 Fleet_2
2008 7 2 3.05223e-05 0.0401052 #_orig_obs: 3.07e-05 Fleet_2
2009 7 2 3.15959e-05 0.0401051 #_orig_obs: 3.18e-05 Fleet_2
2010 7 2 2.90427e-05 0.0401053 #_orig_obs: 2.97e-05 Fleet_2
2011 7 2 2.76048e-05 0.0401056 #_orig_obs: 2.73e-05 Fleet_2
2012 7 2 3.19022e-05 0.040105 #_orig_obs: 3.26e-05 Fleet_2
2013 7 2 2.75573e-05 0.0401055 #_orig_obs: 2.77e-05 Fleet_2
2014 7 2 2.2595e-05 0.0401061 #_orig_obs: 2.18e-05 Fleet_2
2015 7 2 2.35009e-05 0.0401059 #_orig_obs: 2.4e-05 Fleet_2
2016 7 2 2.04034e-05 0.0401063 #_orig_obs: 1.96e-05 Fleet_2
2017 7 2 1.79464e-05 0.0401065 #_orig_obs: 1.78e-05 Fleet_2
2018 7 2 1.97291e-05 0.0401064 #_orig_obs: 1.94e-05 Fleet_2
2019 7 2 3.22585e-05 0.0401051 #_orig_obs: 3.24e-05 Fleet_2
2020 7 -2 3.9193e-05 0.0401044 #_orig_obs: 3.94e-05 Fleet_2
2021 7 -2 3.9265e-05 0.040106 #_orig_obs: 2.32e-05 Fleet_2
2022 7 -2 3.82613e-05 0.0401062 #_orig_obs: 2.06e-05 Fleet_2
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
 1988 6 1 1 0 62.3694  0.0615914 2.19822 18.888 25.0045 13.273 2.17786 0.266461 0.0694984 0.0615804 0.0614484 0.0614477 0.0614477 0.0614477 0.0614477 0.0614477 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
 1997 6 1 1 0 1.80543  0.00177985 0.011945 0.10921 0.376639 0.56292 0.397492 0.226979 0.0841194 0.0202445 0.00462454 0.00220678 0.00189155 0.00181188 0.00178573 0.00177984 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
 2001 6 1 1 0 4.08137  0.00402339 0.0214002 0.196281 0.694727 1.12482 0.954642 0.669729 0.295675 0.0798921 0.0168012 0.00610782 0.00470396 0.00433516 0.00415181 0.00407789 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
 2003 6 1 1 0 2.92151  0.00288033 0.0189242 0.143935 0.465281 0.885368 0.690842 0.428641 0.19643 0.0588096 0.013087 0.00466035 0.00350074 0.00318341 0.00301702 0.00295367 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
 1988 6 1 2 0 8.91226  0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0.00880109 0.314114 2.699 3.57301 1.89664 0.311204 0.0380759 0.00993096 0.00879952 0.00878066 0.00878055 0.00878055 0.00878055 0.00878055 0.00878055
 1997 6 1 2 0 0.486919  0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0.000480019 0.00322153 0.0294537 0.101578 0.151818 0.107202 0.0612156 0.0226867 0.00545988 0.00124722 0.000595162 0.000510145 0.00048866 0.000481605 0.000480018
 2001 6 1 2 0 0.760469  0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0.000749666 0.00398744 0.0365725 0.129446 0.209584 0.177876 0.124789 0.0550923 0.0148861 0.00313052 0.00113805 0.000876475 0.000807757 0.000773595 0.000759821
 2003 6 1 2 0 0.497861  0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0.000490843 0.00322492 0.0245282 0.0792895 0.150877 0.117728 0.0730456 0.033474 0.0100219 0.00223018 0.00079418 0.000596568 0.000542491 0.000514137 0.000503341
 1988 6 2 1 0 3.2148  0.0031721 0.00317142 0.532199 2.21683 0.399786 0.0302713 0.00401897 0.00318011 0.00316751 0.00316729 0.00316729 0.00316729 0.00316729 0.00316729 0.00316729 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
 1990 6 2 1 0 0.17625  0.000173763 0.000173692 0.00723866 0.0980627 0.0580291 0.0104546 0.000711862 0.000189511 0.000174266 0.000173684 0.000173647 0.000173645 0.000173645 0.000173645 0.000173645 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
 2008 6 2 1 0 0.2397  0.000236288 0.000236229 0.0124183 0.143571 0.0607046 0.0160718 0.00353475 0.000811634 0.000402228 0.000340303 0.000312265 0.000288336 0.00026827 0.000253443 0.000250914 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
 2022 10 2 1 0 0.780294  0.000769189 0.000768948 0.0302142 0.382825 0.24102 0.0939099 0.0209027 0.00334881 0.00124435 0.000992314 0.000923481 0.000881263 0.000845619 0.000816367 0.000832526 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
 1988 6 2 2 0 0.459378  0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0.000453276 0.00045318 0.0760484 0.316773 0.0571273 0.00432561 0.000574289 0.000454421 0.00045262 0.00045259 0.000452589 0.000452589 0.000452589 0.000452589 0.000452589
 1990 6 2 2 0 0.065988  0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 6.5057e-05 6.50302e-05 0.00271016 0.0367147 0.0217261 0.00391419 0.000266521 7.0953e-05 6.52452e-05 6.50272e-05 6.50136e-05 6.50128e-05 6.50128e-05 6.50128e-05 6.50128e-05
 2008 6 2 2 0 0.0423  0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 4.1698e-05 4.16874e-05 0.00219147 0.025336 0.0107126 0.00283619 0.00062378 0.00014323 7.09815e-05 6.00534e-05 5.51055e-05 5.08827e-05 4.73418e-05 4.47252e-05 4.42789e-05
 2022 10 2 2 0 0.170892  0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0.00016846 0.000168407 0.00661719 0.0838423 0.0527857 0.0205672 0.00457789 0.000733421 0.000272525 0.000217327 0.000202251 0.000193005 0.000185199 0.000178792 0.000182331
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

