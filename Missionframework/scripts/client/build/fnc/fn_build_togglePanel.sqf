/*
    File: fn_build_togglePanel.sqf
    Author: KP Liberation Dev Team - https://github.com/KillahPotatoes
    Date: 2026-01-29
    Last Update: 2026-01-30
    License: MIT License - http://www.opensource.org/licenses/MIT
    
    Description:
        No description added yet.
    
    Parameter(s):
        _localVariable - Description [DATATYPE, defaults to DEFAULTVALUE]
    
    Returns:
        Function reached the end [BOOL]
*/
#include "..\ui\defines.hpp"

params [
	["_control", controlNull, [controlNull]],
	["_panelId", -1, [-1]]
];

if (_panelId isEqualTo -1) exitWith {};

private _display = ctrlParent _control;
private _panel = _display displayCtrl _panelId;
_panel ctrlShow !(ctrlShown _panel);