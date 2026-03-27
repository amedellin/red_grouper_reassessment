#V3.30.22.1;_safe;_compile_date:_Jan 30 2024;_Stock_Synthesis_by_Richard_Methot_(NOAA)_using_ADMB_13.1
#_Stock_Synthesis_is_a_work_of_the_U.S._Government_and_is_not_subject_to_copyright_protection_in_the_United_States.
#_Foreign_copyrights_may_apply._See_copyright.txt_for_more_information.
#_User_support_available_at:NMFS.Stock.Synthesis@noaa.gov
#_User_info_available_at:https://vlab.noaa.gov/group/stock-synthesis
#_Source_code_at:_https://github.com/nmfs-ost/ss3-source-code

#C file created using the SS_writectl function in the R package r4ss
#C file write time: 2020-03-30 14:33:05
#_data_and_control_files: datafile.dat // controlfile.ctl
0  # 0 means do not read wtatage.ss; 1 means read and use wtatage.ss and also read and use growth parameters
1  #_N_Growth_Patterns (Growth Patterns, Morphs, Bio Patterns, GP are terms used interchangeably in SS3)
1 #_N_platoons_Within_GrowthPattern 
#_Cond 1 #_Platoon_within/between_stdev_ratio (no read if N_platoons=1)
#_Cond sd_ratio_rd < 0: platoon_sd_ratio parameter required after movement params.
#_Cond  1 #vector_platoon_dist_(-1_in_first_val_gives_normal_approx)
#
4 # recr_dist_method for parameters:  2=main effects for GP, Area, Settle timing; 3=each Settle entity; 4=none (only when N_GP*Nsettle*pop==1)
1 # not yet implemented; Future usage: Spawner-Recruitment: 1=global; 2=by area
1 #  number of recruitment settlement assignments 
0 # unused option
#GPattern month  area  age (for each settlement assignment)
 1 1 1 0
#
#_Cond 0 # N_movement_definitions goes here if Nareas > 1
#_Cond 1.0 # first age that moves (real age at begin of season, not integer) also cond on do_migration>0
#_Cond 1 1 1 2 4 10 # example move definition for seas=1, morph=1, source=1 dest=2, age1=4, age2=10
#
0 #_Nblock_Patterns
#_Cond 0 #_blocks_per_pattern 
# begin and end years of blocks
#
# controls for all timevary parameters 
1 #_time-vary parm bound check (1=warn relative to base parm bounds; 3=no bound check); Also see env (3) and dev (5) options to constrain with base bounds
#
# AUTOGEN
 1 1 1 1 1 # autogen: 1st element for biology, 2nd for SR, 3rd for Q, 4th reserved, 5th for selex
# where: 0 = autogen time-varying parms of this category; 1 = read each time-varying parm line; 2 = read then autogen if parm min==-12345
#
#_Available timevary codes
#_Block types: 0: P_block=P_base*exp(TVP); 1: P_block=P_base+TVP; 2: P_block=TVP; 3: P_block=P_block(-1) + TVP
#_Block_trends: -1: trend bounded by base parm min-max and parms in transformed units (beware); -2: endtrend and infl_year direct values; -3: end and infl as fraction of base range
#_EnvLinks:  1: P(y)=P_base*exp(TVP*env(y));  2: P(y)=P_base+TVP*env(y);  3: P(y)=f(TVP,env_Zscore) w/ logit to stay in min-max;  4: P(y)=2.0/(1.0+exp(-TVP1*env(y) - TVP2))
#_DevLinks:  1: P(y)*=exp(dev(y)*dev_se;  2: P(y)+=dev(y)*dev_se;  3: random walk;  4: zero-reverting random walk with rho;  5: like 4 with logit transform to stay in base min-max
#_DevLinks(more):  21-25 keep last dev for rest of years
#
#_Prior_codes:  0=none; 6=normal; 1=symmetric beta; 2=CASAL's beta; 3=lognormal; 4=lognormal with biascorr; 5=gamma
#
# setup for M, growth, wt-len, maturity, fecundity, (hermaphro), recr_distr, cohort_grow, (movement), (age error), (catch_mult), sex ratio 
#_NATMORT
0 #_natM_type:_0=1Parm; 1=N_breakpoints;_2=Lorenzen;_3=agespecific;_4=agespec_withseasinterpolate;_5=BETA:_Maunder_link_to_maturity;_6=Lorenzen_range
  #_no additional input for selected M option; read 1P per morph
