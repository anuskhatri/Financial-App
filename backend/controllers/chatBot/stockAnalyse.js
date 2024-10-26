const allStock = require("../../models/investement/stock/allstock");
const stockAnalysePrompt = require("../../models/investement/stock/stockAnalysePrompt");
const getUserid = require("../../models/user/getUserid");

const stockAnalyse = async (req, res) => {
    try {
        const { userauth } = req.headers;
        const { id } = getUserid(userauth); // Ensure getUserid returns an object with id
        const { stockId } = req.params;
        const response=await stockAnalysePrompt(id,stockId)
        // console.log(response)
        if (response==null) {
            res.status(404).send("Not found data");
        }
        res.send(response)
    } catch (error) {
        console.error(error);
        res.status(500).send("Try again later");
    }
};

module.exports = stockAnalyse;
