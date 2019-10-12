#ifdef GL_FRAGMENT_PRECISION_HIGH
precision highp float;
#else
precision mediump float;
#endif

uniform vec2 resolution;
uniform float battery;
uniform float time;

void main(void) {
	vec2 uv = gl_FragCoord.xy / resolution.xy;
	vec3 color = vec3(0.,1.,0.5);
	color *= abs(sin(time));
	gl_FragColor = vec4(
		vec3(step(uv.y, battery) * color),
		1.0);
}
