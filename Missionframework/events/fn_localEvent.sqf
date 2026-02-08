/*
    File: fn_localEvent.sqf
    Author: ColinM - https://github.com/ColinM9991/KP-Liberation
    Date: 2026-02-03
    Last Update: 2026-02-08
    License: MIT License - http://www.opensource.org/licenses/MIT
    
    Description:
        Triggers an event on the local machine. CBA compatible API.
    
    Parameter(s):
        _eventName  - The event name         [String, defaults to ""]
        _eventArgs  - The event arguments    [ANY, defaults to []]
*/
params [
	["_eventName", "", [""]],
	["_eventArgs", []]
];

private _eventHandlers = KPLIB_events getOrDefault[_eventName, createHashMap];
private _functions = values _eventHandlers;

{
	_eventArgs call _x;
} forEach _functions;