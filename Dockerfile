FROM debian

ENV LJHOME=/work/learning-journey

RUN mkdir /work && cd /work \
    && apt-get update -y \
    && apt-get install -y git make autoconf g++ flex bison gnupg apt-transport-https wget vim \
    && apt-get install -y default-jdk \
    && echo "deb https://dl.bintray.com/sbt/debian /" | tee -a /etc/apt/sources.list.d/sbt.list \
    && apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 642AC823 \
    && apt-get update -y \
    && apt-get install -y sbt \
    && git clone http://git.veripool.org/git/verilator \
    && cd verilator && git pull \
    && git checkout verilator_3_904 && unset VERILATOR_ROOT \
    && autoconf && ./configure \
    && make && make install \
    && cd /work \
    && git clone https://github.com/ucb-bar/riscv-sodor.git \
    && git clone https://github.com/Intensivate/learning-journey.git \
    && cd ${LJHOME} \
    && echo exit | sbt \
    && echo "Finished"

WORKDIR /work/learning-journey
CMD [ "bash" ]


