# Remove previous documentation
rm -rf /docs/{*,.*}
# Generate documentation
nim doc --project --index:on --outdir:docs src/tomato_engine.nim