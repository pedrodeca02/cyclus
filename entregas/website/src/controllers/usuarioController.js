var usuarioModel = require("../models/usuarioModel");
var aquarioModel = require("../models/aquarioModel");

function autenticar(req, res) {
    var email = req.body.emailServer;
    var senha = req.body.senhaServer;

    if (email == undefined) {
        res.status(400).send("Seu email está undefined!");
    } else if (senha == undefined) {
        res.status(400).send("Sua senha está indefinida!");
    } else {

        usuarioModel.autenticar(email, senha)
            .then(
                function (resultadoAutenticar) {
                    console.log(`\nResultados encontrados: ${resultadoAutenticar.length}`);
                    console.log(`Resultados: ${JSON.stringify(resultadoAutenticar)}`); // transforma JSON em String

                    if (resultadoAutenticar.length == 1) {
                        console.log(resultadoAutenticar);

                        aquarioModel.buscarAquariosPorEmpresa(resultadoAutenticar[0].empresaId)
                            .then((resultadoAquarios) => {
                                if (resultadoAquarios.length > 0) {
                                    res.json({
                                        id: resultadoAutenticar[0].id,
                                        email: resultadoAutenticar[0].email,
                                        nome: resultadoAutenticar[0].nome,
                                        senha: resultadoAutenticar[0].senha,
                                        aquarios: resultadoAquarios
                                    });
                                } else {
                                    res.status(204).json({ aquarios: [] });
                                }
                            })
                    } else if (resultadoAutenticar.length == 0) {
                        res.status(403).send("Email e/ou senha inválido(s)");
                    } else {
                        res.status(403).send("Mais de um usuário com o mesmo login e senha!");
                    }
                }
            ).catch(
                function (erro) {
                    console.log(erro);
                    console.log("\nHouve um erro ao realizar o login! Erro: ", erro.sqlMessage);
                    res.status(500).json(erro.sqlMessage);
                }
            );
    }

}

    function cadastrarEndereco(req, res) {
        const { cepServer, ruaServer, numeroServer, complementoServer } = req.body;

        usuarioModel.cadastrarEndereco(cepServer, ruaServer, numeroServer, complementoServer)
            .then(resultado => {
                console.log("resultado", resultado);
                res.json({ idEndereco: resultado.insertId })
            })
            .catch(erro => {
                console.log('erro', erro);
                res.status(500).json(erro.sqlMessage);
            });
    }

    function cadastrarEmpresa(req, res) {
        const { razaosocialServer, cnpjServer, idEndereco } = req.body;
        
        usuarioModel.cadastrarEmpresa(razaosocialServer, cnpjServer, idEndereco)
            .then(resultado => {
                res.json({ idEmpresa: resultado.insertId });
            })
            .catch(erro => {
                res.status(500).json(erro.sqlMessage);
            });
    }

    function cadastrarUsuario(req, res) {
        const { nomeServer, emailServer, senhaServer, idEmpresa } = req.body;

        usuarioModel.cadastrarUsuario(nomeServer, emailServer, senhaServer, idEmpresa)
            .then(resultado => {
                res.json({ idUsuario: resultado.insertId });
            })
            .catch(erro => {
                res.status(500).json(erro.sqlMessage);
            });
    }


module.exports = {
    autenticar,
    cadastrarEndereco,
    cadastrarEmpresa,
    cadastrarUsuario
}