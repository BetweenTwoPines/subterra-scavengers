#define FADE_SCALE 30.0
#define OCTAVES 6 // Number of times to randomly generate values
#define FREQUENCY 0.4 // Increased frequency for more waves
#define AMPLITUDE 4 // Adjusted amplitude for higher waves

varying mediump vec2 var_texcoord0;

uniform lowp vec4 time; // provided by water.script

float rand(vec2 n) { 
    return fract(sin(dot(n, vec2(12.9898, 4.1414))) * 43758.5453);
}

// simpple random noise
float noise(vec2 x)
{
    vec2 i = floor(x);
    vec2 f = x - i;
    f *= f * (3.0 - 2.0 * f);
    return mix(mix(rand(i), rand(i + vec2(1.0, 0.0)), f.x),
    mix(rand(i + vec2(0.0, 1.0)), rand(i + vec2(1.0, 1.0)), f.x), f.y);
}

// Fractal Brownian Motion https://thebookofshaders.com/13/
float fbm(vec2 st) {
    float value = 0.0;
    float amplitude = AMPLITUDE;
    for (int i = 0; i < OCTAVES; i++) {
        value += amplitude * noise(st * FREQUENCY);
        st *= 2.0;
        amplitude *= 0.5;
    }
    return value;
}

vec4 render(vec2 uv)
{
    float n = 0.06 * (fbm(vec2(uv.x, 4.0)) + fbm(vec2(uv.x + time.x, 4.0)));
    float d = (uv.y + n - 1.0) * FADE_SCALE;
    float t = clamp(d, 0.0, 1.0);

    vec3 skyColor = vec3(0.0, 0.0, 0.0);
    vec3 waterColor = vec3(0.0, 0.3, 0.5) + 0.3 * uv.y;
    vec3 color = mix(waterColor, skyColor, t);
    float alpha = mix(1.0, 0.0, t); // Water is opaque, sky is transparent
    return vec4(color, alpha);
}

void main()
{
    vec2 resolution = vec2(1.0, 1.0);
    float aspect = resolution.x / resolution.y;
    
    vec2 coord = var_texcoord0;
    coord.y -= 0.55;
    vec2 uv = (2.0 * coord - resolution) / resolution.y;

    gl_FragColor = render(2.0 * uv + vec2(-aspect, 1.0));;
}
