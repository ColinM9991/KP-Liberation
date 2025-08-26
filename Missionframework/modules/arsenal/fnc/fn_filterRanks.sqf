/*
    File: fn_filterRanks.sqf
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
#ifndef IDC_RANKS_LISTBOX
#include "..\ui\defines.hpp"
#endif

params[["_selectedIndex", lbCurSel IDC_RANKS_COMBO, [-1]]];

if(_selectedIndex isEqualTo -1) exitWith {};
lbClear IDC_RANKS_LISTBOX;

private _rank = _selectedIndex + 1;
private _rankItems = (TVG_ItemRanksEdit select 1) getOrDefault [_rank, []];
private _selectedCategoryItems = [lbText [IDC_ITEMS_COMBO, lbCurSel IDC_ITEMS_COMBO]] call TVG_fnc_getCategoryItems;

if(_rankItems isEqualTo []) exitWith {};

_rankItems = _rankItems arrayIntersect _selectedCategoryItems;

private _mappedItems = _rankItems apply {
	private _itemDetails = [_x] call TVG_fnc_getItemDisplay;

	[_x, _itemDetails select 0, _itemDetails select 1];
};

{
	private _rowIndex = lbAdd[IDC_RANKS_LISTBOX, _x select 1];
	lbSetData [IDC_RANKS_LISTBOX, _rowIndex, _x select 0];
	lbSetPicture [IDC_RANKS_LISTBOX, _rowIndex, _x select 2];
} forEach _mappedItems;
lbSort IDC_RANKS_LISTBOX;