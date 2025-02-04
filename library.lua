-- drifter's esp library

local drift = {}

-- Configuration (Customize these)
drift.LineColor = Color3.fromRGB(0, 255, 0) -- Green
drift.LineWidth = 2
drift.MaxDistance = 100 -- Maximum distance to draw the line

-- Function to draw a line to a part's position
function drift.line(partPosition)
    local camera = workspace.CurrentCamera
    local startPoint = camera:WorldToViewportPoint(camera.CFrame.Position) -- Camera's position
    local endPoint = camera:WorldToViewportPoint(partPosition)

    if endPoint.z <= 0 then return end -- Don't draw if behind camera

    local distance = (camera.CFrame.Position - partPosition).Magnitude
    if distance > drift.MaxDistance then return end -- Don't draw if too far

    local line = Instance.new("Part")
    line.Parent = workspace.CurrentCamera -- Attach to camera for consistent view
    line.Name = "driftLine"
    line.Anchored = true
    line.CanCollide = false
    line.Transparency = 0.5 -- Make it slightly transparent
    line.Material = Enum.Material.Neon

    local distanceVector = (partPosition - camera.CFrame.Position).Unit * distance
    local midPoint = camera.CFrame.Position + distanceVector/2
    line.CFrame = CFrame.new(midPoint, partPosition)
    line.Size = Vector3.new(drift.LineWidth, drift.LineWidth, distance)


    local beam = Instance.new("Beam")
    beam.Parent = line
    beam.Attachment0 = line.new("Attachment")
    beam.Attachment1 = line.new("Attachment")
    beam.Attachment0.Position = Vector3.new(0,0,0)
    beam.Attachment1.Position = Vector3.new(0,0,distance)
    beam.Width0 = drift.LineWidth
    beam.Width1 = drift.LineWidth
    beam.Color = ColorSequence.new(drift.LineColor)
    beam.Transparency = NumberSequence.new({0,0})


    return line -- Return the line part
end

function drift.log(text)
print(string.format(("drift-lib: %s", text))
end
