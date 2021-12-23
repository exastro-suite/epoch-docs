---
layout: common
lang: en
type: website
title: Index
pageName: index
---
<section id="features">
  <div class="sectionInner">
    <h2>5 Features of <em>Exastro EPOCH</em></h2>
    <div id="featuresList">
      <svg id="svgArea" width="100%" height="100%" >
      </svg>
      <ol>
        <li><a href="overview.html#feature1"><i class="fas fa-cog"></i>　<span class="featureText">Immediately provides CI/CD pipelines for cloudnative apps</span></a></li>
        <li><a href="overview.html#feature2"><i class="fas fa-cog"></i>　<span class="featureText">Extracts environment for GitOps</span></a></li>
        <li><a href="overview.html#feature3"><i class="fas fa-cog"></i>　<span class="featureText">Supports Canary release/ Blue-Green deployment</span></a></li>
        <li><a href="overview.html#feature4"><i class="fas fa-cog"></i>　<span class="featureText">Centrally manages CI/CD Statuses</span></a></li>
        <li><a href="overview.html#feature5"><i class="fas fa-cog"></i>　<span class="featureText">Manages declarative IaC's environment dependent parameters on the system</span></a></li>
      </ol>
    </div>
    <p class="linkArea"><a href="./learn.html" class="move"><span>Start using Exastro EPOCH <i class="fas fa-angle-right"></i></span></a></p>
  </div>
</section>
<style>
</style>
<script>
$(function(){
  $('.featureText').each(function(){
  const $text = $( this ),
        sWidth = $text.get(0).scrollWidth,
        cWidth = $text.get(0).offsetWidth;
  if ( cWidth < sWidth ) {
    $text.css('transform', 'scale(' + ( cWidth / sWidth ) + ')')
  } else {
    $text.removeAttr('style');
  }
  });
});
</script>