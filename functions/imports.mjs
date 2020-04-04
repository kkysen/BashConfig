import {promises as fs} from "fs";

async function existsAnd(path, statsFunc) {
    try {
        const stats = await fs.stat(path);
        return statsFunc(stats);
    } catch (e) {
        return false;
    }
}

async function run() {
    const [, , dir, importFile] = process.argv;

    function warn(name, message) {
        console.warn(`import "${name}" for dir "${dir}" in file "${importFile}": ${message}`);
    }

    const notEmpty = a => a.length > 0;
    const isFile = stats => stats.isFile();

    const contents = await fs.readFile(`${importFile}`, "utf8");
    const names = contents.split("\n")
        .map(line => line.split("#")[0].trim())
        .filter(notEmpty)
        .map(line => {
            if (line.startsWith(`"`) && line.endsWith(`"`)) {
                return line.slice(1, line.length - 1);
            }
            if (line.includes(" ")) {
                warn(line, "contains spaces but is not double-quoted");
                return "";
            }
            return line;
        })
        .filter(notEmpty);
    const imports = (await Promise.all(names.map(async name => {
        const path = `${dir}/${name}.sh`;
        const generatorPath = `${dir}/${name}.generate.sh`;
        if (await existsAnd(path, isFile)) {
            return `. "${path}"`;
        }
        if (await existsAnd(generatorPath, isFile)) {
            return `genConfig "${name}" "${dir}"`;
        }
        warn(name, "cannot be found");
        return "";
    }))).filter(notEmpty);
    const script = imports.join("\n");
    console.log(script);
}

(async () => {
    try {
        await run();
    } catch (e) {
        console.error(e);
        process.exit(1);
    }
})();
