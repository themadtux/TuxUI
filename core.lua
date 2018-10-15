local E, L, V, P, G = unpack(ElvUI);
local TXUI = E:NewModule('TuxUI', "AceHook-3.0", "AceEvent-3.0", "AceTimer-3.0");

local LSM = LibStub('LibSharedMedia-3.0')
local EP = LibStub('LibElvUIPlugin-1.0')
local addon, ns = ...

local _G = _G
local pairs, print = pairs, print
local format = string.format
local GetAddOnMetadata = GetAddOnMetadata
local GetAddOnEnableState = GetAddOnEnableState

V['tuxui'] = {}
P['tuxui'] = {}

TXUI.Config = {}
TXUI.Title = format('|cff00c0fa%s |r', 'TuxUI')
TXUI.Version = GetAddOnMetadata('ElvUI_TuxUI', 'Version')

function TXUI:IsAddOnEnabled(addon)
	return GetAddOnEnableState(E.myname, addon) == 2
end

-- Check other addons
TXUI.AS = TXUI:IsAddOnEnabled('AddOnSkins')
TXUI.BU = TXUI:IsAddOnEnabled('ElvUI_BenikUI')
TXUI.DT = TXUI:IsAddOnEnabled('ElvUI_DTBars2')
TXUI.CT = TXUI:IsAddOnEnabled('ElvUI_CustomTweaks')
TXUI.VAT = TXUI:IsAddOnEnabled('ElvUI_VisualAuraTimers')

LSM:Register('font', 'MelloUI Club', [[Interface\AddOns\ElvUI_TuxUI\media\fonts\CLUB____.ttf]])
LSM:Register('font', 'MelloUI Tukui UnitFrame', [[Interface\AddOns\ElvUI_TuxUI\media\fonts\uf_font.ttf]])
LSM:Register('font', 'MelloUI Forced Square', [[Interface\AddOns\ElvUI_TuxUI\media\fonts\FORCED_SQUARE.ttf]])

local function PrintURL(url)
	return format("|cFF00c0fa[|Hurl:%s|h%s|h]|r", url, url)
end

function TXUI:Initialize()

	-- run install when ElvUI install finishes
	if E.private.install_complete == E.version and E.db.tuxui.installed == nil then
		E:GetModule("PluginInstaller"):Queue(TXUI.installTable)
	end

	-- run the setup again when a profile gets deleted.
	local profileKey = ElvDB.profileKeys[E.myname..' - '..E.myrealm]
	if ElvDB.profileKeys and profileKey == nil then
		E:GetModule("PluginInstaller"):Queue(TXUI.installTable)
	end

	EP:RegisterPlugin(addon, self.ConfigTable)
	print('TuxUI Loaded')
end

local function InitializeCallback()
	TXUI:Initialize()
end

E:RegisterModule(TXUI:GetName(), InitializeCallback)