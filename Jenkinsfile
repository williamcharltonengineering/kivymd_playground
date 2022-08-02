pipeline {
    agent {
        label 'docker' 
    }
    environment {
        // ANDROID_HOME    = "${env.WORKSPACE}"
        ANDROID_NDK     = "android-ndk-r25"
        ANDROID_HOME    = "${env.WORKSPACE}/android-8.1.0"
        // ANDROIDSDK      = "${env.WORKSPACE}/android-sdk-27"
        // ANDROIDNDK      = "${env.WORKSPACE}/${env.ANDROID_NDK}"
        // ANDROIDAPI      = "27"
        // NDKAPI          = "21"
        PATH            = "${env.HOME}/.local/bin:${env.PATH}"
    }
    stages {
        stage('collect-artifacts') {
            steps {
                // sh 'if [ ! -f ' + env.ANDROID_NDK + '-linux.zip ] ; then wget https://dl.google.com/android/repository/android-ndk-r25-linux.zip ; fi'
                // sh 'if [ ! -d ' + env.ANDROID_NDK + ' ] ; then unzip ' + env.ANDROID_NDK + '-linux.zip ; fi'
                sh 'if [ ! -f platform-27_r03.zip ] ; then wget https://dl.google.com/android/repository/platform-27_r03.zip ; fi'
                sh "if [ ! -d ${env.ANDROID_HOME} ] ; then unzip platform-27_r03.zip ; fi"
                sh "if [ ! -f commandlinetools-linux-8512546_latest.zip ] ; then wget https://dl.google.com/android/repository/commandlinetools-linux-8512546_latest.zip ; fi"
                sh "mkdir -p ${env.ANDROID_HOME}/cmdline-tools/latest ; unzip -o commandlinetools-linux-8512546_latest.zip ; yes | cp -rf cmdline-tools/* ${env.ANDROID_HOME}/cmdline-tools/latest/"
                sh "mkdir -p ${env.ANDROID_HOME}/tools ; unzip -o commandlinetools-linux-8512546_latest.zip ; yes | cp -rf cmdline-tools/* ${env.ANDROID_HOME}/tools/"
            }
        }
        stage ('setup-env') {
            steps {
                sh "echo WORKSPACE=${env.WORKSPACE}"
                sh "echo PATH=${env.PATH}"
                sh 'if [ ! -d buildozer ] ; then git clone https://github.com/kivy/buildozer ; fi'
                sh 'cd buildozer ; git pull'
                sh 'pip install --user -e buildozer'
                sh "yes | ${env.ANDROID_HOME}/cmdline-tools/latest/bin/sdkmanager \"platforms;android-27\""
                sh "yes | ${env.ANDROID_HOME}/cmdline-tools/latest/bin/sdkmanager \"build-tools;28.0.2\""
            }
        }
        stage('build') {

            steps {
                withEnv(["PATH=${env.HOME}/.local/bin:${env.PATH}"]) {
                    sh "echo PATH=${env.PATH}"
                    sh "echo HOME=${env.HOME}"
                    sh "echo USER=${env.USER}"
                    sh '~/.local/bin/buildozer --version'
                    // sh '~/.local/bin/buildozer android clean'
                    sh "echo Starting build..."
                    sh '~/.local/bin/buildozer android debug'
                }
            }
        }
    }
}
