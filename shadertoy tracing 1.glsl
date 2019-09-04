#ifdef GL_FRAGMENT_PRECISION_HIGH
precision highp float;
#else
precision mediump float;
#endif

uniform vec2 resolution;
uniform float time;




/**
 * Part 1 Challenges
 * - Make the circle yellow
 * - Make the circle smaller by decreasing its radius
 * - Make the circle smaller by moving the camera back
 * - Make the size of the circle oscillate using the sin() function and the iTime
 *   uniform provided by shadertoy
 */

const int MAX_MARCHING_STEPS = 255;
const float MIN_DIST = 0.0;
const float MAX_DIST = 100.0;
const float EPSILON = 0.0001;

/**
 * Signed distance function for a sphere centered at the origin with radius 1.0;
 */
float sphereSDF(vec3 samplePoint, float size) {
    return length(samplePoint) - size;
}

/**
 * Signed distance function describing the scene.
 *
 * Absolute value of the return value indicates the distance to the surface.
 * Sign indicates whether the point is inside or outside the surface,
 * negative indicating inside.
 */
float sceneSDF(vec3 samplePoint) {
    return sphereSDF(samplePoint, 3.0 );
}

/**
 * Return the shortest distance from the eyepoint to the scene surface along
 * the marching direction. If no part of the surface is found between start and end,
 * return end.
 *
 * eye: the eye point, acting as the origin of the ray
 * marchingDirection: the normalized direction to march in
 * start: the starting distance away from the eye
 * end: the max distance away from the eye to march before giving up
 */
float shortestDistanceToSurface(vec3 eye, vec3 marchingDirection, float start, float end, out int steps) {
    float depth = start;
    for (int i = 0; i < MAX_MARCHING_STEPS; i++) {
    	steps = i;
        float dist = sceneSDF(eye + depth * marchingDirection);
        if (dist < EPSILON) {
					return depth;
        }
        depth += dist;
        if (depth >= end) {
            return end;
        }
    }
    return end;
}


/**
 * Return the normalized direction to march in from the eye point for a single pixel.
 *
 * fieldOfView: vertical field of view in degrees
 * size: resolution of the output image
 * fragCoord: the x,y coordinate of the pixel in the output image
 */
vec3 rayDirection(float fieldOfView, vec2 size, vec2 fragCoord) {
    vec2 xy = fragCoord - size / 2.0;
    float z = size.y / tan(radians(fieldOfView) / 2.0);
    return normalize(vec3(xy, -z));
}


vec4 drawImage(vec2 fragCoord )
{
	vec4 fragColor;
	vec3 dir = rayDirection(90.0, resolution.xy, fragCoord);
  vec3 eye = vec3(0.0, 0.0, 10.0);
  int steps;
  float dist = shortestDistanceToSurface(eye, dir, MIN_DIST, MAX_DIST, steps);

    if (dist > MAX_DIST - EPSILON) {
        // Didn't hit anything
        return vec4(0.0, 0.0, 0.0, 0.0);

    }
		vec4 glow = vec4(1.) * float(steps)/100.0;
    return vec4(0.1,0.1,0.1 , 1.0) + glow;
}



void main(void) {
	gl_FragColor = drawImage(gl_FragCoord.xy);
}
