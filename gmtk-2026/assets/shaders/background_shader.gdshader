shader_type canvas_item;

// Target pixel resolution
uniform vec2 target_resolution = vec2(640.0, 360.0);

// Color Palette
uniform vec4 deep_color : source_color = vec4(0.02, 0.08, 0.22, 1.0);  // Deep ocean blue
uniform vec4 shallow_color : source_color = vec4(0.05, 0.38, 0.52, 1.0); // Tropical teal
uniform vec4 foam_color : source_color = vec4(0.40, 0.85, 0.90, 1.0);    // Bright caustic highlights

// Settings
uniform float speed : hint_range(0.05, 2.0) = 0.3;
uniform float scale : hint_range(1.0, 20.0) = 5.0;
uniform float distortion : hint_range(0.0, 2.0) = 0.8;

// Pseudo-random noise function
vec2 hash(vec2 p) {
    p = vec2(dot(p, vec2(127.1, 311.7)), dot(p, vec2(269.5, 183.3)));
    return -1.0 + 2.0 * fract(sin(p) * 43758.5453123);
}

// Simplex-style 2D Noise
float noise(vec2 p) {
    vec2 i = floor(p);
    vec2 f = fract(p);
    vec2 u = f * f * (3.0 - 2.0 * f);

    return mix(mix(dot(hash(i + vec2(0.0, 0.0)), f - vec2(0.0, 0.0)),
                   dot(hash(i + vec2(1.0, 0.0)), f - vec2(1.0, 0.0)), u.x),
               mix(dot(hash(i + vec2(0.0, 1.0)), f - vec2(0.0, 1.0)),
                   dot(hash(i + vec2(1.0, 1.0)), f - vec2(1.0, 1.0)), u.x), u.y);
}

// Layered Fractal Brownian Motion (fBm)
float fbm(vec2 uv, float time) {
    float value = 0.0;
    float amplitude = 0.5;
    vec2 shift = vec2(100.0);
    mat2 rot = mat2(vec2(cos(0.5), sin(0.5)), vec2(-sin(0.5), cos(0.5)));

    for (int i = 0; i < 4; i++) {
        vec2 dir = vec2(cos(time * 0.2 + float(i)), sin(time * 0.15 + float(i)));
        value += amplitude * noise(uv + dir * time * speed);
        uv = rot * uv * 2.0 + shift;
        amplitude *= 0.5;
    }
    return value;
}

void fragment() {
    // 1. Pixelate UV coordinates to 640x360 grid
    vec2 pixel_uv = floor(UV * target_resolution) / target_resolution;

    // 2. Compute noise using the pixelated UVs
    vec2 uv = pixel_uv * scale;
    float time = TIME;

    vec2 q = vec2(0.0);
    q.x = fbm(uv + vec2(0.0, 0.0), time);
    q.y = fbm(uv + vec2(5.2, 1.3), time);

    vec2 r = vec2(0.0);
    r.x = fbm(uv + distortion * q + vec2(1.7, 9.2) + 0.15 * time, time);
    r.y = fbm(uv + distortion * q + vec2(8.3, 2.8) + 0.12 * time, time);

    float n = fbm(uv + distortion * r, time);
    n = clamp((n + 0.5) * 0.8, 0.0, 1.0);

    // 3. Compute gradient and lighting using pixelated UVs
    vec4 base_gradient = mix(shallow_color, deep_color, pixel_uv.y * 0.85 + 0.15);
    vec4 water_color = mix(base_gradient, shallow_color, smoothstep(0.1, 0.7, n));

    float caustic = pow(n, 3.5) * 1.8;
    vec4 final_color = mix(water_color, foam_color, clamp(caustic, 0.0, 1.0));

    COLOR = final_color;
}