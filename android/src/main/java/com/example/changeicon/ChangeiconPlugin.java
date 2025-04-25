package com.example.changeicon;

import android.app.Activity;
import android.app.Application;
import android.content.Context;
import android.os.Bundle;
import androidx.annotation.NonNull;
import androidx.lifecycle.DefaultLifecycleObserver;
import androidx.lifecycle.Lifecycle;
import androidx.lifecycle.LifecycleOwner;
import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.embedding.engine.plugins.activity.ActivityAware;
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding;
import io.flutter.embedding.engine.plugins.lifecycle.FlutterLifecycleAdapter;
import io.flutter.plugin.common.BinaryMessenger;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.Log;

/** ChangeiconPlugin */
public class ChangeiconPlugin implements FlutterPlugin, ActivityAware {
    private MethodChannel channel;
    private MethodCallImplementation handler;
    private static final String TAG = "[Change_icon]";
    private static final String CHANNEL_ID = "Changeicon";
    private FlutterPluginBinding pluginBinding;
    private ActivityState activityState;

    @Override
    public void onAttachedToEngine(@NonNull FlutterPluginBinding flutterPluginBinding) {
        setupChannel(flutterPluginBinding.getBinaryMessenger(), flutterPluginBinding.getApplicationContext());
        pluginBinding = flutterPluginBinding;
    }

    @Override
    public void onDetachedFromEngine(@NonNull FlutterPluginBinding binding) {
        teardownChannel();
        pluginBinding = null;
    }

    @Override
    public void onAttachedToActivity(@NonNull ActivityPluginBinding binding) {
        setup(
                pluginBinding.getBinaryMessenger(),
                (Application) pluginBinding.getApplicationContext(),
                binding.getActivity(),
                binding);
        handler.setActivity(binding.getActivity());
    }

    @Override
    public void onDetachedFromActivity() {
        tearDown();
        handler.setActivity(null);
    }

    @Override
    public void onReattachedToActivityForConfigChanges(@NonNull ActivityPluginBinding binding) {
        onAttachedToActivity(binding);
    }

    @Override
    public void onDetachedFromActivityForConfigChanges() {
        onDetachedFromActivity();
    }

    private void setupChannel(BinaryMessenger messenger, Context context) {
        channel = new MethodChannel(messenger, CHANNEL_ID);
        handler = new MethodCallImplementation(context, null);
        channel.setMethodCallHandler(handler);
    }

    private void teardownChannel() {
        if (channel != null) {
            channel.setMethodCallHandler(null);
            channel = null;
        }
        handler = null;
    }

    private void setup(
            final BinaryMessenger messenger,
            final Application application,
            final Activity activity,
            final ActivityPluginBinding activityBinding) {
        activityState = new ActivityState(application, activity, messenger, activityBinding);
    }

    private void tearDown() {
        if (activityState != null) {
            activityState.release();
            activityState = null;
        }
    }

    private class ActivityState {
        private Application application;
        private Activity activity;
        private LifeCycleObserver observer;
        private ActivityPluginBinding activityBinding;
        private Lifecycle lifecycle;

        ActivityState(
                final Application application,
                final Activity activity,
                final BinaryMessenger messenger,
                final ActivityPluginBinding activityBinding) {
            this.application = application;
            this.activity = activity;
            this.activityBinding = activityBinding;

            observer = new LifeCycleObserver(activity);
            lifecycle = FlutterLifecycleAdapter.getActivityLifecycle(activityBinding);
            lifecycle.addObserver(observer);
        }

        void release() {
            if (activityBinding != null) {
                activityBinding = null;
            }
            if (lifecycle != null) {
                lifecycle.removeObserver(observer);
                lifecycle = null;
            }
            application = null;
            activity = null;
            observer = null;
        }

        Activity getActivity() {
            return activity;
        }
    }

    private class LifeCycleObserver
            implements Application.ActivityLifecycleCallbacks, DefaultLifecycleObserver {
        private final Activity thisActivity;

        LifeCycleObserver(Activity activity) {
            this.thisActivity = activity;
        }

        @Override
        public void onCreate(@NonNull LifecycleOwner owner) {}

        @Override
        public void onStart(@NonNull LifecycleOwner owner) {}

        @Override
        public void onResume(@NonNull LifecycleOwner owner) {}

        @Override
        public void onPause(@NonNull LifecycleOwner owner) {
            Log.i("ChangeIcon", "The app has paused");
            handler.updateIcon();
        }

        @Override
        public void onStop(@NonNull LifecycleOwner owner) {}

        @Override
        public void onDestroy(@NonNull LifecycleOwner owner) {}

        @Override
        public void onActivityCreated(@NonNull Activity activity, Bundle savedInstanceState) {}

        @Override
        public void onActivityStarted(@NonNull Activity activity) {}

        @Override
        public void onActivityResumed(@NonNull Activity activity) {}

        @Override
        public void onActivityPaused(@NonNull Activity activity) {}

        @Override
        public void onActivitySaveInstanceState(@NonNull Activity activity, @NonNull Bundle outState) {}

        @Override
        public void onActivityDestroyed(@NonNull Activity activity) {
            if (thisActivity == activity && activity.getApplicationContext() != null) {
                ((Application) activity.getApplicationContext())
                        .unregisterActivityLifecycleCallbacks(this);
            }
        }

        @Override
        public void onActivityStopped(@NonNull Activity activity) {}
    }

    public static String getTAG() {
        return TAG;
    }

    public static String getChannelId() {
        return CHANNEL_ID;
    }
}