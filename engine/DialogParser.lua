local WordTypes = {
    ["set"] = function(words) 
        local character = words[2]
        local prop = words[3]
        local data = {}
        for i = 4, #words, 1 do 
            table.insert(data, words[i])
        end
        return {
            type = "set",
            prop = prop,
            data = data,
            character = character
        }
    end,
    
    ["text"] = function(words) 
        local character = words[2]
        local text = ""
        for i = 3, #words, 1 do 
            text = text .. words[i] .. " "
        end
        return {
            type = "text",
            text = text:sub(1, -2),
            character = character
        }
    end,
}

local DialogParser = function(content) 
    local dialog = {}
    for line in content:gmatch("[^\r\n]+") do 
        local words = {}
        for word in line:gmatch("%S+") do 
            table.insert(words, word)
        end
        table.insert(dialog, WordTypes[words[1]](words))
    end
    return dialog
end

return DialogParser
