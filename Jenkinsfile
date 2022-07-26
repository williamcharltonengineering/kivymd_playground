pipeline {
    agent {
        label 'docker' 
    }
    environment {
        // ANDROID_HOME    = "${env.WORKSPACE}"
        ANDROID_NDK     = "android-ndk-r25"
        ANDROID_HOME    = "/usr/lib/android-sdk"
        PATH            = "${env.ANDROID_HOME}/cmdline-tools/latest/bin:${env.HOME}/.local/bin:${env.PATH}"
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
                sh 'if [ ! -d cmdline-tools ] ; then unzip commandlinetools-linux-8512546_latest.zip ; fi'
            }
        }
        stage ('setup-env') {
            steps {
                sh "echo WORKSPACE=${env.WORKSPACE}"
                sh "echo PATH=${env.PATH}"
                sh 'if [ ! -d buildozer ] ; then git clone https://github.com/kivy/buildozer ; fi'
                sh 'cd buildozer ; git pull'
                sh 'pip install --user -e buildozer'
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
                sh "echo PATH=${env.PATH}"
                sh "echo HOME=${env.HOME}"
                sh "echo USER=${env.USER}"
                sh '~/.local/bin/buildozer --version'
                sh '~/.local/bin/buildozer clean'
                sh '~/.local/bin/buildozer android debug'
            }
        }
    }
}
