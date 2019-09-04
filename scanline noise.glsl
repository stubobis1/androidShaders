	#ifdef GL_FRAGMENT_PRECISION_HIGH
precision highp float;
#else
precision mediump float;
#endif

uniform vec2 resolution;
uniform float time;





float rnd (vec2 st) {
    return fract(sin(dot(st.xy,
                         vec2(12.9898,78.233)))*
        43758.5453123);
}

vec4 drawImage( vec2 fragCoord )
{
    // Normalized pixel coordinates (from 0 to 1)
    vec2 uv = fragCoord/resolution.xy;
    uv.x *= 160.;
    uv.y *= 120.;

    vec2 ipos = ceil(uv);  // get the integer coords
    vec3 col = vec3(rnd(ipos + time));
    col +=  abs(vec3(tan(fragCoord.y - time * 8.)) * 0.1);

    // Output to screen
    return vec4(col,1.0);
}



void main(void) {
	gl_FragColor = drawImage(gl_FragCoord.xy);
}
