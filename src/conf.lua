local debug = true

function love.conf(t)
	t.identity = "bsg"
	t.version = "0.9.1"
	if debug then t.console = true end

	t.window = {}
	t.window.title = "Thirty-Three"
	t.window.width = 960
	t.window.height = 540
	t.window.fullscreen = false
	--t.window.borderless = true
	t.window.resizable = false

	--t.modules = {}
	t.modules.joystick = false
	t.modules.physics = false
end

return debug
