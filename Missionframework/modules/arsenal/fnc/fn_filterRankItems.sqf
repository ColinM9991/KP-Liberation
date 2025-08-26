/*
    File: fn_filterRankItems.sqf
    Author: ColinM - https://github.com/ColinM9991/KP-Liberation
    Date: 2022-08-06
    Last Update: 2022-08-09
    License: MIT License - http://www.opensource.org/licenses/MIT
    
    Description:
        Updates the Items combo box and sorts alphabetically.
    
    Parameter(s):
        _selectedIndex - The selected index from the items combo box [INTEGER, defaults to -1]
    
    Returns:
        NONE
*/
#ifndef IDC_ITEMS_LISTBOX
#include "..\ui\defines.hpp"
#endif

params[["_selectedIndex", -1, [-1]]];

if(_selectedIndex isEqualTo -1) exitWith {};
lbClear IDC_ITEMS_LISTBOX;

private _categories = TVG_ItemRanksEdit select 0;
private _categoryName = lbText [IDC_ITEMS_COMBO, _selectedIndex];
private _items = _categories getOrDefault[_categoryName, []];
private _rankAssignments = [] call TVG_fnc_getAllRankAssignments;

if(_items isEqualTo []) exitWith {};

private _mappedItems = (_items select {
    (_rankAssignments find _x) isEqualTo -1;
}) apply {
	private _itemDetails = [_x] call TVG_fnc_getItemDisplay;

	[_x, _itemDetails select 0, _itemDetails select 1];
};

{
    if ((_x select 1) isEqualTo "") then { continue };
	private _rowIndex = lbAdd[IDC_ITEMS_LISTBOX, _x select 1];
	lbSetData [IDC_ITEMS_LISTBOX, _rowIndex, _x select 0];
	lbSetPicture [IDC_ITEMS_LISTBOX, _rowIndex, _x select 2];
} forEach _mappedItems;

lbSort IDC_ITEMS_LISTBOX;

[] call TVG_fnc_filterRanks;