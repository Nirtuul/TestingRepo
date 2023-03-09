// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

Shader "Hidden/NewImageEffectShader"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "white" {}
        _Poisson ("Fishy Ratio", Range(0.01,0.49)) = 0.42
        _LateralStrain ("Up/Down Strain", float) = 0.0
        _ForceAppliedX("Force being applied",float ) = 0.0
        _ForceAppliedY("Force being applied",float ) = 0.0
        _SquashValue("This is the actual value of squashing",vector)=(0.0, 0.0, 0.0, 0.0)
        _ScaleAmount("Arbitrary scale amount", float)=0.0
        _SquashMagnitude("Linear squash value", float) = 0.0
    }
    SubShader
    {
        // No culling or depth
        Cull Off ZWrite Off ZTest Always

        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag

            #include "UnityCG.cginc"
            #include "PoissonRatio.cginc"

            struct appdata
            {
                float4 vertex : POSITION;
                float2 uv : TEXCOORD0;
            };
            
            struct v2f
            {
                float2 uv : TEXCOORD0;
                float4 vertex : SV_POSITION;
            };
            
            v2f vert (appdata v)
            {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.uv = v.uv;
                //here i was playing with the idea that if you jump something should happen to my square
                    o.vertex.xy = Scale(o.vertex.xy);
                    o.vertex.xy = Squash(o.vertex.xy);
                   //o.vertex.xy = o.vertex.xy*2.0f;//StretchAndSquash(); //StretchAndSquash(); //UnityObjectToClipPos(v.vertex*float3(StretchAndSquash().xy,0));
                   //o.vertex.zw = o.vertex.zw*3;
                 //StretchAndSquash(o.vertex.xy);
                return o;
            }

            sampler2D _MainTex;
            
            float4 _MainTex_TexelSize;//not sure this var works the way i originally thought

            fixed4 frag (v2f i) : SV_Target
            {
                fixed4 col = tex2D(_MainTex, i.uv);
                // just invert the colors
                //_MainTex_TexelSize.zw = StretchAndSquash();
                col.rgb = 1 - col.rgb;
                return col;
            }
            ENDCG
        }
    }
}
