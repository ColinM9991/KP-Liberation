/*
    File: defines.hpp
    Author: KP Liberation Dev Team - https://github.com/KillahPotatoes
    Date: 2026-01-20
    Last Update: 2026-01-30
    License: MIT License - http://www.opensource.org/licenses/MIT
    
    Description:
        No description added yet.
*/
#include "defines.hpp"

// Component dimensions
#define BUTTON_WIDTH (20 * GRID_W)
#define BUTTON_HEIGHT (5 * GRID_H)
#define HEADER_HEIGHT (5 * GRID_H)
#define COMBO_HEIGHT (5 * GRID_H)
#define TEXT_HEIGHT (10 * GRID_H)
#define SPACING (2 * GRID_H)
#define ITEM_INFORMATION_HEIGHT (15 * GRID_H)

// Panel dimensions
#define VERTICAL_OFFSET 5
#define HORIZONTAL_OFFSET 8
#define PANEL_W (80 * GRID_W)
#define PANEL_H (safeZoneH - (VERTICAL_OFFSET * 2) * GRID_H)
#define MIDDLE_X (BUILD_GROUP_X + PANEL_W)
#define MIDDLE_W ((CART_GROUP_X - MIDDLE_X) - pixelW)

#define BUILD_GROUP_X (safeZoneX + HORIZONTAL_OFFSET * GRID_W)
#define CART_GROUP_X (safeZoneX + safeZoneW - PANEL_W - HORIZONTAL_OFFSET * GRID_W)
#define HEADER_Y (safeZoneY + VERTICAL_OFFSET * GRID_H)

#define GROUP_Y HEADER_Y + HEADER_HEIGHT
#define GROUP_H PANEL_H - HEADER_HEIGHT

// Relative positioning in group
#define BUILD_LIST_Y COMBO_HEIGHT
#define BUILD_LIST_H GROUP_H - COMBO_HEIGHT - ITEM_INFORMATION_HEIGHT
#define CART_LIST_H (GROUP_H - BUTTON_HEIGHT - SPACING)
#define BUTTON_Y (CART_LIST_H + SPACING)
#define SECTOR_INFO_Y (BUILD_LIST_Y + BUILD_LIST_H + ((ITEM_INFORMATION_HEIGHT - TEXT_HEIGHT) / 2))

#define CALC_BUTTON(REL, IDX) (REL - (BUTTON_WIDTH * IDX) - (SPACING * IDX))

class RscBuildDialog
{
	idd = -1;
	movingEnable = 0;

	onLoad = "call KPLIB_fnc_build_onDisplayLoad;";
    onKeyDown = "[true, _this] call KPLIB_fnc_build_handleKeys";

	class controlsBackground
	{
		class MouseHandler : RscStructuredText
		{
			idc = -1;
			x = safeZoneX;
			y = safeZoneY;
			w = safeZoneW;
			h = safeZoneH;
			onMouseMoving = "['onMouseMoving', _this] call KPLIB_fnc_build_handleMouse;";
			onMouseButtonDown = "['onMouseButtonDown', _this] call KPLIB_fnc_build_handleMouse;";
			onMouseButtonUp = "['onMouseButtonUp', _this] call KPLIB_fnc_build_handleMouse;";
			onMouseEnter = "['onMouseEnter', _this] call KPLIB_fnc_build_handleMouse;";
			onMouseExit = "['onMouseExit', _this] call KPLIB_fnc_build_handleMouse;";
			colorBackground[] = {0, 0, 0, 0};
		};

		class ResourcesInformation : RscStructuredText {
			idc = BUILD_HEADER_RESOURCES;
			x = MIDDLE_X;
			y = HEADER_Y;
			w = MIDDLE_W;
			h = HEADER_HEIGHT;
			colorBackground[] = {0, 0, 0, 0.5};

			class Attributes {
				align = "center";
			}
		};
	};

