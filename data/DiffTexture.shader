//Shader "Custom/Difftexture" {  
//    Properties {
//        _MainTex ("Base (RGB)", 2D) = "white" {}
//    }
//    SubShader {
//        Tags { "RenderType"="Opaque" }
//        LOD 200
//
//        CGPROGRAM
//        #pragma surface surf Lambert
//
//        sampler2D _MainTex;
//
//        struct Input {
//            float2 uv_MainTex;
//        };
//
//        void surf (Input IN, inout SurfaceOutput o) {
//            half4 c = tex2D (_MainTex, IN.uv_MainTex);
//            o.Albedo = c.rgb;
//            o.Alpha = c.a;
//        }
//        ENDCG
//    } 
//    FallBack "Diffuse"
//}
Shader "Custom/Diffhit"{
	Properties {  
	    _MainTex ("Base (RGB)", 2D) = "white" {}
	    _Bump ("Bump", 2D) = "bump" {}
	    _Snow ("Snow Level", Range(0,1) ) = 0
	    _SnowColor ("Snow Color", Color) = (1.0,1.0,1.0,1.0)
	    _SnowDirection ("Snow Direction", Vector) = (0,-1,0)
	    _SnowDepth ("Snow Depth", Range(0,0.3)) = 0.1
	}
    SubShader {
		Tags { "RenderType" = "Opaque" }
		CGPROGRAM
		#pragma surface surf Lambert vertex:vert  
			struct Input {  
			    float2 uv_MainTex;
			    float2 uv_Bump;
			    float3 worldNormal; INTERNAL_DATA
			};    
		 
			sampler2D _MainTex;  
			sampler2D _Bump;  
			float _Snow;  
			float4 _SnowColor;  
			float4 _SnowDirection;     
			float _SnowDepth;  

			void vert (inout appdata_full v) {  
			    if(dot(v.normal, _SnowDirection.xyz) <= lerp(-1,1, _Snow)) {
			        v.vertex.xyz += (_SnowDirection.xyz + v.normal) * _SnowDepth * _Snow;
			    }
			}

			void surf (Input IN, inout SurfaceOutput o) {  
			    half4 c = tex2D (_MainTex, IN.uv_MainTex);
			    o.Normal = UnpackNormal(tex2D(_Bump, IN.uv_Bump));

			    if (dot(WorldNormalVector(IN, o.Normal), _SnowDirection.xyz) < lerp(-1,1,_Snow)) {
			        o.Albedo = _SnowColor.rgb;
			    } else {
			        o.Albedo = c.rgb;
			    }

			    o.Alpha = c.a;
			}
      	ENDCG
    } 
    Fallback "Diffuse"
  }
//Shader "Custom/Diffhit"{
// Properties {
//    _MainTex (
//        "Texture", 2D) = "white" {}
//        _ColorTint ("Tint", Color) = (1.0, 0.6, 0.6, 1.0)
//        _Add("Add",Range(0,1)) = 0       
//    }
//    SubShader {
//      Tags { "RenderType" = "Opaque" }
//      CGPROGRAM
//      #pragma surface surf Lambert finalcolor:mycolor        
//      struct Input {
//          float2 uv_MainTex;
//      };       
//      fixed4 _ColorTint;  
//      float _Add;     
//      void mycolor (Input IN, SurfaceOutput o, inout fixed4 color) {
//           color *= _ColorTint;  
//           color += _ColorTint*_Add; 
//      }
//      sampler2D _MainTex;
//      void surf (Input IN, inout SurfaceOutput o) {
//           o.Albedo = tex2D (_MainTex, IN.uv_MainTex).rgb;
//      }
//      ENDCG
//    } 
//    Fallback "Diffuse"
//  }
//Shader "Custom/Difftexture"{
//	Properties {
//	   _MainTex ("Texture", 2D) = "white" {}
//	   _Detail ("Detail", 2D) = "bump" {}
//	}
//    SubShader {
//      Tags { "RenderType" = "Opaque" }
//      CGPROGRAM
//      #pragma surface surf Lambert
//      struct Input {
//          float2 uv_MainTex;
//          float4 screenPos;
//      };
//      sampler2D _MainTex;
//      sampler2D _Detail;
//      void surf (Input IN, inout SurfaceOutput o) {
//          o.Albedo = tex2D (_MainTex, IN.uv_MainTex).rgb;
//          float2 screenUV = IN.screenPos.xy / IN.screenPos.w; //2          
//          //screenUV *= float2(8,6);          
//          o.Albedo *= tex2D (_Detail, screenUV).rgb * 2;       
//      }
//      ENDCG
//    } 
//    Fallback "Diffuse"
//  }
//Shader "Custom/Difftexture"{
//	Properties {
//		_MainTex ("Texture", 2D) = "white" {}
//		_BumpMap ("Bumpmap", 2D) = "bump" {}
//		_RimColor ("Rim Color", Color) = (0.26,0.19,0.16,0.0)//1
//		_RimPower ("Rim Power", Range(0.5,8.0)) = 3.0 //2
//	}
//    SubShader {
//      Tags { "RenderType" = "Opaque" }
//      CGPROGRAM
//      #pragma surface surf Lambert
//      struct Input {
//          float2 uv_MainTex;
//          float2 uv_BumpMap; float3 viewDir; //3      
//      };
//      sampler2D _MainTex;
//      sampler2D _BumpMap;       
//      float4 _RimColor;//4       
//      float _RimPower;//5 
//      void surf (Input IN, inout SurfaceOutput o) {
//          o.Albedo = tex2D (_MainTex, IN.uv_MainTex).rgb;
//          o.Normal = UnpackNormal (tex2D (_BumpMap, IN.uv_BumpMap));             
//          half rim = 1.0 - saturate(dot (normalize(IN.viewDir), o.Normal));//6         
//          //o.Emission = _RimColor.rgb * pow (rim, _RimPower);//7 
//          o.Emission = _RimColor.rgb * rim * _RimPower;
//      }
//      ENDCG
//    } 
//	FallBack "Diffuse"
//}

//Shader "Custom/DiffTexture" {
//	Properties {
//		_Color ("Color", Color) = (1,1,1,1)
//		_MainTex ("Albedo (RGB)", 2D) = "white" {}
//		_Glossiness ("Smoothness", Range(0,1)) = 0.5
//		_Metallic ("Metallic", Range(0,1)) = 0.0
//	}
//	SubShader {
//		Tags { "RenderType"="Opaque" }
//		LOD 200
//		
//		CGPROGRAM
//		// Physically based Standard lighting model, and enable shadows on all light types
//		#pragma surface surf Standard fullforwardshadows
//
//		// Use shader model 3.0 target, to get nicer looking lighting
//		#pragma target 3.0
//
//		sampler2D _MainTex;
//
//		struct Input {
//			float2 uv_MainTex;
//		};
//
//		half _Glossiness;
//		half _Metallic;
//		fixed4 _Color;
//
//		void surf (Input IN, inout SurfaceOutputStandard o) {
//			// Albedo comes from a texture tinted by color
//			fixed4 c = tex2D (_MainTex, IN.uv_MainTex) * _Color;
//			o.Albedo = c.rgb;
//			// Metallic and smoothness come from slider variables
//			o.Metallic = _Metallic;
//			o.Smoothness = _Glossiness;
//			o.Alpha = c.a;
//		}
//		ENDCG
//	} 
//	FallBack "Diffuse"
//}
