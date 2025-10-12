//
// http://gta.rockstarvision.com/skygfx/skygfx.html
//
// The PS2 effect works like this: out = in*rgb1*2 + in*rgb2*2*alpha2*2.
//
// Result = BlendOp(Dst * DstBlend, Src * SrcBlend)
//
// BlendOp		: Add
// DstBlend		: BlendFactor
// SrcBlend		: DestColor
//
// Result = (Dst * BlendFactor) + (Src * DestColor)
//
// Src			: FILTER1
// BlendFactor	: FILTER2
//
// Result = (Dst * FILTER2) + (FILTER1 * DestColor)
// Result = (Dst * FILTER2) + (Dst * FILTER1)

float4 color1 = 1;
float4 color2 = 1;

static float4 FILTER1 = float4(color1.rgb / 255.0 * 2, 1);
static float4 FILTER2 = float4((color2.rgb / 255.0 * 2) * (color2.a / 255.0 * 2), 1);

technique ps2
{
	pass P0
	{
		TextureFactor = FILTER1;
		BlendFactor = FILTER2;

		Texture[0] = Null;
		ColorArg1[0] = TFactor;
		ColorOp[0] = SelectArg1;
		AlphaOp[0] = Disable;
		ColorOp[1] = Disable;
		AlphaOp[1] = Disable;

		BlendOp = Add;
		SrcBlend = DestColor;
		DestBlend = BlendFactor;
	}
}