import { promises as fs } from "fs";

async function run() {
    const buffer = await fs.readFile("/dev/stdin");
    const inputString = buffer.toString("utf-8");
    const input = (() => {
        try {
            return JSON.parse(inputString);
        } catch {
            return inputString;
        }
    })();
    const [, , js, ...args] = process.argv;
    // js should be of the form `input => output`
    const func = new Function("args", "fs", `return ${js}`)(args, fs);
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
