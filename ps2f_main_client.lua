local SCREEN_WIDTH, SCREEN_HEIGHT = guiGetScreenSize()
local SHADER = dxCreateShader("ps2.fx")

addEventHandler("onClientHUDRender", root,
	function()

		if getCameraGoggleEffect() ~= "normal" then
			resetColorFilter()
			return
		end

		setColorFilter(0, 0, 0, 0, 0, 0, 0, 0)

		local r1, g1, b1, a1, r2, g2, b2, a2 = getColorFilter(true)
		dxSetShaderValue(SHADER, "color1", r1, g1, b1, a1)
		dxSetShaderValue(SHADER, "color2", r2, g2, b2, a2)
		dxDrawImage(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT, SHADER)
	end,
	false,
	"high"
)

addEventHandler("onClientResourceStop", resourceRoot,
	function()
		resetColorFilter()
	end
)