-- work in progress lua
--by Silencer

require("keydown")
require("customrenderer")



client.notify("Injecting...")




--flick 1, flick 2, flick 3

--login system:

local val=60
local MAX_CHOKE=14
--local flicktick=54
local flick=0
local side=180
local pitch = 90
local screen_size = engine.get_screen_size()

local tahoma_bold = renderer.setup_font("C:/windows/fonts/tahomabd.ttf", 50, 0)
local prev_angle=0
local yawanglenumb=0
local lastflick=0
local modangles=0
local ticknumb=32
local ticknumb2=16
local ticknumb3=8


--Main Menu shit

local tabselect = ui.add_combo_box("[Cumgambit]>>>Tab", "tabselect",{"Main", "AntiAim", "Misc/Visuals", "Advanced settings"}, 0)

local cumgambitcheckbox = ui.add_check_box(">>> [Cumgambit]", "cumgambitcheckbox", true)
local version = ui.add_check_box(">>> [Version 1.2]", "version", true)
local changelog = ui.add_check_box(">>> [Change log]", "changelog", true)
local discord = ui.add_check_box(">>> [Discord (to be announced)]", "discord", false)



--aa stuff (to be cleaned up)
local raamaster = ui.add_check_box("Rising sun AA", "raamaster", false)
local antibrute = ui.add_check_box("Antibrute random", "antibrute", false)
local _180treehouse = ui.add_check_box("180树屋", "_180treehouse", false)
local antiprevangle = ui.add_check_box("Anti previous angle", "antiprevangle", false)
local apat = ui.add_slider_int("Anti Previous angle threshold", "apat",0,180,25)
local left_side = ui.add_key_bind("Left", "left_side", 0, 1)
local right_side = ui.add_key_bind("Right", "right_side", 0, 1)


local chockonsafe = ui.add_check_box("Choke lag on safe angle", "chockonsafe", false)

local randc = ui.add_check_box("Random Choke", "randc", false)


--choke on safe safe side
local consss = ui.add_slider_int("Safe side choke value", "consss", 0,16,16)
--choke on safe unsafe side
local consus = ui.add_slider_int("Unsafe side choke value", "consus", 0,16,4)


--anti previous angle threshold


local toflick = ui.add_check_box("Flick 1", "toflick", false)
local toflick2 = ui.add_check_box("Flick 2", "toflick2", false)
local toflick3 = ui.add_check_box("Flick 3", "toflick3", false)

local upflick = ui.add_check_box("Up flick on tick", "upflick", false)
local randtick = ui.add_check_box("Flick on random tick", "randtick", false)

local flicktick = ui.add_slider_int("Flick tick", "flicktick", 1, 64, 54)

--visuals stuff (to be cleaned up)

local thirdperson_distance_enable = ui.add_check_box("Thirdperson Distance", "thirdperson_distance_enable", false)
local thirdperson_distance_value = ui.add_slider_int("Value", "thirdperson_distance_value", 0, 250, 100)

local animclantag = ui.add_check_box("Animated clantag", "animclantag", false)
local tagpick = ui.add_combo_box("Clantag type", "tagpickkey", {"cumgambit on top", "cumgabit typing", "default", "180树屋"}, 2)
local visclantag = ui.add_check_box("Visualize clantag for client", "visclantag", false)

--watermark ui stuff
local wmcheck = ui.add_check_box("Watermark", "wmcheck", true)
local ctecheck = ui.add_check_box("Custom text effect", "ctecheck", true)
local wmcolor = ui.add_color_edit("Watermark background color", "wmcolor", true, color_t.new(255,255,255,100))
local crtc1 = ui.add_color_edit("Color 1", "crtc1", true, color_t.new(0, 153, 51, 255))
local crtc2 = ui.add_color_edit("Color 2", "crtc2", true, color_t.new(51,204,255,255))
local debuginfo = ui.add_check_box("Show debug numbers", "debuginfo", false)

