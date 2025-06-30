module main

import raylib as rl

$if android {
#include <android/native_activity.h>
#include <android/native_window.h>
#include <android/input.h>

/*
__global (
	activity &C.ANativeActivity
)
*/
}


fn set_jni(activity voidptr) {

$if android {
	// cast activity and set your globals jni ......
}
}


@[export: 'save_jni_android_V_raylib_onCreate']
pub fn on_create(activity voidptr) {
	rl.trace_log(0, '[V] onCreate_android_V_raylib', rl.TraceLogLevel.log_all)
}
@[export: 'onDestroy_android_V_raylib']
pub fn on_destroy(activity voidptr) {
	rl.trace_log(0, '[V] onDestroy_android_V_raylib', rl.TraceLogLevel.log_all)
}

@[export: 'onStart_android_V_raylib']
pub fn on_start(activity voidptr) {
	rl.trace_log(0, '[V] onStart_android_V_raylib', rl.TraceLogLevel.log_all)
}

@[export: 'onResume_android_V_raylib']
pub fn on_resume(activity voidptr) {
	rl.trace_log(0, '[V] onResume_android_V_raylib', rl.TraceLogLevel.log_all)
}

@[export: 'onSaveInstanceState_android_V_raylib']
pub fn on_save_instance_state(activity voidptr, out_size voidptr) voidptr {
	rl.trace_log(0, '[V] onSaveInstanceState_android_V_raylib', rl.TraceLogLevel.log_all)
	return voidptr(0)
}

@[export: 'onPause_android_V_raylib']
pub fn on_pause(activity voidptr) {
	rl.trace_log(0, '[V] onPause_android_V_raylib', rl.TraceLogLevel.log_all)
}

@[export: 'onStop_android_V_raylib']
pub fn on_stop(activity voidptr) {
	rl.trace_log(0, '[V] onStop_android_V_raylib', rl.TraceLogLevel.log_all)
}

@[export: 'onConfigurationChanged_android_V_raylib']
pub fn on_configuration_changed(activity voidptr) {
	rl.trace_log(0, '[V] onConfigurationChanged_android_V_raylib', rl.TraceLogLevel.log_all)
}

@[export: 'onLowMemory_android_V_raylib']
pub fn on_low_memory(activity voidptr) {
	rl.trace_log(0, '[V] onLowMemory_android_V_raylib', rl.TraceLogLevel.log_all)
}

@[export: 'onWindowFocusChanged_android_V_raylib']
pub fn on_window_focus_changed(activity voidptr, has_focus int) {
	rl.trace_log(0, '[V] onWindowFocusChanged_android_V_raylib: focus=$has_focus', rl.TraceLogLevel.log_all)
}

@[export: 'onNativeWindowCreated_android_V_raylib']
pub fn on_native_window_created(activity  voidptr, window voidptr) {
	rl.trace_log(0, '[V] onNativeWindowCreated_android_V_raylib', rl.TraceLogLevel.log_all)
}

@[export: 'onNativeWindowDestroyed_android_V_raylib']
pub fn on_native_window_destroyed(activity voidptr, window voidptr) {
	rl.trace_log(0, '[V] onNativeWindowDestroyed_android_V_raylib', rl.TraceLogLevel.log_all)
}

@[export: 'onInputQueueCreated_android_V_raylib']
pub fn on_input_queue_created(activity voidptr, queue voidptr) {
	rl.trace_log(0, '[V] onInputQueueCreated_android_V_raylib', rl.TraceLogLevel.log_all)
}

@[export: 'onInputQueueDestroyed_android_V_raylib']
pub fn on_input_queue_destroyed(activity voidptr, queue voidptr) {
	rl.trace_log(0, '[V] onInputQueueDestroyed_android_V_raylib', rl.TraceLogLevel.log_all)
}
