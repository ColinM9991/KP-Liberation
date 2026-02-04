/*
    File: fn_removeEventHandler.sqf
    Author: ColinM - https://github.com/ColinM9991/KP-Liberation
    Date: 2026-02-03
    Last Update: 2026-02-03
    License: MIT License - http://www.opensource.org/licenses/MIT
    
    Description:
        Removes an event handler with the specified ID. CBA compatible API.
    
    Parameter(s):
        _eventName  - The event name         [String, defaults to ""]
        _eventId    - The event id           [Number, defaults to -1]
*/
params [
	["_eventName", "", [""]],
	["_eventId", -1, [-1]]
];

if (_eventName isEqualTo "" || _eventId isEqualTo -1) exitWith{};

private _eventRegistrations = KPLIB_events getOrDefault [_eventName, createHashMap];
private _eventHandlers = _eventRegistrations getOrDefault ["events", createHashMap];

_eventHandlers deleteAt _eventId;