#
1 # GrowthModel: 1=vonBert with L1&L2; 2=Richards with L1&L2; 3=age_specific_K_incr; 4=age_specific_K_decr; 5=age_specific_K_each; 6=NA; 7=NA; 8=growth cessation
-0.099 #_Age(post-settlement) for L1 (aka Amin); first growth parameter is size at this age; linear growth below this
999 #_Age(post-settlement) for L2 (aka Amax); 999 to treat as Linf
0 #_exponential decay for growth above maxage (value should approx initial Z; -999 replicates 3.24; -998 to not allow growth above maxage)
0  #_placeholder for future growth feature
#
0 #_SD_add_to_LAA (set to 0.1 for SS2 V1.x compatibility)
0 #_CV_Growth_Pattern:  0 CV=f(LAA); 1 CV=F(A); 2 SD=F(LAA); 3 SD=F(A); 4 logSD=F(A)
#
1 #_maturity_option:  1=length logistic; 2=age logistic; 3=read age-maturity matrix by growth_pattern; 4=read age-fecundity; 5=disabled; 6=read length-maturity
0 #_First_Mature_Age
2 #_fecundity_at_length option:(1)eggs=Wt*(a+b*Wt);(2)eggs=a*L^b;(3)eggs=a*Wt^b; (4)eggs=a+b*L; (5)eggs=a+b*W
0 #_hermaphroditism option:  0=none; 1=female-to-male age-specific fxn; -1=male-to-female age-specific fxn
1 #_parameter_offset_approach for M, G, CV_G:  1- direct, no offset**; 2- male=fem_parm*exp(male_parm); 3: male=female*exp(parm) then old=young*exp(parm)
#_** in option 1, any male parameter with value = 0.0 and phase <0 is set equal to female parameter
#
#_growth_parms
#_ LO HI INIT PRIOR PR_SD PR_type PHASE env_var&link dev_link dev_minyr dev_maxyr dev_PH Block Block_Fxn
# Sex: 1  BioPattern: 1  NatMort
 0.001 2 0.225 -2.92 0.22 3 -1 0 0 0 0 0 0 0 # NatM_uniform_Fem_GP_1
# Sex: 1  BioPattern: 1  Growth
 -50 100 0 0 10 0 -3 0 0 0 0 0 0 0 # L_at_Amin_Fem_GP_1
 1 500 100.9 100.9 10 0 -2 0 0 0 0 0 0 0 # L_at_Amax_Fem_GP_1
 0.001 2 0.15 0.15 0.05 0 -3 0 0 0 0 0 0 0 # VonBert_K_Fem_GP_1
 0.001 5 0.1 0.1 0.5 0 -4 0 0 0 0 0 0 0 # CV_young_Fem_GP_1
 0.001 5 0.1 0.1 0.5 0 -4 0 0 0 0 0 0 0 # CV_old_Fem_GP_1
# Sex: 1  BioPattern: 1  WtLen
 0 3 1.23e-05 1.23e-05 99 0 -99 0 0 0 0 0 0 0 # Wtlen_1_Fem_GP_1
 2 4 3.035 3.035 99 0 -99 0 0 0 0 0 0 0 # Wtlen_2_Fem_GP_1
# Sex: 1  BioPattern: 1  Maturity&Fecundity
 0.0001 1000 50.9 50.9 99 0 -99 0 0 0 0 0 0 0 # Mat50%_Fem_GP_1
 -2 4 -0.323565 -0.323565 99 0 -99 0 0 0 0 0 0 0 # Mat_slope_Fem_GP_1
 0 3 1.23e-05 1.23e-05 0.8 0 -3 0 0 0 0 0 0 0 # Eggs_scalar_Fem_GP_1
 0 10 3.035 3.035 0.8 0 -3 0 0 0 0 0 0 0 # Eggs_exp_len_Fem_GP_1
# Sex: 2  BioPattern: 1  NatMort
 0.001 2 0.225 -2.92 0.22 3 -1 0 0 0 0 0 0 0 # NatM_uniform_Mal_GP_1
