
var path = require('path');
var fs = require('fs');
var xml = require('xml-js');

function Page(p, basePath) {

    this.basePath = basePath;
    this.dirname = path.dirname(p);

    var ext = path.extname(p);
    var base = p.substr(0, p.length - ext.length);

    this.path = {
        html: base + '.wx.html',
        wxml: base + '.wxml',
        wxss: base + '.wxss',
        json: base + '.json',
    };

};

Page.prototype = Object.create(Object.prototype, {
    compile: {
        value: function () {
            var vs = [];
            vs.push('<head><meta charset="utf-8"/><meta name="viewport" content="width=device-width,minimum-scale=1,maximum-scale=1" /><style type="text/css">\n');
            vs.push((fs.readFileSync("app.css") + '').replace(/([0-9\.\-]+)rpx/g,function(text,v){
                return (v * 0.05) + 'rem';
            }));
            this.compilePageCSS(vs);
            vs.push('</style></head><body><script type="text/javascript">\n');
            vs.push("(function(){\n");
            vs.push("var View = kk.CreateElement;\n")
            vs.push("kk.Page(");

            this.compilePageView(vs);

            vs.push(");})();\n");
            vs.push('</script></body>');

            fs.writeFileSync(this.path.html, vs.join(''));
        },
        writable: false
    },
    compilePageView: {
        value: function (vs) {

            var level = 0;
            var doc = xml.xml2js('<document>' + fs.readFileSync(this.path.wxml, { encoding: 'utf8' }) + '</document>', { compact: false });

            vs.push("function(element,data,context){\n");

            level++;

            for (let element of doc.elements[0].elements) {
                View(element);
            }

            level--;

            vs.push("}");

            function View(element) {

                if (element.type != "element") {
                    return;
                }

                vs.push("\t".repeat(level));
                vs.push("View(element,data,");
                vs.push(JSON.stringify(element.name));
                vs.push(",");

                var attrs = element.attributes;

                if (element.elements) {
                    for (var e of element.elements) {
                        if (e.type == 'text') {
                            attrs['#text'] = e.text;
                            break;
                        }
                    }
                }

                vs.push(JSON.stringify(attrs));

                vs.push(",context,function(element,data,context){\n");

                level++;

                if (element.elements) {
                    for (let e of element.elements) {
                        View(e);
                    }
                }

                level--;

                vs.push("\t".repeat(level));
                vs.push("});\n");
            }

        },
        writable: false
    },
    compilePageCSS: {
        value: function (vs) {

            vs.push(Parse(this.path.wxss));

            function Parse(p) {
                if (fs.existsSync(p)) {
                    var v = fs.readFileSync(p) + '';
                    var basedir = path.dirname(p);
                    v = v.replace(/([0-9\.\-]+)rpx/g,function(text,v){
                        return (v * 0.05) + 'rem';
                    });
                    v = v.replace(/\@import +\"([^\"]*?)\";/g, function (text, v) {
                        return Parse(path.join(basedir, v));
                    });
                    return v;
                }
                return '';
            }

        },
        writable: false
    }
});

module.exports = Page;
