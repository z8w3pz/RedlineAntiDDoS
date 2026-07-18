
local ConnectionHistory = {}
local BlacklistedIPs = {}

local MAX_CONNECTIONS_PER_IP = 3    -- 5 saniyede maksimum bağlantı isteği
local TIMEFRAME_MS = 5000           -- Zaman aralığı (milisaniye)
local BAN_DURATION_SEC = 300        -- Şüpheli IP'lerin engellenme süresi (5 dakika)

local function ExtractIP(endpoint)
    if not endpoint then return nil end
    local ip = string.match(endpoint, "([^:]+)")
    return ip
end

AddEventHandler('connecting', function(name, setKickReason, deferrals)
    local source = source
    local endpoint = GetPlayerEndpoint(source)
    local ip = ExtractIP(endpoint)

    if not ip then return end
    local currentTime = GetGameTimer()

    if BlacklistedIPs[ip] and currentTime < BlacklistedIPs[ip] then
        deferrals.defer()
        deferrals.close("Your IP is temporarily blocked due to unusual traffic pattern detection.")
        CancelEvent()
        return
    elseif BlacklistedIPs[ip] and currentTime >= BlacklistedIPs[ip] then
        BlacklistedIPs[ip] = nil
    end

    if not ConnectionHistory[ip] then
        ConnectionHistory[ip] = {}
    end

    local validConnections = {}
    for _, timestamp in ipairs(ConnectionHistory[ip]) do
        if currentTime - timestamp < TIMEFRAME_MS then
            table.insert(validConnections, timestamp)
        end
    end
    ConnectionHistory[ip] = validConnections

    if #ConnectionHistory[ip] >= MAX_CONNECTIONS_PER_IP then
        BlacklistedIPs[ip] = currentTime + (BAN_DURATION_SEC * 1000)
        deferrals.defer()
        deferrals.close("Anti-DDoS: Connection rate limit exceeded. Please wait 5 minutes.")
        CancelEvent()
        return
    end

    table.insert(ConnectionHistory[ip], currentTime)
end)

AddEventHandler('onServerResourceStart', function(resourceName)
    if string.find(resourceName, "ddos") or resourceName == GetCurrentResourceName() then
        print("^2[RedlineShare]^7 Advanced DDoS Protection Loaded Successfully.")
    end
end)
