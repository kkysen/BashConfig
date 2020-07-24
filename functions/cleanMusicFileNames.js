async function main(input) {
    const newMap = cleanMusicFileNames(input);
    const renameFile = args[0];
    const prevMap = await readPrevMap(renameFile);
    const map = {...prevMap, ...newMap};
    await fs.writeFile(renameFile, JSON.stringify(map, null, 4));
}

async function readPrevMap(path) {
    try {
        return JSON.parse(await fs.readFile(path, "utf-8"));
    } catch (e) {
        if (e.code === "ENOENT") {
            return {};
        }
        throw e;
    }
}

function cleanMusicFileNames(filesAsString) {
    const map = {};
    for (const filePath of filesAsString.split("\0")) {
        const newFilePath = cleanFilePath(filePath);
        if (newFilePath === undefined) {
            continue;
        }
        map[filePath] = newFilePath;
    }
    return map;
}

function cleanFilePath(filePath) {
    if (!filePath) {
        return;
    }
    const {dir, name, ext} = path.parse(filePath);
    if (ext !== ".mp3") {
        return;
    }
    const newName = cleanFileName(name);
    if (!newName || newName === name) {
        return;
    }
    return path.join(dir, newName + ext);
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

function cleanFileName(name) {
    for (; ;) {
        const newName = cleanFileNameOnce(name);
        if (newName === undefined) {
            return name;
        }
        name = newName;
    }
}

function cleanFileNameOnce(fileName) {
    // oficial is Spanish
    for (const pattern of ["video", "audio", "lyric", "official", "edit", "oficial"]) {
        const match = new RegExp(pattern, "i").exec(fileName);
        if (!match) {
            continue;
        }
        const [matched] = match;
        const i = match.index;
        const j = i + matched.length;
        const before = fileName.slice(0, i);
        const after = fileName.slice(j);

        function findDelims(s, delims, reverse) {
            const indexOf = reverse ? "".lastIndexOf : "".indexOf;
            const direction = reverse ? -1 : 1;
            return [...delims]
                .map((delim, delimIndex) => ({delim, delimIndex, index: indexOf.call(s, delim)}))
                .filter(e => e.index !== -1)
                .sort((a, b) => direction * (a.index - b.index))
        }

        const endDelim = index => ({delim: "", delimIndex: 3, index});

        const openDelims = [...findDelims(before, "([-", true), endDelim(0)];
        const closeDelims = [...findDelims(after, ")]-", false), endDelim(after.length)];
        if (openDelims.length === 1 && closeDelims.length === 1) {
            continue;
        }

        const [start, end] = (() => {
            for (let i = 0, j = 0; i < openDelims.length && j < closeDelims.length;) {
                const open = openDelims[i];
                const close = closeDelims[j];
                const match = open.delimIndex === close.delimIndex;
                const partialMatch = Math.max(open.delimIndex, close.delimIndex) >= 2;
                if (match || partialMatch) {
                    return [open.index, close.index];
                }
                if (open.delimIndex < close.delimIndex) {
                    j++;
                } else {
                    i++;
                }
            }
        })();

        function reassembleNewFileName({start, end}) {
            const newBefore = before.slice(0, start).trimRight();
            const newAfter = after.slice(end + 1).trimLeft();
            const removed = before.slice(start) + matched + after.slice(0, end + 1);
            if (isAnException(removed)) {
                return;
            }
            return `${newBefore} ${newAfter}`.trim();
        }

        const newFileName = reassembleNewFileName({start, end});
        if (newFileName === undefined) {
            continue;
        }

        // e.x. "Imagine Dragons - Bleeding Out Lyrics.mp3"
        // should be "Imagine Dragons - Bleeding Out.mp3",
        // not "Imagine Dragons.mp3",
        const removedTooMuchWithHyphen = fileName.includes("-") && !newFileName.includes("-");
        if (!removedTooMuchWithHyphen) {
            return newFileName;
        }
        const secondNewFileName = reassembleNewFileName({
            start: before.lastIndexOf(" "),
            end,
        })
        if (secondNewFileName === undefined) {
            continue;
        }
        return secondNewFileName;
    }
}

function isAnException(removed) {
    // if (removed.includes("FIFA")) {
    //     return true;
    // }
    return false;
}
