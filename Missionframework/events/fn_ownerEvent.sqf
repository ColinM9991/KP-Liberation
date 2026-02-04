/*
    File: fn_ownerEvent.sqf
    Author: ColinM - https://github.com/ColinM9991/KP-Liberation
    Date: 2026-02-03
    Last Update: 2026-02-03
    License: MIT License - http://www.opensource.org/licenses/MIT
    
    Description:
        Triggers an event on the target. CBA compatible API.
    
    Parameter(s):
        _eventName  - The event name         [String, defaults to ""]
        _eventArgs  - The event arguments    [ANY, defaults to []]
        _owner      - The desired target     [Number, -1]
*/
params [
	["_eventName", "", [""]],
	["_eventArgs", []],
	["_owner", -1, [-1]]
];

if (_owner isEqualTo -1) exitWith {};

switch (_owner) do {
    case 2: {[_eventName, _eventArgs] call KPLIB_fnc_serverEvent;};
    case clientOwner: {[_eventName, _eventArgs] call KPLIB_fnc_localEvent;};
    default {[_eventName, _eventArgs] remoteExecCall ["KPLIB_fnc_localEvent", _owner];}
}