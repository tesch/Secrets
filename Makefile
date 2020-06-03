install:
	swift build --configuration release
	install .build/Release/secrets /usr/local/bin/secrets
