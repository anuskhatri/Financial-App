const { default: ollama } = require("ollama");

const format1 = {
  type: "object",
  properties: {
    fund_age_yr: {
      type: "integer",
    },
    risk_level: {
      type: "integer",
    },
    returns_1yr: {
      type: "number",
    },
  },
  required: ["fund_age_yr", "risk_level", "returns_1yr"],
};

const mutualFundsGpt = async (userQuery) => {
  const data = [
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
      role: "system",
      content:
        "I'm looking to invest in mutual funds with a moderate risk level. I have a bank balance " +
        "of ₹20,000 and a pending loan of ₹5,000. What type of mutual fund should I consider for " +
        "a 5-year investment?",
    },
    {
      role: "system",
      content: '{"fund_age_yr": 5, "risk_level": 3, "returns_1yr": 8.0}',
    },
    {
      role: "system",
      content:
        "I want to retire early and I'm okay with taking higher risks. I have ₹1,000,000 saved " +
        "up, but I still owe ₹300,000 in loans. Which mutual fund should I choose for investing " +
        "over the next 15 years?",
    },
    {
      role: "system",
      content: '{"fund_age_yr": 10, "risk_level": 5, "returns_1yr": 10.0}',
    },
    {
      role: "system",
      content: "retirement",
    },
    {
      role: "system",
      content: '{"fund_age_yr": 10, "risk_level": 5, "returns_1yr": 10.0}',
    },
    {
      role: "system",
      content: "How to invest if I want to buy a car",
    },
    {
      role: "system",
      content: '{"fund_age_yr": 3, "risk_level": 2, "returns_1yr": 6.0}',
    },
    {
      role: "user",
      content: userQuery,
    },
  ];

  try {
    // Send the chat request to the Ollama API
    const response = await ollama.chat({
      model: "llama3.2",
      messages: data,
      format: format1,
    });

    // Log the full response
    console.log(response.message.content + "fdvdv");
    return response.message.content;
  } catch (error) {
    // Handle errors gracefully
    console.error(
      "Error occurred while communicating with Ollama:",
      error.message || error
    );
  }
};
console.console.log(response.message.contentS);

// Call the async function
