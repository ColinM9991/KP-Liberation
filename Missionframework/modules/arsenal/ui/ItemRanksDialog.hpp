import RscCombo;
import RscListBox;
import RscText;
import RscButtonMenuCancel;
import RscButton;
import RscButtonMenu;
import RscXListBox;

#include "defines.hpp"

class ItemRanksDialog {
    movingEnable = 0;
    idd = IDD_ITEM_RANKS_DIALOG;
    onUnload = "TVG_ItemRanksEdit = nil"; 
    
    class controlsBackground
    {
        class DialogBackground: RscText
        {
            idc = 1001;
            x = STARTING_POS_X;
            y = STARTING_POS_Y;
            w = DIALOG_WIDTH;
            h = DIALOG_HEIGHT;
            colorBackground[] = {0,0,0,0.5};
        };

        class DialogTitle: DialogBackground
        {
            idc = 1000;
            text = "KP Ranks - Weapon Restrictions"; //--- ToDo: Localize;
            y = (STARTING_POS_Y) - DIALOG_TITLE_HEIGHT;
            h = DIALOG_TITLE_HEIGHT;
            colorBackground[] = {"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.13])","(profilenamespace getvariable ['GUI_BCG_RGB_G',0.54])","(profilenamespace getvariable ['GUI_BCG_RGB_B',0.21])","(profilenamespace getvariable ['GUI_BCG_RGB_A',0.8])"};
        };
    };
    class controls
    {
        class LbItems: RscListBox
        {
            idc = IDC_ITEMS_LISTBOX;
            x = GRID_POS_X(1, 3);
            y = STARTING_POS_Y;
            w = LIST_WIDTH;
            h = DIALOG_HEIGHT;
            colorPicture[] = {1,1,1,1};
            colorPictureSelected[] = {1,1,1,1};
            colorPictureDisabled[] = {1,1,1,1};
            onLBDblClick = "[_this select 0, _this select 1] call TVG_fnc_assignOrUnassignItem;";
        };
        
        class LbRanks: RscListBox
        {
            idc = IDC_RANKS_LISTBOX;
            x = GRID_POS_X(3, 3);
            y = STARTING_POS_Y;
            w = LIST_WIDTH;
            h = DIALOG_HEIGHT;
            onLBDblClick = "[_this select 0, _this select 1, true] call TVG_fnc_assignOrUnassignItem;";
        };

        class LblItems: RscText {
            text= "Category";
            x = GRID_POS_X(2, 3) + SPACING;
            y = GRID_POS_Y(1,20, 0.022 * safezoneH);
            h = 0.022 * safezoneH;
        };

        class ItemsCategoryCombo: RscCombo
        {
            idc = IDC_ITEMS_COMBO;
            x = GRID_POS_X(2, 3) + SPACING;
            y = GRID_POS_Y(2,20, 0.022 * safezoneH);
            w = LIST_WIDTH - (SPACING * 2);
            h = 0.022 * safezoneH;
            onLBSelChanged = "[_this select 1] call TVG_fnc_filterRankItems;";
        };

        class LblRanks: RscText {
            text= "Rank";
            x = GRID_POS_X(2, 3) + SPACING;
            y = GRID_POS_Y(3,20, 0.022 * safezoneH);
            h = 0.022 * safezoneH;
        };

        class RanksCombo: RscXListBox
        {
            idc = IDC_RANKS_COMBO;
            x = GRID_POS_X(2, 3) + SPACING;
            y = GRID_POS_Y(4,20, 0.022 * safezoneH);
            w = LIST_WIDTH - (SPACING * 2);
            h = 0.022 * safezoneH;
            onLBSelChanged = "[_this select 1] call TVG_fnc_filterRanks;";
        };

        class BtnSave: RscButtonMenu
        {
            idc = IDC_SAVE_BUTTON;

            text = "Save"; //--- ToDo: Localize;
            x = END_POS_X - 0.0498837 * safezoneW;
            y = STARTING_POS_BUTTON;
            w = 0.0498837 * safezoneW;
            h = 0.022 * safezoneH;
            onButtonClick = "[] call TVG_fnc_saveRankItemsClient;";
        };

        class BtnCancel: RscButtonMenu
        {
            idc = IDC_CANCEL_BUTTON;

            text = "Cancel"; //--- ToDo: Localize;
            x = STARTING_POS_X;
            y = STARTING_POS_BUTTON;
            w = 0.0498837 * safezoneW;
            h = 0.022 * safezoneH;
        };
    }
}
