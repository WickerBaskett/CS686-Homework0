shader_type spatial;

void vertex() {
	VERTEX.y += abs(VERTEX.x + VERTEX.z);
}

void fragment() {
	ALBEDO = vec3(1, 0, 0);
}

//void light() {
	// Called for every pixel for every light affecting the material.
	// Uncomment to replace the default light processing function with this one.
//}