	class controls
	{
		class LeftPanelHeader : RscButton
		{
			idc = BUILD_PANEL_LEFT_HEADER;
			text = "Build";
			x = BUILD_GROUP_X;
			y = HEADER_Y;
			w = PANEL_W;
			h = HEADER_HEIGHT;
			onButtonClick = "[_this select 0, 3000] call KPLIB_fnc_build_togglePanel;";
		};

		class RightPanelHeader : RscButton
		{
			idc = BUILD_PANEL_RIGHT_HEADER;
			text = "Cart";
			x = CART_GROUP_X;
			y = HEADER_Y;
			w = PANEL_W;
			h = HEADER_HEIGHT;
			onButtonClick = "[_this select 0, 4000] call KPLIB_fnc_build_togglePanel;";
		};

		class LeftPanel : RscControlsGroupNoScrollbars
		{
			idc = BUILD_PANEL_LEFT;
			x = BUILD_GROUP_X;
			y = GROUP_Y;
			w = PANEL_W;
			h = GROUP_H;

			class controls {
				class LeftPanel : RscText
				{
					idc = -1;
					x = 0;
					y = 0;
					w = PANEL_W;
					h = GROUP_H;
					colorBackground[] = {0, 0, 0, 0.25};
				};

				class SectorText : RscStructuredText {
					idc = BUILD_PANEL_LEFT_SECTOR_INFORMATION;
					x = 0;
					y = SECTOR_INFO_Y;
					w = PANEL_W;
					h = TEXT_HEIGHT;
					class Attributes
					{
						align = "center";
					};
				};

				class BuildMenuType : RscCombo
				{
					idc = BUILD_CATEGORY_IDC;
					x = 0;
					y = 0;
					w = PANEL_W;
					h = COMBO_HEIGHT;
				};

				class BuildItemsList : RscListNBox
				{
					idc = BUILD_LIST_IDC;
					x = 0;
					y = BUILD_LIST_Y;
					w = PANEL_W;
					h = BUILD_LIST_H;
					idcLeft = 999; // Bug with ListNBox which hides controls if this IDC matches any other control IDC
					idcRight = 999; // Bug with ListNBox which hides controls if this IDC matches any other control IDC
					columns[] = {0, 0.65, 0.75, 0.85};
				};
			}
		};

		class RightPanel : RscControlsGroupNoScrollbars
		{
			idc = BUILD_PANEL_RIGHT;
			x = CART_GROUP_X;
			y = GROUP_Y;
			w = PANEL_W;
			h = GROUP_H;

			class controls {
				class RightPanel : RscText
				{
					idc = -1;
					x = 0;
					y = 0;
					w = PANEL_W;
					h = GROUP_H;
					colorBackground[] = {0, 0, 0, 0.25};
				};

				class CartItemsList : RscListNBox
				{
					idc = BUILD_CART_IDC;
					x = 0;
					y = 0;
					w = PANEL_W;
					h = CART_LIST_H;
					idcLeft = 999; // Bug with ListNBox which hides controls if this IDC matches any other control IDC
					idcRight = 999; // Bug with ListNBox which hides controls if this IDC matches any other control IDC
					columns[] = {0, 0.65, 0.75, 0.85};
				};

				class ButtonCancel : RscButtonMenuCancel
				{
					idc = BUILD_BUTTON_CANCEL;
					x = CALC_BUTTON(PANEL_W, 2);
					y = BUTTON_Y;
					w = BUTTON_WIDTH;
					h = BUTTON_HEIGHT;
					onButtonClick = "[] call KPLIB_fnc_build_end;";
				};

				class ButtonConfirm : RscButtonMenuOK
				{
					idc = BUILD_BUTTON_CONFIRM;
					x = CALC_BUTTON(PANEL_W, 1);
					y = BUTTON_Y;
					w = BUTTON_WIDTH;
					h = BUTTON_HEIGHT;
					text = "Confirm";
					onButtonClick = "[] call KPLIB_fnc_build_confirmBuild;";
				};
			}
		};
	};
};