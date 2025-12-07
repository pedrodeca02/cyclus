const mysql = require('mysql2');

const HABILITAR_OPERACAO_INSERIR = true;

const pool = mysql.createPool({
    host: 'localhost',
    user: 'aluno',
    password: 'Sptech#2024',
    database: 'cyclus',
    port: 3307
}).promise();

async function inserirDadoMock() {
    try {
        if (!HABILITAR_OPERACAO_INSERIR) return;

        // gera valor aleatório (mock)
        const valor = (Math.random() * 10 + 1).toFixed(2);

        let alerta;
        if (valor >= 7 || valor <= 2){
            alerta = 1;
        } else {
            alerta = 0;
        }

        await pool.execute(
            `INSERT INTO registro (tempAtual, dataHoraRegistro, alerta, fkFreezer) VALUES (${valor}, NOW(), ${alerta}, 1)`
        );

        console.log("Valor inserido:", valor);

    } catch (erro) {
        console.error("Erro ao inserir no banco:", erro);
    }
}
setInterval(inserirDadoMock, 2000);
