ESX                = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterCommand("jail", function(src, args, raw)

	local xPlayer = ESX.GetPlayerFromId(src)
	local id = src
    local xPlayer = ESX.GetPlayerFromId(id)
	local Vrati = 0
	local result = MySQL.Sync.fetchAll('SELECT permission_level FROM users WHERE ID = @id', {
		['@id'] = xPlayer.getID()
	})
	local vr = result[1].permission_level
	if vr > 0 then
		Vrati = 1
	else
		Vrati = 0
	end

	if xPlayer["job"]["name"] == "police" or xPlayer["job"]["name"] == "sipa" or Vrati == 1 then

		local jailPlayer = args[1]
		local jailTime = tonumber(args[2])
		local jailReason = args[3]
		if jailPlayer ~= nil and jailTime ~= nil and jailReason ~= nil then
			if GetPlayerName(jailPlayer) ~= nil then

				if jailTime ~= nil then
					JailPlayer(jailPlayer, jailTime)
					if Vrati == 0 then
						TriggerEvent('esx_qalle_brottsregister:add', GetPlayerServerId(closestPlayer), reason)
					end

					TriggerClientEvent("esx:showNotification", src, GetPlayerName(jailPlayer) .. " je zatvoren na " .. jailTime .. " minuta!")
					
					if args[3] ~= nil then
						GetRPName(jailPlayer, function(Firstname, Lastname)
							TriggerClientEvent('chat:addMessage', -1, { args = { "SUDAC",  Firstname .. " " .. Lastname .. " je zavrsio u zatvoru zbog: " .. args[3] }, color = { 249, 166, 0 } })
						end)
					end
				else
					TriggerClientEvent("esx:showNotification", src, "Krivo vrijeme!")
				end
			else
				TriggerClientEvent("esx:showNotification", src, "Igrac nije online!")
			end
		else
			TriggerClientEvent('chat:addMessage', src, { args = { "SYSTEM",  "/jail [ID igraca][Vrijeme u zatvoru][Razlog]"}, color = { 249, 166, 0 } })
		end
	else
		TriggerClientEvent("esx:showNotification", src, "Niste policajac!")
	end
end)

RegisterCommand("unjail", function(src, args)

	local xPlayer = ESX.GetPlayerFromId(src)
	local id = src
    local xPlayer = ESX.GetPlayerFromId(id)
	local Vrati = 0
	local result = MySQL.Sync.fetchAll('SELECT permission_level FROM users WHERE ID = @id', {
		['@id'] = xPlayer.getID()
	})
	local vr = result[1].permission_level
	if vr > 0 then
		Vrati = 1
	else
		Vrati = 0
	end

	if xPlayer["job"]["name"] == "police" or xPlayer["job"]["name"] == "sipa" or Vrati == 1 then

		local jailPlayer = args[1]
		if jailPlayer ~= nil then
			if GetPlayerName(jailPlayer) ~= nil then
				UnJail(jailPlayer)
			else
				TriggerClientEvent("esx:showNotification", src, "Igrac nije online!")
			end
		else
			TriggerClientEvent('chat:addMessage', id, { args = { "SYSTEM",  "/unjail [ID igraca]"}, color = { 249, 166, 0 } })
		end
	else
		TriggerClientEvent("esx:showNotification", src, "Niste policajac!")
	end
end)

RegisterServerEvent("charselect:createsign")
AddEventHandler("charselect:createsign", function(xPlayer)
    local _source = source
    local xPlayer  = ESX.GetPlayerFromId(_source)
    local player = xPlayer.identifier
    local result = MySQL.Sync.fetchAll("SELECT * FROM users WHERE identifier=@username", {['@username'] = player})
    if result[1] then
        if xPlayer ~= nil then
            TriggerClientEvent("charselect:createsign", _source, (result[1].firstname .. " " .. result[1].lastname), xPlayer.job.label, ("Cash: " .. result[1].money .. "$"))
        end
    end
end)

RegisterNetEvent('jail:PostaviBucket')
AddEventHandler('jail:PostaviBucket', function(br)
	local src = source
	SetPlayerRoutingBucket(src, br)
	local xPlayer = ESX.GetPlayerFromId(src)

	for i=#xPlayer.loadout, 1, -1 do
		xPlayer.removeWeapon(xPlayer.loadout[i].name)
	end
end)

