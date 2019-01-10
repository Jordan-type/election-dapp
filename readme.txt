https://www.youtube.com/watch?v=3681ZYbDSSk

D:\Workspace\election>truffle migrate
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


D:\Workspace\election>truffle console
truffle(development)> Election.deployed().then(function(instance) { app = instance })
undefined
truffle(development)> app.address
'0x1Bd992252497712195545A8Cf60C0D76e6Eeb2F6'
truffle(development)> app.candidate() // getter function
'Candidate 1'
truffle(development)>.exit