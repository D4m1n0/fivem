json = require "json"


RegisterServerEvent('damino:marker:setHouseLocation')
AddEventHandler('damino:marker:setHouseLocation', function(location)
    local playerID = GetPlayerIdentifiers(source)[1]
    local _source = source
    MySQL.Async.insert("INSERT INTO housing (location) VALUES(@location)",
    {
        ["@location"] = json.encode(location)
    },
    function(result)
        TriggerClientEvent('damino:marker:houseCreate', _source, {response={data="Maison créée"}})
    end)
end)

RegisterServerEvent('damino:marker:setObjectLocation')
AddEventHandler('damino:marker:setObjectLocation', function(data)
    local playerID = GetPlayerIdentifiers(source)[1]
    local _source = source

    local name = data[2]
    local location = json.encode({["x"]=data[1].x, ["y"]=data[1].y, ["z"]=data[1].z})
    local objectLocation = data[3]

    MySQL.Async.fetchAll("SELECT * FROM housing WHERE name = @name",
    {["@name"] = name},
    function(result)
        if result[1] ~= nil then
            MySQL.Async.fetchAll("UPDATE housing SET "..objectLocation.."_location=@location WHERE name=@name",
            {
                ["@name"] = name,
                ["@location"] = location
            },
            function(result)
                if result ~= nil then
                    print(objectLocation, ' create')
                end
            end)
        end
    end)
end)