shader_type canvas_item;

uniform vec4 color1 : source_color = vec4(0.1, 0.1, 0.1, 1.0); // Stripe A
uniform vec4 color2 : source_color = vec4(1.0, 1.0, 1.0, 1.0); // Stripe B
uniform float stripe_width = 20.0; // Width in pixels
uniform float angle_deg = 45.0; // Angle in degrees
uniform float speed = 20.0; // Scroll speed in pixels/second

void fragment() {
    // Convert angle to radians
    float angle = radians(angle_deg);

    // Create stripe UV by rotating the screen position
    vec2 dir = vec2(cos(angle), sin(angle));
    float pos = dot(FRAGCOORD.xy + vec2(TIME * speed), dir);

    // Determine which stripe we're in
    float stripe = floor(pos / stripe_width);

    // Alternate colors based on stripe number
    float is_even = mod(stripe, 2.0);
    COLOR = mix(color1, color2, is_even);
}