# Sex: 2  BioPattern: 1  Growth
 -50 100 0 0 10 0 -3 0 0 0 0 0 0 0 # L_at_Amin_Mal_GP_1
 1 500 100.9 100.9 10 0 -2 0 0 0 0 0 0 0 # L_at_Amax_Mal_GP_1
 0.001 2 0.15 0.15 0.05 0 -3 0 0 0 0 0 0 0 # VonBert_K_Mal_GP_1
 0.001 5 0.1 0.1 0.5 0 -4 0 0 0 0 0 0 0 # CV_young_Mal_GP_1
 0.001 5 0.1 0.1 0.5 0 -4 0 0 0 0 0 0 0 # CV_old_Mal_GP_1
# Sex: 2  BioPattern: 1  WtLen
 0 3 1.23e-05 1.23e-05 99 0 -99 0 0 0 0 0 0 0 # Wtlen_1_Mal_GP_1
 2 4 3.035 3.035 99 0 -99 0 0 0 0 0 0 0 # Wtlen_2_Mal_GP_1
# Hermaphroditism
#  Recruitment Distribution 
#  Cohort growth dev base
 0.1 10 1 1 1 0 -1 0 0 0 0 0 0 0 # CohortGrowDev
#  Movement
#  Platoon StDev Ratio 
#  Age Error from parameters
#  catch multiplier
#  fraction female, by GP
 0.01 0.99 0.5 0.5 0.5 0 -99 0 0 0 0 0 0 0 # FracFemale_GP_1
#  M2 parameter for each predator fleet
#
#_no timevary MG parameters
#
#_seasonal_effects_on_biology_parms
 0 0 0 0 0 0 0 0 0 0 #_femwtlen1,femwtlen2,mat1,mat2,fec1,fec2,Malewtlen1,malewtlen2,L1,K
#_ LO HI INIT PRIOR PR_SD PR_type PHASE
#_Cond -2 2 0 0 -1 99 -2 #_placeholder when no seasonal MG parameters
#
3 #_Spawner-Recruitment; Options: 1=NA; 2=Ricker; 3=std_B-H; 4=SCAA; 5=Hockey; 6=B-H_flattop; 7=survival_3Parm; 8=Shepherd_3Parm; 9=RickerPower_3parm
0  # 0/1 to use steepness in initial equ recruitment calculation
0  #  future feature:  0/1 to make realized sigmaR a function of SR curvature
#_          LO            HI          INIT         PRIOR         PR_SD       PR_type      PHASE    env-var    use_dev   dev_mnyr   dev_mxyr     dev_PH      Block    Blk_Fxn #  parm_name
        0.0001            20       10.1737             7            99             3          1          0          0          0          0          0          0          0 # SR_LN(R0)
           0.2             1          0.84          0.84          0.24             3         -1          0          0          0          0          0          0          0 # SR_BH_steep
             0             2           0.5           0.5            99             0         -6          0          0          0          0          0          0          0 # SR_sigmaR
            -5             5             0             0            99             0        -99          0          0          0          0          0          0          0 # SR_regime
             0             2             0             1            99             0        -99          0          0          0          0          0          0          0 # SR_autocorr
#_no timevary SR parameters
3 #do_recdev:  0=none; 1=devvector (R=F(SSB)+dev); 2=deviations (R=F(SSB)+dev); 3=deviations (R=R0*dev; dev2=R-f(SSB)); 4=like 3 with sum(dev2) adding penalty
1950 # first year of main recr_devs; early devs can precede this era
2023 # last year of main recr_devs; forecast devs start in following year
1 #_recdev phase 
1 # (0/1) to read 13 advanced options
 -1 #_recdev_early_start (0=none; neg value makes relative to recdev_start)
 3 #_recdev_early_phase
 0 #_forecast_recruitment phase (incl. late recr) (0 value resets to maxphase+1)
 1 #_lambda for Fcast_recr_like occurring before endyr+1
 1950 #_last_yr_nobias_adj_in_MPD; begin of ramp
 1950 #_first_yr_fullbias_adj_in_MPD; begin of plateau
 2023 #_last_yr_fullbias_adj_in_MPD
 2023 #_end_yr_for_ramp_in_MPD (can be in forecast to shape ramp, but SS3 sets bias_adj to 0.0 for fcast yrs)
 1 #_max_bias_adj_in_MPD (typical ~0.8; -3 sets all years to 0.0; -2 sets all non-forecast yrs w/ estimated recdevs to 1.0; -1 sets biasadj=1.0 for all yrs w/ recdevs)
 0 #_period of cycles in recruitment (N parms read below)
 -5 #min rec_dev
 5 #max rec_dev
 0 #_read_recdevs
