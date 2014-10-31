require("libs.Utils")

local ignoreSelfInitiation = true
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
				if speed>1350 and speed<10000 and not SelfInitiated() then --set low range to >1800 to disable force staff detection
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

function SelfInitiated()

if not ignoreSelfInitiation then  
return false end

local me = entityList:GetMyHero()
local blinkDagger = me:FindItem("item_blink")

if me:DoesHaveModifier("modifier_storm_spirit_ball_lightning") then 
	--debugText1.text= "ball lightning detected" 
	return true end 

if me.name == "npc_dota_hero_rubick" or me.name ==  "npc_dota_hero_faceless_void" or me.name ==  "npc_dota_hero_shredder" or  me.name == "npc_dota_hero_phoenix" or  me.name == "pc_dota_hero_antimage" or  me.name == "npc_dota_hero_mirana" or me.name ==  "npc_dota_hero_earth_spirit" or  me.name == "npc_dota_hero_chaos_knight" or  me.name == "npc_dota_hero_morphling" or  me.name == "npc_dota_hero_vengefulspirit" or  me.name == "npc_dota_hero_phantom_assassin" or  me.name == "npc_dota_hero_riki" or  me.name == "npc_dota_hero_weaver" or  me.name == "npc_dota_hero_sand_king" or me.name ==  "npc_dota_hero_queenofpain" or me.name == "npc_dota_hero_storm_spirit" then  
	for t = 1, 6 do 
		if me:GetAbility(t) and me:GetAbility(t).level > 0 then	
			
			if me:GetAbility(t).name == "faceless_void_time_walk" or  me:GetAbility(t).name == "shredder_timber_chain" or  me:GetAbility(t).name == "phoenix_icarus_dive" or  me:GetAbility(t).name == "antimage_blink" or  me:GetAbility(t).name == "mirana_leap" or  me:GetAbility(t).name == "earth_spirit_rolling_boulder" or me:GetAbility(t).name ==  "chaos_knight_reality_rift" or  me:GetAbility(t).name == "morphling_waveform" or  me:GetAbility(t).name == "vengefulspirit_nether_swap" or  me:GetAbility(t).name == "phantom_assassin_phantom_strike" or  me:GetAbility(t).name == "riki_blink_strike" or  me:GetAbility(t).name == "weaver_time_lapse" or  me:GetAbility(t).name == "sandking_burrowstrike" or  me:GetAbility(t).name == "queenofpain_blink" or me:GetAbility(t).name == "storm_spirit_ball_lightning" then 
				if (math.ceil(me:GetAbility(t).cd) > 0 and math.ceil(me:GetAbility(t).cd - 0.1) ==  math.ceil(me:GetAbility(t):GetCooldown(me:GetAbility(t).level))) then 
					--debugText1.text= "ability detected"
					return true
				end
			end
		end
	end
end


if blinkDagger ~= nil and blinkDagger.cd > 11.85 then
--debugText1.text= "blink detected"
return true
end	
--debugText1.text= "Execute AutoFocusScreen"
return false	
end

script:RegisterEvent(EVENT_CLOSE,GameClose)
script:RegisterEvent(EVENT_TICK,Load)
