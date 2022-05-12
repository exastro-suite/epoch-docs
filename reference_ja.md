---
layout: common
lang: ja
type: article
title: Reference
pageName: reference
---
<div id="swagger-ui"></div>

<link href="./asset/swagger/swagger-ui.css" rel="stylesheet">
<script src="./asset/swagger/swagger-ui-bundle.js" charset="UTF-8"></script>
<script src="./asset/swagger/swagger-ui-standalone-preset.js" charset="UTF-8"></script>
<script>
$(function(){
  // ID change
  $('#articleBody').attr('id', 'swaggerBody');

  // Begin Swagger UI call region
  const ui = SwaggerUIBundle({
    url: "https://raw.githubusercontent.com/exastro-suite/epoch/v1.0.1/docs/epoch-service-api.yaml",
    dom_id: '#swagger-ui',
    deepLinking: true,
    presets: [
      SwaggerUIBundle.presets.apis,
      SwaggerUIStandalonePreset
    ],
    plugins: [
      SwaggerUIBundle.plugins.DownloadUrl
    ],
    layout: "StandaloneLayout",
    supportedSubmitMethods: []
  });
  // End Swagger UI call region

  window.ui = ui;
});
</script>