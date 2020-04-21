async function main(input) {
    const newMap = cleanMusicFileNames(input);
    const renameFile = args[0];
    const prevMap = JSON.parse(await fs.readFile(renameFile, "utf-8"));
    const map = {...prevMap, ...newMap};
    await fs.writeFile(renameFile, JSON.stringify(map, null, 4));
}

function cleanMusicFileNames(filesAsString) {
    // main function must be on first line
    // noinspection CommaExpressionJS
    const toObj = (obj, [key, value]) => (obj[key] = value, obj);

    const newMap = filesAsString.split("\0").map(fileName => {
        if (!fileName) {
            return;
        }
        const {dir, name, base, ext} = path.parse(fileName);
        if (ext !== ".mp3") {
            return;
        }
        const newName = cleanFileName(name);
        if (!newName || newName === name) {
            return;
        }
        const newFileName = path.join(dir, newName + ext);
        return [fileName, newFileName];
    })
        .filter(Boolean)
        .reduce(toObj, {});
}

/*
algorithm

for each of [audio, lyric, official],
check if s contains it, case-insensitively
if it does, we want to remove this part of the name
search to the right of the match, find the first of ), ], -, or end
search to the left of the match, find the first of ), ], or -
if couldn't find anything, emit warning
try to match the delimiters, but have some tolerance
- and end of string should match either () or [], but () and [] shouldn't match each other
remove this string up to the delimiters
trimRight left side and trimLeft right side
join together with a single space and then trim again
repeat until nothing can be removed
 */

function cleanFileNameOnce(s) {
    for (const remove of ["audio", "lyric", "official"]) {
        const match = new RegExp(remove, "i").exec(s);
        if (!match) {
            continue;
        }
        const [remove] = match;
        const i = match.index;
        const j = i + remove.length;
        const before = s.slice(0, i);
        const after = s.slice(j);

        // TODO

        const close = /[)\]-]/.exec(after) || {0: "", index: after.length};
        const end = j + close.index;
        const closeDelim = close[0];

        const open = /[([-]/.exec(before);
    }
}

function cleanFileName(name) {
    for (; ;) {
        const newName = cleanFileNameOnce(name);
        if (!newName) {
            return name;
        }
        name = newName;
    }
}
