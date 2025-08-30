/*
    File: init_grad_civs.sqf
    Author: ColinM - https://github.com/ColinM9991/KP-Liberation
    Date: 2022-07-25
    Last Update: 2022-08-03
    License: MIT License - http://www.opensource.org/licenses/MIT
    
    Description:
        Adds the GRAD Civs translation code to use the existing kill handler (KPLIB_manageKills).
        Also adds exclusion zones based on existing FOBs and military zones, factories and towers.
    
    Parameter(s):
        NONE
    
    Returns:
        NONE
*/
["grad_civs_civKilled", {
    params ["", "_killer", "_civilian"];

    ["KPLIB_manageKills", [_civilian, _killer]] call CBA_fnc_localEvent;
}] call CBA_fnc_addEventHandler;

["grad_civs_cars_vehKilled", {
    params ["", "_killer", "_vehicle"];

    ["KPLIB_manageKills", [_vehicle, _killer]] call CBA_fnc_localEvent;
}] call CBA_fnc_addEventHandler;

["CBA_SettingsInitialized", {
    [format["Initializing Civilians %1 %2", KPLIB_c_units, KPLIB_c_vehicles], "GRAD CIVS"] call KPLIB_fnc_log;
    ["grad_civs_lifecycle_civClasses", str KPLIB_c_units, 1, "server", true] call CBA_settings_fnc_set; 
    ["grad_civs_cars_vehicles", str KPLIB_c_vehicles, 1, "server", true] call CBA_settings_fnc_set; 
}] call CBA_fnc_addEventHandler;

waitUntil {!isNil "KPLIB_sectors_fob"};
waitUntil {!isNil "sectors_military"};
waitUntil {!isNil "sectors_factory"};
waitUntil {!isNil "sectors_tower"};

grad_civs_common_exclusion_zones = [];
_excludedZones = [];
{
    _excludedZones pushBack (getMarkerPos _x);
} forEach (["startbase_marker"] + sectors_military + sectors_tower + sectors_factory);

{
    [[_x, 200, 200, 0, false]] call grad_civs_common_fnc_addExclusionZone; 
} forEach (_excludedZones + KPLIB_sectors_fob);

publicVariable "grad_civs_common_exclusion_zones";