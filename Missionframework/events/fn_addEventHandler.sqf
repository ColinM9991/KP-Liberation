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
*/
params [
	["_eventName", "", [""]],
	["_eventFunction", nil, [{}]]
];

if (_eventName isEqualTo "" || isNil "_eventFunction") exitWith {};

private _eventHandlers = KPLIB_events getOrDefault [_eventName, createHashMap, true];
private _eventId = hashValue _eventFunction;

_eventHandlers set [_eventId, _eventFunction];
_eventId