RegisterServerEvent("esx-qalle-jail:jailPlayer")
AddEventHandler("esx-qalle-jail:jailPlayer", function(targetSrc, jailTime, jailReason)
	local src = source
	local targetSrc = tonumber(targetSrc)
	local xPlayer = ESX.GetPlayerFromId(src)
	local id = src
    local xPlayer = ESX.GetPlayerFromId(id)
	local Vrati = 0
	local result = MySQL.Sync.fetchAll('SELECT permission_level FROM users WHERE ID = @id', {
		['@id'] = xPlayer.getID()
	})
	local vr = result[1].permission_level
	if vr > 0 then
		Vrati = 1
	else
		Vrati = 0
	end
	if xPlayer.job.name == 'police' or xPlayer.job.name == "sipa" or Vrati == 1 then
		JailPlayer(targetSrc, jailTime)
		GetRPName(targetSrc, function(Firstname, Lastname)
			TriggerClientEvent('chat:addMessage', -1, { args = { "SUDAC",  Firstname .. " " .. Lastname .. " je zavrsio u zatvoru zbog: " .. jailReason }, color = { 249, 166, 0 } })
		end)
		TriggerClientEvent("esx:showNotification", src, GetPlayerName(targetSrc) .. " je zatvorit na " .. jailTime .. " minuta!")
	else
		print(('esx_jail: %s attempted to jail!'):format(xPlayer.identifier))
		TriggerEvent("DiscordBot:Anticheat", GetPlayerName(src).."["..src.."] je pokusao pozvati event za stavljanje u zatvor, a nije zaposlen kao policajac!")
	    TriggerEvent("AntiCheat:Citer", src)
	end
end)

RegisterServerEvent("esx-qalle-jail:unJailPlayer")
AddEventHandler("esx-qalle-jail:unJailPlayer", function(targetIdentifier)
	local src = source
	local xPlayer = ESX.GetPlayerFromIdentifier(targetIdentifier)

	if xPlayer ~= nil then
		UnJail(xPlayer.source)
	else
		MySQL.Async.execute(
			"UPDATE users SET jail = @newJailTime WHERE identifier = @identifier",
			{
				['@identifier'] = targetIdentifier,
				['@newJailTime'] = 0
			}
		)
	end

	TriggerClientEvent("esx:showNotification", src, xPlayer.name .. " oslobodjen!")
end)

RegisterServerEvent("esx-qalle-jail:updateJailTime")
AddEventHandler("esx-qalle-jail:updateJailTime", function(newJailTime)
	local src = source

	EditJailTime(src, newJailTime)
end)

RegisterServerEvent("zatvor:radutijeku")
AddEventHandler("zatvor:radutijeku", function()
	local src = source

	local xPlayer = ESX.GetPlayerFromId(src)
        local rand = math.random(13, 21)
	xPlayer.addMoney(rand)
        local por = "["..os.date("%X").."] ("..GetCurrentResourceName()..") Igrac "..GetPlayerName(src).."("..xPlayer.identifier..") je dobio $"..rand
	TriggerEvent("SpremiLog", por)

	TriggerClientEvent("esx:showNotification", src, "Evo ti nesto novca za trud!")
end)

function JailPlayer(jailPlayer, jailTime)
	TriggerClientEvent(jailPlayer, "esx_policejob:unrestrain")
	TriggerClientEvent(jailPlayer, "esx_policejob:undragga")
	TriggerClientEvent(jailPlayer, "esx_sipa:unrestrain")
	TriggerClientEvent(jailPlayer, "esx_sipa:undragga")
	TriggerClientEvent("esx-qalle-jail:jailPlayer", jailPlayer, jailTime)
	EditJailTime(jailPlayer, jailTime)
end

function UnJail(jailPlayer)
	TriggerClientEvent("esx-qalle-jail:unJailPlayer", jailPlayer)

	EditJailTime(jailPlayer, 0)
end

function EditJailTime(source, jailTime)

	local src = source

	local xPlayer = ESX.GetPlayerFromId(src)
	local Identifier = xPlayer.identifier

	MySQL.Async.execute(
       "UPDATE users SET jail = @newJailTime WHERE identifier = @identifier",
        {
			['@identifier'] = Identifier,
			['@newJailTime'] = tonumber(jailTime)
		}
	)
end

function GetRPName(playerId, data)
	local Identifier = ESX.GetPlayerFromId(playerId).identifier

	MySQL.Async.fetchAll("SELECT firstname, lastname FROM users WHERE identifier = @identifier", { ["@identifier"] = Identifier }, function(result)

		data(result[1].firstname, result[1].lastname)

	end)
end

ESX.RegisterServerCallback("esx-qalle-jail:retrieveJailedPlayers", function(source, cb)
	
	local jailedPersons = {}

	MySQL.Async.fetchAll("SELECT firstname, lastname, jail, identifier FROM users WHERE jail > @jail", { ["@jail"] = 0 }, function(result)

		for i = 1, #result, 1 do
			table.insert(jailedPersons, { name = result[i].firstname .. " " .. result[i].lastname, jailTime = result[i].jail, identifier = result[i].identifier })
		end

		cb(jailedPersons)
	end)
end)

ESX.RegisterServerCallback("esx-qalle-jail:retrieveJailTime", function(source, cb)

	local src = source

	local xPlayer = ESX.GetPlayerFromId(src)
	local Identifier = xPlayer.identifier


	MySQL.Async.fetchScalar("SELECT jail FROM users WHERE identifier = @identifier", { ["@identifier"] = Identifier }, function(result)

		local JailTime = tonumber(result)

		if JailTime > 0 then

			cb(true, JailTime)
		else
			cb(false, 0)
		end

	end)
end)	