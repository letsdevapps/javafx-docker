# Java FX Docker

## Download SDK JavaFX

	https://openjfx.io/
	
	Acesse o site oficial e em downloads procure por SDK e seu sistema operacional

## Iniciar o Projeto pelo Maven Archetype

	mvn archetype:generate -DgroupId=com.exemplo -DartifactId=meu-projeto -DarchetypeArtifactId=maven-archetype-quickstart -DinteractiveMode=false
	
## Corrigir o POM

	adicione o seguinte trecho antes de Dependencies
	
	<properties>
		<project.build.sourceEncoding>UTF-8</project.build.sourceEncoding>
	    	<maven.compiler.source>21</maven.compiler.source>
	    	<maven.compiler.target>21</maven.compiler.target>
	    	<exec.mainClass>com.pro.Main</exec.mainClass>
  	</properties>

## Adicionar Dependencias

	<!-- Dependência JavaFX para controle de interface gráfica -->
	<dependency>
		<groupId>org.openjfx</groupId>
		<artifactId>javafx-controls</artifactId>
		<version>21</version>
	</dependency>
	<!-- Dependência para FXML -->
	<dependency>
	        <groupId>org.openjfx</groupId>
	        <artifactId>javafx-fxml</artifactId>
	        <version>21</version>
	</dependency>

## Adicionar plugin para gerar arquivo JAR com Manifest

	<build>
	    <plugins>
		<!-- Plugin para gerar o arquivo JAR com o Manifesto -->
		<plugin>
		    <groupId>org.apache.maven.plugins</groupId>
		    <artifactId>maven-jar-plugin</artifactId>
		    <version>3.1.0</version>
		    <configuration>
		        <archive>
		            <manifestEntries>
		                <Main-Class>com.pro.Main</Main-Class>
		            </manifestEntries>
		        </archive>
		    </configuration>
		</plugin>
		</plugins>
	</build>

## Compilar com Maven

 	mvn clean package

## Executar Jar

Aponte o caminho para a pasta lib da SDK que voce baixou

 	java --module-path "/home/user/openjfx-21.0.8_linux-x64_bin-sdk/javafx-sdk-21.0.8/lib" --add-modules javafx.controls,javafx.graphics,javafx.fxml -jar target/javafx-1.0-SNAPSHOT.jar

## DOCKER

### Apos configurar o Dockerfile

	docker build -t javafx-app .

### Entre no container para analisar nas vezes que estava dando erro

	docker run -it --entrypoint /bin/bash javafx-app

### Para autorizar o Xorg

	xhost +local:docker

### Rodar a imagem

	docker run -it --env DISPLAY=$DISPLAY --volume /tmp/.X11-unix:/tmp/.X11-unix javafx-app
	
	docker run -it -e DISPLAY=$DISPLAY -v /tmp/.X11-unix:/tmp/.X11-unix javafx-app
	
### Retirar Auth

	xhost -local:docker
