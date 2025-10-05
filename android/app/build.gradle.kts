plugins {
    id("com.android.application")
    id("kotlin-android")
    // The Flutter Gradle Plugin must be applied after the Android and Kotlin Gradle plugins.
    id("dev.flutter.flutter-gradle-plugin")
}

android {
    namespace = "com.vibecoding.contest_reminder"
    compileSdk = flutter.compileSdkVersion
    ndkVersion = flutter.ndkVersion
    

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_11
        targetCompatibility = JavaVersion.VERSION_11
        isCoreLibraryDesugaringEnabled = true
    }

    kotlinOptions {
        jvmTarget = JavaVersion.VERSION_11.toString()
    }

    defaultConfig {
        applicationId = "com.vibecoding.contest_reminder"
                minSdk = flutter.minSdkVersion  // Required for flutter_local_notifications
        targetSdk = flutter.targetSdkVersion
        versionCode = flutter.versionCode
        versionName = flutter.versionName
        
        multiDexEnabled = true
    }

    signingConfigs {
        create("release") {
            val keyPropertiesFile = rootProject.file("key.properties")
            if (keyPropertiesFile.exists()) {
                val keyProperties = keyPropertiesFile.readLines().map { it.split("=") }.associate { it[0] to it[1] }
                storeFile = if (keyProperties["storeFile"] != null) {
                    rootProject.file(keyProperties["storeFile"]!!)
                } else {
                    rootProject.file("app/upload-keystore.jks")
                }
                storePassword = keyProperties["storePassword"]
                keyAlias = keyProperties["keyAlias"]
                keyPassword = keyProperties["keyPassword"]
            }
        }
    }

    buildTypes {
        getByName("debug") {
            isMinifyEnabled = false
            isDebuggable = true
        }
        getByName("release") {
            isMinifyEnabled = true
            isDebuggable = false
            proguardFiles(getDefaultProguardFile("proguard-android-optimize.txt"), "proguard-rules.pro")
            signingConfig = signingConfigs.getByName("release")
        }
    }
}

dependencies {
    coreLibraryDesugaring("com.android.tools:desugar_jdk_libs:2.0.4")
    implementation("com.google.android.material:material:1.12.0")
}

flutter {
    source = "../.."
}
