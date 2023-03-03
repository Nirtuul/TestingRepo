#ifndef POISSONRATIO
#define POISSONRATIO


float _Poisson;
float _ForceAppliedX;
float _ForceAppliedY;
float _LateralStrain;
float4 _MainTex_TexelSize;//not sure this var works

inline float2 StretchAndSquash(inout float2 vert )
{
    //attempted to use poisson's ratio directly
    
    //notes for me{
   //here we want to move the vertices in the direction of the force being applied to them and to scale
   //so we need an in of the vertices and then a return of the modified vertices
   //as well as an in of the force we will take poisson's ratio to calculate the deformation}
    float ExoverEy = -_Poisson;
    //float Ex = 
    
    float2 forceApplied = float2(_ForceAppliedX, _ForceAppliedY);
    
    //float finalDefX;
    //float finalDefY;
    //float deltaLY = finalDefY-_MainTex_TexelSize.w; //LFy -Ly
    //float deltaLX = finalDefX-_MainTex_TexelSize.z;
    //float Ey = deltaLY/_MainTex_TexelSize.w;
    //float Ex = deltaLX/_MainTex_TexelSize.z;
    //
    //_Poisson = Ex/Ey
    
    return float2(0,0);
}
inline float2 squeeze(in float2 IN)
{
    //tried to use deformation matrices for squeeze and stretch as a way to get changes in vertices just to test ans see changes
    
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
