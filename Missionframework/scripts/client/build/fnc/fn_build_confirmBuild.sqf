/*
    File: fn_build_confirmBuild.sqf
    Author: KP Liberation Dev Team - https://github.com/KillahPotatoes
    Date: 2026-01-24
    Last Update: 2026-02-03
    License: MIT License - http://www.opensource.org/licenses/MIT
    
    Description:
        No description added yet.
    
    Parameter(s):
        _localVariable - Description [DATATYPE, defaults to DEFAULTVALUE]
    
    Returns:
        Function reached the end [BOOL]
*/

#include "defines.hpp"

private _validItems = GVAR(buildCart) select { _x getVariable ["KPLIB_build_validPlacement", true]; };
private _buildItems = _validItems apply {
    private _data = [typeOf _x, getPosWorld _x, [vectorDir _x, vectorUp _x], _x getVariable ["KPLIB_buildPrice", [0, 0, 0]]];

	deleteVehicle _x;

    _data
};

[
    {
        [_this, player] remoteExecCall ["KPLIB_fnc_build_confirmBuildServer", 2];
        [] call KPLIB_fnc_build_end;
    },
    _buildItems,
    5
] call CBA_fnc_execAfterNFrames;