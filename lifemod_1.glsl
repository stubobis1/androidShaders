#ifdef GL_FRAGMENT_PRECISION_HIGH
precision highp float;
#else
precision mediump float;
#endif

#define PI 3.14159265359;

uniform vec2 resolution;
uniform int pointerCount;
uniform vec3 pointers[10];
uniform sampler2D backbuffer;
uniform sampler2D noise;

float get(float x, float y) {
	return texture2D(
		backbuffer,
		mod(gl_FragCoord.xy + vec2(x, y),
			resolution) / resolution).a;
}

vec4 evaluate(float sum) {
	float a = 1.0 - abs(clamp(sum - 3.0, -1.0, 1.0));
	float b = 1.0 - abs(clamp(sum - 2.0, -1.0, 1.0));
	return vec4(a + b * get(0.0, 0.0));
}

vec3 modcol(vec2 uv, vec4 orgcol){


	vec2 uv = gl_FragCoord.xy / resolution.xy;
	uv-= .5;
	uv *= 10.;
	uv.x *= resolution.x/resolution.y;

	vec2 t;
	t.x = atan(uv.x /(uv.y )) / PI;
	t.y = 1./length(uv) ;
	float d = t.y * 2.;


	vec4 c = vec4 (texture2D(
		backbuffer,mod(t, 1.)).a);

	return c.rgb;
	}

void main() {
	vec2 uv = gl_FragCoord.xy / resolution;
	float sum =
		get(-1.0, -1.0) +
		get(-1.0, 0.0) +
		get(-1.0, 1.0) +
		get(0.0, -1.0) +
		get(0.0, 1.0) +
		get(1.0, -1.0) +
		get(1.0, 0.0) +
		get(1.0, 1.0);

	float tap = min(resolution.x, resolution.y) * 0.05;
	for (int n = 0; n < pointerCount; ++n) {

		if (distance(pointers[n].xy, gl_FragCoord.xy) < tap

			//&& mod( gl_FragCoord.y * 	gl_FragCoord.x, 2.) == 0.
			&& step(.05, texture2D(noise, uv.xy * 50.).r) == 0.
			){
			sum = 3.0;
			break;
		}
	}

	vec4 lifecol = evaluate(sum);
	gl_FragColor = vec4( modcol(uv,lifecol).rg, lifecol.a , lifecol.r);
}
