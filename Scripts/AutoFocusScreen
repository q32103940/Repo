require("libs.Utils")

local monitor     = client.screenSize.x/1600
local F14         = drawMgr:CreateFont("F14","Tahoma",14*monitor,550*monitor) 
--local debugText1  = drawMgr:CreateText(10*monitor,475*monitor,-1,"debug1",F14) debugText1.visible = true
--local debugText2  = drawMgr:CreateText(10*monitor,460*monitor,-1,"debug2",F14) debugText2.visible = true
--local debugText3  = drawMgr:CreateText(10*monitor,445*monitor,-1,"debug3",F14) debugText3.visible = true

local snapshotPos
local distMoved2D
local speed

function Tick(tick)
local me = entityList:GetMyHero()
		if me.alive and not (client.paused or me:IsChanneling()) then
			
			local myPos = {me.position.x,me.position.y}
			if not SleepCheck(main) then return end 
			
			if snapshotPos == nil then snapshotPos= myPos end
			distMoved2D = {math.abs(math.abs(myPos[1])-math.abs(snapshotPos[1])),math.abs(math.abs(myPos[2])-math.abs(snapshotPos[2]))}
			speed=(distMoved2D[1]^2+distMoved2D[2]^2)^0.5*10*0.745 --(arbitrary coefficient 0.745) 				if speed > 1400 and speed <10000 then 
				if speed>1350 and speed<10000 then --set low range to >1800 to disable force staff detection
				client:ExecuteCmd("+dota_camera_center_on_hero")
				client:ExecuteCmd("-dota_camera_center_on_hero")
				end
			
			--debugText3.text = "Speed:"..speed
			
		snapshotPos = {me.position.x,me.position.y}
		Sleep(100,main)
		end
end


function Load()
	
	
	if PlayingGame()  then
	if entityList:GetMyHero() == nil then return end
			reg = true
			script:RegisterEvent(EVENT_TICK,Tick)
			script:UnregisterEvent(Load)
		
	end
	end

function GameClose()

	collectgarbage("collect")
	if reg then
		script:UnregisterEvent(Tick)
		script:RegisterEvent(EVENT_TICK,Load)
		reg = false
		end
end

script:RegisterEvent(EVENT_CLOSE,GameClose)
script:RegisterEvent(EVENT_TICK,Load)
