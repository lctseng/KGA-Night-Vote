# setup redis shorthand
if ENV["HEROKU_REDIS_SILVER_URL"]
  REDIS = Redis.new(:url => ENV["HEROKU_REDIS_SILVER_URL"])
else
  REDIS = Redis.current
end
# set all ticket id
TICKET_LIST = ["LQ001", "NT002", "NU003", "QO004", "XX005", "GO006", "QM007", "WT008", "HN009", "FW010", "PM011", "SP012", "XB013", "WS014", "TN015", "LM016", "ZF017", "GC018", "YW019", "IR020", "WZ021", "OC022", "WM023", "XY024", "MA025", "IB026", "SI027", "GS028", "VO029", "JV030", "NS031", "IC032", "EU033", "RL034", "IK035", "PA036", "MI037", "CQ038", "HT039", "WA040", "UC041", "JR042", "JK043", "VL044", "SR045", "PY046", "WJ047", "FK048", "EI049", "RM050", "XZ051", "HB052", "TO053", "BE054", "WO055", "RU056", "KF057", "CC058", "QE059", "CU060", "NM061", "MD062", "GI063", "NH064", "SL065", "CM066", "JD067", "DI068", "HW069", "TG070", "VX071", "TR072", "ZP073", "HA074", "AI075", "ZB076", "FM077", "DR078", "FG079", "WR080", "QQ081", "XI082", "UI083", "UW084", "QV085", "EH086", "MM087", "SF088", "LJ089", "OB090", "FC091", "DN092", "BM093", "DX094", "HL095", "MU096", "FD097", "MR098", "YG099", "BW100", "LU101", "IH102", "NY103", "UJ104", "QU105", "VP106", "EZ107", "OM108", "QI109", "MB110", "ZO111", "VU112", "AL113", "OY114", "GY115", "TF116", "CN117", "OE118", "NG119", "UB120", "MS121", "HR122", "DA123", "GL124", "EX125", "HF126", "KJ127", "RX128", "DE129", "LV130", "CP131", "PQ132", "FS133", "CW134", "FE135", "EB136", "SX137", "MC138", "LF139", "NP140", "NC141", "KK142", "RQ143", "SE144", "WC145", "PD146", "TM147", "DL148", "UM149", "SA150", "NK151", "BA152", "OP153", "RD154", "SG155", "KB156", "HS157", "VJ158", "KD159", "VR160", "PJ161", "RE162", "YC163", "YS164", "FI165", "QF166", "GK167", "DP168", "DZ169", "UH170", "ZD171", "YB172", "ZA173", "KQ174", "MP175", "AM176", "SD177", "WX178", "VQ179", "FT180", "RS181", "VB182", "ZE183", "SB184", "UQ185", "QL186", "TB187", "LZ188", "JO189", "FO190", "BJ191", "UT192", "LI193", "TP194", "RC195", "HY196", "SK197", "CE198", "BZ199", "ME200", "GA201", "CT202", "JE203", "WF204", "VZ205", "UD206", "LY207", "OQ208", "MH209", "MF210", "VK211", "FP212", "TU213", "KZ214", "IS215", "VI216", "QG217", "FN218", "KG219", "JF220", "YL221", "IY222", "BL223", "SY224", "BP225", "UP226", "LL227", "RH228", "ST229", "GR230", "KX231", "XO232", "GU233", "XH234", "JZ235", "GB236", "IU237", "AS238", "IN239", "QS240", "PN241", "XG242", "EJ243", "GJ244", "HV245", "AX246", "RR247", "IF248", "XE249", "YX250", "QH251", "IG252", "FB253", "ED254", "JX255", "OH256", "SZ257", "KW258", "LX259", "IE260", "AW261", "EY262", "ZR263", "VN264", "RK265", "II266", "CF267", "PB268", "FV269", "NI270", "AJ271", "QR272", "NR273", "SW274", "SN275", "KR276", "PV277", "DT278", "VV279", "AU280", "YE281", "KI282", "BF283", "OD284", "WE285", "OA286", "QA287", "YF288", "XW289", "BU290", "WV291", "HZ292", "CZ293", "SS294", "TE295", "FY296", "QX297", "VM298", "BS299", "LE300", "PS301", "ZS302", "TW303", "UK304", "WB305", "MN306", "DY307", "FZ308", "JI309", "LR310", "KY311", "RN312", "ND313", "OT314", "EL315", "TJ316", "MG317", "EV318", "XK319", "XM320", "JN321", "GQ322", "MW323", "VT324", "KL325", "GW326", "RY327", "KC328", "GT329", "HX330", "HO331", "FU332", "EA333", "NN334", "CY335", "PW336", "PZ337", "TD338", "LP339", "VW340", "KM341", "KH342", "ER343", "FQ344", "EM345", "EG346", "BR347", "FH348", "MO349", "RV350", "KT351", "EE352", "KS353", "QN354", "YD355", "GM356", "CI357", "TZ358", "CS359", "HI360", "HG361", "KA362", "CK363", "IV364", "BB365", "QK366", "CR367", "LH368", "EO369", "JM370", "QC371", "LG372", "EP373", "NA374", "LD375", "RT376", "SJ377", "PO378", "ZM379", "OU380", "UV381", "WL382", "DH383", "EF384", "IL385", "NW386", "AQ387", "TS388", "ZJ389", "UN390", "VC391", "OZ392", "OS393", "AD394", "JL395", "ZH396", "TC397", "XU398", "FA399", "AN400", "YA401", "WU402", "KV403", "IA404", "VH405", "IQ406", "FX407", "OR408", "GP409", "MJ410", "XC411", "OK412", "YN413", "HM414", "KO415", "NO416", "TV417", "YM418", "BH419", "HH420", "GD421", "UO422", "BG423", "XL424", "WH425", "CA426", "AK427", "DO428", "ZW429", "QJ430", "OF431", "DU432", "CL433", "XV434", "DK435", "AG436", "BO437", "IJ438", "ZX439", "LK440", "BY441", "WK442", "QP443", "PE444", "JS445", "LC446", "EN447", "WN448", "XP449", "GV450", "LS451", "WG452", "ZC453", "ZQ454", "GX455", "WD456", "ZL457", "HK458", "NJ459", "WP460", "PR461", "MQ462", "SU463", "GZ464", "ZI465", "JP466", "XT467", "RB468", "HC469", "MK470", "PC471", "XJ472", "VY473", "XS474", "DW475", "OW476", "BT477", "YO478", "YZ479", "EQ480", "GN481", "MY482", "RJ483", "RG484", "QY485", "MZ486", "BN487", "TI488", "NF489", "DM490", "AV491", "KU492", "NE493", "HJ494", "GH495", "YK496", "YT497", "PG498", "JC499", "PL500", "XN501", "FF502", "IT503", "ZV504", "EC505", "JY506", "JU507", "IP508", "AT509", "AF510", "PU511", "DQ512", "GE513", "PH514", "BK515", "MX516", "US517", "LB518", "LO519", "QW520", "AH521", "VE522", "ZY523", "DB524", "PP525", "OG526", "NQ527", "SO528", "OX529", "OO530", "YP531", "DG532", "XR533", "AA534", "JW535", "UG536", "IM537", "FJ538", "SQ539", "XA540", "KN541", "SH542", "LA543", "TY544", "VF545", "LT546", "CB547", "YU548", "AR549", "GG550", "AB551", "JQ552", "QT553", "ZZ554", "CJ555", "SM556", "TQ557", "HD558", "SV559", "TA560", "QD561", "QB562", "LN563", "FL564", "VA565", "HE566", "BI567", "WQ568", "KE569", "WI570", "CG571", "YR572", "ZG573", "XD574", "BX575", "RA576", "DD577", "ON578", "SC579", "XF580", "RF581", "CV582", "UY583", "OL584", "ZU585", "TT586", "AC587", "YY588", "QZ589", "CH590", "JH591", "TH592", "YQ593", "AP594", "VG595", "FR596", "ZK597", "XQ598", "AY599", "NZ600", "NX601", "UZ602", "BQ603", "HQ604", "PF605", "IX606", "DF607", "IW608", "UF609", "GF610", "NL611", "AZ612", "ES613", "DS614", "PI615", "RP616", "RZ617", "WY618", "MT619", "DV620", "UA621", "YI622", "EK623", "UL624", "KP625", "ID626", "HP627", "CD628", "IO629", "BV630", "CX631", "UU632", "YH633", "CO634", "WW635", "IZ636", "JB637", "BC638", "TL639", "RI640", "TX641", "ZT642", "VD643", "YJ644", "VS645", "BD646", "YV647", "AE648", "OV649", "UX650", "LW651", "RO652", "UR653", "JG654", "MV655", "ML656", "PK657", "DJ658", "PT659", "DC660", "JT661", "RW662", "ZN663", "ET664", "NV665", "AO666", "NB667", "TK668", "EW669", "OJ670", "JJ671", "JA672", "UE673", "PX674", "OI675", "HU676"]

