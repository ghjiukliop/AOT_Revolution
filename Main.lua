-- [[ AOT REVOLUTION - MAIN CLOUD FIXED ]] --
local BaseURL = "https://raw.githubusercontent.com/ghjiukliop/AOT_Revolution/main/"

_G.AOT_Hub = {
    Settings = { Version = "1.0.0" }, -- Giá trị mặc định để tránh lỗi 'nil'
    Utils = {},
    Raid = {},
    Mission = {}
}

-- Hàm nạp file từ GitHub (Đã thêm chống Cache)
local function Import(path)
    local success, content = pcall(function()
        -- Thêm ?t= để luôn lấy code mới nhất ông vừa Push
        return game:HttpGet(BaseURL .. path .. "?t=" .. tick())
    end)
    
    if success and not content:find("404") then
        local func, err = loadstring(content)
        if func then
            local result = func()
            -- Nếu file không return gì, trả về bảng rỗng thay vì nil
            return result or {} 
        else
            warn("Lỗi cú pháp trong " .. path .. ": " .. err)
        end
    else
        warn("Không tìm thấy file trên GitHub: " .. path)
    end
    return {} -- Trả về bảng rỗng nếu thất bại
end

-- Bắt đầu liên kết các Module
_G.AOT_Hub.Settings = Import("Settings.lua")
_G.AOT_Hub.Raid = Import("Model/Raid.lua")
_G.AOT_Hub.Mission = Import("Model/Mission.lua")

-- Đợi 0.1 giây để đảm bảo dữ liệu đã nạp xong
task.wait(0.1)

-- Cuối cùng là load UI
Import("UI.lua")