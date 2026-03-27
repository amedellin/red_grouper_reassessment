#V3.30.22.1;_safe;_compile_date:_Jan 30 2024;_Stock_Synthesis_by_Richard_Methot_(NOAA)_using_ADMB_13.1
#_Stock_Synthesis_is_a_work_of_the_U.S._Government_and_is_not_subject_to_copyright_protection_in_the_United_States.
#_Foreign_copyrights_may_apply._See_copyright.txt_for_more_information.
#_User_support_available_at:NMFS.Stock.Synthesis@noaa.gov
#_User_info_available_at:https://vlab.noaa.gov/group/stock-synthesis
#_Source_code_at:_https://github.com/nmfs-ost/ss3-source-code

#_Start_time: Mon Oct  6 15:29:38 2025
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
-999 1 1 10583.1 0.01
1986 1 1 2456.79 0.01
1987 1 1 3833.15 0.01
1988 1 1 3804.72 0.01
1989 1 1 1895.35 0.01
1990 1 1 3458.43 0.01
1991 1 1 4584.24 0.01
1992 1 1 4320.7 0.01
1993 1 1 3681.77 0.01
1994 1 1 3855.46 0.01
1995 1 1 4134.53 0.01
1996 1 1 1523.02 0.01
1997 1 1 2807.04 0.01
1998 1 1 2652.55 0.01
1999 1 1 2865.69 0.01
2000 1 1 3772.02 0.01
2001 1 1 2314.26 0.01
2002 1 1 2791.59 0.01
2003 1 1 1137.23 0.01
2004 1 1 1668.57 0.01
2005 1 1 1571.22 0.01
2006 1 1 1577.7 0.01
2007 1 1 3545.63 0.01
2008 1 1 3718.9 0.01
2009 1 1 4669.6 0.01
2010 1 1 2922.47 0.01
2011 1 1 2310.45 0.01
2012 1 1 4055.49 0.01
2013 1 1 3253.87 0.01
2014 1 1 2607.08 0.01
2015 1 1 3808.71 0.01
2016 1 1 3889.59 0.01
2017 1 1 4055.5 0.01
2018 1 1 3050.95 0.01
2019 1 1 3512.54 0.01
2020 1 1 2998.28 0.01
2021 1 1 2819.6 0.01
2022 1 1 3656.27 0.01
2023 1 1 2909.64 0.01
-999 1 2 0.0220408 0.01
1986 1 2 5509.3 0.01
1987 1 2 8833.92 0.01
1988 1 2 7834.95 0.01
1989 1 2 7749.08 0.01
1990 1 2 7577.53 0.01
1991 1 2 7754.1 0.01
1992 1 2 7102.94 0.01
1993 1 2 6004.97 0.01
1994 1 2 6516.75 0.01
1995 1 2 6836.07 0.01
1996 1 2 5505.85 0.01
1997 1 2 4807.63 0.01
1998 1 2 4600.99 0.01
1999 1 2 4956.36 0.01
2000 1 2 5691.36 0.01
2001 1 2 4836.17 0.01
2002 1 2 2.34747 0.01
2003 1 2 4657.31 0.01
2004 1 2 3827.42 0.01
2005 1 2 5459.09 0.01
2006 1 2 4563.49 0.01
2007 1 2 5253.67 0.01
2008 1 2 5396.69 0.01
2009 1 2 5332.9 0.01
2010 1 2 4797.12 0.01
2011 1 2 4023.18 0.01
2012 1 2 5200.65 0.01
2013 1 2 4368.93 0.01
2014 1 2 2889.44 0.01
2015 1 2 3460.75 0.01
2016 1 2 2150.69 0.01
2017 1 2 2256.21 0.01
2018 1 2 2095.05 0.01
2019 1 2 2134.8 0.01
2020 1 2 2014.78 0.01
2021 1 2 1873.41 0.01
2022 1 2 1530.42 0.01
2023 1 2 1340.51 0.01
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
2000 7 1 0.000138362 0.152765 #_orig_obs: 0.000157071 Fleet_1
2001 7 1 0.000104256 0.152765 #_orig_obs: 0.000126056 Fleet_1
2002 7 1 0.000111176 0.152765 #_orig_obs: 0.000143716 Fleet_1
2003 7 1 0.000109583 0.152765 #_orig_obs: 9.7e-05 Fleet_1
2004 7 1 0.000123549 0.152765 #_orig_obs: 0.000115653 Fleet_1
2005 7 1 0.000131094 0.152765 #_orig_obs: 0.000110721 Fleet_1
2006 7 1 0.00012331 0.152765 #_orig_obs: 0.000123072 Fleet_1
2007 7 1 0.000137576 0.152765 #_orig_obs: 0.000143974 Fleet_1
2008 7 1 0.000154229 0.152765 #_orig_obs: 0.00013286 Fleet_1
2009 7 1 0.00015461 0.152765 #_orig_obs: 0.000147786 Fleet_1
2010 7 1 0.000136222 0.152765 #_orig_obs: 0.000118078 Fleet_1
2011 7 1 0.000133048 0.152765 #_orig_obs: 0.000111093 Fleet_1
2012 7 1 0.000158933 0.152765 #_orig_obs: 0.000147501 Fleet_1
2013 7 1 0.00012114 0.152765 #_orig_obs: 0.000128946 Fleet_1
2014 7 1 0.000109944 0.152765 #_orig_obs: 0.00011487 Fleet_1
2015 7 1 0.000115025 0.152765 #_orig_obs: 0.000135493 Fleet_1
2016 7 1 9.56572e-05 0.152765 #_orig_obs: 0.00013237 Fleet_1
2017 7 1 9.21492e-05 0.152765 #_orig_obs: 0.000130696 Fleet_1
2018 7 1 0.000101722 0.152765 #_orig_obs: 0.000103782 Fleet_1
2019 7 1 0.000151953 0.152765 #_orig_obs: 0.000127599 Fleet_1
2020 7 1 0.00014596 0.152765 #_orig_obs: 0.000127537 Fleet_1
2021 7 1 0.000102465 0.152765 #_orig_obs: 8.67e-05 Fleet_1
2022 7 1 0.00010059 0.152765 #_orig_obs: 8.61e-05 Fleet_1
2000 7 2 2.73772e-05 0.0401056 #_orig_obs: 2.7e-05 Fleet_2
2001 7 2 2.28181e-05 0.040106 #_orig_obs: 2.28e-05 Fleet_2
2002 7 2 2.50548e-05 0.0401059 #_orig_obs: 2.45e-05 Fleet_2
2003 7 2 2.38611e-05 0.0401059 #_orig_obs: 2.39e-05 Fleet_2
2004 7 2 2.4835e-05 0.0401058 #_orig_obs: 2.49e-05 Fleet_2
2005 7 2 2.84412e-05 0.0401054 #_orig_obs: 2.87e-05 Fleet_2
2006 7 2 2.57243e-05 0.0401057 #_orig_obs: 2.58e-05 Fleet_2
2007 7 2 2.63081e-05 0.0401057 #_orig_obs: 2.61e-05 Fleet_2
2008 7 2 3.03393e-05 0.0401052 #_orig_obs: 3.07e-05 Fleet_2
2009 7 2 3.18659e-05 0.0401051 #_orig_obs: 3.18e-05 Fleet_2
2010 7 2 2.92991e-05 0.0401053 #_orig_obs: 2.97e-05 Fleet_2
2011 7 2 2.71663e-05 0.0401056 #_orig_obs: 2.73e-05 Fleet_2
2012 7 2 3.23624e-05 0.040105 #_orig_obs: 3.26e-05 Fleet_2
2013 7 2 2.76298e-05 0.0401055 #_orig_obs: 2.77e-05 Fleet_2
2014 7 2 2.20409e-05 0.0401061 #_orig_obs: 2.18e-05 Fleet_2
2015 7 2 2.39343e-05 0.0401059 #_orig_obs: 2.4e-05 Fleet_2
2016 7 2 2.00239e-05 0.0401063 #_orig_obs: 1.96e-05 Fleet_2
2017 7 2 1.80571e-05 0.0401065 #_orig_obs: 1.78e-05 Fleet_2
2018 7 2 1.95794e-05 0.0401064 #_orig_obs: 1.94e-05 Fleet_2
2019 7 2 3.20589e-05 0.0401051 #_orig_obs: 3.24e-05 Fleet_2
2020 7 2 3.84528e-05 0.0401044 #_orig_obs: 3.94e-05 Fleet_2
2021 7 2 2.32909e-05 0.040106 #_orig_obs: 2.32e-05 Fleet_2
2022 7 2 2.03374e-05 0.0401062 #_orig_obs: 2.06e-05 Fleet_2
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
 1988 6 1 1 0 62.3694  0.0615251 1.61169 18.0296 27.5102 12.1063 2.29395 0.25691 0.0688629 0.0616713 0.0614584 0.0614493 0.0614482 0.0614479 0.0614478 0.0614478 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
 1997 6 1 1 0 1.80543  0.00178053 0.0167559 0.198875 0.624101 0.561937 0.275713 0.0905255 0.0198514 0.00459001 0.00221597 0.00189954 0.00182797 0.00179462 0.00178225 0.00177934 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
 2001 6 1 1 0 4.08137  0.00402679 0.0557662 0.667289 1.85877 1.14752 0.277554 0.0314723 0.00796864 0.00560274 0.00456077 0.00429532 0.00422996 0.00416061 0.00409209 0.00405642 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
 2003 6 1 1 0 2.92151  0.00288281 0.0561125 0.580374 1.18108 0.762386 0.258542 0.0518546 0.00724943 0.00328459 0.00301248 0.00296994 0.00296943 0.0029559 0.00292886 0.00291507 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
 1988 6 1 2 0 8.91226  0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0.00879161 0.230301 2.57634 3.93106 1.72993 0.327793 0.036711 0.00984014 0.00881251 0.00878209 0.00878078 0.00878063 0.00878059 0.00878057 0.00878057
 1997 6 1 2 0 0.486919  0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0.000480203 0.00451901 0.0536361 0.168318 0.151553 0.0743589 0.0244145 0.00535387 0.00123791 0.000597641 0.0005123 0.000492997 0.000484003 0.000480667 0.000479883
 2001 6 1 2 0 0.760469  0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0.0007503 0.0103908 0.124334 0.34634 0.213814 0.0517158 0.00586413 0.00148477 0.00104394 0.000849795 0.000800335 0.000788156 0.000775235 0.000762468 0.000755822
 2003 6 1 2 0 0.497861  0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0.000491266 0.00956224 0.0989027 0.20127 0.12992 0.0440587 0.00883664 0.00123539 0.000559733 0.000513362 0.000506114 0.000506026 0.000503721 0.000499112 0.000496762
 1988 6 2 1 0 3.2148  0.0031788 0.00317552 0.00317443 1.10763 1.78549 0.267934 0.0184737 0.00356373 0.00317728 0.00316807 0.0031675 0.00316737 0.00316733 0.00316731 0.00316731 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
 1990 6 2 1 0 0.17625  0.000173826 0.000173713 0.000173715 0.0285832 0.111989 0.0311066 0.00257698 0.000255582 0.000175453 0.00017371 0.000173653 0.000173648 0.000173646 0.000173646 0.000173646 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
 2008 6 2 1 0 0.2397  0.000236834 0.000236505 0.000236482 0.0766182 0.137417 0.0214318 0.00156547 0.000287106 0.000239441 0.000237113 0.000237204 0.000237693 0.000238179 0.000238349 0.000242195 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
 2022 10 2 1 0 0.780294  0.000771595 0.000769786 0.000769684 0.235586 0.431261 0.0881025 0.0151698 0.00236731 0.000871134 0.000777244 0.000770267 0.000769234 0.000769043 0.000769018 0.000769862 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
 1988 6 2 2 0 0.459378  0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0.000454234 0.000453765 0.000453609 0.158275 0.255137 0.0382864 0.00263979 0.000509239 0.000454016 0.000452701 0.000452619 0.000452601 0.000452594 0.000452592 0.000452592
 1990 6 2 2 0 0.065988  0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 6.50803e-05 6.50381e-05 6.50391e-05 0.0107016 0.0419287 0.0116463 0.00096482 9.56897e-05 6.56896e-05 6.5037e-05 6.50157e-05 6.50137e-05 6.50131e-05 6.50129e-05 6.50129e-05
 2008 6 2 2 0 0.0423  0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 4.17943e-05 4.17362e-05 4.17321e-05 0.0135209 0.0242501 0.00378209 0.000276259 5.06657e-05 4.22542e-05 4.18434e-05 4.18596e-05 4.19459e-05 4.20316e-05 4.20617e-05 4.27402e-05
 2022 10 2 2 0 0.170892  0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0.000168987 0.000168591 0.000168568 0.0515957 0.0944504 0.0192953 0.00332234 0.000518463 0.000190787 0.000170224 0.000168696 0.00016847 0.000168428 0.000168423 0.000168607
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

