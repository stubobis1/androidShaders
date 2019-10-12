#ifdef GL_FRAGMENT_PRECISION_HIGH
precision highp float;
#else
precision mediump float;
#endif

#define PI 3.14159265359;
#define halfPI 1.57079632679;
#define twoPI 6.28318530718;
#define fourPI 12.5663706144;
uniform vec2 resolution;
uniform sampler2D noise;
uniform sampler2D perlinnoise;
uniform float time;

vec4 gettexat(vec2 pos)
{
	vec4 col;
	col =
	texture2D(perlinnoise,pos);
	//texture2D(noise,pos);

	col.r = texture2D(perlinnoise,pos * 3.).r;
	col.g = (col.r + col.b - .3);
	//col.b /= 1. /( col.b + col.g);

	return col;
	}

void main(void) {
	float tme = time/2.;
	vec2 uv = gl_FragCoord.xy / resolution.xy;
	uv-= .5;
	uv *= 10.;
	uv.x *= resolution.x/resolution.y;

	uv.y += tan(tme *.5) ;
	uv.x += .0;


	vec2 t;
	t.x = atan(uv.x /uv.y ) / PI;
	t.y = 1./length(uv) * 2.;

	float fp = fourPI;
	float tp = twoPI;
  float hp = halfPI;
  float p = PI;

	float d = t.y * 2.;
  float sign = sign(mod(tme + p, fp) - tp);
	t.y += (tme ) * sign;
	t.x += tme * .2 * sign; //sign?


	vec4 r;
	r= gettexat(t) / d;
	if( d > 50.){
		r *= vec4(95.);
		}
	//r.b *= sign;
	gl_FragColor = r;
}
