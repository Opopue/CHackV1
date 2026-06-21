-- Shared.luau
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
    freecam = Enum.KeyCode.Unknown, invisible = Enum.KeyCode.Unknown
}
_G.espTable = {}
_G.flySpeed = 50
_G.badges = {}
_G.strokes = {}
_G.keyBtns = {}
_G.bindingKey = nil
