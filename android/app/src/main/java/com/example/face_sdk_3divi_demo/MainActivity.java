package com.example.face_sdk_3divi_demo;
import android.content.pm.ApplicationInfo;
import androidx.annotation.NonNull;
import io.flutter.embedding.android.FlutterActivity;
import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.embedding.engine.loader.FlutterLoader;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.FlutterInjector;

/*
import android.content.Context;
import android.content.pm.PackageManager;
import androidx.core.content.ContextCompat;
import android.Manifest;

 */

public class MainActivity extends FlutterActivity {
    static{
        System.loadLibrary("facerec");
    }

    private static final String CHANNEL = "samples.flutter.dev/facesdk";

    private String _getNativeLibDir() {
        return getApplicationInfo().nativeLibraryDir;
    }

    @Override
    public void configureFlutterEngine(@NonNull FlutterEngine flutterEngine) {
        super.configureFlutterEngine(flutterEngine);
        new MethodChannel(flutterEngine.getDartExecutor().getBinaryMessenger(), CHANNEL)
                .setMethodCallHandler(
                        (call, result) -> {
                            /*
                            if (CheckPermission(this, Manifest.permission.READ_PHONE_STATE)) {
                                YourStuffHandling();
                            } else {
                                RequestPermission(MyDevIDS.this, Manifest.permission.READ_PHONE_STATE, REQUEST_READ_PERMISSION );
                            }

                             */
                            System.out.println(_getNativeLibDir());
                            if (call.method.equals("getNativeLibDir")) {
                                String nativeLibDir = _getNativeLibDir();
                                result.success(nativeLibDir);
                            } else {
                                result.notImplemented();
                            }
                        }
                );
    }
    /*
    public boolean CheckPermission(Context context, String Permission) {
        if (ContextCompat.checkSelfPermission(context,
                Permission) == PackageManager.PERMISSION_GRANTED) {
            return true;
        } else {
            return false;
        }
    }

     */
}
