/*
    File: fn_openItemRanksDialog.sqf
    Author: ColinM - https://github.com/ColinM9991/KP-Liberation
    Date: 2022-08-06
    Last Update: 2022-08-09
    License: MIT License - http://www.opensource.org/licenses/MIT
    
    Description:
        Opens the dialog and adds items.
    
    Parameter(s):
        _arsenalItems - All items that are added to the arsenal [ARRAY, defaults to []]
    
    Returns:
        NONE
*/
#ifndef IDD_ITEM_RANKS_DIALOG
#include "..\ui\defines.hpp"
#endif

private _result = createDialog "ItemRanksDialog";
if (!_result) exitWith {};

disableSerialization;

private _dialog = findDisplay IDD_ITEM_RANKS_DIALOG;

private _itemsList = _dialog displayCtrl IDC_ITEMS_LISTBOX;
private _itemsCombo = _dialog displayCtrl IDC_ITEMS_COMBO;
private _ranksCombo = _dialog displayCtrl IDC_RANKS_COMBO;

private _categorisedItems = [TVG_ranksArsenalItems] call TVG_fnc_getCategorisedItems;

TVG_ItemRanksEdit = [+_categorisedItems, +TVG_itemRankRestrictions];

{ _itemsCombo lbAdd _x; } forEach (keys _categorisedItems);
for "_rankIndex" from 1 to 19 do { _ranksCombo lbAdd str _rankIndex };

lbSort _itemsCombo;

_itemsCombo lbSetCurSel 0;
_ranksCombo lbSetCurSel 0;