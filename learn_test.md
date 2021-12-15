---
layout: common
lang: ja
type: article
title: Learn
name: learn
---

<style>

#articleBody {
display: flex;
flex-wrap: wrap;
}
#articleTitle {
width: 100%;
}
#articleNavi {
width: 320px;
padding: 16px;
background-color: #F4F9F8;
border-right: 1px solid #BCDDD7;
}
#articleBody {
width: calc( 100% - 320px );
}
.article-navi-search {
margin-bottom: 16px; padding: 16px;
}
.article-navi-list {
position: sticky;
top: 40px;
}
.article-navi-item {
margin-bottom: 16px;
}
.article-navi-contents-item:last-child {
border-bottom: none;
}
.article-navi-contents-link {
display: block;
padding: 12px 16px;
border-radius: 4px;
text-decoration: none;
font-size: 16px;
color: #333;
}
.article-navi-contents-link.hover {
background-color: #E9F4F2;
}
.article-navi-title > .article-navi-contents-link {
font-size: 20px;
color: #1F8C78;
}
.article-navi-contents-item > .article-navi-contents-link {
padding-left: 2em;
}
.article-navi-list .fas {
margin-right: 16px;
}
.article-navi-contents-item .fas {
color: #8FC6BC;
}

</style>

{% include navi_learn.html %}

{% if page.lang == "ja" %}
    {% assign list = site.data.learn_ja %}
{% else %}
    {% assign list = site.data.learn_en %}
{% endif %}

<div id="articleContents">{% for learn in list.learn %}
    <section class="">
        <h2><i class="{{ learn.icon }}"></i> {{ learn.title }}</h2>
        <ul class="content-list">{% for document in learn.documents %}
            <li class="content-item">
                <div class="content-card">
                    <div class="content-header">
                        <h3 class="content-title">
                            <span class="content-type">Exastro EPOCH</span><br>
                            {{ document.title }}
                        </h3>
                    </div>
                    <div class="content-body">
                        <p class="content-paragraph">{{ document.description }}</p>
                    </div>
                    <div class="content-footer">
                        <ul class="content-link-list">{% for link in document.links %}
                            <li class="content-link-item">
                                <a class="content-link" href="{{ link.url }}">
                                    {{ link.title }} <i class="fas fa-angle-right"></i>
                                </a>
                            </li>
                        {% endfor %}</ul>
                    </div>
                </div>
            </li>
        {% endfor %}{% assign remainder = learn.documents.size | modulo: 2 %}{% if remainder != 0 %}
            <li class="content-item content-item-padding"></li>
        {% endif %}
        </ul>
    </section>
{% endfor %}</div>