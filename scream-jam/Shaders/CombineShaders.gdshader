shader_type canvas_item;

uniform float intensity :hint_range(0.0, 1.0) = 0;

uniform vec2 r_displacement = vec2(3.0, 0.0);
uniform vec2 g_displacement = vec2(0.0, 0.0);
uniform vec2 b_displacement = vec2(-3.0, 0.0);

uniform float wave_count : hint_range(1.0, 20.0) = 20.0;
uniform float speed : hint_range(0.0, 10.0) = 10.0;
uniform float height : hint_range(0.0, 0.1) = 0.05;

uniform sampler2D screen_texture : hint_screen_texture, filter_nearest;

void fragment() {
    // Primero: efecto de onda / distorsión radial
    vec2 cPos = -1.0 + 2.0 * UV;
    float cLength = length(cPos);
    vec2 uv_offset = (cPos / cLength) * cos(cLength * wave_count - TIME * speed * intensity) * height * intensity;
    vec2 uv = SCREEN_UV + uv_offset;

    // Luego: aberración cromática por canales
    float r = texture(screen_texture, uv + vec2(SCREEN_PIXEL_SIZE * r_displacement* intensity), 0.0).r;
    float g = texture(screen_texture, uv + vec2(SCREEN_PIXEL_SIZE * g_displacement* intensity), 0.0).g;
    float b = texture(screen_texture, uv + vec2(SCREEN_PIXEL_SIZE * b_displacement* intensity), 0.0).b;

    COLOR = vec4(r, g, b, 1.0);
}
