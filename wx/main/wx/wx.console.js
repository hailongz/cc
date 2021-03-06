
function parseArguments(vs,args) {
    for (var i = 0; i < args.length; i++) {
        var v = args[i];
        switch(typeof v == 'object') {
            case 'object':
            vs.push(JSON.stringify(v, undefined, 4));
            break;
            default:
            vs.push(v + '');
            break;
        }
    }
}

console = {
    log: function () {
        var vs = ["[LOG]"];
        parseArguments(vs,arguments);
        print(vs.join(" "));
    },
    error: function () {
        var vs = ["[ERROR]"];
        parseArguments(vs,arguments);
        print(vs.join(" "));
    },
    debug: function () {
        var vs = ["[DEBUG]"];
        parseArguments(vs,arguments);
        print(vs.join(" "));
    },
    info: function () {
        var vs = ["[INFO]"];
        parseArguments(vs,arguments);
        print(vs.join(" "));
    }
};

module.exports = console;
