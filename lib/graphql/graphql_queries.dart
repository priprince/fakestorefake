class GraphqlQueries {
  static String getAllProducts() {
    return '''
  products{
		id
    title
    price
		description
		images
		category {
			id
			name
			image
		}
  }
  ''';
  }
}
