_G.Players = game:GetService("Players")
_G.RunService = game:GetService("RunService")
_G.UIS = game:GetService("UserInputService")
_G.Camera = workspace.CurrentCamera
_G.LocalPlayer = _G.Players.LocalPlayer

_G.state = {
    esp = false, nametags = false, health = false, range = false,
    fly = false, speed = false, noclip = false,
    god = false, infjump = false, antiafk = false,
    fps = false, freecam = false, invisible = false
}
_G.keys = {
    esp = Enum.KeyCode.Unknown, nametags = Enum.KeyCode.Unknown,
    health = Enum.KeyCode.Unknown, range = Enum.KeyCode.Unknown,
    fly = Enum.KeyCode.Unknown, speed = Enum.KeyCode.Unknown,
    noclip = Enum.KeyCode.Unknown, god = Enum.KeyCode.Unknown,
    infjump = Enum.KeyCode.Unknown, antiafk = Enum.KeyCode.Unknown,
    fps = Enum.KeyCode.Unknown, freecam = Enum.KeyCode.Unknown,
    invisible = Enum.KeyCode.Unknown
}
_G.flySpeed = 50
_G.espTable = {}
_G.badges = {}
_G.strokes = {}
_G.keyBtns = {}
_G.bindingKey = nil
_G.bodyVel = nil
_G.bodyGyro = nil
_G.freecamPart = nil
_G.freecamYaw = 0
_G.freecamPitch = 0
_G.lastTime = tick()
