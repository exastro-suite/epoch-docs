---
layout: common
lang: ja
type: article
title: Reference
pageName: reference
---
<section>
    <div class="sectionInner">
        <h2><em>Exastro EPOCH</em> Reference</h2>
        <div id="swagger-ui"></div>
        <script src="./asset/swagger/swagger-ui-bundle.js" charset="UTF-8"></script>
        <script src="./asset/swagger/swagger-ui-standalone-preset.js" charset="UTF-8"></script>
        <script>
        window.onload = function() {
          // Begin Swagger UI call region
          const ui = SwaggerUIBundle({
            url: "https://petstore.swagger.io/v2/swagger.json",
            dom_id: '#swagger-ui',
            deepLinking: true,
            presets: [
              SwaggerUIBundle.presets.apis,
              SwaggerUIStandalonePreset
            ],
            plugins: [
              SwaggerUIBundle.plugins.DownloadUrl
            ],
            layout: "StandaloneLayout"
          });
          // End Swagger UI call region

          window.ui = ui;
        };
      </script>
    </div>
</section>