var pump = require('pump')
var ndjson = require('ndjson')
var through = require('through2')
var hyperquest = require('hyperquest')
var token = process.argv.slice(2)

pump(
  hyperquest('http://10.10.10.225:2375/events'),
  ndjson.parse(),
  through.obj(write),
  process.stdout
)

function send_container_event(a, b, c, d, e, f, g, h, i, j, k , l) {
  var request = require('request');
  var options = {
    'method': 'POST',
    'url': 'http://10.10.10.225:4000/channels/dockerchannel/chaincodes/eventdb',
    'headers': {
      'Authorization': "Bearer " + token[0],
      'Content-Type': 'application/json'
    },
    body: JSON.stringify({"fcn":"createEvent","peers":["peer0.provedor.labenv.com","peer0.desenvolvedor.labenv.com","peer0.usuario.labenv.com"],"ChaincodeName":"eventdb","args":[String(a),String(b),String(c),String(d),String(e),String(f),String(g),String(h),String(i),String(j),String(k),String(l)]})
  
  }
  request(options, function (error, response) {
    if (error) throw new Error(error),
    console.log(response.body)
  })
}

function send_service_event(a, b, c, d, e, f, g, h, i, j) {
  var request = require('request');
  var options = {
    'method': 'POST',
    'url': 'http://10.10.10.225:4000/channels/dockerchannel/chaincodes/eventdb',
    'headers': {
      'Authorization': "Bearer " + token[0],
      'Content-Type': 'application/json'
    },
    body: JSON.stringify({"fcn":"createEvent","peers":["peer0.provedor.labenv.com","peer0.desenvolvedor.labenv.com","peer0.usuario.labenv.com"],"ChaincodeName":"eventdb","args":[String(a),String(b),String(c),String(d),String(e),String(f),String(g),String(h),String(i),String(j)]})
  
  }
  request(options, function (error, response) {
    if (error) throw new Error(error),
    console.log(response.body)
  })
}

function write (chunk, enc, next) {


  if ((chunk.Type=="service")) {

    A = [chunk.Type, chunk.Action, chunk.Actor.ID, chunk.Actor.Attributes.name, chunk['Actor']['Attributes']['replicas.new'], chunk['Actor']['Attributes']['replicas.old'], chunk.scope, chunk.time, chunk.timeNano],

    send_service_event(A[2], A[0], A[1], A[2], A[3], A[4], A[5], A[6], A[7], A[8]),

    next(null)

  } else {
    A = [chunk.status, chunk.id, chunk.from, chunk.Type, chunk.Action, chunk.Actor.ID, chunk.Actor.Attributes.image, chunk.Actor.Attributes.name, chunk.scope, chunk.time, chunk.timeNano],
    
    send_container_event(A[5], A[0], A[1], A[2], A[3], A[4], A[5], A[6], A[7], A[8], A[9], A[10], A[11]),

    next(null)
  }
}
// A = [chunk.status, chunk.id, chunk.from, chunk.Type, chunk.Action, chunk.Actor.ID, chunk.Actor.Attributes.image, chunk.Actor.Attributes.name, chunk.scope, chunk.time, chunk.timeNano],
