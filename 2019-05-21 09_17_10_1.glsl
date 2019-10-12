#ifdef GL_FRAGMENT_PRECISION_HIGH
precision highp float;
#else
precision mediump float;
#endif

uniform vec2 resolution;
uniform sampler2D noise;
uniform float ftime;
uniform float time;

vec4 gettexat(vec2 pos)
{
	return
	texture2D(noise,pos * atan(time + 10. * sin( time * 3.)));
	}

void main(void) {
	vec2 uv = gl_FragCoord.xy / resolution.xy;
	uv-= .5;
	uv.x *= resolution.x/resolution.y;


	vec2 t;
	t.x = atan(uv.x/uv.y) / 3.1415;
	t.y = 1./length(uv) * 2.;

	vec4 r;
	r= gettexat(t);

	gl_FragColor = r;
}
