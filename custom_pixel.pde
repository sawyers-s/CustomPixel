// Note: API code is not needed to run file, but included for documentation purposes

// API key used to fetch headlines
//String URL = "https://newsapi.org/v2/everything";
//String API_KEY = "d3c9d7d72f264f458784917e2f889029";
//String QUERY = "fast fashion"; // also queried: "textile waste", "ethical fashion", "unsustainable fashion", "textile", "child labor", "sweat shop", "fashion supply chain", "greenwashing", "microplastics", "Shein", "Primark", "H&M", "Forever 21"
//String LANGUAGE = "en";  // specify search for articles in English
//String SORT_BY = "popularity";

// create global variables
String[] lines; // create array to hold lines of text
String fileName = "textfile.txt"; // name of text file
PImage img; // image to get colors from
PFont[] fonts; // create array to hold different font sizes

int margin = 0; // margin around text
int x = margin;
int y = margin;
int maxWidth; // max width for text wrapping
int lineHeight;
float[] fontSizes = {50, 40, 30, 20, 10, 5, 3, 1.7}; // various font sizes for iteration
int currentFontSizeIndex = 0;
int frameDelay;
int frameCounter = 0;

void setup() {
  size(1050, 700);
  noStroke();

  // API code to fetch and print article titles to load into "textfile.txt"
  //ArrayList<JSONObject> articles = fetchArticles(QUERY, LANGUAGE, SORT_BY, API_KEY, URL);
  //fill(0);
  //textSize(16);
  //textAlign(LEFT, TOP);

  // load image
  img = loadImage("metgala.jpg");
  img.resize(width, height);

  // load fonts with different sizes
  fonts = new PFont[fontSizes.length];
  for (int i = 0; i < fontSizes.length; i++) {
    fonts[i] = createFont("OldStandardTT-Bold.ttf", fontSizes[i]);
  }

  // load text from file
  lines = loadStrings(fileName);

  // check if file loaded correctly
  if (lines == null || lines.length == 0) {
    println("Error: Failed to load text from file or file is empty");
    noLoop(); // stop draw loop if no text is loaded
    return;
  }

  // set initial font size and frame rate
  setFrameRateForCurrentSize();
}

void draw() {
  // clear canvas
  background(255);

  // set current text size and apply current font
  textFont(fonts[currentFontSizeIndex]);
  float textSizeValue = fontSizes[currentFontSizeIndex];
  textSize(textSizeValue);
  lineHeight = (int) textAscent() + (int) textDescent(); // adjust line height accordingly

  // draw text with current font size
  drawRepeatedText();

  // update font size index and frame counter to loop through fonts
  frameCounter++;
  if (frameCounter >= frameDelay) {
    currentFontSizeIndex++;
    if (currentFontSizeIndex >= fontSizes.length) {
      currentFontSizeIndex = 0;
    }
    setFrameRateForCurrentSize();
    frameCounter = 0;
  }
}

void drawRepeatedText() {
  int startY = margin; // store starting y position
  int lineCount = 0;
  x = margin; // reset x and y positions for each line
  y = startY;

  while (y < height) {
    StringBuilder currentText = new StringBuilder();
    x = margin;
    y = startY + lineCount * lineHeight; // start new line for each headline

    // concatenate headlines starting from lineCount
    for (int i = 0; i < lines.length; i++) {
      String word = lines[(lineCount + i) % lines.length];
      currentText.append(word).append(" ");
    }

    String[] words = split(currentText.toString(), ' ');
    float currentX = x;

    for (String word : words) {
      // calculate color of text based on its position
      int imgX = (int) currentX;
      int imgY = (int) y;
      // check if text is in bounds of canvas
      if (imgX >= 0 && imgX < width && imgY >= 0 && imgY < height) {
        int textColor = img.get(imgX, imgY);
        fill(textColor); // set text color to color of corresponding pixel
      } else {
        fill(0); // default color if out of bounds
      }
      text(word, currentX, y); // place text in correct color from image

      currentX += textWidth(word + " ");
      if (currentX > width) {
        break; // stop if text exceeds canvas width
      }
    }

    y += lineHeight; // move to next line
    lineCount++;
  }
}

void setFrameRateForCurrentSize() {
  // set frame rate based on current font size; frameRate and frameDelay values based on trial and error
  float size = fontSizes[currentFontSizeIndex];
  if (size <= 2) {
    frameRate(100000);
    frameDelay = 5;
  } else if (size <= 3) {
    frameRate(1);
    frameDelay = 35;
  } else if (size <= 5) {
    frameRate(5);
    frameDelay = 25;
  } else if (size <= 10) {
    frameRate(7);
    frameDelay = 35;
  } else if (size <= 20) {
    frameRate(6);
    frameDelay = 35;
  } else if (size <= 30) {
    frameRate(4);
    frameDelay = 25;
  } else if (size <= 40) {
    frameRate(2);
    frameDelay = 15;
  } else {
    frameRate(2);
    frameDelay = 30;
  }
}

// API code to gather article data and encode string search query into valid URL query
//ArrayList<JSONObject> fetchArticles(String query, String language, String sortBy, String apiKey, String url) {
//  // construct full URL with the language and sortBy parameters
//  String requestUrl = url + "?q=" + encodeURL(query) + "&language=" + language + "&sortBy=" + sortBy + "&apiKey=" + apiKey;
//  println("Request URL: " + requestUrl);

//  // load JSON response
//  JSONObject json = loadJSONObject(requestUrl);

//  // check if response is valid
//  if (json == null) {
//    println("Error: Failed to fetch data");
//    return new ArrayList<JSONObject>();
//  }

//  // check if response contains any articles
//  if (!json.hasKey("articles")) {
//    println("Error: No articles key in response");
//    println(json.toString());
//    return new ArrayList<JSONObject>();
//  }

//  // extract articles array
//  JSONArray articlesArray = json.getJSONArray("articles");

//  // create ArrayList to store articles
//  ArrayList<JSONObject> articles = new ArrayList<JSONObject>();

//  // loop through articles and add to ArrayList
//  for (int i = 0; i < articlesArray.size(); i++) {
//    JSONObject article = articlesArray.getJSONObject(i);
//    articles.add(article);
//  }

//  return articles;
//}

//// Utility function to URL-encode query parameters
//String encodeURL(String s) {
//  try {
//    return java.net.URLEncoder.encode(s, "UTF-8");
//  } catch (java.io.UnsupportedEncodingException e) {
//    e.printStackTrace();
//    return s;
//  }
//}
