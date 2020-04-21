import {promises as fs} from "fs";
import * as path from "path";

async function run() {
    const inputString = await fs.readFile("/dev/stdin", "utf-8");
    const input = (() => {
        try {
            return JSON.parse(inputString);
        } catch {
            return inputString;
        }
    })();
    const [, , js, ...args] = process.argv;
    // js should be of the form `input => output`
    const closure = {args, fs, path};
    const func = new Function(...Object.keys(closure), `return ${js}`)(...Object.values(closure));
    const output = await func(input);  // allow promises
    const outputString = typeof output === "string"
        ? output
        : Array.isArray(output) && JSON.stringify(output).length < 80
            ? JSON.stringify(output)
            : JSON.stringify(output, null, 2);
    console.log(outputString);
}

(async () => {
    try {
        await run();
    } catch (e) {
        console.error(e);
        process.exit(1);
    }
})();
