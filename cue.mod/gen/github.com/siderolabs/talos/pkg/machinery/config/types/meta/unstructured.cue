package meta

// cue get go cannot express the upstream yaml:",inline" tag on
// Unstructured.Object; defs removes the generated copy so this flat,
// semantically-equivalent def stands in for it.
#Unstructured: {...}
