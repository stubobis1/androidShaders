#ifdef GL_FRAGMENT_PRECISION_HIGH
precision highp float;
#else
precision mediump float;
#endif

uniform vec2 resolution;
uniform int pointerCount;
uniform vec3 pointers[10];
uniform sampler2D backbuffer;
uniform sampler2D noise;

float get(float x, float y) {
	return texture2D(
		backbuffer,
		mod(gl_FragCoord.xy + vec2(x, y), resolution) / resolution).r;
}

vec3 evaluate(float sum) {
	float a = 1.0 - abs(clamp(sum - 3.0, -1.0, 1.0));
	float b = 1.0 - abs(clamp(sum - 2.0, -1.0, 1.0));
	return vec3(a + b * get(0.0, 0.0));
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
			&& step(.3, texture2D(noise, uv.xy * 50.).r) == 0.
			){
			sum = 3.0;
			break;
		}
	}

	gl_FragColor = vec4(evaluate(sum), 1.0);
}
