---
layout: common
lang: ja
type: website
title: Index
pageName: index
---
<section id="features">
  <div class="sectionInner">
    <h2><em>Exastro EPOCH</em> の５つの特徴です。</h2>
    <div id="featuresList">
      <svg id="svgArea" width="100%" height="100%" >
      </svg>
      <ol>
        <li><a href="overview_ja.html#feature1"><i class="fas fa-cog"></i>　<span class="featureText">クラウドネイティブなアプリケーションのCI/CDパイプラインを即時に提供</span></a></li>
        <li><a href="overview_ja.html#feature2"><i class="fas fa-cog"></i>　<span class="featureText">GitOpsに対応した環境の展開</span></a></li>
        <li><a href="overview_ja.html#feature3"><i class="fas fa-cog"></i>　<span class="featureText">カナリアリリース/ブルーグリーンデプロイに対応</span></a></li>
        <li><a href="overview_ja.html#feature4"><i class="fas fa-cog"></i>　<span class="featureText">CI/CDのステータスを一元管理</span></a></li>
        <li><a href="overview_ja.html#feature5"><i class="fas fa-cog"></i>　<span class="featureText">宣言的IaCの環境依存パラメータをシステム上で管理</span></a></li>
      </ol>
    </div>
    <p class="linkArea"><a href="./learn_ja.html" class="move"><span>Exastro EPOCH を始める <i class="fas fa-angle-right"></i></span></a></p>
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