-- Advanced options stuff
--antibrute advanced angle threshold
local abaat = ui.add_slider_int("antibrute max random angle threshold","abaat", 0,180,60)

--Anti previous angles angle threshold
local apaat = ui.add_slider_int("Anti previous angles max randomm angle threshold","apaat",0,180,15)

local flicktick2 = ui.add_slider_int("Flick 2 tick", "fliicktick2",1,64)
local flicktick3 = ui.add_slider_int("Flick 3 tick", "flicktick3", 1,64)

--local exampleslider = ui.add_slider_int("lable", "exampleslider", 0, 64, 54)
--"lable, key, min, max, set"


--menu shit

function tab_selection_function()
    if tabselect:get_value()~=0 then
        cumgambitcheckbox:set_visible(false)
        version:set_visible(false)
        changelog:set_visible(false)
        discord:set_visible(false)
    else

        cumgambitcheckbox:set_visible(true)
        version:set_visible(true)
        changelog:set_visible(true)
        discord:set_visible(true)
    end

    if tabselect:get_value()~=1 then
        raamaster:set_visible(false)
        antibrute:set_visible(false)
        _180treehouse:set_visible(false)
        chockonsafe:set_visible(false)
        antiprevangle:set_visible(false)
        consss:set_visible(false)
        consus:set_visible(false)
        randc:set_visible(false)
        apat:set_visible(false)
        left_side:set_visible(false)
        right_side:set_visible(false)
        toflick:set_visible(false)
        toflick2:set_visible(false)
        toflick3:set_visible(false)
        upflick:set_visible(false)
        randtick:set_visible(false)
        flicktick:set_visible(false)
    else
        raamaster:set_visible(true)
        antibrute:set_visible(true)
        _180treehouse:set_visible(true)
        chockonsafe:set_visible(true)
        antiprevangle:set_visible(true)
        consss:set_visible(true)
        consus:set_visible(true)
        randc:set_visible(true)
        apat:set_visible(true)
        left_side:set_visible(true)
        right_side:set_visible(true)
        toflick:set_visible(true)
        toflick2:set_visible(true)
        toflick3:set_visible(true)
        upflick:set_visible(true)
        randtick:set_visible(true)
        flicktick:set_visible(true)
    end

    if tabselect:get_value()~=2 then
        thirdperson_distance_enable:set_visible(false)
        thirdperson_distance_value:set_visible(false)
        debuginfo:set_visible(false)
        animclantag:set_visible(false)
        tagpick:set_visible(false)
        visclantag:set_visible(false)
        wmcheck:set_visible(false)
        ctecheck:set_visible(false)
        wmcolor:set_visible(false)
        crtc1:set_visible(false)
        crtc2:set_visible(false)
    else
        thirdperson_distance_enable:set_visible(true)
        thirdperson_distance_value:set_visible(true)
        debuginfo:set_visible(true)
        animclantag:set_visible(true)
        tagpick:set_visible(true)
        visclantag:set_visible(true)
        wmcheck:set_visible(true)
        ctecheck:set_visible(true)
        wmcolor:set_visible(true)
        crtc1:set_visible(true)
        crtc2:set_visible(true)
    end
  
    if tabselect:get_value()~=3 then
        abaat:set_visible(false)
        apaat:set_visible(false)
        flicktick2:set_visible(false)
        flicktick3:set_visible(false)
    else
        abaat:set_visible(true)
        apaat:set_visible(true)
        flicktick2:set_visible(true)
        flicktick3:set_visible(true)
    end

end

client.register_callback("paint", tab_selection_function)


--print(64-(globalvars.get_tick_count()%64))

