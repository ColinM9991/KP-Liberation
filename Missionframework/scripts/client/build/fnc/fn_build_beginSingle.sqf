/*
    File: fn_build_beginSingle.sqf
    Author: KP Liberation Dev Team - https://github.com/KillahPotatoes
    Date: 2026-01-24
    Last Update: 2026-02-01
    License: MIT License - http://www.opensource.org/licenses/MIT
    
    Description:
        No description added yet.
    
    Parameter(s):
        _localVariable - Description [DATATYPE, defaults to DEFAULTVALUE]
    
    Returns:
        Function reached the end [BOOL]
*/
#include "defines.hpp"
#include "..\ui\defines.hpp"

params [
	["_className", "", [""]],
	["_pos", getPos player, [[]]],
	["_buildType", -1, [-1]],
	["_radius", KPLIB_range_fob, [0]]
];

if (_buildType isEqualTo -1) exitWith {};

private _displayLoadedEventId = ["KPLIB_build_event_displayLoaded", {
	private _display = _this;
    
    private _display = _this;
    {
	    (_display displayCtrl _x) ctrlShow false;
    } forEach [
        BUILD_PANEL_LEFT,
        BUILD_PANEL_RIGHT,
        BUILD_PANEL_LEFT_HEADER,
        BUILD_PANEL_RIGHT_HEADER,
        BUILD_HEADER_RESOURCES];
}] call CBA_fnc_addEventHandler;

["KPLIB_fnc_build_ended", {
	[_thisType, _thisId] call CBA_fnc_removeEventHandler;
    ["KPLIB_build_event_displayLoaded", _thisArgs] call CBA_fnc_removeEventHandler;
}, _displayLoadedEventId] call CBA_fnc_addEventHandlerArgs;

[_pos, _radius] call KPLIB_fnc_build_beginCore;

private _value = [_className, 0, 0, 0];
private _object = _value call KPLIB_fnc_build_createObject;

SVAR(cursorObject, vehicle _object);
SVAR(isBuilding, true);
SVAR(isSingleBuild, true);
SVAR(buildType, _buildType);