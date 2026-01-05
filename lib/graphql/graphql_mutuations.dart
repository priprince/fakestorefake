class GraphqlMutuations {
  static String login() {
    return '''mutation 
    Login(\$email: String!,\$password: String!)
    {
      login(email: \$email, password: \$password) 
      {
		    access_token
		    refresh_token
	    }
    }''';
  }
}
