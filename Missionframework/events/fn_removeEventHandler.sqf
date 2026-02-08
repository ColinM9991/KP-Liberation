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

if (_eventName isEqualTo "" || _eventId isEqualTo "") exitWith{};

private _eventHandlers = KPLIB_events getOrDefault [_eventName, createHashMap];

_eventHandlers deleteAt _eventId;

private _eventArgs = KPLIB_eventArgs;
{
    _x params ["", "", "_type", "_id"];
    if (_type isEqualTo _eventName && _id isEqualTo _eventId) then {
        KPLIB_eventArgs deleteAt _forEachIndex;
    };
} forEach _eventArgs;