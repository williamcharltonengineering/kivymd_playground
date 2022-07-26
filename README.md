# Buildozer Example Project For Jenkins

This project is a simple copy-paste of the example app from [KivyMD](https://kivymd.readthedocs.io/en/latest/getting-started/) First application.

The purpose of _this_ particular repository is to show a Jenkins-based build with a dedicated Debian11 build node.

```puml
cloud "Unraid" {
    node "Jenkins" {
        frame "Debian11 Node - jenkins-docker-slave" {
        }
    }
}
cloud "Github" {
    node "williamcharltonengineering" {
        frame "kivymd_playground" {
        }
    }
}
```

# APPENDIX

Setting up the Debian11 Node (`jenkins-docker-slave`) was a bit tricky...

Things I tried before really reading the docs...

```console
root@jenkins-docker-slave:/home/will# history | grep install
    3  apt install     apt-transport-https     ca-certificates     curl     gnupg     lsb-release
    9  apt install docker-ce docker-ce-cli containerd.io
   20  apt -y install gcc
   25  apt-get install clang-13 lldb-13 lld-13
   26  apt install clang lldb lld
   28  apt install sdkmanager
   29  apt install android-sdk
   57  apt install python3-venv
   61  apt install zlib1g-dev
   77  apt install cython3
   79  apt install python3-pip
   90  apt install cmake g++ make
   95  apt install autoconf
   96  apt install libtool
   98  apt install libssl-dev
   98  apt install zip
```

Then I read the docs a bit and found this nugget (changed jdk-13 to jdk17 for debian bullseye)

```console
apt install -y \
    git \
    zip \
    unzip \
    openjdk-17-jdk \
    python3-pip \
    autoconf \
    libtool \
    pkg-config \
    zlib1g-dev \
    libncurses5-dev \
    libncursesw5-dev \
    libtinfo5 \
    cmake \
    libffi-dev \
    libssl-dev
```