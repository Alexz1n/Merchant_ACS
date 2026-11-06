local CK = GameMain:NewMod("载入自定义窗口")
local XS = GameMain:GetMod("按钮功能与实现")
local Adapter = GameMain:GetMod("Jai_HotkeyAdapter")

local dmax
local dmin
local day
local a = 1
local str
local str1
local str2
local sha ={}

-- Alterna a janela do ajudante (usado pela tecla P e pelo botao do adapter)
local function ToggleHelperWindow()
	if isShowing == true then
		fromA:Hide()
		isShowing = false
	else
		fromA:Show()
		isShowing = true
	end
end

function CK:registerWithAdapter()
	-- pega o mod de novo aqui, caso ele nao existisse quando o arquivo foi carregado
	local adp = Adapter or GameMain:GetMod("Jai_HotkeyAdapter")
	if adp == nil then
		return
	end
	local T = XT or function(s) return s end

	adp:register(T("显示辅助"), T("打开面板"),
		function()
			ToggleHelperWindow()
		end
	)
end

function CK:OnInit()
	fromA=GameMain:GetMod("Windows"):CreateWindow("窗体A")
	local DataA=UIPackage.CreateObject("Package1", "Component1")
	fromA.window.contentPane=DataA
	local closeButton=fromA:GetChild("frame"):GetChild("closeButton")
	closeButton.onClick:Add(closeButtonOn)
	HuitxtText=fromA:GetChild("n5"):GetChild("n10")
	HuitxteText=fromA:GetChild("n5"):GetChild("n3")
	XS:open()
	self:registerWithAdapter()
end

function XS:OnSave()--系统会将返回的table存档 table应该是纯粹的KV
	cs()
	sha[0] = CS.XiaWorld.TradeMgr.Instance.WalkTrader.KillTrader
	local tbSave = sha[0];
	return tbSave;
end

function CK:OnEnter()
	isShowing=true
	fromA:Hide();
	cs1()
	sjxz()
end

function CK:OnLoad(tbLoad)
	cs1()
	sjxz()
	sha[0] = tbLoad;
end

function closeButtonOn()
	isShowing=false
end

function CK:OnSetHotKey()
	
	local KeyInfo = { {ID = "P" , Name = "显示辅助" , Type = "Mod", InitialKey1 = "P" , InitialKey2 = "Equals" } };
	return KeyInfo;
	
end

function cs()
local file = io.open("cd.txt","w")
file:write(CS.XiaWorld.WalkTraderData.NextComeDay_Min)
file:write("\n")
file:write(CS.XiaWorld.WalkTraderData.NextComeDay_Max)
file:write("\n")
file:write(CS.XiaWorld.WalkTraderData.FirstComeDay)
file:write("\n")
if CS.XiaWorld.WalkTraderData.WalkTradeStaySec == 0 then
	CS.XiaWorld.WalkTraderData.WalkTradeStaySec = 601
	file:write(CS.XiaWorld.WalkTraderData.WalkTradeStaySec)
else
	file:write(CS.XiaWorld.WalkTraderData.WalkTradeStaySec)
end
file:write("\n")
file:write(CS.XiaWorld.TradeMgr.Instance.default_walkdef.AllRandomCount)
file:write("\n")
file:close()
local file1=io.input("cd.txt")
local str=io.read("*l")
local str1=io.read("*l")
local str2=io.read("*l")
--print(str)
--print(str1)
--print(str2)
end

function cs1()
local file1=io.input("cd.txt")
local str=io.read("*l")
local str1=io.read("*l")
local str2=io.read("*l")
local a=io.read("*l")
local b=io.read("*l")
local sha=io.read("*l")
CS.XiaWorld.WalkTraderData.NextComeDay_Min = str
CS.XiaWorld.WalkTraderData.NextComeDay_Max = str1
CS.XiaWorld.WalkTraderData.FirstComeDay = str2
CS.XiaWorld.WalkTraderData.WalkTradeStaySec = a
CS.XiaWorld.TradeMgr.Instance.default_walkdef.AllRandomCount = b
--CS.XiaWorld.TradeMgr.Instance.WalkTrader.KillTrader = 0
sjxz()
--print(str)
--print(str1)
--print(str2)
end

function sjxz()
	if CS.XiaWorld.WalkTraderData.WalkTradeStaySec == 0 then
	CS.XiaWorld.WalkTraderData.WalkTradeStaySec = 601
	end
end

function wp()
	if CS.XiaWorld.WalkTraderData.WalkTradeStaySec == 600 then
	CS.XiaWorld.ThingMgr.Instance:AddItemThing(520,"Item_LingStone",map,888,true)
	end
end
function wp1()
	CS.XiaWorld.ThingMgr.Instance:AddItemThing(520,"Item_LingStone",map,1000,true)
	HuitxteText.text="刷出"..a.."次灵石"
	a=a+1
end

function shanchu()
	local thing=CS.WorldLuaHelper():GetSelectThing()
	--local me=thing.LuaHelper
	if thing ~= nil then
	CS.XiaWorld.ThingMgr.Instance:RemoveThing(thing,true,true)
	--print(thing)
	HuitxteText.text="canceled"
	else
	HuitxteText.text="choose target"
	end
end
function CK:OnHotKey(ID,state)
	HuitxtText.text=" "
	if ID == "P" and state == "down" then
		ToggleHelperWindow()
	end
end