#_end of advanced SR options
#
#_placeholder for full parameter lines for recruitment cycles
# read specified recr devs
#_Yr Input_value
#
# all recruitment deviations
#  1949E 1950R 1951R 1952R 1953R 1954R 1955R 1956R 1957R 1958R 1959R 1960R 1961R 1962R 1963R 1964R 1965R 1966R 1967R 1968R 1969R 1970R 1971R 1972R 1973R 1974R 1975R 1976R 1977R 1978R 1979R 1980R 1981R 1982R 1983R 1984R 1985R 1986R 1987R 1988R 1989R 1990R 1991R 1992R 1993R 1994R 1995R 1996R 1997R 1998R 1999R 2000R 2001R 2002R 2003R 2004R 2005R 2006R 2007R 2008R 2009R 2010R 2011R 2012R 2013R 2014R 2015R 2016R 2017R 2018R 2019R 2020R 2021R 2022R 2023R 2024F
#  -0.0462601 -0.0541974 -0.181298 -0.190514 -0.200792 -0.212203 -0.224772 -0.238347 -0.252678 -0.26822 -0.283003 -0.300756 -0.322104 -0.343718 -0.363503 -0.390829 -0.410764 -0.424981 -0.433751 -0.432957 -0.421407 -0.403571 -0.353019 -0.205156 0.296575 0.191369 -0.479273 -0.81927 -0.93392 -0.739732 -0.197778 0.198013 -0.906203 -0.105002 -0.228862 -0.262645 0.168192 -0.49464 -0.300783 -0.346724 0.0164475 -0.137181 -0.273117 -0.338986 -0.368631 -0.718954 -0.479115 -0.963986 0.689369 -1.06961 -0.139256 -0.679834 -0.348495 -0.14509 -0.648716 -0.266902 0.0832339 -0.0557348 -0.197437 -0.49836 0.0927146 -0.578288 -0.838602 -0.262889 -0.94148 -0.646952 -0.558735 0.281079 -0.296575 -1.64462 -0.735107 -0.568931 -0.263719 -0.256225 -0.258228 0
#
#Fishing Mortality info 
0.03 # F ballpark value in units of annual_F
-1999 # F ballpark year (neg value to disable)
3 # F_Method:  1=Pope midseason rate; 2=F as parameter; 3=F as hybrid; 4=fleet-specific parm/hybrid (#4 is superset of #2 and #3 and is recommended)
4 # max F (methods 2-4) or harvest fraction (method 1)
4  # N iterations for tuning in hybrid mode; recommend 3 (faster) to 5 (more precise if many fleets)
#
#_initial_F_parms; for each fleet x season that has init_catch; nest season in fleet; count = 4
#_for unconstrained init_F, use an arbitrary initial catch and set lambda=0 for its logL
#_ LO HI INIT PRIOR PR_SD  PR_type  PHASE
 0 10 1e-20 1 999 0 -1 # InitF_seas_1_flt_1Fleet_1
 0 10 1e-20 1 999 0 -1 # InitF_seas_1_flt_2Fleet_2
 0 10 1e-20 1 999 0 -1 # InitF_seas_1_flt_3Fleet_3
 0 10 1e-20 1 999 0 -1 # InitF_seas_1_flt_4Fleet_4
