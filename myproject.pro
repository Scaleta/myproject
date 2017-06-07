TEMPLATE = app
TARGET = myproject
QT += quick quickcontrols2

SOURCES += \
    myproject.cpp

RESOURCES += \
    myproject.qml \
    qtquickcontrols2.conf \
    $$files(images/*.png) \
    $$files(images/+material/*.png) \
    $$files(pages/*.qml)

#target.path = $$[QT_INSTALL_EXAMPLES]/quickcontrols2/myproject
#INSTALLS += target

#DISTFILES += \

DISTFILES += \
    pages/CategoryDelegate.qml \
    android/AndroidManifest.xml \
    android/gradle/wrapper/gradle-wrapper.jar \
    android/gradlew \
    android/res/values/libs.xml \
    android/build.gradle \
    android/gradle/wrapper/gradle-wrapper.properties \
    android/gradlew.bat


#LIBS += \
#    -L$$PWD/openssl/x86/lib/ -lcrypto \
#    -L$$PWD/openssl/x86/lib/ -lssl


#win32:CONFIG(release, debug|release): LIBS += -L$$PWD/openssl/x86/lib/ -lcrypto
#else:win32:CONFIG(debug, debug|release): LIBS += -L$$PWD/openssl/x86/lib/ -lcryptod
#else:unix: LIBS += -L$$PWD/openssl/x86/lib/ -lcrypto

#INCLUDEPATH += $$PWD/openssl/x86
#DEPENDPATH += $$PWD/openssl/x86

#contains(ANDROID_TARGET_ARCH,x86) {
#    ANDROID_EXTRA_LIBS = \
#        $$PWD/openssl/x86/lib/libcrypto.so \
#        $$PWD/openssl/x86/lib/libssl.so
#}


#win32:CONFIG(release, debug|release): LIBS += -L$$PWD/openssl/x86/lib/ -lssl
#else:win32:CONFIG(debug, debug|release): LIBS += -L$$PWD/openssl/x86/lib/ -lssld
#else:unix: LIBS += -L$$PWD/openssl/x86/lib/ -lssl

#INCLUDEPATH += $$PWD/openssl/x86
#DEPENDPATH += $$PWD/openssl/x86

#LIBS += \
#$$PWD/openssl/libcrypto.a \
#$$PWD/openssl/libssl.a

android {
LIBS += \
$$PWD/android/libs/openssl/libcrypto.a \
$$PWD/android/libs/openssl/libssl.a

ANDROID_PACKAGE_SOURCE_DIR = $$PWD/android
OTHER_FILES += $$PWD/android/AndroidManifest.xml

contains(ANDROID_TARGET_ARCH, x86) {
ANDROID_EXTRA_LIBS = \
$$PWD/android/libs/openssl/libcrypto.so \
$$PWD/android/libs/openssl/libssl.so
}
}






