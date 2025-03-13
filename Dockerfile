FROM lscr.io/linuxserver/webtop:ubuntu-xfce

# Instalar dependencias y herramientas de desarrollo
RUN apt update && apt install -y \
    python3 python3-pip python3-venv \
    wget curl unzip git \
    openjdk-17-jdk openjdk-17-jre \
    libreoffice \
    && rm -rf /var/lib/apt/lists/*

# Instalar VSCodium
RUN wget -qO- https://github.com/VSCodium/vscodium/releases/download/1.98.2.25072/codium_1.98.2.25072_amd64.deb \
    | tee /tmp/vscodium.deb \
    && apt install -y /tmp/vscodium.deb \
    && rm /tmp/vscodium.deb

# Instalar Eclipse
RUN wget -qO /tmp/eclipse.tar.gz "https://ftp.osuosl.org/pub/eclipse/oomph/epp/2024-03/R/eclipse-inst-jre-linux64.tar.gz" \
    && mkdir -p /opt/eclipse \
    && tar -xzf /tmp/eclipse.tar.gz -C /opt/eclipse --strip-components=1 \
    && rm /tmp/eclipse.tar.gz
	
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
RUN wget -qO- https://dev.mysql.com/get/Downloads/MySQLGUITools/mysql-workbench-community_8.0.41-1ubuntu24.04_amd64.deb \
    | tee /tmp/mysql-workbench.deb \
    && apt install -y /tmp/mysql-workbench.deb \
    && rm /tmp/mysql-workbench.deb

# Instalar MongoDB Compass
RUN wget -qO /tmp/mongodb-compass.deb https://downloads.mongodb.com/compass/mongodb-compass_1.39.2_amd64.deb \
    && apt install -y /tmp/mongodb-compass.deb \
    && rm /tmp/mongodb-compass.deb

# Definir Eclipse y VSCode como accesibles desde el entorno gráfico
ENV PATH="/opt/eclipse:$PATH"

# Limpiar cache
RUN apt clean

# Definir usuario por defecto
USER abc
