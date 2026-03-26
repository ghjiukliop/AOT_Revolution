local BaseURL = "https://raw.githubusercontent.com/ghjiukliop/AOT_Revolution/main/"

_G.AOT_Hub = {
    Settings = { Version = "1.0.0" }, -- Giá trị dự phòng
    Utils = {},
    Raid = {},
    Mission = {}
}

local function Import(path)
    local success, content = pcall(function()
        return game:HttpGet(BaseURL .. path .. "?t=" .. tick())
    end)
    
    if success and not content:find("404") then
        local func, err = loadstring(content)
        if func then
            -- Nếu file chạy thành công thì lấy kết quả, không thì lấy bảng rỗng
            local res = func()
            return (type(res) == "table" and res) or {}
        end
    end
    -- Trả về bảng rỗng để các file sau (như UI) gọi .Version sẽ ra nil chứ không báo lỗi sập script
    return {} 
end

-- Nạp dữ liệu
_G.AOT_Hub.Settings = Import("Settings.lua")
_G.AOT_Hub.Raid = Import("Model/Raid.lua")
_G.AOT_Hub.Mission = Import("Model/Mission.lua")

task.wait(0.2) -- Chờ một tí cho chắc
Import("UI.lua")