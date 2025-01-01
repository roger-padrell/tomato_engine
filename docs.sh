# Remove previous documentation
rm -rf docs/*
# Generate documentation
nim doc --project --index:on --outdir:docs src/tomato_engine.nim
# Generate JSON docs
nim jsondoc --project --index:on --outdir:docs/json src/tomato_engine.nim
# Generate docs.md
deno run --allow-read --allow-write generateReadme.ts
# Copy docs.md and README.md to /docs
cp docs.md docs/docs.md
cp README.md docs/README.md