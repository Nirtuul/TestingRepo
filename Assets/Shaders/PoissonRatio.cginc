#ifndef POISSONRATIO
#define POISSONRATIO


float _Poisson;
float _ForceAppliedX;
float _ForceAppliedY;
float _LateralStrain;
vector _SquashValue;
float _ScaleAmount;
float _SquashMagnitude;
//float4 _MainTex_TexelSize;//not sure this var works
inline fixed2 Scale (inout fixed2 value)
{

    return value *= _ScaleAmount;

}
inline fixed2 Squash(inout fixed2 value)
{
    fixed squashAmount = (abs(_SquashValue.x) - abs (_SquashValue.y)) * _SquashMagnitude;
    
    value.x += squashAmount * sign (value.x);
    value.y += -squashAmount * sign (value.y);
    return value;
}
//inline float2 StretchAndSquash( )
//{
//    //attempted to use poisson's ratio directly
//    
//    //notes for me{
//   //here we want to move the vertices in the direction of the force being applied to them and to scale
//   //so we need an in of the vertices and then a return of the modified vertices
//   //as well as an in of the force we will take poisson's ratio to calculate the deformation}
//    float ExoverEy = -_Poisson;
//    //float Ex = 
//    
//    float2 forceApplied = float2(_ForceAppliedX, _ForceAppliedY);
//    
//    //float finalDefX;
//    //float finalDefY;
//    //float deltaLY = finalDefY-_MainTex_TexelSize.w; //LFy -Ly
//    //float deltaLX = finalDefX-_MainTex_TexelSize.z;
//    //float Ey = deltaLY/_MainTex_TexelSize.w;
//    //float Ex = deltaLX/_MainTex_TexelSize.z;
//    //
//    //_Poisson = Ex/Ey
//    float3 squashVector = float3(_SquashValue, -_SquashValue, 0.0);
//    //float squashValue = Mathf.Clamp(((Mathf.Abs(_acceleration.x)) - Mathf.Abs(_acceleration.y)) * magnitude, -maxStretch, maxStretch);
//    float3 worldScale = float3(
//    length(float3(unity_ObjectToWorld[0].x, unity_ObjectToWorld[1].x, unity_ObjectToWorld[2].x))+squashVector.x, // scale x axis
//    length(float3(unity_ObjectToWorld[0].y, unity_ObjectToWorld[1].y, unity_ObjectToWorld[2].y))+squashVector.y, // scale y axis
//    length(float3(unity_ObjectToWorld[0].z, unity_ObjectToWorld[1].z, unity_ObjectToWorld[2].z))  // scale z axis
//    );
//    
//    //_MainTex_TexelSize.zw = ( worldScale.xy+squashVector.xy); 
//    return worldScale;
//    
//}
//half3 ObjectScale() {
//    return half3(
//        length(unity_ObjectToWorld._m00_m10_m20),
//        length(unity_ObjectToWorld._m01_m11_m21),
//        length(unity_ObjectToWorld._m02_m12_m22)
//    );
//}
inline float2 squeeze(in float2 IN)
{
    //tried to use deformation matrices for squeeze and stretch as a way to get changes in vertices just to test and see changes
    
    float k =_Poisson;
    float2x2 squezeMatrix = float2x2(k, 0, 0, 1/k);
    float2 modified = mul(IN , squezeMatrix);
    return modified;
}

inline float2 Stretch(in float2 IN)
{
    float k = _Poisson;
    float2x2 stretchMatrix = float2x2(k, 0, 0, 1);
    float2 modified = mul(IN, stretchMatrix);
    return modified;
}
#endif
