/*
    File: fn_addEventHandlerArgs.sqf
    Author: ColinM - https://github.com/ColinM9991/KP-Liberation
    Date: 2026-02-03
    Last Update: 2026-02-08
    License: MIT License - http://www.opensource.org/licenses/MIT
    
    Description:
        Adds an event handler for the specified event. CBA compatible API.
        The following parameters are passed to the event function:
            _thisArgs   - The additional arguments passed to the event
            _thisFnc    - The event delegate
            _thisType   - The event name
            _thisId     - The event id
    
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

private _eventId = [_eventName, _eventFunction, _arguments] call KPLIB_fnc_addEventHandler;

_eventId