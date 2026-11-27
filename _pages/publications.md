---
layout: page
title: publications
permalink: /publications/
nav: true
nav_order: 2
---

<style>
.publications .bibliography { list-style: none; padding-left: 0; }
.publications .bibliography > li { list-style: none; margin-bottom: 1.25rem; }
.publications .bibliography > li::marker { content: ""; }
.publications .bibliography .title { font-weight: 600; }
.publications .bibliography .author em { font-weight: 700; font-style: normal; }
.publications h2.bibliography { font-size: 1.25rem; border-bottom: 1px solid var(--global-divider-color, #ddd); padding-bottom: .35rem; margin-top: 1.5rem; }
.publications .bibliography .abbr .badge { background-color: var(--global-theme-color, #174675); color: white; border-radius: 3px; padding: .3em .55em; }
.publications .bibliography .links a { border: 1px solid currentColor; border-radius: 3px; padding: .2em .65em; margin-right: .3em; }
</style>

<div class="publications">
<h2>International Journal Articles</h2>

{% bibliography --query @*[category=international] %}

<h2>Chinese Journal Articles (in Chinese)</h2>

{% bibliography --query @*[category=chinese] %}

<h2>International Conference Proceedings</h2>

{% bibliography --query @*[category=conference] %}
</div>
