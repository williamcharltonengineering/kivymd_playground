pipeline {
    agent {
        label 'docker' 
    }
    environment {
        // ANDROID_HOME    = "${env.WORKSPACE}"
        ANDROID_NDK     = "android-ndk-r25"
        ANDROID_HOME    = "/usr/lib/android-sdk"
        PATH            = "${env.ANDROID_HOME}/cmdline-tools/latest/bin:${env.WORKSPACE}/.buildozer/android/platform/build-armeabi-v7a/build/venv/bin:${env.PATH}"
    }
    stages {
        stage('collect-artifacts') {
            agent {
                docker {
                    label 'docker'
                    image 'busybox:latest'
                    args '-v ' + env.WORKSPACE + ':/root --entrypoint=""'
                }
            }
            steps {
                sh 'if [ ! -f ' + env.ANDROID_NDK + '-linux.zip ] ; then wget https://dl.google.com/android/repository/android-ndk-r25-linux.zip ; fi'
                sh 'if [ ! -d ' + env.ANDROID_NDK + ' ] ; then unzip ' + env.ANDROID_NDK + '-linux.zip ; fi'
                sh 'if [ ! -f platform-27_r03.zip ] ; then wget https://dl.google.com/android/repository/platform-27_r03.zip ; fi'
                sh 'if [ ! -f commandlinetools-linux-8512546_latest.zip ] ; then wget https://dl.google.com/android/repository/commandlinetools-linux-8512546_latest.zip ; fi'
                sh 'if [ ! -d android-8.1.0 ] ; then unzip commandlinetools-linux-8512546_latest.zip ; fi'
            }
        }
        stage ('setup-env') {
            steps {
                sh 'if [ ! $(which cython3) ] ; then CYTHON3LOC="$(which cpython | head -n 1)" ; ln -s ${CYTHON3LOC}3 ${CYTHON3LOC} ; fi'
                sh 'if [ ! -d buildozer ] ; then git clone https://github.com/kivy/buildozer ; fi'
                sh 'cd buildozer ; git pull'
                sh 'python3 -m venv .venv'
                sh '.venv/bin/pip install -e buildozer'
            }
        }
        stage('build') {
            // agent {
            //     docker {
            //         label 'docker'
            //         image 'kivy/buildozer:latest'
            //         args '-v ' + env.WORKSPACE + ':/home/user/hostcwd --entrypoint=""'
            //     }
            // }
            steps {
                sh '.venv/bin/buildozer --version'
                sh '.venv/bin/buildozer android debug'
            }
        }
    }
}