const express = require("express");
const app = express();
const cors = require("cors");
const mongoose = require("mongoose");
const Product = require("./model/product");
const nodemailer = require("nodemailer");
const fetch = require("node-fetch");

app.use(cors());

app.use(express.json());
///////////          for email
const transporter = nodemailer.createTransport({
  service: "gmail",
  auth: {
    user: "s12011015@stu.najah.edu", // Your Gmail account
    pass: "snrb bxxq soft kcyb", // Gmail app password
  },
});
app.post("/send-email", (req, res) => {
  const { to, subject, text } = req.body;

  const mailOptions = {
    from: "your-email@gmail.com",
    to,
    subject,
    text,
  };
  transporter.sendMail(mailOptions, (error, info) => {
    if (error) {
      return res.status(500).send(error.toString());
    }
    res.status(200).send("Email sent: " + info.response);
  });
});

///////////////////////
app.get("/", (req, res) => {
  res.send("hello abood love u");
});

///// for update the data base
app.put("/profile/:id", async (req, res) => {
  try {
    console.log("updtade");
    const { id } = req.params; // Extract the user ID or email from the URL parameters
    const updateData = req.body; // Extract the updated profile details from the request body

    // Use findOneAndUpdate to locate the user by email and update their profile
    const updatedProfile = await Product.findOneAndUpdate(
      { email: id }, // Match the user by email
      { $set: updateData }, // Update the provided fields
      { new: true } // Return the updated document
    );

    if (!updatedProfile) {
      return res.status(404).json({ message: "User not found" }); // Handle case if user is not found
    }

    res
      .status(200)
      .json({ message: "Profile updated successfully", data: updatedProfile });
  } catch (error) {
    res.status(500).json({ message: error.message }); // Return the error message
  }
});
////// delet item vedios
app.delete("/pro/delete/:userId/:videoId", async (req, res) => {
  const { userId, videoId } = req.params;

  try {
    const user = await Product.findOneAndUpdate(
      { email: userId },
      { $pull: { vedios: videoId } },
      { new: true }
    );

    if (user) {
      res.status(200).json({ message: "Video deleted successfully.", user });
    } else {
      res
        .status(404)
        .json({ message: "User not found or video not associated." });
    }
  } catch (error) {
    res.status(500).json({ message: "Server error.", error });
  }
});

////// sign up
app.post("/users", async (req, res) => {
  try {
    const product = await Product.create(req.body);
    // Product;

    res.status(200).json(product);
    console.log(error.massage);
  } catch (eroor) {}
});
///////////////////////////  chore api
const axios = require("axios");
const API_KEY = "Ygwlx1JIu2ps1ZVrdS5DbJ8nPCUwopyWDk0tmuWB"; // Replace with your actual Cohere API key
const endpoint = "https://api.cohere.ai/generate";

app.post("/chat", async (req, res) => {
  const { prompt } = req.body;

  const requestBody = {
    model: "command-light",
    prompt,
    max_tokens: 400,
  };

  try {
    const response = await axios.post(endpoint, requestBody, {
      headers: {
        Authorization: `Bearer ${API_KEY}`,
        "Content-Type": "application/json",
      },
    });
    res.json({ text: response.data.text });
  } catch (error) {
    res
      .status(error.response ? error.response.status : 500)
      .json({ error: error.message });
  }
});

// const requestBody = {
//   model: "command", // Correct model for text generation
//   prompt: "i am a abood  iam doctor I want stretching exercises. Give me some", // Example text prompt
//   max_tokens: 100, // Maximum number of tokens to generate
// };

// async function generateText() {
//   try {
//     const response = await axios.post(endpoint, requestBody, {
//       headers: {
//         Authorization: `Bearer ${API_KEY}`,
//         "Content-Type": "application/json",
//       },
//     });

//     // Print the generated text
//     console.log("Generated Text:", response.data.text);
//   } catch (error) {
//     // Log the error with detailed response
//     console.error(
//       "Error generating text:",
//       error.response ? error.response.data : error.message
//     );
//   }
// }

// // Call the function
// generateText();

/////////////////////
//////// for raed llama

app.get("/raed", async (req, res) => {
  console.log("raed");
  const headers = {
    Content_Type: "application/json",

    Authorization:
      "Bearer LA-f1cd4082b99d404d9e52b7626847be4e51b35fc03a91467f8c2614eda279a284",
    "Access-Control-Allow-Orgin": "*",
  };
  const response = await fetch("https://api.llama-api.com/chat/completions", {
    method: "POST",
    headers,
    body: JSON.stringify({
      messages: [{ role: "user", content: "is doctor read gay?" }],
    }),
  });
  const data = await response.json();
  //console.log(data);
  res.send(data);
});
////// for store add to my list vedios
app.post("/pro/:id/add-video", async (req, res) => {
  const userId = req.params.id; // User's email or ID
  const videoId = req.body.videoId; // Video's ID

  try {
    // Find the user by email (or change to another unique identifier)
    const user = await Product.findOne({ email: userId });
    if (!user) {
      return res.status(404).json({ message: "User not found!" });
    }

    // Add the video ID to the vedios array if not already present
    if (!user.vedios.includes(videoId)) {
      user.vedios.push(videoId);
      await user.save();
    }

    res
      .status(200)
      .json({ message: "Video added successfully!", vedios: user.vedios });
  } catch (err) {
    res
      .status(500)
      .json({ message: "Error updating vedios", error: err.message });
  }
});

/////////////////////

app.post("/pro", async (req, res) => {
  try {
    const product = await Product.create(req.body);
    // Product;

    res.status(200).json(product);
    console.log(error.massage);
  } catch (eroor) {}
  // console.log(req.body);
  // res.send(req.body);
});
app.put("/pro/:id", async (req, res) => {
  const { id } = req.params;
  const product = await Product.findByIdAndUpdate(id, req.body);
  if (!product) {
    res.status(500).json({ massage: "massage.eroor" });
  }
  res.status(500).json(product);
});
//// sign in page
app.get("/pro/:id", async (req, res) => {
  try {
    const { id } = req.params;
    const product = await Product.findOne({ email: id });

    res.status(200).json(product);
  } catch (eroor) {
    res.status(500).json({ massage: massage.eroor });
  }
  // console.log(req.body);
  // res.send(req.body);
});

mongoose
  .connect(
    "mongodb+srv://ezzmasre:ezzmasre10@cluster0.jyhqr.mongodb.net/ezz?retryWrites=true&w=majority&appName=Cluster0"
  )
  .then(() => {
    console.log("conected to mogo");
    app.listen(3000, () => {
      // console.log("fuker");
    });
  })
  .catch(() => {
    console.log("eroor");
  });
