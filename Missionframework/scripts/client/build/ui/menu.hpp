/*
    File: defines.hpp
    Author: KP Liberation Dev Team - https://github.com/KillahPotatoes
    Date: 2026-01-20
    Last Update: 2026-01-25
    License: MIT License - http://www.opensource.org/licenses/MIT
    
    Description:
        No description added yet.
*/
#include "defines.hpp"

// Base positioning from safeZone
#define PANEL_X (safeZoneX + PANEL_OFFSET * GRID_W)
#define PANEL_Y (safeZoneY + PANEL_OFFSET * GRID_H)

// Right panel positioning
#define PANEL_RIGHT_X (safeZoneX + safeZoneW - PANEL_W - PANEL_OFFSET * GRID_W)
#define PANEL_RIGHT_END (PANEL_RIGHT_X + PANEL_W)

// Panel dimensions
#define PANEL_W (80 * GRID_W)
#define PANEL_H (safeZoneH - (PANEL_OFFSET * 2) * GRID_H)
#define PANEL_OFFSET 10

// Component dimensions
#define BUTTON_WIDTH (20 * GRID_W)
#define BUTTON_HEIGHT (5 * GRID_H)
#define HEADER_HEIGHT (5 * GRID_H)
#define COMBO_HEIGHT (5 * GRID_H)
#define SPACING (2 * GRID_H)

// Calculated Y positions (stacking elements vertically)
#define HEADER_Y PANEL_Y
#define COMBO_Y (HEADER_Y + HEADER_HEIGHT + SPACING)
#define LIST_Y (COMBO_Y + COMBO_HEIGHT + SPACING)
#define LIST_H (PANEL_Y + PANEL_H - LIST_Y - BUTTON_HEIGHT - SPACING * 2)
#define BUTTON_Y (PANEL_Y + PANEL_H - BUTTON_HEIGHT - SPACING)

#define CALC_BUTTON(REL, IDX) (REL - (BUTTON_WIDTH * IDX) - (SPACING * IDX))

#define TASKBAR_COLOR {"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.13])", "(profilenamespace getvariable ['GUI_BCG_RGB_G',0.54])", "(profilenamespace getvariable ['GUI_BCG_RGB_B',0.21])", "(profilenamespace getvariable ['GUI_BCG_RGB_A',0.8])"}

class RscBuildDialog
{
	idd = -1;
	movingEnable = 0;

	onLoad = "call KPLIB_fnc_build_onDisplayLoad;";
    onKeyUp = "[false, _this] call KPLIB_fnc_build_handleKeys";
    onKeyDown = "[true, _this] call KPLIB_fnc_build_handleKeys";

	class controlsBackground
	{
		class LeftPanel : RscText
		{
			idc = BUILD_PANEL_LEFT;
			x = PANEL_X;
			y = PANEL_Y;
			w = PANEL_W;
			h = PANEL_H;
			colorBackground[] = {0, 0, 0, 0.8};
		};

		class RightPanel : LeftPanel
		{
			idc = BUILD_PANEL_RIGHT;
			x = PANEL_RIGHT_X;
		};

		class LeftPanelHeader : RscText
		{
			idc = BUILD_PANEL_LEFT_HEADER;
			text = "Build Menu";
			x = PANEL_X;
			y = HEADER_Y;
			w = PANEL_W;
			h = HEADER_HEIGHT;
			colorBackground[] = TASKBAR_COLOR;
			style = ST_CENTER;
		};

		class RightPanelHeader : LeftPanelHeader
		{
			idc = BUILD_PANEL_RIGHT_HEADER;
			text = "Cart";
			x = PANEL_RIGHT_X;
		};

		class MouseHandler : RscControlsGroupNoScrollbars
		{
			idc = BUILD_MOUSE_TRACKER;
			x = safeZoneX;
			y = safeZoneY;
			w = safeZoneW;
			h = safeZoneH;
			onMouseHolding = "['onMouseHolding', _this] call KPLIB_fnc_build_handleMouse;";
			onMouseMoving = "['onMouseMoving', _this] call KPLIB_fnc_build_handleMouse;";
			onMouseButtonDown = "['onMouseButtonDown', _this] call KPLIB_fnc_build_handleMouse;";
			onMouseButtonUp = "['onMouseButtonUp', _this] call KPLIB_fnc_build_handleMouse;";
		};
	};

	class controls
	{
		class BuildMenuType : RscCombo
		{
			idc = BUILD_CATEGORY_IDC;
			x = PANEL_X;
			y = COMBO_Y;
			w = PANEL_W;
			h = COMBO_HEIGHT;
		};

		class BuildItemsList : RscListNBox
		{
			idc = BUILD_LIST_IDC;
			x = PANEL_X;
			y = LIST_Y;
			w = PANEL_W;
			h = LIST_H;
    		columns[] = {0, 0.65, 0.75, 0.85};
		};

		class CartItemsList : BuildItemsList
		{
			idc = BUILD_CART_IDC;
			x = PANEL_RIGHT_X;
		};

		class ButtonCancel : RscButtonMenuCancel
		{
			idc = BUILD_BUTTON_CANCEL;
			x = CALC_BUTTON(PANEL_RIGHT_END, 2);
			y = BUTTON_Y;
			w = BUTTON_WIDTH;
			h = BUTTON_HEIGHT;
			onButtonClick = "[] call KPLIB_fnc_build_end;";
		};

		class ButtonConfirm : RscButtonMenuOK
		{
			idc = BUILD_BUTTON_CONFIRM;
			x = CALC_BUTTON(PANEL_RIGHT_END, 1);
			y = BUTTON_Y;
			w = BUTTON_WIDTH;
			h = BUTTON_HEIGHT;
			text = "Confirm";
			onButtonClick = "[] call KPLIB_fnc_build_confirmBuild;";
		};
	};
};