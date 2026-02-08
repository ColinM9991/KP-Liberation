/*
    File: fn_removeEventHandler.sqf
    Author: ColinM - https://github.com/ColinM9991/KP-Liberation
    Date: 2026-02-03
    Last Update: 2026-02-08
    License: MIT License - http://www.opensource.org/licenses/MIT
    
    Description:
        Removes an event handler with the specified ID. CBA compatible API.
    
    Parameter(s):
        _eventName  - The event name         [String, defaults to ""]
        _eventId    - The event id           [Number, defaults to -1]
*/
params [
	["_eventName", "", [""]],
	["_eventId", "", [""]]
];

if (_eventName isEqualTo "" || _eventId isEqualTo "") exitWith{
    [format ["Invalid parameters passed to %1: eventName - %2, eventId - %3", __FILE__, _eventName, _eventId], "EVENTS"] call KPLIB_fnc_log;
};

private _eventHandlers = KPLIB_events getOrDefault [_eventName, createHashMap];

_eventHandlers deleteAt _eventId;

if (_eventId in KPLIB_eventArgs) then {
    KPLIB_eventArgs deleteAt _eventId;
};