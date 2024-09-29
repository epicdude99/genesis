-- all source code was made by samet
local InstanceLibrary  = {
    Objects = {};
    Classes = {
        UIElements = {
            "Frame",
            "TextButton",
            "TextBox",
            "TextLabel",
            "ImageButton",
            "ImageLabel",
            "BillboardGui",
            "ScrollingFrame",
        }
    }
}

local INew = Instance.new
local Workspace = game:GetService("Workspace")

local InstancesFolder = INew("Folder",Workspace)
InstancesFolder.Name = tostring(math.random(1,100000) + math.random(1,900) / math.random(1,1003) * math.random(1,104141))
-- 
local UIElementsFolder = INew("ScreenGui", game.CoreGui)
UIElementsFolder.ResetOnSpawn = false 
UIElementsFolder.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

function InstanceLibrary:Create(Class, Properties)
    local Object = INew(Class)

    for Property, Value in Properties do
        Object[Property] = Value 
    end

    if table.find(InstanceLibrary.Classes.UIElements, Class) then
        Class.Parent = UIElementsFolder
    end

    table.insert(InstanceLibrary.Objects, Object)

    return Object
end

function InstanceLibrary:FindChild(Name, Path)
    return Path:FindFirstChild(Name)
end

function InstanceLibrary:Destroy(Name, Path)
    if Path == "Core" then
        if InstanceLibrary:FindChild(Name, UIElementsFolder) then
            UIElementsFolder[Name]:Destroy()
        end
    elseif Path == "Workspace" then
        if InstanceLibrary:FindChild(Name, InstancesFolder) then
            InstancesFolder[Name]:Destroy()
        end
    end
end

function InstanceLibrary:Highlight(Object, Color, Transparency)
    local Highlight = InstanceLibrary:Create("Highlight", {
        Parent = InstancesFolder,
        FillColor = Color,
        FillTransparency = Transparency,
        OutlineTransparency = 1,
        Adornee = Object,
    })

    return Highlight
end

function InstanceLibrary:Outline(Object, Color, Transparency)
    local Outline = InstanceLibrary:Create("Highlight", {
        Parent = InstancesFolder,
        FillColor = Color,
        FillTransparency = 1,
        OutlineTransparency = Transparency,
        OutlineColor = Color,
        Adornee = Object,
    })

    return Outline
end


return InstanceLibrary