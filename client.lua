----- muestra el ID en la pantalla -----
CreateThread(function()
    Wait(50)
    while true do
        -- modifica las coords para posicionar la ID en cualquier lugar de la pantalla o para cambiar el color de la ID
        miid(1.400, 1.438, 1.0,1.0,0.50, "~b~ID:~b~  ".. GetPlayerServerId(NetworkGetEntityOwner(PlayerPedId())) .. '', 255, 255, 255, 255)
        Wait(1)
    end
end)

function miid(x,y ,width,height,scale, text, r,g,b,a, outline)
    SetTextFont(4)
    SetTextProportional(0)
    SetTextScale(scale, scale)
	SetTextColour( 0,0,0, 255 )
    SetTextDropShadow(0, 0, 0, 0,255)
    SetTextEdge(1, 0, 0, 0, 255)
    SetTextDropShadow()
	SetTextOutline()
    SetTextEntry("STRING")
    AddTextComponentString(text)
    DrawText(x - width/2, y - height/2 + 0.009)
end

----- Funcion que añade animacion de caminar herido cuando pierdes salud -----
local hurt = false
CreateThread(function()
    while true do
        Wait(0)
        if GetEntityHealth(PlayerPedId()) <= 159 then
            setHurt()
        elseif hurt and GetEntityHealth(PlayerPedId()) > 160 then
            setNotHurt()
        end
    end
end)

function setHurt()
    hurt = true
    RequestAnimSet("move_m@injured")
    SetPedMovementClipset(PlayerPedId(), "move_m@injured", true)
end

function setNotHurt()
    hurt = false
    ResetPedMovementClipset(PlayerPedId())
    ResetPedWeaponMovementClipset(PlayerPedId())
    ResetPedStrafeClipset(PlayerPedId())
end

---- funcion que regula y modifica a tu gusto el daño de las armas mele, de fuego o puños ---

CreateThread(function()
    while true do
    	N_0x4757f00bc6323cfe(GetHashKey("WEAPON_NIGHTSTICK"), 0.1) -- modifica el valor 0.1 para el daño, a mayor valor mayor daño hace el arma
        Wait(0)
        N_0x4757f00bc6323cfe(GetHashKey("WEAPON_UNARMED"), 0.1) 
    	Wait(0)
        N_0x4757f00bc6323cfe(GetHashKey("WEAPON_BAT"), 0.7)
        Wait(0)
        N_0x4757f00bc6323cfe(GetHashKey("WEAPON_FLASHLIGHT"), 0.1)
        Wait(0)
    end
end)

CreateThread(function()
    while true do
        Wait(10)
	local ped = PlayerPedId()
        if IsPedArmed(ped, 6) then
	   DisableControlAction(1, 140, true)
       	   DisableControlAction(1, 141, true)
           DisableControlAction(1, 142, true)
        end
    end
end)

--Funcion Fix para vehiculos Add-on que muestra el nombre del modelo en vez de aparecer NULL
CreateThread(function()
    AddTextEntry('fxxk', 'Ferrari FXXK 2021') -- copia y pega abajo para agregar los modelos que gustes
	end)

    ------ Funcion para dar presencia en discord de tu servidor ---
	CreateThread(function()
		while true do
			-- Este es el ID de la aplicación o el bots de tu servidor de discord (reemplácelo con el suyo)
			SetDiscordAppId(917440200978878515)
			SetDiscordRichPresenceAsset('logo_server')
			SetDiscordRichPresenceAssetText('SERVIDOR DE ROLEPLAY')
			SetDiscordRichPresenceAssetSmall('nombre_de_imagen_o_icono')	
			SetDiscordRichPresenceAssetSmallText('NOMBRE QUE SERA VISTO')
			SetDiscordRichPresenceAction(0, "Web", "tu link")
			SetDiscordRichPresenceAction(1, "Discord", "tu link")
	
			Wait(60000)
		end
	end)

    --- Esta funcion desactiva la animacion estupida de GTA que aparece cuando disparas, algo molestoso cuando quieres correr inmediatamente despues de disparar --
CreateThread(function()
    while true do
        Citizen.Wait(500)
        ped = PlayerPedId()
        if not IsPedInAnyVehicle(ped, false) then
            if IsPedUsingActionMode(ped) then
                SetPedUsingActionMode(ped, -1, -1, 1)
            end
        else
        Wait(3000)
        end
    end
end)

--- Esta funcion deactiva la camara de reposo de tu personaje cuando estas unos segundos sin moverte, muy util ---
CreateThread(function()
    while true do
        InvalidateIdleCam()
        InvalidateVehicleIdleCam()
        Wait(29000) --La cámara inactiva se activa después de 30 segundos, por lo que no necesitamos llamar a esto por cuadro
    end
end)

--- Esta funcion te muestra la ID en la cabeza solo cuando presionas una tecla --
local orion = {
	"ID",
	"IDcabeza"
}

function isorion(name)
	for i = 1, #orion, 1 do
		if string.lower(name) == string.lower(orion[i]) then
			return true
		end
	end
	return false
end

Citizen.CreateThread(function()
	Citizen.Wait(2000)
	while true do
		Citizen.Wait( 1 )
		local headIds = { }
		if IsControlPressed(0, 47) then
			for id = 0, 256, 1 do
				if NetworkIsPlayerActive( id ) then 
					local ped = GetPlayerPed( id )
					if ped ~= nil and (GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), GetEntityCoords(ped)) < Config.drawDistance) and HasEntityClearLosToEntity(PlayerPedId(),  ped,  17) then
						if GetPlayerServerId(id) ~= nil and not isorion(GetPlayerName(id)) then
						 headIds[id] = Citizen.InvokeNative(0xBFEFE3321A3F5015, ped, tostring(GetPlayerServerId(id)), false, false, "", false )
						 N_0x63bb75abedc1f6a0(headIds[id], false, true)
						end
					end
				end
			end
			while IsControlPressed(0, 47) do
				Citizen.Wait(20)
			end
			
			for id = 0, 256, 1 do
				if NetworkIsPlayerActive( id ) then
					N_0x63bb75abedc1f6a0(headIds[id], false, false)
				end
			end
		end
	end
end)

-- si quieres desactivar los sonidos ambientales de tu servidor, como sonidos de sirenas NPC, disparos NPC o dialogos molestosos, aca tienes
StartAudioScene('CHARACTER_CHANGE_IN_SKY_SCENE') -- pegala en cualquier client.lua de tu servidor

---- Funcion que añade BLIPS a donde tu quieras posicionarlos en el mapa ---
local blips = {
    -- id= es el id del blips o icono que sera visible
    -- aca puedes encontrar muchos iconos para fivem https://docs.fivem.net/docs/game-references/blips/
	{title="Carabineros de Chile", colour=38, id=60, x=116.7, y=-750.86, z=45.43, scale= 0.7},
  }
Citizen.CreateThread(function()

    for _, info in pairs(blips) do
      info.blip = AddBlipForCoord(info.x, info.y, info.z)
      SetBlipSprite(info.blip, info.id)
      SetBlipDisplay(info.blip, 4)
      SetBlipScale(info.blip, info.scale)
      SetBlipColour(info.blip, info.colour)
      SetBlipAsShortRange(info.blip, true)
	  BeginTextCommandSetBlipName("STRING")
      AddTextComponentString(info.title)
      EndTextCommandSetBlipName(info.blip)
    end
end)