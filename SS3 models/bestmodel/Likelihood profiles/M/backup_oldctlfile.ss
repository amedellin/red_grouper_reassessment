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
        0.0001            20       10.2058             7            99             0          1          0          0          0          0          0          0          0 # SR_LN(R0)
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
#  -0.0404922 -0.0473667 -0.174125 -0.182294 -0.191374 -0.201386 -0.212382 -0.224334 -0.237175 -0.250983 -0.264352 -0.279641 -0.298157 -0.318389 -0.337849 -0.363125 -0.380142 -0.394803 -0.406748 -0.41289 -0.412334 -0.417424 -0.418729 -0.405839 -0.318134 -0.0163461 0.284692 -0.450279 -0.884625 -1.02431 -0.989256 0.3424 -0.890248 -0.107092 -0.303425 -0.254674 0.179529 -0.454454 -0.311424 -0.330201 0.00260512 -0.144526 -0.284185 -0.340674 -0.378103 -0.736974 -0.494214 -0.961812 0.601471 -0.79267 -0.23171 -0.634172 -0.421154 -0.185446 -0.647424 -0.334322 0.0284092 -0.083082 -0.215853 -0.535018 0.01833 -0.535216 -0.894596 -0.332543 -0.93735 -0.714165 -0.610265 0.167729 -0.204664 -1.68754 -0.806317 -0.629943 -0.278304 -0.27044 -0.271829 0
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
# Fleet_1 0.00120397 0.00151961 0.00192792 0.002487 0.00324368 0.00417188 0.00532921 0.00680949 0.00872511 0.0161966 0.0232486 0.0274525 0.0258238 0.0444718 0.0450609 0.0430866 0.0564344 0.0335296 0.0403738 0.0653227 0.0781247 0.225791 0.303893 0.285971 0.295549 0.222737 0.183485 0.126162 0.171146 0.120876 0.252612 0.611751 0.458883 0.123105 0.366146 0.217056 0.239796 0.328245 0.364402 0.218053 0.423589 0.551803 0.517355 0.464593 0.537292 0.687239 0.299243 0.527471 0.619275 0.255171 0.286451 0.219426 0.256523 0.106156 0.133908 0.127888 0.132748 0.253642 0.243393 0.320908 0.229415 0.163092 0.2857 0.297498 0.239615 0.366896 0.432304 0.452498 0.235743 0.216727 0.239014 0.303671 0.386286 0.256697 0.152077
# Fleet_2 0.00819622 0.0102889 0.0130471 0.0165927 0.0216692 0.0282649 0.0363981 0.0466739 0.0599357 0.0754953 0.104152 0.13268 0.140066 0.20088 0.228469 0.219514 0.278106 0.168785 0.223816 0.333091 0.424593 0.49733 0.878441 0.906001 1.2387 1.45769 1.11101 0.827212 0.62026 0.667099 0.896662 1.36748 1.92102 0.79572 0.751467 0.736403 0.649116 1.10564 0.850932 1.10179 1.21773 1.56642 1.32773 1.08712 1.28451 1.74376 1.62144 1.50403 1.45277 1.64932 0.467084 0.470114 0.000210376 0.432318 0.34494 0.429349 0.393836 0.446112 0.393414 0.375703 0.36134 0.328834 0.361623 0.351914 0.28864 0.32375 0.238238 0.274193 0.237033 0.146151 0.125309 0.16765 0.166675 0.13953 0.0826693
# Fleet_3 0.00211902 0.00283239 0.00379007 0.00507936 0.00682533 0.00921548 0.0125376 0.0172633 0.0240255 0.033703 0.0269051 0.0390993 0.0361288 0.0392057 0.0447954 0.0480414 0.0651248 0.0854645 0.116207 0.0915254 0.0925127 0.204053 0.205551 0.187247 0.228176 0.225138 0.449594 0.577975 0.792057 0.85022 0.510891 0.346314 0.349652 0.383174 0.540067 0.84959 0.727908 0.642202 0.657875 0.653774 0.704255 0.384791 0.279021 0.239142 0.155492 0.131508 0.132194 0.115664 0.0498991 0.029702 0.0219735 0.0389553 0.0153078 0.00910593 0.00677258 0.00369499 0.00204305 0.00256503 0.00253348 0.00237676 0.00245141 0.00225647 0.00226404 0.00212731 0.00220504 0.00208593 0.00160299 0.00126996 0.00101014 0.00080745 0.000638224 0.000464754 0.000303022 0.00020289 0.000120741
# Fleet_4 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0.000180243 0.000228379 0.000303185 0.000406239 0.000553478 0.000779304 0.00116394 0.0018941 0.00329974 0.00600357 0.0099398 0.0132377 0.0145795 0.0734018 0.0908052 0.0592116 0.457873 0.779231 0.653007 0.405081 0.265912 0.251123 0.173686 0.162815 0.125425 0.245714 0.224211 0.145934 0.0922 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
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
           -15            15      -18.3919             0             1             0         -1          0          0          0          0          0          0          0  #  LnQ_base_Fleet_1(1)
           -15            15      -19.9249             0             1             0         -1          0          0          0          0          0          0          0  #  LnQ_base_Fleet_2(2)
           -15            15      -7.35141             0             1             0         -1          0          0          0          0          0          0          0  #  LnQ_base_Fleet_3(3)
           -15            15      -7.54901             0             1             0         -1          0          0          0          0          0          0          0  #  LnQ_base_Fleet_4(4)
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
            20            90       32.6234            35            99             0          3          0          0          0          0          0          0          0  #  Size_DblN_peak_Fleet_1(1)
           -15            15      -24.6353      -24.6353            99             0         -3          0          0          0          0          0          0          0  #  Size_DblN_top_logit_Fleet_1(1)
            -4            12      -2.94607       3.58539            99             0          3          0          0          0          0          0          0          0  #  Size_DblN_ascend_se_Fleet_1(1)
           -15             6       4.60517       4.60517            99             0         -3          0          0          0          0          0          0          0  #  Size_DblN_descend_se_Fleet_1(1)
          -999            15           -15           -10            99             0         -2          0          0          0          0          0          0          0  #  Size_DblN_start_logit_Fleet_1(1)
           -15            20      -2.94444      -2.94444            99             0         -3          0          0          0          0          0          0          0  #  Size_DblN_end_logit_Fleet_1(1)
