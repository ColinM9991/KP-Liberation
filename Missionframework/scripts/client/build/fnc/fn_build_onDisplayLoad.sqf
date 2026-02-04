/*
    File: fn_build_onDisplayLoad.sqf
    Author: KP Liberation Dev Team - https://github.com/KillahPotatoes
    Date: 2026-01-20
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
params [
	["_display", nil, [displayNull]]
];

SVAR(display, _display);

["KPLIB_build_event_displayLoaded", _display] call KPLIB_fnc_localEvent;