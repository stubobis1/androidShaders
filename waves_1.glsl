#ifdef GL_FRAGMENT_PRECISION_HIGH
precision highp float;
#else
precision mediump float;
#endif

uniform vec2 resolution;
uniform float time;





float plot(vec2 st, float pct){
	float thick = 0.04;

return smoothstep( pct-thick, pct, st.y) -

 smoothstep( pct, pct+thick, st.y);

}


void main(void) {

 vec2 st = gl_FragCoord.xy/ resolution.xy;
		st *= 5.;

	vec3 col;
	for(int i= 2; i < 20; i++)
	{

		float pc = plot(st, sin(st.x * float(i) + time / float(i))+2.);
		col.g += pc;
		}



 gl_FragColor = vec4(col,1.0);

}



