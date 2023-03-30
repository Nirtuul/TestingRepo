#ifndef POISSONRATIO
#define POISSONRATIO

vector _SquashValue;
float _SquashMagnitude;
float _TimeElapsed;


inline float2 StretchMatrixForm(inout float2 value)
{
    fixed squashAmountX = clamp(abs(_SquashValue.x),abs(_SquashValue.x * _SquashMagnitude),_TimeElapsed/100);
    
   
    //Matrix for squash in the x  axis
    float2x2 StretchX = float2x2(squashAmountX, 0.0,
                                 0.0,           1.0);
    //here is where we have the transversal strain for poisson's ratio so we could apply matrix
    //compare value obtained with initial value and from that we could solve for axial strain and give it to the next matrix
    float DEtrans = length(mul(value, StretchX)-value);//length this to get a float value of the difference of transversal strain
    float v=.49;
    float DEaxial = DEtrans/(-v);
    fixed squashAmountY = clamp(abs(_SquashValue.y),((abs(_SquashValue.y)) * _SquashMagnitude),_TimeElapsed/100);
    fixed poissonSquash = clamp(0.0,DEaxial,_TimeElapsed/100);
    //stretch Martix for y axis with poisson's ratio built in
    float2x2 stretchY = float2x2(1.0,           0.0,
                                 0.0,           squashAmountY-poissonSquash);
    //shear matrix for slant when moving
    float2x2 ShearMat = float2x2(1.0,0.0,
                                 (_SquashValue.x-1)/10,1.0);
    //final composition matrix for stretch
    float2x2 stretchMartix = mul(StretchX,stretchY);
    //adding in the shear for final comp. Matrix
    float2x2 DeformationMat = mul(ShearMat,stretchMartix);
                                    
    return mul(value, DeformationMat);
}

#endif
