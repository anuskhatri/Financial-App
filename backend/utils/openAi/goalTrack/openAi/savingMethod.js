const { GoogleGenerativeAI } = require("@google/generative-ai");

const genAI = new GoogleGenerativeAI("AIzaSyB6Iu9CN6RWvFpOEBy_2tUj4kOpJdusA80");

async function getFinancialAdviceOnSavingGoal(prompt) {
  try {
    const model = await genAI.getGenerativeModel({ model: "gemini-1.5-flash" });
    const result = await model.generateContent(`I made a plan to achive my goal I want to achive in here is the data of it ${JSON.stringify(prompt)}, cuurency unit:- ruppes(INR) time_frame unit:- days, is theplan feasible and recommend how to improve the plan give a specific. Limit the response to a few sentences. `);
    
    // Access and clean the response text
    if (result?.response?.candidates && result.response.candidates.length > 0) {
      let responseText = result.response.candidates[0].content.parts[0].text;
      
      // Use regex to remove asterisks
      responseText = responseText.replace(/\*/g, "");
      
      return responseText;
    } else {
      throw new Error("No response candidates found.");
    }
  } catch (error) {
    console.error("Error generating content:", error);
    throw error;  // Re-throw error to handle it in the calling code
  }
}

module.exports = getFinancialAdviceOnSavingGoal 
