 -- Berk ---- Berk ---- Berk ---- Berk ---- Berk ---- Berk ---- Berk ---- Berk ---- Berk ---- Berk ---- Berk ---- Berk ---- Berk ---- Berk ---- Berk ---- Berk --
-- Discord Berk#0343 ---- Discord Berk#0343 ---- Discord Berk#0343 -- -- Discord Berk#0343 -- -- Discord Berk#0343 -- -- Discord Berk#0343 -- -- Discord Berk#0343 --  
-- Whitelist düzeni
local whitelistArray = {}

local data = LoadResourceFile(GetCurrentResourceName(), GetConvar("enfer.whitelist", "whitelist.json"))

if data then
    whitelistArray = json.decode(data)
    print("" .. #whitelistArray .. " oyuncunun whitelisti yuklendi!")
end

AddEventHandler("playerConnecting", function(playerName, setKickReason, deferrals)
	
	deferrals.defer()
	
    local s = source
	
-- Sunucuya katılmaya izin verildiyse
	local joined = false
	
	-- Giren kişiye whitelist kontrolü için bekleme mesajı
    deferrals.update("Lütfen bekleyiniz. Whitelistiniz doğrulanılıyor.")
	
	Wait(100)
	
	local totalInWhitelist = #whitelistArray -- Dizideki toplam ID sayısı
	local noIdentifiers = #GetPlayerIdentifiers(s) -- Oyuncunun kaç Identifierı vardır (genellikle 2 ve ya 3)
	local currentId = 0 -- Kontrol edilen ID'nin dizisi
	local totalChecksNeeded = totalInWhitelist * noIdentifiers -- İhtiyacımız olan toplam etkileşim sayısı
	
    for myIdx,identifier in pairs(GetPlayerIdentifiers(s)) do
	
        for wIdx,i in ipairs(whitelistArray) do
			
			-- Oyuncunun dizide olup olmadığının kontrolü
            if(string.lower(i) == string.lower(identifier))then
                deferrals.done() 
                joined = true 
				break 
            end
			
			-- Whitelist kontrolü
			deferrals.update(string.format("Whitelist sırayla kontrol ediliyor... %.2f%%", (currentId / totalChecksNeeded)*100))

			Wait(1)
			currentId = currentId +1
        end
    end
	if joined then
		return
	end
	
	-- Whitelistte değilsin. (Mesajı istediğin gibi değiştirebilirsin.)
	deferrals.done("Whitelist'e kayıtlı değilsin!")
end)
-- Discord Berk#0343 -- -- Discord Berk#0343 -- -- Discord Berk#0343 -- -- Discord Berk#0343 -- -- Discord Berk#0343 -- -- Discord Berk#0343 -- -- Discord Berk#0343 -- 
-- Berk ---- Berk ---- Berk ---- Berk ---- Berk ---- Berk ---- Berk ---- Berk ---- Berk ---- Berk ---- Berk ---- Berk ---- Berk ---- Berk ---- Berk ---- Berk --