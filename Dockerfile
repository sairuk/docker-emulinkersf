FROM multiarch/debian-debootstrap:i386-stretch
MAINTAINER sairuk
ARG USER=user
ARG UID=1004
ARG APPNAME=emulinker
ARG APPVER=0.90.0
ARG APPFILE=EmuLinkerSF.zip
ARG APPURL=https://github.com/God-Weapon/EmuLinkerSF/releases/download/${APPVER}/${APPFILE}
ARG SRVDIR=/srv/${APPNAME}

RUN apt-get update && apt-get -y upgrade

RUN apt-get -y install \
      curl \
      unzip

RUN mkdir -p ${SRVDIR} /usr/share/man/man1/ /usr/share/man/man7/
RUN apt-cache search jre
RUN apt-get -y install ca-certificates-java openjdk-8-jre-headless

RUN curl -sLo /tmp/${APPFILE} ${APPURL} \
    && unzip /tmp/${APPFILE} -d ${SRVDIR} \
    && rm /tmp/${APPFILE}

RUN mv ${SRVDIR}/EmuLinkerSF/* ${SRVDIR}/ \
    && rmdir ${SRVDIR}/EmuLinkerSF/

RUN useradd -m -s /bin/bash -u ${UID} ${USER}

COPY _custom/. ${SRVDIR}

RUN chown ${USER}: ${SRVDIR}

USER ${USER}

EXPOSE \
27888/tcp \
27888/udp \
27889-27899/udp

WORKDIR ${SRVDIR}

CMD  ["java", "-Xms64m", "-Xmx128m", "-cp", "./conf:./lib/emulinker.jar:./lib/commons-collections-3.1.jar:./lib/commons-configuration-1.1.jar:./lib/commons-el.jar:./lib/commons-lang-2.1.jar:./lib/commons-logging.jar:./lib/commons-pool-1.2.jar:./lib/log4j-1.2.12.jar:./lib/nanocontainer-1.0-beta-3.jar:./lib/picocontainer-1.1.jar:./lib/xstream-1.1.2.jar:./lib/commons-codec-1.3.jar:./lib/commons-httpclient-3.0-rc3.jar","org.emulinker.kaillera.pico.PicoStarter"]
