#ifdef GL_FRAGMENT_PRECISION_HIGH
precision highp float;
#else
precision mediump float;
#endif

uniform vec2 resolution;
uniform float time;

void main(void) {
	vec2 uv = gl_FragCoord.xy; // / resolution.xy;
	vec3 col;
	uv *= .06;
	uv.x += sin(time);
	uv.y += cos(time);
	col.r = mod(uv.x,1.);
	col.g = mod(mod(uv.y, 8.)	, mod(mod(uv.x, 8.) * abs(sin(time)), 8.));
	col.b = mod(uv.y,1.);

	gl_FragColor = vec4(col, 1.0);
}
