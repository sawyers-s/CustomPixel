String[] lines; // Array to hold lines of text
String fileName = "textfile.txt"; // Name of the text file
PImage img; // Image to get colors from
int margin = 0; // Margin around the text
int x = margin; // X position for drawing text
int y = margin; // Y position for drawing text
int maxWidth; // Maximum width for text wrapping
int lineHeight; // Height of each line of text
float[] fontSizes = {50, 40, 30, 20, 10, 5, 3, 1.7}; // List of font sizes in descending order
int[] frameRates = {1, 2, 4, 8, 16, 32}; // Frame rates for different font sizes
int currentFontSizeIndex = 0; // Index to track the current font size
int frameDelay; // Number of frames to pause before updating to the next font size
int frameCounter = 0; // Counter to track frame updates

void setup() {
  size(1050, 700); // Set canvas size
  noStroke(); // Remove stroke from text
  setFrameRateForCurrentSize(); // Set initial frame rate

  // Load the image
  img = loadImage("metgala.jpg");
  img.resize(width, height); // Resize image to match canvas size

  // Load text from the file
  lines = loadStrings(fileName);

  // Check if the file loaded correctly
  if (lines == null || lines.length == 0) {
    println("Error: Failed to load text from file or file is empty");
    noLoop(); // Stop draw loop if no text is loaded
    return;
  }
}

void draw() {
  // Clear the canvas
  background(255);

  // Set the current text size
  float textSizeValue = fontSizes[currentFontSizeIndex];
  textSize(textSizeValue);
  lineHeight = (int) textAscent() + (int) textDescent(); // Update lineHeight with new text size

  // Draw text with the current font size
  drawRepeatedText();

  // Update font size index and frame counter
  frameCounter++;
  if (frameCounter >= frameDelay) {
    currentFontSizeIndex++;
    if (currentFontSizeIndex >= fontSizes.length) {
      currentFontSizeIndex = 0; // Reset index to loop through font sizes again
    }
    setFrameRateForCurrentSize(); // Update frame rate for the new font size
    frameCounter = 0; // Reset frame counter
  }
}

void drawRepeatedText() {
  int startY = margin; // Store the starting y position
  int lineCount = 0;
  x = margin; // Reset x position
  y = startY; // Reset y position

  while (y < height) {
    StringBuilder currentText = new StringBuilder();
    x = margin;
    y = startY + lineCount * lineHeight; // Start new line for each headline

    // Concatenate headlines starting from lineCount
    for (int i = 0; i < lines.length; i++) {
      String word = lines[(lineCount + i) % lines.length];
      currentText.append(word).append(" ");
    }

    String[] words = split(currentText.toString(), ' ');
    float currentX = x;

    for (String word : words) {
      // Calculate the color of the text based on its position
      int imgX = (int) currentX;
      int imgY = (int) y;
      if (imgX >= 0 && imgX < width && imgY >= 0 && imgY < height) { // Ensure coordinates are within image bounds
        int textColor = img.get(imgX, imgY);
        fill(textColor); // Set text color to the color of the corresponding pixel
      } else {
        fill(0); // Default color if out of bounds
      }
      text(word, currentX, y);

      currentX += textWidth(word + " ");
      if (currentX > width) {
        break; // Stop if the text exceeds the canvas width
      }
    }

    y += lineHeight; // Move to the next line
    lineCount++;
  }
}

void setFrameRateForCurrentSize() {
  // Set frame rate based on current font size
  float size = fontSizes[currentFontSizeIndex];
  if (size <= 2) {
    frameRate(1000000); // Fast frame rate for smallest sizes
    frameDelay = 5; // Minimum frame delay
  } else if (size <= 3) {
    frameRate(1000000); // Fast frame rate for smallest sizes
    frameDelay = 4; // Minimum frame delay
  } else if (size <= 5) {
    frameRate(200); // Fast frame rate for smallest sizes
    frameDelay = 20; // Minimum frame delay
  } else if (size <= 10) {
    frameRate(7); // Medium frame rate for small sizes
    frameDelay = 35; // Slightly longer frame delay
  } else if (size <= 20) {
    frameRate(6); // Slower frame rate for medium sizes
    frameDelay = 35; // Longer frame delay
  }
    else if (size <= 30) {
    frameRate(4);
    frameDelay = 25;
    }
    else if (size <= 40) {
    frameRate(2);
    frameDelay = 15;
  } else {
    frameRate(2); // Slow frame rate for larger sizes
    frameDelay = 30; // Longest frame delay
  }
}
