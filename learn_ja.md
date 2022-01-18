---
layout: common
lang: ja
type: article
title: Learn
pageName: learn
---
{% include navi_learn.html %}{% if page.lang == "ja" %}{% assign list = site.data.learn_ja %}{% else %}{% assign list = site.data.learn_en %}{% endif %}
<div id="articleContents">{% for learn in list.learn %}
    {% if learn.id != "home" %}<section id="{{ learn.id }}">
        <h2><i class="{{ learn.icon }}"></i> {{ learn.title }}</h2>
        <ul class="content-list">{% for document in learn.documents %}
            <li class="content-item" id="{{ document.id }}">
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
                                <a class="content-link" href="{{ layout.suiteURL }}{{ link.url }}">
                                    {{ link.title }} <i class="fas fa-angle-right"></i>
                                </a>
                            </li>
                        {% endfor %}</ul>
                    </div>
                </div>
            </li>{% endfor %}{% assign remainder = learn.documents.size | modulo: 2 %}{% if remainder != 0 %}
            <li class="content-item content-item-padding"></li>{% endif %}
        </ul>
    </section>{% endif %}
{% endfor %}</div>