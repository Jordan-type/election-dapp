# Scribble Notes

## Building a Solidity dapp

Tutorial video: https://www.youtube.com/watch?v=3681ZYbDSSk

**Install dependencies**

> $ npm install -g truffle
> 
> $ mkdir election
> 
> $ cd election
> 
> $ truffle unbox pet-shop
> 
> $ npm install

#### 1. Smoke Test (https://github.com/aimanbaharum/election-dapp/commit/927773041c50ce81da9828d97e0bf8281c7f707c)

As of ^0.5.0, constructor is named `constructor()` instead of `function ClassName()`.

D:\Workspace\election>truffle migrate

```
   Compiling .\contracts\Election.sol...
   Compiling .\contracts\Migrations.sol...
   Writing artifacts to .\build\contracts

   ⚠️  Important ⚠️
   If you're using an HDWalletProvider, it must be Web3 1.0 enabled or your migration will hang.


   Starting migrations...
   ======================
   > Network name:    'development'
   > Network id:      5777
   > Block gas limit: 6721975



   1_initial_migration.js
   ======================

      Deploying 'Migrations'
      ----------------------
      > transaction hash:    0x64ba7ffa1f4bf1ab6a08037af2169c5fb8380eb3dceeed47edc9441842a8869d
      > Blocks: 0            Seconds: 0
      > contract address:    0x53e8bEc13708B88DF984B04895422f0a88939CCf
      > account:             0x26a2C6638097813b2368C06E69cd6ab72A25a596
      > balance:             99.99430184
      > gas used:            284908
      > gas price:           20 gwei
      > value sent:          0 ETH
      > total cost:          0.00569816 ETH


      > Saving migration to chain.
      > Saving artifacts
      -------------------------------------
      > Total cost:          0.00569816 ETH


   2_deploy_contracts.js
   =====================

      Deploying 'Election'
      --------------------
      > transaction hash:    0x02bb7a9f47d376da933351dca4dea1dc7ffa6397c01a3525d4bee32401bd13da
      > Blocks: 0            Seconds: 0
      > contract address:    0x1Bd992252497712195545A8Cf60C0D76e6Eeb2F6
      > account:             0x26a2C6638097813b2368C06E69cd6ab72A25a596
      > balance:             99.98949376
      > gas used:            198370
      > gas price:           20 gwei
      > value sent:          0 ETH
      > total cost:          0.0039674 ETH


      > Saving migration to chain.
      > Saving artifacts
      -------------------------------------
      > Total cost:           0.0039674 ETH


   Summary
   =======
   > Total deployments:   2
   > Final cost:          0.00966556 ETH
```


D:\Workspace\election>truffle console

```
   truffle(development)> Election.deployed().then(function(instance) { app = instance })
   undefined
   truffle(development)> app.address
   '0x1Bd992252497712195545A8Cf60C0D76e6Eeb2F6'
   truffle(development)> app.candidate() // getter function
   'Candidate 1'
   truffle(development)>.exit
```

#### 2. List Candidates (https://github.com/aimanbaharum/election-dapp/commit/08cbae682d168096e9df1e0eff2889bc5329e0c6)

**Storage vs Memory vs Stack**

> **Storage:** The persistent memory that every account has is called storage. Storage is a key-value store where keys and values are both 32 bytes.
> 
> **Memory:** Memory is a byte-array, which hold the data in it until the execution of the function. Memory starts with zero-size and can be expanded in 32-byte chunks by simply accessing or storing memory at indices greater than its current size. 
To save gas, it is always recommended to shrink it’s size whenever possible.
>
> **Stack:** It is used to hold small local variables. It costs same as memory, but can only hold a limited amount of values.

Further readings:

- https://medium.com/coinmonks/what-the-hack-is-memory-and-storage-in-solidity-6b9e62577305
- https://ethereum.stackexchange.com/questions/1701/what-does-the-keyword-memory-do-exactly

**Migration reset**

Since we are still modifying the same Contract, just reset the migration. NOTE: only on development mode

D:\Workspace\election>truffle migrate --reset

