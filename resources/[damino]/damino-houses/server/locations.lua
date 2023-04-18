json = require "json"

RegisterServerEvent('damino:locations:getMarkerLocations')
AddEventHandler('damino:locations:getMarkerLocations', function()
    print("test")
    local _source = source
    MySQL.Async.fetchAll("SELECT * FROM housing ORDER BY id ASC",
    {},
    function(houseResult)
        if houseResult[1] ~= nil then
            local houses = {}
            for i=1, #(houseResult) do
                houses[i] = json.decode(houseResult[i].location)
                if i == #(houseResult) then
                    TriggerClientEvent('damino:locations:setMarkerLocations', _source, { response={data=houses} })
                end
            end
        end
    end)
end)