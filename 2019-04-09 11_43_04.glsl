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
uniform sampler2D checkers;

vec2 modpos(vec2 pos)
{
	float pi = halfPI;
	pos=abs(pos);
	pos.x+= pos.y * .2;
	pos=mod(pos, 2.);
	pos.x +=  (sin(time * .4) + 1.) * 2.;

	return pos;
}

vec4 checker(vec2 pos)
{

	return vec4(
		mod(
			ceil( mod (pos.x ,2.) -1.) +
			ceil( mod (pos.y ,2.) -1.)
		,2.)
	);
}

vec4 pnoise(vec2 pos)
{
	return texture2D(perlinnoise, pos);
}
vec4 gettexat(vec2 pos)
{
	vec4 col;
	col = vec4(
		pnoise (modpos(vec2(pos.x * 8., pos.y * 0.6)))
	);

	col *= vec4(.717,.545,.141,1.);
	//texture2D(checkers,pos);
	//texture2D(noise,pos);

	//col.r = texture2D(checkers,pos * 3.).r;
	//col.r = checker( pos ,8. + time,20.);
	float vq =  (modpos(vec2(pos.x * 6., pos.y * 40.))).r * .7;
	vq = smoothstep(0.,.7, vq);



	float vw =  (modpos(vec2(pos.x * -8., pos.y * 0.))).r;



	//col.g = (col.r + col.b) * .5;
	//col.g = checker( pos ,4.1,10.);
	//col.b /= 1. /( col.b + col.g);


	col += vec4 (.2,.3,.5 ,.1) *vq;
	return col;
	}

void main(void) {
	float tme = (time + 7.)/2.;
	vec2 uv = gl_FragCoord.xy / resolution.xy;
	uv-= .5;
	uv *= 10.;
	uv.x *= resolution.x/resolution.y;

	uv.y += tan(tme *.5) ;
	uv.x += .0;


	vec2 t;
	t.x = atan(uv.x /uv.y ) / PI;
	t.y = 1./length(uv) * 2.;
	float d = t.y * 2.;



	float fp = fourPI;
	float tp = twoPI;
  float hp = halfPI;
  float p = PI;


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
