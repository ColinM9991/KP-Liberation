/*
    File: fn_canBuildAi.sqf
    Author: ColinM https://github.com/ColinM9991/KP-Liberation
    Date: 2022-07-28
    Last Update: 2022-07-28
    License: MIT License - http://www.opensource.org/licenses/MIT

    Description:
        Can the AI unit or squad be built.

    Parameter(s):

    Returns:
        [
            Boolean // Build: Can Build Item,
            False   // Build with Crew: False by default since this function is for Infantry or Squads.
        ]
*/
#ifndef BUILD_TYPE_BUILDING
#include "..\build_types.hpp"
#endif

params[
	"",
	["_supplyCost", 0, [0]],
	["_ammoCost", 0, [0]],
	["_fuelCost", 0, [0]],
	["_buildType", -1, [-1]]
];

// Is the unit affordable
private _isAffordable = [_supplyCost, _ammoCost, _fuelCost] call KPLIB_fnc_canAffordBuildItem;
private _exceedsUnitCap = unitcap >= ([] call KPLIB_fnc_getLocalCap);

// If it exceeds the unit cap and the build mode is Infantry or Groups/Squads,
// or if the build mode is infantry and the player's group has reached the max unit limit, disable building
private _canBuild = if(
    _exceedsUnitCap
    || {_buildType isEqualTo BUILD_TYPE_INFANTRY && {count (units group player) >= KPLIB_param_maxSquadSize}}) then  [{false},{_isAffordable}];

[_canBuild, false]