#
# F rates by fleet x season
# Yr:  1950 1951 1952 1953 1954 1955 1956 1957 1958 1959 1960 1961 1962 1963 1964 1965 1966 1967 1968 1969 1970 1971 1972 1973 1974 1975 1976 1977 1978 1979 1980 1981 1982 1983 1984 1985 1986 1987 1988 1989 1990 1991 1992 1993 1994 1995 1996 1997 1998 1999 2000 2001 2002 2003 2004 2005 2006 2007 2008 2009 2010 2011 2012 2013 2014 2015 2016 2017 2018 2019 2020 2021 2022 2023 2024
# seas:  1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1
# Fleet_1 0.00112472 0.00142056 0.00180606 0.00233217 0.00304797 0.00393435 0.00503648 0.00644389 0.00826588 0.0153617 0.0220859 0.0261346 0.0246329 0.0425353 0.0432574 0.0414614 0.0544153 0.0323631 0.0389326 0.0630808 0.0756471 0.219048 0.295891 0.273987 0.260885 0.143925 0.106899 0.108748 0.209051 0.147838 0.251223 0.367411 0.354592 0.105578 0.320427 0.185993 0.203859 0.291898 0.324364 0.194176 0.378747 0.498923 0.464595 0.414639 0.479013 0.612224 0.263043 0.468413 0.537573 0.225189 0.246329 0.189669 0.221629 0.0917103 0.116116 0.110517 0.114967 0.220138 0.21084 0.278548 0.198443 0.141634 0.247551 0.257387 0.208658 0.31762 0.374947 0.39287 0.202663 0.188088 0.207467 0.262076 0.336685 0.228203 0.145475
# Fleet_2 0.00758138 0.00951877 0.0120823 0.0154007 0.0201152 0.0263203 0.0340059 0.0436992 0.0562024 0.0708951 0.0979909 0.12515 0.13247 0.190587 0.217744 0.210072 0.266941 0.162265 0.215037 0.320678 0.410966 0.484511 0.866668 0.901546 1.1914 1.16853 0.570183 0.457277 0.620975 0.865682 1.12932 1.2248 0.930648 0.645811 0.615334 0.629685 0.53389 0.918192 0.745596 0.955174 1.05947 1.36978 1.17522 0.959689 1.1219 1.51113 1.39506 1.28872 1.24504 1.40971 0.402378 0.400109 0.000180249 0.370024 0.295078 0.368465 0.336868 0.382001 0.337059 0.32146 0.309779 0.281217 0.310082 0.301411 0.246557 0.278323 0.203484 0.234757 0.203438 0.123965 0.108689 0.142861 0.142883 0.120609 0.0768967
# Fleet_3 0.00194224 0.00259559 0.00347186 0.00465014 0.00624124 0.00840799 0.0113932 0.0155788 0.0215289 0.03005 0.0239313 0.0347618 0.0321354 0.0349038 0.0399205 0.04287 0.058217 0.0766561 0.105009 0.0837142 0.0858505 0.191461 0.193736 0.17593 0.211809 0.20313 0.38533 0.458983 0.546547 0.509075 0.354217 0.304478 0.334332 0.357031 0.448486 0.654968 0.642105 0.580438 0.603477 0.589003 0.627904 0.349158 0.246726 0.203979 0.132735 0.117413 0.121526 0.105566 0.0445581 0.0261443 0.0193348 0.0358217 0.0188255 0.0123355 0.00851097 0.00433219 0.00223857 0.00267754 0.00254281 0.00229222 0.00230936 0.00211495 0.00211163 0.00195742 0.00200532 0.00188583 0.00141709 0.00109309 0.00085268 0.000667481 0.000523491 0.000397897 0.000280111 0.000191708 0.000122792
# Fleet_4 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0.000246142 0.000317399 0.000431435 0.000588463 0.000810996 0.00113996 0.00168031 0.00270418 0.00465838 0.00820291 0.0126889 0.0153724 0.0161812 0.0835732 0.106376 0.0663129 0.477592 0.891456 0.778592 0.470377 0.303905 0.277621 0.195429 0.184683 0.138458 0.263331 0.24111 0.164211 0.107703 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
#
#_Q_setup for fleets with cpue or survey data
#_1:  fleet number
#_2:  link type: (1=simple q, 1 parm; 2=mirror simple q, 1 mirrored parm; 3=q and power, 2 parm; 4=mirror with offset, 2 parm)
#_3:  extra input for link, i.e. mirror fleet# or dev index number
#_4:  0/1 to select extra sd parameter
#_5:  0/1 for biasadj or not
#_6:  0/1 to float
#_   fleet      link link_info  extra_se   biasadj     float  #  fleetname
         1         1         0         0         0         1  #  Fleet_1
         2         1         0         0         0         1  #  Fleet_2
         3         1         0         0         0         1  #  Fleet_3
         4         1         0         0         0         1  #  Fleet_4
