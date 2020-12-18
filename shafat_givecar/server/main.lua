ESX = nil

local Categories = {}
local Vehicles   = {}

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

TriggerEvent('es:addGroupCommand', 'givecar', 'admin', function(source, args, user)
	TriggerClientEvent('nuo:spawnVehicleBySql',source,args[1],args[2])
end, function(source, args, user)
	TriggerClientEvent('chat:addMessage', source,'')
end)

RegisterServerEvent('nuo:setVehicleBySql')
AddEventHandler('nuo:setVehicleBySql', function (vehicleProps)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)

	MySQL.Async.execute('INSERT INTO owned_vehicles (owner, plate, vehicle) VALUES (@owner, @plate, @vehicle)',
	{
		['@owner']   = xPlayer.identifier,
		['@plate']   = vehicleProps.plate,
		['@vehicle'] = json.encode(vehicleProps)
	}, function (rowsChanged)
		TriggerClientEvent('esx:showNotification', _source,'addCar:plate:'..vehicleProps.plate)
	end)
end)

TriggerEvent('es:addGroupCommand', 'giveyoucar', 'admin', function(source, args, user)
	--TriggerClientEvent('esx:spawnVehicle', source, args[1])
	TriggerClientEvent('nuo:spawnYouVehicleBySql',source,args[1],args[2],args[3])
end, function(source, args, user)
	TriggerClientEvent('chat:addMessage', source,'')
end)

RegisterServerEvent('nuo:setYouVehicleBySql')
AddEventHandler('nuo:setYouVehicleBySql', function (vehicleProps,youId)
	local _source = youId
	local xPlayer = ESX.GetPlayerFromId(_source)

	MySQL.Async.execute('INSERT INTO owned_vehicles (owner, plate, vehicle) VALUES (@owner, @plate, @vehicle)',
	{
		['@owner']   = xPlayer.identifier,
		['@plate']   = vehicleProps.plate,
		['@vehicle'] = json.encode(vehicleProps)
	}, function (rowsChanged)
		TriggerClientEvent('esx:showNotification', _source,'addCar:plate:'..vehicleProps.plate)
	end)
end)

ExecuteCommand('sets ShafatGiveCar ✅')

TriggerEvent('es:addGroupCommand', 'delcarbyplate', 'admin', function(source, args, user)	
	MySQL.Async.execute('DELETE FROM owned_vehicles WHERE plate = @plate', {
		['@plate'] = args[1]
	})
	TriggerClientEvent('esx:showNotification', source,'deletecar:plate:'..args[1])
end, function(source, args, user)
	TriggerClientEvent('chat:addMessage', source,'')
end)