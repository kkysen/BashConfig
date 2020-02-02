import { promises as fs } from "fs";

async function run() {
    const buffer = await fs.readFile("/dev/stdin");
    const inputString = buffer.toString("utf-8");
    const input = JSON.parse(inputString);
    const [, , js] = process.argv;
    // js should be of the form `input => output`
    const func = new Function(`return ${js}`)();
    const output = func(input);
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
    }
})();
