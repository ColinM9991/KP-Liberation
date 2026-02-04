/*
    File: fn_globalEvent.sqf
    Author: ColinM - https://github.com/ColinM9991/KP-Liberation
    Date: 2026-02-03
    Last Update: 2026-02-03
    License: MIT License - http://www.opensource.org/licenses/MIT
    
    Description:
        Triggers an event on all active machines. CBA compatible API.
    
    Parameter(s):
        _eventName  - The event name         [String, defaults to ""]
        _eventArgs  - The event arguments    [ANY, defaults to []]
*/
params [
	["_eventName", "", [""]],
	["_eventArgs", []]
];

[_eventName, _eventArgs] remoteExecCall ["KPLIB_fnc_localEvent"];