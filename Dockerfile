FROM openjdk:21-jdk-slim

WORKDIR /app

# Atualiza o apt-get e instala os pacotes necessários (wget e unzip)
RUN apt-get update && \
    apt-get install -y x11-apps wget unzip \
	libgtk-3-0 \
    libx11-xcb1 \
    libgdk-pixbuf2.0-0 \
    libpango-1.0-0 \
    libatk1.0-0 \
    libpangocairo-1.0-0 \
    libcups2 \
	x11-apps \
	libcanberra-gtk-module && \
    rm -rf /var/lib/apt/lists/*

# Baixa o OpenJFX (versão 25.0.1)
#RUN wget https://download2.gluonhq.com/openjfx/25.0.1/openjfx-25.0.1_linux-x64_bin-sdk.zip
RUN wget https://download2.gluonhq.com/openjfx/21.0.9/openjfx-21.0.9_linux-x64_bin-sdk.zip

# Descompacta o arquivo ZIP
#RUN unzip openjfx-25.0.1_linux-x64_bin-sdk.zip
RUN unzip openjfx-21.0.9_linux-x64_bin-sdk.zip

# Move o SDK do OpenJFX para o diretório correto
#RUN mv javafx-sdk-25.0.1 /opt/javafx
RUN mv javafx-sdk-21.0.9 /opt/javafx

# Remove o arquivo .zip após a extração
#RUN rm openjfx-25.0.1_linux-x64_bin-sdk.zip
RUN rm openjfx-21.0.9_linux-x64_bin-sdk.zip


# Defina a variável de ambiente para o OpenJFX
ENV PATH="/opt/javafx/bin:${PATH}"
ENV JAVA_HOME=/usr/local/openjdk-21
ENV JAVA_FX_HOME=/opt/javafx

# Expor a variável DISPLAY para o container
ENV DISPLAY=:0

COPY target/*.jar javafx-1.0.jar

#CMD java --module-path "/opt/javafx/lib" --add-modules javafx.controls,javafx.graphics,javafx.fxml -jar javafx-1.0.jar
CMD ["java", "--module-path", "/opt/javafx/lib", "--add-modules", "javafx.controls,javafx.graphics,javafx.fxml", "-jar", "javafx-1.0.jar"]
