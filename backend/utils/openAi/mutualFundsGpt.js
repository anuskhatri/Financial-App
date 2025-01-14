const axios = require("axios");
const { GoogleGenerativeAI } = require("@google/generative-ai");

const genAI = new GoogleGenerativeAI("AIzaSyB6Iu9CN6RWvFpOEBy_2tUj4kOpJdusA80"); // Replace with your actual API key
const base_url = process.env.STOCK_APP_BASE_URL;
const systemMessage =
  'Your objective is to intelligently interpret natural language queries and make financial decisions based on the provided user input.You need to calculate the following variables based on the query: 1. `fund_age_yr` (the duration for mutual fund investment): Short Term [1-3 years], Mid Term [4-7 years], Long Term [8-10 years].2. `risk_level` (the risk level of the investment): Low Risk [1-2], Medium Risk [3-4], High Risk [5-6].3. `returns_1yr` (expected return percentage for one year), calculated based on fund age, risk level, and investment details.When the user asks about a financial decision, you must calculate and provide the following based on the query:- For long-term financial goals (e.g., retirement), assume a longer investment duration (8-10 years) with higher risk (5-6), and higher returns (9-12%).- For short-term goals (e.g., buying a car), assume a shorter investment duration (1-3 years) with moderate risk (2-4) and moderate returns (5-7%).- If the query is unclear, irrelevant, or does not provide sufficient information to make a decision, output all values as `0` in JSON format.Do not include any additional explanation or commentary. Your output should be strictly in JSON format:{\n  "fund_age_yr": <integer>,\n  "risk_level": <integer>,\n  "returns_1yr": <float>\n}Ensure your response is relevant and accurate to the user\'s query. If unsure about the details, you can infer the values based on general financial principles.';

console.log(systemMessage);

async function mutualFundsGpt(userQuery) {
  console.log("fesfffffffffffe");
  try {
    const messages = [
      {
        role: "system",
        content: systemMessage,
      },
      {Git add .

        role: "user",
        content: userQuery,
      },
    ];

    const mutualFundAiText = await axios.post(`${base_url}/mutual_fund_ai`, {
      query: messages,
    });
    console.log(mutualFundAiText.data);

    return mutualFundAiText.data;
  } catch (error) {
    console.error("Error generating content:", error);
    return null;
  }
}

module.exports = mutualFundsGpt;
