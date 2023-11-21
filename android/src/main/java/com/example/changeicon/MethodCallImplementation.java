package com.example.changeicon;

import android.app.Activity;
import android.content.ComponentName;
import android.content.Context;
import android.content.Intent;
import android.content.pm.PackageManager;
import android.os.Build;
import android.util.Log;

import androidx.annotation.NonNull;
import androidx.annotation.RequiresApi;
import java.util.ArrayList;

import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.util.List;
import java.util.Map;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;

public class MethodCallImplementation implements MethodChannel.MethodCallHandler {
    private static final String TAG = ChangeiconPlugin.getTAG();

    private final Context context;
    private Activity activity;

    private static List<String> classNames = null;
    private static boolean iconChanged = false;
    private static List<String> args =  new ArrayList<>();

    MethodCallImplementation(Context context, Activity activity) {
        this.context = context;
        this.activity = activity;
    }

    void setActivity(Activity activity) {
        this.activity = activity;
    }

    @RequiresApi(api = Build.VERSION_CODES.KITKAT)
    @Override
    public void onMethodCall(@NonNull MethodCall call, @NonNull MethodChannel.Result result) {

        switch (call.method) {
            case "getPlatformVersion":
            {
                result.success("Android " + android.os.Build.VERSION.RELEASE);
                break;
            }
            case "initialize":
            {
                classNames = call.arguments();
                break;
            }
            case "switchIconTo":
            {
                switchIconTo(call);
                break;
            }
            default:
                result.notImplemented();
                break;
        }
    }

    private void switchIconTo(MethodCall call) {
        if(classNames == null || classNames.isEmpty()) {
            Log.e(TAG,"Initialization Failed!");
            Log.i(TAG,"List all the activity-alias class names in initialize()");
            return;
        }

         args = call.arguments();
         iconChanged = true;

    }

void updateIcon() {
    if (iconChanged){
        String className = args.get(0);
        PackageManager pm = activity.getPackageManager();
        String packageName = activity.getPackageName();
        int componentState = PackageManager.COMPONENT_ENABLED_STATE_DISABLED;
        int i=0;
        for(;i<classNames.size();i++) {
            ComponentName cn = new ComponentName(packageName, packageName+"."+classNames.get(i));
            if(className.equals(classNames.get(i))) {
                componentState = PackageManager.COMPONENT_ENABLED_STATE_ENABLED;
            }
            else{
                componentState = PackageManager.COMPONENT_ENABLED_STATE_DISABLED;
            }
            pm.setComponentEnabledSetting(cn, componentState, PackageManager.DONT_KILL_APP);
        }

        if(i>classNames.size()) {
            Log.e(TAG,"class name "+className+" did not match in the initialized list.");
            return;
        }
        iconChanged = false;
        Log.d(TAG,"Icon switched to "+className);
     }
    }
}

