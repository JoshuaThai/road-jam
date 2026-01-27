shader_type canvas_item;

uniform float blur_strength : hint_range(0.0, 10.0) = 100.0;
uniform sampler2D SCREEN_TEXTURE : hint_screen_texture, filter_linear_mipmap;

void fragment() {
    vec2 size = blur_strength / vec2(textureSize(SCREEN_TEXTURE, 0));
    vec4 color = vec4(0.0);

    color += texture(SCREEN_TEXTURE, SCREEN_UV + size * vec2(-1, -1));
    color += texture(SCREEN_TEXTURE, SCREEN_UV + size * vec2(-1,  1));
    color += texture(SCREEN_TEXTURE, SCREEN_UV + size * vec2( 1, -1));
    color += texture(SCREEN_TEXTURE, SCREEN_UV + size * vec2( 1,  1));

    COLOR = color * 0.25;
}

//void light() {
//	// Called for every pixel for every light affecting the CanvasItem.
//	// Uncomment to replace the default light processing function with this one.
//}
