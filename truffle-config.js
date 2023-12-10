module.exports = {
  networks: {
    development: {
      host: "127.0.0.1", // Adresse IP de Ganache
      port: 7545, // Port de Ganache (par défaut 7545, mais peut être différent selon votre configuration)
      network_id: "5777", // Match n'importe quel ID de réseau
    },
  },
  compilers: {
    solc: {
      version: "0.5.16", // Version du compilateur Solidity à utiliser
    },
  },
};