shader_type canvas_item;

uniform vec4 color1 : source_color = vec4(0.1, 0.1, 0.1, 1.0);
uniform vec4 color2 : source_color = vec4(0.9, 0.9, 0.9, 1.0);
uniform float square_size = 32.0;
uniform float speed = 0.5;
uniform bool diagonal = true;
uniform float skew = 0.0; // Skew amount (try 0.0 to 1.0 or -1.0)

void fragment() {
    vec2 pos = FRAGCOORD.xy;

    // Movement direction
    vec2 movement = diagonal ? vec2(1.0, 1.0) : vec2(1.0, 0.0);
    vec2 offset = TIME * speed * movement;

    // Apply movement
    pos += offset;

    // Apply skew to Y based on X (slants pattern)
    pos.y += pos.x * skew;

    // Calculate checker pattern
    vec2 checker = floor(pos / square_size);
    float is_even = mod(checker.x + checker.y, 2.0);

    COLOR = mix(color1, color2, is_even);
}
