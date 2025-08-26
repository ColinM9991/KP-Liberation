/*
    File: fn_assignOrUnassignItem.sqf
    Author: ColinM - https://github.com/ColinM9991/KP-Liberation
    Date: 2022-08-07
    Last Update: 2022-08-09
    License: MIT License - http://www.opensource.org/licenses/MIT
    
    Description:
        No description added yet.
    
    Parameter(s):
        _localVariable - Description [DATATYPE, defaults to DEFAULTVALUE]
    
    Returns:
        NONE
*/
#ifndef IDD_ITEM_RANKS_DIALOG
#include "..\ui\defines.hpp"
#endif

params[
    ["_control", controlNull, [controlNull]],
    ["_selectedIndex", -1, [-1]],
    ["_isUnassign", false, [false]]
];

disableSerialization;

private _display = findDisplay IDD_ITEM_RANKS_DIALOG;
private _otherList = _display displayCtrl (if(_isUnassign) then [{IDC_ITEMS_LISTBOX},{IDC_RANKS_LISTBOX}]);

private _text = _control lbText _selectedIndex;
private _picture = _control lbPicture _selectedIndex;
private _value = _control lbData _selectedIndex;

_control lbDelete _selectedIndex;

private _itemIndex = _otherList lbAdd _text;
_otherList lbSetPicture [_itemIndex, _picture];
_otherList lbSetData [_itemIndex, _value];

lbSort _otherList;

[(lbCurSel IDC_RANKS_COMBO) + 1, _value, _isUnassign] call TVG_fnc_addOrRemoveAssignment;