#V3.30.22.1;_safe;_compile_date:_Jan 30 2024;_Stock_Synthesis_by_Richard_Methot_(NOAA)_using_ADMB_13.1
#_Stock_Synthesis_is_a_work_of_the_U.S._Government_and_is_not_subject_to_copyright_protection_in_the_United_States.
#_Foreign_copyrights_may_apply._See_copyright.txt_for_more_information.
#_User_support_available_at:NMFS.Stock.Synthesis@noaa.gov
#_User_info_available_at:https://vlab.noaa.gov/group/stock-synthesis
#_Source_code_at:_https://github.com/nmfs-ost/ss3-source-code

#_Start_time: Mon Oct  6 16:13:32 2025
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
-999 1 1 4640.95 0.01
1986 1 1 2456.74 0.01
1987 1 1 3844.65 0.01
1988 1 1 3807.22 0.01
1989 1 1 1895.73 0.01
1990 1 1 3458.53 0.01
1991 1 1 4574.94 0.01
1992 1 1 4319.7 0.01
1993 1 1 3682.21 0.01
1994 1 1 3855.2 0.01
1995 1 1 4133.66 0.01
1996 1 1 1520.37 0.01
1997 1 1 2806.17 0.01
1998 1 1 2651.19 0.01
1999 1 1 2862.87 0.01
2000 1 1 3773.88 0.01
2001 1 1 2316.79 0.01
2002 1 1 2791.51 0.01
2003 1 1 1137.04 0.01
2004 1 1 1667.83 0.01
2005 1 1 1571.03 0.01
2006 1 1 1576.93 0.01
2007 1 1 3546.24 0.01
2008 1 1 3717.93 0.01
2009 1 1 4666.79 0.01
2010 1 1 2920.48 0.01
2011 1 1 2308.1 0.01
2012 1 1 4053.53 0.01
2013 1 1 3248.62 0.01
2014 1 1 2604.5 0.01
2015 1 1 3804.18 0.01
2016 1 1 3891.54 0.01
2017 1 1 4053.01 0.01
2018 1 1 3050.76 0.01
2019 1 1 3512.55 0.01
2020 1 1 2999 0.01
2021 1 1 2821.4 0.01
2022 1 1 3655.92 0.01
2023 1 1 2909.75 0.01
-999 1 2 5497 0.01
1986 1 2 5510.14 0.01
1987 1 2 8857.16 0.01
1988 1 2 7846.55 0.01
1989 1 2 7753.94 0.01
1990 1 2 7578.72 0.01
1991 1 2 7796.79 0.01
1992 1 2 7098.74 0.01
1993 1 2 6007.52 0.01
1994 1 2 6515.94 0.01
1995 1 2 6823.24 0.01
1996 1 2 5524.54 0.01
1997 1 2 4804.03 0.01
1998 1 2 4594.58 0.01
1999 1 2 4949.86 0.01
2000 1 2 5694.66 0.01
2001 1 2 4842.57 0.01
2002 1 2 2.3474 0.01
2003 1 2 4656.48 0.01
2004 1 2 3825.39 0.01
2005 1 2 5458.4 0.01
2006 1 2 4560.79 0.01
2007 1 2 5255.19 0.01
2008 1 2 5395.07 0.01
2009 1 2 5329.14 0.01
2010 1 2 4793.32 0.01
2011 1 2 4017.96 0.01
2012 1 2 5197.77 0.01
2013 1 2 4360.65 0.01
2014 1 2 2885.91 0.01
2015 1 2 3455.92 0.01
2016 1 2 2151.99 0.01
2017 1 2 2254.56 0.01
2018 1 2 2094.9 0.01
2019 1 2 2134.81 0.01
2020 1 2 2015.3 0.01
2021 1 2 1874.82 0.01
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
1986 7 1 0.000165928 0.243426 #_orig_obs: 0.000224 Fleet_1
1987 7 1 0.00016594 0.243426 #_orig_obs: 0.000257 Fleet_1
1988 7 1 0.000147856 0.243426 #_orig_obs: 0.000247 Fleet_1
1989 7 1 0.000131699 0.243426 #_orig_obs: 0.000248 Fleet_1
1990 7 1 0.000132022 0.243426 #_orig_obs: 0.000179 Fleet_1
1991 7 1 0.000135069 0.243426 #_orig_obs: 0.000195 Fleet_1
1992 7 1 0.000128634 0.243426 #_orig_obs: 0.000136 Fleet_1
1993 7 1 0.000123284 0.243426 #_orig_obs: 0.000169 Fleet_1
1994 7 1 0.00011846 0.243426 #_orig_obs: 0.000174 Fleet_1
1995 7 1 9.88977e-05 0.243426 #_orig_obs: 0.000198 Fleet_1
1996 7 1 8.76004e-05 0.243426 #_orig_obs: 0.000151 Fleet_1
1997 7 1 8.07998e-05 0.243426 #_orig_obs: 0.000131 Fleet_1
1998 7 1 9.70879e-05 0.243426 #_orig_obs: 0.000116 Fleet_1
1999 7 1 0.000168621 0.243426 #_orig_obs: 0.000128 Fleet_1
2000 7 1 0.000153422 0.152765 #_orig_obs: 0.000157071 Fleet_1
2001 7 1 0.000113677 0.152765 #_orig_obs: 0.000126056 Fleet_1
2002 7 1 0.000114702 0.152765 #_orig_obs: 0.000143716 Fleet_1
2003 7 1 0.000128911 0.152765 #_orig_obs: 9.7e-05 Fleet_1
2004 7 1 0.000141938 0.152765 #_orig_obs: 0.000115653 Fleet_1
2005 7 1 0.000135783 0.152765 #_orig_obs: 0.000110721 Fleet_1
2006 7 1 0.000149884 0.152765 #_orig_obs: 0.000123072 Fleet_1
2007 7 1 0.000179834 0.152765 #_orig_obs: 0.000143974 Fleet_1
2008 7 1 0.000185884 0.152765 #_orig_obs: 0.00013286 Fleet_1
2009 7 1 0.000163108 0.152765 #_orig_obs: 0.000147786 Fleet_1
2010 7 1 0.000150615 0.152765 #_orig_obs: 0.000118078 Fleet_1
2011 7 1 0.000169471 0.152765 #_orig_obs: 0.000111093 Fleet_1
2012 7 1 0.000149876 0.152765 #_orig_obs: 0.000147501 Fleet_1
2013 7 1 0.000122808 0.152765 #_orig_obs: 0.000128946 Fleet_1
2014 7 1 0.000125437 0.152765 #_orig_obs: 0.00011487 Fleet_1
2015 7 1 0.000114587 0.152765 #_orig_obs: 0.000135493 Fleet_1
2016 7 1 0.000101546 0.152765 #_orig_obs: 0.00013237 Fleet_1
2017 7 1 0.000120887 0.152765 #_orig_obs: 0.000130696 Fleet_1
2018 7 1 0.000162159 0.152765 #_orig_obs: 0.000103782 Fleet_1
2019 7 1 0.000145591 0.152765 #_orig_obs: 0.000127599 Fleet_1
2020 7 1 0.000104693 0.152765 #_orig_obs: 0.000127537 Fleet_1
2021 7 1 9.22553e-05 0.152765 #_orig_obs: 8.67e-05 Fleet_1
2022 7 1 9.47395e-05 0.152765 #_orig_obs: 8.61e-05 Fleet_1
1986 7 2 2.14228e-05 0.0401061 #_orig_obs: 2.17e-05 Fleet_2
1987 7 2 2.13715e-05 0.0401063 #_orig_obs: 1.97e-05 Fleet_2
1988 7 2 1.82979e-05 0.0401062 #_orig_obs: 2.07e-05 Fleet_2
1989 7 2 1.626e-05 0.0401068 #_orig_obs: 1.5e-05 Fleet_2
1990 7 2 1.28675e-05 0.040107 #_orig_obs: 1.3e-05 Fleet_2
1991 7 2 1.04136e-05 0.0401073 #_orig_obs: 1e-05 Fleet_2
1992 7 2 1.07049e-05 0.0401072 #_orig_obs: 1.07e-05 Fleet_2
1993 7 2 1.13139e-05 0.0401072 #_orig_obs: 1.13e-05 Fleet_2
1994 7 2 1.07193e-05 0.0401072 #_orig_obs: 1.07e-05 Fleet_2
1995 7 2 8.62537e-06 0.0401075 #_orig_obs: 8.33e-06 Fleet_2
1996 7 2 7.43778e-06 0.0401076 #_orig_obs: 7.33e-06 Fleet_2
1997 7 2 7.15227e-06 0.0401076 #_orig_obs: 7e-06 Fleet_2
1998 7 2 6.70955e-06 0.0401076 #_orig_obs: 7e-06 Fleet_2
1999 7 2 7.28529e-06 0.0401076 #_orig_obs: 6.67e-06 Fleet_2
2000 7 2 2.34495e-05 0.0401056 #_orig_obs: 2.7e-05 Fleet_2
2001 7 2 2.45361e-05 0.040106 #_orig_obs: 2.28e-05 Fleet_2
2002 7 2 2.39341e-05 0.0401059 #_orig_obs: 2.45e-05 Fleet_2
2003 7 2 2.43604e-05 0.0401059 #_orig_obs: 2.39e-05 Fleet_2
2004 7 2 2.5146e-05 0.0401058 #_orig_obs: 2.49e-05 Fleet_2
2005 7 2 2.76884e-05 0.0401054 #_orig_obs: 2.87e-05 Fleet_2
2006 7 2 2.59929e-05 0.0401057 #_orig_obs: 2.58e-05 Fleet_2
2007 7 2 2.60083e-05 0.0401057 #_orig_obs: 2.61e-05 Fleet_2
2008 7 2 3.01964e-05 0.0401052 #_orig_obs: 3.07e-05 Fleet_2
2009 7 2 3.18918e-05 0.0401051 #_orig_obs: 3.18e-05 Fleet_2
2010 7 2 2.88794e-05 0.0401053 #_orig_obs: 2.97e-05 Fleet_2
2011 7 2 2.78319e-05 0.0401056 #_orig_obs: 2.73e-05 Fleet_2
2012 7 2 3.14652e-05 0.040105 #_orig_obs: 3.26e-05 Fleet_2
2013 7 2 2.71423e-05 0.0401055 #_orig_obs: 2.77e-05 Fleet_2
2014 7 2 2.26189e-05 0.0401061 #_orig_obs: 2.18e-05 Fleet_2
2015 7 2 2.2927e-05 0.0401059 #_orig_obs: 2.4e-05 Fleet_2
2016 7 2 2.02138e-05 0.0401063 #_orig_obs: 1.96e-05 Fleet_2
2017 7 2 1.76926e-05 0.0401065 #_orig_obs: 1.78e-05 Fleet_2
2018 7 2 1.99088e-05 0.0401064 #_orig_obs: 1.94e-05 Fleet_2
2019 7 2 3.23022e-05 0.0401051 #_orig_obs: 3.24e-05 Fleet_2
2020 7 2 3.47579e-05 0.0401044 #_orig_obs: 3.94e-05 Fleet_2
2021 7 2 2.58611e-05 0.040106 #_orig_obs: 2.32e-05 Fleet_2
2022 7 2 2.00655e-05 0.0401062 #_orig_obs: 2.06e-05 Fleet_2
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
 1988 6 1 1 0 62.3694  0.0614851 1.12082 20.4447 24.6718 12.1447 3.00226 0.40333 0.0864646 0.0637165 0.06207 0.0617798 0.06165 0.0615697 0.0615176 0.0615343 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
 1997 6 1 1 0 1.80543  0.00178144 0.0510685 0.500336 0.846701 0.326527 0.058395 0.00622028 0.0019391 0.00178316 0.00177924 0.00177918 0.00177939 0.00177958 0.00177963 0.00178118 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
 2001 6 1 1 0 4.08137  0.00402357 0.0733262 1.22124 1.38594 0.874941 0.417099 0.0697561 0.00682105 0.00407992 0.00402416 0.00402148 0.00402125 0.00402132 0.00402146 0.00402322 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
 2003 6 1 1 0 2.92151  0.00287954 0.0553518 1.03181 1.02811 0.53448 0.192874 0.0459028 0.00917574 0.00356562 0.00296896 0.0028883 0.00287916 0.00287849 0.00287848 0.00287915 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
 1988 6 1 2 0 8.91226  0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0.0087859 0.160159 2.92144 3.52547 1.73542 0.429007 0.0576337 0.0123553 0.00910475 0.00886947 0.008828 0.00880947 0.00879799 0.00879054 0.00879293
 1997 6 1 2 0 0.486919  0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0.000480449 0.013773 0.134939 0.228353 0.0880634 0.015749 0.00167759 0.000522969 0.000480912 0.000479855 0.00047984 0.000479896 0.000479946 0.00047996 0.000480378
 2001 6 1 2 0 0.760469  0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0.0007497 0.0136627 0.227551 0.258239 0.163025 0.0777169 0.0129975 0.00127095 0.000760199 0.000749809 0.000749311 0.000749267 0.000749281 0.000749307 0.000749634
 2003 6 1 2 0 0.497861  0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0.000490709 0.00943262 0.175832 0.175201 0.0910817 0.0328681 0.00782239 0.00156366 0.000607625 0.000505946 0.000492202 0.000490643 0.000490528 0.000490528 0.000490642
 1988 6 2 1 0 3.2148  0.00317837 0.00317062 0.00317044 0.00316994 1.34614 1.44136 0.338856 0.0482184 0.00775384 0.00367896 0.0032868 0.00322868 0.00320384 0.00318823 0.00319322 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
 1990 6 2 1 0 0.17625  0.00017451 0.000174013 0.000173944 0.000173822 0.0772855 0.077469 0.0173016 0.00208666 0.000333992 0.000193351 0.000179513 0.000177286 0.000176073 0.000175126 0.000175567 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
 2008 6 2 1 0 0.2397  0.000236611 0.000236315 0.000236321 0.0002363 0.0873241 0.109755 0.0319916 0.00677633 0.00128068 0.00038331 0.000272981 0.000252775 0.000242719 0.000237959 0.000236583 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
 2022 10 2 1 0 0.780294  0.000770785 0.000769465 0.000769328 0.000769145 0.206081 0.295611 0.180345 0.0742686 0.0141102 0.00228202 0.0010848 0.000925848 0.000861706 0.00082072 0.00082466 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
 1988 6 2 2 0 0.459378  0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0.000454173 0.000453065 0.000453039 0.000452967 0.192356 0.205963 0.0484208 0.00689015 0.00110798 0.000525705 0.000469666 0.000461361 0.000457812 0.000455581 0.000456295
 1990 6 2 2 0 0.065988  0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 6.53367e-05 6.51503e-05 6.51246e-05 6.50788e-05 0.0289357 0.0290044 0.00647773 0.000781246 0.000125046 7.23906e-05 6.72097e-05 6.63759e-05 6.59218e-05 6.5567e-05 6.57323e-05
 2008 6 2 2 0 0.0423  0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 4.17549e-05 4.17027e-05 4.17036e-05 4.17e-05 0.0154101 0.0193686 0.00564558 0.00119582 0.000226002 6.7643e-05 4.81731e-05 4.46074e-05 4.28328e-05 4.19928e-05 4.17499e-05
 2022 10 2 2 0 0.170892  0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0.000168809 0.00016852 0.00016849 0.00016845 0.0451338 0.0647416 0.0394973 0.0162655 0.00309026 0.000499785 0.000237582 0.00020277 0.000188722 0.000179746 0.000180609
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

