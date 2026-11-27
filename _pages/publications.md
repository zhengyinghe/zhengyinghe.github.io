---
layout: page
title: publications
permalink: /publications/
nav: true
nav_order: 2
---

<h2>International Journal Articles</h2>

{% bibliography --query @*[category=international] %}

<h2>Chinese Journal Articles (in Chinese)</h2>

{% bibliography --query @*[category=chinese] %}

<h2>International Conference Proceedings</h2>

{% bibliography --query @*[category=conference] %}
