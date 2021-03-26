---
title: Collections
layout: page
permalink: /collections/
---

{% assign wax_collections = site.collections | where: "layout", "wax_item" %}

<div>
{% for collection in wax_collections %}
    {% assign label = collection.label %}
    {% assign collection_data = site.data[label] %}
    {% include collection_gallery.html collection=label data=collection_data %}
{% endfor %}
</div>
