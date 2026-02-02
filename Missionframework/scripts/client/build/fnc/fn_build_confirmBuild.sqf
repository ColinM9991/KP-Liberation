/*
    File: fn_build_confirmBuild.sqf
    Author: KP Liberation Dev Team - https://github.com/KillahPotatoes
    Date: 2026-01-24
    Last Update: 2026-02-02
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

// deleteVehicle deletes objects in the next frame
// Wait until the objects are deleted and then spawn the real objects.
// This helps with local testing where createVehicleLocal objects are global to the server and client.
// This shouldn't be an issue on a dedicated server
[
    {
        _this params ["_buildItems", "_storageAreas"];

        {
            [_x, player] remoteExecCall ["KPLIB_fnc_build_confirmBuildServer", 2];
        } forEach _buildItems;
        [] call KPLIB_fnc_build_end;
    },
    [_buildItems],
    5
] call CBA_fnc_execAfterNFrames;