-9999 0 0 0 0 0
#
#_Q_parms(if_any);Qunits_are_ln(q)
#_          LO            HI          INIT         PRIOR         PR_SD       PR_type      PHASE    env-var    use_dev   dev_mnyr   dev_mxyr     dev_PH      Block    Blk_Fxn  #  parm_name
           -15            15      -18.5357             0             1             0         -1          0          0          0          0          0          0          0  #  LnQ_base_Fleet_1(1)
# REMOVED: # REMOVED:            -15            15      -20.0798             0             1             0         -1          0          0          0          0          0          0          0  #  LnQ_base_Fleet_2(2)
           -15            15      -7.44583             0             1             0         -1          0          0          0          0          0          0          0  #  LnQ_base_Fleet_3(3)
           -15            15      -7.43156             0             1             0         -1          0          0          0          0          0          0          0  #  LnQ_base_Fleet_4(4)
#_no timevary Q parameters
#
#_size_selex_patterns
#Pattern:_0;  parm=0; selex=1.0 for all sizes
#Pattern:_1;  parm=2; logistic; with 95% width specification
#Pattern:_5;  parm=2; mirror another size selex; PARMS pick the min-max bin to mirror
#Pattern:_11; parm=2; selex=1.0  for specified min-max population length bin range
#Pattern:_15; parm=0; mirror another age or length selex
#Pattern:_6;  parm=2+special; non-parm len selex
#Pattern:_43; parm=2+special+2;  like 6, with 2 additional param for scaling (mean over bin range)
#Pattern:_8;  parm=8; double_logistic with smooth transitions and constant above Linf option
#Pattern:_9;  parm=6; simple 4-parm double logistic with starting length; parm 5 is first length; parm 6=1 does desc as offset
#Pattern:_21; parm=2+special; non-parm len selex, read as pairs of size, then selex
#Pattern:_22; parm=4; double_normal as in CASAL
#Pattern:_23; parm=6; double_normal where final value is directly equal to sp(6) so can be >1.0
#Pattern:_24; parm=6; double_normal with sel(minL) and sel(maxL), using joiners
#Pattern:_2;  parm=6; double_normal with sel(minL) and sel(maxL), using joiners, back compatibile version of 24 with 3.30.18 and older
#Pattern:_25; parm=3; exponential-logistic in length
#Pattern:_27; parm=special+3; cubic spline in length; parm1==1 resets knots; parm1==2 resets all 
#Pattern:_42; parm=special+3+2; cubic spline; like 27, with 2 additional param for scaling (mean over bin range)
#_discard_options:_0=none;_1=define_retention;_2=retention&mortality;_3=all_discarded_dead;_4=define_dome-shaped_retention
#_Pattern Discard Male Special
 24 0 0 0 # 1 Fleet_1
 24 0 0 0 # 2 Fleet_2
 24 0 0 0 # 3 Fleet_3
 24 0 0 0 # 4 Fleet_4
#
#_age_selex_patterns
#Pattern:_0; parm=0; selex=1.0 for ages 0 to maxage
#Pattern:_10; parm=0; selex=1.0 for ages 1 to maxage
#Pattern:_11; parm=2; selex=1.0  for specified min-max age
#Pattern:_12; parm=2; age logistic
#Pattern:_13; parm=8; age double logistic. Recommend using pattern 18 instead.
#Pattern:_14; parm=nages+1; age empirical
#Pattern:_15; parm=0; mirror another age or length selex
#Pattern:_16; parm=2; Coleraine - Gaussian
#Pattern:_17; parm=nages+1; empirical as random walk  N parameters to read can be overridden by setting special to non-zero
#Pattern:_41; parm=2+nages+1; // like 17, with 2 additional param for scaling (mean over bin range)
#Pattern:_18; parm=8; double logistic - smooth transition
#Pattern:_19; parm=6; simple 4-parm double logistic with starting age
#Pattern:_20; parm=6; double_normal,using joiners
#Pattern:_26; parm=3; exponential-logistic in age
#Pattern:_27; parm=3+special; cubic spline in age; parm1==1 resets knots; parm1==2 resets all 
#Pattern:_42; parm=2+special+3; // cubic spline; with 2 additional param for scaling (mean over bin range)
#Age patterns entered with value >100 create Min_selage from first digit and pattern from remainder
#_Pattern Discard Male Special
 10 0 0 0 # 1 Fleet_1
 10 0 0 0 # 2 Fleet_2
 10 0 0 0 # 3 Fleet_3
 10 0 0 0 # 4 Fleet_4
