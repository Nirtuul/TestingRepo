#ifndef POISSONRATIO
#define POISSONRATIO

vector _SquashValue;
float _SquashMagnitude;
float _TimeElapsed;


inline float2 StretchMatrixForm(inout float2 value)
{
    fixed squashAmountX = clamp(abs(_SquashValue.x),((abs(_SquashValue.x)) * _SquashMagnitude),_TimeElapsed/100);
    fixed squashAmountY = clamp(abs(_SquashValue.y),((abs(_SquashValue.y)) * _SquashMagnitude),_TimeElapsed/100);
   
    //composition matrix for squash in the x and y axis
    float2x2 StretchX = float2x2(squashAmountX, 0.0,
                                 0.0,           1.0);
    float2x2 stretchY = float2x2(1.0,           0.0,
                                 0.0,           squashAmountY);
    float2x2 ShearMat = float2x2(1.0,0.0,
                                 (_SquashValue.x-1)/10,1.0);
    
    float2x2 stretchMartix = mul(StretchX,stretchY);
    float2x2 DeformationMat = mul(ShearMat,stretchMartix);
                                    
    return mul(value, DeformationMat);
}

#endif
