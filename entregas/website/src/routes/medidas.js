var express = require("express");
var router = express.Router();

var medidaController = require("../controllers/medidaController");

router.get("/ultimas/:idAquario", function (req, res) {
    medidaController.buscarUltimasMedidas(req, res);
});

router.get("/tempo-real", function (req, res) {
    medidaController.buscarDadosTempoReal(req, res);
})

router.get("/dadosfreezer", function (req, res) {
    medidaController.buscarFreezer(req, res);
})

router.get("/obterdados", function (req, res) {
    medidaController.buscarDados(req, res);
})

router.get("/obterdadoskpi1", function (req, res) {
    medidaController.buscarDadosKpi1(req, res);
})

router.get("/obterdadoskpi2", function (req, res) {
    medidaController.buscarDadosKpi2(req, res);
})

router.get("/obterdadoskpi3", function (req, res) {
    medidaController.buscarDadosKpi3(req, res);
})

module.exports = router;