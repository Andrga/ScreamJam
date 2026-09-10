// chromatic aberration
// https://godotshaders.com/shader/just-chromatic-aberration/

shader_type canvas_item;

uniform vec2 r_displacement = vec2(3.0, 0.0);
uniform vec2 g_displacement = vec2(0.0, 0.0);
uniform vec2 b_displacement = vec2(-3.0, 0.0);

uniform sampler2D screen_texture : hint_screen_texture, repeat_disable, filter_nearest;

void fragment()
{
	float r = texture(screen_texture, SCREEN_UV + vec2(SCREEN_PIXEL_SIZE*r_displacement), 0.0).r;
	float g = texture(screen_texture, SCREEN_UV + vec2(SCREEN_PIXEL_SIZE*g_displacement), 0.0).g;
	float b = texture(screen_texture, SCREEN_UV + vec2(SCREEN_PIXEL_SIZE*b_displacement), 0.0).b;
	
	COLOR = vec4(r, g, b, 1.0);
}