```
   Compiling .\contracts\Election.sol...
   Writing artifacts to .\build\contracts

   ⚠️  Important ⚠️
   If you're using an HDWalletProvider, it must be Web3 1.0 enabled or your migration will hang.


   Starting migrations...
   ======================
   > Network name:    'development'
   > Network id:      5777
   > Block gas limit: 6721975


   1_initial_migration.js
   ======================

      Replacing 'Migrations'
      ----------------------
      > transaction hash:    0x0d8a205e8b3b813570f14ea140e35e5aeb80165659374d84199d49636478de0a
      > Blocks: 0            Seconds: 0
      > contract address:    0xc679e55Ed170F822c5a663A85Ce1911d4d1248bD
      > account:             0x26a2C6638097813b2368C06E69cd6ab72A25a596
      > balance:             99.98325492
      > gas used:            284908
      > gas price:           20 gwei
      > value sent:          0 ETH
      > total cost:          0.00569816 ETH


      > Saving migration to chain.
      > Saving artifacts
      -------------------------------------
      > Total cost:          0.00569816 ETH


   2_deploy_contracts.js
   =====================

      Replacing 'Election'
      --------------------
      > transaction hash:    0x576457e39a333e5c8077563e9ea1277174296e66ca8ef6c2bd5e67a7f9b98b83
      > Blocks: 0            Seconds: 0
      > contract address:    0x44Fe6F1e57E9D2d4703DE3c16097Df27484DCe3A
      > account:             0x26a2C6638097813b2368C06E69cd6ab72A25a596
      > balance:             99.97549486
      > gas used:            345969
      > gas price:           20 gwei
      > value sent:          0 ETH
      > total cost:          0.00691938 ETH


      > Saving migration to chain.
      > Saving artifacts
      -------------------------------------
      > Total cost:          0.00691938 ETH


   Summary
   =======
   > Total deployments:   2
   > Final cost:          0.01261754 ETH
```

**Inspecting object**

D:\Workspace\election>truffle console

```
   truffle(development)> Election.deployed().then(function(i) { app = i; }) // assign a promise to Election
   undefined
   truffle(development)> app.candidates(1)
   Result {
   '0': <BN: 1>,
   '1': 'Candidate 1',
   '2': <BN: 0>,
   id: <BN: 1>,
   name: 'Candidate 1',
   voteCount: <BN: 0> }
   truffle(development)> app.candidates(2)
   Result {
   '0': <BN: 2>,
   '1': 'Candidate 2',
   '2': <BN: 0>,
   id: <BN: 2>,
   name: 'Candidate 2',
   voteCount: <BN: 0> }
   truffle(development)> app.candidates(99) // not existing
   Result {
   '0': <BN: 0>,
   '1': '',
   '2': <BN: 0>,
   id: <BN: 0>,
   name: '',
   voteCount: <BN: 0> }
   truffle(development)> app.candidatesCount()
   <BN: 2>
   truffle(development)> app.candidates(1).then(function(c) { candidate = c; }) // assign a promise to Candidates Object 1
   undefined
   truffle(development)> candidate
   Result {
   '0': <BN: 1>,
   '1': 'Candidate 1',
   '2': <BN: 0>,
   id: <BN: 1>,
   name: 'Candidate 1',
   voteCount: <BN: 0> }
   truffle(development)> candidate.id // access the id
   <BN: 1>
   truffle(development)> candidate.name // access the name
   'Candidate 1'
   truffle(development)> candidate[0] // access the id (the array way)
   <BN: 1>
   truffle(development)> web3 // client-side connection library

   ...

   truffle(development)> web3.eth

   ...

   truffle(development)> web3.eth.getAccounts() // asynchronous call

   [ '0x26a2C6638097813b2368C06E69cd6ab72A25a596',
   '0xd941c4Fd3d4e73D380A9F014A23B785ad6706F4C',
   '0xA31382225d632deC178b39a608C12046B145C406',
   '0xe2072A132A25a9F43AAD6854c44F7111CC6EAe0c',
   '0x88932d3B2ebAed62d2f3847Db119Db98Ff6b1D1B',
   '0xdB8Af57C86B742810922F518580D55c1a855D6de',
   '0x59aD6B82A5A102193596F3b3832cbB78107Ee78f',
   '0xACcec393A7B4a9D68802c3cA634a784E5A712765',
   '0x1c656aABe88f65b337cc6361B405cF1894649088',
   '0x05dE2CEa7A11EeF4a995daB54489adB63b8ef073' ]

   truffle(development)> web3.eth.accounts[0] // won't work with > 0.4.1

   ... showing first account

```

