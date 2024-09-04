shader_type spatial;

uniform vec3 velocity = vec3(0, 0, 0);

void vertex() {
	// Called for every vertex the material is visible on.
	COLOR.xyz = vec3(1, 0, 0);
}

void fragment() {
	ALBEDO = vec3(0.1, 0.3, 0.5);
}

//void light() {
	// Called for every pixel for every light affecting the material.
	// Uncomment to replace the default light processing function with this one.
//}
