pipeline {
    agent {
        label 'docker' 
    }
    environment {
        // ANDROID_HOME    = "${env.WORKSPACE}"
        ANDROID_NDK     = "android-ndk-r25"
        ANDROID_HOME    = "${env.WORKSPACE}/android-8.1.0"
        PATH            = "${env.ANDROID_HOME}/cmdline-tools/latest/bin:${env.HOME}/.local/bin:${env.PATH}"
    }
    stages {
        stage('collect-artifacts') {
            steps {
                sh 'if [ ! -f ' + env.ANDROID_NDK + '-linux.zip ] ; then wget https://dl.google.com/android/repository/android-ndk-r25-linux.zip ; fi'
                sh 'if [ ! -d ' + env.ANDROID_NDK + ' ] ; then unzip ' + env.ANDROID_NDK + '-linux.zip ; fi'
                sh 'if [ ! -f platform-27_r03.zip ] ; then wget https://dl.google.com/android/repository/platform-27_r03.zip ; fi'
                sh 'if [ ! -d android-8.1.0 ] ; then unzip platform-27_r03.zip ; mkdir -p android-8.1.0/tools ; fi'
                sh 'if [ ! -f commandlinetools-linux-8512546_latest.zip ] ; then wget https://dl.google.com/android/repository/commandlinetools-linux-8512546_latest.zip ; fi'
                sh 'unzip -o commandlinetools-linux-8512546_latest.zip ; yes | cp -rf cmdline-tools/* android-8.1.0/tools/'
            }
        }
        stage ('setup-env') {
            steps {
                sh "echo WORKSPACE=${env.WORKSPACE}"
                sh "echo PATH=${env.PATH}"
                sh 'if [ ! -d buildozer ] ; then git clone https://github.com/kivy/buildozer ; fi'
                sh 'cd buildozer ; git pull'
                sh 'pip install --user -e buildozer'
                sh "${env.ANDROID_HOME}/tools/bin/sdkmanager \"platforms;android-27\""
            }
        }
        stage('build') {

            steps {
                withEnv(["PATH=${env.HOME}/.local/bin:${env.PATH}"]) {
                    sh "echo PATH=${env.PATH}"
                    sh "echo HOME=${env.HOME}"
                    sh "echo USER=${env.USER}"
                    sh "echo Overwriting buildozer.spec file with buildozer.jenkins.spec..."
                    sh "cp buildozer.jenkins.spec buildozer.spec"
                    sh '~/.local/bin/buildozer --version'
                    // sh '~/.local/bin/buildozer android clean'
                    sh "echo Starting build..."
                    sh '~/.local/bin/buildozer android debug'
                }
            }
        }
    }
}
