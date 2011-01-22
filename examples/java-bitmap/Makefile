all: config install

config: local.properties build.xml

install:
	ndk-build
	ant install


local.properties build.xml:
	android update project --name java-bitmap --target 2 --path .

clean:
	ndk-build clean
	ant clean
	rm -Rf obj libs


.PHONY: all config clean
