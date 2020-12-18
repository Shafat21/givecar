ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)



RegisterNetEvent('nuo:spawnVehicleBySql')
AddEventHandler('nuo:spawnVehicleBySql', function(model,plate)
	local playerPed = PlayerPedId()
	local coords    = GetEntityCoords(playerPed)

	ESX.Game.SpawnVehicle(model, coords, 90.0, function(vehicle)
		TaskWarpPedIntoVehicle(playerPed,  vehicle, -1)
		
		local newPlate     = plate
		local vehicleProps = ESX.Game.GetVehicleProperties(vehicle)
		vehicleProps.plate = newPlate
		TriggerServerEvent('nuo:setVehicleBySql', vehicleProps)
	end)
end)


RegisterNetEvent('nuo:spawnYouVehicleBySql')
AddEventHandler('nuo:spawnYouVehicleBySql', function(model,plate,youId)
	local playerPed = PlayerPedId()
	local coords    = GetEntityCoords(playerPed)

	ESX.Game.SpawnVehicle(model, coords, 90.0, function(vehicle)
		TaskWarpPedIntoVehicle(playerPed,  vehicle, -1)
		print(playerPed)
		
		local newPlate     = plate
		local vehicleProps = ESX.Game.GetVehicleProperties(vehicle)
		vehicleProps.plate = newPlate
		TriggerServerEvent('nuo:setYouVehicleBySql', vehicleProps,youId)
	end)
end)