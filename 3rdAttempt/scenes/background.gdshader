shader_type canvas_item;

uniform float square_size = 32.0;
uniform float speed = 0.5;
uniform bool diagonal = true;
uniform float skew = 0.0;

void fragment() {
    vec2 pos = FRAGCOORD.xy;

    vec2 movement = diagonal ? vec2(1.0, 1.0) : vec2(1.0, 0.0);
    vec2 offset = TIME * speed * movement;
    pos += offset;

    pos.y += pos.x * skew;

    vec2 checker = floor(pos / square_size);
    float is_even = mod(checker.x + checker.y, 2.0);

    // Subtle cycling colours
    vec4 base1 = vec4(0.3, 0.3, 0.35, 1.0); // muted blue-grey
    vec4 base2 = vec4(0.4, 0.35, 0.3, 1.0); // muted warm brown

    float t = (sin(TIME * 0.4) + 1.0) * 0.5; // value from 0.0 to 1.0
    vec4 color1 = mix(base1, base2, t);

    vec4 base3 = vec4(0.25, 0.25, 0.3, 1.0); // even darker grey-blue
    vec4 base4 = vec4(0.35, 0.3, 0.25, 1.0); // earthy brown-grey

    float t2 = (cos(TIME * 0.3) + 1.0) * 0.5;
    vec4 color2 = mix(base3, base4, t2);

    COLOR = mix(color1, color2, is_even);
}