#
#_          LO            HI          INIT         PRIOR         PR_SD       PR_type      PHASE    env-var    use_dev   dev_mnyr   dev_mxyr     dev_PH      Block    Blk_Fxn  #  parm_name
# 1   Fleet_1 LenSelex
            20            90       34.2925            35            99             0          3          0          0          0          0          0          0          0  #  Size_DblN_peak_Fleet_1(1)
           -15            15      -24.6353      -24.6353            99             0         -3          0          0          0          0          0          0          0  #  Size_DblN_top_logit_Fleet_1(1)
            -4            12       2.77379       3.58539            99             0          3          0          0          0          0          0          0          0  #  Size_DblN_ascend_se_Fleet_1(1)
           -15             6       4.60517       4.60517            99             0         -3          0          0          0          0          0          0          0  #  Size_DblN_descend_se_Fleet_1(1)
          -999            15           -15           -10            99             0         -2          0          0          0          0          0          0          0  #  Size_DblN_start_logit_Fleet_1(1)
           -15            20      -2.94444      -2.94444            99             0         -3          0          0          0          0          0          0          0  #  Size_DblN_end_logit_Fleet_1(1)
# 2   Fleet_2 LenSelex
            20            80       39.6122            45            99             0          3          0          0          0          0          0          0          0  #  Size_DblN_peak_Fleet_2(2)
           -15            15      -24.4121      -24.4121            99             0         -3          0          0          0          0          0          0          0  #  Size_DblN_top_logit_Fleet_2(2)
            -4            12      0.766475       4.97168            99             0          3          0          0          0          0          0          0          0  #  Size_DblN_ascend_se_Fleet_2(2)
           -15             6       4.60517       4.60517            99             0         -3          0          0          0          0          0          0          0  #  Size_DblN_descend_se_Fleet_2(2)
          -999            15           -15           -10            99             0         -2          0          0          0          0          0          0          0  #  Size_DblN_start_logit_Fleet_2(2)
           -15            20      -2.94444      -2.94444            99             0         -3          0          0          0          0          0          0          0  #  Size_DblN_end_logit_Fleet_2(2)
# 3   Fleet_3 LenSelex
            20            75       74.9964            50            99             0          3          0          0          0          0          0          0          0  #  Size_DblN_peak_Fleet_3(3)
           -15            15     -0.847298     -0.847298            99             0         -3          0          0          0          0          0          0          0  #  Size_DblN_top_logit_Fleet_3(3)
            -4            12       3.82423       4.97168            99             0          3          0          0          0          0          0          0          0  #  Size_DblN_ascend_se_Fleet_3(3)
           -15             6       4.60517       4.60517            99             0         -3          0          0          0          0          0          0          0  #  Size_DblN_descend_se_Fleet_3(3)
          -999            15           -15           -10            99             0         -2          0          0          0          0          0          0          0  #  Size_DblN_start_logit_Fleet_3(3)
           -15            20      -2.94444      -2.94444            99             0         -3          0          0          0          0          0          0          0  #  Size_DblN_end_logit_Fleet_3(3)
# 4   Fleet_4 LenSelex
            20            90       87.3965            35            99             0          3          0          0          0          0          0          0          0  #  Size_DblN_peak_Fleet_4(4)
           -15            15   1.99999e-11   1.99999e-11            99             0         -3          0          0          0          0          0          0          0  #  Size_DblN_top_logit_Fleet_4(4)
            -4            12      -3.99677       4.97168            99             0          3          0          0          0          0          0          0          0  #  Size_DblN_ascend_se_Fleet_4(4)
           -15             6       4.60517       4.60517            99             0         -3          0          0          0          0          0          0          0  #  Size_DblN_descend_se_Fleet_4(4)
          -999            15           -15           -10            99             0         -2          0          0          0          0          0          0          0  #  Size_DblN_start_logit_Fleet_4(4)
           -15            20       6.90676       6.90676            99             0         -3          0          0          0          0          0          0          0  #  Size_DblN_end_logit_Fleet_4(4)
