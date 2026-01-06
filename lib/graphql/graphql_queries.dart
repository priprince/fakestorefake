class GraphqlQueries {
  static String getAllProducts() {
    return '''
  query
  { 
    products
    {
      id
      title
      price
      description
      images
      category 
      {
        id
        name
        image
      }
    }
  }
  ''';
  }
}
