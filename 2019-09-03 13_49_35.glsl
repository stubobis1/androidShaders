#ifdef GL_FRAGMENT_PRECISION_HIGH
precision highp float;
#else
precision mediump float;
#endif

uniform vec2 resolution;
uniform float time;

float rnd(float i){
	i = mod(i, 1.);
	return fract(sin(time + i * 10000.));
	}


	float rnd(vec2 i){
	i = mod(i, 1.);
	float v = dot(i.xy, vec2(15,84.));
	return fract(sin(time + v * 1000.));
	}

	float random (vec2 st) {
		//st += mod(time * 2.45, 16.);
    return fract(sin(dot(st.xy,
                         vec2(12.9898,78.233)))*
        43758.5453123);
}
void main(void) {
	vec2 uv = gl_FragCoord.xy / resolution.xy;
	vec3 col;
	col.r = random(uv);
	col.g = random(vec2(uv.y,uv.x));
	col.b = random(vec2(uv.y,uv.y));
	gl_FragColor = vec4(col, 1.0);
}
