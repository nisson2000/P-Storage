rule Model_keywords
{
    meta:
        description = "detect keyword for semicoductor model"
        created = "建立日期"
    strings:
        $model = "MODEL"
        $process = "PROCESS"
        $lib = "LIB"
        $nmos = "NMOS"
        $pmos = "PMOS"
        $param = "PARAM"
    condition:
        3 of them
}
rule Corner_keywords
{
    meta:
        description = "detect keyword for process corner"
        created = "建立日期"
    strings:
        $tt = "TT"
        $ss = "SS"
        $ff = "FF"
        $sf = "SF"
        $fs = "FS"
    condition:
        2 of them
}
rule Detect_Device_Parameter_Patterns
{
    meta:
        description = "detect MOSFET device parameters"
        created = "建立日期"
    strings:
        $device_param = /D[A-Z0-9]+_(N|P)(_[A-Z0-9])?_18/
        $dtox_n = "DTOX_N_18"
        $dvth0_n = "DVTH0_N_18"
        $du0_n = "DU0_N_18"
        $dvlth0_n = "DLVTH0_N_18"
        $dwu0_n = "DWU0_N_18"
        $dpvsat_n = "DPVSAT_N_18"
        $dcgdo_n = "DCGDO_N_18"
        $dcgso_n = "DCGSO_N_18"
        $dtox_p = "DTOX_P_18"
        $dvth0_p = "DVTH0_P_18"
        $du0_p = "DU0_P_18"
    condition:
        4 of them
}