# 2   Fleet_2 LenSelex
            20            80       37.9279            45            99             0          3          0          0          0          0          0          0          0  #  Size_DblN_peak_Fleet_2(2)
           -15            15      -24.4121      -24.4121            99             0         -3          0          0          0          0          0          0          0  #  Size_DblN_top_logit_Fleet_2(2)
            -4            12      -2.44786       4.97168            99             0          3          0          0          0          0          0          0          0  #  Size_DblN_ascend_se_Fleet_2(2)
           -15             6       4.60517       4.60517            99             0         -3          0          0          0          0          0          0          0  #  Size_DblN_descend_se_Fleet_2(2)
          -999            15           -15           -10            99             0         -2          0          0          0          0          0          0          0  #  Size_DblN_start_logit_Fleet_2(2)
           -15            20      -2.94444      -2.94444            99             0         -3          0          0          0          0          0          0          0  #  Size_DblN_end_logit_Fleet_2(2)
# 3   Fleet_3 LenSelex
            20            75       62.7832            50            99             0          3          0          0          0          0          0          0          0  #  Size_DblN_peak_Fleet_3(3)
           -15            15     -0.847298     -0.847298            99             0         -3          0          0          0          0          0          0          0  #  Size_DblN_top_logit_Fleet_3(3)
            -4            12       -3.8397       4.97168            99             0          3          0          0          0          0          0          0          0  #  Size_DblN_ascend_se_Fleet_3(3)
           -15             6       4.60517       4.60517            99             0         -3          0          0          0          0          0          0          0  #  Size_DblN_descend_se_Fleet_3(3)
          -999            15           -15           -10            99             0         -2          0          0          0          0          0          0          0  #  Size_DblN_start_logit_Fleet_3(3)
           -15            20      -2.94444      -2.94444            99             0         -3          0          0          0          0          0          0          0  #  Size_DblN_end_logit_Fleet_3(3)
# 4   Fleet_4 LenSelex
            20            90       82.3966            35            99             0          3          0          0          0          0          0          0          0  #  Size_DblN_peak_Fleet_4(4)
           -15            15   1.99999e-11   1.99999e-11            99             0         -3          0          0          0          0          0          0          0  #  Size_DblN_top_logit_Fleet_4(4)
            -4            12      -3.99807       4.97168            99             0          3          0          0          0          0          0          0          0  #  Size_DblN_ascend_se_Fleet_4(4)
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
1 #_sd_offset; must be 1 if any growthCV, sigmaR, or survey extraSD is an estimated parameter
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

