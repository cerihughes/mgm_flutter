export DART_POST_PROCESS_FILE="flutter dartfmt ."
rm -rf openapi
openapi-generator generate -i mgm-schema/v0/openapi.yaml -o openapi -g dart