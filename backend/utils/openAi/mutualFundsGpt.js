const { GoogleGenerativeAI } = require("@google/generative-ai");

const genAI = new GoogleGenerativeAI("AIzaSyCYKpOuJ49yeZy-RR5G1lxdow9Y3iSSp_s");  // Replace with your actual API key

async function mutualFundsGpt(userQuery) {
  try {
    // Retrieve the model object
    const model = await genAI.getGenerativeModel({ model: "gemini-1.5-flash" });

    // Define the structured prompt
    const prompt = `
Your objective is to convert natural language queries of users into three variables: fund_age_yr (Short Term [1-3 yrs], Mid Term [4-7 yrs], Long Term [8-10 yrs]), risk_level (Low Risk [1-2], Medium Risk [3-4], High Risk [5-6]), and returns_1yr (based on fund_age_yr, risk_level, user bank balance, and pending loan).

Respond strictly in JSON format. For example:
User query: "I want a 5-year moderate-risk mutual fund."
Response:
{
  "fund_age_yr": 5,
  "risk_level": 3,
  "returns_1yr": 8.0
}

If the query is irrelevant or lacks details, return all values as 0.

Query: "${userQuery}"
`;

    // Generate content with the prompt
    const result = await model.generateContent(prompt);

    if (result?.response?.candidates && result.response.candidates.length > 0) {
      const assistantResponse = result.response.candidates[0].content.parts[0].text;

      // Extract the JSON part from the response
      const jsonMatch = assistantResponse.match(/\{[\s\S]*\}/);
      if (!jsonMatch) {
        throw new Error("Failed to extract JSON from response.");
      }

      const jsonResponse = jsonMatch[0];

      let structuredResponse;
      try {
        structuredResponse = JSON.parse(jsonResponse);
        console.log("structuredResponse:", structuredResponse);
      } catch (error) {
        throw new Error("Failed to parse response as JSON.");
      }

      console.log({
        role: "assistant",
        content: structuredResponse
      });
      return structuredResponse;
    } else {
      throw new Error("No response candidates found.");
    }
  } catch (error) {
    console.error("Error generating content:", error);
    throw error; // Re-throw error for handling in calling code
  }
}

module.exports = mutualFundsGpt;
