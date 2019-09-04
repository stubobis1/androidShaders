#ifdef GL_FRAGMENT_PRECISION_HIGH
precision highp float;
#else
precision mediump float;
#endif

uniform vec2 resolution;
uniform vec2 cameraAddent;
uniform mat2 cameraOrientation;
uniform samplerExternalOES cameraBack;

void main(void) {
	vec2 uv = gl_FragCoord.xy / resolution.xy;
	vec2 st = cameraAddent + uv * cameraOrientation;

	vec3 pix = texture2D(cameraBack, st).rgb;


	gl_FragColor = vec4(pix
		,1.0);
}
