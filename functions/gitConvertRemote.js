function convertRemoteUrl(remoteUrl) {
    for (const regex of [
        /https:\/\/([^\/]+)\/([^\/]+)\/([^\.]+)\.git/,
        /git@([^:]+):([^\/]+)\/([^\.]+)\.git/,
    ]) {
        const match = regex.exec(remoteUrl);
        if (!match) {
            continue;
        }
        const [_, host, userName, repoName] = match;
        return protocol => {
            switch (protocol) {
                case "https":
                    return `https://${host}/${userName}/${repoName}.git`;
                case "ssh":
                    return `git@${host}:${userName}/${repoName}.git`;
                default:
                    throw new Error(`protocol \`${protocol}\` must be ssh or https`);
            }
        };
    }
    return protocol => {
        switch (protocol) {
            case "https":
            case "ssh":
                throw new Error(`invalid current remote url: ${remoteUrl}`);
            default:
                throw new Error(`protocol \`${protocol}\` must be ssh or https`);
        }
    };
}

function main() {
    try {
        const [_, __, protocol, currentRemoteUrl] = process.argv;
        const newRemoteUrl = convertRemoteUrl(currentRemoteUrl)(protocol);
        console.log(newRemoteUrl);
        process.exit(0);
    } catch (e) {
        console.error(e.message);
        process.exit(1);
    }
}

main();
