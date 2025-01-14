const { pool } = require("../../../config/dbConfig");
const mutualFundsGpt = require("../../../utils/openAi/mutualFundsGpt");

function toTitleCase(str) {
  if (typeof str !== "string") {
    return str; // Return the input as is if not a string
  }
  return str
    .split("-")
    .map((word) => word.charAt(0).toUpperCase() + word.slice(1).toLowerCase())
    .join(" ");
}

const mutualFundsPrompt = async (req, res) => {
  try {
    const { userInput } = req.params;

    // Get AI-generated structured response
    const promptResult = await mutualFundsGpt(userInput);

    console.log("Prompt Result:", promptResult);

    // Ensure promptResult.message is parsed correctly from JSON string
    let queryData = null;
    try {
      if (promptResult && promptResult.message) {
        queryData = JSON.parse(promptResult.message);
      }
    } catch (error) {
      console.error("Error parsing JSON from promptResult:", error);
      return res.status(500).send({
        message:
          "Failed to parse the response from the AI tool. Please try again.",
      });
    }

    // Validate the parsed data
    if (
      !queryData ||
      queryData.fund_age_yr === undefined ||
      queryData.risk_level === undefined ||
      queryData.returns_1yr === undefined
    ) {
      return res.status(400).send({
        message:
          "Invalid or incomplete input. Please provide mutual fund details.",
      });
    }

    // Check if all values are 0 (for invalid input)
    if (
      queryData.fund_age_yr === 0 &&
      queryData.risk_level === 0 &&
      queryData.returns_1yr === 0
    ) {
      return res.status(400).send({
        message: "Please provide valid mutual fund details.",
      });
    }

    // Determine fund age category
    let fundAgeCategory;
    if (queryData.fund_age_yr > 6) {
      fundAgeCategory = "long-term";
    } else if (queryData.fund_age_yr >= 4 && queryData.fund_age_yr <= 6) {
      fundAgeCategory = "midterm";
    } else {
      fundAgeCategory = "short-term";
    }

    // Map risk level and returns to categories
    const params = {
      fund_age_yr: fundAgeCategory,
      risk_range:
        queryData.risk_level >= 1 && queryData.risk_level <= 2
          ? "Low"
          : queryData.risk_level >= 3 && queryData.risk_level <= 4
          ? "Medium"
          : "High",
      returns_1yr:
        queryData.returns_1yr >= 0 && queryData.returns_1yr <= 3
          ? "Low"
          : queryData.returns_1yr >= 4 && queryData.returns_1yr <= 6
          ? "Medium"
          : "High",
    };

    // Define tolerance ranges
    const riskTolerance = 1; // Adjust tolerance as needed
    const returnsTolerance = 1; // Adjust tolerance as needed

    // Log input data for debugging
    console.log("Database Query Parameters:", {
      fund_age_yr_start: queryData.fund_age_yr > 6 ? 7 : 0,
      fund_age_yr_end: queryData.fund_age_yr > 6 ? 10 : 6,
      risk_level_start: queryData.risk_level - riskTolerance,
      risk_level_end: queryData.risk_level + riskTolerance,
      returns_start: queryData.returns_1yr - returnsTolerance,
      returns_end: queryData.returns_1yr + returnsTolerance,
    });

    // Query the database
    const mutualData = await pool.query(
      `
        SELECT * FROM mutual_funds
        WHERE fund_age_yr::integer BETWEEN $1 AND $2
          AND risk_level::integer BETWEEN $3 AND $4
          AND returns_1yr::integer BETWEEN $5 AND $6;
      `,
      [
        queryData.fund_age_yr > 6 ? 7 : 0, // Start of long-term range
        queryData.fund_age_yr > 6 ? 10 : 6, // End of long-term range
        queryData.risk_level - riskTolerance, // Lower bound of risk level
        queryData.risk_level + riskTolerance, // Upper bound of risk level
        queryData.returns_1yr - returnsTolerance, // Lower bound of returns
        queryData.returns_1yr + returnsTolerance, // Upper bound of returns
      ]
    );

    // Return response
    return res.send({ ...params, mutualData: mutualData.rows });
  } catch (error) {
    console.error("Error:", error);
    return res.status(500).send({ message: "Internal server error." });
  }
};

module.exports = mutualFundsPrompt;
