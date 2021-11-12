Texture2D Texture: register(t0);
sampler TextureSampler: register(s0);

cbuffer constant : register(b0)
{
    row_major float4x4 world;
    row_major float4x4 view;
    row_major float4x4 proj;
};

struct PS_INPUT
{
    float4 position: SV_POSITION;
    float2 texcoord: TEXCOORD;
    float3 normal:   NORMAL;
};

float4 psmain(PS_INPUT input) : SV_TARGET
{
    float light_direction = float3(0.5, 0.5, 0.5);
    float direction_to_camera = float3(1, 0, 1);

    //AMBIENT LIGHT
    float ka = 0.1;
    float3 ia = float3(1.0, 1.0, 1.0);

    float3 ambient_light = ka * ia;

    //DIFFUSE LIGHT
    float kd = 0.7;
    float3 id = float3(1.0, 1.0, 1.0);
    float amount_diffuse_light = max(0.0, dot(light_direction, input.normal));

    float3 diffuse_light = kd * amount_diffuse_light * id;

    //SPECULAR LIGHT
    float ks = 1.0;
    float3 is = float3(1.0, 1.0, 1.0);
    float3 reflected_light = reflect(light_direction, input.normal);
    float shininess = 30.0;
    float amount_specular_light = pow(max(0.0, dot(reflected_light, direction_to_camera)), shininess);

    float3 specular_light = ks * amount_specular_light * is;

    float3 final_light = ambient_light + diffuse_light + specular_light;

    return float4(final_light,1.0);
}