local localplayer = entitylist.get_local_player()
--rising sun AA
client.register_callback("create_move", function(cmd) 
    if engine.is_in_game() and localplayer:is_alive() and not(localplayer:is_dormant()) then
        if tostring(client.is_key_pressed(0x45))=="false" and tostring(client.is_key_pressed(0x1))=="false" then
            -- pitch down

            pitch = 0
            -- backwards
            ui.get_combo_box("antihit_antiaim_pitch"):set_value(1)
            if left_side:is_active() then
                side=180
            end

            if right_side:is_active() then
                side=0
            end


            if raamaster:get_value() then
                if val<170 then
                    val = val + 1
                    --local antiaim_yaw = ui.get_slider_int("antihit_antiaim_yaw_jitter")
                    --antiaim_yaw:set_value(val-80)
                else
                    val=80
                end


                -- Flick shit... 
                -- basically rinse and repeat 3 times for each flick request

                if toflick:get_value() then 
                    if (64-(globalvars.get_tick_count()%64))/ ticknumb == 1 then
                        if randtick:get_value() then
                            local ticknumb=math.random(1,64)
                            print(ticknumb)
                        else 
                            local ticknumb=flicktick:get_value()
                        end

                        flick=-180+math.random(-30,30)
                        ticknumb=math.random(0,64)
                        --print("tick: "..tostring((64-(globalvars.get_tick_count()%64))))
                        --print("flicking: "..tostring(flick))
                        if upflick:get_value() then
                            ui.get_combo_box("antihit_antiaim_pitch"):set_value(3)
                        else
                            ui.get_combo_box("antihit_antiaim_pitch"):set_value(1)
                        end

                    else
                        --ui.get_combo_box("antihit_antiaim_pitch"):set_value(1)
                        flick=0
                    end
                end

                if toflick2:get_value() then                        

                    if (64-(globalvars.get_tick_count()%64))/ ticknumb2 == 1 then

                        if (randtick:get_value()) then
                            local ticknumb2=math.random(1,64)
                        else 
                            local ticknumb2=flicktick:get_value()
                        end

                        flick=-180+math.random(-30,30)
                        ticknumb=math.random(0,64)
                        --print("tick: "..tostring((64-(globalvars.get_tick_count()%64))))
                        --print("flicking: "..tostring(flick))
                        if upflick:get_value() then
                            ui.get_combo_box("antihit_antiaim_pitch"):set_value(3)
                        else
                            ui.get_combo_box("antihit_antiaim_pitch"):set_value(1)
                        end

                    else
                        --ui.get_combo_box("antihit_antiaim_pitch"):set_value(1)
                        flick=0
                    end
                end
                
                if toflick3:get_value() then

                        

                    if (64-(globalvars.get_tick_count()%64))/ ticknumb3 == 1 then
                        if (randtick:get_value()) then
                            local ticknumb3=math.random(1,64)
                        else 
                            local ticknumb3=flicktick:get_value()

                        end
                        flick=-180+math.random(-30,30)
                        ticknumb=math.random(0,64)
                        --print("tick: "..tostring((64-(globalvars.get_tick_count()%64))))
                        --print("flicking: "..tostring(flick))
                        if upflick:get_value() then
                            ui.get_combo_box("antihit_antiaim_pitch"):set_value(3)
                        else
                            ui.get_combo_box("antihit_antiaim_pitch"):set_value(1)
                        end

                    else
                        --ui.get_combo_box("antihit_antiaim_pitch"):set_value(1)
                        flick=0
                    end
                end





                if antibrute:get_value() then
                    -- og numbers: -90,90
                    antibruteangle=math.random(-(abaat:get_value()),abaat:get_value())
                else
                    antibruteangle=0
                end
                modangles = (val + side + antibruteangle)+flick
                yawanglenumb=(cmd.viewangles.yaw + val+side +antibruteangle)+flick

                if antiprevangle:get_value() and yawanglenumb<prev_angle+(apat:get_value()) and yawanglenumb>prev_angle-(apat:get_value()) then
                    -- og numbers: -15,15
                    yawanglenumb=yawanglenumb+math.random(-(apaat:get_value()),apaat:get_value())
                else
                    prev_angle=yawanglenumb
                end

                --cmd.viewangles.yaw = yawanglenumb
                --lag stuff
                if chockonsafe:get_value() then
                    if side==0 and (modangles<180 and modangles>0) then   
                        ui.get_slider_int("antihit_fakelag_limit"):set_value(consss:get_value())
                    elseif side==180 and (modangles<360 and modangles>180) then
                        ui.get_slider_int("antihit_fakelag_limit"):set_value(consss:get_value())
                    else
                        if randc:get_value() then
                            ui.get_slider_int("antihit_fakelag_limit"):set_value(math.random(1,16))
                        else
                            ui.get_slider_int("antihit_fakelag_limit"):set_value(consus:get_value())
                        end
                    end
                end

                --basicall nulls every previous calculationn but its still fun
                if _180treehouse:get_value() then
                    yawanglenumb=(math.random(0,32767))
                end
                cmd.viewangles.yaw = yawanglenumb

            end
            cmd.viewangles.pitch=pitch
        else
            cmd.viewangles.pitch=cmd.viewangles.pitch
            cmd.viewangles.yaw=cmd.viewangles.yaw
        end

        -- fakelag
        --cmd.send_packet = clientstate.get_choked_commands() >= MAX_CHOKE
    end 
end)

