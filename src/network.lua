socket = require("socket")

NetworkController = Class {}

function NetworkController:init(ip, port)
    local client = socket.tcp()
    client:settimeout(10)
    local success = client:connect(ip, port)
    if not success then
        print('Failed to connect to server: ' .. ip .. ':' .. tostring(port))
    end
    client:send('Szatan\n')
    print(client:receive("*l"))

    print("Szatan czyste zło")
    client:close()
end
