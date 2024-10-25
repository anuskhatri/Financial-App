const { getUserMutualFunds } = require('../../models/investement/mutualFunds/getUserMutualF')
const allStock = require('../../models/investement/stock/allstock')
const getUserid = require('../../models/user/getUserid')
const { getFinancialAdvice } = require('../../utils/openAi/chatbot/chatBot')

const investementPrompt = async (req, res) => {
    try {
        const token = req.headers.userauth
        const { userInput } = req.params
        const decodeData = getUserid(token)

        const { investment_details } = await getUserMutualFunds(decodeData.id)
        const investment = investment_details.map((invested) => {
            invested.current_value = Number(invested.current_value)
            invested.total_invested_amount = Number(invested.total_invested_amount)
            invested.total_current_value = Number(invested.total_current_value)
            return invested
        })
        const stock=await allStock(decodeData.id)
        const botResponse = await getFinancialAdvice(userInput, `Here is my investement data ${JSON.stringify({...investment,...stock})}`)
        res.send(botResponse)
    } catch (error) {
        console.error('Error:', error)
        res.status(500).send({ error: error.message })
    }
}

module.exports = investementPrompt
