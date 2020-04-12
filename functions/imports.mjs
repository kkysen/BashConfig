import {promises as fs} from "fs";

async function existsAnd(path, statsFunc) {
    try {
        const stats = await fs.stat(path);
        return statsFunc(stats);
    } catch (e) {
        return false;
    }
}

async function getImportScript(dir, importFile) {
    function warn(name, message) {
        console.warn(`import "${name}" for dir "${dir}" in file "${importFile}": ${message}`);
    }

    const notEmpty = a => a.length > 0;
    const isFile = stats => stats.isFile();

    const now = Date.now();
    function daysOld(stats) {
        const diffTime = now - stats.mtime;
        return diffTime / (1000 * 60 * 60 * 24);
    }

    const maxDaysOld = 1;

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
        const paths = {
            normal: `${dir}/${name}.sh`,
            generator: `${dir}/${name}.generate.sh`,
            generated: `${dir}/${name}.generated.sh`,
        };
        const lines = [];
        if (await existsAnd(paths.normal, isFile)) {
            lines.push(`. "${paths.normal}"`);
        }
        if (await existsAnd(paths.generator, isFile)) {
            const cached = await existsAnd(paths.generated, stats => daysOld(stats) < maxDaysOld);
            if (!cached) {
                lines.push(`"${paths.generator}" > "${paths.generated}"`);
            }
            lines.push(`. "${paths.generated}"`);
        }
        if (lines.length === 0) {
            warn(name, "cannot be found");
        }
        return lines.join("\n");
    }))).filter(notEmpty);
    return imports.join("\n");
}

async function run() {
    const [, , dir, importFile] = process.argv;
    const script = await getImportScript(dir, importFile);
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
