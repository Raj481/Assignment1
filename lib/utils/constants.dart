

enum ToastEnum {
  error,
  warning,
  success
}

String prepareHtml(String data){

  return '''
  <html>
  <head>
  <style>
    body {
      padding: 15px 10px 15px 10px
    }
    h1 {
    color: white
    }
    
    ul, li {
    color: white;
    }
    
    p {
    color: white;
    text-justify: none;
    }
  </style>
  </head>
  
  <body>
  $data
  </body>
  </html>
  ''';
}