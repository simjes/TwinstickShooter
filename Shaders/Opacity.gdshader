shader_type canvas_item;

uniform bool active = true;

void fragment() {
	vec4 previous_color = texture(TEXTURE, UV);
	vec4 zero_opactiy = vec4(0.0, 0.0, 0.0, 0.0);
	COLOR = active ? zero_opactiy : previous_color;
}