# 1   Fleet_1 AgeSelex
# 2   Fleet_2 AgeSelex
# 3   Fleet_3 AgeSelex
# 4   Fleet_4 AgeSelex
#_No_Dirichlet parameters
#_no timevary selex parameters
#
0   #  use 2D_AR1 selectivity? (0/1)
#_no 2D_AR1 selex offset used
#_specs:  fleet, ymin, ymax, amin, amax, sigma_amax, use_rho, len1/age2, devphase, before_range, after_range
#_sigma_amax>amin means create sigma parm for each bin from min to sigma_amax; sigma_amax<0 means just one sigma parm is read and used for all bins
#_needed parameters follow each fleet's specifications
# -9999  0 0 0 0 0 0 0 0 0 0 # terminator
#
# Tag loss and Tag reporting parameters go next
0  # TG_custom:  0=no read and autogen if tag data exist; 1=read
#_Cond -6 6 1 1 2 0.01 -4 0 0 0 0 0 0 0  #_placeholder if no parameters
#
# no timevary parameters
#
#
# Input variance adjustments factors: 
 #_1=add_to_survey_CV
 #_2=add_to_discard_stddev
 #_3=add_to_bodywt_CV
 #_4=mult_by_lencomp_N
 #_5=mult_by_agecomp_N
 #_6=mult_by_size-at-age_N
 #_7=mult_by_generalized_sizecomp
#_Factor  Fleet  Value
      4      1  0.001577
      4      2  0.000334
      4      3  0.000374
 -9999   1    0  # terminator
#
15 #_maxlambdaphase
-1 #_sd_offset; must be 1 if any growthCV, sigmaR, or survey extraSD is an estimated parameter
# read 8 changes to default Lambdas (default value is 1.0)
# Like_comp codes:  1=surv; 2=disc; 3=mnwt; 4=length; 5=age; 6=SizeFreq; 7=sizeage; 8=catch; 9=init_equ_catch; 
# 10=recrdev; 11=parm_prior; 12=parm_dev; 13=CrashPen; 14=Morphcomp; 15=Tag-comp; 16=Tag-negbin; 17=F_ballpark; 18=initEQregime
#like_comp fleet  phase  value  sizefreq_method
 8 1 1 1 1
 8 2 1 1 1
 8 3 1 1 1
 8 4 1 1 1
 9 1 1 0 1
 9 2 1 0 1
 9 3 1 0 1
 9 4 1 0 1
-9999  1  1  1  1  #  terminator
#
# lambdas (for info only; columns are phases)
#  1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 #_CPUE/survey:_1
#  1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 #_CPUE/survey:_2
#  1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 #_CPUE/survey:_3
#  1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 #_CPUE/survey:_4
#  1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 #_lencomp:_1
#  1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 #_lencomp:_2
#  1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 #_lencomp:_3
#  0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 #_lencomp:_4
#  0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 #_init_equ_catch1
#  0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 #_init_equ_catch2
#  0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 #_init_equ_catch3
#  0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 #_init_equ_catch4
#  1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 #_recruitments
#  1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 #_parameter-priors
#  1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 #_parameter-dev-vectors
#  1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 #_crashPenLambda
#  0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 # F_ballpark_lambda
0 # (0/1/2) read specs for more stddev reporting: 0 = skip, 1 = read specs for reporting stdev for selectivity, size, and numbers, 2 = add options for M,Dyn. Bzero, SmryBio
 # 0 2 0 0 # Selectivity: (1) fleet, (2) 1=len/2=age/3=both, (3) year, (4) N selex bins
 # 0 0 # Growth: (1) growth pattern, (2) growth ages
 # 0 0 0 # Numbers-at-age: (1) area(-1 for all), (2) year, (3) N ages
 # -1 # list of bin #'s for selex std (-1 in first bin to self-generate)
 # -1 # list of ages for growth std (-1 in first bin to self-generate)
 # -1 # list of ages for NatAge std (-1 in first bin to self-generate)
999

