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

    const completionsDir = process.env.COMPLETIONS;

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
        const base = `${dir}/${name}`;
        const paths = {
            normal: {
                from: `${base}.sh`,
                load: true,
            },
            generated: {
                from: `${base}.generate.sh`,
                to: `${base}.generated.sh`,
                load: true,
            },
            completion: {
                from: `${base}.complete.sh`,
                to: `${completionsDir}/${name}`,
                load: false,
            },
        };
        const lines = [];
        let numFound = 0;
        for (const map of Object.values(paths)) {
            if (!await existsAnd(map.from, isFile)) {
                continue;
            }
            numFound++;
            if (map.to) {
                const cached = await existsAnd(map.to, stats => daysOld(stats) < maxDaysOld);
                if (!cached) {
                    lines.push(`"${map.from}" > "${map.to}"`);
                }
            }
            if (map.load) {
                lines.push(`. "${map.to || map.from}"`); // TODO change || to ??
            }
        }
        if (numFound === 0) {
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
