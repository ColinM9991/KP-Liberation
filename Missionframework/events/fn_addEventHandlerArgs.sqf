/*
    File: fn_addEventHandlerArgs.sqf
    Author: ColinM - https://github.com/ColinM9991/KP-Liberation
    Date: 2026-02-03
    Last Update: 2026-02-03
    License: MIT License - http://www.opensource.org/licenses/MIT
    
    Description:
        Adds an event handler for the specified event. CBA compatible API.
    
    Parameter(s):
        _eventName      - The event name                                [String, defaults to ""]
        _eventFunction  - The event delegate                            [Code, defaults to nil]
        _arguments      - The additional arguments to pass to the event [ANY, defaults to []]
*/
params [
	["_eventName", "", [""]],
	["_eventFunction", nil, [{}]],
	["_arguments", []]
];

private _eventData = [_arguments, _eventFunction, _eventName];
private _eventDataId = KPLIB_eventArgs pushBack _eventData;

_eventFunction = compileFinal format['
	(KPLIB_eventArgs select %1) params ["_thisArgs", "_thisFnc", "_thisType", "_thisId"];

	_this call _thisFnc;
', _eventDataId];

private _eventId = [_eventName, _eventFunction] call KPLIB_fnc_addEventHandler;

_eventData pushBack _eventId;
_eventId