**Running test**

D:\Workspace\election>truffle test

```
   Using network 'development'.



   Contract: Election
      √ initializes with two candidates
      √ it initilalizes the candidates with the correct values (78ms)


   2 passing (137ms)
```

**Running app in browser**

At this point, connect to MetaMask with test account (Ganache) in order to see the listing related to the eth account we played around earlier.

D:\Workspace\election>truffle migrate --reset

...

D:\Workspace\election>npm run dev

```
   > pet-shop@1.0.0 dev D:\Workspace\election
   > lite-server

   ** browser-sync config **
   { injectChanges: false,
   files: [ './**/*.{html,htm,css,js}' ],
   watchOptions: { ignored: 'node_modules' },
   server:
      { baseDir: [ './src', './build/contracts' ],
      middleware: [ [Function], [Function] ] } }
   [Browsersync] Access URLs:
   ------------------------------------
         Local: http://localhost:3000
      External: http://192.168.1.3:3000
   ------------------------------------
            UI: http://localhost:3001
   UI External: http://localhost:3001
   ------------------------------------
   [Browsersync] Serving files from: ./src
   [Browsersync] Serving files from: ./build/contracts
   [Browsersync] Watching files...
```

#### 3. Cast Votes (https://github.com/aimanbaharum/election-dapp/commit/98a08436bff5448c62807b9bba32b6fa3cf1fa98)

_**FIXME:** `web3.eth.accounts` is deprecated. Use `web3.eth.getAccounts()` for asynchronous purpose. getAccounts() returns an array of addresses. Cannot seem to get single account to test `vote()` function._ See https://ethereum.stackexchange.com/questions/65342/fetching-single-account-from-web3-eth


D:\Workspace\election>truffle migrate --reset

...

D:\Workspace\election>truffle console

```
   truffle(development)> Election.deployed().then(function(i) { app = i; })
   undefined
   truffle(development)> app.vote(1, { from: web3.eth.accounts[0] }) // metadata 'from' telling web3 to cast a vote using the first account 0
```

**Test vote() function**

D:\Workspace\election>truffle test

```
   Using network 'development'.

   Contract: Election
    √ initializes with two candidates (55ms)
    √ it initilalizes the candidates with the correct values (112ms)
    √ allows a voter to cast a vote (237ms)
    √ throws an exception for invalid candidates (289ms)
    √ throws an exception for double voting (366ms)


  5 passing (1s)
```

**Running in web browser**

D:\Workspace\election>truffle migrate --reset

...

D:\Workspace\election>npm run dev

...

Note:  
A logged in address can only vote once as according to our contract. Voting form will disappear after voting. Log in to another Ganache account to vote with another address.

#### 4. Watch Events (https://github.com/aimanbaharum/election-dapp/commit/0541ad4eb99a377cabf20db6853e785b7bf634e4)

**Test**

D:\Workspace\election>truffle test

```
   Using network 'development'.

   Compiling .\contracts\Election.sol...

   /D/Workspace/election/contracts/Election.sol:51:9: TypeError: Event invocations have to be prefixed by "emit".
         votedEvent(_candidateId);
         ^----------------------^
   Compilation failed. See above.
```

> In a recent release (v0.4.21 at 8th March 2018), `emit` keyword has been introduced to emit the event. This will help to differentiate the functions from event which was one of the reason of TheDAO Hack which led to hard fork in Ethereum & gave birth to Ethereum Classic.
> 
> General: Support and recommend using `emit EventName();` to call events explicitly.
> 
> In order to make events stand out with regards to regular function calls, `emit EventName()` as opposed to just `EventName()` should now be used to "call" events.

Readings: https://medium.com/@aniketengg/emit-keyword-in-solidity-242a679b0e1a

D:\Workspace\election>truffle test

