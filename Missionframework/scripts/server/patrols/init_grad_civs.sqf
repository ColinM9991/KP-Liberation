/*
    File: init_grad_civs.sqf
    Author: ColinM - https://github.com/ColinM9991/KP-Liberation
    Date: 2022-07-25
    Last Update: 2026-02-08
    License: MIT License - http://www.opensource.org/licenses/MIT
    
    Description:
        Adds the GRAD Civs translation code to use the existing kill handler (KPLIB_manageKills).
        Also adds exclusion zones based on existing FOBs and military zones, factories and towers.
    
    Parameter(s):
        NONE
    
    Returns:
        NONE
*/

["CBA_SettingsInitialized", {
    [format["Initializing Civilians %1 %2", KPLIB_c_units, KPLIB_c_vehicles], "GRAD CIVS"] call KPLIB_fnc_log;
    ["grad_civs_lifecycle_civClasses", str KPLIB_c_units, 1, "server", true] call CBA_settings_fnc_set; 
    ["grad_civs_cars_vehicles", str KPLIB_c_vehicles, 1, "server", true] call CBA_settings_fnc_set; 
}] call CBA_fnc_addEventHandler;

waitUntil {!isNil "KPLIB_sectors_fob"};
waitUntil {!isNil "KPLIB_sectors_military"};
waitUntil {!isNil "KPLIB_sectors_factory"};
waitUntil {!isNil "KPLIB_sectors_tower"};

{
    [[(getMarkerPos _x), 200, 200, 0, false]] call grad_civs_common_fnc_addExclusionZone; 
} forEach (["startbase_marker"] + KPLIB_sectors_military + KPLIB_sectors_tower + KPLIB_sectors_factory);

[format["Initialized GRAD CIVS with exclusion zones: %1", grad_civs_common_exclusion_zones], "GRAD CIVS"] call KPLIB_fnc_log;