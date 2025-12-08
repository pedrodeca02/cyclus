var database = require("../database/config");

function buscarUltimasMedidas(idAquario, limite_linhas) {
    var instrucaoSql = `SELECT 
        dht11_temperatura as temperatura, 
        dht11_umidade as umidade,
                        momento,
                        DATE_FORMAT(momento,'%H:%i:%s') as momento_grafico
                    FROM medida
                    WHERE fk_aquario = ${idAquario}
                    ORDER BY id DESC LIMIT ${limite_linhas}`;

    console.log("Executando a instrução SQL: \n" + instrucaoSql);
    return database.executar(instrucaoSql);
}

function buscarFreezer(limite) {
    var instrucaoSql = `SELECT freezer_tempAtual, freezer_dataHora, freezer_corredor,
                        freezer_id, freezer_tempMax, freezer_tempMin, freezer_alerta
                        FROM freezer_view WHERE freezer_id = 1
                        ORDER BY freezer_dataHora DESC LIMIT ${limite};`;
    console.log("Executando a instrução SQL: \n" + instrucaoSql);
    return database.executar(instrucaoSql);
}

function buscarDados(limite) {
    var instrucaoSql = `SELECT freezer_tempAtual, freezer_dataHora, freezer_corredor,
                        freezer_id, freezer_tempMax, freezer_tempMin, freezer_alerta
                        FROM grafico_view WHERE freezer_id = 1
                        ORDER BY freezer_dataHora DESC LIMIT ${limite};`;
    console.log("Executando a instrução SQL: \n" + instrucaoSql);
    return database.executar(instrucaoSql);
}

function buscarDadosKpi1() {
    var instrucaoSql = `SELECT r.fkFreezer AS id_freezer,
                                f.localizacao,
                                COUNT(*) AS total_alertas
                        FROM registro r
                        JOIN freezer f ON r.fkFreezer = f.idFreezer
                        WHERE r.alerta = 1
                        GROUP BY r.fkFreezer, f.localizacao
                        ORDER BY total_alertas DESC LIMIT 1;`;
    console.log("Executando a instrução SQL: \n" + instrucaoSql);
    return database.executar(instrucaoSql);
}

function buscarDadosKpi2() {
    var instrucaoSql = `SELECT YEAR(dataHoraRegistro) AS ano,
                        WEEK(dataHoraRegistro) AS semana_do_ano,
                        COUNT(CASE WHEN alerta = 1 THEN 1 END) AS total_alertas,
                        COUNT(*) AS total_registros,
                        CONCAT(
                            FORMAT(
                                (COUNT(CASE WHEN alerta = 1 THEN 1 END) / COUNT(*)) * 100, 2
                            ), '%'
                        ) AS percentual_alertas
                        FROM registro GROUP BY ano, semana_do_ano
                        ORDER BY ano DESC, semana_do_ano DESC;`;
    console.log("Executando a instrução SQL: \n" + instrucaoSql);
    return database.executar(instrucaoSql);
}

function buscarDadosKpi3() {
    var instrucaoSql = `SELECT COUNT(DISTINCT r.fkFreezer) AS total_freezers_com_alerta_ativo
                        FROM registro r
                        INNER JOIN (
                            SELECT fkFreezer, MAX(dataHoraRegistro) AS ultimo_registro
                            FROM registro GROUP BY fkFreezer
                        ) AS ultimos_registros
                        ON r.fkFreezer = ultimos_registros.fkFreezer AND r.dataHoraRegistro = ultimos_registros.ultimo_registro
                        WHERE r.alerta = 1;`;
    console.log("Executando a instrução SQL: \n" + instrucaoSql);
    return database.executar(instrucaoSql);
}

function buscarDadosTempoReal() {
    var instrucaoSql = `SELECT freezer_tempAtual, freezer_dataHora, freezer_corredor,
                        freezer_id, freezer_tempMax, freezer_tempMin, freezer_alerta
                        FROM grafico_view WHERE freezer_id = 1
                        ORDER BY freezer_dataHora DESC LIMIT 1;`;

    console.log("Executando a instrução SQL: \n" + instrucaoSql);
    return database.executar(instrucaoSql);
}

module.exports = {
    buscarUltimasMedidas,
    buscarDadosTempoReal,
    buscarFreezer,
    buscarDados,
    buscarDadosKpi1,
    buscarDadosKpi2,
    buscarDadosKpi3
}
