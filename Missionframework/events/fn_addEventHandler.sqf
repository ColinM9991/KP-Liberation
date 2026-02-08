/*
    File: fn_addEventHandler.sqf
    Author: ColinM - https://github.com/ColinM9991/KP-Liberation
    Date: 2026-02-03
    Last Update: 2026-02-08
    License: MIT License - http://www.opensource.org/licenses/MIT
    
    Description:
        Adds an event handler for the specified event. CBA compatible API.
    
    Parameter(s):
        _eventName      - The event name         [String, defaults to ""]
        _eventFunction  - The event delegate     [Code, defaults to nil]
        _arguments      - The additional arguments to pass to the event [ANY, defaults to []]
*/
params [
	["_eventName", "", [""]],
	["_eventFunction", nil, [{}]],
    ["_arguments", []]
];

if (_eventName isEqualTo "" || isNil "_eventFunction") exitWith {
    [format ["Invalid parameters passed to %1: eventName - %2, eventFunction - %3", __FILE__, _eventName, _eventFunction], "EVENTS"] call KPLIB_fnc_log;
};

private _eventHandlers = KPLIB_events getOrDefault [_eventName, createHashMap, true];
private _eventId = hashValue _eventFunction;

if (_eventId in _eventHandlers) exitWith {
    [format ["Event handler with id %1 already exists for event %2", _eventId, _eventName], "EVENTS"] call KPLIB_fnc_log;
};

if (_arguments isNotEqualTo []) then {
    KPLIB_eventArgs set [_eventId, [_arguments, _eventFunction, _eventName, _eventId]];
    
    _eventFunction = compileFinal format['
        (KPLIB_eventArgs get "%1") params ["_thisArgs", "_thisFnc", "_thisType", "_thisId"];
    
        _this call _thisFnc;
    ', _eventId];
};

_eventHandlers set [_eventId, _eventFunction];

_eventId