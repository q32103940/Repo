--[[
special thanks to UWM8, Moones, Zynox, Sophylax
original thread http://www.zynox.net/forum/threads/1026-Get-mouse-position-do-mouse-click-at-another-position
]]

require("libs.ScriptConfig")
require("libs.Utils")


config = ScriptConfig.new()
config:Load()

worldpos= nil


--Stuff
local hero = {} local note = {} local reg = false local combo = false
local activ = true local draw = true local myhero = nil

local shft = client.screenSize.x/1680
  local F16 = drawMgr:CreateFont("F16","Calibri",16*shft,800*shft)
--Draw function


function Load()
	if PlayingGame() then
		local me = entityList:GetMyHero()
		
			reg = true
			myhero = me.classId
			script:RegisterEvent(EVENT_TICK,Tick)
			script:RegisterEvent(EVENT_KEY,Key)
			script:UnregisterEvent(Load)
		
	end
end

function Tick(tick)
	
  OOB= false
local mx = client.mouseScreenPosition.x
local my = client.mouseScreenPosition.y
 
 if client.mousePosition.x < 10000 then
	worldpos=client.mousePosition
	end

	if (mx < client.screenSize.x*0.4 or mx > client.screenSize.x-client.screenSize.x*0.4) and (my < client.screenSize.y*0.4 or my > client.screenSize.y-client.screenSize.y*0.4) then 
	OOB=true
	end
	
	if not SleepCheck() then return end	Sleep(100)
	local me = entityList:GetMyHero()	
	if not me then return end
	local ID = me.classId	
	if ID ~= myhero then GameClose() end
	
end

function Key(msg,code)
	if not PlayingGame() then return end
	local me = entityList:GetMyHero() if not me then return end
		if msg == RBUTTON_DOWN and OOB==true then
			entityList:GetMyPlayer().selection[1]:Move(worldpos)
		end
	

end


function GameClose()
	
	hero = {}
	myhero = nil
	combo = false
	collectgarbage("collect")
	if reg then
		script:UnregisterEvent(Tick)
		script:UnregisterEvent(Key)
		script:RegisterEvent(EVENT_TICK,Load)
		reg = false
	end
end

script:RegisterEvent(EVENT_CLOSE,GameClose)
script:RegisterEvent(EVENT_TICK,Load)
script:RegisterEvent(EVENT_KEY,Key)
