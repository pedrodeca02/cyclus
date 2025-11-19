var database = require("../database/config")

function autenticar(email, senha) {
    console.log("ACESSEI O USUARIO MODEL \n \n\t\t >> Se aqui der erro de 'Error: connect ECONNREFUSED',\n \t\t >> verifique suas credenciais de acesso ao banco\n \t\t >> e se o servidor de seu BD está rodando corretamente. \n\n function entrar(): ", email, senha)
    var instrucaoSql = `
        SELECT id, nome, email, fk_empresa as empresaId FROM usuario WHERE email = '${email}' AND senha = '${senha}';
    `;
    console.log("Executando a instrução SQL: \n" + instrucaoSql);
    return database.executar(instrucaoSql);
}

// Coloque os mesmos parâmetros aqui. Vá para a var instrucaoSql
// function cadastrar(nome, razaosocial, cnpj, email, telefone, cep, endereco, numero, complemento, senha) {
//     console.log("ACESSEI O USUARIO MODEL \n \n\t\t >> Se aqui der erro de 'Error: connect ECONNREFUSED',\n \t\t >> verifique suas credenciais de acesso ao banco\n \t\t >> e se o servidor de seu BD está rodando corretamente. \n\n function cadastrar():", nome, razaosocial, email, telefone, cep, endereco, numero, complemento, senha);
//     var instrucaoSql = `
//         INSERT INTO empresa (razao_social, cnpj) VALUES ('${razaosocial}', '${cnpj}');
//         INSERT INTO usuario (nome, email, senha) VALUES ('${nome}', '${email}', '${senha}');
//         INSERT INTO endereco (nome, email, senha) VALUES ('${nome}', '${email}', '${senha}');
//     `;
//     console.log("Executando a instrução SQL: \n" + instrucaoSql);
//     return database.executar(instrucaoSql);
// }

function cadastrarEndereco(cep, endereco, numero, complemento) {
    console.log("ACESSEI O USUARIO MODEL \n \n\t\t >> Se aqui der erro de 'Error: connect ECONNREFUSED',\n \t\t >> verifique suas credenciais de acesso ao banco\n \t\t >> e se o servidor de seu BD está rodando corretamente. \n\n function cadastrar():", nome, razaosocial, email, telefone, cep, endereco, numero, complemento, senha);
    var instrucaoSql = `
        INSERT INTO endereco (cep, endereco, numero, complemento) 
        VALUES ('${cep}', '${endereco}', '${numero}', '${complemento}');
    `;
    console.log("Executando a instrução SQL: \n" + instrucaoSql);
    return database.executar(instrucaoSql);
}

function cadastrarEmpresa(razaosocial, cnpj, fkEndereco) {
    console.log("ACESSEI O USUARIO MODEL \n \n\t\t >> Se aqui der erro de 'Error: connect ECONNREFUSED',\n \t\t >> verifique suas credenciais de acesso ao banco\n \t\t >> e se o servidor de seu BD está rodando corretamente. \n\n function cadastrar():", nome, razaosocial, email, telefone, cep, endereco, numero, complemento, senha);
    var instrucaoSql = `
        INSERT INTO empresa (razao_social, cnpj, fkEndereco) 
        VALUES ('${razaosocial}', '${cnpj}', '${fkEndereco}');
    `;
    console.log("Executando a instrução SQL: \n" + instrucaoSql);
    return database.executar(instrucaoSql);
}

function cadastrarUsuario(nome, cpf, email, senha, fkEmpresa) {
    console.log("ACESSEI O USUARIO MODEL \n \n\t\t >> Se aqui der erro de 'Error: connect ECONNREFUSED',\n \t\t >> verifique suas credenciais de acesso ao banco\n \t\t >> e se o servidor de seu BD está rodando corretamente. \n\n function cadastrar():", nome, razaosocial, email, telefone, cep, endereco, numero, complemento, senha);
    var instrucaoSql = `
        INSERT INTO usuario (nome, cpf, email, senha, fkEmpresa) 
        VALUES ('${nome}', '${cpf}', '${email}', '${senha}', '${fkEmpresa}');
    `;
    console.log("Executando a instrução SQL: \n" + instrucaoSql);
    return database.executar(instrucaoSql);
}

module.exports = {
    autenticar,
    // cadastrar,
    cadastrarEndereco,
    cadastrarEmpresa,
    cadastrarUsuario
};