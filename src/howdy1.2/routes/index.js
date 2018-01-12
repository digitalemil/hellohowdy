var express = require('express');
var router = express.Router();
var fs = require('fs');

/* GET home page. */
router.get('/', function(req, res, next) {
  let port= process.env.PORT;
  if(process.env.PORT== undefined)
    port= 3000;
let secret= process.env.SECRET;
var os = require( 'os' );

let filebasedsecret="";
let text= "";
try {
  text= fs.readFileSync(process.env.MESOS_SANDBOX+"/"+process.env.FILEBASEDSECRET, 'utf8');
  filebasedsecret= JSON.parse(text);
}
catch(e) {
  console.log(e);
}

var networkInterfaces = os.networkInterfaces( );

  res.render('index', { title: 'Howdy v1.2', port: port, secret: secret, interfaces: networkInterfaces, filebasedsecret:filebasedsecret.secret });
});

module.exports = router;
