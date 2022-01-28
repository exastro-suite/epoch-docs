---
layout: common
lang: en
type: article
title: FAQ
pageName: faq
---
<section>
    <div class="sectionInner">
        <h2>Frequently asked questions about <em>Exastro EPOCH</em>（FAQ）</h2>
        <div id="faqContent">
            <nav id="faqNavi">
                <div class="faqNaviTitle">Search</div>
                <div class="search-box"><input type="text" id="search-input"><button id="search-button" class="touch"><i class="fas fa-search"></i> Search</button></div>
                <div class="faqNaviTitle">Category</div>
                <ul>
                </ul>
            </nav>
            <div id="faqList">
                <div class="loading"></div>
                <div id="search-result" class="faqItem">
                <h3>Search result</h3>
                <ul></ul>
                </div>
            </div>
        </div>
    </div>
</section>
<script>
$(function(){
  var url = '{{ layout.suiteURL }}/asset/json/faq.json';
  faqLoading( url );
});
</script>