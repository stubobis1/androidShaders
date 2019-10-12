#ifdef GL_FRAGMENT_PRECISION_HIGH
precision highp float;
#else
precision mediump float;
#endif

uniform vec2 resolution;



void main(void) {
	vec2 uv = gl_FragCoord.xy / resolution.xy;


	uv.x = atan(uv.x / uv.y);
	uv.y = length(uv);

	uv.x = clamp(0.,1.,uv.x);
	gl_FragColor = vec4(uv, 1.0, 1.0);
}