--aa renderer
local tahoma_bold = renderer.setup_font("C:/windows/fonts/tahomabd.ttf", 50, 0)

--text, font, positoin, size, color


local size=25
local font=tahoma_bold

function caltextsize(text)
    return(renderer.get_text_size(font, size, text))
end


--screen drawing shit
local function on_paint()

    --taken from endless.lua...
    if thirdperson_distance_enable:get_value() == true then
        local distance = thirdperson_distance_value:get_value()
        se.get_convar("c_mindistance"):set_int(distance)
        se.get_convar("c_maxdistance"):set_int(distance)
    end     


    --[[
    removed due to bugs with tab selection :(
    if randtick:get_value() then
        flicktick:set_visible(false)
    else
        flicktick:set_visible(true)
    end
    ]]--
    if engine.is_in_game() then


        breh=caltextsize(">")
        breh2=caltextsize("<")

        if side==0 then
            renderer.text(">", tahoma_bold, vec2_t.new((screen_size.x/2)-(breh.x/2)+25, (1080/2)-15), 25, color_t.new(255, 255, 255, 255))
        else 
            renderer.text("<", tahoma_bold, vec2_t.new((screen_size.x/2)-(breh2.x/2)-25, (1080/2)-15), 25, color_t.new(255, 255, 255, 255))
        end

        if debuginfo:get_value() then
            modtext="Mod: "..tostring(side)
            modtextsize=caltextsize(modtext)
            renderer.text(modtext, tahoma_bold, vec2_t.new((screen_size.x/2)-(modtextsize.x/2), (1080/2)+25), 25, color_t.new(255, 255, 255, 255))

            if toflick:get_value() then
                if (64-(globalvars.get_tick_count()%64))/ flicktick:get_value() == 1 then 
                    flicktext="Flicking"
                    flicktextsize=caltextsize(flicktext)
                    renderer.text("Flicking", tahoma_bold, vec2_t.new((screen_size.x/2)-(flicktextsize.x/2), (1080/2)+50), 25, color_t.new(200, 0, 0, 255))
                else
                    renderer.text("Flicking", tahoma_bold, vec2_t.new((screen_size.x/2)-(flicktextsize.x/2), (1080/2)+50), 25, color_t.new(0, 180, 0, 255))
                end

            end

            yawtext="Yaw: "..tostring(math.floor(yawanglenumb))
            yawtextsize=caltextsize(yawtext)
            if side==0 and yawanglenumb<0 then
                renderer.text(yawtext, tahoma_bold, vec2_t.new((screen_size.x/2)-(yawtextsize.x/2), (1080/2)+75), 25, color_t.new(200, 0, 0, 255))
            elseif side==180 and yawanglenumb<180 then
                renderer.text(yawtext, tahoma_bold, vec2_t.new((screen_size.x/2)-(yawtextsize.x/2), (1080/2)+75), 25, color_t.new(200, 0, 0, 255))
            else
                renderer.text(yawtext, tahoma_bold, vec2_t.new((screen_size.x/2)-(yawtextsize.x/2), (1080/2)+75), 25, color_t.new(255, 255, 255, 255))        
            end

            choketext="Choke: "..tostring(math.floor(ui.get_slider_int("antihit_fakelag_limit"):get_value()))
            choketextsize=caltextsize(choketext)

            renderer.text(choketext, tahoma_bold, vec2_t.new((screen_size.x/2)-(choketextsize.x/2), (1080/2)+100), 25, color_t.new(255, 255, 255, 255))
            

            lastflicktext="last flick: "..tostring(math.floor(lastflick))
            lastflicktextsize=caltextsize(lastflicktext)
            renderer.text(lastflicktext, tahoma_bold, vec2_t.new((screen_size.x/2)-(lastflicktextsize.x/2), (1080/2)+125), 25, color_t.new(255, 255, 255, 255))        
            

            modanglestext="modangle:  "..tostring(math.floor(modangles))
            modanglestextsize=caltextsize(modanglestext)
            renderer.text(modanglestext, tahoma_bold, vec2_t.new((screen_size.x/2)-(modanglestext.x/2), (1080/2)+150), 25, color_t.new(255, 255, 255, 255))        

            if (64-(globalvars.get_tick_count()%64))/ flicktick:get_value() == 1 then
                lastflick = yawanglenumb
            end

            ticknumbtext="ticknumb:  "..tostring(math.floor(ticknumb))
            ticknumbtextsize=caltextsize(ticknumbtext)

            renderer.text(ticknumbtext, tahoma_bold, vec2_t.new((screen_size.x/2)-(ticknumbtextsize.x/2), (1080/2)+175), 25, color_t.new(255, 255, 255, 255))        
        end

    else
        renderer.text("Cumgambit: Awaiting game", tahoma_bold, vec2_t.new((screen_size.x/2)-25, (1080/2)+100), 25, color_t.new(255, 255, 255, 255))
    end
end

client.register_callback("paint", on_paint)

--watermark shit

local function watermarkfunc()

    if wmcheck:get_value() then
        local hours, minutes, seconds = client.get_system_time()
        local username = client.get_username()
        local ping = se.get_latency()
        local tick_count = (globalvars.get_tick_count())
        local max_clients = globalvars.get_max_clients()

        watermarktext = ("Cumgambit v1.2 | "..username.." | "..seconds..":"..minutes..":"..hours.." | Ping: "..ping.." | "..tick_count.." | "..max_clients)
        wmx = (caltextsize(watermarktext).x+size)
        wmy = (caltextsize(watermarktext).y+size)

        local ssx = screen_size.x
        local ssy = screen_size.y
        --local points ={vec2_t.new(1850,25), vec2_t.new(1870,50), vec2_t.new(1600,50),  vec2_t.new(1580,25)}


        local tr = vec2_t.new(ssx-100,25)
        local br = vec2_t.new(ssx-80, 50)
        
        local bl = vec2_t.new((ssx-80)-wmx, 50)
        local tl = vec2_t.new((ssx-100)-wmx, 25)


        local points ={tr, br, bl,  tl}

        renderer.filled_polygon(points, wmcolor:get_value())

        --DrawEnchantedText(2, "Enchanted Text", font, vec2_t.new(100, 130), 30, color_t.new(255, 255, 255, 255), color_t.new(255, 0, 0, 255))

        --renderer.text(watermarktext, font, vec2_t.new((ssx-50)-wmx, 25), size, color_t.new(255, 255, 255, 255))

        if ctecheck:get_value() then
            DrawEnchantedText(1, watermarktext, font, vec2_t.new((ssx-80)-wmx, 25), size, crtc1:get_value(), crtc2:get_value())
        else
            renderer.text(watermarktext, font, vec2_t.new((ssx-80)-wmx, 25), size, color_t.new(255, 255, 255, 255))
        end

    end


end

client.register_callback("paint", watermarkfunc)

--anim clantag stuff

local m_iTeamNum = se.get_netvar("DT_BasePlayer", "m_iTeamNum")
local a1 = 0
local a2 = 0


local a3=
{
    "c             | ", --1
    "c           u | ", --2
    "c      u    m | ", --3
    "cu     m    g | ", --4
    "cumg   a    m | ", --5
    "cumga  m    b | ", --6
    "cumgam b    i | ", --7
    "cumgambi    t | ", --8
    "cumgambit     | ", --9
    "cumgambit o   | ", --10
    "cumgambit on  | ", --11
    "umgambit on t | ", --12
    "mgambit on to | ", --13
    "gambit on top | ", --14
    "gambit on top.| ", --15
    "gambit on top.. ", --16
    "gambit on top...", -- mid
    "gambit on top.. ", --16
    "gambit on top.| ", --15
    "gambit on top | ", --14
    "mgambit on to | ", --13
    "umgambit on t | ", --12
    "cumgambit on  | ", --11
    "cumgambit o   | ", --10
    "cumgambit     | ", --9
    "cumgambi    t | ", --8
    "cumgam b    i | ", --7
    "cumga  m    b | ", --6
    "cumg   a    m | ", --5
    "cu     m    g | ", --4
    "c      u    m | ", --3
    "c           u | ", --2
    "c             | ", --1

}

local a4={
    "c........ user | ", --1
    "c.......u user | ", --2
    "c.....u.m user | ", --3
    "c...u.m.g user | ", --4
    "c.u.m.g.a user | ", --5
    "cu.m.g.a. user | ", --6
    "cum.g.a.m user | ", --7
    "cumg.a.m. user | ", --8
    "cumga.m.b user | ", --9
    "cumgam.b. user | ", --10
    "cumgamb.i user | ", --11
    "cumgambi. user | ", --12
    "cumgambit user | ", --13
    "umgambit user  | ", --14
    "mgambit user   | ", --15
    "gambit user    | ", --16
    "ambit user     | ", --17
    "mbit user      | ", --18
    "bit user       | ", --19
    "it user        | ", --20
    "t user         | ", --30
    " user          | ", --31
    "user |         | ", --38
    "user -|        | ", --39
    "user - |       | ", --40
    "user - d|      | ", --41
    "user - de|     | ", --42
    "user - dev|    | ", --49
    "user - de|v    | ", --50
    "user - d|ev    | ", --51
    "user - |dev    | ", --52
    "user -| dev    | ", --53
    "user |- dev    | ", --54
    "user| - dev    | ", --55
    "use|r - dev    | ", --56
    "us|er - dev    | ", --57
    "u|ser - dev    | ", --57
    "|user - dev    | ", --66
    "|ser - dev     | ", --67
    "|er - dev      | ", --68
    "|r - dev       | ", --69
    "| - dev        | ", --70
    "|- dev         | ", --71
    "| dev          | ", --72
    "|dev           | ", --73
    "|ev            | ", --74
    "|v             | ", --75
    "|              | ", --76
    "|              | ", --77
    "c|             | ", --78
    "c.|            | ", --79
    "c..|           | ", --80
    "c...|          | ", --81
    "c....|         | ", --82
    "c.....|        | ", --83
    "c......|       | ", --84
    "c.......|      | ", --85
    "c........|     | ", --86
    "c.........|    | ", --87
    "c.........u|   | ", --88
    "c.........us|  | ", --89
    "c.........use| | ", --90
    "c.........user|| ", --91
    "c.........user | ", --92
}

a5={
    ".............| ", --1
    "............c| ", --2
    "...........cu| ", --3
    "..........cum| ", --4
    ".........cumb| ", --5
    "........cumbg| ", --6
    ".......cumgam| ", --7
    "......cumgamb| ", --8
    ".....cumgambi| ", --9
    "....cumgambit| ", --10
    "...cumgambit.| ", --11
    "..cumgambit.x| ", --12
    ".cumgambit.xy| ",-- 13
    "cumgambit.xyz| ",
    "cumgambit.xyz| ",
    "cumgambit.xyz| ",
    "cumgambit.xyz| ",
    "cumgambit.xyz| ",
    ".cumgambit.xy| ",-- 13
    "..cumgambit.x| ", --12
    "...cumgambit.| ", --11
    "....cumgambit| ", --10
    ".....cumgambi| ", --9
    "......cumgamb| ", --8
    ".......cumgam| ", --7
    "........cumbg| ", --6
    ".........cumb| ", --5
    "..........cum| ", --4
    "...........cu| ", --3
    "............c| ", --2
    ".............| ", --1

}


a6={
  "1|", --1
  "18|", --2
  "180|", --3
  "180 |", --4
  "180 t|", --5
  "180 tr|", --6
  "180 tre|", --7
  "180 tree|", --8
  "180 tree |", --9
  "180 tree h|", --10
  "180 tree ho|", --11
  "180 tree hou|", --12
  "180 tree hous|", --13
  "180 tree house|", --14
  "180 tree house|", --14
  "180 tree house|", --14
  "180 tree hous|",--13
  "180 tree hou|",--12
  "180 tree ho|", --11
  "180 tree h|", --10
  "180 tree |", --9
  "180 tree|", --8
  "180 tre|", --7
  "180 tr|", --6
  "180 t|", --5
  "180 |", --4
  "180|", --3
  "18|", --2
  "1|", --1
}


local taglength=64

function paint()
    if engine.is_in_game() and animclantag:get_value() then
        if tagpick:get_value()==0 then
            taglength=32
            if visclantag:get_value() then
                renderer.text(tostring(a3[a2]), tahoma_bold, vec2_t.new((screen_size.y/2)+390, (1080/2)-75), 15, color_t.new(255, 255, 255, 255))
            end
        elseif tagpick:get_value()==1 then
            taglength=63
            if visclantag:get_value() then
                renderer.text(tostring(a4[a2]), tahoma_bold, vec2_t.new((screen_size.y/2)+390, (1080/2)-75), 15, color_t.new(255, 255, 255, 255))
            end
        elseif tagpick:get_value()==2 then
            taglength=30
            if visclantag:get_value() then
                renderer.text(tostring(a5[a2]), tahoma_bold, vec2_t.new((screen_size.y/2)+390, (1080/2)-75), 15, color_t.new(255, 255, 255, 255))
            end
        elseif tagpick:get_value()==3 then
            taglength=29
            if visclantag:get_value() then
                renderer.text(tostring(a6[a2]), tahoma_bold, vec2_t.new((screen_size.y/2)+390, (1080/2)-75), 15, color_t.new(255, 255, 255, 255))
            end
        end

        if a1 < globalvars.get_tick_count() then     
            a2 = a2 + 1
            if a2 > taglength then
                a2 = 0
            end
            if tagpick:get_value()==0 then
                se.set_clantag(a3[a2])
            elseif tagpick:get_value()==1 then
                se.set_clantag(a4[a2])
            elseif tagpick:get_value()==2 then
                se.set_clantag(a5[a2])
            elseif tagpick:get_value()==3 then
                se.set_clantag(a6[a2])
            end
            a1 = globalvars.get_tick_count() + 18

        end



    --elseif engine.is_in_game() and not animclantag:get_value() then
    --    se.set_clantag("")
    end
end

client.register_callback("paint", paint)



--master looser resolver coming soon


client.notify("Injected!")
client.notify("Thank you "..tostring(client.get_username()).." for using cumgambit AA! Developed by silencer on nixware.cc")
