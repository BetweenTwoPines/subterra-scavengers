varying mediump vec2 var_texcoord0;
varying highp vec4 world_position;

uniform lowp sampler2D texture_sampler;

uniform highp vec4 maxLightDistance;
uniform highp vec4 lightPosition;

void main()
{
    // Pre-multiply alpha since all runtime textures are premultiplied
    lowp vec4 tex_color = texture2D(texture_sampler, var_texcoord0.xy);

    // Calculate distance from light to this fragment
    float distance = length(world_position.xyz - lightPosition.xyz);

    // If distance is less than maxLightDistance.x, step returns 0.0 (because the fragment is within the light radius), making alpha equal to 1.0.
    float alpha = 1.0 - step(maxLightDistance.x, distance);

    // Apply the light intensity
    gl_FragColor = tex_color * alpha;
}