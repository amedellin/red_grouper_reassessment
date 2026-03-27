#V3.30.22.1;_safe;_compile_date:_Jan 30 2024;_Stock_Synthesis_by_Richard_Methot_(NOAA)_using_ADMB_13.1
#_Stock_Synthesis_is_a_work_of_the_U.S._Government_and_is_not_subject_to_copyright_protection_in_the_United_States.
#_Foreign_copyrights_may_apply._See_copyright.txt_for_more_information.
#_User_support_available_at:NMFS.Stock.Synthesis@noaa.gov
#_User_info_available_at:https://vlab.noaa.gov/group/stock-synthesis
#_Source_code_at:_https://github.com/nmfs-ost/ss3-source-code

#_Start_time: Sat Oct  4 19:10:02 2025
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
-999 1 1 11053.4 0.01
1986 1 1 2456.58 0.01
1987 1 1 3843.15 0.01
1988 1 1 3805.91 0.01
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
2000 1 1 3778.79 0.01
2001 1 1 2319.34 0.01
2002 1 1 2791.61 0.01
2003 1 1 1139.1 0.01
2004 1 1 1670.43 0.01
2005 1 1 1574.02 0.01
2006 1 1 1580.08 0.01
2007 1 1 3552.51 0.01
2008 1 1 3724.28 0.01
2009 1 1 4662.83 0.01
2010 1 1 2922.24 0.01
2011 1 1 2309.85 0.01
2012 1 1 4052.04 0.01
2013 1 1 3245.08 0.01
2014 1 1 2603.66 0.01
2015 1 1 3797.28 0.01
2016 1 1 3887.73 0.01
2017 1 1 4047.54 0.01
2018 1 1 3049.9 0.01
2019 1 1 3512.01 0.01
2020 1 1 2998.51 0.01
2021 1 1 2819.22 0.01
2022 1 1 3654.94 0.01
2023 1 1 2909.36 0.01
-999 1 2 0.0060923 0.01
1986 1 2 5508.68 0.01
1987 1 2 8846.39 0.01
1988 1 2 7838.27 0.01
1989 1 2 7748.17 0.01
1990 1 2 7577.51 0.01
1991 1 2 7754.22 0.01
1992 1 2 7102.91 0.01
1993 1 2 6004.94 0.01
1994 1 2 6516.71 0.01
1995 1 2 6836.14 0.01
1996 1 2 5505.59 0.01
1997 1 2 4807.68 0.01
1998 1 2 4599.86 0.01
1999 1 2 4950.3 0.01
2000 1 2 5703.33 0.01
2001 1 2 4848.51 0.01
2002 1 2 2.34749 0.01
2003 1 2 4665.87 0.01
2004 1 2 3832.24 0.01
2005 1 2 5469.87 0.01
2006 1 2 4571.17 0.01
2007 1 2 5265.78 0.01
2008 1 2 5405.72 0.01
2009 1 2 5323.93 0.01
2010 1 2 4796.41 0.01
2011 1 2 4021.48 0.01
2012 1 2 5195.58 0.01
2013 1 2 4355.41 0.01
2014 1 2 2884.79 0.01
2015 1 2 3448.92 0.01
2016 1 2 2149.6 0.01
2017 1 2 2251.1 0.01
2018 1 2 2094.18 0.01
2019 1 2 2134.45 0.01
2020 1 2 2014.97 0.01
2021 1 2 1873.25 0.01
2022 1 2 1529.79 0.01
2023 1 2 1340.37 0.01
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
2000 7 1 0.00014895 0.152765 #_orig_obs: 0.000157071 Fleet_1
2001 7 1 0.000108285 0.152765 #_orig_obs: 0.000126056 Fleet_1
2002 7 1 0.000113863 0.152765 #_orig_obs: 0.000143716 Fleet_1
2003 7 1 0.000114559 0.152765 #_orig_obs: 9.7e-05 Fleet_1
2004 7 1 0.000120412 0.152765 #_orig_obs: 0.000115653 Fleet_1
2005 7 1 0.000130237 0.152765 #_orig_obs: 0.000110721 Fleet_1
2006 7 1 0.000124432 0.152765 #_orig_obs: 0.000123072 Fleet_1
2007 7 1 0.000130324 0.152765 #_orig_obs: 0.000143974 Fleet_1
2008 7 1 0.000147443 0.152765 #_orig_obs: 0.00013286 Fleet_1
2009 7 1 0.00014878 0.152765 #_orig_obs: 0.000147786 Fleet_1
2010 7 1 0.000133549 0.152765 #_orig_obs: 0.000118078 Fleet_1
2011 7 1 0.000133903 0.152765 #_orig_obs: 0.000111093 Fleet_1
2012 7 1 0.000151029 0.152765 #_orig_obs: 0.000147501 Fleet_1
2013 7 1 0.000124626 0.152765 #_orig_obs: 0.000128946 Fleet_1
2014 7 1 0.000108201 0.152765 #_orig_obs: 0.00011487 Fleet_1
2015 7 1 0.000112013 0.152765 #_orig_obs: 0.000135493 Fleet_1
2016 7 1 9.60717e-05 0.152765 #_orig_obs: 0.00013237 Fleet_1
2017 7 1 8.67561e-05 0.152765 #_orig_obs: 0.000130696 Fleet_1
2018 7 1 9.79858e-05 0.152765 #_orig_obs: 0.000103782 Fleet_1
2019 7 1 0.00014612 0.152765 #_orig_obs: 0.000127599 Fleet_1
2020 7 1 0.000161866 0.152765 #_orig_obs: 0.000127537 Fleet_1
2021 7 1 0.000114217 0.152765 #_orig_obs: 8.67e-05 Fleet_1
2022 7 1 9.85956e-05 0.152765 #_orig_obs: 8.61e-05 Fleet_1
2000 7 2 2.73003e-05 0.0401056 #_orig_obs: 2.7e-05 Fleet_2
2001 7 2 2.2952e-05 0.040106 #_orig_obs: 2.28e-05 Fleet_2
2002 7 2 2.48817e-05 0.0401059 #_orig_obs: 2.45e-05 Fleet_2
2003 7 2 2.37737e-05 0.0401059 #_orig_obs: 2.39e-05 Fleet_2
2004 7 2 2.48151e-05 0.0401058 #_orig_obs: 2.49e-05 Fleet_2
2005 7 2 2.84226e-05 0.0401054 #_orig_obs: 2.87e-05 Fleet_2
2006 7 2 2.57862e-05 0.0401057 #_orig_obs: 2.58e-05 Fleet_2
2007 7 2 2.62399e-05 0.0401057 #_orig_obs: 2.61e-05 Fleet_2
2008 7 2 3.05824e-05 0.0401052 #_orig_obs: 3.07e-05 Fleet_2
2009 7 2 3.17243e-05 0.0401051 #_orig_obs: 3.18e-05 Fleet_2
2010 7 2 2.94338e-05 0.0401053 #_orig_obs: 2.97e-05 Fleet_2
2011 7 2 2.70858e-05 0.0401056 #_orig_obs: 2.73e-05 Fleet_2
2012 7 2 3.24892e-05 0.040105 #_orig_obs: 3.26e-05 Fleet_2
2013 7 2 2.77072e-05 0.0401055 #_orig_obs: 2.77e-05 Fleet_2
2014 7 2 2.19431e-05 0.0401061 #_orig_obs: 2.18e-05 Fleet_2
2015 7 2 2.42525e-05 0.0401059 #_orig_obs: 2.4e-05 Fleet_2
2016 7 2 1.99985e-05 0.0401063 #_orig_obs: 1.96e-05 Fleet_2
2017 7 2 1.82077e-05 0.0401065 #_orig_obs: 1.78e-05 Fleet_2
2018 7 2 1.9524e-05 0.0401064 #_orig_obs: 1.94e-05 Fleet_2
2019 7 2 3.21719e-05 0.0401051 #_orig_obs: 3.24e-05 Fleet_2
2020 7 2 3.79403e-05 0.0401044 #_orig_obs: 3.94e-05 Fleet_2
2021 7 2 2.31202e-05 0.040106 #_orig_obs: 2.32e-05 Fleet_2
2022 7 2 2.03707e-05 0.0401062 #_orig_obs: 2.06e-05 Fleet_2
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
 1988 6 1 1 0 62.3694  0.0614953 1.37889 19.1761 25.5388 10.8746 3.76382 0.921574 0.199924 0.0787304 0.0647568 0.0629258 0.0623161 0.061967 0.0617465 0.0618265 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
 1997 6 1 1 0 1.80543  0.00177953 0.020254 0.312696 0.693809 0.450565 0.227542 0.0692086 0.0143635 0.00362199 0.002217 0.00200783 0.00191108 0.00184507 0.00180818 0.00180094 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
 2001 6 1 1 0 4.08137  0.0040262 0.09082 1.27567 1.97307 0.512616 0.10136 0.0535538 0.0280729 0.0114214 0.00664258 0.00565374 0.00510955 0.00467763 0.00436956 0.00430063 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
 2003 6 1 1 0 2.92151  0.00288307 0.0821352 0.942015 1.20789 0.498994 0.134679 0.0208892 0.00689761 0.00458383 0.00378667 0.00366354 0.00353056 0.00332334 0.00313388 0.00311403 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
 1988 6 1 2 0 8.91226  0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0.00878735 0.197036 2.74016 3.64936 1.55392 0.53783 0.131688 0.0285681 0.0112502 0.00925341 0.00899177 0.00890464 0.00885476 0.00882325 0.00883468
 1997 6 1 2 0 0.486919  0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0.000479935 0.00546245 0.0843332 0.187118 0.121516 0.0613675 0.0186654 0.00387379 0.00097684 0.000597919 0.000541505 0.000515414 0.00049761 0.00048766 0.000485707
 2001 6 1 2 0 0.760469  0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0.00075019 0.0169222 0.237692 0.367637 0.0955142 0.0188861 0.00997851 0.00523075 0.00212812 0.00123769 0.00105344 0.000952047 0.000871569 0.000814168 0.000801324
 2003 6 1 2 0 0.497861  0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0.00049131 0.0139968 0.160531 0.205838 0.0850345 0.0229509 0.00355978 0.00117543 0.00078114 0.000645293 0.000624311 0.000601651 0.000566336 0.00053405 0.000530668
 1988 6 2 1 0 3.2148  0.00317117 0.00316965 0.21714 2.10338 0.696521 0.14066 0.0221935 0.00544435 0.00363377 0.00337347 0.00328313 0.00323669 0.00320883 0.00319119 0.00319759 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
 1990 6 2 1 0 0.17625  0.000173799 0.000173706 0.0062741 0.10462 0.0515025 0.0106656 0.00128203 0.000291728 0.000199093 0.000185376 0.00017987 0.000176962 0.000175434 0.000174612 0.000174819 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
 2008 6 2 1 0 0.2397  0.000236682 0.000236418 0.0214797 0.178921 0.0339244 0.00254183 0.000368642 0.000248748 0.00024074 0.000241922 0.000245837 0.00025033 0.000252274 0.000250335 0.000261 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
 2022 10 2 1 0 0.780294  0.0007706 0.000769467 0.0581091 0.553954 0.132974 0.0232862 0.003969 0.00103347 0.000796142 0.000774318 0.000770765 0.000770105 0.000770042 0.000770238 0.000776054 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
 1988 6 2 2 0 0.459378  0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0.000453143 0.000452926 0.0310282 0.300561 0.0995292 0.0200996 0.00317134 0.000777969 0.000519247 0.000482051 0.000469142 0.000462506 0.000458525 0.000456004 0.000456919
 1990 6 2 2 0 0.065988  0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 6.50702e-05 6.50355e-05 0.00234902 0.0391699 0.0192825 0.00399321 0.000479991 0.000109223 7.45406e-05 6.94049e-05 6.73434e-05 6.62545e-05 6.56826e-05 6.53746e-05 6.54524e-05
 2008 6 2 2 0 0.0423  0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 4.17674e-05 4.17208e-05 0.00379054 0.0315743 0.00598666 0.000448559 6.50545e-05 4.38967e-05 4.24835e-05 4.26921e-05 4.33829e-05 4.41759e-05 4.45189e-05 4.41768e-05 4.60588e-05
 2022 10 2 2 0 0.170892  0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0.000168769 0.000168521 0.0127264 0.121321 0.0291226 0.0050999 0.000869249 0.00022634 0.000174363 0.000169583 0.000168805 0.00016866 0.000168647 0.00016869 0.000169963
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

