pipeline {
    agent {
        label 'docker' 
    }
    environment {
        ANDROID_HOME    = "${env.WORKSPACE}"
        PATH            = "${env.ANDROID_HOME}/cmdline-tools/latest/bin:${env.PATH}"
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
                sh 'if [ ! -f android-ndk-r25-linux.zip ] ; then wget https://dl.google.com/android/repository/android-ndk-r25-linux.zip ; fi'
                sh 'if [ ! -d android-ndk-r25 ] ; then unzip android-ndk-r25-linux.zip ; fi'
                sh 'if [ ! -f platform-27_r03.zip ] ; then wget https://dl.google.com/android/repository/platform-27_r03.zip ; fi'
                sh 'if [ ! -f commandlinetools-linux-8512546_latest.zip ] ; then wget https://dl.google.com/android/repository/commandlinetools-linux-8512546_latest.zip ; fi'
                sh 'if [ ! -d android-8.1.0 ] ; then unzip commandlinetools-linux-8512546_latest.zip ; fi'
            }
        }
        stage('build') {
            agent {
                docker {
                    label 'docker'
                    image 'kivy/buildozer:latest'
                    args '-v ' + env.WORKSPACE + ':/home/user/hostcwd --entrypoint=""'
                }
            }
            steps {
                sh 'buildozer --version'
                sh 'buildozer android debug'
            }
        }
    }
}