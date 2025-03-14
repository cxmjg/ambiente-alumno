# Imagen base con entorno gráfico Ubuntu XFCE
FROM lscr.io/linuxserver/webtop:ubuntu-xfce

# Declaración de variables de entorno
ENV USERNAME=devuser
ENV USER_UID=1000
ENV USER_GID=1000
ENV ECLIPSE_VERSION="2025-03"
ENV INSTALL_DIR="/opt/eclipse"
ENV EXECUTABLE="/usr/local/bin/eclipse"
ENV LANG=es_ES.UTF-8
ENV LANGUAGE=es_ES.UTF-8
ENV LC_ALL=es_ES.UTF-8

# Instalar dependencias y configurar idioma español
RUN apt update && apt install -y \
    locales language-pack-es sudo \
    python3 python3-pip python3-venv \
    wget curl unzip git \
    openjdk-17-jdk openjdk-17-jre \
    libreoffice \
    && locale-gen es_ES.UTF-8 \
    && update-locale LANG=${LANG} LANGUAGE=${LANGUAGE} LC_ALL=${LC_ALL} \
    && apt clean

# Instalar VSCodium
RUN wget -qO /tmp/vscodium.deb "https://github.com/VSCodium/vscodium/releases/download/1.98.2.25072/codium_1.98.2.25072_amd64.deb" \
    && apt install -y /tmp/vscodium.deb \
    && rm /tmp/vscodium.deb

# Instalar Eclipse
RUN wget -qO /tmp/eclipse.tar.gz "https://ftp.osuosl.org/pub/eclipse/technology/epp/downloads/release/${ECLIPSE_VERSION}/R/eclipse-java-${ECLIPSE_VERSION}-R-linux-gtk-x86_64.tar.gz" \
    && mkdir -p ${INSTALL_DIR} \
    && tar -xzf /tmp/eclipse.tar.gz -C ${INSTALL_DIR} --strip-components=1 \
    && rm /tmp/eclipse.tar.gz \
    && ln -sf ${INSTALL_DIR}/eclipse ${EXECUTABLE} \
    && echo "[Desktop Entry]" > /usr/share/applications/eclipse.desktop \
    && echo "Name=Eclipse IDE" >> /usr/share/applications/eclipse.desktop \
    && echo "Type=Application" >> /usr/share/applications/eclipse.desktop \
    && echo "Exec=${EXECUTABLE}" >> /usr/share/applications/eclipse.desktop \
    && echo "Icon=${INSTALL_DIR}/icon.xpm" >> /usr/share/applications/eclipse.desktop \
    && echo "Categories=Development;IDE;" >> /usr/share/applications/eclipse.desktop \
    && echo "Terminal=false" >> /usr/share/applications/eclipse.desktop

# Agregar repositorio de compatibilidad con versiones anteriores
RUN echo "deb http://archive.ubuntu.com/ubuntu jammy universe" >> /etc/apt/sources.list && \
    apt update

# Instalar dependencias manualmente
RUN apt install -y \
    libatkmm-1.6-1v5 \
    libglibmm-2.4-1t64 \
    libgtkmm-3.0-1t64 \
    libodbc2 \
    libproj25 \
    libsecret-1-0 \
    libsigc++-2.0-0v5 \
    libzip4t64 \
    && apt clean

# Instalar MySQL Workbench
RUN wget -qO /tmp/mysql-workbench.deb "https://dev.mysql.com/get/Downloads/MySQLGUITools/mysql-workbench-community_8.0.41-1ubuntu24.04_amd64.deb" \
    && apt install -y /tmp/mysql-workbench.deb \
    && rm /tmp/mysql-workbench.deb

# Instalar MongoDB Compass
RUN wget -qO /tmp/mongodb-compass.deb "https://downloads.mongodb.com/compass/mongodb-compass_1.39.2_amd64.deb" \
    && apt install -y /tmp/mongodb-compass.deb \
    && rm /tmp/mongodb-compass.deb

# Crear acceso directo en el escritorio
RUN echo "[Desktop Entry]" > /etc/skel/mongodb-compass.desktop \
    && echo "Name=MongoDB Compass" >> /etc/skel/mongodb-compass.desktop \
    && echo "Type=Application" >> /etc/skel/mongodb-compass.desktop \
    && echo "Exec=/opt/appimages/mongodb-compass.AppImage" >> /etc/skel/mongodb-compass.desktop \
    && echo "Icon=/opt/appimages/mongodb-compass.png" >> /etc/skel/mongodb-compass.desktop \
    && echo "Categories=Development;Database;" >> /etc/skel/mongodb-compass.desktop \
    && echo "Terminal=false" >> /etc/skel/mongodb-compass.desktop \
    && chmod +x /etc/skel/mongodb-compass.desktop