function XS:open()
	
	local list=fromA:GetChild("n3")
	
	local item = list:AddItemFromPool();
	item.title="tomorrow";
	local item = list:AddItemFromPool();
	item.title="10days";
	local item = list:AddItemFromPool();
	item.title="20days";
	local item = list:AddItemFromPool();
	item.title="30days";
	local item = list:AddItemFromPool();
	item.title="Vanilla";
	local item = list:AddItemFromPool();	
	item.title = "custom";
	local item = list:AddItemFromPool();	
	item.title = "Call2";
	local item = list:AddItemFromPool();	
	item.title = "Range";
	local item = list:AddItemFromPool();
	item.title = "more items";
	local item = list:AddItemFromPool();
	item.title = "reset goods";
	local item = list:AddItemFromPool();
	item.title = "call";
	local item = list:AddItemFromPool();
	item.title = "cancel";
	local item = list:AddItemFromPool();
	item.title = "Group";
	if CS.XiaWorld.WalkTraderData.FirstComeDay == 19 then
	local item = list:AddItemFromPool();
	item.title = "easter egg";
	end
	list.onClickItem:Add(ClickList);

end

function ClickList(context)
	local txt=context.data.title
	if txt=="tomorrow" then
	dmax = 1
	dmin = 1
	day = 20
	CS.XiaWorld.WalkTraderData.NextComeDay_Min = dmax
	CS.XiaWorld.WalkTraderData.NextComeDay_Max = dmin
	CS.XiaWorld.WalkTraderData.FirstComeDay = day
	HuitxteText.text="tomorrow"
	elseif txt=="10days" then
	dmax = 10
	dmin = 1
	day = 20
	CS.XiaWorld.WalkTraderData.NextComeDay_Min = dmin
	CS.XiaWorld.WalkTraderData.NextComeDay_Max = dmax
	CS.XiaWorld.WalkTraderData.FirstComeDay = day
	HuitxteText.text="Merchant arrives in 1-10days"
	elseif txt=="20days" then
	dmax = 20
	dmin = 10
	day = 20
	CS.XiaWorld.WalkTraderData.NextComeDay_Min = dmin
	CS.XiaWorld.WalkTraderData.NextComeDay_Max = dmax
	CS.XiaWorld.WalkTraderData.FirstComeDay = day
	HuitxteText.text="Merchant arrives in 10~20days"
	elseif txt=="30days" then
	dmax = 30
	dmin = 10
	day = 20
	CS.XiaWorld.WalkTraderData.NextComeDay_Min = dmin
	CS.XiaWorld.WalkTraderData.NextComeDay_Max = dmax
	CS.XiaWorld.WalkTraderData.FirstComeDay = day
	HuitxteText.text="Merchant arrives in 10~30days"
	elseif txt=="Vanilla" then
	dmax = 40
	dmin = 10
	day = 20
	CS.XiaWorld.WalkTraderData.NextComeDay_Min = dmin
	CS.XiaWorld.WalkTraderData.NextComeDay_Max = dmax
	CS.XiaWorld.WalkTraderData.FirstComeDay = day
	HuitxteText.text="Merchant arrives in 10~40days"
	elseif txt=="more items" then
	CS.XiaWorld.TradeMgr.Instance.default_walkdef.AllRandomCount=10000
	HuitxteText.text="A large number of items were modified successfully"
	elseif txt=="reset goods" then
	CS.XiaWorld.TradeMgr.Instance.default_walkdef.AllRandomCount=6
	HuitxteText.text="reset goods successful"
	elseif txt=="Call2" then
	local sj=CS.WorldLuaHelper().DaySecond
	CS.XiaWorld.TradeMgr.Instance.WalkTrader:AddTraderNpc(tostring(sj))
	elseif txt=="Range" then
	HuitxteText.text="Arrvial in:"..CS.XiaWorld.WalkTraderData.NextComeDay_Min.."~"..CS.XiaWorld.WalkTraderData.NextComeDay_Max.."day(s)"
	elseif txt=="cancel" then
	shanchu()
	elseif txt=="call" then
	CS.XiaWorld.TradeMgr.Instance.WalkTrader.KillTrader = 0
	local sj=CS.WorldLuaHelper().DaySecond
	CS.XiaWorld.TradeMgr.Instance.WalkTrader:AddTraderNpc(tostring(sj))
	elseif txt=="Group" then
	HuitxteText.text="交流QQ群：261811872"
		if CS.XiaWorld.WalkTraderData.WalkTradeStaySec == 600 then
			wp()
			BOX("Surprise below the map :）")
			CS.XiaWorld.WalkTraderData.WalkTradeStaySec = 601
			--print("2")
		elseif HuitxtText.text=="Happy" then
			CS.XiaWorld.WalkTraderData.FirstComeDay = 19
			BOX("Cheats entered successfully ）")
			--print("3")
		else
			HuitxteText.text="交流QQ群：261811872"
			--print("1")
		end
	elseif txt=="easter egg" then
		wp1()
	elseif txt=="custom" then 
		
		if HuitxtText.text=="" then
			BOX("Please enter content in the yellow box")
			HuitxteText.text="Please enter a custom time frame"
		else
			dmax = tonumber(HuitxtText.text)
			dmin = tonumber(HuitxtText.text)
			day = 20
			CS.XiaWorld.WalkTraderData.NextComeDay_Min = dmin
			CS.XiaWorld.WalkTraderData.NextComeDay_Max = dmax
			CS.XiaWorld.WalkTraderData.FirstComeDay = day
		end
	end
	HuitxtText.text=""


end

function BOX(text)

	CS.WorldLuaHelper():ShowMsgBox(text,"alert")
end
