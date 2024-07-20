String URL = "https://newsapi.org/v2/everything";
String API_KEY = "d3c9d7d72f264f458784917e2f889029";
// Use 'OR' to combine multiple queries
String QUERY = "fast fashion"; // also used: "textile waste", "ethical fashion", "unsustainable fashion", "textile", "child labor", "sweat shop", "fashion supply chain", "greenwashing", "microplastics", "Shein", "Primark", "H&M", "Forever 21"
String LANGUAGE = "en";  // Specify English
String SORT_BY = "popularity";  // Sort by popularity

void setup() {
  // Fetch and print article titles
  ArrayList<JSONObject> articles = fetchArticles(QUERY, LANGUAGE, SORT_BY, API_KEY, URL);
  for (JSONObject article : articles) {
    String title = article.getString("title");
    println(title);
  }
}

ArrayList<JSONObject> fetchArticles(String query, String language, String sortBy, String apiKey, String url) {
  // Construct the full URL with the language and sortBy parameters
  String requestUrl = url + "?q=" + encodeURL(query) + "&language=" + language + "&sortBy=" + sortBy + "&apiKey=" + apiKey;
  println("Request URL: " + requestUrl);
  
  // Load the JSON response
  JSONObject json = loadJSONObject(requestUrl);
  
  // Check if the response is valid
  if (json == null) {
    println("Error: Failed to fetch data");
    return new ArrayList<JSONObject>();
  }
  
  // Check if the response contains any articles
  if (!json.hasKey("articles")) {
    println("Error: No articles key in response");
    println(json.toString());
    return new ArrayList<JSONObject>();
  }
  
  // Extract the articles array
  JSONArray articlesArray = json.getJSONArray("articles");
  
  // Create an ArrayList to store the articles
  ArrayList<JSONObject> articles = new ArrayList<JSONObject>();
  
  // Loop through the articles and add them to the ArrayList
  for (int i = 0; i < articlesArray.size(); i++) {
    JSONObject article = articlesArray.getJSONObject(i);
    articles.add(article);
  }
  
  return articles;
}

// Utility function to URL-encode query parameters
String encodeURL(String s) {
  try {
    return java.net.URLEncoder.encode(s, "UTF-8");
  } catch (java.io.UnsupportedEncodingException e) {
    e.printStackTrace();
    return s;
  }
}
