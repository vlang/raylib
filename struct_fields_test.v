module main

import raylib

// vlang/raylib#32: V reads `font.glyphCount` as the C member `glyphCount`, so a binding that spells
// a C struct's member differently (`glyph_count`) compiles in V and fails in the C compiler. Every
// member below is spelled as raylib.h spells it.

fn test_font_and_glyph_members() {
	mut glyph := raylib.GlyphInfo{}
	glyph.value = 65
	glyph.offsetX = -3
	glyph.offsetY = 7
	glyph.advanceX = 19
	assert glyph.value == 65 && glyph.offsetX == -3 && glyph.offsetY == 7 && glyph.advanceX == 19

	mut font := raylib.Font{}
	font.baseSize = 32
	font.glyphCount = 95
	font.glyphPadding = 4
	assert font.baseSize == 32 && font.glyphCount == 95 && font.glyphPadding == 4
}

fn test_mesh_and_model_members() {
	mut mesh := raylib.Mesh{}
	mesh.vertexCount = 24
	mesh.triangleCount = 12
	mesh.boneCount = 2
	mesh.vaoId = 5
	assert mesh.vertexCount == 24 && mesh.triangleCount == 12 && mesh.boneCount == 2 && mesh.vaoId == 5
	assert isnil(mesh.animVertices) && isnil(mesh.animNormals) && isnil(mesh.boneIndices)
	assert isnil(mesh.boneWeights) && isnil(mesh.vboId)

	mut model := raylib.Model{}
	model.meshCount = 3
	model.materialCount = 2
	assert model.meshCount == 3 && model.materialCount == 2
	assert isnil(model.meshMaterial) && isnil(model.boneMatrices)
}

fn test_audio_members() {
	mut stream := raylib.AudioStream{}
	stream.sampleRate = 44100
	stream.sampleSize = 16
	stream.channels = 2
	assert stream.sampleRate == 44100 && stream.sampleSize == 16 && stream.channels == 2

	mut sound := raylib.Sound{}
	sound.frameCount = 1000
	assert sound.frameCount == 1000

	mut music := raylib.Music{}
	music.frameCount = 2000
	music.ctxType = 1
	assert music.frameCount == 2000 && music.ctxType == 1 && isnil(music.ctxData)

	mut wave := raylib.Wave{}
	wave.frameCount = 3000
	wave.sampleRate = 22050
	wave.sampleSize = 8
	wave.channels = 1
	assert wave.frameCount == 3000 && wave.sampleRate == 22050 && wave.sampleSize == 8 && wave.channels == 1
}

fn test_vr_members() {
	mut info := raylib.VrDeviceInfo{}
	info.hResolution = 1920
	info.vResolution = 1080
	info.hScreenSize = 0.12
	info.vScreenSize = 0.07
	info.eyeToScreenDistance = 0.04
	info.lensSeparationDistance = 0.06
	info.interpupillaryDistance = 0.063
	assert info.hResolution == 1920 && info.vResolution == 1080
	assert info.hScreenSize == f32(0.12) && info.interpupillaryDistance == f32(0.063)

	mut config := raylib.VrStereoConfig{}
	config.scaleIn[0] = 2.0
	config.scale[1] = 0.5
	assert config.scaleIn[0] == 2.0 && config.scale[1] == 0.5
}

fn test_keyword_named_member() {
	// `type` is a V keyword; the binding spells the member `@type`.
	mut event := raylib.AutomationEvent{}
	event.frame = 10
	event.@type = 3
	event.params[2] = -7
	assert event.frame == 10 && event.@type == 3 && event.params[2] == -7
}

fn test_model_animation_members() {
	mut anim := raylib.ModelAnimation{}
	anim.boneCount = 20
	anim.keyframeCount = 60
	assert anim.boneCount == 20 && anim.keyframeCount == 60 && isnil(anim.keyframePoses)
}
