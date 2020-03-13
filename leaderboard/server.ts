import { serve, Response } from "https://deno.land/std/http/server.ts";
type User = {
  avatar: Object,
  username: String,
  creationServer: String,
  right: Number,
  score: Number,
  wrong: Number
}

function shuffle(array: Array<any>) {
  array.sort(() => Math.random() - 0.5);
}
//"right":5,"score":0,"scoringServer":"NY","username":"Rose Mustang","wrong":1
const s = serve({ port: 8080, hostname: '127.0.0.1' });
console.log("http://localhost:8080/");
for await (const req of s) {
  let users = [
    {"avatar":{"body":0,"color":1,"ears":2,"eyes":1,"mouth":2,"nose":4},"creationServer":"SFO","gameId":"00ba3368-2095-4b65-80c9-94c1b1ab9068","gameServer":"SFO","id":"SFO Apple Song","right":86,"score":2380,"scoringServer":"SFO","username":"Apple Song","wrong":5},
    {"avatar":{"body":0,"color":2,"ears":0,"eyes":0,"mouth":0,"nose":4},"creationServer":"SFO","gameId":"00ba3368-2095-4b65-80c9-94c1b1ab9068","gameServer":"SFO","id":"SFO Spring Singer","right":6,"score":100,"scoringServer":"SFO","username":"Spring Singer","wrong":0},
    {"avatar":{"body":0,"color":1,"ears":3,"eyes":0,"mouth":3,"nose":1},"creationServer":"SFO","gameId":"00ba3368-2095-4b65-80c9-94c1b1ab9068","gameServer":"SFO","id":"SFO Prairie Watcher","right":6,"score":100,"scoringServer":"SFO","username":"Prairie Watcher","wrong":0},
    {"avatar":{"body":1,"color":3,"ears":3,"eyes":0,"mouth":0,"nose":0},"creationServer":"SFO","gameId":"00ba3368-2095-4b65-80c9-94c1b1ab9068","gameServer":"SFO","id":"SFO Silk Player","right":11,"score":0,"scoringServer":"SFO","username":"Silk Player","wrong":31},
    {"avatar":{"body":2,"color":3,"ears":4,"eyes":0,"mouth":4,"nose":3},"creationServer":"SFO","gameId":"00ba3368-2095-4b65-80c9-94c1b1ab9068","gameServer":"SFO","id":"SFO Short Raccoon","right":5,"score":0,"scoringServer":"SFO","username":"Short Raccoon","wrong":1},
    {"avatar":{"body":2,"color":0,"ears":4,"eyes":2,"mouth":3,"nose":2},"creationServer":"LDN","gameId":"00ba3368-2095-4b65-80c9-94c1b1ab9068","gameServer":"LDN","id":"LDN Rune Fang","right":5,"score":0,"scoringServer":"UNKN","username":"Rune Fang","wrong":1},
    {"avatar":{"body":3,"color":1,"ears":0,"eyes":4,"mouth":2,"nose":3},"creationServer":"LDN","gameId":"00ba3368-2095-4b65-80c9-94c1b1ab9068","gameServer":"LDN","id":"LDN Blossom Guardian","right":5,"score":0,"scoringServer":"UNKN","username":"Blossom Guardian","wrong":1},
    {"avatar":{"body":4,"color":4,"ears":1,"eyes":3,"mouth":4,"nose":1},"creationServer":"LDN","gameId":"00ba3368-2095-4b65-80c9-94c1b1ab9068","gameServer":"LDN","id":"LDN Stream Buffalo","right":5,"score":0,"scoringServer":"LDN","username":"Stream Buffalo","wrong":1},
    {"avatar":{"body":4,"color":2,"ears":0,"eyes":4,"mouth":2,"nose":1},"creationServer":"NY","gameId":"00ba3368-2095-4b65-80c9-94c1b1ab9068","gameServer":"NY","id":"NY Rose Mustang","right":5,"score":0,"scoringServer":"NY","username":"Rose Mustang","wrong":1},
    {"avatar":{"body":1,"color":0,"ears":2,"eyes":2,"mouth":1,"nose":0},"creationServer":"SFO","gameId":"00ba3368-2095-4b65-80c9-94c1b1ab9068","gameServer":"SFO","id":"SFO Lead Chanter","right":1,"score":0,"scoringServer":"SFO","username":"Lead Chanter","wrong":0}
    ];
  let resp: Response = {};
  resp.headers = new Headers();
  resp.headers.set('content-type','application/json; charset=utf-8')
  resp.headers.set('status', '200')
  shuffle(users);
  //console.log(users)
  resp.body = new TextEncoder().encode(JSON.stringify(users));
  req.respond(resp);
}

