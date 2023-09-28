# React Native原生安卓开屏图片设置



ai工具生成开屏画面：https://hotpot.ai/

图标和开屏生成工具：https://apetools.webprofusion.com/

## 原生的React Native项目中，安装Expo模块

在原生的React Native项目中，安装Expo模块。它分为两种安装方式 一种是自动安装、一种是手动安装。

参考：https://docs.expo.dev/bare/installing-expo-modules/

自动安装命令：

```
npx install-expo-modules@latest
```



## 安装首屏动画插件

```
npx expo install expo-splash-screen
```



## 配置

### 步骤1：设置背景图片

先准备一张4096x4096的图片，然后图标和开屏生成工具：https://apetools.webprofusion.com/生成，并且下载到

在`android\app\src\main\res\drawable`目录放置图片`splashscreen_image.png`






### 步骤2：设置背景颜色

编辑`android\app\src\main\res\values\colors.xml`文件（如果没有则创建一个）：

```xml
<resources>
+ <color name="splashscreen_background">#AABBCC</color> <!-- #AARRGGBB or #RRGGBB format -->
  <!-- Other colors defined for your application -->
</resources>
```



### 步骤3：设置开机图片路径

编辑`android\app\src\main\res\drawable\splashscreen.xml`文件

```xml
<layer-list xmlns:android="http://schemas.android.com/apk/res/android">
  <item android:drawable="@color/splashscreen_background"/>
  <item>
    <bitmap android:gravity="center" android:src="@drawable/splashscreen_image"/>
  </item>
</layer-list>
```



### 步骤4：设置主题

编辑`android\app\src\main\res\values\styles.xml`文件：

```xml
<resources>

    <!-- Base application theme. -->
    <style name="AppTheme" parent="Theme.AppCompat.DayNight.NoActionBar">
        <!-- Customize your theme here. -->
        <item name="android:editTextBackground">@drawable/rn_edit_text_material</item>
        <item name="android:windowBackground">@drawable/splashscreen</item> <!-- this line instructs the system to use 'splashscreen.xml' as a background of the whole application -->
        <!-- Other style properties -->
        
        <!-- 全屏的时候，隐藏顶部状态栏 -->
        <item name="android:windowFullscreen">true</item>
    </style>
</resources>

```



### 步骤5：修改主题

编辑`android\app\src\main\AndroidManifest.xml`文件

在activity中追加`android:theme="@style/AppTheme"`

```xml
<manifest xmlns:android="http://schemas.android.com/apk/res/android">

    <uses-permission android:name="android.permission.INTERNET" />

    <application
      android:name=".MainApplication"
      android:label="@string/app_name"
      android:icon="@mipmap/ic_launcher"
      android:roundIcon="@mipmap/ic_launcher_round"
      android:allowBackup="false"
      android:theme="@style/AppTheme">
      <activity
        android:name=".MainActivity"
        <!-- 追加这行 -->
        android:theme="@style/AppTheme"
        android:label="@string/app_name"
        android:configChanges="keyboard|keyboardHidden|orientation|screenLayout|screenSize|smallestScreenSize|uiMode"
        android:launchMode="singleTask"
        android:windowSoftInputMode="adjustResize"
        android:exported="true">
        <intent-filter>
            <action android:name="android.intent.action.MAIN" />
            <category android:name="android.intent.category.LAUNCHER" />
        </intent-filter>
      </activity>
    </application>
</manifest>

```



### 步骤6：设置图片模式

编辑`android\app\src\main\res\values\strings.xml`文件

```xml
<resources>
    <!-- 设置APP名字 -->
    <string name="app_name">X次幂</string>
    <!-- 设置开屏模式：选项可以是contain、cover、native之一 -->
    <string name="expo_splash_screen_resize_mode">native</string>
    <!-- 状态栏半透明 -->
    <string name="expo_splash_screen_status_bar_translucent">true</string>
</resources>

```

