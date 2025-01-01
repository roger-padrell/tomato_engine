# Remove previous documentation
rm -rf /docs/{*,.*}
# Generate documentation
nim doc --project --index:on --outdir:docs src/tomato_engine.nim
# Copy static documentation to /docs
cp -r staticdocs/* docs/