const { pool } = require("../../../config/dbConfig");
const mutualFundsGpt = require("../../../utils/openAi/mutualFundsGpt");

function toTitleCase(str) {
  if (typeof str !== 'string') {
    return str; // Return the input as is if not a string
  }
  return str.split('-').map(word => word.charAt(0).toUpperCase() + word.slice(1).toLowerCase()).join(' ');
}

const mutualFundsPrompt = async (req, res) => {
  try {
    const { userInput } = req.params;
    const promptResult = await mutualFundsGpt(userInput);

    // Directly use promptResult since it returns the structured response
    const queryData = promptResult;

    // Check if any value is 0 and return a specific message
    if (!queryData || queryData.fund_age_yr === 0 && queryData.risk_level === 0 && queryData.returns_1yr === 0) {
      return res.send({ message: "I am an AI tool for mutual funds, please prompt specific to mutual funds" });
    }

    // Convert fund_age_yr to a string based on conditions
    let fundAgeCategory;
    if (queryData.fund_age_yr > 6) {
      fundAgeCategory = "long-term";
    } else if (queryData.fund_age_yr >= 4 && queryData.fund_age_yr <= 6) {
      fundAgeCategory = "midterm";
    } else {
      fundAgeCategory = "short-term";
    }

    // Assign the category to params
    const params = { fund_age_yr: fundAgeCategory };

    // Determine risk range
    if (queryData.risk_level >= 1 && queryData.risk_level <= 2) {
      params.risk_range = "Low";
    } else if (queryData.risk_level >= 3 && queryData.risk_level <= 4) {
      params.risk_range = "Medium";
    } else {
      params.risk_range = "High";
    }

    // Determine returns range
    if (queryData.returns_1yr >= 0 && queryData.returns_1yr <= 3) {
      params.returns_1yr = "Low";
    } else if (queryData.returns_1yr >= 4 && queryData.returns_1yr <= 6) {
      params.returns_1yr = "Medium";
    } else {
      params.returns_1yr = "High";
    }

    // Define tolerance ranges
    const riskTolerance = 1; // Adjust tolerance as needed
    const returnsTolerance = 1; // Adjust tolerance as needed

    // Query the database
    const mutualData = await pool.query(
      `SELECT * FROM mutual_funds 
       WHERE fund_age_yr BETWEEN $1 AND $2 
       AND risk_level BETWEEN $3 AND $4 
       AND returns_1yr BETWEEN $5 AND $6`,
      [
        // Use the appropriate numeric ranges for the database query
        queryData.fund_age_yr > 6 ? 7 : 0, // Adjust start of long-term range
        queryData.fund_age_yr > 6 ? 10 : 6, // Adjust end of long-term range
        queryData.risk_level - riskTolerance,
        queryData.risk_level + riskTolerance,
        queryData.returns_1yr - returnsTolerance,
        queryData.returns_1yr + returnsTolerance
      ]
    );

    return res.send({ ...params, mutualData: mutualData.rows });
  } catch (error) {
    console.error("Error:", error);
    res.sendStatus(500);
  }
};

module.exports = mutualFundsPrompt;
