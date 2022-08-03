#ifndef BUILD_TYPE_BUILDING
#include "ui\build_types.hpp"
#endif

if (((_this select 3) select 0) != KP_liberation_small_storage_building) exitWith {
    [player getVariable ["KPLIB_nearProd", []], ((_this select 3) select 0), clientOwner] remoteExec ["build_fac_remote_call",2];
};

private _sectorPos = markerPos ([100] call KPLIB_fnc_getNearestSector);
    
[
    KP_liberation_small_storage_building,
    0,
    0,
    0,
    BUILD_TYPE_SECTOR,
    false,
    _sectorPos
] call KPLIB_fnc_handleBuild;

recalculate_sectors = true;
publicVariable "recalculate_sectors";