```
Using network 'development'.

Compiling .\contracts\Election.sol...


  Contract: Election
    √ initializes with two candidates (43ms)
    √ it initilalizes the candidates with the correct values (350ms)
    √ allows a voter to cast a vote (203ms)
    √ throws an exception for invalid candidates (320ms)
    √ throws an exception for double voting (405ms)


  5 passing (1s)
```

**Running in web browser**

D:\Workspace\election>npm run dev

Event will be triggered and UI will refresh itself once a vote is casted (new tx found in the blockchain)

Console output:

```
event triggered {…}​address: "0x997fcc0116785465918e42c75674ed534c187686"​args: Object { _candidateId: {…} }​blockHash: "0x1053ac906a63fc725ee3cb9992c39f969e7fe1952d2f19078b231a611794e3be"​blockNumber: 61​event: "votedEvent"​logIndex: 0​transactionHash: "0x366b374313cf2c11d3884cf8c243927ea3e1f6655f9458d5f4165b84f688a44a"​transactionIndex: 0​type: "mined"​<prototype>: Object { … } app.js:48:9
```

## Running an IPFS

Tutorial video: https://www.youtube.com/watch?v=ADoRVVOSpI8

**Install dependencies**

Windows: https://dist.ipfs.io/#go-ipfs

Objective: to move away from centralized front-end hosting

1. Initialize a node

> ipfs init

2. Run the node. Keep it running
   
> ipfs daemon

```bash
Initializing daemon...
go-ipfs version: 0.4.18-
Repo version: 7
System version: amd64/windows
Golang version: go1.11.1
Swarm listening on /ip4/127.0.0.1/tcp/4001
Swarm listening on /ip4/169.254.114.118/tcp/4001
Swarm listening on /ip4/169.254.55.93/tcp/4001
Swarm listening on /ip4/192.168.1.10/tcp/4001
Swarm listening on /ip4/192.168.1.5/tcp/4001
Swarm listening on /ip6/::1/tcp/4001
Swarm listening on /p2p-circuit
Swarm announcing /ip4/127.0.0.1/tcp/4001
Swarm announcing /ip4/169.254.114.118/tcp/4001
Swarm announcing /ip4/169.254.55.93/tcp/4001
Swarm announcing /ip4/192.168.1.10/tcp/4001
Swarm announcing /ip4/192.168.1.5/tcp/4001
Swarm announcing /ip6/::1/tcp/4001
API server listening on /ip4/127.0.0.1/tcp/5001
Gateway (readonly) server listening on /ip4/127.0.0.1/tcp/8080
Daemon is ready
```

3. Understanding Solidity dapp structure

`/src` - is where our client side front-end stored. need this to be served in our ipfs node.
`/build/contracts` - contract abstractions. need this for serving front-end client distributed data

1. Create directory for ipfs serving

> mkdir dist

5. Sync files with dist/

Using bash on Windows,

> rsync -r src/ dist/
> 
> rsync -r build/contracts/ dist/

6. Gather peers to share the content

> ipfs swarm peers

7. Add dist/ to ipfs node

> ipfs add -r dist/

