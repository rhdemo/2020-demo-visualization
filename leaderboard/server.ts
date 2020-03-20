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

function randomInt(range: number) {
  return Math.floor(Math.random() * range)
}

function getAvatar() {
  return {
    body: randomInt(5),
    color: randomInt(9),
    ears: randomInt(5),
    eyes: randomInt(5),
    mouth: randomInt(5),
    nose: randomInt(5)
  }
}
//"right":5,"score":0,"scoringServer":"NY","username":"Rose Mustang","wrong":1
const s = serve({ port: 8080, hostname: '127.0.0.1' });
console.log("http://localhost:8080/");
for await (const req of s) {
  let users = [
    {"avatar":getAvatar(),"creationServer":"SFO","gameId":"00ba3368-2095-4b65-80c9-94c1b1ab9068","gameServer":"SFO","id":"SFO Apple Song","right":86,"score":2380,"scoringServer":"SFO","username":"Apple Song","wrong":5},
    {"avatar":getAvatar(),"creationServer":"SFO","gameId":"00ba3368-2095-4b65-80c9-94c1b1ab9068","gameServer":"SFO","id":"SFO Spring Singer","right":6,"score":100,"scoringServer":"SFO","username":"Spring Singer","wrong":0},
    {"avatar":getAvatar(),"creationServer":"SFO","gameId":"00ba3368-2095-4b65-80c9-94c1b1ab9068","gameServer":"SFO","id":"SFO Prairie Watcher","right":6,"score":100,"scoringServer":"SFO","username":"Prairie Watcher","wrong":0},
    {"avatar":getAvatar(),"creationServer":"SFO","gameId":"00ba3368-2095-4b65-80c9-94c1b1ab9068","gameServer":"SFO","id":"SFO Silk Player","right":11,"score":0,"scoringServer":"SFO","username":"Silk Player","wrong":31},
    {"avatar":getAvatar(),"creationServer":"SFO","gameId":"00ba3368-2095-4b65-80c9-94c1b1ab9068","gameServer":"SFO","id":"SFO Short Raccoon","right":5,"score":0,"scoringServer":"SFO","username":"Short Raccoon","wrong":1},
    {"avatar":getAvatar(),"creationServer":"LDN","gameId":"00ba3368-2095-4b65-80c9-94c1b1ab9068","gameServer":"LDN","id":"LDN Rune Fang","right":5,"score":0,"scoringServer":"UNKN","username":"Rune Fang","wrong":1},
    {"avatar":getAvatar(),"creationServer":"LDN","gameId":"00ba3368-2095-4b65-80c9-94c1b1ab9068","gameServer":"LDN","id":"LDN Blossom Guardian","right":5,"score":0,"scoringServer":"UNKN","username":"Blossom Guardian","wrong":1},
    {"avatar":getAvatar(),"creationServer":"LDN","gameId":"00ba3368-2095-4b65-80c9-94c1b1ab9068","gameServer":"LDN","id":"LDN Stream Buffalo","right":5,"score":0,"scoringServer":"LDN","username":"Stream Buffalo","wrong":1},
    {"avatar":getAvatar(),"creationServer":"NY","gameId":"00ba3368-2095-4b65-80c9-94c1b1ab9068","gameServer":"NY","id":"NY Rose Mustang","right":5,"score":0,"scoringServer":"NY","username":"Rose Mustang","wrong":1},
    {"avatar":getAvatar(),"creationServer":"SFO","gameId":"00ba3368-2095-4b65-80c9-94c1b1ab9068","gameServer":"SFO","id":"SFO Lead Chanter","right":1,"score":0,"scoringServer":"SFO","username":"Lead Chanter","wrong":0}
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

