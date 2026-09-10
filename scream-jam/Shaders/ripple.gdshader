// Converted/modified from ShaderToy: https://www.shadertoy.com/view/ldBXDD
// Attach this shader to a ColorRect

shader_type canvas_item;

uniform float wave_count : hint_range(1.0, 20.0, 1.0) = 20.0;
uniform float speed : hint_range(0.0, 10.0, 0.1) = 3.0;
uniform float height : hint_range(0.0, 0.1, 0.001) = 0.003;

uniform sampler2D screen_texture : hint_screen_texture, repeat_disable, filter_nearest;

void fragment() {
vec2 cPos = -1.0 + 2.0 * UV;
float cLength = length(cPos);
vec2 uv = SCREEN_UV + (cPos/cLength) * cos(cLength * wave_count - TIME * speed) * height;
  vec3 col = textureLod(screen_texture,uv, 0.0).xyz;
COLOR = vec4(col,1.0);
}