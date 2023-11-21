package com.example.changeicon;

import androidx.annotation.NonNull;
import androidx.lifecycle.DefaultLifecycleObserver;
import androidx.lifecycle.Lifecycle;
import androidx.lifecycle.LifecycleOwner;
import android.app.Activity;
import android.content.Context;


import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
import android.app.Activity;
import android.app.Application;
import android.os.Bundle;
import androidx.annotation.NonNull;
import androidx.annotation.Nullable;
import androidx.annotation.VisibleForTesting;
import androidx.lifecycle.DefaultLifecycleObserver;
import androidx.lifecycle.Lifecycle;
import androidx.lifecycle.LifecycleOwner;
import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.embedding.engine.plugins.activity.ActivityAware;
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding;
import io.flutter.embedding.engine.plugins.lifecycle.FlutterLifecycleAdapter;
import io.flutter.plugin.common.BinaryMessenger;
import io.flutter.plugin.common.PluginRegistry;
import java.util.List;


import io.flutter.Log;

/** ChangeiconPlugin */
public class ChangeiconPlugin implements FlutterPlugin, ActivityAware {
  /// The MethodChannel that will the communication between Flutter and native Android
  ///
  /// This local reference serves to register the plugin with the Flutter Engine and unregister it
  /// when the Flutter Engine is detached from the Activity
  private MethodChannel channel;
  private MethodCallImplementation handler;
  private static final String TAG = "[Change_icon]";

  private static final String CHANNEL_ID = "Changeicon";

  public static String getTAG() {
    return TAG;
  }

  public static String getChannelId() {
    return CHANNEL_ID;
  }

  @SuppressWarnings("deprecation")
  public static void registerWith(io.flutter.plugin.common.PluginRegistry.Registrar registrar) {
    final ChangeiconPlugin plugin = new ChangeiconPlugin();
    plugin.setupChannel(registrar.messenger(), registrar.context(), registrar.activity());
  }


  private void setupChannel(BinaryMessenger messenger, Context context, Activity activity) {
    channel = new MethodChannel(messenger, CHANNEL_ID);
    handler = new MethodCallImplementation(context, activity);
    channel.setMethodCallHandler(handler);
  }

  private void teardownChannel() {
    channel.setMethodCallHandler(null);
    channel = null;
    handler = null;
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
    public void onStop(@NonNull LifecycleOwner owner) {
    }

    @Override
    public void onDestroy(@NonNull LifecycleOwner owner) {
    }

    @Override
    public void onActivityCreated(Activity activity, Bundle savedInstanceState) {}

    @Override
    public void onActivityStarted(Activity activity) {}

    @Override
    public void onActivityResumed(Activity activity) {}

    @Override
    public void onActivityPaused(Activity activity) {}

    @Override
    public void onActivitySaveInstanceState(Activity activity, Bundle outState) {}

    @Override
    public void onActivityDestroyed(Activity activity) {
      if (thisActivity == activity && activity.getApplicationContext() != null) {
        ((Application) activity.getApplicationContext())
            .unregisterActivityLifecycleCallbacks(
                this); // Use getApplicationContext() to avoid casting failures
      }
    }

    @Override
    public void onActivityStopped(Activity activity) {
      if (thisActivity == activity) {
        
      }
    }
  }


  /**
   * Move all activity-lifetime-bound states into this helper object, so that {@code setup} and
   * {@code tearDown} would just become constructor and finalize calls of the helper object.
   */
  private class ActivityState {
    private Application application;
    private Activity activity;
    private LifeCycleObserver observer;
    private ActivityPluginBinding activityBinding;
    private BinaryMessenger messenger;

    // This is null when not using v2 embedding;
    private Lifecycle lifecycle;

    // Default constructor
    ActivityState(
        final Application application,
        final Activity activity,
        final BinaryMessenger messenger,
        final PluginRegistry.Registrar registrar,
        final ActivityPluginBinding activityBinding) {
      this.application = application;
      this.activity = activity;
      this.activityBinding = activityBinding;
      this.messenger = messenger;

      observer = new LifeCycleObserver(activity);
      if (registrar != null) {
        // V1 embedding setup for activity listeners.
        application.registerActivityLifecycleCallbacks(observer);
      } else {
        // V2 embedding setup for activity listeners.
        lifecycle = FlutterLifecycleAdapter.getActivityLifecycle(activityBinding);
        lifecycle.addObserver(observer);
      }
    }

    void release() {
      if (activityBinding != null) {
        activityBinding = null;
      }

      if (lifecycle != null) {
        lifecycle.removeObserver(observer);
        lifecycle = null;
      }

      if (application != null) {
        application.unregisterActivityLifecycleCallbacks(observer);
        application = null;
      }

      activity = null;
      observer = null;
    }

    Activity getActivity() {
      return activity;
    }

  }

  private FlutterPluginBinding pluginBinding;
  ActivityState activityState;


  @Override
  public void onAttachedToEngine(@NonNull FlutterPluginBinding flutterPluginBinding) {
    // channel = new MethodChannel(flutterPluginBinding.getBinaryMessenger(), "Changeicon");
    // channel.setMethodCallHandler(this);
    setupChannel(flutterPluginBinding.getBinaryMessenger(), flutterPluginBinding.getApplicationContext(), null);
    pluginBinding =  flutterPluginBinding;
  }

  // @Override
  // public void onMethodCall(@NonNull MethodCall call, @NonNull Result result) {
  //   if (call.method.equals("getPlatformVersion")) {
  //     result.success("Android " + android.os.Build.VERSION.RELEASE);
  //   } else if(call.method.equals("setIcon")) {

  //   } 
  //   else {
  //     result.notImplemented();
  //   }
  // }

    @Override
  public void onAttachedToActivity(@NonNull ActivityPluginBinding binding) {
    setup(
        pluginBinding.getBinaryMessenger(),
        (Application) pluginBinding.getApplicationContext(),
        binding.getActivity(),
        null,
        binding);
      handler.setActivity(binding.getActivity());
  }


    @VisibleForTesting
  final ActivityState getActivityState() {
    return activityState;
  }

    private void setup(
      final BinaryMessenger messenger,
      final Application application,
      final Activity activity,
      final PluginRegistry.Registrar registrar,
      final ActivityPluginBinding activityBinding) {
    activityState =
        new ActivityState(application, activity, messenger,registrar, activityBinding);
  }

    private void tearDown() {
    if (activityState != null) {
      activityState.release();
      activityState = null;
    }
  }


  @Override
  public void onDetachedFromActivity() {
    tearDown();
    handler.setActivity(null);
  }

  @Override
  public void onDetachedFromActivityForConfigChanges() {
    onDetachedFromActivity();
  }

  @Override
  public void onReattachedToActivityForConfigChanges(@NonNull ActivityPluginBinding binding) {
    onAttachedToActivity(binding);
  }


  @Override
  public void onDetachedFromEngine(@NonNull FlutterPluginBinding binding) {
   teardownChannel();
  }
}
