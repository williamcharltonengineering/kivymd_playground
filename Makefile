.PHONY: help setup serve apk

help:
	@echo "setup - create python3 virtual environment, install dependencies"
	@echo "run   - run the app"
	@echo "apk   - build the android apk"
setup:
	python3 -m venv .venv
	.venv/bin/pip install --upgrade pip
	.venv/bin/pip install kivymd python-for-android
	if [ ! -f android-ndk-r25-linux.zip ] ; then wget https://dl.google.com/android/repository/android-ndk-r25-linux.zip ; fi
	if [ ! -d android-ndk-r25 ] ; then unzip android-ndk-r25-linux.zip ; fi
	if [ ! -f platform-27_r03.zip ] ; then wget https://dl.google.com/android/repository/platform-27_r03.zip ; fi
	if [ ! -f commandlinetools-linux-8512546_latest.zip ] ; then wget https://dl.google.com/android/repository/commandlinetools-linux-8512546_latest.zip ; fi
	if [ ! -d cmdline-tools ] ; then unzip commandlinetools-linux-8512546_latest.zip ; fi
	# install android sdk version 27
	cmdline-tools/bin/sdkmanager --sdk_root=android-8.1.0 --install 'platforms;android-27'
	cmdline-tools/bin/sdkmanager --sdk_root=android-8.1.0 --install 'system-images;android-27;default;arm64-v8a'

apk:
	.venv/bin/p4a apk \
		--package=com.williamcharltonengineering.testapp \
		--requirements=python3,kivy==2.1.0,kivymd==0.104.2,sdl2_ttf==2.0.15,pillow \
		--private ${PWD}/testapp \
		--name "TestApp" \
		--version 0.0.1 \
		--bootstrap=sdl2 \
		--arch=armeabi-v7a \
		--orientation portrait \
		--sdk_dir ${PWD}/android-8.1.0 \
		--ndk_dir ${PWD}/android-ndk-r25

run:
	.venv/bin/python testapp/main.py

devsync:
	scp -r * will@jenkins-docker-slave.local:/home/will/jenkinsworkdir/workspace/kivymd_playground/
