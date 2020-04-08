Shader "Custom/Flora" {
	Properties{
	_Color("Main Color", Color) = (1,1,1,1)
	_MainTex("MainTex", 2D) = "white" {}
	_OverlayTex("OverlayDiff", 2D) = "white" {}
	_BumpMap("Normal", 2D) = "bump" {}
	_Cutoff("Alpha cutoff", Range(0,1)) = 0.5 
	}

		SubShader{
		Tags{ "Queue" = "AlphaTest" "IgnoreProjector" = "True" "RenderType" = "TransparentCutout" }
		LOD 200
		Cull Off


		CGPROGRAM

#pragma target 3.0
#pragma surface surf Lambert alphatest:_Cutoff vertex
//#pragma surface surf Lambert

		struct Input {
		float2 uv_MainTex;
		float2 uv_BumpMap;
		float2 uv2_OverlayTex;
	};

	sampler2D _MainTex;
	sampler2D _BumpMap;
	sampler2D _OverlayTex;
	fixed4 _Color;

	void surf(Input IN, inout SurfaceOutput o) {
		fixed4 c = tex2D(_MainTex, IN.uv_MainTex) * _Color;
		fixed4 c2 = tex2D(_OverlayTex, IN.uv2_OverlayTex) * _Color;
		o.Albedo = c.rgb*c2.rgb;

		o.Normal = UnpackNormal(tex2D(_BumpMap, IN.uv_BumpMap));
		o.Alpha = c.a;
	}
	ENDCG
	}
		Fallback "Transparent/Cutout/VertexLit"
}