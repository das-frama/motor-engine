struct VS_INPUT
{
    float4 position: POSITION;
    float2 texcoord: TEXCOORD;
    float3 normal:   NORMAL;
};

struct VS_OUTPUT
{
    float4 position: SV_POSITION;
    float2 texcoord: TEXCOORD;
    float3 normal:   NORMAL;
};

cbuffer constant : register(b0)
{
    row_major float4x4 world;
    row_major float4x4 view;
    row_major float4x4 proj;
};

VS_OUTPUT vsmain(VS_INPUT input)
{
    VS_OUTPUT output = (VS_OUTPUT)0;

    // // world.
    output.position = mul(input.position, world);
    // // // view.
    output.position = mul(output.position, view);
    // // // screen space.
    output.position = mul(output.position, proj);

    // output.position = input.position;
    output.texcoord = input.texcoord;
    output.normal = input.normal;

    return output;
}