const doc = await Deno.readTextFile("docs/json/theindex.json");
const data = JSON.parse(doc);
let readme = `# Documentation - Tomato engine\n\n`;
for (const key in data.modules) {
    let name = data.modules[key].split("/");
    name = name[name.length - 1];
    name = name.replaceAll("_", " ");
    readme += `## ${name}\n\n`;
    readme += `[${name}](${data.modules[key]})\n\n`;
}
Deno.writeTextFile("docs.md", readme);