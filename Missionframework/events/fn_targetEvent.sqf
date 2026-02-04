/*
    File: fn_targetEvent.sqf
    Author: ColinM - https://github.com/ColinM9991/KP-Liberation
    Date: 2026-02-03
    Last Update: 2026-02-03
    License: MIT License - http://www.opensource.org/licenses/MIT
    
    Description:
        Triggers an event on the target. CBA compatible API.
    
    Parameter(s):
        _eventName  - The event name         [String, defaults to ""]
        _eventArgs  - The event arguments    [ANY, defaults to []]
        _target     - The desired target     [Object, Group, Side or Array, defaults to []]
*/
params [
	["_eventName", "", [""]],
	["_eventArgs", []],
	["_target", [], [objNull, grpNull, sideEmpty, []]]
];

[_eventName, _eventArgs] remoteExecCall ["KPLIB_fnc_localEvent", _target];