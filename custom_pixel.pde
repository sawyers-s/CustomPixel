String[] lines; // Array to hold lines of text
String fileName = "textfile.txt"; // Name of the text file
PImage img; // Image to get colors from
int margin = 0; // Margin around the text
int x = margin; // X position for drawing text
int y = margin; // Y position for drawing text
int maxWidth; // Maximum width for text wrapping
int lineHeight; // Height of each line of text

void setup() {
  size(1050, 700); // Set canvas size
  background(255); // Set background color

  // Load the image
  img = loadImage("metgala.jpg");
  img.resize(width, height); // Resize image to match canvas size

  // Set text properties
  textSize(6); // Set small text size
  textAlign(LEFT, TOP); // Set text alignment
  
  // Calculate maxWidth based on canvas width and margins
  maxWidth = width - 2 * margin;
  lineHeight = (int) textAscent() + (int) textDescent(); // Height of each line
  
  // Load text from the file
  lines = loadStrings(fileName);
  
  // Check if the file loaded correctly
  if (lines == null || lines.length == 0) {
    println("Error: Failed to load text from file or file is empty");
    noLoop(); // Stop draw loop if no text is loaded
    return;
  }
  
  // Draw text with wrapping and repetition
  drawRepeatedText();
}

void draw() {
  // Do nothing, as text is drawn once in setup
}

void drawRepeatedText() {
  int startY = y; // Store the starting y position
  int lineCount = 0;

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
      int textcolor = img.get(imgX, imgY);

      fill(textcolor); // Set text color to the color of the corresponding pixel
      text(word, currentX, y);

      currentX += textWidth(word + " ");
      if (currentX > width) {
        break;
      }
    }
    lineCount++;
  }
}
