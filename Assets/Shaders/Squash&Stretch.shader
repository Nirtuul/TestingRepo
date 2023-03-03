Shader "Hidden/NewImageEffectShader"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "white" {}
        _Poisson ("Fishy Ratio", Range(0.01,0.49)) = 0.42
        _LateralStrain ("Up/Down Strain", float) = 0.0
        _ForceAppliedX("Force being applied",float ) = 0.0
        _ForceAppliedY("Force being applied",float ) = 0.0
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
                if(_ForceAppliedY>0)
                {
                   o.uv = squeeze(o.uv);
                }
                //StretchAndSquash(o.vertex.xy);
                return o;
            }

            sampler2D _MainTex;
            
            //float4 _MainTex_TexelSize;//not sure this var works the way i originally thought

            fixed4 frag (v2f i) : SV_Target
            {
                fixed4 col = tex2D(_MainTex, i.uv);
                // just invert the colors
                col.rgb = 1 - col.rgb;
                return col;
            }
            ENDCG
        }
    }
}
