#ifdef GL_FRAGMENT_PRECISION_HIGH
precision highp float;
#else
precision mediump float;
#endif

uniform int pointerCount;
uniform vec3 pointers[10];
uniform vec2 resolution;
uniform sampler2D perlinnoise;
uniform sampler2D backbuffer;

void main(void) {
	float mx = max(resolution.x, resolution.y);
	vec2 uv = gl_FragCoord.xy / mx;
	vec3 color = vec3(0.0);

	for (int n = 0; n < pointerCount; ++n) {
		color = max(color, smoothstep(
			0.085,
			0.08,
			distance(uv, pointers[n].xy / mx)));
	}
	color.xyz *= texture2D(perlinnoise, uv).xyz;
	color.xyz += texture2D(backbuffer, gl_FragCoord.xy).xyz;
	gl_FragColor = vec4(color, 1.0);
}
