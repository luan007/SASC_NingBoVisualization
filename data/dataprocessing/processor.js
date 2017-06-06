var target = 'meituan-utf8.txt'
var fs = require('fs');

console.log(fs.readFileSync(target).toString('utf8').substring(1));