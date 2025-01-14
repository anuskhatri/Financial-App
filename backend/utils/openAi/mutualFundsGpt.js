const axios = require("axios");
const { GoogleGenerativeAI } = require("@google/generative-ai");

const genAI = new GoogleGenerativeAI("AIzaSyB6Iu9CN6RWvFpOEBy_2tUj4kOpJdusA80"); // Replace with your actual API key
const base_url = process.env.STOCK_APP_BASE_URL;

async function mutualFundsGpt(userQuery) {
  console.log("fesfffffffffffe");
  try {
    const messages = [
      {
        role: "system",
        content:
          "Your objective is to intelligently convert natural language queries of users into the " +
          "three variables: fund_age_yr (duration of mutual funds: Short Term [1-3 yrs], Mid Term " +
          "[4-7 yrs], Long Term [8-10 yrs]), risk_level (Low Risk [1-2], Medium Risk [3-4], High " +
          "Risk [5-6]), and returns_1yr (calculated based on fund_age_yr, risk_level, user bank " +
          "balance, and pending loan).\n\nOutput the following JSON format strictly based on " +
          'relevant queries:\n{\n  "fund_age_yr": <integer>,\n  "risk_level": <integer>,\n  ' +
          '"returns_1yr": <float>\n}\n\nFor any irrelevant queries, or when unable to determine ' +
          "relevant values, or when the user query is unclear, or there is insufficient data to " +
          "answer or any random words like hey, hi etc., output all values as 0. If any response " +
          "contains values other than JSON, it will result in user disappointment. Ensure " +
          "responses are accurate and relevant.",
      },

      {
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
