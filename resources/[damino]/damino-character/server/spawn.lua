json = require "json"


RegisterServerEvent('damino:spawn:getPlayerSpawn')
AddEventHandler('damino:spawn:getPlayerSpawn', function()
    local playerID = GetPlayerIdentifiers(source)[1]
    local _source = source
    MySQL.Async.fetchAll("SELECT * FROM player WHERE license = @playerID ORDER BY id DESC",
        {["@playerID"] = playerID},
        function(result)
            if result[1] == nil then
                firstSpawn(playerID)
            else
                local position = json.decode(result[1].position)
                local data = {
                    x= position.x,
                    y= position.y,
                    z= position.z
                }
                TriggerClientEvent('damino:spawn:spawnPlayer', _source, {response={data=data}})
            end
    end)
end)

function firstSpawn(playerID)
    local _source = source
    local location = {
        x = 1464.723,
        y = 1105.405,
        z = 114.3344
    }
    MySQL.Async.insert("INSERT INTO player (license, name, position) VALUES(@playerID, @name, @location)",
    {
        ["@playerID"] = playerID,
        ["@name"] = "NoName",
        ["@location"] = json.encode(location)
    },
    function(result)
        TriggerClientEvent('damino:spawn:spawnPlayer', _source, {response={data=location}})
    end)
end