--use blink dagger to your cursor when you click or hold mouse wheel button.

require("libs.Utils")

local active=false

function Tick(tick)
	
 
	if active==true then UseBlinkDagger() end
	
	if not SleepCheck() then return end	Sleep(10)
	local me = entityList:GetMyHero()	
	if not me then return end
	local ID = me.classId	
	if ID ~= myhero then GameClose() end
	
end

function Key(msg,code)
	if not PlayingGame() then return end
	local me = entityList:GetMyHero() if not me then return end
		if msg == MBUTTON_DOWN then
		active=true
		else 
		active=false
				end
	

end

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


function GameClose()
	
	combo = false	collectgarbage("collect")
	if reg then
		script:UnregisterEvent(Tick)
		script:UnregisterEvent(Key)
		script:RegisterEvent(EVENT_TICK,Load)
		reg = false
	end
end


function UseBlinkDagger()
	local me = entityList:GetMyHero()
local BlinkDagger = me:FindItem("item_blink")
if BlinkDagger ~= nil and BlinkDagger.cd == 0 then

me:CastItem(BlinkDagger.name,client.mousePosition)

end

end


script:RegisterEvent(EVENT_CLOSE,GameClose)
script:RegisterEvent(EVENT_TICK,Load)
script:RegisterEvent(EVENT_KEY,Key)




