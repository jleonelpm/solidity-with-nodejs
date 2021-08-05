//Este script se empleará para realizar de manera manual la compilación
//de nuestro Smart Contract en Bytecode (Que será ejecutado por la EVM ) 
//y el ABI (Application Binary Interfacde). El ABI es un JSON que define la estructura de nuestro contrato

//Importamos las liberías que nos van a servir
const path = require("path"); //Rutas
const fs = require("fs"); //Ficheros en disco
const solc = require("solc"); //Compilador solídity
const chalk = require("chalk"); //Librería para cambiar el color en terminal

const contractPath = path.resolve(__dirname, "../contracts", "UsersContract.sol");
const source = fs.readFileSync(contractPath, "utf8");

//Retorna un objeto llamado contracts
const {interface, bytecode}  = solc.compile(source, 1).contracts[":UsersContract"];

console.log(chalk.green(bytecode));
console.log(chalk.cyan(interface));
