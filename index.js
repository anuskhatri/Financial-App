const { GoogleGenerativeAI } = require("@google/generative-ai");

const genAI = new GoogleGenerativeAI("AIzaSyCYKpOuJ49yeZy-RR5G1lxdow9Y3iSSp_s");  // Replace with your actual API key

const getFinancialAdvice = async (prompt, data) => {
  try {
    // Retrieve the model object
    const model = await genAI.getGenerativeModel({ model: "gemini-1.5-flash" });

    // Generate content with the provided prompt
    const result = await model.generateContent(`Provide financial advice for: ${prompt}. Additional data: ${JSON.stringify(data)}. The currency unit is INR (Indian Rupees), and please include a reasoned explanation.`);

    // Check for response candidates and clean the response text
    if (result?.response?.candidates && result.response.candidates.length > 0) {
      let responseText = result.response.candidates[0].content.parts[0].text;

      // Remove asterisks if present
      responseText = responseText.replace(/\*/g, "");
      console.log(responseText);
      
      return responseText;
    } else {
      throw new Error("No response candidates found.");
    }
  } catch (error) {
    console.error("Error generating content:", error);
    throw error;  // Re-throw error for handling in calling code
  }
};
getFinancialAdvice("hey","")
// Export the function for use in other modules
module.exports = getFinancialAdvice 
