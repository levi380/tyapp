# Flutter ProGuard Rules
# 只保留Flutter必要的类和方法，允许混淆其他内容
-keep class io.flutter.app.** { *; }
-keep class io.flutter.plugin.**  { *; }
-keep class io.flutter.util.**  { *; }
-keep class io.flutter.view.**  { *; }
-keep class io.flutter.embedding.** { *; }
-keep class io.flutter.embedding.engine.** { *; }
-keep class io.flutter.embedding.engine.dart.** { *; }
-keep class io.flutter.embedding.engine.plugins.** { *; }

# 保留Flutter插件接口，但允许混淆实现
-keep interface io.flutter.plugins.** { *; }
-keep class io.flutter.plugins.** { 
    public <init>(...);
}

# 保留必要的Android类（只保留真正需要的，不保留所有）
-keep class android.app.Activity { *; }
-keep class android.app.Application { *; }
-keep class android.app.Service { *; }
-keep class android.content.BroadcastReceiver { *; }

# GetX - 只保留必要的类
-keep class get.** { *; }
-keepclassmembers class get.** { *; }

# 不保留所有AndroidX和Android类，只保留必要的
# 移除 -keep class androidx.** { *; }
# 移除 -keep class android.** { *; }

# 保留反射使用的类
-keepattributes *Annotation*
-keepattributes Signature
-keepattributes Exceptions
-keepattributes InnerClasses
-keepattributes EnclosingMethod

# 保留Parcelable实现类
-keepclassmembers class * implements android.os.Parcelable {
    public static final android.os.Parcelable$Creator CREATOR;
}

# 保留Serializable类
-keepclassmembers class * implements java.io.Serializable {
    static final long serialVersionUID;
    private static final java.io.ObjectStreamField[] serialPersistentFields;
    private void writeObject(java.io.ObjectOutputStream);
    private void readObject(java.io.ObjectInputStream);
    java.lang.Object writeReplace();
    java.lang.Object readResolve();
}

# 保留枚举类
-keepclassmembers enum * {
    public static **[] values();
    public static ** valueOf(java.lang.String);
}

# 保留WebView相关类
-keepclassmembers class * extends android.webkit.WebViewClient {
    public void *(android.webkit.WebView, java.lang.String, android.graphics.Bitmap);
    public boolean *(android.webkit.WebView, java.lang.String);
}
-keepclassmembers class * extends android.webkit.WebChromeClient {
    public void *(android.webkit.WebView, java.lang.String);
}

# 保留自定义View
-keep public class * extends android.view.View {
    public <init>(android.content.Context);
    public <init>(android.content.Context, android.util.AttributeSet);
    public <init>(android.content.Context, android.util.AttributeSet, int);
    public void set*(...);
    *** get*();
}

# 保留R类
-keepclassmembers class **.R$* {
    public static <fields>;
}

# 只保留必要的项目类（移除通配符，只保留真正需要的）
# 如果项目中有通过反射访问的类，需要单独添加
# -keep class com.filbet.project.filbet.** { *; }  # 注释掉，允许混淆项目代码

# 移除日志
-assumenosideeffects class android.util.Log {
    public static boolean isLoggable(java.lang.String, int);
    public static int v(...);
    public static int i(...);
    public static int w(...);
    public static int d(...);
    public static int e(...);
}

# Google Play Core相关类（可选依赖，如果未使用可以忽略警告）
-dontwarn com.google.android.play.core.splitcompat.SplitCompatApplication
-dontwarn com.google.android.play.core.splitinstall.SplitInstallException
-dontwarn com.google.android.play.core.splitinstall.SplitInstallManager
-dontwarn com.google.android.play.core.splitinstall.SplitInstallManagerFactory
-dontwarn com.google.android.play.core.splitinstall.SplitInstallRequest$Builder
-dontwarn com.google.android.play.core.splitinstall.SplitInstallRequest
-dontwarn com.google.android.play.core.splitinstall.SplitInstallSessionState
-dontwarn com.google.android.play.core.splitinstall.SplitInstallStateUpdatedListener
-dontwarn com.google.android.play.core.tasks.OnFailureListener
-dontwarn com.google.android.play.core.tasks.OnSuccessListener
-dontwarn com.google.android.play.core.tasks.Task

-keep class com.mob.**{*;}
-dontwarn com.mob.**
-keep class cn.fly.**{*;}
-dontwarn cn.fly.**

-dontwarn  com.shubao.xinstall.**
-keep class com.shubao.xinstall.** {*;}
-dontwarn  com.xinstall.**
-keep class com.xinstall.** {*;}

# 更激进的优化配置
-optimizationpasses 5
-dontusemixedcaseclassnames
-dontskipnonpubliclibraryclasses
-allowaccessmodification
-repackageclasses ''
-verbose

# 允许优化和混淆
-optimizations !code/simplification/arithmetic,!code/simplification/cast,!field/*,!class/merging/*

