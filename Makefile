.PHONY: test
test:
	rm -rf coverage* && \
	flutter test --coverage test && \
	lcov --remove coverage/lcov.info 'lib/**/setup_on_message.dart' -o coverage/lcov.info && \
    genhtml -q -o coverage coverage/lcov.info && \
	google-chrome coverage/index.html


.PHONY: generate
generate:
	flutter pub run build_runner build --delete-conflicting-outputs