```bash
 111.96 KiB / ? added QmSaYyDbjAvzzwQwAUy1zXAHvByjDJAH4teohoCHTkabdz dist/Election.json
 163.72 KiB / 1.42 MiB 11.25% added Qmc4ys53sPgXRKk3WeiqwqDpnzc7DwDQckQ8mkNBHCaNeo dist/Migrations.json
 282.08 KiB / 1.42 MiB 19.39% added QmYUaCPwvJWiueRXFSTTv8vdedWWzRhRdn8RMw35e7k67u dist/css/bootstrap.min.css
 811.56 KiB / 1.42 MiB 55.77% added QmbrzMumAwEPCoLs6jBdDyHz2TBjpkSFhcCHMT7fBsdFyr dist/css/bootstrap.min.css.map
 831.22 KiB / 1.42 MiB 57.12% added QmWhoNhVUb9bcjuKLB259VYogJpPsJaAe8dern9LK95tVN dist/fonts/glyphicons-halflings-regular.eot
 937.41 KiB / 1.42 MiB 64.42% added QmbcbjLEC1aHy4j2qvtncevjenYwHjEF4qZ2kK5pRJzDLg dist/fonts/glyphicons-halflings-regular.svg
 981.75 KiB / 1.42 MiB 67.47% added QmciDEkreBpY2S6Ktg1Zarbsx5K2DmHK59H261Bjr2fnuR dist/fonts/glyphicons-halflings-regular.ttf
 1004.62 KiB / 1.42 MiB 69.04% added QmaYEdLkMnEHVN8HZB2GGETottySZoHh3TnYZERke36PVr dist/fonts/glyphicons-halflings-regular.woff
 1022.23 KiB / 1.42 MiB 70.25% added QmUbUsBQbjJhm5iYba5jqibRr4A6gG3HVczSy5gs5PrMhY dist/fonts/glyphicons-halflings-regular.woff2
 1.00 MiB / 1.42 MiB 70.42% added QmbSX6YDWdSihZUUDLJdd4dR22VxD4BYE7tY5cCFSt9NyC dist/index.html
 1.00 MiB / 1.42 MiB 70.68% added Qmd8tPiA6uqvh49bF6SBvG83dSsufswTLJWeZhcdn9vxo5 dist/js/app.js
 1.04 MiB / 1.42 MiB 73.16% added QmNXRFREw7waGtKW9uBUze3PkR9E12HeeAQSkZQSiFUJqo dist/js/bootstrap.min.js
 1.29 MiB / 1.42 MiB 90.53% added QmZQp29tbdppjqyixxM8L8NjsG4paN4eVW9GxZYicXov9v dist/js/truffle-contract.js
 1.42 MiB / 1.42 MiB 100.00% added QmdTtsVM7KtvycQ68f9M43N4EQKvbd58q8aeAhP2fMz4Di dist/js/web3.min.js
 1.42 MiB / 1.42 MiB 100.00% added QmQfwrATTrJc1aTN1dVu9K7nQ5rw67np8yg46EvAbqKEZw dist/css
 1.42 MiB / 1.42 MiB 100.00% added QmUNLLsPACCz1vLxQVkXqqLX5R1X345qqfHbsf67hvA3Nn dist/dist
 1.42 MiB / 1.42 MiB 100.00% added Qmb3fJpXVGvUnNeRLC3P5sTXMzjpf5zq4tKt9XjhtYFf1k dist/fonts
 1.42 MiB / 1.42 MiB 100.00% added QmUNLLsPACCz1vLxQVkXqqLX5R1X345qqfHbsf67hvA3Nn dist/images
 1.42 MiB / 1.42 MiB 100.00% added QmbFdwzJsGexRoDg2y76iqUGtm9UqosDUMhbuFHAVdREvB dist/js
 1.42 MiB / 1.42 MiB 100.00% added QmPi18aR7qrH9mEcAfHVS81LzrWFHbf1fFJexNPwYYgBbk dist
 1.42 MiB / 1.42 MiB 100.00%
 ```

8. Get the hash of dist/ directory

The last hash of `add` command above.

> 1.42 MiB / 1.42 MiB 100.00% added QmPi18aR7qrH9mEcAfHVS81LzrWFHbf1fFJexNPwYYgBbk dist

Hash: `QmPi18aR7qrH9mEcAfHVS81LzrWFHbf1fFJexNPwYYgBbk`

9. Publish the hash to ipfs

This hash of dist/ is like a root folder for our website

> ipfs name publish QmPi18aR7qrH9mEcAfHVS81LzrWFHbf1fFJexNPwYYgBbk
> 
> Published to QmV2uBS8UbRhZg44gqDuqduuPS2zRVDvsvirjrrw8kcnSy: /ipfs/QmPi18aR7qrH9mEcAfHVS81LzrWFHbf1fFJexNPwYYgBbk

10. Access through a web browser

- Go to https://gateway.ipfs.io
- Get the hash: QmPi18aR7qrH9mEcAfHVS81LzrWFHbf1fFJexNPwYYgBbk
- Paste in the URL with `/ipfs/` prepended

> https://gateway.ipfs.io/ipfs/QmPi18aR7qrH9mEcAfHVS81LzrWFHbf1fFJexNPwYYgBbk

11. Done

Fully decentralized application -- backend with ethereum blockchain, frontend with ipfs